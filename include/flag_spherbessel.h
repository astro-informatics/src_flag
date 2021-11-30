// FLAG package
// Copyright (C) 2021
// Boris Leistedt & Jason McEwen & Matthew Price

#ifndef FLAG_SPHERBESSEL
#define FLAG_SPHERBESSEL

#include "flag_types.h"

#include <complex.h> 
#ifdef __cplusplus
extern "C" {
#endif

void flag_spherlaguerre2spherbessel(double *flk, const double *fn, double *kvalues, int Nk, int N, int ell, double tau);

void flag_spherbessel_approx(double *flk, const double *f, double *kvalues, int Nk, double *nodes, int Nnodes, int ell);

void flag_fourierlaguerre2fourierbessel(FLAG_COMPLEX(double) *flmk, FLAG_COMPLEX(double) *flmn, double *kvalues, int Nk, int N, int L, double tau);

void flag_sbesselslag(double *sbesselslag, int ell, double *kvalues, int Nk, int N, double tau);

void flag_mulk(double *mulk, int n, int ell, double k, double tau);

#ifdef __cplusplus
}
#endif
#endif