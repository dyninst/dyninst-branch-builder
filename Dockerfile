ARG dyninst_base=ghcr.io/dyninst/dyninst-ubuntu-20.04:latest
FROM ${dyninst_base}

# docker build --build-arg dyninst_base=ghcr.io/dyninst/dyninst-ubuntu-20.04:latest -f Dockerfile.test -t dyninst-test ../
# docker build --build-arg DYNINST_BRANCH=kupsch/parse-callsites-preview-2 -t ghcr.io/dyninst/dyninst-branch-builder:callsites-2 .

# Ensure the package file with branch "dev" is added
COPY ./package.py /opt/spack/var/spack/repos/builtin/packages/dyninst/package.py

# Set the branch name for spack to use
ARG DYNINST_BRANCH=master
ENV DYNINST_BRANCH=${DYNINST_BRANCH}

WORKDIR /
RUN rm -rf /code && \
    git clone -b ${DYNINST_BRANCH} https://github.com/dyninst/dyninst /code && \
    cd /code && \

    # Be consistent in branch name so we don't need to update below
    git checkout -b dev ${DYNINST_BRANCH} && \    
    . /opt/spack/share/spack/setup-env.sh && \
    spack env activate . && \
    spack remove dyninst && \
    spack add dyninst@dev && \
    
# Previous WORKDIR, just to be careful - reinstall dyninst if needed
# Thenbuild and run the test suite
WORKDIR /opt/dyninst-env
RUN /bin/bash /opt/dyninst-env/build.sh
