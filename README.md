## Packaged/compiled Kilosort releases

This contains compiled versions of Kilosort 2.5


Run this on Linux. I used UBUNTU 22.04

To compile the MEX files, I had make sure I had a supported compiler for the CUDA version.
In my case that was version 11.8 so I had to install GCC 10

   - `sudo apt install gcc-10 g++-10`
   - `sudo ln -s /usr/bin/gcc-10 /usr/local/cuda/bin/gcc`
   - `sudo ln -s /usr/bin/g++-10 /usr/local/cuda/bin/g++`
   