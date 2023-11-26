# matlabComplexGraphing
Project for Math/Cs 371 computational problem solving. 
For this project, we are graphing complex-valued functions in multiple ways and packaging them together in a Matlab app.
Once this is released, feel free to use it however you wish.

To use the main app, just launch ComplexGraphing.mlapp inside the FinalApp folder (make sure you have advanced.mlapp in the same directory). Then you can do the following things:
* Enter your own functions by typing in the box at the bottom after
  - Changing the resolution by typing in the box in the top right (1000 is a good number)
  - adding scale, so you aren't zoomed in on one point (10 for each is good)
* Change where in the graph you are looking by toggling the "move center" button
  - (to move the center, simply type the real and imaginary offset (positive direction) into the box)
* Use special functions such as the gamma and zeta function, by using the drop down box on the right.

To use the complex surface, which is not currently in the app, do the following:
* for all input styles, you'll need to edit the function manually in the script
  - Scroll down to the line that says Z = @(z) ... to do this, just edit what comes after the @(z)
  
 * There are 4 input styles for when you call the function
  - 2 inputs (res, scale) 
    - res changes the resoluton, a higher number is a "finer" graph
    - scale changes the area of the function shown, if a value of 5 is put for this, it'll show the function from [-5, 5] and [-5i, 5].
   - 3 inputs, no vector (res, scaleX, scaleY)
     - res does the same thing
     - scaleX changes the real axis, so a value of 2 make the corrosponding x or y range from either [-5, 5] or [-5i, 5i] depending on which graph you are considering
     - scaleY does the same thing, but for y
   -  3 inputs, vector (res, scale, [zMin zMax])
     - res and scale do the same things as in 2 inputs
     - zMin and zMax set the minimum and maximum z values shown
    - 4 inputs (res, scaleX, scaleY, [zMin zMax]
      - Each of the inputs do the same thing as previously stated
    
If you want to access the code without the app, some of the raw code (which was rewritten inside the app) can be found in the src folder.
 
Gabriel Cammack-Coleman\
Cameron Miller\
Brycen Daniels
