if [[ -d /opt/homebrew ]]; then
    export PATH="/opt/homebrew/bin:$PATH"
    export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
    export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"
    export PATH="/opt/homebrew/opt/grep/libexec/gnubin:$PATH"
fi
[[ -d '@homeDirectory@/.local/bin' ]] && export PATH="@homeDirectory@/.local/bin:$PATH"
