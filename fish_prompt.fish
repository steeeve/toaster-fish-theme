set color_orange FD971F
set color_blue 6EC9DD
set color_green A6E22E
set color_yellow E6DB7E
set color_pink F92672
set color_grey 554F48
set color_white F1F1F1
set color_purple 9458FF
set color_lilac AE81FF

function ce
  set_color $argv[1]
  echo -n $argv[2]
end

function current_folder
  echo -n $PWD | grep -o -E '[^\/]+$'
end

function _git_status
  echo (git status --porcelain ^/dev/null | sed -E 's/(^.{3}).*/\1/' | tr -d ' \n')
end

function git_branch_name
  echo (git rev-parse --abbrev-ref HEAD ^/dev/null)
end

function git_status_icons
  set -l git_status (_git_status)

  function rainbow
    if echo $argv[1] | grep -q -e $argv[3]
      ce $argv[2] "彡ミ"
    end
  end

  rainbow $git_status $color_pink 'D'
  rainbow $git_status $color_orange 'R'
  rainbow $git_status $color_white 'C'
  rainbow $git_status $color_green 'A'
  rainbow $git_status $color_blue 'U'
  rainbow $git_status $color_lilac 'M'
  rainbow $git_status $color_grey '?'
end

function git_status
  # In git
  if test -n (git_branch_name)

    ce $color_blue " git"
    ce $color_white ":"(git_branch_name)

    if test -n (_git_status)
      ce $color_pink ' ●'
      ce $color_white ' [^._.^]ﾉ'
      echo (git_status_icons)
    else
      ce $color_green ' ○'
    end
  end
end

function fish_prompt
  ce $color_blue "# "
  ce $color_purple (current_folder)
  echo (git_status)
  ce $color_pink "\$ "
end
