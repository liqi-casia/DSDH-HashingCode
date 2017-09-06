addpath ../matconvnet-1.0-beta23/matlab/
gpuDevice(1)
vl_setupnn;
for codelens=[12,24,32,48]
    for eta=55
        [B_dataset,B_test,map] = DSDH(codelens,eta);
    end
end
