#ifndef FLAG_TYPES
#define FLAG_TYPES

#include <ssht/ssht.h>

#ifdef __cplusplus
#include <complex>
#define FLAG_COMPLEX(TYPE) std::complex<TYPE>
extern "C" {
#else
#define FLAG_COMPLEX(TYPE) TYPE complex
#endif

#define FLAG_PI    3.141592653589793238462643383279502884197

#ifdef __cplusplus
}
#endif
#endif