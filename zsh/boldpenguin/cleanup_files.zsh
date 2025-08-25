clean_files() {
  dos2unix $1 && sed -i '' 's/[[:space:]]*$//' $1
}