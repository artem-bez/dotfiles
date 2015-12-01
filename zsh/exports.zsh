export PATH=$PATH:$HOME/bin
export PYTHONDOCS=/usr/share/doc/python2/html/
export ALTERNATE_EDITOR=""
export EDITOR="emacsclient -c"
# When jumping position target line on the 3 line. Scroll by 4 lines. Ignore case when lowercase.
export LESS='-R -j4 -z-3 -i'
export BROWSER='firefox'
export PAGER='less'
# virtualenv wrapper
export WORKON_HOME=$HOME/.venvs
export PROJECT_HOME=$HOME/src/my
#export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python2
#export VIRTUALENVWRAPPER_VIRTUALENV=/usr/bin/virtualenv2
export FZF_DEFAULT_OPTS='-x'