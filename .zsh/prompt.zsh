# References:
#		https://github.com/alexanderjeurissen/ombre.zsh/blob/master/prompt_ombre_setup

autoload -Uz promptinit && promptinit

_generate_left_prompt() {
  local prompt_content="${prompt_newline}"

  # Only print host name when connected through ssh
  if [[ "$SSH_CONNECTION" != '' ]]; then
    prompt_content+="%F{blue} %m%f"
  fi

  # Change color based on last exit code
  prompt_content+="%(?. %F{green}›%f . %F{red}›%f )"

  PROMPT="${(j..)prompt_content}"
}

_generate_right_prompt() {
  local rprompt_content
  local working_tree="${vcs_info_msg_1_}"

  # Not sure if this is the best approach, but it works!
  if [[ -n $working_tree ]]; then
    if ( test -z "$(command git status --porcelain --ignore-submodules -unormal)" ); then
      rprompt_content+="%F{green}"
    else
      rprompt_content+="%F{red}"
    fi
  fi

  # Show last two segments of path
  rprompt_content+=" %(3~|%2~|%~)"

  # Add VCS info if inside a repository
  if [[ -n $working_tree ]]; then
    rprompt_content+="${vcs_info_msg_0_}"
  fi

  RPROMPT="%F{default}${rprompt_content}%f"
}

prompt_setup() {
  # prevent percentage showing up
  # if output doesn't end with a newline
  export PROMPT_EOL_MARK=''
  setopt prompt_subst

  # Enable case-insensitive globbing
  setopt EXTENDED_GLOB
  unsetopt CASE_GLOB

  # Borrowwed from sindresorhus/pure
  if [[ -z $prompt_newline ]]; then
    # This variable needs to be set, usually set by promptinit.
    typeset -g prompt_newline=$'\n%{\r%}'
  fi

  zmodload zsh/datetime
  zmodload zsh/zle

  autoload -Uz add-zsh-hook
  autoload -Uz vcs_info

  zstyle ':vcs_info:*' enable git
  zstyle ':vcs_info:*' use-simple true
  zstyle ':vcs_info:*' max-exports 3
  zstyle ':vcs_info:git*' formats ' %%S  %b %f%%s' '%R'
  zstyle ':vcs_info:git*' actionformats ' %%S  %b %f%%s' '%b|%a' '%R'

  add-zsh-hook precmd vcs_info
  add-zsh-hook precmd _generate_left_prompt
  add-zsh-hook precmd _generate_right_prompt
}

prompt_setup "$@"
