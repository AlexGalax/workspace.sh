#!/bin/bash

#
# First parameter is workspace action
#
action=$1
shift

#
# Execute action script in project directory
#
executeActionScript(){
  script_file="${BASH_SOURCE%/*}/$session_name/$action.sh"
  if [[ -f "$script_file" ]]; then
    colEcho yellow "Executing $script_file…"
    ${script_file}
  fi
}

#
# Kill existing tmux session
#
killTmuxSession(){
  if [[ $kill = true ]] ; then
    colEcho yellow "Killing tmux session $1."
    tmux kill-session -t $1
  fi
}

#
# Because
#
colEcho(){
  if [ "${1}" = "black" ]; then
    col='\x1B[30m'
  elif [ "${1}" = "red" ]; then
    col='\x1B[31m'
  elif [ "${1}" = "green" ]; then
    col='\x1B[32m'
  elif [ "${1}" = "yellow" ]; then
    col='\x1B[33m'
  elif [ "${1}" = "blue" ]; then
    col='\x1B[34m'
  elif [ "${1}" = "purple" ]; then
    col='\x1B[35m'
  elif [ "${1}" = "cyan" ]; then
    col='\x1B[36m'
  elif [ "${1}" = "white" ]; then
    col='\x1B[37m'
  fi
  echo -e "${col}$2\x1B[0m"
}

#
# Get the optional parameters -k to kill the
# session and the session name / project name
#
kill=false
while [[ "$#" -ge 1 ]]; do
  case "$1" in
    -k|--kill)
      kill=true;;
    *)
      session_name=$1;;
  esac
  shift
done

#
# Get open session name, if not provided from prompt
#
if [[ -z "$session_name" ]]; then
  session_name="$(tmux display -p '#S')"
  if [[ -z "$session_name" ]]; then
    colEcho red "No tmux session open nor provided to $action workspace."
    exit 1
  fi
fi

#
# Check if session name directory exists
#
source_folder="${BASH_SOURCE%/*}/$session_name"
if [[ ! -d "$source_folder" ]]; then
  colEcho red "Workspace directory $source_folder does not exist."
  exit 1
fi

#
# End tmux session
#
if [[ $action = "end" ]]; then
  colEcho green "Closing workspace \"$session_name\""
  executeActionScript $session_name
  tmux detach -s $session_name
  killTmuxSession $session_name

#
# Start tmux session
#
elif [[ $action = "start" ]]; then
  colEcho green "Starting workspace \"$session_name\""
  killTmuxSession $session_name
  executeActionScript $session_name

  # check if tmux session already exists
  tmux ls | grep "$session_name" 2> /dev/null
  if [[ $? -ne 0 ]]; then

    # if not, create session
    TMUX= tmux new-session -d -s "$session_name"

    # load tmux configuration file
    source_file="${source_folder}/tmux.conf"
    if [[ -f "$source_file" ]]; then
      if $has_source_file; then
        tmux source-file $source_file
      fi
    fi
  fi

  if [[ -z "$TMUX" ]]; then
    tmux attach -t "$session_name"
  else
    tmux switch-client -t "$session_name"
  fi

#
# Execute any other action script
#
else
  killTmuxSession $session_name
  executeActionScript $session_name
fi