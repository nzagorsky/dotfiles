source ~/.zsh/antigen/antigen.zsh

antigen use oh-my-zsh

antigen bundle aws
antigen bundle compleat
antigen bundle docker
antigen bundle git-extras
antigen bundle gitfast
antigen bundle httpie
antigen bundle kubectl
antigen bundle npm
antigen bundle pip
antigen bundle python
antigen bundle redis-cli
antigen bundle yarn
antigen bundle z

antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-history-substring-search

# Pure prompt
antigen bundle mafredri/zsh-async
antigen bundle sindresorhus/pure

# Execute
antigen apply
