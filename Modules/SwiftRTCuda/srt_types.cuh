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
#pragma once
#include <stdint.h>
#include <cuda_fp16.h>
#include <cuda_bf16.h>
#include <vector_types.h>

#include "cuda_helpers.cuh"
#include "complex.h"

//==============================================================================
// used for casting between gpu simd types and uint32_t
#define UINT_CREF(_v) reinterpret_cast<const unsigned&>(_v)
#define CAST(type, _v) (*reinterpret_cast<const type*>(&(_v)))

//==============================================================================
// supplemental logical types
struct bool2 {
    bool x, y;
    __HOSTDEVICE_INLINE__ bool2() { x = false; y = false; }
    __HOSTDEVICE_INLINE__ bool2(bool _x, bool _y) { x = _x; y = _y; }
    
    __DEVICE_INLINE__ bool2(__half2 v) { x = v.x; y = v.y; }
    __DEVICE_INLINE__ bool2(__nv_bfloat162 v) { x = v.x; y = v.y; }
    __DEVICE_INLINE__ bool2(unsigned v) {
        x = v & 0xFF;
        y = (v >> 16) & 0xFF;
    }
};

struct bool4 {
    bool x, y, z, w;
    __HOSTDEVICE_INLINE__ bool4() {
        x = false; y = false; z = false; w = false;
    }
    __HOSTDEVICE_INLINE__ bool4(bool _x, bool _y, bool _z, bool _w) {
        x = _x; y = _y; z = _z; w = _w;
    }
    __HOSTDEVICE_INLINE__ bool4(unsigned v) {
        *this = *reinterpret_cast<const bool4*>(&v);
    }
};


//==============================================================================
// conformance helpers
template<typename A, typename O>
inline constexpr bool isSame() {
    return std::is_same<A,O>::value;
}

template<typename A>
inline constexpr bool isInteger() {
    return std::is_integral<A>::value ||
        std::is_same<A,char4>::value  || std::is_same<A,uchar4>::value ||
        std::is_same<A,short2>::value || std::is_same<A,ushort2>::value;
}

template<typename A>
inline constexpr bool isFloating() {
    return 
        std::is_floating_point<A>::value ||
        std::is_same<A,__half>::value  || std::is_same<A,__half2>::value ||
        std::is_same<A,__nv_bfloat16>::value || std::is_same<A,__nv_bfloat162>::value;
}

template<typename A>
inline constexpr bool isComplex() {
    return std::is_same<A, Complex<float>>::value;
}

template<typename A>
inline constexpr bool isBool() {
    return std::is_same<A,bool>::value ||
        std::is_same<A,bool2>::value || std::is_same<A,bool4>::value;
}

template<typename A>
inline constexpr bool isNumeric() {
    return isInteger<A>() || isFloating<A>() || isComplex<A>();
}

template<typename A>
inline constexpr bool isComparable() {
    return isNumeric<A>();
}

template<typename T>
inline constexpr bool isEquatable() {
    return isNumeric<T>() || isBool<T>();
}

template<typename A>
inline constexpr bool isSignedNumeric() {
    return isNumeric<A>() && std::is_signed<A>::value;
}

template<typename A>
inline constexpr bool isPacked() {
    return 
    std::is_same<A,bool2>::value  || std::is_same<A,bool4>::value ||
    std::is_same<A,char4>::value  || std::is_same<A,uchar4>::value ||
    std::is_same<A,short2>::value || std::is_same<A,ushort2>::value ||
    std::is_same<A,__half2>::value || std::is_same<A,__nv_bfloat162>::value;
}

//==============================================================================
// given an input type A and an output type O, if the input is
// packed, then the corresponding packed respresention of O is defined
template<typename T> struct packed {
    typedef T type;
    inline static T value(const T v) { return v; }
};

template<> struct packed<int8_t> {
    typedef char4 type;
    inline static type value(const int8_t v) {
        type p; p.x = v; p.y = v; p.z = v; p.w = v; return p;
    }
};

template<> struct packed<uint8_t> {
    typedef uchar4 type;
    inline static type value(const uint8_t v) {
        type p; p.x = v; p.y = v; p.z = v; p.w = v; return p;
    }
};

template<> struct packed<int16_t> {
    typedef short2 type;
    inline static type value(const int16_t v) {
        type p; p.x = v; p.y = v; return p;
    }
};

template<> struct packed<uint16_t> {
    typedef ushort2 type;
    inline static type value(const uint16_t v) {
        type p; p.x = v; p.y = v; return p;
    }
};

template<> struct packed<__half> {
    typedef __half2 type;
    inline static type value(const __half v) {
        type p; p.x = v; p.y = v; return p;
    }
};

template<> struct packed<__nv_bfloat16> {
    typedef __nv_bfloat162 type;
    inline static type value(const __nv_bfloat16 v) {
        type p; p.x = v; p.y = v; return p;
    }
};

//--------------------------------------
// given an input type A and an output type O, if the input is
// packed, then the corresponding packed respresention of O is defined
template<typename A, typename O>
struct matching_packed { typedef O type; };
template<> struct matching_packed<char4, bool> { typedef bool4 type; };
template<> struct matching_packed<char4, int8_t> { typedef char4 type; };

template<> struct matching_packed<uchar4, bool> { typedef bool4 type; };
template<> struct matching_packed<uchar4, uint8_t> { typedef uchar4 type; };

template<> struct matching_packed<short2, bool> { typedef bool2 type; };
template<> struct matching_packed<short2, int16_t> { typedef short2 type; };

template<> struct matching_packed<ushort2, bool> { typedef bool2 type; };
template<> struct matching_packed<ushort2, uint16_t> { typedef ushort2 type; };

template<> struct matching_packed<__half2, bool> { typedef bool2 type; };
template<> struct matching_packed<__half2, __half> { typedef __half2 type; };

template<> struct matching_packed<__nv_bfloat162, bool> { typedef bool2 type; };
template<> struct matching_packed<__nv_bfloat162, __nv_bfloat16> { typedef __nv_bfloat162 type; };

//--------------------------------------
// given an input type A and an output type O, if the input is
// packed, then the corresponding packed respresention of O is defined
template<typename A> struct packing { static const int count = 1; };

template<> struct packing<char4> { static const int count = 4; };
template<> struct packing<const char4> { static const int count = 4; };
template<> struct packing<uchar4> { static const int count = 4; };
template<> struct packing<const uchar4> { static const int count = 4; };
template<> struct packing<bool4> { static const int count = 4; };
template<> struct packing<const bool4> { static const int count = 4; };

template<> struct packing<bool2> { static const int count = 2; };
template<> struct packing<const bool2> { static const int count = 2; };
template<> struct packing<short2> { static const int count = 2; };
template<> struct packing<const short2> { static const int count = 2; };
template<> struct packing<ushort2> { static const int count = 2; };
template<> struct packing<const ushort2> { static const int count = 2; };
template<> struct packing<__half2> { static const int count = 2; };
template<> struct packing<const __half2> { static const int count = 2; };
template<> struct packing<__nv_bfloat162> { static const int count = 2; };
template<> struct packing<const __nv_bfloat162> { static const int count = 2; };

