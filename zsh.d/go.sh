
#(( $+commands[go] )) || echo "go not installed" && return

# Configure our private repositories. By blacklisting personal and work repos.
export GOPRIVATE=${GOPRIVATE},github.com/azr

# allow doing cd gitlab.com/...
export CDPATH=$CDPATH:$(go env GOPATH)/src

# allow doing cd azr/...
export CDPATH=$CDPATH:$(go env GOPATH)/src/github.com

# allow doing cd in my projects
export CDPATH=$CDPATH:$(go env GOPATH)/src/github.com/azr

# add go as a binary
export PATH=$PATH:$(go env GOPATH)/bin
