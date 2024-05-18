FROM condaforge/miniforge3:23.3.1-1

ENV DEBIAN_FRONTEND="noninteractive"

SHELL ["/bin/bash", "-c"]

ENV LANG="en_US.UTF-8"
ENV LANGUAGE="en_US.UTF-8"
ENV LC_ALL="en_US.UTF-8"
RUN apt-get update \
    && apt-get install --no-install-recommends -y \
        language-pack-en \
        locales \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && locale-gen en_US.UTF-8

RUN apt-get update \
    && apt-get install --no-install-recommends -y \
        gosu \
        openmpi-bin \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ENV PATH="/opt/conda/bin:$PATH"
RUN conda install -y -c conda-forge \
        python=3.11 \
        rdkit=2024.3.2 \
        numpy=1.26.4 \
        scipy=1.13.0 \
        mpi4py=3.1.6 \
    && conda clean --all --force-pkgs-dirs --yes

ENV PYTHONPATH="/opt/gypsum_dl:${PYTHONPATH}"
RUN git clone https://github.com/durrantlab/gypsum_dl.git /opt/gypsum_dl

RUN adduser --disabled-password --gecos "" user

COPY --chmod=755 entrypoint.sh /usr/local/bin
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
