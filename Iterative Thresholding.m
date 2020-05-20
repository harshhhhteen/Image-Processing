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
## @deftypefn {} {@var{delta} =} iterativeThreshold (@var{input})
##
## @seealso{}
## @end deftypefn

## Author: Harshit <harshhhhteen@Lenovo-ideapad-310-15IKB>
## Created: 2020-05-20

function delta = iterativeThreshold (input)
%input- is the 2D grayscale image matrix
%delta- is the return threshold value
  [n,m] = size(input);
  u1 = (input(1,1)+input(1,m)+input(n,1)+input(n,m))/4;
  u2 = 0;
  for i = 1:n
    for j = 1:m
      if !((i==1 || i==n) && (j==1 || j==m))
        u2 = u2 + input(i,j);
      endif
    endfor
  endfor
  u2 = u2/(n*m - 4);
  t_old = 0;
  t_new = (u1 + u2)/2;
  while t_new != t_old
    u1 = 0;
    u2 = 0;
    count1 = 0;
    count2 = 0;
    for i = 1:n
      for j = 1:m
        if input(i,j) < t_new
          u1 = u1 + input(i,j);
          count1++;
        else
          u2 = u2 + input(i,j);
          count2++;
        endif
      endfor
    endfor
    u1 = u1/count1;
    u2 = u2/count2;
    t_old = t_new;
    t_new = (u1 + u2)/2;
  endwhile
  delta = t_new;
endfunction
