MYDIR="${${0:#$ZSH_ARGZERO}:-${(%):-%N}}"
MYDIR="${${(M)MYDIR:#/*}:-$PWD/$MYDIR}"
function night-source() {
    local dir="${2:-$MYDIR/load}"
    local file="$dir/$1.zsh"
    if test -e "$file" ; then
        source "$file"
    else
        print -nr -- "$0: File '$file' not found." >&2
    fi
}
##
if test -z "$night_plugins[*]" ; then
    night_plugins=( fuzzy/websearch )
fi
night-source compat-suite
local plugin
for plugin in "$night_plugins[@]" ; do
    night-source "$plugin"
done
##
