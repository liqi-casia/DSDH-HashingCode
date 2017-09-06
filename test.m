function [map,B_dataset,B_test] = test(net, dataset_L, test_L,data_set, test_data )
    S = compute_S(dataset_L,test_L) ;
    [B_dataset, B_test] = compute_B (data_set,test_data,net) ;
    map = return_map (B_dataset, B_test, S) ;
end