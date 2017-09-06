function S = compute_S (train_L,test_L)
    train_L = single(train_L) ;
    test_L = single(test_L) ;
    Dp = repmat(train_L,1,length(test_L)) - repmat(test_L',length(train_L),1);
    S = Dp == 0;
end