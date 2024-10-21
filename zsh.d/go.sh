# Ensure Go is installed and set up the PATH
if ! (( $+commands[go] )); then
    echo "go not installed"
    return
fi

# Add Go binary paths
test -r /usr/local/go/bin && export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$(go env GOPATH)/bin

# Configure our private repositories by blacklisting personal and work repos
export GOPRIVATE=${GOPRIVATE},github.com/azr

# Allow doing cd gitlab.com/...
export CDPATH=$CDPATH:$(go env GOPATH)/src

# Allow doing cd azr/...
export CDPATH=$CDPATH:$(go env GOPATH)/src/github.com

# Allow doing cd in my projects
export CDPATH=$CDPATH:$(go env GOPATH)/src/github.com/azr
