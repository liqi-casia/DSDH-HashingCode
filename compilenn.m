gpuDevice(1)
addpath ../matconvnet-1.0-beta23/matlab;
vl_compilenn('enableGpu', true,'EnableImreadJpeg',false,'cudaRoot', '/usr/local/cuda-8.0','cudaMethod', 'nvcc');
