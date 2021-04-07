import numpy as np 
from pytest import approx 

import pyflag as flag 

def test_complex_transform():

	L = 32
	N = 32
	tau = 1.0
	reality = 0
	spin = 0
	nodes, weights = flag.flag_sl_sampling(tau, N)
	rng = np.random.default_rng()

	f_size = flag.flag_f_size(L, N)
	flmn_size = flag.flag_flmn_size(L, N)
	flmn_input = rng.normal(size=(flmn_size)) + 1j*rng.normal(size=(flmn_size))

	f_input = flag.flag_synthesis(flmn_input, nodes, N, L, tau, N, spin, reality)
	flmn_output = flag.flag_analysis(f_input, L, tau, N, spin, reality)
	f_output = flag.flag_synthesis(flmn_output, nodes, N, L, tau, N, spin, reality)

	assert flmn_output == approx(flmn_input)
	assert f_output == approx(f_input)

def test_analysis_adjoint_transform():

	L = 32
	N = 32
	tau = 1.0
	reality = 0
	spin = 0
	nodes, weights = flag.flag_sl_sampling(tau, N)
	rng = np.random.default_rng()

	f_size = flag.flag_f_size(L, N)
	flmn_size = flag.flag_flmn_size(L, N)

	flmn_input = rng.normal(size=(flmn_size)) + 1j*rng.normal(size=(flmn_size))
	f_input = rng.normal(size=(f_size)) + 1j*rng.normal(size=(f_size))

	f_output = flag.flag_analysis_adjoint(flmn_input, L, tau, N, spin, reality)
	flmn_output = flag.flag_analysis(f_input, L, tau, N, spin, reality)

	assert np.abs(np.vdot(f_output, f_input)) == approx(np.abs(np.vdot(flmn_input, flmn_output)))

def test_synthesis_adjoint_transform():

	L = 32
	N = 32
	tau = 1.0
	reality = 0
	spin = 0
	nodes, weights = flag.flag_sl_sampling(tau, N)
	rng = np.random.default_rng()

	f_size = flag.flag_f_size(L, N)
	flmn_size = flag.flag_flmn_size(L, N)

	flmn_input = rng.normal(size=(flmn_size)) + 1j*rng.normal(size=(flmn_size))
	f_input = rng.normal(size=(f_size)) + 1j*rng.normal(size=(f_size))

	f_output = flag.flag_synthesis(flmn_input, nodes, N, L, tau, N, spin, reality)
	flmn_output = flag.flag_synthesis_adjoint(f_input, nodes, N, L, tau, N, spin, reality)

	assert np.abs(np.vdot(f_output, f_input)) == approx(np.abs(np.vdot(flmn_input, flmn_output)))
