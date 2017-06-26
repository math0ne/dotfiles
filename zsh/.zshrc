source  ~/powerlevel9k/powerlevel9k.zsh-theme

# https://github.com/bhilburn/powerlevel9k/wiki/Show-Off-Your-Config
# https://github.com/bhilburn/powerlevel9k/wiki/Stylizing-Your-Prompt

# Disable dir/git icons
POWERLEVEL9K_MODE='awesome-patched'

POWERLEVEL9K_STATUS_OK_BACKGROUND="7"
POWERLEVEL9K_STATUS_OK_FOREGROUND="0"
POWERLEVEL9K_STATUS_ERROR_BACKGROUND="7"
POWERLEVEL9K_STATUS_ERROR_FOREGROUND="0"

POWERLEVEL9K_HOME_ICON=''
POWERLEVEL9K_HOME_SUB_ICON=''
POWERLEVEL9K_FOLDER_ICON=''

DISABLE_AUTO_TITLE="true"

POWERLEVEL9K_DIR_HOME_BACKGROUND="6"
POWERLEVEL9K_DIR_HOME_FOREGROUND="7"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND="6"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="7"
POWERLEVEL9K_DIR_DEFAULT_BACKGROUND="6"
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND="7"

POWERLEVEL9K_CONTEXT_DEFAULT_BACKGROUND="11"
POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND="0"

POWERLEVEL9K_OS_ICON_BACKGROUND="7"
POWERLEVEL9K_OS_ICON_FOREGROUND="0"

POWERLEVEL9K_TIME_BACKGROUND="3"
POWERLEVEL9K_TIME_FOREGROUND="0"




POWERLEVEL9K_VCS_GIT_ICON=''
POWERLEVEL9K_VCS_STAGED_ICON='\u00b1'
POWERLEVEL9K_VCS_UNTRACKED_ICON='\u25CF'
POWERLEVEL9K_VCS_UNSTAGED_ICON='\u00b1'
POWERLEVEL9K_VCS_INCOMING_CHANGES_ICON='\u2193'
POWERLEVEL9K_VCS_OUTGOING_CHANGES_ICON='\u2191'

POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='yellow'
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='yellow'
#POWERLEVEL9K_VCS_UNTRACKED_ICON='?'

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(status os_icon context dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(background_jobs time)

POWERLEVEL9K_SHORTEN_STRATEGY="truncate_middle"
POWERLEVEL9K_SHORTEN_DIR_LENGTH=4

POWERLEVEL9K_TIME_FORMAT="%D{%H.%M %d.%m}"

POWERLEVEL9K_STATUS_VERBOSE=false
export DEFAULT_USER="$USER"

