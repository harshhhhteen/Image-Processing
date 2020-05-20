# Image-Processing

## Segmentation
- Non Contextual
  - Iterative Thresholding
- Contextual
  - Region Growing
  
## Iterative Thresholding

Iterative Threshold Selection Function implemented in OCTAVE, will also work in MATLAB

##### Algorithm
````
Compute μ1, the mean grey level of the corner pixels
Compute μ2, the mean grey level of all other pixels
T_old = 0
T_new = (μ1 + μ2)/2
while T_new ≠ T_old do
  μ1 = mean grey level of pixels for which f(x,y) < T_new
  μ2 = mean grey level of pixels for which f(x,y) ≥ T_new
  T_old = T_new
  T_new = (μ1 + μ2)/2
end while
````

## Region Growing

Region Growing Segementation Function implemented in OCTAVE, will also work in MATLAB


Region growing is a bottom up approach that starts with a set of seed pixels. Each seed will then grow up to a uniform region by adding pixels where a pixel to be added to the region iff

1. The pixel has not been assigned to any region

2. The pixel is a neighbor of that region

3. The new region created by addition of the pixel is still uniform

###### Algorithm
````
Let f be an image for which regions are to be grown  
Define a set of regions, R1, R2...Rn, each consisting of a single seed pixel  
repeat
  for i=1 to n do
    for each pixel, p, at the border of Ri do
      for all neighbours of p do
        Let x,y be the neighbour's coordinates
        Let μ[i] be the mean grey level of pixels in Ri
        if the neighbour is unassigned and |f(x,y)-μ[i]| ≤ Δ then
          Add neighbour to Ri
          Update μ[i]
        end if  
      end for  
    end for  
  end for  
until no more pixels are being assigned to regions  
````
