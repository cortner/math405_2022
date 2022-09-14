# -*- coding: utf-8 -*-
# +
# I'm assuming math405.jl is the same folder
# as Project.toml and Manifest.toml

# TODO: PATH COULD BE LESS THAN 12 DIGITS!
if length(DEPOT_PATH[1] >= 12) || (DEPOT_PATH[1][1:12] != "/julia_depot")
    @info("""You are not running in the `math405` Jupyter Hub environment. 
             I'm therefore activating the local environment.
             Make sure you know what you are doing! If this is unintentional 
             then get in touch with your instructor to get help.""") 
    import Pkg 
    Pkg.activate(@__DIR__())  
end

using Plots
using ForwardDiff
using LinearAlgebra
using LaTeXStrings
using BenchmarkTools
using SpecialFunctions
using Printf
using PrettyTables
using Logging
# using OrdinaryDiffEq
using StaticArrays
using SparseArrays
using Random 
using Test
using NLsolve
using Roots

# module MATH405 

# using Plots, LaTeXStrings

# function __copy_env__()
#     run(`cp /Users/ortner/gits/math405/math405.jl ./`)
#     run(`cp /Users/ortner/gits/math405/Project.toml ./`)
#     run(`cp /Users/ortner/gits/math405/Manifest.toml ./`)
# end

# function chebyshev_projection(N)
#     t = range(0, pi, length=300)
#     T = range(0, pi, length=N+1)
#     plt = plot(cos.(t), sin.(t), lw=3, label ="", size=(500,300))
#     for θ in T   
#         plot!([cos(θ), cos(θ)], [sin(θ), 0.0], lw=2, c = :black, ls=:dash, label = "")
#     end
#     scatter!(cos.(T), sin.(T), ms=8, c=1, label = "")
#     scatter!(cos.(T), 0*T, ms=8, c=2, label = "")
#     xlabel!("Chebyshev Nodes")
#     yticks!(Float64[])
#     return plt
# end 


# function illustrate_trapezoidal(f, N)
#     xp = range(0, 1, length=100)
#     X = range(0, 1, length=N+1)
#     plot(xp, f.(xp), lw=2, label = L"f", size = (500, 300))
#     plot!(X, f.(X), lw=2, m = :o, ms=6, label = L"s_1")
# end



# function illustrate_midpoint(f, N)
#     xp = range(0, 1, length=100)
#     plot(xp, f.(xp), lw=2, label = L"f", size = (500, 300))
#     X = range(0.5/N, 1-0.5/N, length=N)
#     for x in X
#         plot!([x-0.5/N, x+0.5/N], [f(x), f(x)], lw=2, c=2, label = (x==X[1] ? L"s_0" : ""))
#     end
#     scatter!(X, f.(X), ms=6, c=2, label = "")
# end


# """
# A basic utility function to plot sublevel sets. I've tested this with GR, Plotly and PyPlot. 
# Only PyPlot appears to produce the desired result. Turn on the PyPlot backend by calling 
# `Plots.pyplot()`
# """
# levelset(args...; kwargs...) = levelset!(plot(), args...; kwargs...)

# function levelset!(plt, xlims, ylims, fs, s; label = "", xy=true, ngrid=100, kwargs...)
#     if Plots.backend_name() != :pyplot 
#         @warn("""This function has so far only been tested with the pyplot backend. 
#                  Please switch backend by calling Plots.pyplot()""")
#     end
#     f1 = (x, y) -> max(s-0.1, min(s+0.1, f(x,y)))
#     plt = plot(; xaxis = [xlims...], yaxis = [ylims...])

#     if fs isa Function 
#         fs = [fs]
#         label = [label]
#     end

#     x = range(xlims[1], xlims[2], length=ngrid)
#     y = range(ylims[1], ylims[2], length=ngrid)
#     o = ones(length(x))
#     X = x * o' 
#     Y = o * y'
#     x_ =  [xlims[2]+1, xlims[2]+2]
#     y_ = [0,0]

#     for (c, (f, lab)) in enumerate(zip(fs, label))
#         contour!(plt, X, Y, f.(X,Y); label = "", size=(300,300),levels = [-1e300, s], c = c, lw=3, colorbar=false, fill=true, kwargs...)
#         plot!(x_, y_, lw=3, c=c, label = lab)
#     end 
    
#     if xy
#         hline!(plt, [0.0], c=:gray, lw=1, label = "")
#         vline!([0.0], c=:grey, lw=1, label = "")
#         annotate!(xlims[2], 0.02, text("Re(z)", :right, :bottom, :grey, 12))
#         annotate!(0.04, ylims[2], text("Im(z)", :left, :top, :grey, 12))    
#     end 
    
#     return plt
# end


# function rk4_step(u, f, h)
#     k1 = h * f(u)
#     k2 = h * f(u + 0.5 * k1)
#     k3 = h * f(u + 0.5 * k2)
#     k4 = h * f(u + k3)
#     return u + k1/6 + k2/3 + k3/3 + k4/6
# end


# function illustrate_mol()
#     X = range(0, 1, length=10)
#     vline(X[:], lw=2, label = "")
#     scatter!(X[:], 0*X[:], ms = 8, label = "", 
#                   size = (400, 200), xlabel = L"x_n", ylabel = L"t",
#                     yaxis = [-0.05, 2.5])
# end


# function illustrate_characteristicsR()
#     plt = plot([-1, 2], [0,0]; c=:black, lw=2, label = "", 
#                 size = (400, 200), xlims = (-0.02, 1.02), ylims = (-0.02, 0.52), 
#                 xlabel = "x", ylabel = "t", title = L"a = 1")
#     for x in -1:0.2:0.99 
#         plot!([x, 2], [0, 2-x], c=1, lw=2, label = "")
#     end 
#     return plt
# end



# function illustrate_characteristics()
#     plt = plot([0,0,1,1], [0.5,0,0,0.5], c=:black, lw=2, label = "", 
#                 size = (400, 200), xlims = (-0.02, 1.02), ylims = (-0.02, 0.52), 
#                 xlabel = "x", ylabel = "t", title = L"a = 1")
#     for x in 0:0.2:0.99 
#         plot!([x, 1], [0, 1-x], c=1, lw=2, label = "")
#     end 
#     for y in 0.2:0.2:0.5 
#         plot!([0, 1], [y, y+1], c=1, lw=2, label = "")
#     end
#     return plt
# end


# function illustrate_fwdbwdstencils()
#     illustrate_characteristicsR()
#     vline!(0:0.2:1, c=:black, lw = 1, label = "")
#     hline!(0:0.15:0.5, c=:black, lw = 1, label = "")
#     plot!([0.2, 0.2, 0.4], [0.3, 0.15, 0.15], c=2, lw=3, ms=6, m = :o, label = L"D^+")
#     plot!([0.8, 0.8, 0.6], [0.3, 0.15, 0.15], c=3, lw=3, ms=6, m = :o, label = L"D^-")
#     plot!(; title = "Finite Difference Stencils", legend = :outertopright, size = (500, 250))
# end


# end
# ;


# -


