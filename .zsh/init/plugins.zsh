source ~/.zsh/antigen/antigen.zsh

antigen use oh-my-zsh

antigen bundle command-not-found
antigen bundle compleat
antigen bundle docker
antigen bundle kubectl
antigen bundle git-extras
antigen bundle gitfast
antigen bundle pip
antigen bundle python
antigen bundle z

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# Pure prompt
antigen bundle mafredri/zsh-async
antigen bundle sindresorhus/pure

# Autsuggest
antigen bundle zsh-users/zsh-history-substring-search

# Execute
antigen apply
