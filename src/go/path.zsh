# Ensure Go is in the path
if command -v go > /dev/null; then
  export GOPATH=$(go env GOPATH)
  export PATH="$GOPATH/bin:$PATH"
  export GOPRIVATE=github.com/pixiesys/*,github.com/minsoft-io/*,github.com/patrickward/*,github.com/warpware/*
fi
