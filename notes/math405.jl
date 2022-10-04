# -*- coding: utf-8 -*-
# +
# I'm assuming math405.jl is the same folder
# as Project.toml and Manifest.toml

if (length(DEPOT_PATH[1]) < 12) || (DEPOT_PATH[1][1:12] != "/julia_depot")
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

module MATH405 

using Plots, LaTeXStrings, FFTW, LinearAlgebra

function chebyshev_projection(N)
    t = range(0, pi, length=300)
    T = range(0, pi, length=N+1)
    plt = plot(cos.(t), sin.(t), lw=3, label ="", size=(500,300))
    for θ in T   
        plot!([cos(θ), cos(θ)], [sin(θ), 0.0], lw=2, c = :black, ls=:dash, label = "")
    end
    scatter!(cos.(T), sin.(T), ms=8, c=1, label = "")
    scatter!(cos.(T), 0*T, ms=8, c=2, label = "")
    xlabel!("Chebyshev Nodes")
    yticks!(Float64[])
    return plt
end 


function illustrate_trapezoidal(f, N)
    xp = range(0, 1, length=100)
    X = range(0, 1, length=N+1)
    plot(xp, f.(xp), lw=2, label = L"f", size = (500, 300))
    plot!(X, f.(X), lw=2, m = :o, ms=6, label = L"s_1")
end



function illustrate_midpoint(f, N)
    xp = range(0, 1, length=100)
    plot(xp, f.(xp), lw=2, label = L"f", size = (500, 300))
    X = range(0.5/N, 1-0.5/N, length=N)
    for x in X
        plot!([x-0.5/N, x+0.5/N], [f(x), f(x)], lw=2, c=2, label = (x==X[1] ? L"s_0" : ""))
    end
    scatter!(X, f.(X), ms=6, c=2, label = "")
end



"""
Compute interpolatory quadrature weights using the Vandermonde matrix. 
This is an unstable procedure and should normally NOT be used.
"""
function unstable_quad_weights(X) 
    N = length(X)-1
    V = [ x^n for x in X, n = 0:N ]
    return pinv(V)' * collect(1:N+1)
end



chebnodes(N) = 0.5 .+ 0.5 * cos.(range(0, π, length=N+1))

chebcoeffs(f, N) = fct(f.(chebnodes(N)))

function fct(A::AbstractVector)
    N = length(A)
    F = real.(ifft([A[1:N]; A[N-1:-1:2]]))
   return [[F[1]]; 2*F[2:(N-1)]; [F[N]]]
end

"""
Stable implementation of Clenshaw Curtis Quadrature 
"""

function stable_clenshaw_curtis(f, N)
    A = chebcoeffs(f, N) 
    W = zeros(length(A)); W[1:2:end] = 2 ./ (1 .- (0:2:N).^2) 
    return 0.5 * dot(W, A) 
end



using Images

"""
A basic utility function to plot sublevel sets.
"""
levelset(args...; kwargs...) = levelset!(plot(), args...; kwargs...)

function levelset!(plt, xlims, ylims, fs, s; col = nothing, label = "", xy=true, ngrid=400, sz = (300, 300), kwargs...)
    if fs isa Function
        fs = [fs,]
    end
    
    colors = Plots.get_color_palette(:default, 1)
    white = RGB(1,1,1)

    x = range(xlims[1], xlims[2], length=ngrid)
    y = range(ylims[1], ylims[2], length=ngrid)

    Nx = length(x); Ny = length(y)
    cols = fill(white, (Nx, Ny))
    
    for (c, f) in enumerate(fs)
        if length(fs) == 1 && col != nothing; c = col; end 
        for i = 1:Nx, j = 1:Ny
            z = f(x[i], y[j])
            if z < s 
                cols[j, i] = colors[c] 
            end 
        end
    end
    
    plt = plot(x, y, cols; size = sz, kwargs...)
    if xy
        hline!(plt, [0.0], c=:gray, lw=1, label = "")
        vline!([0.0], c=:grey, lw=1, label = "")
        annotate!(xlims[2], 0.02, text("Re(z)", :right, :bottom, :grey, 12))
        annotate!(0.04, ylims[2] - 0.5, text("Im(z)", :left, :top, :grey, 12))    
    end 

    return plt 
end

function rk4_step(u, f, h)
    k1 = h * f(u)
    k2 = h * f(u + 0.5 * k1)
    k3 = h * f(u + 0.5 * k2)
    k4 = h * f(u + k3)
    return u + k1/6 + k2/3 + k3/3 + k4/6
end


function illustrate_mol()
    X = range(0, 1, length=10)
    vline(X[:], lw=2, label = "")
    scatter!(X[:], 0*X[:], ms = 8, label = "", 
                  size = (400, 200), xlabel = L"x_n", ylabel = L"t",
                    yaxis = [-0.05, 2.5])
end


function illustrate_characteristicsR()
    plt = plot([-1, 2], [0,0]; c=:black, lw=2, label = "", 
                size = (400, 200), xlims = (-0.02, 1.02), ylims = (-0.02, 0.52), 
                xlabel = "x", ylabel = "t", title = L"a = 1")
    for x in -1:0.2:0.99 
        plot!([x, 2], [0, 2-x], c=1, lw=2, label = "")
    end 
    return plt
end



function illustrate_characteristics()
    plt = plot([0,0,1,1], [0.5,0,0,0.5], c=:black, lw=2, label = "", 
                size = (400, 200), xlims = (-0.02, 1.02), ylims = (-0.02, 0.52), 
                xlabel = "x", ylabel = "t", title = L"a = 1")
    for x in 0:0.2:0.99 
        plot!([x, 1], [0, 1-x], c=1, lw=2, label = "")
    end 
    for y in 0.2:0.2:0.5 
        plot!([0, 1], [y, y+1], c=1, lw=2, label = "")
    end
    return plt
end


function illustrate_fwdbwdstencils()
    illustrate_characteristicsR()
    vline!(0:0.2:1, c=:black, lw = 1, label = "")
    hline!(0:0.15:0.5, c=:black, lw = 1, label = "")
    plot!([0.2, 0.2, 0.4], [0.3, 0.15, 0.15], c=2, lw=3, ms=6, m = :o, label = L"D^+")
    plot!([0.8, 0.8, 0.6], [0.3, 0.15, 0.15], c=3, lw=3, ms=6, m = :o, label = L"D^-")
    plot!(; title = "Finite Difference Stencils", legend = :outertopright, size = (500, 250))
end


end
;


