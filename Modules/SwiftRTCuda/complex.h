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
#ifndef complex_h
#define complex_h

// a cuda partial version of limits on github
// https://gist.github.com/eyalroz/858d7beae1ad09b83b691107306d0176

#include <cmath>
#include <optional>
#include <limits>

/* Set up function decorations */
#ifndef __CUDA_HOSTDEVICE__
#if defined(__CUDACC__)
#define __CUDA_HOSTDEVICE__ __host__ __device__
#else /* !defined(__CUDACC__) */
#define __CUDA_HOSTDEVICE__
#endif /* defined(__CUDACC_) */
#endif

//******************************************************************************
// This is the Complex module from Swift Numerics ported to C++
//
//******************************************************************************

template<typename RealType>
struct Complex {
    //  A note on the `x` and `y` properties
    //
    //  `x` and `y` are the names we use for the raw storage of the real and
    //  imaginary components of our complex number. We also provide public
    //  `.real` and `.imaginary` properties, which wrap this storage and
    //  fixup the semantics for non-finite values.

    /// The real component of the value.
    RealType x;

    /// The imaginary part of the value.
    RealType y;

    //--------------------------------------------------------------------------
    /// A complex number constructed by specifying the real and imaginary parts.
    __CUDA_HOSTDEVICE__ inline Complex(RealType real, RealType imaginary) {
        x = real;
        y = imaginary;
    }

    __CUDA_HOSTDEVICE__ inline Complex(RealType real) {
        x = real;
        y = 0;
    }

    //==========================================================================
    // basic properties
    //==========================================================================
    __CUDA_HOSTDEVICE__ inline static bool isNormal(RealType x) {
        return x != 0 && 
            x >= std::numeric_limits<RealType>::min() &&
            x <= std::numeric_limits<RealType>::max();
    }

    /// The real part of this complex value.
    ///
    /// If `z` is not finite, `z.real` is `.nan`.
    __CUDA_HOSTDEVICE__ inline RealType real() { isFinite() ? x : std::nan; }
    __CUDA_HOSTDEVICE__ inline RealType real(RealType newValue) { x = newValue; }

    /// The imaginary part of this complex value.
    ///
    /// If `z` is not finite, `z.imaginary` is `.nan`.
    __CUDA_HOSTDEVICE__ inline RealType imaginary() { isFinite() ? y : std::nan; }
    __CUDA_HOSTDEVICE__ inline RealType imaginary(RealType newValue) { y = newValue; }

    /// The additive identity, with real and imaginary parts both zero.
    ///
    /// See also:
    /// -
    /// - .one
    /// - .i
    /// - .infinity
    __CUDA_HOSTDEVICE__ inline static Complex zero() { return Complex(0, 0); }

    /// The multiplicative identity, with real part one and imaginary part zero.
    ///
    /// See also:
    /// -
    /// - .zero
    /// - .i
    /// - .infinity
    __CUDA_HOSTDEVICE__ inline static Complex one() { return Complex(1, 0); }

    /// The imaginary unit.
    ///
    /// See also:
    /// -
    /// - .zero
    /// - .one
    /// - .infinity
    __CUDA_HOSTDEVICE__ inline static Complex i() { return Complex(0, 1); }

    /// The point at infinity.
    ///
    /// See also:
    /// -
    /// - .zero
    /// - .one
    /// - .i
    __CUDA_HOSTDEVICE__ inline static Complex infinity() { return Complex(INFINITY, 0); }

    /// The complex conjugate of this value.
    __CUDA_HOSTDEVICE__ inline Complex conjugate() { return Complex(x, -y); }

    /// True if this value is finite.
    ///
    /// A complex value is finite if neither component is an infinity or nan.
    ///
    /// See also:
    /// -
    /// - `.isNormal`
    /// - `.isSubnormal`
    /// - `.isZero`
    __CUDA_HOSTDEVICE__ inline bool isFinite() {
        return isfinite(x) && isfinite(y);
    }

    /// True if this value is normal.
    ///
    /// A complex number is normal if it is finite and *either* the real or imaginary component is normal.
    /// A floating-point number representing one of the components is normal if its exponent allows a full-
    /// precision representation.
    ///
    /// See also:
    /// -
    /// - `.isFinite`
    /// - `.isSubnormal`
    /// - `.isZero`
    __CUDA_HOSTDEVICE__ inline bool isNormal() {
        return isFinite() && (isNormal(x) || isNormal(y));
    }

    /// True if this value is subnormal.
    ///
    /// A complex number is subnormal if it is finite, not normal, and not zero. When the result of a
    /// computation is subnormal, underflow has occurred and the result generally does not have full
    /// precision.
    /// See also:
    /// -
    /// - `.isFinite`
    /// - `.isNormal`
    /// - `.isZero`
    __CUDA_HOSTDEVICE__ inline bool isSubnormal() { return isFinite() && !isNormal() && !isZero(); }

    /// True if this value is zero.
    ///
    /// A complex number is zero if *both* the real and imaginary components are zero.
    ///
    /// See also:
    /// -
    /// - `.isFinite`
    /// - `.isNormal`
    /// - `.isSubnormal`
    __CUDA_HOSTDEVICE__ inline bool isZero() { return x == 0 && y == 0; }

    /// The ∞-norm of the value (`max(abs(real), abs(imaginary))`).
    ///
    /// If you need the Euclidean norm (a.k.a. 2-norm) use the `length` or `lengthSquared`
    /// properties instead.
    ///
    /// Edge cases:
    /// -
    /// - If `z` is not finite, `z.magnitude` is `.infinity`.
    /// - If `z` is zero, `z.magnitude` is `0`.
    /// - Otherwise, `z.magnitude` is finite and non-zero.
    ///
    /// See also:
    /// -
    /// - `.length`
    /// - `.lengthSquared`
    __CUDA_HOSTDEVICE__ inline RealType magnitude() {
        if (isFinite()) {
            return max(abs(x), abs(y));
        } else {
            return INFINITY;
        }
    }

    /// A "canonical" representation of the value.
    ///
    /// For normal complex numbers with a RealType conforming to
    /// BinaryFloatingPoint (the common case), the result is simply this value
    /// unmodified. For zeros, the result has the representation (+0, +0). For
    /// infinite values, the result has the representation (+inf, +0).
    ///
    /// If the RealType admits non-canonical representations, the x and y
    /// components are canonicalized in the result.
    ///
    /// This is mainly useful for interoperation with other languages, where
    /// you may want to reduce each equivalence class to a single representative
    /// before passing across language boundaries, but it may also be useful
    /// for some serialization tasks. It's also a useful implementation detail for
    /// some primitive operations.
    __CUDA_HOSTDEVICE__ inline Complex canonicalized() {
        if (isZero()) {
            return zero();
        } else if (isFinite()) {
            return multipliedBy(1);
        } else {
            return infinity();
        }
    }

    //==========================================================================
    // Additional Initializers
    //==========================================================================

    //==========================================================================
    // Operations for working with polar form
    //==========================================================================

    /// The Euclidean norm (a.k.a. 2-norm, `sqrt(real*real + imaginary*imaginary)`).
    ///
    /// This property takes care to avoid spurious over- or underflow in
    /// this computation. For example:
    ///
    ///     let x: Float = 3.0e+20
    ///     let x: Float = 4.0e+20
    ///     let naive = sqrt(x*x + y*y) // +Inf
    ///     let careful = Complex(x, y).length // 5.0e+20
    ///
    /// Note that it *is* still possible for this property to overflow,
    /// because the length can be as much as sqrt(2) times larger than
    /// either component, and thus may not be representable in the real type.
    ///
    /// For most use cases, you can use the cheaper `.magnitude`
    /// property (which computes the ∞-norm) instead, which always produces
    /// a representable result.
    ///
    /// Edge cases:
    /// -
    /// If a complex value is not finite, its `.length` is `infinity`.
    ///
    /// See also:
    /// -
    /// - `.magnitude`
    /// - `.lengthSquared`
    /// - `.phase`
    /// - `.polar`
    /// - `init(r:θ:)`
    __CUDA_HOSTDEVICE__ inline RealType length() {
        auto naive = lengthSquared();
        if (naive.isNormal()) {
            return sqrt(naive);
        } else {
            return carefulLength();
        }
    }
    
    //  Internal implementation detail of `length`, moving slow path off
    //  of the inline function. Note that even `carefulLength` can overflow
    //  for finite inputs, but only when the result is outside the range
    //  of representable values.
    __CUDA_HOSTDEVICE__ inline RealType carefulLength() {
        if (isFinite()) {
            return hypot(x, y);
        } else {
            return infinity();
        }
    }
    
    /// The squared length `(real*real + imaginary*imaginary)`.
    ///
    /// This property is more efficient to compute than `length`, but is
    /// highly prone to overflow or underflow; for finite values that are
    /// not well-scaled, `lengthSquared` is often either zero or
    /// infinity, even when `length` is a finite number. Use this property
    /// only when you are certain that this value is well-scaled.
    ///
    /// For many cases, `.magnitude` can be used instead, which is similarly
    /// cheap to compute and always returns a representable value.
    ///
    /// See also:
    /// -
    /// - `.length`
    /// - `.magnitude`
    __CUDA_HOSTDEVICE__ inline RealType lengthSquared() {
        return x*x + y*y;
    }
    
    /// The phase (angle, or "argument").
    ///
    /// Returns the angle (measured above the real axis) in radians. If
    /// the complex value is zero or infinity, the phase is not defined,
    /// and `nan` is returned.
    ///
    /// Edge cases:
    /// -
    /// If the complex value is zero or non-finite, phase is `nan`.
    ///
    /// See also:
    /// -
    /// - `.length`
    /// - `.polar`
    /// - `init(r:θ:)`
    __CUDA_HOSTDEVICE__ inline RealType phase() {
        if (isFinite() && !isZero()) {
            return atan2(y, x);
        }  else {
            return std::nan;
        }
    }
    
    /// The length and phase (or polar coordinates) of this value.
    ///
    /// Edge cases:
    /// -
    /// If the complex value is zero or non-finite, phase is `.nan`.
    /// If the complex value is non-finite, length is `.infinity`.
    ///
    /// See also:
    /// -
    /// - `.length`
    /// - `.phase`
    /// - `init(r:θ:)`
    struct Polar {
        RealType length;
        RealType phase;
        __CUDA_HOSTDEVICE__ inline Polar(RealType l, RealType p) {
            length = l;
            phase = p;
        }
    };

    __CUDA_HOSTDEVICE__ inline Polar polar() {
        return Polar(length(), phase());
    }
    
    /// Creates a complex value specified with polar coordinates.
    ///
    /// Edge cases:
    /// -
    /// - Negative lengths are interpreted as reflecting the point through the origin, i.e.:
    ///   ```
    ///   Complex(length: -r, phase: θ) == -Complex(length: r, phase: θ)
    ///   ```
    /// - For any `θ`, even `.infinity` or `.nan`:
    ///   ```
    ///   Complex(length: .zero, phase: θ) == .zero
    ///   ```
    /// - For any `θ`, even `.infinity` or `.nan`, if `r` is infinite then:
    ///   ```
    ///   Complex(length: r, phase: θ) == .infinity
    ///   ```
    /// - Otherwise, `θ` must be finite, or a precondition failure occurs.
    ///
    /// See also:
    /// -
    /// - `.length`
    /// - `.phase`
    /// - `.polar`
    __CUDA_HOSTDEVICE__ inline Complex(Polar polar) {
        if (polar.phase.isFinite()) {
            *this = Complex(cos(polar.phase), sin(polar.phase)).multipliedBy(polar.length);
        } else {
            // "Either phase must be finite, or length must be zero or infinite."
            assert(polar.length == 0 || isfinite(polar.length));
            *this = Complex(polar.length);
        }
    }

    //==========================================================================
    // Equatable
    //==========================================================================

    // The Complex type identifies all non-finite points (waving hands slightly,
    // we identify all NaNs and infinites as the point at infinity on the Riemann
    // sphere).
    __CUDA_HOSTDEVICE__ inline bool operator==(Complex b) {
        // Identify all numbers with either component non-finite as a single
        // "point at infinity".
        if (!(isFinite() || b.isFinite())) return true;
        // For finite numbers, equality is defined componentwise. Cases where
        // only one of a or b is infinite fall through to here as well, but this
        // expression correctly returns false for them so we don't need to handle
        // them explicitly.
        return x == b.x && y == b.y;
    }

    //==========================================================================
    // AdditiveArithmetic
    //==========================================================================

    __CUDA_HOSTDEVICE__ inline Complex operator+(Complex w) const {
        return Complex(x + w.x, y + w.y);
    }
    
    __CUDA_HOSTDEVICE__ inline Complex operator-(Complex w) const {
        return Complex(x - w.x, y - w.y);
    }
    
    __CUDA_HOSTDEVICE__ inline Complex operator-() const {
        return Complex(-x, -y);
    }

    __CUDA_HOSTDEVICE__ inline void operator+=(Complex w) {
        *this = *this + w;
    }
    
    __CUDA_HOSTDEVICE__ inline void operator-=(Complex w) {
        *this = *this - w;
    }

    //==========================================================================
    // AlgebraicField
    //==========================================================================
    //
    // Policy: deliberately not using the * and / operators for these at the
    // moment, because then there's an ambiguity in expressions like 2*z; is
    // that Complex(2) * z or is it RealType(2) * z? This is especially
    // problematic in type inference: suppose we have:
    //
    //   let a: RealType = 1
    //   let b = 2*a
    //
    // what is the type of b? If we don't have a type context, it's ambiguous.
    // If we have a Complex type context, then b will be inferred to have type
    // Complex! Obviously, that doesn't help anyone.
    //
    // TODO: figure out if there's some way to avoid these surprising results
    // and turn these into operators if/when we have it.
    // (https://github.com/apple/swift-numerics/issues/12)
    __CUDA_HOSTDEVICE__ inline Complex multipliedBy(RealType a) const {
        return Complex(x*a, y*a);
    }

    __CUDA_HOSTDEVICE__ inline Complex dividedBy(RealType a) const {
        return Complex(x/a, y/a);
    }

    __CUDA_HOSTDEVICE__ inline Complex operator*(Complex w) const {
        return Complex(x*w.x - y*w.y, x*w.y + y*w.x);
    }
    
    
    __CUDA_HOSTDEVICE__ inline Complex operator/(Complex w) const {
        // Try the naive expression z/w = z*conj(w) / |w|^2; if we can compute
        // this without over/underflow, everything is fine and the result is
        // correct. If not, we have to rescale and do the computation carefully.
        RealType lenSq = w.lengthSquared();
        if (isNormal(lenSq)) {
            return *this * (w.conjugate().dividedBy(lenSq));
        } else {
            return rescaledDivide(*this, w);
        }
    }

    __CUDA_HOSTDEVICE__ inline void operator*=(Complex w) {
        *this = *this * w;
    }

    __CUDA_HOSTDEVICE__ inline void operator/=(Complex w)  {
        *this = *this / w;
    }

    __CUDA_HOSTDEVICE__ static Complex rescaledDivide(Complex z, Complex w) {
        if (w.isZero()) return infinity();
        if (z.isZero() || !w.isFinite()) return zero();
        // TODO: detect when RealType is Float and just promote to Double, then
        // use the naive algorithm.
        auto zScale = z.magnitude();
        auto wScale = w.magnitude();
        auto zNorm = z.dividedBy(zScale);
        auto wNorm = w.dividedBy(wScale);
        auto r = (zNorm * wNorm.conjugate()).dividedBy(wNorm.lengthSquared());
        // At this point, the result is (r * zScale)/wScale computed without
        // undue overflow or underflow. We know that r is close to unity, so
        // the question is simply what order in which to do this computation
        // to avoid spurious overflow or underflow. There are three options
        // to choose from:
        //
        // - r * (zScale / wScale)
        // - (r * zScale) / wScale
        // - (r / wScale) * zScale
        //
        // The simplest case is when zScale / wScale is normal:
        if (isNormal(zScale / wScale)) {
            return r.multipliedBy(zScale / wScale);
        }
        // Otherwise, we need to compute either rNorm * zScale or rNorm / wScale
        // first. Choose the first if the first scaling behaves well, otherwise
        // choose the other one.
        if (isNormal(r.magnitude() * zScale)) {
            return r.multipliedBy(zScale).dividedBy(wScale);
        }
        return r.dividedBy(wScale).multipliedBy(zScale);
    }

    /// A normalized complex number with the same phase as this value.
    ///
    /// If such a value cannot be produced (because the phase of zero and infinity is undefined),
    /// `nil` is returned.
    __CUDA_HOSTDEVICE__ inline std::optional<Complex> normalized() {
        if (length().isNormal()) {
            return this->dividedBy(length());
        }
        if (isZero() || !isFinite()) {
            return std::nullopt;
        }
        return this->dividedBy(magnitude()).normalized();
    }

    /// The reciprocal of this value, if it can be computed without undue overflow or underflow.
    ///
    /// If z.reciprocal is non-nil, you can safely replace division by z with multiplication by this value. It is
    /// not advantageous to do this for an isolated division, but if you are dividing many values by a single
    /// denominator, this will often be a significant performance win.
    ///
    /// Typical use looks like this:
    /// ```
    /// func divide<T: Real>(data: [Complex<T>], by divisor: Complex<T>) -> [Complex<T>] {
    ///   // If divisor is well-scaled, use multiply by reciprocal.
    ///   if let recip = divisor.reciprocal {
    ///     return data.map { $0 * recip }
    ///   }
    ///   // Fallback on using division.
    ///   return data.map { $0 / divisor }
    /// }
    /// ```
    __CUDA_HOSTDEVICE__ inline std::optional<Complex> reciprocal() {
        auto recip = 1/(*this);
        if (recip.isNormal() || isZero() || !isFinite()) {
            return recip;
        }
        return std::nullopt;
    }
};


#endif
