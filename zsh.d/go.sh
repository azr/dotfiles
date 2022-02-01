
command go || return

# Configure our private repositories. By blacklisting personal and work repos.
export GOPRIVATE="github.com/azr,github.com/hashicorp"

# allow doing cd gitlab.com/...
export CDPATH=$CDPATH:$(go env GOPATH)/src

# allow doing cd azr/...
export CDPATH=$CDPATH:$(go env GOPATH)/src/github.com

# add go as a binary
export PATH=$PATH:$(go env GOPATH)/bin
