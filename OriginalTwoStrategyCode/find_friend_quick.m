function list = find_friend_quick(index)
    global con_matrix
    friend_list = [];
    number = 1;
    while con_matrix(index,number)~=0
        friend_list = [friend_list, con_matrix(index,number)];
        number = number + 1;
    end
    list = friend_list;
end