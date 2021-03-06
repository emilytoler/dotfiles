# Read by subshells. Login shells source this file via .bash_profile
#
# Set aliases in ~/.bash/aliases
# Set prompts and whatnot in ~/.bash/config
# Set prompts in ~/.bash/paths
#
# Don't set PATH here because it'll keep growing.

# These don't carry through to subshells so they go here instead of
# .bash_profile

source ~/.bash/aliases
source ~/.bash/completions
source ~/.bash/config

# Use .localrc for settings specific to one system.
if [ -f ~/.localrc ]; then
    source ~/.localrc
fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"