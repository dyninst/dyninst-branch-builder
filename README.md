# Dyninst Develop

This is a quick recipe to build dyninst from some random branch.
We use [this base container](https://github.com/dyninst/dyninst/pkgs/container/dyninst-ubuntu-20.04)
and we just need to build again. You can specify the branch of dyninst to use as follows:

```bash
$ docker build --build-arg DYNINST_BRANCH=kupsch/parse-callsites-preview -t ghcr.io/dyninst/dyninst-branch-builder:callsites .
```

The above would build Jim's branch for callsites, which I need in some reproducible way
to actually test it because Dyninst is a monster to build. If you have permission, you can
then push the container so others can use it:

```bash
$ docker push ghcr.io/dyninst/dyninst-branch-builder:callsites
```
The tag should be something related to the branch name, but  it's up to you.
These containers are typically for testing or development. Finally, make sure that you
visit the package page on GitHub and associate it with the repository here.
