#!/bin/bash

# Gazelle can automatically generate and maintain bazel BUILD files and dependencies.
bazel run //:gazelle -- update-repos --from_file=go.mod -to_macro=repositories.bzl%go_repositories
bazel run //:gazelle -- fix

# gazelle does not yet support aliasing in go.mod
# we need to manually carry on that aliasing ourselves.
sed "s/@com_github_dkales_dpf_go\/\/dpf:go_default_library/\/\/modules\/dpf-go\/dpf:dpf/g" -i modules/dpf-go/BUILD.bazel pir/BUILD.bazel
sed "s/checklist\/modules\/dpf-go\/dpf/github.com\/dkales\/dpf-go\/dpf/g" -i modules/dpf-go/dpf/BUILD.bazel

# link against lstdc++ instead of -static-libstdc++.
sed "s/-static-libstdc++/-lstdc++/g" -i psetggm/BUILD.bazel
