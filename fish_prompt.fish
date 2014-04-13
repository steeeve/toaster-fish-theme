function git_branch
  echo (git rev-parse --abbrev-ref HEAD ^/dev/null)
end

function current_folder
  echo -n $PWD | grep -o -E '[^\/]+$'
end

function git_status
  # In git
  if test -n (git_branch)

    set_color blue
    echo -n " git"
    set_color white
    echo -n ":"
    echo -n (git_branch)

    set -l is_dirty (git status --porcelain -z ^/dev/null)
    if test -n (echo $is_dirty)
      set_color red
      echo -n " ●"
      set_color white
      echo -n " [^._.^]ﾉ"
      echo (_git_status_codes)
    else
      set_color green
      echo -n ' ○' # clean
    end
  end
end

function _git_status_codes
  set -l git_status (git status --porcelain ^/dev/null)
  if echo "$git_status" | grep -q -E '^M '
    set_color blue
    echo -n "彡ミ"
  end
  if echo "$git_status" | grep -q -E '^A '
    set_color green
    echo -n "彡ミ"
  end
  if echo "$git_status" | grep -q -E '^D '
    set_color red
    echo -n "彡ミ"
  end
  if echo "$git_status" | grep -q -E '^R '
    set_color orange
    echo -n "彡ミ"
  end
  if echo "$git_status" | grep -q -E '^C '
    set_color yellow
    echo -n "彡ミ"
  end
  if echo "$git_status" | grep -q -E '^M '
    set_color cyan
    echo -n "彡ミ"
  end
end

function fish_prompt
  set_color blue
  echo -n "# "
  set_color cyan
  echo -n (current_folder)
  echo -n (git_status)
  echo ""
  set_color red
  echo "\$ "
end
