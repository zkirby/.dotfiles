##################
#### Aliases #####
##################
# Git Alias
alias gbr='git branch'
alias g='git'
alias gf='git fetch'
alias gfr='git fetch --all'
alias gr='git rebase'
alias gra='git rebase --abort'
alias grc='git rebase --continue'
alias gri='git rebase --interactive'
alias grs='git rebase --skip'
alias gs='git stash'
alias gsa='git stash apply'
alias log="git log --graph --abbrev-commit --date=relative"
alias gco='git checkout'
alias ga='git add'
alias gd='git diff'
alias gcm='git commit -m'
alias gcb='gco -b'
alias gst='git status'
alias gundo='git reset HEAD~1'
alias gcf="git diff-tree --no-commit-id --name-only -r"
alias gcfc='git diff --name-only HEAD^ HEAD'
alias gpof='git push origin HEAD --force-with-lease'
alias gpp='gco development; g pull; gco -; g rebase development'
alias gupdate='g fetch upstream; gco master; g merge upstream/master'
alias gpu='g push -u origin HEAD'
alias gcma='ga .; gcm'
alias gcom='gco master'
alias gclean='git fetch -p && for branch in `git branch -vv --no-color | grep ": gone]" | awk "{print $1}"`; do git branch -D $branch; done'

# Gatsby
alias gyd='gatsby develop'
alias gyb='gatsby build'
alias gys='gatsby serve'

# npm alias
alias nrd='npm run deploy'
alias nrs='npm run serve'
alias nrl='npm run lint'

# Vim alias 
alias v='mvim -v'
alias vz='v ~/.zshrc'
alias vv='v ~/.vim/vimrc'

# Alias for directories
alias cdl='function _cdls() { cd "$1" && ls; };_cdls'
alias cdu='cd ..; ls;'
alias lh='ls -a | egrep "^\."'
alias cat='bat'
alias yrm='yes | rm -r '

# Workflow aliases
# -- Coding
alias cdw='function _f() { local n="$1"; local g="$2"; cd ~/Desktop/web-dev; cd ${n}*; cdl ${g}* };_f'

alias cdd='cdl ~/Desktop/web-dev/projects/website/website_v6/'
# -- Writing 
alias ws='cd ~/Desktop/writing/; ga .; gcm "writing save"; g push; cd -' # write save
function _wg() {
	if [ $# -eq 0 ]; then
		cdl ~/Desktop/writing
  else
		local n="$1"
		cdl ~/Desktop/writing/${n}*
	fi
}
alias wg='_wg'
function _lw() {
	ls -Art | tail -n 3 | head -n 1
}
function _wro() {
	cd ~/Desktop/writing/reviews/weekly
	bat $(_lw)
}
function _wr() {
	cd ~/Desktop/writing/reviews/weekly
	today=`date +'%Y-%m-%d'`
	cp ~/Desktop/writing/reviews/weekly/template.md ${today}.md
  v ${today}.md 
}
alias wr='_wr' # creates a review
alias wro='_wro' # view the review from last week
alias wn='function _wn() { cp .template "$1" };_wn' # write new
alias wz='v ~/Desktop/writing/fun/spit sheet.md'

# -- General 
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

###################
### zsh edits #####
###################
setopt hist_ignore_all_dups # ignore duplicated commands history list
setopt auto_cd # cd by typing directory name if it's not a command
setopt auto_list # automatically list choices on ambiguous completion
setopt correct_all # autocorrect commands
setopt always_to_end # move cursor to end if word had one match

####################
### Path edits #####
####################
eval "$(rbenv init -)"
source /Users/ARK/Library/Preferences/org.dystroy.broot/launcher/bash/br
#PATH="/User/ARK/git-fuzzy/bin:$PATH"
# PATH edits to include custom scripts
PATH="${PATH}:/Users/ARK/.dotfiles/scripts"
# Setting PATH for Python 2.7. The orginal version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
PATH="/Users/ARK/git-fuzzy/bin:$PATH"
# MacPorts Installer addition on 2015-12-12_at_17:12:35: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"

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
	sv
  dotup
}
alias sz='source ~/.zshrc'
alias vzu='editZsh'
alias vvu='editV'

# Added by serverless binary installer
export PATH="$HOME/.serverless/bin:$PATH"
