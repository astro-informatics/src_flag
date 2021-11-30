// FLAG package
// Copyright (C) 2021
// Boris Leistedt & Jason McEwen & Matthew Price

#ifndef FLAG_CORE
#define FLAG_CORE

#include "flag_types.h"

#include <complex.h>
#ifdef __cplusplus
extern "C" {
#endif

/*!
 * Allocate FLAG coefficients.
 *
 * \param[out]  flmn Fourier-Laguerre coefficients.
 * \param[in]  L Angular harmonic band-limit.
 * \param[in]  N Radial harmonic band-limit.
 * \retval none
 */
void flag_core_allocate_flmn(FLAG_COMPLEX(double) **flmn, int L, int N);

/*!
 * Allocate sampled field (MW sampling, real).
 *
 * \param[out]  f Sampled dataset (real).
 * \param[in]  L Angular harmonic band-limit.
 * \param[in]  N Radial harmonic band-limit.
 * \retval none
 */
void flag_core_allocate_f_real(double **f, int L, int N);

/*!
 * Allocate sampled field (MW sampling, complex).
 *
 * \param[out]  f Sampled dataset (complex).
 * \param[in]  L Angular harmonic band-limit.
 * \param[in]  N Radial harmonic band-limit.
 * \retval none
 */
void flag_core_allocate_f(FLAG_COMPLEX(double) **f, int L, int N);

/*!
 * Get size of the full FLAG decomposition.
 *
 * \param[in]  L Angular harmonic band-limit.
 * \param[in]  N Radial harmonic band-limit.
 * \retval N*L^2
 */
int flag_core_flmn_size(int L, int N);

/*!
 * Get size of the full dataset for MW sampling.
 *
 * \param[in]  L Angular harmonic band-limit.
 * \param[in]  N Radial harmonic band-limit.
 * \retval N*L*(2*L-1)
 */
int flag_core_f_size_mw(int L, int N);

/*!
 * Perform Fourier-Laguerre analysis (MW sampling, complex signal).
 *
 * \param[out] flmn Fourier-Laguerre coefficients.
 * \param[in]  f Input dataset (MW sampling, complex signal)
 * \param[in]  L Angular harmonic band-limit.
 * \param[in]  N Radial harmonic band-limit.
 * \retval none
 */
void flag_core_analysis(FLAG_COMPLEX(double) *flmn, const FLAG_COMPLEX(double) *f, int L, double tau, int N, int spin);

/*!
 * Perform Fourier-Laguerre analysis adjoint (MW sampling, complex signal).
 *
 * \param[out]  f Input dataset (MW sampling, complex signal)
 * \param[in] flmn Fourier-Laguerre adjoint space coefficients.
 * \param[in]  L Angular harmonic band-limit.
 * \param[in]  N Radial harmonic band-limit.
 * \retval none
 * \retval none
 */
void flag_adjoint_analysis(FLAG_COMPLEX(double) *f, const FLAG_COMPLEX(double) *flmn, int L, double tau, int N, int spin);

/*!
 * Perform Fourier-Laguerre synthesis (MW sampling, complex signal).
 *
 * \param[out]  f Input dataset (MW sampling, complex signal)
 * \param[in] flmn Fourier-Laguerre coefficients.
 * \param[in]  L Angular harmonic band-limit.
 * \param[in]  N Radial harmonic band-limit.
 * \retval none
 */
 void flag_core_synthesis(FLAG_COMPLEX(double) *f, const FLAG_COMPLEX(double) *flmn, const double *nodes, int Nnodes, int L, double tau, int N, int spin);

 /*!
 * Perform Fourier-Laguerre analysis (MW sampling, complex signal).
 *
 * \param[out] flmn Fourier-Laguerre coefficients.
 * \param[in]  f Input dataset (MW sampling, complex signal)
 * \param[in]  L Angular harmonic band-limit.
 * \param[in]  N Radial harmonic band-limit.
 * \retval none
 */
 void flag_adjoint_synthesis(FLAG_COMPLEX(double) *flmn, const FLAG_COMPLEX(double) *f, const double *nodes, int Nnodes, int L, double tau, int N, int spin);

/*!
 * Perform Fourier-Laguerre analysis (MW sampling, real signal).
 *
 * \param[out] flmn Fourier-Laguerre coefficients.
 * \param[in]  f Input dataset (MW sampling, real signal)
 * \param[in]  L Angular harmonic band-limit.
 * \param[in]  N Radial harmonic band-limit.
 * \retval none
 */
void flag_core_analysis_real(FLAG_COMPLEX(double) *flmn, const double *f, int L, double tau, int N);

/*!
 * Perform Fourier-Laguerre analysis adjoint (MW sampling, real signal).
 *
 * \param[out]  f Input dataset (MW sampling, real signal)
 * \param[in] flmn Fourier-Laguerre adjoint space coefficients.
 * \param[in]  L Angular harmonic band-limit.
 * \param[in]  N Radial harmonic band-limit.
 * \retval none
 * \retval none
 */
void flag_adjoint_analysis_real(double *f, const FLAG_COMPLEX(double) *flmn, int L, double tau, int N);

/*!
 * Perform Fourier-Laguerre synthesis (MW sampling, real signal).
 *
 * \param[out]  f Input dataset (MW sampling, real signal)
 * \param[in] flmn Fourier-Laguerre coefficients.
 * \param[in]  L Angular harmonic band-limit.
 * \param[in]  N Radial harmonic band-limit.
 * \retval none
 */
void flag_core_synthesis_real(double *f, const FLAG_COMPLEX(double) *flmn, const double *nodes, int Nnodes, int L, double tau, int N);

 /*!
 * Perform Fourier-Laguerre analysis (MW sampling, real signal).
 *
 * \param[out] flmn Fourier-Laguerre coefficients.
 * \param[in]  f Input dataset (MW sampling, real signal)
 * \param[in]  L Angular harmonic band-limit.
 * \param[in]  N Radial harmonic band-limit.
 * \retval none
 */
 void flag_adjoint_synthesis_real(FLAG_COMPLEX(double) *flmn, const double *f, const double *nodes, int Nnodes, int L, double tau, int N);

/*!
 * Compute the spherical-Bessel function of order l at X
 */
double j_ell(double X, int l);

/*!
 * Compute the spherical-Bessel basis functions on a grid of radii
 *
 * \param[out]  jell Synthesised basis function.
 * \param[in]  ell order-multipole of the basis function.
 * \param[in]  nodes Radii where the function must be calculated.
 * \param[in]  Nnodes Number of radii.
 * \retval none
 */
void flag_spherbessel_basis(double *jell, const int ell, const double *nodes, int Nnodes);
void flag_core_fourierbessel_analysis(FLAG_COMPLEX(double) *flmn, const FLAG_COMPLEX(double) *f, int L, double tau, int N);
void flag_core_fourierbessel_synthesis(FLAG_COMPLEX(double) *f, const FLAG_COMPLEX(double) *flmn, const double *nodes, int Nnodes, int L, double tau, int N);


#ifdef __cplusplus
}
#endif
#endif