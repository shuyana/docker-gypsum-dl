#!/bin/bash -eu

groupmod -g ${GID:-9001} -o user &>/dev/null
usermod -u ${UID:-9001} -d /home/user -m -o user &>/dev/null
if [[ "$@" =~ --job_manager[[:space:]]mpi ]]; then
    physical_cores=$(grep '^core id' /proc/cpuinfo | sort -u | wc -l)
    exec gosu user mpirun -n ${NPROC:-${physical_cores}} python3 -m mpi4py /opt/gypsum_dl/run_gypsum_dl.py "$@"
else
    exec gosu user python3 /opt/gypsum_dl/run_gypsum_dl.py "$@"
fi
