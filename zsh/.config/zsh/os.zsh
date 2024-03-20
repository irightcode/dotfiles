case $(uname -s) in
  Darwin)
    alias dircolors=gdircolors
  ;;
  Linux)
    # clipboard
    alias pbcopy='xclip -selection clipboard'
    alias pbpaste='xclip -selection clipboard -o'
  ;;
esac
