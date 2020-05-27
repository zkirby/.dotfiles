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
alias gpu='g push -u origin'

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
alias sz='source ~/.zshrc'
alias vv='v ~/.vim/vimrc'
alias sv='source ~/.vim/vimrc'

# Alias for directories
alias cdw='function _f() { local n="$1"; cd ~/Desktop/web-dev; cd ${n}* };_f'
alias cdl='function _cdls() { cd "$1" && ls; };_cdls'
alias lh='ls -a | egrep "^\."'
alias cat='bat'

###################
### zsh edits #####
###################
setopt HIST_IGNORE_ALL_DUPS # ignore duplicated commands history list

####################
### Path edits #####
####################
source /Users/ARK/Library/Preferences/org.dystroy.broot/launcher/bash/br
# Setting PATH for Python 2.7. The orginal version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
# MacPorts Installer addition on 2015-12-12_at_17:12:35: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"

###################
## Maintenance ####
###################
# Force vim to be default editor for git
gitvim() {
  git config --global core.editor "vim"
}

# Sync dot files
dots=('.zshrc' '.vim')
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
