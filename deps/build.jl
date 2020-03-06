using PyCall

py"""
import sys
import subprocess
try:
    import qiskit
except ImportError as e:
    subprocess.check_call([sys.executable, "-m", "pip", "install", "qiskit"])
"""
