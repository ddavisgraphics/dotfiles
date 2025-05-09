clean_screenshots(){
  find ~/Desktop -name "*.png" -type f -mtime +2 -exec rm {} \;
}