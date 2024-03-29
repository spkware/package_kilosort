## Packaged/compiled Kilosort releases

This contains a compiled version of Kilosort 2.5


#### Instructions

Run this on Linux. I used UBUNTU 22.04
After running `sh compile_kilosort2_5.sh` open matlab and run:

`pcmn = matlab.depfun.internal.ProductComponentModuleNavigator;`

`for f = fscanf(fopen('requiredMCRProducts.txt'),'%d')';`

`disp(pcmn.productInfo(f).extPName)`

`end`

to show which components need to be installed in the runtime.

#### Required components

  - MATLAB Runtime - Core
  - MATLAB Runtime - Non Interactive MATLAB
  - MATLAB Runtime - Numerics
  - MATLAB Runtime - Signal Processing Toolbox Addin
  - MATLAB Runtime - Image Processing Toolbox Addin
  - MATLAB Runtime - Statistics and Machine Learning Toolbox Addin
  - MATLAB Runtime - Parallel Computing Toolbox Cluster Addin
  - MATLAB Runtime - Parallel Computing Toolbox GPU Addin


##### Troubleshooting
To compile the MEX files, I had make sure I had a supported compiler for the CUDA version.
In my case that was version 11.8 so I had to install GCC 10

   - `sudo apt install gcc-10 g++-10`
   - `sudo ln -s /usr/bin/gcc-10 /usr/local/cuda/bin/gcc`
   - `sudo ln -s /usr/bin/g++-10 /usr/local/cuda/bin/g++`
