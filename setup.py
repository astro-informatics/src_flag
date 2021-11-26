from pathlib import Path 
from skbuild import setup

cmake_args = ["-Dtests:BOOL=OFF"]

long_description = (
    Path(__file__).parent / "src" / "main" / "pyflag" / ".FLAG_Python_Documentation.rst"
).read_text()

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
    long_description=long_description,
    long_description_content_type="text/x-rst",
    url="https://github.com/astro-informatics/flag",
    package_dir={"pyflag": "src/main/pyflag"},
    package_data={"pyflag": ["FLAG_Python_Documentation.rst"]},
    cmake_args=cmake_args,
    cmake_languages=("C",),
    license="GPL-3",
    packages=["pyflag"],
)
