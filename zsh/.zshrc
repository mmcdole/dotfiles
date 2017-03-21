# Path to your oh-my-zsh installation.
export ZSH=/Users/mmcdole/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="wezm"


# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

# User configuration

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export GOPATH="$HOME/go"
export PATH="$HOME/.yarn/bin:$PATH"
export GOBIN="$GOPATH/bin"

source $ZSH/oh-my-zsh.sh

export EDITOR='vim'

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#
alias helix="muxssh helix"

alias sa="s -p amazon"
alias sw="s -p wikipedia"
alias sy="s -p youtube"

shn() { s "$@" site:news.ycombinator.com; }

# export GOBIN="/Users/mmcdole/go/bin"

# Setup FZF 
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi


play() {
    # Skip DASH manifest for speed purposes. This might actually disable
    # being able to specify things like 'bestaudio' as the requested format,
    # but try anyway.
    # Get the best audio that isn't WebM, because afplay doesn't support it.
    # Use "$*" so that quoting the requested song isn't necessary.
    youtube-dl --default-search=ytsearch: \
               --youtube-skip-dash-manifest \
               --output="${TMPDIR:-/tmp/}%(title)s-%(id)s.%(ext)s" \
               --restrict-filenames \
               --format="bestaudio[ext!=webm]" \
               --exec=afplay "$*"
}

mp3() {
    # Get the best audio, convert it to MP3, and save it to the current
    # directory.
    youtube-dl --default-search=ytsearch: \
               --restrict-filenames \
               --format=bestaudio \
               --extract-audio \
               --audio-format=mp3 \
               --audio-quality=1 "$*"
}

extract() {
	for i in *.mobileprovision; do
	  uuid=`grep UUID -A1 -a $i | grep -io "[-A-Z0-9]\{36\}"`
	  echo $i - $uuid
	done
}


muxssh () {
  /usr/bin/ssh -t $@ "tmux attach || tmux new";
}
