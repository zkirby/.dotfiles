##################
#### Aliases #####
##################
# Git Alias
alias g='git'
alias ga='git add'
alias gbr='git branch'
alias gco='git checkout'
alias gf='git fetch'
alias gfr='git fetch --all'
alias gra='git rebase --abort'
alias grc='git rebase --continue'
alias gri='git rebase --interactive'
alias grs='git rebase --skip'
alias gs='git stash'
alias gs.='ga .; gs'
alias gsn='gs. push -m'
alias gsa='git stash apply'
alias gsl='git stash list'
alias gsp='gs pop'
alias log="git log --graph --abbrev-commit --date=relative"
alias gcm='git commit -m'
alias gcma='ga .; gcm'
alias gcmp='ga .; gcm "$1"; g push'
alias gcom='gco main'
alias gcb='gco -b'
alias gst='git status'
alias gpu='g push -u origin HEAD'
alias gundo='git reset HEAD~1'
alias gcf="git diff-tree --no-commit-id --name-only -r"
alias gcfc='git diff --name-only HEAD^ HEAD'
alias gupdate='g fetch upstream; gco main; g merge upstream/main'
alias gclean='git fetch -p && for branch in `git branch -vv --no-color | grep ": gone]" | awk "{print $1}"`; do git branch -D $branch; done'
alias gcfm='git diff main --name-only'
alias gd='git diff --stat --cached' # add [origin/branch] to see what is about to be pushed to remote branch
alias gstf='g fuzzy status'
alias gdel='g branch -D'
alias gmm='g merge main'
alias gcoo='gco origin/main --'
alias gcon='function _gcon() { gco @{-$1}};_gcon'
alias gstats='g shortlog -sn --all --no-merges'
alias grec='g for-each-ref --count=20 --sort=-committerdate refs/heads --format="%(refname:short)"' # recent branches
alias gtoday='g log --since=00:00:00 --all --no-merges --oneline --author=zkirby16@gmail.com' # what I worked on today
alias gccb='gcom; g pull; gcb'
alias gg='function _gg() { gr -i "HEAD~$1" };_gg'
alias gopen='mac git:open'

# Gatsby
alias gyd='gatsby develop'
alias gydl='npm run start:local'
alias gyb='gatsby build'
alias gys='gatsby serve'

# npm alias
alias nrd='npm run deploy'
alias nrl='npm run lint'
alias y='yarn'
grt () {
    cd "$(git rev-parse --show-toplevel 2>/dev/null)"
}

# Vim alias 
alias v='mvim -v'
alias vz='v ~/.zshrc'
alias vv='v ~/.vim/vimrc'

# Alias for directories
alias -- -='cd -'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias cdl='function _cdls() { cd "$1" && ls; };_cdls'
alias cdu='cd ..; ls;'
alias lh='ls -a | egrep "^\."'
alias cat='bat'
alias yrm='yes | rm -r '

# Workflow aliases
# -- Coding
alias cdw='function _f() { local n="$1"; local g="$2"; cd ~/Desktop/codes; cd ${n}*; cdl ${g}* };_f'
alias cdd='cdl ~/Desktop/vessel/code/monorepo'
alias cdc='cdl ~/Desktop/vessel/code/core'
alias gcheckup='git ls-files | grep -vE "yarn|package"| xargs wc -l'

# -- Vessel
alias vd='cdd; cd scripts; gco "#-total-rev"';
alias vdy='cdd; cd scripts; gco "#-total-rev"; yc';

# -- Scripts
alias gpt='node ~/scripts/ai/gpt3.5-turbo.js'

# -- Writing 
alias ws='cd ~/writings/; ga .; gcm "writings save"; g push; bat ~/.dotfiles/db/inspo.txt; cd -' # write save
alias wpull='cd ~/scripts; npx dotenv -e .env ts-node ./writings/sync.ts -- --command "pull"; cd -'
alias wpush='cd ~/scripts; npx dotenv -e .env ts-node ./writings/sync.ts -- --command "push"; cd -'
alias wpushll='cd ~/scripts; npx dotenv -e .env ts-node ./writings/sync.ts -- --command "pushll"; cd -'
function _wg() {
	if [ $# -eq 0 ]; then
		cdl ~/writings
  else
		local n="$1"
		cdl ~/writings/${n}*
	fi
}
alias wg='_wg'
function _lw() {
	ls -Art | tail -n 3 | head -n 1
}
function _wro() {
	cd ~/writings/reviews/weekly
	bat $(_lw)
}
function _wr() {
	cd ~/writings/reviews/weekly
	today=`date +'%Y-%m-%d'`
	cp ~/writings/reviews/weekly/template.md ${today}.md
  v ${today}.md 
}
alias wr='_wr' # creates a review
alias wro='_wro' # view the review from last week
alias wn='function _wn() { cp .template "$1" };_wn' # write new
alias wz='v ~/writings/fun/spit sheet.md'
alias newproject='npm init gatsby; npm install eslint --save-dev; npx eslint --init'

# -- General 
alias sleep='mac sleep'
alias v:mute='mac volume:mute'
alias v:umute='mac volume:unmute'
alias v:set='mac volume'
function _pp() {
	RAN_NUM=$(($RANDOM % 5))
	START=0
	input=~/.dotfiles/db/projects.txt

	while IFS= read -r line
	do
		if (( START == RAN_NUM )); then
			echo "$line"
		fi
	  ((START=START+1))
	done < "$input"
}
alias pp='_pp' # pick a project to work on
alias pe='v ~/.dotfiles/db/projects.txt' # edit the projects file
alias yt='function _yt() { cd ~/Desktop; yt-dlp "$1"; cd - };_yt'

# -- Python
alias penv='python3 -m venv .env; source .env/bin/activate'

###################
### zsh edits #####
###################
# add git branch to terminal name
autoload -Uz vcs_info
precmd () { vcs_info }
setopt prompt_subst
PS1="%F{green}\$vcs_info_msg_0_%F{white}$PS1"

setopt hist_ignore_all_dups # ignore duplicated commands history list
setopt auto_cd # cd by typing directory name if it's not a command
setopt auto_list # automatically list choices on ambiguous completion
setopt correct_all # autocorrect commands
setopt always_to_end # move cursor to end if word had one match

####################
### Path edits #####
####################
eval "$(rbenv init -)"
source /Users/zkirby/.config/broot/launcher/bash/br
# PATH edits to include custom scripts
PATH="${PATH}:/Users/ARK/.dotfiles/scripts"
# Setting PATH for Python 2.7. The orginal version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
# MacPorts Installer addition on 2015-12-12_at_17:12:35: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Added by serverless binary installer
export PATH="$HOME/.serverless/bin:$PATH"
[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh
# Added by Amplify CLI binary installer
export PATH="$HOME/.amplify/bin:$PATH"
 
###################
## Maintenance ####
###################
source ~/alias-tips/alias-tips.plugin.zsh
source ~/zsh-vim-mode/zsh-vim-mode.plugin.zsh
# Force vim to be default editor for git
gitvim() {
  git config --global core.editor "vim"
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Sync dot files
dots=('.zshrc' '.vim/vimrc')
function copy_up() {
	for dot in $dots; do
		cp -r ~/$dot ~/.dotfiles/$dot
  done
}
function copy_down() {
	for dot in $dots; do
		cp -r ~/.dotfiles/$dot ~/$dot
	done
}
alias dotupdate='cd ~/.dotfiles/; g pull'
alias dotadd='g add .; gcm "updates"; g push;'
alias dotup='copy_up; dotupdate; dotadd; cd -'
alias dotdown='dotupdate; copy_down; cd -'

# Actual edits
function editZsh() {
	v ~/.zshrc
	sz
  dotup
}
function editV() {
	v ~/.vim/vimrc
  dotup
}
alias sz='source ~/.zshrc'
alias vzu='editZsh'
alias vvu='editV'


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion



export PATH="/Users/zkirby/git-fuzzy/bin:$PATH"

# bun completions
[ -s "/Users/zkirby/.bun/_bun" ] && source "/Users/zkirby/.bun/_bun"

# Bun
export BUN_INSTALL="/Users/zkirby/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/opt/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

export PATH="/Users/zkirby/.local/bin:$PATH"


# JINA_CLI_BEGIN

## autocomplete
if [[ ! -o interactive ]]; then
    return
fi

compctl -K _jina jina

_jina() {
  local words completions
  read -cA words

  if [ "${#words}" -eq 2 ]; then
    completions="$(jina commands)"
  else
    completions="$(jina completions ${words[2,-2]})"
  fi

  reply=(${(ps:
:)completions})
}

# session-wise fix
ulimit -n 4096
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

# JINA_CLI_END




# pnpm
export PNPM_HOME="/Users/zkirby/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
