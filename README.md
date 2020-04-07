# mltoolbox


Uses `plaidml` to run on GPU.

## 1 Setup

    make setup
    
During inhalation you will see:
```
PlaidML Setup (0.7.0)

Thanks for using PlaidML!

The feedback we have received from our users indicates an ever-increasing need
for performance, programmability, and portability. During the past few months,
we have been restructuring PlaidML to address those needs.  To make all the
changes we need to make while supporting our current user base, all development
of PlaidML has moved to a branch — plaidml-v1. We will continue to maintain and
support the master branch of PlaidML and the stable 0.7.0 release.

Read more here: https://github.com/plaidml/plaidml

Some Notes:
  * Bugs and other issues: https://github.com/plaidml/plaidml/issues
  * Questions: https://stackoverflow.com/questions/tagged/plaidml
  * Say hello: https://groups.google.com/forum/#!forum/plaidml-dev
  * PlaidML is licensed under the Apache License 2.0


Default Config Devices:
   llvm_cpu.0 : CPU (via LLVM)
   metal_intel(r)_uhd_graphics_630.0 : Intel(R) UHD Graphics 630 (Metal)
   metal_amd_radeon_pro_560x.0 : AMD Radeon Pro 560X (Metal)

Experimental Config Devices:
   llvm_cpu.0 : CPU (via LLVM)
   opencl_amd_radeon_pro_560x_compute_engine.0 : AMD AMD Radeon Pro 560X Compute Engine (OpenCL)
   metal_intel(r)_uhd_graphics_630.0 : Intel(R) UHD Graphics 630 (Metal)
   opencl_intel_uhd_graphics_630.0 : Intel Inc. Intel(R) UHD Graphics 630 (OpenCL)
   metal_amd_radeon_pro_560x.0 : AMD Radeon Pro 560X (Metal)

Using experimental devices can cause poor performance, crashes, and other nastiness.

Enable experimental device support? (y,n)[n]:y

Multiple devices detected (You can override by setting PLAIDML_DEVICE_IDS).
Please choose a default device:

   1 : llvm_cpu.0
   2 : opencl_amd_radeon_pro_560x_compute_engine.0
   3 : metal_intel(r)_uhd_graphics_630.0
   4 : opencl_intel_uhd_graphics_630.0
   5 : metal_amd_radeon_pro_560x.0

Default device? (1,2,3,4,5)[1]:5

Selected device:
    metal_amd_radeon_pro_560x.0

Almost done. Multiplying some matrices...
Tile code:
  function (B[X,Z], C[Z,Y]) -> (A) { A[x,y : X,Y] = +(B[x,z] * C[z,y]); }
Whew. That worked.

Save settings to /Users/filipe/.plaidml? (y,n)[y]:y
Success!
```

### 1.1 Run plaidml testing benchmark:
    make bench

## 2 Utils
#### Dependencies:
Adding new dependencies:

    poetry add <pip_package_name>
    
Updating all dependencies:

    make update
    
#### Other Makefile cmds:

