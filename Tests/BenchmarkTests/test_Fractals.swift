//******************************************************************************
// Copyright 2019 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    https://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
import XCTest
import Foundation
import SwiftRT

#if canImport(SwiftRTCuda)
import SwiftRTCuda
#endif

final class test_Fractals: XCTestCase {
    //==========================================================================
    // support terminal test run
    static var allTests = [
        ("test_gpuJulia", test_gpuJulia),
        ("test_pmapJulia", test_pmapJulia),
        ("test_pmapKernelJulia", test_pmapKernelJulia),
        ("test_Julia", test_Julia),
    ]

    // append and use a discrete async cpu device for these tests
    override func setUpWithError() throws {
       log.level = .diagnostic
    }

    override func tearDownWithError() throws {
    //    log.level = .error
    }

    //--------------------------------------------------------------------------
    func test_gpuJulia() {
        #if canImport(SwiftRTCuda)
        // parameters
        let iterations = 2048
        let size = (r: 1000, c: 1000)
        let tolerance: Float = 4.0
        let C = Complex<Float>(-0.8, 0.156)
        let first = Complex<Float>(-1.7, 1.7)
        let last = Complex<Float>(1.7, -1.7)
        typealias CF = Complex<Float>
        let rFirst = CF(first.real, 0), rLast = CF(last.real, 0)
        let iFirst = CF(0, first.imaginary), iLast = CF(0, last.imaginary)

        // repeat rows of real range, columns of imaginary range, and combine
        let Z = repeating(array(from: rFirst, to: rLast, (1, size.c)), size) +
                repeating(array(from: iFirst, to: iLast, (size.r, 1)), size)
        var d = full(size, iterations)
        let queue = currentQueue

        // fused kernel RTX 2080 Ti: 0.003s
        measure {
            _ = d.withMutableTensor(using: queue) { d, dDesc in
                Z.withTensor(using: queue) {z, zDesc in
                    withUnsafePointer(to: tolerance) { t in
                        withUnsafePointer(to: C) { c in
                            srtJulia(z, zDesc, d, dDesc, t, c, iterations, queue.stream)
                        }
                    }
                }
            }
            // read on cpu to ensure gpu kernel is complete
            _ = d.read()
        }
        #endif
    }

    //--------------------------------------------------------------------------
    func test_Julia() {
        #if !DEBUG
        // parameters
        let iterations = 2048
        let size = (r: 1000, c: 1000)
        let tolerance: Float = 4.0
        let C = Complex<Float>(-0.8, 0.156)
        let first = Complex<Float>(-1.7, 1.7)
        let last = Complex<Float>(1.7, -1.7)
        typealias CF = Complex<Float>
        let rFirst = CF(first.real, 0), rLast = CF(last.real, 0)
        let iFirst = CF(0, first.imaginary), iLast = CF(0, last.imaginary)

        // repeat rows of real range, columns of imaginary range, and combine
        var Z = repeating(array(from: rFirst, to: rLast, (1, size.c)), size) +
                repeating(array(from: iFirst, to: iLast, (size.r, 1)), size)
        var divergence = full(size, iterations)

        // cpu 12.816s, gpu 1.48s
        measure {
            for i in 0..<iterations {
                Z = multiply(Z, Z, add: C)
                divergence[abs(Z) .> tolerance] = min(divergence, i)
            }
        }
        #endif
    }

    //--------------------------------------------------------------------------
    func test_pmapJulia() {
         #if !DEBUG
        // parameters
        let iterations = 2048
        let size = (r: 1000, c: 1000)
        let tolerance: Float = 4.0
        let C = Complex<Float>(-0.8, 0.156)
        let first = Complex<Float>(-1.7, 1.7)
        let last = Complex<Float>(1.7, -1.7)
        typealias CF = Complex<Float>
        let rFirst = CF(first.real, 0), rLast = CF(last.real, 0)
        let iFirst = CF(0, first.imaginary), iLast = CF(0, last.imaginary)

        usingSyncQueue {
            // repeat rows of real range, columns of imaginary range, and combine
            let Z = repeating(array(from: rFirst, to: rLast, (1, size.c)), size) +
                    repeating(array(from: iFirst, to: iLast, (size.r, 1)), size)
            var divergence = full(size, iterations)

            // mac cpu16 0.850, ubuntu cpu6 3.790s
            measure {
                pmap(Z, &divergence) { Z, divergence in
                    for i in 0..<iterations {
                        Z = multiply(Z, Z, add: C)
                        divergence[abs(Z) .> tolerance] = min(divergence, i)
                    }
                }
            }
        }
         #endif
    }

    func test_pmapKernelJulia() {
        #if !DEBUG
        // parameters
        let iterations = 2048
        let size = (r: 1000, c: 1000)
        let tolerance: Float = 4.0
        let C = Complex<Float>(-0.8, 0.156)
        let first = Complex<Float>(-1.7, 1.7)
        let last = Complex<Float>(1.7, -1.7)
        typealias CF = Complex<Float>
        let rFirst = CF(first.real, 0), rLast = CF(last.real, 0)
        let iFirst = CF(0, first.imaginary), iLast = CF(0, last.imaginary)
        
        usingSyncQueue {
            // repeat rows of real range, columns of imaginary range, and combine
            let Z = repeating(array(from: rFirst, to: rLast, (1, size.c)), size) +
                    repeating(array(from: iFirst, to: iLast, (size.r, 1)), size)
            var divergence = full(size, iterations)
            let t2 = tolerance //* tolerance

            // mac cpu32: 0.116s, ubuntu cpu12: 1.482s
            measure {
                pmap(Z, &divergence, limitedBy: .compute) {
                    juliaKernel(Z: $0, divergence: &$1, C, t2, iterations)
                }
            }
        }
        #endif
    }
}

//==============================================================================
// user defined element wise function
@inlinable public func juliaKernel<E>(
    Z: TensorR2<Complex<E>>,
    divergence: inout TensorR2<E>,
    _ C: Complex<E>,
    _ tolerance: E,
    _ iterations: Int
) {
    let message =
        "julia(Z: \(Z.name), divergence: \(divergence.name), constant: \(C), " +
        "tolerance: \(tolerance), iterations: \(iterations))"

    kernel(Z, &divergence, message) {
        var Z = $0, d = $1
        for i in 0..<iterations {
            Z = Z * Z + C
            if abs(Z) > tolerance {
                d = min(d, E.Value(exactly: i)!)
                break
            }
        }
        return d
    }
}
