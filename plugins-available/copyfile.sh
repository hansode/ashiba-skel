function list_guestroot_tree() {
  local dir=$1

  [[ -d "${dir}" ]] || return 0
  cd ${dir}
  find . ! -type d | sed s,^\.,, | egrep -v '^/(.gitkeep|functions.sh)'
}

function generate_copyfile() {
  local guestroot_dirs="${guestroot_dir:-$(pwd)/guestroot}"

  echo "[INFO](copyfile) Generating copy.txt"
  local dir=
  for dir in ${guestroot_dirs}; do
    local line=
    while read line; do
      echo ${dir}${line} ${line}
    done < <(list_guestroot_tree ${dir})
  done > $(pwd)/copy.txt
  cat $(pwd)/copy.txt
}

generate_copyfile
