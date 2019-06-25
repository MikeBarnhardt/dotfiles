# References:
#   Ombre.zsh
#     - https://github.com/alexanderjeurissen/ombre.zsh/blob/master/prompt_ombre_setup

autoload -Uz promptinit && promptinit

_generate_left_prompt() {
  local prompt_content="${prompt_newline}"

  # Only print host name when connected through ssh
  if [[ "$SSH_CONNECTION" != '' ]]; then
    prompt_content+="%F{blue}%m%f"
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
  rprompt_content+="%(3~|%2~|%~)"

  # Add VCS info if inside a repository
  if [[ -n $working_tree ]]; then
    rprompt_content+="${vcs_info_msg_0_}"
  fi

  RPROMPT="%F{default}${rprompt_content}%f"
}

_buffer_empty() {
  if [ -z "$BUFFER" ]; then
    if [ -n "${vcs_info_msg_1_}" ]; then
       echo -ne "\033[1m git status\033[0m \n"
       git -c color.status=always status --ignore-submodules=all | less -XFR
       git -c color.status=always lg -3 | less -XFR
    fi

    # echo -ne "\n \033[1m--- FILES:\033[0m \n"
    # CLICOLOR_FORCE=1 ls -C -G | less -XFR
    # echo -n "\n"

    zle redisplay
  else
    zle accept-line
  fi
}

_keymap_select() {
  [[ "$KEYMAP" == 'main' ]] && PROMPT="${PROMPT/·/›}"
  [[ "$KEYMAP" == 'viins' ]] && PROMPT="${PROMPT/·/›}"
  [[ "$KEYMAP" == 'vicmd' ]] && PROMPT="${PROMPT/›/·}"

  zle reset-prompt
  # zle -R
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
  zstyle ':vcs_info:git*' formats ' %%S %b %f%%s' '%R'
  zstyle ':vcs_info:git*' actionformats ' %%S %b %f%%s' '%b|%a' '%R'

  # Allow case insensitive globbing
  zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

  add-zsh-hook precmd vcs_info
  add-zsh-hook precmd _generate_left_prompt
  add-zsh-hook precmd _generate_right_prompt

  zle -N zle-keymap-select _keymap_select
  zle -N buffer-empty _buffer_empty

  bindkey -M main  "^M" buffer-empty
  bindkey -M vicmd "^M" buffer-empty
  bindkey -M viins  "^M" buffer-empty
}

prompt_setup "$@"
