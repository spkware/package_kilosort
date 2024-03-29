#!/bin/bash

KILOSORT="kilosort3_0"
KILOSORT_COMMIT=0fa64dc
KILOSORT_PATH=`realpath $KILOSORT`   
NPY_MATLAB_PATH=`realpath "npy-matlab"`
TMPDIR="temp"
OUTDIR="bin"
CWD=`pwd`

export TMPDIR=$CWD/$TMPDIR  # build dir for matlab
mkdir -p $TMPDIR  # for the temporary

# This script has to be ran from a LINUX computer with Matlab and all Kilosort2.5 dependencies installed. You will also need CUDA and MCC (matlab compiler)

# 1) Checkout the release version of Kilosort2.5
cd $KILOSORT_PATH
git checkout $KILOSORT_COMMIT
#
# 2) Compile all MEX

# To compile the MEX files, I had make sure I had a supported compiler for the CUDA version.
# In my case that was version 11.8 so I had to install GCC 10
#   - `sudo apt install gcc-10 g++-10`
#   - `sudo ln -s /usr/bin/gcc-10 /usr/local/cuda/bin/gcc`
#   - `sudo ln -s /usr/bin/g++-10 /usr/local/cuda/bin/g++`
cd $KILOSORT_PATH"/CUDA"
matlab -batch "mexGPUall"

# 3) Compile Kilosort to $OUTDIR
export OUTDIR=$CWD/$OUTDIR  # output dir
cd $OUTDIR   # go to the output dir

CMD="mcc -v -R -nodisplay -m "${CWD}"/run_"${KILOSORT}".m -a "${KILOSORT_PATH}" -a "${NPY_MATLAB_PATH}" -o "${KILOSORT}

matlab -batch "$CMD"



