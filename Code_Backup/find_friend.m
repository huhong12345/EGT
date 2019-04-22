function list = find_friend(index, k)
    global friend_matrix
    friend_list = zeros(4,k);
    if  



    l = 1;
    while friend_matrix(index, l) ~=0
        friend_list = [friend_list,friend_matrix(index, l)];
        l = l + 1;
    end
    list = friend_list;
end


