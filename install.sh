#!/usr/bin/env sh

# Installation script for config-lazygit

point_lazygit_to_this_config() {
  echo "Pointing lazygit to this config"
  if [ -L ~/.config/lazygit ]; then
    echo "lazygit config already set - verifying it points to this config"
    local actual_resolved_path
    actual_resolved_path=$(readlink -f ~/.config/lazygit)
    if [ "$actual_resolved_path" = "$(pwd)" ]; then
      echo "lazygit is already pointing to this config"
    else
      echo "lazygit is pointing to another config: ${actual_resolved_path}"
      exit 1
    fi
  else
    if [ -d ~/.config/lazygit ]; then
      echo "lazygit config already exists - moving it to backup"
      mv ~/.config/lazygit{,.bak}
    else
      echo "Linking lazygit to this config"
      ln -s ~/repos/config-lazygit ~/.config/lazygit
    fi
  fi
}

main() {

  if [ -e config.yml ]; then
    point_lazygit_to_this_config
  else
    echo "You need to run this script from within the config-lazygit directory"
  fi
}

main
