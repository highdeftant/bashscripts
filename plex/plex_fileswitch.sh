#!/bin/bash

# todo: Add a function to compare file size
# with free storage on server

DEST="Plex/Media/Movies"

addMovie() {
  MOVIE="$1"

  local USER="gh0stpi"
  local HOST="hashirama"

  if [[ ! -f "$MOVIE" ]]; then
    echo "[ERROR]: $MOVIE not found"
  else
    rsync -av -e ssh -P "$MOVIE" "$USER"@"$HOST":"$DEST"
    echo "[SUCCESS]: Moved "$MOVIE" to "$DEST""
  fi
}

# todo: Add text processor for "\"
# possibly using sed/awk


# todo: Add funtion to scan for files older
# than 30+ days and prompt to delete/keep

archiveFile() {
  LISTFILE=$(ssh $USER@$HOST ls -A "$DEST")
  NUM=1

  # Iterates through folder and checks
  # last modded date of file

  for FILE in $LISTFILE; do
    if [[ -f $FILE ]]; || continue
      EXT=${FILE##*.-}
      ARCHIVE=`date -d "30 days ago" +%s`
      LASTMOD=`date -c "%Y" "$FILE"`

      # Checks extention for .iso
      case $EXT in
        ISO|iso)
        if [[ $LASTMOD -lt $ARCHTIME ]]; then

          # Prints all files found over 30 days
          echo -e "Files Older than 30 days\n"
          echo $("[$NUM]: $FILE" "- $ARCHTIME")
          (( NUM ++ ))
          ;;
     # if [a[ $EXT == "."[Ii][Ss][Oo] ]]; then
        #if [[ $LASTMOD -lt $ARCHTIME ]]; then
        fi
    esac
    fi
  done
}


addMovie $1
