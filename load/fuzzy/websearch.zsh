function ffgoo() {
    local query="$*"
    local count="${ffgoo_count:-${ffgoo_c:-30}}"

    setopt local_options
    setopt pipefail

    local fzf_cmd="$(cmd-sub fz fzf)"
    local memoi_cmd="$(cmd-sub memoi-eval '')"

    local search="$($memoi_cmd googler --json --count "$count" "$query")"
    local is i
    is=("${(@f)$(<<<$search jq -re '.[] | .title + " | " + .abstract + " | " + .metadata' |cat -n | SHELL=dash $fzf_cmd --multi --preview 'printf -- "%s " {}' --preview-window up:7:wrap --with-nth 2.. | awk '{print $1}')}") || return 1
    for i in $is[@] ; do
        i=$((i-1)) # jq is zero-indexed
        <<<$search jq -re ".[$i] | .url"
    done
}
