function [B_dataset, B_test]=compute_B (data_set,test_data,net)
    batchsize = 128;
    for j = 0:ceil(size(data_set,4)/batchsize)-1
        im = data_set(:,:,:,(1+j*batchsize):min((j+1)*batchsize,size(data_set,4))) ;
        im_ = single(im) ; % note: 0-255 range
        im_ = imresize(im_, net.meta.normalization.imageSize(1:2)) ;
        im_ = im_ - repmat(net.meta.normalization.averageImage,1,1,1,size(im_,4)) ;
        im_ = gpuArray(im_) ;
        % run the CNN
        res = vl_simplenn(net, im_) ;
        features = squeeze(gather(res(end).x))' ;
        U_train((1+j*batchsize):min((j+1)*batchsize,size(data_set,4)),:) = features ;
    end
    for j = 0:ceil(size(test_data,4)/batchsize)-1
        im = test_data(:,:,:,(1+j*batchsize):min((j+1)*batchsize,size(test_data,4))) ;
        im_ = single(im) ; % note: 0-255 range
        im_ = imresize(im_, net.meta.normalization.imageSize(1:2)) ;
        im_ = im_ - repmat(net.meta.normalization.averageImage,1,1,1,size(im_,4)) ;
        im_ = gpuArray(im_) ;
        % run the CNN
        res = vl_simplenn(net, im_) ;
        features = squeeze(gather(res(end).x))' ;
        U_test((1+j*batchsize):min((j+1)*batchsize,size(test_data,4)),:) = features ;
    end
    B_dataset = U_train > 0 ;
    B_test = U_test > 0 ;
end