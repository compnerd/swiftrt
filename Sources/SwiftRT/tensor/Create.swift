//******************************************************************************
// Copyright 2020 Google LLC
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

// gyb utility docs
// https://nshipster.com/swift-gyb/

//******************************************************************************
//
// DO NOT EDIT. THIS FILE IS GENERATED FROM Create.swift.gyb
//
//******************************************************************************

//==============================================================================
// ranked convenience types
/// FillTensors
public typealias Fill1<Element> = FillTensor<Shape1, Element>
/// FillTensors
public typealias Fill2<Element> = FillTensor<Shape2, Element>
/// FillTensors
public typealias Fill3<Element> = FillTensor<Shape3, Element>
/// FillTensors
public typealias Fill4<Element> = FillTensor<Shape4, Element>
/// FillTensors
public typealias Fill5<Element> = FillTensor<Shape5, Element>
/// FillTensors
public typealias Fill6<Element> = FillTensor<Shape6, Element>

/// DenseTensors
public typealias Dense1<Element> = DenseTensor<Shape1, Element>
/// DenseTensors
public typealias Dense2<Element> = DenseTensor<Shape2, Element>
/// DenseTensors
public typealias Dense3<Element> = DenseTensor<Shape3, Element>
/// DenseTensors
public typealias Dense4<Element> = DenseTensor<Shape4, Element>
/// DenseTensors
public typealias Dense5<Element> = DenseTensor<Shape5, Element>
/// DenseTensors
public typealias Dense6<Element> = DenseTensor<Shape6, Element>

//==============================================================================
/// empty
/// Return a new tensor of given shape and type, without initializing entries.
/// - Parameters:
///  - shape: Int or tuple of Int
///    Shape of the empty array, e.g., (2, 3) or 2.
///  - dtype: data-type, optional
///    Desired output data-type for the array, e.g, Int8. Default is DType.
///  - order: { .C, .F }, optional, default .C
///    Whether to store multi-dimensional data in row-major (C-style)
///    or column-major (Fortran-style) order in memory.
/// - Returns: Dense of uninitialized (arbitrary) data of the given shape,
///   dtype, and order. Elements will not be initialized.
@inlinable
public func empty<Shape, Element>(
    _ shape: Shape.Tuple,
    _ dtype: Element.Type,
    _ order: StorageOrder = .C
) -> DenseTensor<Shape, Element> where Shape: Shaped
{
    empty(Shape(shape), dtype, order)
}

@inlinable
public func empty<Shape, Element>(
    _ shape: Shape,
    _ dtype: Element.Type,
    _ order: StorageOrder = .C
) -> DenseTensor<Shape, Element> where Shape: Shaped
{
    DenseTensor(shape, order: order)
}

//---------------------------------------
// Rank 0
@inlinable
public func empty() -> Dense1<DType> {
    empty(Shape1(1), DType.self)
}

@inlinable
public func empty<Element>(dtype: Element.Type)
    -> Dense1<Element> { empty(Shape1(1), dtype) }

//---------------------------------------
// Rank1
@inlinable
public func empty(_ shape: Shape1.Tuple, order: StorageOrder = .C)
    -> Dense1<DType> { empty(shape, DType.self, order) }

@inlinable
public func empty<Element>(_ shape: Shape1.Tuple, dtype: Element.Type)
    -> Dense1<Element> { empty(shape, dtype) }

@inlinable
public func empty<Element>(_ shape: Shape1.Tuple, dtype: Element.Type,
                           order: StorageOrder = .C)
    -> Dense1<Element> { empty(shape, dtype, order) }
    
//---------------------------------------
// Rank2
@inlinable
public func empty(_ shape: Shape2.Tuple, order: StorageOrder = .C)
    -> Dense2<DType> { empty(shape, DType.self, order) }

@inlinable
public func empty<Element>(_ shape: Shape2.Tuple, dtype: Element.Type)
    -> Dense2<Element> { empty(shape, dtype) }

@inlinable
public func empty<Element>(_ shape: Shape2.Tuple, dtype: Element.Type,
                           order: StorageOrder = .C)
    -> Dense2<Element> { empty(shape, dtype, order) }
    
//---------------------------------------
// Rank3
@inlinable
public func empty(_ shape: Shape3.Tuple, order: StorageOrder = .C)
    -> Dense3<DType> { empty(shape, DType.self, order) }

@inlinable
public func empty<Element>(_ shape: Shape3.Tuple, dtype: Element.Type)
    -> Dense3<Element> { empty(shape, dtype) }

@inlinable
public func empty<Element>(_ shape: Shape3.Tuple, dtype: Element.Type,
                           order: StorageOrder = .C)
    -> Dense3<Element> { empty(shape, dtype, order) }
    
//---------------------------------------
// Rank4
@inlinable
public func empty(_ shape: Shape4.Tuple, order: StorageOrder = .C)
    -> Dense4<DType> { empty(shape, DType.self, order) }

@inlinable
public func empty<Element>(_ shape: Shape4.Tuple, dtype: Element.Type)
    -> Dense4<Element> { empty(shape, dtype) }

@inlinable
public func empty<Element>(_ shape: Shape4.Tuple, dtype: Element.Type,
                           order: StorageOrder = .C)
    -> Dense4<Element> { empty(shape, dtype, order) }
    
//---------------------------------------
// Rank5
@inlinable
public func empty(_ shape: Shape5.Tuple, order: StorageOrder = .C)
    -> Dense5<DType> { empty(shape, DType.self, order) }

@inlinable
public func empty<Element>(_ shape: Shape5.Tuple, dtype: Element.Type)
    -> Dense5<Element> { empty(shape, dtype) }

@inlinable
public func empty<Element>(_ shape: Shape5.Tuple, dtype: Element.Type,
                           order: StorageOrder = .C)
    -> Dense5<Element> { empty(shape, dtype, order) }
    
//---------------------------------------
// Rank6
@inlinable
public func empty(_ shape: Shape6.Tuple, order: StorageOrder = .C)
    -> Dense6<DType> { empty(shape, DType.self, order) }

@inlinable
public func empty<Element>(_ shape: Shape6.Tuple, dtype: Element.Type)
    -> Dense6<Element> { empty(shape, dtype) }

@inlinable
public func empty<Element>(_ shape: Shape6.Tuple, dtype: Element.Type,
                           order: StorageOrder = .C)
    -> Dense6<Element> { empty(shape, dtype, order) }
    

//==============================================================================
/// empty(like:
/// Return a new tensor of given shape and type, without initializing entries.
/// - Parameters:
///  - prototype: unspecified attributes are copied from this tensor
///  - dtype: data-type, optional
///    Desired output data-type for the array, e.g, Int8. Default is DType.
///  - order: { .C, .F }, optional, default .C
///    Whether to store multi-dimensional data in row-major (C-style)
///    or column-major (Fortran-style) order in memory.
///  - shape: Int or tuple of Int
///    Shape of the empty array, e.g., (2, 3) or 2.
/// - Returns: Dense of uninitialized (arbitrary) data of the given shape,
///   dtype, and order. Elements will not be initialized.

// same type and shape
@inlinable
public func empty<T>(
    like prototype: T,
    order: StorageOrder? = nil
) -> DenseTensor<T.Shape, T.Element> where T: Tensor
{
    empty(prototype.shape, T.Element.self, order ?? prototype.order)
}

//------------------------------------------------------------------------------
// same type different shape
// Rank1
@inlinable public func empty<T>(
    like prototype: T,
    order: StorageOrder? = nil,
    shape: Shape1.Tuple
) -> DenseTensor<Shape1, T.Element> where T: Tensor
{
    assert(prototype.count == Shape1(shape).elementCount())
    return empty(shape, T.Element.self, order ?? prototype.order)
}
// Rank2
@inlinable public func empty<T>(
    like prototype: T,
    order: StorageOrder? = nil,
    shape: Shape2.Tuple
) -> DenseTensor<Shape2, T.Element> where T: Tensor
{
    assert(prototype.count == Shape2(shape).elementCount())
    return empty(shape, T.Element.self, order ?? prototype.order)
}
// Rank3
@inlinable public func empty<T>(
    like prototype: T,
    order: StorageOrder? = nil,
    shape: Shape3.Tuple
) -> DenseTensor<Shape3, T.Element> where T: Tensor
{
    assert(prototype.count == Shape3(shape).elementCount())
    return empty(shape, T.Element.self, order ?? prototype.order)
}
// Rank4
@inlinable public func empty<T>(
    like prototype: T,
    order: StorageOrder? = nil,
    shape: Shape4.Tuple
) -> DenseTensor<Shape4, T.Element> where T: Tensor
{
    assert(prototype.count == Shape4(shape).elementCount())
    return empty(shape, T.Element.self, order ?? prototype.order)
}
// Rank5
@inlinable public func empty<T>(
    like prototype: T,
    order: StorageOrder? = nil,
    shape: Shape5.Tuple
) -> DenseTensor<Shape5, T.Element> where T: Tensor
{
    assert(prototype.count == Shape5(shape).elementCount())
    return empty(shape, T.Element.self, order ?? prototype.order)
}
// Rank6
@inlinable public func empty<T>(
    like prototype: T,
    order: StorageOrder? = nil,
    shape: Shape6.Tuple
) -> DenseTensor<Shape6, T.Element> where T: Tensor
{
    assert(prototype.count == Shape6(shape).elementCount())
    return empty(shape, T.Element.self, order ?? prototype.order)
}

//------------------------------------------------------------------------------
// different type same shape
@inlinable public func empty<T, Element>(
    like prototype: T,
    dtype: Element.Type,
    order: StorageOrder? = nil
) -> DenseTensor<T.Shape, Element> where T: Tensor
{
    empty(prototype.shape, Element.self, order ?? prototype.order)
}

//------------------------------------------------------------------------------
// different type, different shape
// Rank1
@inlinable public func empty<T, Element>(
    like prototype: T,
    dtype: Element.Type,
    order: StorageOrder? = nil,
    shape: Shape1.Tuple
) -> DenseTensor<Shape1, Element> where T: Tensor
{
    assert(prototype.count == Shape1(shape).elementCount())
    return empty(shape, Element.self, order ?? prototype.order)
}
// Rank2
@inlinable public func empty<T, Element>(
    like prototype: T,
    dtype: Element.Type,
    order: StorageOrder? = nil,
    shape: Shape2.Tuple
) -> DenseTensor<Shape2, Element> where T: Tensor
{
    assert(prototype.count == Shape2(shape).elementCount())
    return empty(shape, Element.self, order ?? prototype.order)
}
// Rank3
@inlinable public func empty<T, Element>(
    like prototype: T,
    dtype: Element.Type,
    order: StorageOrder? = nil,
    shape: Shape3.Tuple
) -> DenseTensor<Shape3, Element> where T: Tensor
{
    assert(prototype.count == Shape3(shape).elementCount())
    return empty(shape, Element.self, order ?? prototype.order)
}
// Rank4
@inlinable public func empty<T, Element>(
    like prototype: T,
    dtype: Element.Type,
    order: StorageOrder? = nil,
    shape: Shape4.Tuple
) -> DenseTensor<Shape4, Element> where T: Tensor
{
    assert(prototype.count == Shape4(shape).elementCount())
    return empty(shape, Element.self, order ?? prototype.order)
}
// Rank5
@inlinable public func empty<T, Element>(
    like prototype: T,
    dtype: Element.Type,
    order: StorageOrder? = nil,
    shape: Shape5.Tuple
) -> DenseTensor<Shape5, Element> where T: Tensor
{
    assert(prototype.count == Shape5(shape).elementCount())
    return empty(shape, Element.self, order ?? prototype.order)
}
// Rank6
@inlinable public func empty<T, Element>(
    like prototype: T,
    dtype: Element.Type,
    order: StorageOrder? = nil,
    shape: Shape6.Tuple
) -> DenseTensor<Shape6, Element> where T: Tensor
{
    assert(prototype.count == Shape6(shape).elementCount())
    return empty(shape, Element.self, order ?? prototype.order)
}

//==============================================================================
/// full
/// Return a new tensor of given shape and type filled with `value`
/// - Parameters:
///  - shape: Int or tuple of Int
///    Shape of the array, e.g., (2, 3) or 2.
///  - value: Fill value.
///  - dtype: data-type, optional
///    Desired output data-type for the array, e.g, Int8. Default is DType.
///  - order: { .C, .F }, optional, default .C
///    Whether to store multi-dimensional data in row-major (C-style)
///    or column-major (Fortran-style) order in memory.
/// - Returns: Fill of uninitialized (arbitrary) data of the given shape,
///   dtype, and order. Elements will not be initialized.
@inlinable
public func full<Shape, Element>(
    _ shape: Shape.Tuple,
    _ value: Element,
    _ dtype: Element.Type,
    _ order: StorageOrder = .C
) -> FillTensor<Shape, Element> where Shape: Shaped
{
    full(Shape(shape), value, dtype, order)
}

@inlinable
public func full<Shape, Element>(
    _ shape: Shape,
    _ value: Element,
    _ dtype: Element.Type,
    _ order: StorageOrder = .C
) -> FillTensor<Shape, Element> where Shape: Shaped
{
    FillTensor(shape, element: value, order: order)
}

//---------------------------------------
// Rank0
@inlinable
public func full(_ value: DType) -> Fill1<DType> {
    full(Shape1(1), value, DType.self)
}

@inlinable
public func full<Element>(_ value: Element, dtype: Element.Type)
    -> Fill1<Element> { full(Shape1(1), value, dtype) }

//---------------------------------------
// Rank1
@inlinable
public func full(
    _ shape: Shape1.Tuple,
    _ value: DType,
    order: StorageOrder = .C
) -> Fill1<DType> { full(shape, value, DType.self, order) }

@inlinable
public func full<Element>(
    _ shape: Shape1.Tuple,
    _ value: Element,
    dtype: Element.Type
) -> Fill1<Element> { full(shape, value, dtype) }

@inlinable
public func full<Element>(
    _ shape: Shape1.Tuple,
    _ value: Element,
    dtype: Element.Type,
    order: StorageOrder = .C
) -> Fill1<Element> { full(shape, value, dtype, order) }

//---------------------------------------
// Rank2
@inlinable
public func full(
    _ shape: Shape2.Tuple,
    _ value: DType,
    order: StorageOrder = .C
) -> Fill2<DType> { full(shape, value, DType.self, order) }

@inlinable
public func full<Element>(
    _ shape: Shape2.Tuple,
    _ value: Element,
    dtype: Element.Type
) -> Fill2<Element> { full(shape, value, dtype) }

@inlinable
public func full<Element>(
    _ shape: Shape2.Tuple,
    _ value: Element,
    dtype: Element.Type,
    order: StorageOrder = .C
) -> Fill2<Element> { full(shape, value, dtype, order) }

//---------------------------------------
// Rank3
@inlinable
public func full(
    _ shape: Shape3.Tuple,
    _ value: DType,
    order: StorageOrder = .C
) -> Fill3<DType> { full(shape, value, DType.self, order) }

@inlinable
public func full<Element>(
    _ shape: Shape3.Tuple,
    _ value: Element,
    dtype: Element.Type
) -> Fill3<Element> { full(shape, value, dtype) }

@inlinable
public func full<Element>(
    _ shape: Shape3.Tuple,
    _ value: Element,
    dtype: Element.Type,
    order: StorageOrder = .C
) -> Fill3<Element> { full(shape, value, dtype, order) }

//---------------------------------------
// Rank4
@inlinable
public func full(
    _ shape: Shape4.Tuple,
    _ value: DType,
    order: StorageOrder = .C
) -> Fill4<DType> { full(shape, value, DType.self, order) }

@inlinable
public func full<Element>(
    _ shape: Shape4.Tuple,
    _ value: Element,
    dtype: Element.Type
) -> Fill4<Element> { full(shape, value, dtype) }

@inlinable
public func full<Element>(
    _ shape: Shape4.Tuple,
    _ value: Element,
    dtype: Element.Type,
    order: StorageOrder = .C
) -> Fill4<Element> { full(shape, value, dtype, order) }

//---------------------------------------
// Rank5
@inlinable
public func full(
    _ shape: Shape5.Tuple,
    _ value: DType,
    order: StorageOrder = .C
) -> Fill5<DType> { full(shape, value, DType.self, order) }

@inlinable
public func full<Element>(
    _ shape: Shape5.Tuple,
    _ value: Element,
    dtype: Element.Type
) -> Fill5<Element> { full(shape, value, dtype) }

@inlinable
public func full<Element>(
    _ shape: Shape5.Tuple,
    _ value: Element,
    dtype: Element.Type,
    order: StorageOrder = .C
) -> Fill5<Element> { full(shape, value, dtype, order) }

//---------------------------------------
// Rank6
@inlinable
public func full(
    _ shape: Shape6.Tuple,
    _ value: DType,
    order: StorageOrder = .C
) -> Fill6<DType> { full(shape, value, DType.self, order) }

@inlinable
public func full<Element>(
    _ shape: Shape6.Tuple,
    _ value: Element,
    dtype: Element.Type
) -> Fill6<Element> { full(shape, value, dtype) }

@inlinable
public func full<Element>(
    _ shape: Shape6.Tuple,
    _ value: Element,
    dtype: Element.Type,
    order: StorageOrder = .C
) -> Fill6<Element> { full(shape, value, dtype, order) }


//==============================================================================
/// full(like:
/// Return a new tensor of given shape and type filled with `value`
/// - Parameters:
///  - prototype: unspecified attributes are copied from this tensor
///  - value: Fill value.
///  - dtype: data-type, optional
///    Desired output data-type for the array, e.g, Int8. Default is DType.
///  - order: { .C, .F }, optional, default .C
///    Whether to store multi-dimensional data in row-major (C-style)
///    or column-major (Fortran-style) order in memory.
///  - shape: Int or tuple of Int
///    Shape of the full array, e.g., (2, 3) or 2.
/// - Returns: Fill of uninitialized (arbitrary) data of the given shape,
///   dtype, and order. Elements will not be initialized.

// same type and shape
@inlinable
public func full<T>(
    like prototype: T,
    _ value: T.Element,
    order: StorageOrder? = nil
) -> FillTensor<T.Shape, T.Element> where T: Tensor
{
    full(prototype.shape, value, T.Element.self, order ?? prototype.order)
}

//------------------------------------------------------------------------------
// same type different shape
// Rank1
@inlinable public func full<T>(
    like prototype: T,
    _ value: T.Element,
    order: StorageOrder? = nil,
    shape: Shape1.Tuple
) -> Fill1<T.Element> where T: Tensor
{
    assert(prototype.count == Shape1(shape).elementCount())
    return full(shape, value, T.Element.self, order ?? prototype.order)
}

// Rank2
@inlinable public func full<T>(
    like prototype: T,
    _ value: T.Element,
    order: StorageOrder? = nil,
    shape: Shape2.Tuple
) -> Fill2<T.Element> where T: Tensor
{
    assert(prototype.count == Shape2(shape).elementCount())
    return full(shape, value, T.Element.self, order ?? prototype.order)
}

// Rank3
@inlinable public func full<T>(
    like prototype: T,
    _ value: T.Element,
    order: StorageOrder? = nil,
    shape: Shape3.Tuple
) -> Fill3<T.Element> where T: Tensor
{
    assert(prototype.count == Shape3(shape).elementCount())
    return full(shape, value, T.Element.self, order ?? prototype.order)
}

// Rank4
@inlinable public func full<T>(
    like prototype: T,
    _ value: T.Element,
    order: StorageOrder? = nil,
    shape: Shape4.Tuple
) -> Fill4<T.Element> where T: Tensor
{
    assert(prototype.count == Shape4(shape).elementCount())
    return full(shape, value, T.Element.self, order ?? prototype.order)
}

// Rank5
@inlinable public func full<T>(
    like prototype: T,
    _ value: T.Element,
    order: StorageOrder? = nil,
    shape: Shape5.Tuple
) -> Fill5<T.Element> where T: Tensor
{
    assert(prototype.count == Shape5(shape).elementCount())
    return full(shape, value, T.Element.self, order ?? prototype.order)
}

// Rank6
@inlinable public func full<T>(
    like prototype: T,
    _ value: T.Element,
    order: StorageOrder? = nil,
    shape: Shape6.Tuple
) -> Fill6<T.Element> where T: Tensor
{
    assert(prototype.count == Shape6(shape).elementCount())
    return full(shape, value, T.Element.self, order ?? prototype.order)
}


//------------------------------------------------------------------------------
// different type same shape
@inlinable
public func full<T, Element>(
    like prototype: T,
    _ value: Element,
    dtype: Element.Type,
    order: StorageOrder? = nil
) -> FillTensor<T.Shape, Element> where T: Tensor
{
    full(prototype.shape, value, Element.self, order ?? prototype.order)
}

//------------------------------------------------------------------------------
// different type, different shape
// Rank1
@inlinable public func full<T, Element>(
    like prototype: T,
    _ value: Element,
    dtype: Element.Type,
    order: StorageOrder? = nil,
    shape: Shape1.Tuple
) -> Fill1<Element> where T: Tensor
{
    assert(prototype.count == Shape1(shape).elementCount())
    return full(shape, value, Element.self, order ?? prototype.order)
}

// Rank2
@inlinable public func full<T, Element>(
    like prototype: T,
    _ value: Element,
    dtype: Element.Type,
    order: StorageOrder? = nil,
    shape: Shape2.Tuple
) -> Fill2<Element> where T: Tensor
{
    assert(prototype.count == Shape2(shape).elementCount())
    return full(shape, value, Element.self, order ?? prototype.order)
}

// Rank3
@inlinable public func full<T, Element>(
    like prototype: T,
    _ value: Element,
    dtype: Element.Type,
    order: StorageOrder? = nil,
    shape: Shape3.Tuple
) -> Fill3<Element> where T: Tensor
{
    assert(prototype.count == Shape3(shape).elementCount())
    return full(shape, value, Element.self, order ?? prototype.order)
}

// Rank4
@inlinable public func full<T, Element>(
    like prototype: T,
    _ value: Element,
    dtype: Element.Type,
    order: StorageOrder? = nil,
    shape: Shape4.Tuple
) -> Fill4<Element> where T: Tensor
{
    assert(prototype.count == Shape4(shape).elementCount())
    return full(shape, value, Element.self, order ?? prototype.order)
}

// Rank5
@inlinable public func full<T, Element>(
    like prototype: T,
    _ value: Element,
    dtype: Element.Type,
    order: StorageOrder? = nil,
    shape: Shape5.Tuple
) -> Fill5<Element> where T: Tensor
{
    assert(prototype.count == Shape5(shape).elementCount())
    return full(shape, value, Element.self, order ?? prototype.order)
}

// Rank6
@inlinable public func full<T, Element>(
    like prototype: T,
    _ value: Element,
    dtype: Element.Type,
    order: StorageOrder? = nil,
    shape: Shape6.Tuple
) -> Fill6<Element> where T: Tensor
{
    assert(prototype.count == Shape6(shape).elementCount())
    return full(shape, value, Element.self, order ?? prototype.order)
}


//==============================================================================
/// ones
/// Return a new tensor of given shape and type filled with ones
/// - Parameters:
///  - shape: Int or tuple of Int
///    Shape of the array, e.g., (2, 3) or 2.
///  - dtype: data-type, optional
///    Desired output data-type for the array, e.g, Int8. Default is DType.
///  - order: { .C, .F }, optional, default .C
///    Whether to store multi-dimensional data in row-major (C-style)
///    or column-major (Fortran-style) order in memory.
/// - Returns: Fill of uninitialized (arbitrary) data of the given shape,
///   dtype, and order. Elements will not be initialized.
@inlinable
public func ones<Shape, Element>(
    _ shape: Shape.Tuple,
    _ dtype: Element.Type,
    _ order: StorageOrder = .C
) -> FillTensor<Shape, Element> where Shape: Shaped, Element: Numeric
{
    ones(Shape(shape), dtype, order)
}

@inlinable
public func ones<Shape, Element>(
    _ shape: Shape,
    _ dtype: Element.Type,
    _ order: StorageOrder = .C
) -> FillTensor<Shape, Element> where Shape: Shaped, Element: Numeric
{
    FillTensor(shape, element: 1, order: order)
}

//---------------------------------------
// Rank0
@inlinable
public func ones() -> Fill1<DType> {
    ones(Shape1(1), DType.self)
}

@inlinable
public func ones<Element>(dtype: Element.Type)
    -> Fill1<Element> where Element: Numeric { ones(Shape1(1), dtype) }

//---------------------------------------
// Rank1
@inlinable
public func ones(_ shape: Shape1.Tuple, order: StorageOrder = .C)
    -> Fill1<DType> { ones(shape, DType.self, order) }

@inlinable
public func ones<Element>(_ shape: Shape1.Tuple, dtype: Element.Type)
    -> Fill1<Element> where Element: Numeric { ones(shape, dtype) }

@inlinable
public func ones<Element>(
    _ shape: Shape1.Tuple,
    dtype: Element.Type,
    order: StorageOrder = .C
) -> Fill1<Element> where Element: Numeric { ones(shape, dtype, order) }

//---------------------------------------
// Rank2
@inlinable
public func ones(_ shape: Shape2.Tuple, order: StorageOrder = .C)
    -> Fill2<DType> { ones(shape, DType.self, order) }

@inlinable
public func ones<Element>(_ shape: Shape2.Tuple, dtype: Element.Type)
    -> Fill2<Element> where Element: Numeric { ones(shape, dtype) }

@inlinable
public func ones<Element>(
    _ shape: Shape2.Tuple,
    dtype: Element.Type,
    order: StorageOrder = .C
) -> Fill2<Element> where Element: Numeric { ones(shape, dtype, order) }

//---------------------------------------
// Rank3
@inlinable
public func ones(_ shape: Shape3.Tuple, order: StorageOrder = .C)
    -> Fill3<DType> { ones(shape, DType.self, order) }

@inlinable
public func ones<Element>(_ shape: Shape3.Tuple, dtype: Element.Type)
    -> Fill3<Element> where Element: Numeric { ones(shape, dtype) }

@inlinable
public func ones<Element>(
    _ shape: Shape3.Tuple,
    dtype: Element.Type,
    order: StorageOrder = .C
) -> Fill3<Element> where Element: Numeric { ones(shape, dtype, order) }

//---------------------------------------
// Rank4
@inlinable
public func ones(_ shape: Shape4.Tuple, order: StorageOrder = .C)
    -> Fill4<DType> { ones(shape, DType.self, order) }

@inlinable
public func ones<Element>(_ shape: Shape4.Tuple, dtype: Element.Type)
    -> Fill4<Element> where Element: Numeric { ones(shape, dtype) }

@inlinable
public func ones<Element>(
    _ shape: Shape4.Tuple,
    dtype: Element.Type,
    order: StorageOrder = .C
) -> Fill4<Element> where Element: Numeric { ones(shape, dtype, order) }

//---------------------------------------
// Rank5
@inlinable
public func ones(_ shape: Shape5.Tuple, order: StorageOrder = .C)
    -> Fill5<DType> { ones(shape, DType.self, order) }

@inlinable
public func ones<Element>(_ shape: Shape5.Tuple, dtype: Element.Type)
    -> Fill5<Element> where Element: Numeric { ones(shape, dtype) }

@inlinable
public func ones<Element>(
    _ shape: Shape5.Tuple,
    dtype: Element.Type,
    order: StorageOrder = .C
) -> Fill5<Element> where Element: Numeric { ones(shape, dtype, order) }

//---------------------------------------
// Rank6
@inlinable
public func ones(_ shape: Shape6.Tuple, order: StorageOrder = .C)
    -> Fill6<DType> { ones(shape, DType.self, order) }

@inlinable
public func ones<Element>(_ shape: Shape6.Tuple, dtype: Element.Type)
    -> Fill6<Element> where Element: Numeric { ones(shape, dtype) }

@inlinable
public func ones<Element>(
    _ shape: Shape6.Tuple,
    dtype: Element.Type,
    order: StorageOrder = .C
) -> Fill6<Element> where Element: Numeric { ones(shape, dtype, order) }


//==============================================================================
/// ones(like:
/// Return a new tensor of given shape and type filled with ones
/// - Parameters:
///  - prototype: unspecified attributes are copied from this tensor
///  - dtype: data-type, optional
///    Desired output data-type for the array, e.g, Int8. Default is DType.
///  - order: { .C, .F }, optional, default .C
///    Whether to store multi-dimensional data in row-major (C-style)
///    or column-major (Fortran-style) order in memory.
///  - shape: Int or tuple of Int
///    Shape of the ones array, e.g., (2, 3) or 2.
/// - Returns: Fill of uninitialized (arbitrary) data of the given shape,
///   dtype, and order. Elements will not be initialized.

// same type and shape
@inlinable
public func ones<T>(like prototype: T, order: StorageOrder? = nil)
    -> FillTensor<T.Shape, T.Element> where T: Tensor, T.Element: Numeric
{
    ones(prototype.shape, T.Element.self, order ?? prototype.order)
}

//------------------------------------------------------------------------------
// same type different shape
// Rank1
@inlinable public func ones<T>(
    like prototype: T,
    order: StorageOrder? = nil,
    shape: Shape1.Tuple
) -> Fill1<T.Element> where T: Tensor, T.Element: Numeric
{
    assert(prototype.count == Shape1(shape).elementCount())
    return ones(shape, T.Element.self, order ?? prototype.order)
}

// Rank2
@inlinable public func ones<T>(
    like prototype: T,
    order: StorageOrder? = nil,
    shape: Shape2.Tuple
) -> Fill2<T.Element> where T: Tensor, T.Element: Numeric
{
    assert(prototype.count == Shape2(shape).elementCount())
    return ones(shape, T.Element.self, order ?? prototype.order)
}

// Rank3
@inlinable public func ones<T>(
    like prototype: T,
    order: StorageOrder? = nil,
    shape: Shape3.Tuple
) -> Fill3<T.Element> where T: Tensor, T.Element: Numeric
{
    assert(prototype.count == Shape3(shape).elementCount())
    return ones(shape, T.Element.self, order ?? prototype.order)
}

// Rank4
@inlinable public func ones<T>(
    like prototype: T,
    order: StorageOrder? = nil,
    shape: Shape4.Tuple
) -> Fill4<T.Element> where T: Tensor, T.Element: Numeric
{
    assert(prototype.count == Shape4(shape).elementCount())
    return ones(shape, T.Element.self, order ?? prototype.order)
}

// Rank5
@inlinable public func ones<T>(
    like prototype: T,
    order: StorageOrder? = nil,
    shape: Shape5.Tuple
) -> Fill5<T.Element> where T: Tensor, T.Element: Numeric
{
    assert(prototype.count == Shape5(shape).elementCount())
    return ones(shape, T.Element.self, order ?? prototype.order)
}

// Rank6
@inlinable public func ones<T>(
    like prototype: T,
    order: StorageOrder? = nil,
    shape: Shape6.Tuple
) -> Fill6<T.Element> where T: Tensor, T.Element: Numeric
{
    assert(prototype.count == Shape6(shape).elementCount())
    return ones(shape, T.Element.self, order ?? prototype.order)
}


//------------------------------------------------------------------------------
// different type same shape
@inlinable
public func ones<T, Element>(
    like prototype: T,
    dtype: Element.Type,
    order: StorageOrder? = nil
) -> FillTensor<T.Shape, Element>
    where T: Tensor, T.Element: Numeric, Element: Numeric
{
    ones(prototype.shape, Element.self, order ?? prototype.order)
}

//------------------------------------------------------------------------------
// different type, different shape
// Rank1
@inlinable public func ones<T, Element>(
    like prototype: T,
    dtype: Element.Type,
    order: StorageOrder? = nil,
    shape: Shape1.Tuple
) -> Fill1<Element>
    where T: Tensor, T.Element: Numeric, Element: Numeric
{
    assert(prototype.count == Shape1(shape).elementCount())
    return ones(shape, Element.self, order ?? prototype.order)
}

// Rank2
@inlinable public func ones<T, Element>(
    like prototype: T,
    dtype: Element.Type,
    order: StorageOrder? = nil,
    shape: Shape2.Tuple
) -> Fill2<Element>
    where T: Tensor, T.Element: Numeric, Element: Numeric
{
    assert(prototype.count == Shape2(shape).elementCount())
    return ones(shape, Element.self, order ?? prototype.order)
}

// Rank3
@inlinable public func ones<T, Element>(
    like prototype: T,
    dtype: Element.Type,
    order: StorageOrder? = nil,
    shape: Shape3.Tuple
) -> Fill3<Element>
    where T: Tensor, T.Element: Numeric, Element: Numeric
{
    assert(prototype.count == Shape3(shape).elementCount())
    return ones(shape, Element.self, order ?? prototype.order)
}

// Rank4
@inlinable public func ones<T, Element>(
    like prototype: T,
    dtype: Element.Type,
    order: StorageOrder? = nil,
    shape: Shape4.Tuple
) -> Fill4<Element>
    where T: Tensor, T.Element: Numeric, Element: Numeric
{
    assert(prototype.count == Shape4(shape).elementCount())
    return ones(shape, Element.self, order ?? prototype.order)
}

// Rank5
@inlinable public func ones<T, Element>(
    like prototype: T,
    dtype: Element.Type,
    order: StorageOrder? = nil,
    shape: Shape5.Tuple
) -> Fill5<Element>
    where T: Tensor, T.Element: Numeric, Element: Numeric
{
    assert(prototype.count == Shape5(shape).elementCount())
    return ones(shape, Element.self, order ?? prototype.order)
}

// Rank6
@inlinable public func ones<T, Element>(
    like prototype: T,
    dtype: Element.Type,
    order: StorageOrder? = nil,
    shape: Shape6.Tuple
) -> Fill6<Element>
    where T: Tensor, T.Element: Numeric, Element: Numeric
{
    assert(prototype.count == Shape6(shape).elementCount())
    return ones(shape, Element.self, order ?? prototype.order)
}


//==============================================================================
/// zeros
/// Return a new tensor of given shape and type filled with zeros
/// - Parameters:
///  - shape: Int or tuple of Int
///    Shape of the array, e.g., (2, 3) or 2.
///  - dtype: data-type, optional
///    Desired output data-type for the array, e.g, Int8. Default is DType.
///  - order: { .C, .F }, optional, default .C
///    Whether to store multi-dimensional data in row-major (C-style)
///    or column-major (Fortran-style) order in memory.
/// - Returns: Fill of uninitialized (arbitrary) data of the given shape,
///   dtype, and order. Elements will not be initialized.
@inlinable
public func zeros<Shape, Element>(
    _ shape: Shape.Tuple,
    _ dtype: Element.Type,
    _ order: StorageOrder = .C
) -> FillTensor<Shape, Element> where Shape: Shaped, Element: Numeric
{
    zeros(Shape(shape), dtype, order)
}

@inlinable
public func zeros<Shape, Element>(
    _ shape: Shape,
    _ dtype: Element.Type,
    _ order: StorageOrder = .C
) -> FillTensor<Shape, Element> where Shape: Shaped, Element: Numeric
{
    FillTensor(shape, element: 0, order: order)
}

//---------------------------------------
// Rank0
@inlinable
public func zeros() -> Fill1<DType> {
    zeros(Shape1(1), DType.self)
}

@inlinable
public func zeros<Element>(dtype: Element.Type)
    -> Fill1<Element> where Element: Numeric { zeros(Shape1(1), dtype) }

//---------------------------------------
// Rank1
@inlinable
public func zeros(_ shape: Shape1.Tuple, order: StorageOrder = .C)
    -> Fill1<DType> { zeros(shape, DType.self, order) }

@inlinable
public func zeros<Element>(_ shape: Shape1.Tuple, dtype: Element.Type)
    -> Fill1<Element> where Element: Numeric { zeros(shape, dtype) }

@inlinable
public func zeros<Element>(
    _ shape: Shape1.Tuple,
    dtype: Element.Type,
    order: StorageOrder = .C
) -> Fill1<Element> where Element: Numeric { zeros(shape, dtype, order) }

//---------------------------------------
// Rank2
@inlinable
public func zeros(_ shape: Shape2.Tuple, order: StorageOrder = .C)
    -> Fill2<DType> { zeros(shape, DType.self, order) }

@inlinable
public func zeros<Element>(_ shape: Shape2.Tuple, dtype: Element.Type)
    -> Fill2<Element> where Element: Numeric { zeros(shape, dtype) }

@inlinable
public func zeros<Element>(
    _ shape: Shape2.Tuple,
    dtype: Element.Type,
    order: StorageOrder = .C
) -> Fill2<Element> where Element: Numeric { zeros(shape, dtype, order) }

//---------------------------------------
// Rank3
@inlinable
public func zeros(_ shape: Shape3.Tuple, order: StorageOrder = .C)
    -> Fill3<DType> { zeros(shape, DType.self, order) }

@inlinable
public func zeros<Element>(_ shape: Shape3.Tuple, dtype: Element.Type)
    -> Fill3<Element> where Element: Numeric { zeros(shape, dtype) }

@inlinable
public func zeros<Element>(
    _ shape: Shape3.Tuple,
    dtype: Element.Type,
    order: StorageOrder = .C
) -> Fill3<Element> where Element: Numeric { zeros(shape, dtype, order) }

//---------------------------------------
// Rank4
@inlinable
public func zeros(_ shape: Shape4.Tuple, order: StorageOrder = .C)
    -> Fill4<DType> { zeros(shape, DType.self, order) }

@inlinable
public func zeros<Element>(_ shape: Shape4.Tuple, dtype: Element.Type)
    -> Fill4<Element> where Element: Numeric { zeros(shape, dtype) }

@inlinable
public func zeros<Element>(
    _ shape: Shape4.Tuple,
    dtype: Element.Type,
    order: StorageOrder = .C
) -> Fill4<Element> where Element: Numeric { zeros(shape, dtype, order) }

//---------------------------------------
// Rank5
@inlinable
public func zeros(_ shape: Shape5.Tuple, order: StorageOrder = .C)
    -> Fill5<DType> { zeros(shape, DType.self, order) }

@inlinable
public func zeros<Element>(_ shape: Shape5.Tuple, dtype: Element.Type)
    -> Fill5<Element> where Element: Numeric { zeros(shape, dtype) }

@inlinable
public func zeros<Element>(
    _ shape: Shape5.Tuple,
    dtype: Element.Type,
    order: StorageOrder = .C
) -> Fill5<Element> where Element: Numeric { zeros(shape, dtype, order) }

//---------------------------------------
// Rank6
@inlinable
public func zeros(_ shape: Shape6.Tuple, order: StorageOrder = .C)
    -> Fill6<DType> { zeros(shape, DType.self, order) }

@inlinable
public func zeros<Element>(_ shape: Shape6.Tuple, dtype: Element.Type)
    -> Fill6<Element> where Element: Numeric { zeros(shape, dtype) }

@inlinable
public func zeros<Element>(
    _ shape: Shape6.Tuple,
    dtype: Element.Type,
    order: StorageOrder = .C
) -> Fill6<Element> where Element: Numeric { zeros(shape, dtype, order) }


//==============================================================================
/// zeros(like:
/// Return a new tensor of given shape and type filled with zeros
/// - Parameters:
///  - prototype: unspecified attributes are copied from this tensor
///  - dtype: data-type, optional
///    Desired output data-type for the array, e.g, Int8. Default is DType.
///  - order: { .C, .F }, optional, default .C
///    Whether to store multi-dimensional data in row-major (C-style)
///    or column-major (Fortran-style) order in memory.
///  - shape: Int or tuple of Int
///    Shape of the zeros array, e.g., (2, 3) or 2.
/// - Returns: Fill of uninitialized (arbitrary) data of the given shape,
///   dtype, and order. Elements will not be initialized.

// same type and shape
@inlinable
public func zeros<T>(like prototype: T, order: StorageOrder? = nil)
    -> FillTensor<T.Shape, T.Element> where T: Tensor, T.Element: Numeric
{
    zeros(prototype.shape, T.Element.self, order ?? prototype.order)
}

//------------------------------------------------------------------------------
// same type different shape
// Rank1
@inlinable public func zeros<T>(
    like prototype: T,
    order: StorageOrder? = nil,
    shape: Shape1.Tuple
) -> Fill1<T.Element> where T: Tensor, T.Element: Numeric
{
    assert(prototype.count == Shape1(shape).elementCount())
    return zeros(shape, T.Element.self, order ?? prototype.order)
}

// Rank2
@inlinable public func zeros<T>(
    like prototype: T,
    order: StorageOrder? = nil,
    shape: Shape2.Tuple
) -> Fill2<T.Element> where T: Tensor, T.Element: Numeric
{
    assert(prototype.count == Shape2(shape).elementCount())
    return zeros(shape, T.Element.self, order ?? prototype.order)
}

// Rank3
@inlinable public func zeros<T>(
    like prototype: T,
    order: StorageOrder? = nil,
    shape: Shape3.Tuple
) -> Fill3<T.Element> where T: Tensor, T.Element: Numeric
{
    assert(prototype.count == Shape3(shape).elementCount())
    return zeros(shape, T.Element.self, order ?? prototype.order)
}

// Rank4
@inlinable public func zeros<T>(
    like prototype: T,
    order: StorageOrder? = nil,
    shape: Shape4.Tuple
) -> Fill4<T.Element> where T: Tensor, T.Element: Numeric
{
    assert(prototype.count == Shape4(shape).elementCount())
    return zeros(shape, T.Element.self, order ?? prototype.order)
}

// Rank5
@inlinable public func zeros<T>(
    like prototype: T,
    order: StorageOrder? = nil,
    shape: Shape5.Tuple
) -> Fill5<T.Element> where T: Tensor, T.Element: Numeric
{
    assert(prototype.count == Shape5(shape).elementCount())
    return zeros(shape, T.Element.self, order ?? prototype.order)
}

// Rank6
@inlinable public func zeros<T>(
    like prototype: T,
    order: StorageOrder? = nil,
    shape: Shape6.Tuple
) -> Fill6<T.Element> where T: Tensor, T.Element: Numeric
{
    assert(prototype.count == Shape6(shape).elementCount())
    return zeros(shape, T.Element.self, order ?? prototype.order)
}


//------------------------------------------------------------------------------
// different type same shape
@inlinable
public func zeros<T, Element>(
    like prototype: T,
    dtype: Element.Type,
    order: StorageOrder? = nil
) -> FillTensor<T.Shape, Element>
    where T: Tensor, T.Element: Numeric, Element: Numeric
{
    zeros(prototype.shape, Element.self, order ?? prototype.order)
}

//------------------------------------------------------------------------------
// different type, different shape
// Rank1
@inlinable public func zeros<T, Element>(
    like prototype: T,
    dtype: Element.Type,
    order: StorageOrder? = nil,
    shape: Shape1.Tuple
) -> Fill1<Element>
    where T: Tensor, T.Element: Numeric, Element: Numeric
{
    assert(prototype.count == Shape1(shape).elementCount())
    return zeros(shape, Element.self, order ?? prototype.order)
}

// Rank2
@inlinable public func zeros<T, Element>(
    like prototype: T,
    dtype: Element.Type,
    order: StorageOrder? = nil,
    shape: Shape2.Tuple
) -> Fill2<Element>
    where T: Tensor, T.Element: Numeric, Element: Numeric
{
    assert(prototype.count == Shape2(shape).elementCount())
    return zeros(shape, Element.self, order ?? prototype.order)
}

// Rank3
@inlinable public func zeros<T, Element>(
    like prototype: T,
    dtype: Element.Type,
    order: StorageOrder? = nil,
    shape: Shape3.Tuple
) -> Fill3<Element>
    where T: Tensor, T.Element: Numeric, Element: Numeric
{
    assert(prototype.count == Shape3(shape).elementCount())
    return zeros(shape, Element.self, order ?? prototype.order)
}

// Rank4
@inlinable public func zeros<T, Element>(
    like prototype: T,
    dtype: Element.Type,
    order: StorageOrder? = nil,
    shape: Shape4.Tuple
) -> Fill4<Element>
    where T: Tensor, T.Element: Numeric, Element: Numeric
{
    assert(prototype.count == Shape4(shape).elementCount())
    return zeros(shape, Element.self, order ?? prototype.order)
}

// Rank5
@inlinable public func zeros<T, Element>(
    like prototype: T,
    dtype: Element.Type,
    order: StorageOrder? = nil,
    shape: Shape5.Tuple
) -> Fill5<Element>
    where T: Tensor, T.Element: Numeric, Element: Numeric
{
    assert(prototype.count == Shape5(shape).elementCount())
    return zeros(shape, Element.self, order ?? prototype.order)
}

// Rank6
@inlinable public func zeros<T, Element>(
    like prototype: T,
    dtype: Element.Type,
    order: StorageOrder? = nil,
    shape: Shape6.Tuple
) -> Fill6<Element>
    where T: Tensor, T.Element: Numeric, Element: Numeric
{
    assert(prototype.count == Shape6(shape).elementCount())
    return zeros(shape, Element.self, order ?? prototype.order)
}
