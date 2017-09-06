function map = return_map(B_train, B_test, S)
    [~, orderH] = calcHammingRank (B_train, B_test) ;    
    map = calcMAP(orderH,S');
end