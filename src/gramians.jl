import ControlSystems: grampd, gram 

"""
    L = grampd(Σqo::QuadraticOutputStateSpace, opt::Symbol; kwargs...)

Returns a Cholesky factor `L` of the Gramian of system `Σqo`. 
If `opt` is `:c`, the controllability Gramian `P=L'*L` is computed. If `opt` is `:o` the observability Gramian `Q=L*L'` is computed.
"""
function grampd(Σqo::QuadraticOutputStateSpace, opt::Symbol; kwargs...)
    Σ = ss(Σqo)
    n = Σ.nx
    U = grampd(Σ, :c; kwargs...)
    if opt === :c 
        return U
    elseif opt === :o
        # return plyapc(Array(Σqo.A'), Σqo.M * U; kwargs...)
        return cholesky(lyapc(Σqo.A', Σqo.C'*Σqo.C + sum([reshape(Mi,n,n) * U*U' * reshape(Mi,n,n) for Mi ∈ eachrow(Σqo.M)]); kwargs...); check=false).U
    else
        error("opt must be either :c, :o")
    end
end

"""
    X = gram(Σqo::QuadraticOutputStateSpace, opt::Symbol; kwargs...)

Returns the Gramian of system `Σqo`. 
If `opt` is `:c` the controllability Gramian is computed. If `opt` is `:o` the observability Gramian is computed.
"""
function gram(Σqo::QuadraticOutputStateSpace, opt::Symbol; kwargs...)
    U = grampd(Σqo, opt; kwargs...)
    X = opt === :c ? U*U' : U'U
    Λ, U = eigen(hermitianpart(X))
    return hermitianpart(U * diagm(clamp.(Λ, 0, Inf)) * U')
end