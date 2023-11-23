start = [238 441];
N=5;
k=5;
goal=[336 363];
[black ,white,height,width] = map_definition();
GBur = generalised_bur(start,N,k,black,height,width);