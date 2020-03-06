using YaoBase
using YaoBlocks
using PyCall

export IBMQRegister

struct IBMQRegister{B} <: AbstractRegister{B}
    backend::PyObject
    qreg::PyObject
    creg::PyObject
end

function IBMQRegister{B}(n::Int;hub="ibm-q", project="main") where B
    provider = IBMQ.get_provider(hub=hub, project=project)
    backends = provider.backends(filters=
        py"lambda x: x.configuration().n_qubits == 5 and not x.configuration().simulator")
    backend = qiskit.providers.ibmq.least_busy(backends)
    return IBMQRegister{B}(backend, qiskit.QuantumRegister(n), qiskit.ClassicalRegister(n))
end

IBMQRegister(n::Int;hub="ibm-q", project="main") =
    IBMQRegister{1}(n;hub=hub, project=project)

YaoBase.nactive(r::IBMQRegister) = r.backend.configuration().n_qubits
YaoBase.nqubits(r::IBMQRegister) = r.backend.configuration().n_qubits

function YaoBlocks.apply!(r::IBMQRegister, circ::AbstractBlock)
end
