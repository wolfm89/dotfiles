#!/usr/bin/zsh

# First we append the saved layout of worspace N to workspace M
# And finally we fill the containers with the programs they had
i3-msg "workspace 3; append_layout ~/.config/i3/workspace_3.json"
i3-msg "workspace 2; append_layout ~/.config/i3/workspace_2.json"
i3-msg "workspace 1; append_layout ~/.config/i3/workspace_1.json"
(franz-bin &)
(urxvt &)
(urxvt &)
(chromium &)
