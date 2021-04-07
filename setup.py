from skbuild import setup

cmake_args = ["-Dtests:BOOL=OFF"]

setup(
    name="pyflag",
    version="0.0.1",
    author="Boris Leistedt & Jason McEwen",
    install_requires=["numpy", "cython", "scipy"],
    extras_require={
        "dev": [
            "numpy"
            "setuptools",
            "wheel",
            "scikit-build",
            "cmake",
            "ninja",
            "cython",
            "conan",
            "black",
            "pytest-black"
            "pytest",
        ]
    },
    description="Fast Fourier-Laguerre transform on the ball",
    url="https://github.com/astro-informatics/flag",
    package_dir={"pyflag": "src/main/pyflag"},
    cmake_args=cmake_args,
    cmake_languages=("C",),
    license="GPL-3",
    packages=["pyflag"],
)
