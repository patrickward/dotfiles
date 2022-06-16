# Ensure Go is in the path
if command -v go > /dev/null; then
  export GOPATH=$(go env GOPATH)
  export PATH="$GOPATH/bin:$PATH"
fi
