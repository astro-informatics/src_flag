*********************************
FLAG: Fourier-LAGuerre transform
*********************************

.. image:: https://img.shields.io/badge/GitHub-src_flag-brightgreen.svg?style=flat
    :target: https://github.com/astro-informatics/src_flag

.. image:: https://github.com/astro-informatics/src_flag/actions/workflows/cpp.yml/badge.svg
    :target: https://github.com/astro-informatics/src_flag/actions/workflows/cpp.yml

.. image:: https://img.shields.io/badge/License-GPL-blue.svg
    :target: http://perso.crans.org/besson/LICENSE.html

.. image:: http://img.shields.io/badge/arXiv-1205.0792-orange.svg?style=flat
    :target: https://arxiv.org/abs/1205.0792

DESCRIPTION
================================
The FLAG code provides functionality to perform fast and exact Fourier-Laguerre and Fourier-Bessel transforms on the ball.

DOCUMENTATION
================================
See the `code webiste <https://astro-informatics.github.io/flag/>`_ for full documentation and installation procedures. 

INSTALLATION
================================
This package can easily be installed from PyPi by running

.. code-block:: bash

    pip install flag 
    pip list

or alternatively from source by first compiling the C++ code and running 

.. code-block:: bash 

    pip install .

from the root directory.

AUTHORS
================================

     `B. Leistedt <www.ixkael.com/blog>`_
     `J. D. McEwen <www.jasonmcewen.org>`_
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
    title   = {A novel sampling theorem on the
     sphere},
    journal = {IEEE Trans. Sig. Proc.},
    year    = 2011,
    volume  = {59},
    number  = {12},
    pages   = {5876-5887},
    doi     = {10.1109/TSP.2011.2166394},
    }

LICENSE
================================

     FLAG package to perform fast wavelet transform on the sphere<br>
     Copyright (C) 2012 Boris Leistedt & Jason McEwen

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