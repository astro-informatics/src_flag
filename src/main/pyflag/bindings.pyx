# cython: language_level=3

# import both numpy and the Cython declarations for numpy
import numpy as np
cimport numpy as np

# if you want to use the Numpy-C-API from Cython
np.import_array()

#----------------------------------------------------------------------------------------------------#


cdef extern from "flag/flag.h":

	# Core spherical laguerre functions
	int flag_core_flmn_size(int L, int N);
	int flag_core_f_size_mw(int L, int N);
	void flag_spherlaguerre_sampling(double *nodes, double *weights, double tau, int N);
	void flag_core_analysis(double complex *flmn, const double complex *f, int L, double tau, int N, int spin);
	void flag_core_analysis_real(double complex *flmn, const double *f, int L, double tau, int N);
	void flag_core_synthesis(double complex *f, const double complex *flmn, const double *nodes, int Nnodes, int L, double tau, int N, int spin);
	void flag_core_synthesis_real(double *f, const double complex *flmn, const double *nodes, int Nnodes, int L, double tau, int N);

	# Adjoint spherical laguerre functions
	void flag_adjoint_analysis(double complex *f, const double complex *flmn, int L, double tau, int N, int spin);
	void flag_adjoint_analysis_real(double *f, const double complex *flmn, int L, double tau, int N);
	void flag_adjoint_synthesis(double complex *flmn, const double complex *f, const double *nodes, int Nnodes, int L, double tau, int N, int spin);
	void flag_adjoint_synthesis_real(double complex *flmn, const double *f, const double *nodes, int Nnodes, int L, double tau, int N);


# Spherical Laguerre core python functions
def flag_flmn_size(int L, int N):
	return flag_core_flmn_size(L, N)

def flag_f_size(int L, int N):
	return flag_core_f_size_mw(L, N)

def flag_sl_sampling(float tau, int N):
	nodes = np.zeros([N,], dtype=float)
	weights = np.zeros([N,], dtype=float)
	flag_spherlaguerre_sampling(<double *> np.PyArray_DATA(nodes), <double *> np.PyArray_DATA(weights), <double> tau, N)
	return nodes, weights

def flag_analysis(np.ndarray[ double complex, ndim=1, mode="c"] f not None, 
				  int L, float tau, int N, int spin, int reality):
	cdef int flmn_size = flag_flmn_size(L, N)
	flmn = np.zeros([flmn_size,], dtype=complex)
	
	if reality == 1:
		flag_core_analysis_real(<double complex*> np.PyArray_DATA(flmn), <const double *> np.PyArray_DATA(f), L, <double> tau, N)
	else:
		flag_core_analysis(<double complex*> np.PyArray_DATA(flmn), <const double complex*> np.PyArray_DATA(f), L, <double> tau, N, spin)

	return flmn

def flag_analysis_adjoint(np.ndarray[ double complex, ndim=1, mode="c"] flmn not None, 
				  int L, float tau, int N, int spin, int reality):
	cdef int f_size = flag_f_size(L, N)
	
	if reality == 1:
		f = np.zeros([f_size,], dtype=float)
		flag_adjoint_analysis_real(<double *> np.PyArray_DATA(f), <const double complex*> np.PyArray_DATA(flmn), L, <double> tau, N)
	else:
		f = np.zeros([f_size,], dtype=complex)
		flag_adjoint_analysis(<double complex*> np.PyArray_DATA(f), <const double complex*> np.PyArray_DATA(flmn), L, <double> tau, N, spin)

	return f

def flag_synthesis(np.ndarray[ double complex, ndim=1, mode="c"] flmn not None, 
				   np.ndarray[ double, ndim=1, mode="c"] nodes not None,
				   int Nnodes, int L, float tau, int N, int spin, const int reality):
	cdef int f_size = flag_f_size(L, N)
	
	if reality == 1:
		f = np.zeros([f_size,], dtype=float)
		flag_core_synthesis_real(<double *> np.PyArray_DATA(f), <const double complex*> np.PyArray_DATA(flmn), 
								 <const double *> np.PyArray_DATA(nodes), Nnodes, L, <double> tau, N)
	else:
		f = np.zeros([f_size,], dtype=complex)
		flag_core_synthesis(<double complex*> np.PyArray_DATA(f), <const double complex*> np.PyArray_DATA(flmn), 
							<const double *> np.PyArray_DATA(nodes), Nnodes, L, <double> tau, N, spin)

	return f

def flag_synthesis_adjoint(np.ndarray[ double complex, ndim=1, mode="c"] f not None, 
				   np.ndarray[ double, ndim=1, mode="c"] nodes not None,
				   int Nnodes, int L, float tau, int N, int spin, const int reality):
	cdef int flmn_size = flag_flmn_size(L, N)
	flmn = np.zeros([flmn_size,], dtype=complex)
	
	if reality == 1:
		flag_adjoint_synthesis_real(<double complex*> np.PyArray_DATA(flmn), <const double *> np.PyArray_DATA(f), 
								 <const double *> np.PyArray_DATA(nodes), Nnodes, L, <double> tau, N)
	else:
		flag_adjoint_synthesis(<double complex*> np.PyArray_DATA(flmn), <const double complex*> np.PyArray_DATA(f), 
							<const double *> np.PyArray_DATA(nodes), Nnodes, L, <double> tau, N, spin)

	return flmn






