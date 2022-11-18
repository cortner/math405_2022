README.md
# MATH 405/607E
# Numerical Methods for Differential Equations

<img src="files/Lshape.png" alt="banner" width="300"/>

[[Instructor: Christoph Ortner]](http://www.math.ubc.ca/~ortner/)
[[SYLLABUS]](files/syllabus-math405-2022.pdf)
[[PIAZZA]](https://canvas.ubc.ca/courses/103731/external_tools/201?display=borderless)

Questions about the course should normally be posted on [PIAZZA](https://canvas.ubc.ca/courses/103731/external_tools/201?display=borderless) so that the entire group can benefit from the discussion. Please email the instructor only in exceptional circumstances, e.g. when an issue is clearly private. 

[[PIAZZA SIGNUP]](https://piazza.com/ubc.ca/winterterm12022/math4051012022w1)

* Classes are Monday, Wednesday, Friday 1000-1100, West Mall Swing Space  (SWNG) Rm 107  
* Office hours: Monday 1330-1430 and Wed 1100-1200, LSK 303 
* **Midterm: 28/10**

## General Notes 

* You must have access to a [Jupyter](https://jupyter.org) + [Julia](https://julialang.org) environment to complete the assignments. I will provide some instructions on how you can set this up on your private machines, but the recommended and supported way is via a Jupyter Hub server provided by the mathematics department.
* There is a very nice [online textbook written by Toby Driscoll, Fundamentals of Numerical Computation.](https://fncbook.github.io/fnc/frontmatter.html). Although we won't use this book directly the general content and style are similar to MATH 405/607E. Student who would like to get a rough idea what this course will be like can take a look.
* Note there is `dev` branch which we use to test assignments and course notes before releasing them on the `main` branch. You are welcome to look, but DO NOT complete any assignment that hasn't yet been released on the `main` branch!

## Classes

[[Class Notes]](https://notability.com/n/8CcwbmTS3m9B2w6v6dQ~1)


- **Wed 7/9:** intro, admin,  L01, L02
- **Fri 9/9:** more intro, Julia setup, L02, L03 
- **Mon 12/9:** LU factorisation, L04 
- **Wed 14/9:** condition number, eigendecomposition, finish L04
- **Fri 16/9:** floating point arithmetic, L05 
- **Mon 19/9:** no class 
- **Wed 21/9:** Polynomial interpolation, L06 
- **Fri 23/9:** Polynomial interpolation L06, Quadrature L07
- **Mon 26/9:** Finished Quadrature L07
- **Wed 28/9:** Nonlinear equations L08 
- **Fri 30/9:** no class - Truth and reconciliation day
- **Mon 3/10:** Nonlinear systems; [notes on Newton's method](https://notability.com/n/1f5jQ30pG2Cc1qLZe0ZHQ3)
- **Wed 5/10:** Initial value problems, Euler method, L09
- **Fri 7/10:** Initial value problems, Runge Kutta Methods 
- **Mon 10/10:** no class - Thanksgiving
- **Wed 12/10:** Polynomial regression with Ruo Ning Qiu
- **Fri 14/10:** A0, A1 revision class with Ruo Ning Qiu
- **Mon 17/10:** Review of consistency and stability; see [class notes](https://notability.com/n/8CcwbmTS3m9B2w6v6dQ~1) and also my [Notes on Gronwall Inequalities](https://notability.com/n/2X77ioz2K0ashri7MjBVJV)
- **Wed 19/10:** Dissipative systems, Regions of stability, L10
- **Fri 21/10:** Hamiltonian Systems, energy conservation, L11 
- **Mon 24/10:** 2-point BVPs; L12a, see [class notes](https://notability.com/n/8CcwbmTS3m9B2w6v6dQ~1) and my [notes on 2pt-bvp](https://notability.com/n/1hTItCHXW73ANx0yeE1TxF) 
- **Wed 26/10:** BVPs ctd; L12a, L12b and [class notes](https://notability.com/n/8CcwbmTS3m9B2w6v6dQ~1)
- **Fri 28/10:** Midterm 
- **Mon 31/10:** PDEs, diffusion L13
- **Wed 2/11:** review Fourier analysis; see [class notes](https://notability.com/n/8CcwbmTS3m9B2w6v6dQ~1) and my [notes on Fourier analysis](https://notability.com/n/0BwxN5dI8CFd2GXqqsfmeu)
- **Fri 4/11:** PDEs, diffusion L13 and advection, L14  
- **Mon 7/11:** PDEs, advection, L14 
- **Wed 9/11 and Fri 11/11:** midterm break 
- **Mon 14/11 and Wed 16/11:** Spectral methods, approximation, L15 and [notes](https://notability.com/n/0MTNF2R5h0tdg9N0C_yrA8)
- **Fri 18/11 and Mon 21/11:** Spectral methods, PDEs, L16 and [notes](https://notability.com/n/zbdgBhZWEqcIm_4GNwZ5x)
- **Wed 23/11 to Fri 2/12:** Project Presentations
- **Mon 7/11 and Wed 7/11:** revision


<!-- NOTES for future : 
- overall the timing was quite good 
- L10 was a bit longer than 1 50 min lecture; this was dobale but borderline
- L11 was a bit shorter
- should spend a bit of time on Gronwall inequalities and maybe also the stable case 
-->

## Gallery 

<img src="files/Lshape_formula.png" width="200" />
<img src="files/Lshape.png" width="300" />

The course "cover image" is the famous Matlab logo. It is the solution of a second-order partial differential boundary value problem on an L-shaped domain.

<img src="files/advection_formula.png" width="200" />
<img src="files/advection.gif" width="300" />

In the image above we see the numerical solution of an advection equation using an UNSTABLE numerical method. In this course we will learn to recognize and avoid such pitfalls.

<img src="files/kdv_formula.png" width="200" />
<img src="files/kdv.gif" width="300" />

We will learn how to construct "spectral methods" to obtain high-accuracy solutions of highly nonlinear PDEs in only a handful of lines of code. Above the Korteveg-deVries equation and below the Cahn-Hilliard equation (modelling phase separation of binary fluids)

<img src="files/cahnhilliard_formula.png" width="200" />
<img src="files/cahnhilliard.gif" width="300" />

