function list = find_friend(index, L)
    global con_matrix
    friend_list = [];
    l = 1;
    while con_matrix(index, l) ~=0
        friend_list = [friend_list,con_matrix(index, l)];
        l = l + 1;
    end
    list = friend_list;
end