set color_orange fd971f
set color_blue 6ec9dd
set color_green a6e22e
set color_pink f92672
set color_grey 554f48
set color_white f1f1f1
set color_purple 9458ff
set color_lilac ae81ff

function git_branch
  echo (git rev-parse --abbrev-ref HEAD ^/dev/null)
end

function current_folder
  echo -n $PWD | grep -o -E '[^\/]+$'
end

function git_status
  # In git
  if test -n (git_branch)

    set_color $color_blue
    echo -n " git"
    set_color $color_white
    echo -n ":"
    echo -n (git_branch)

    set -l is_dirty (git status --porcelain -z ^/dev/null)
    if test -n (echo $is_dirty)
      set_color $color_pink
      echo -n " ●"
      set_color $color_white
      echo -n " [^._.^]ﾉ"
      echo (_git_status_codes)
    else
      set_color $color_green
      echo -n ' ○' # clean
    end
  end
end

function _git_status_codes
  set -l git_status (git status --porcelain ^/dev/null | tr '\n' '@')
  if echo $git_status | grep -q -E '@M'
    set_color $color_blue
    echo -n "彡ミ"
  end
  if echo $git_status | grep -q -E '@A'
    set_color $color_green
    echo -n "彡ミ"
  end
  if echo $git_status | grep -q -E '@D'
    set_color $color_pink
    echo -n "彡ミ"
  end
  if echo $git_status | grep -q -E '@R'
    set_color $color_orange
    echo -n "彡ミ"
  end
  if echo $git_status | grep -q -E '@C'
    set_color $color_yellow
    echo -n "彡ミ"
  end
  if echo $git_status | grep -q -E '^M '
    set_color $color_lilac
    echo -n "彡ミ"
  end
end

function fish_prompt
  set_color $color_blue
  echo -n "# "
  set_color $color_purple
  echo -n (current_folder)
  echo -n (git_status)
  echo ""
  set_color $color_pink
  echo "\$ "
end
