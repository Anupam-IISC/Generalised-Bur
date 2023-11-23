function gbur = generalised_bur(start,N,k,black,height,width)
root = start;
dc = find_min_distance(black,root);
bur = BUR(root,dc,N,height,width);

end

