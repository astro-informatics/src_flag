.. image:: https://img.shields.io/badge/GitHub-src_flag-brightgreen.svg?style=flat
    :target: https://github.com/astro-informatics/src_flag
.. image:: https://github.com/astro-informatics/src_flag/actions/workflows/cpp.yml/badge.svg
    :target: https://github.com/astro-informatics/src_flag/actions/workflows/cpp.yml
.. image:: https://readthedocs.org/projects/ansicolortags/badge/?version=latest
    :target: https://astro-informatics.github.io/flag/
.. image:: https://badge.fury.io/py/pyflag.svg
    :target: https://badge.fury.io/py/pyflag
.. image:: https://img.shields.io/badge/License-GPL-blue.svg
    :target: http://perso.crans.org/besson/LICENSE.html
.. image:: http://img.shields.io/badge/arXiv-1205.0792-orange.svg?style=flat
    :target: https://arxiv.org/abs/1205.0792
.. image:: http://img.shields.io/badge/arXiv-1110.6298-orange.svg?style=flat
    :target: https://arxiv.org/abs/1110.6298
.. image:: http://img.shields.io/badge/arXiv-2105.05518-orange.svg?style=flat
    :target: https://arxiv.org/abs/2105.05518

|logo| FLAG: Fourier-LAGuerre transform
================================

.. |logo| raw:: html

   <img src="./doc/images/logo.jpg" align="center" height="52" width="56">

DESCRIPTION
================================
The ``FLAG`` code provides functionality to perform fast and exact Fourier-Laguerre and Fourier-Bessel transforms on the ball.

C INSTALLATION
================================
The primary C version of this code can be installed from source by running

.. code-block:: bash

     git clone git@github.com:astro-informatics/src_flag.git
     cd src_flag 
     mkdir build && cd build
     cmake .. && make 

Following which one can check the installation by running

.. code-block:: bash

     ctest

within the build directory.

PYTHON INSTALLATION
================================
``FLAG`` can easily be installed from PyPi by running

.. code-block:: bash

    pip install pyflag 
    pip list

or alternatively from source by first compiling the C code and running 

.. code-block:: bash 

    pip install .

from the root directory, following which the package may be tested by running 

.. code-block:: bash 

     pytest 

within the root directory.

MATLAB INSTALLATION
================================
Mex wrappers are available, however they are currently being sunsetted, so installing previously tagged versions is advised.

BASIC USAGE (PYTHON)
================================
First install ``FLAG`` for python, then you can call it from any python script to perform forward and inverse flag transforms and their adjoints by 

.. code-block:: python

    import pyflag as flag 
    import numpy as np 

    L = 10                          # Angular bandlimit
    P = 5                           # Radial bandlimit
    tau = 1                         # Laguerre scaling factor 
    spin = 0                        # Spin of signal
    reality = 0                     # Real or complex signals

    # Create a random complex signal (c indexing)
    f = np.random.rand(P, L, 2*L-1) + 1j*np.random.rand(P, L, 2*L-1)
    f = f.flatten('C')

    # Compute e.g. the Forward transform 
    flmp = flag.flag_analysis(f, L, tau, P, spin, reality)

AUTHORS
================================

`B. Leistedt <www.ixkael.com/blog>`_, 
`J. D. McEwen <www.jasonmcewen.org>`_, and 
`M. A. Price <https://scholar.google.com/citations?user=w7_VDLQAAAAJ&hl=en&authuser=1>`_

REFERENCES
================================

.. code-block::

    @article{price:2021:bayesian,
        author  = {Matthew~A.~Price and Jason~D.~McEwen},
        title   = {Bayesian variational regularization on the ball},
        journal = {ArXiv},
        eprint  = {arXiv:2105.05518},
        year    = 2021
    }

.. code-block::

    @article{leistedt:2012:exact,
        author  = {Boris~Leistedt and Jason~D.~McEwen},
        title   = {Exact Wavelets on the Ball},
        journal = {IEEE Trans. Sig. Proc.},
        year    = 2012,
        volume  = {60},
        number  = {12},
        pages   = {6257-6269},
        doi     = {10.1109/TSP.2012.2215030},
    }

.. code-block::

    @article{McEwen:2011:novel,
        author  = {Jason~D.~McEwen and Yves~Wiaux},
        title   = {A novel sampling theorem on the sphere},
        journal = {IEEE Trans. Sig. Proc.},
        year    = 2011,
        volume  = {59},
        number  = {12},
        pages   = {5876-5887},
        doi     = {10.1109/TSP.2011.2166394},
    }

LICENSE
================================

.. code-block::

     FLAG package to perform fast wavelet transform on the sphere<br>
     Copyright (C) 2021 Boris Leistedt & Jason McEwen & Matthew Price

     This program is free software; you can redistribute it and/or
     modify it under the terms of the GNU General Public License
     as published by the Free Software Foundation; either version 2
     of the License, or (at your option) any later version.

     This program is distributed in the hope that it will be useful,
     but WITHOUT ANY WARRANTY; without even the implied warranty of
     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
     GNU General Public License for more details (LICENSE.txt).

     You should have received a copy of the GNU General Public License
     along with this program; if not, write to the Free Software
     Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, 
     MA  02110-1301, USA.
