module Qiskit

using PyCall

const qiskit = PyNULL()
const IBMQ = PyNULL()
const Aer = PyNULL()

function save_account(token)
    IBMQ.save_account(token)
end

function __init__()
    copy!(qiskit, pyimport("qiskit"))
    copy!(Aer, qiskit.Aer)
    copy!(IBMQ, qiskit.IBMQ)
end

include("register.jl")

end # module
