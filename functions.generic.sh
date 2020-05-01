# mkdir something && cd something
function mkd() { mkdir -p "$@" && cd "$_"; }
