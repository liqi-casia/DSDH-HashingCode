function [net, U, B] = train (X1, L1, U, B, net, iter ,lr,eta)
    N = size(X1,4) ;
    batchsize = 128 ;
    index = randperm(N) ;
    for j = 0:ceil(N/batchsize)-1
        batch_time=tic ;
        %% random select a minibatch
        ix = index((1+j*batchsize):min((j+1)*batchsize,N)) ;
        S = calcNeighbor (L1, ix, 1:N) ;
        %% load and preprocess an image
        im = X1(:,:,:,ix) ;
        im_ = single(im) ; % note: 0-255 range
        im_ = imresize(im_, net.meta.normalization.imageSize(1:2)) ;
        im_ = im_ - repmat(net.meta.normalization.averageImage,1,1,1,size(im_,4)) ;
        im_ = gpuArray(im_) ;
        %% run the CNN
        res = vl_simplenn(net, im_) ;
        U0 = squeeze(gather(res(end).x))' ;
        U(ix,:)  = U0 ;
        B(ix,:) = sign(U0) ;
         
        label = L1+1; 
        batchLabel = label(ix);
        if isvector(batchLabel) 
            batchY = sparse(1:length(batchLabel), double(batchLabel), 1); 
            batchY = full(batchY);
        else
            batchY = batchLabel;
        end    
        lambda=0.1;
        batchB=sign(U0);
        [Wg, ~, ~] = RRC(batchB, batchY, lambda);   
        Q = eta*U0 + batchY*Wg';            
        batchB = zeros(size(batchB));          
        for time = 1:10           
               Z0 = batchB;
                for k = 1 : size(batchB,2)
                    Zk = batchB; Zk(:,k) = [];
                    Wkk = Wg(k,:); Wk = Wg; Wk(k,:) = [];                    
                    batchB(:,k) = sign(Q(:,k) -  Zk*Wk*Wkk');
                end
                
                if norm(batchB-Z0,'fro') < 1e-6 * norm(Z0,'fro')
                    break
                end
         end
              
        T = U0 * U' / 2 ;
        A = 1 ./ (1 + exp(-T)) ; 
        dJdU = (S - A) * U - 2*eta*(U0-batchB) ;       
        dJdoutput = gpuArray(reshape(dJdU',[1,1,size(dJdU',1),size(dJdU',2)])) ;
        res = vl_simplenn(net, im_, dJdoutput) ;
        %% update the parameters of CNN
        net = update(net , res, lr, N) ;
        batch_time = toc(batch_time) ;
        fprintf(' iter %d  batch %d/%d (%.1f images/s) ,lr is %d\n', iter, j+1,ceil(size(X1,4)/batchsize), batchsize/ batch_time,lr) ;
    end
end
