#!/bin/sh

if [ ! -d "$HOME/conda/bin" ]; then
  if [ -d "$HOME/conda" ]; then
    rm -rf $HOME/conda
  fi
  wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh;
  bash miniconda.sh -b -p $HOME/conda
  export PATH="$HOME/conda/bin:$PATH"
  hash -r
  conda config --set always_yes yes --set changeps1 no
  conda update -q conda
  conda info -a
  conda create -q -n test-environment python=$TRAVIS_PYTHON_VERSION numpy scipy xarray matplotlib h5py coverage pytest pytest-cov
  source activate test-environment
  pip install tqdm plotly h5netcdf coveralls codeclimate-test-reporter
else
  export PATH="$HOME/conda/bin:$PATH"
  hash -r
  conda config --set always_yes yes --set changeps1 no
  conda update -q conda
  source activate test-environment
  conda update -q --all
  pip install -U tqdm plotly h5netcdf coveralls codeclimate-test-reporter
fi
