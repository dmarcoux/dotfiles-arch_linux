# Quicker than cd ..; cd ...; etc...
#   ~$ cd ~/dir/example/folder
#   ~/dir/example/folder$ up 2
#   ~/dir$
# Credits: http://www.bashoneliners.com/oneliners/oneliner/220/ (I simply reformated the script)
up() {
  DEPTH=$1;

  if [ -z "${DEPTH}" ]; then # No depth provided...
    DEPTH=1;
  fi

  for i in $(seq 1 ${DEPTH}); do
    cd ../
  done
}

# Extract archives
extract() {
  if [ -z "$1" ]; then
    # Display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
  fi

  for file in "$@"
  do
    if [ -f "$file" ]; then
      NAME=${file%.*}
      mkdir $NAME && cd $NAME
      case $file in
        *.tar.bz2)   tar xvjf ../$file     ;;
        *.tar.gz)    tar xvzf ../$file     ;;
        *.tar.xz)    tar xvJf ../$file     ;;
        *.lzma)      unlzma ../$file       ;;
        *.bz2)       bunzip2 ../$file      ;;
        *.rar)       unrar x -ad ../$file  ;;
        *.gz)        gunzip ../$file       ;;
        *.tar)       tar xvf ../$file      ;;
        *.tbz2)      tar xvjf ../$file     ;;
        *.tgz)       tar xvzf ../$file     ;;
        *.zip)       unzip ../$file        ;;
        *.Z)         uncompress ../$file   ;;
        *.7z)        7z x ../$file         ;;
        *.xz)        unxz ../$file         ;;
        *.exe)       cabextract ../$file   ;;
        *)           echo "extract: '$file ' - unknown archive method" ;;
      esac

      cd ..
    else
      echo "$file  - file does not exist"
    fi
  done
}
