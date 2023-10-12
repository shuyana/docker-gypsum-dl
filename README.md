# Docker Image for Gypsum-DL

## Usage

```bash
docker run --pull always --rm -it --privileged -e UID=$(id -u) -e GID=$(id -g) -v $(pwd):/home/user/workspace -w /home/user/workspace ghcr.io/shuyana/docker-gypsum-dl \
    --source input.smi \
    --output_folder output \
    --separate_output_files \
    --max_variants_per_compound 1 \
    --use_durrant_lab_filters \
    --job_manager mpi
```
