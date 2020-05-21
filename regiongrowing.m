## Copyright (C) 2020 Harshit
## 
## This program is free software: you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful, but
## WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see
## <https://www.gnu.org/licenses/>.

## -*- texinfo -*- 
## @deftypefn {} {@var{regions} =} regiongrowing (@var{input}, @var{delta},@var{seedList}, @var{neighbour})
##
## @seealso{}
## @end deftypefn

## Author: Harshit <harshhhhteen@Lenovo-ideapad-310-15IKB>
## Created: 2020-05-20

function regions = regiongrowing (input, delta, seedList, neighbour)
%input- is the 2D grayscale image matrix
%delta- threshold value
%seedList- nx2 matrix, having initial seeds. n is number of seeds. First column is x co-ordinate and second column is y coordinate
%neigbour- accepted values 4 or 8
%regions is 3D matrix where each plane represent a region of input image
  [n,m] = size(input);
  number_of_seed = size(seedList)(1);
  regions = zeros(number_of_seed,n,m);
  regions_binary = zeros(number_of_seed,n,m);
  region_boundary =  zeros(number_of_seed,2*(n+m),2);
  region_boundary_size = ones(1, number_of_seed);
  region_size = ones(1, number_of_seed);
  for i = 1:number_of_seed
    region_boundary(i,1,1) = seedList(i,1);
    region_boundary(i,1,2) = seedList(i,2);
  endfor
  u = [];
  for i = 1:number_of_seed
    regions(i,region_boundary(i,1,1),region_boundary(i,1,2)) = input(region_boundary(i,1,1),region_boundary(i,1,2));
    regions_binary(i,region_boundary(i,1,1),region_boundary(i,1,2)) = 1;
    u(i) = input(region_boundary(i,1,1),region_boundary(i,1,2));
  endfor
  surr = [-1 0; 1 0; 0 -1; 0 1; 1 1; -1 1; -1 -1; 1 -1];
  t = 1;
  while t == 1
    t = 0;
    for i = 1:number_of_seed
      j = 1;
      while j <= region_boundary_size(i)
        for k = 1:neighbour
          x = region_boundary(i,j,1) + surr(k,1);
          y = region_boundary(i,j,2) + surr(k,2);
          if x<=n && x>0 && y<=m && y >0 && regions_binary(i,x,y) == 0 && abs(input(x,y)-u(i)) <= delta
            regions_binary(i,x,y) = 1;
            regions(i,x,y) = input(x,y);
            u(i) = u(i)*region_size(i);
            region_size(i)++;
            u(i) = u(i)+input(x,y);
            u(i) = u(i)/region_size(i);
            t = 1;
            flag = x==n || y==m || x==1 || y==1;
            f = 1;
            while f <= neighbour  && !flag
              flag = flag || regions_binary(i,x+surr(f,1),y+surr(f,2))==0;
              f++;
            endwhile
            if flag
              region_boundary_size(i)++;
              region_boundary(i,region_boundary_size(i),:) = [x y];
            endif
          endif
        endfor
        j++;
      endwhile
    endfor
  endwhile
endfunction

