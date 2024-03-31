case $(uname -s) in
  Darwin)
    alias dircolors=gdircolors
  ;;
  Linux)
    # clipboard
    alias pbcopy='xclip -selection clipboard'
    alias pbpaste='xclip -selection clipboard -o'

    # Ubuntu-specific aliases
    alias fd=fdfind
    alias bat=batcat
    alias open=xdg-open
  ;;
esac
