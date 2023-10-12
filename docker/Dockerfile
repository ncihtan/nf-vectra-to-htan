# Following:
# https://pythonspeed.com/articles/conda-docker-image-size/

# The build-stage image:
FROM continuumio/miniconda3 AS build

# File Author / Maintainer
LABEL maintainer="Adam Taylor <adam.taylor@sagebase.org>"

# Install the package as normal:
COPY environment.yml .
RUN conda env create -f environment.yml

# Install conda-pack:
RUN conda install -c conda-forge conda-pack

# Use conda-pack to create a standalone enviornment
# in /venv:
RUN conda-pack -n ome -o /tmp/env.tar && \
  mkdir /venv && cd /venv && tar xf /tmp/env.tar && \
  rm /tmp/env.tar

# We've put venv in same path it'll be in final image,
# so now fix up paths:
RUN /venv/bin/conda-unpack

# The runtime-stage image; we can use Debian as the
# base image since the Conda env also includes Python
# for us.
FROM python:3.11-slim as runtime

SHELL ["/bin/bash", "-c"]

RUN apt-get update

# Copy /venv from the previous stage:
COPY --from=build /venv /venv

RUN source /venv/bin/activate

ENV VIRTUAL_ENV=/venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
