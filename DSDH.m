function [B_dataset,B_test,map] = DSDH(codelens,eta)
    %% prepare the dataset, if you already have the cifar-10.mat, then just commnet it. 
    data_prepare;
    %% load the pre-trained CNN
    net = load('imagenet-vgg-f.mat') ;
    %% load the Dataset
    load('cifar-10.mat') ;
    %% initialization
    maxIter = 150;
    lr = logspace(-2,-6,maxIter) ; %generate #maxIter of points between 10^(-2) ~ 10^(-6) 
    net = net_structure (net, codelens);
    U = zeros(size(train_data,4),codelens);
    B = zeros(size(train_data,4),codelens);
    %% training
    for iter = 1: maxIter
        [net,U,B] = train(train_data,train_L,U,B,net,iter,lr(iter),eta) ;
    end
    %% testing
    [map,B_dataset,B_test] = test(net, dataset_L, test_L,data_set, test_data );
    save(['DSDH_CIFAR_10_' num2str(codelens) 'bits.mat'],'B_dataset','B_test','dataset_L','test_L','map');
end
