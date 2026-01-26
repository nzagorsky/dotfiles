alias cp='cp -i' # confirm before overwriting something
alias cya='systemctl suspend'
alias senv='export $(xargs < .env)'
alias df='df -h'     # human-readable sizes
alias free='free -m' # show sizes in MB
alias grep='grep --color=tty -d skip'
alias la='eza -la'
alias ll='eza -lhs size'
alias lll='eza -lhs size'
alias lla='eza -lahs size'
alias ls='eza'
alias p='ipython'
alias e='emacs -nw'
alias g=git
alias v=nvim
alias reset_shell='env -i HOME="$HOME" zsh -l'
alias lofimpv='mpv --no-video "https://www.youtube.com/watch?v=jfKfPfyJRdk"'
alias wowmpv='mpv --no-video "https://www.youtube.com/Meisio/live"'
alias gdiff="git diff"
alias git_search_all="g log --all -p --source -G"
alias gpull="git pull"
alias gst="git status"
alias macflushdns="sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder"
alias macdns="scutil --dns | egrep -i '(domain|nameserver)'"
alias maclaunchrebuild="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user"
alias macncdu="ncdu --exclude /System/Volumes/Data --exclude $HOME/Documents -x /"
alias reset_xcode_previews="xcrun simctl --set previews delete all"
alias rclone="rclone -P"
alias telepresence_reconnect="telepresence quit && sleep 2 && telepresence connect"
alias tf="terraform"
alias oc="opencode"
alias ocweb="opencode web --hostname 0.0.0.0"

# K8s
alias k='kubectl'
alias kd='kubectl describe'
alias kg='kubectl get'
alias kl='kubectl logs'
alias klf='kubectl logs -f'
alias ke='kubectl exec'
alias kgn='kubectl get nodes'
alias kgns='kubectl get namespaces'

alias kda='kubectl describe --all-namespaces'
alias kga='kubectl get --all-namespaces'

alias kgp='kubectl get pod'
alias kdp='kubectl describe pod'
alias kgd='kubectl get deployment'
alias kdd='kubectl describe deployment'
alias kgs='kubectl get service'

alias kgpa='kubectl get pod --all-namespaces'
alias kgda='kubectl get deployment --all-namespaces'
alias kgsa='kubectl get svc --all-namespaces'

alias kcuc='kubectl config use-context'
alias kcur='kubectl config current-context'
alias kshell='kubectl run tmp-shell --rm -it --restart=Never --image=alpine sh'

# Columns for piping
# Example: cat test.txt | c2 | xargs echo
alias c1="awk '{print \$1}'"
alias c2="awk '{print \$2}'"
alias c3="awk '{print \$3}'"
alias c4="awk '{print \$4}'"
alias c5="awk '{print \$5}'"
alias c6="awk '{print \$6}'"
alias c7="awk '{print \$7}'"
alias c8="awk '{print \$8}'"
alias c9="awk '{print \$9}'"

alias ...="../../"
alias ....="../../../"
alias .....="../../../../"
