# this file generated when environment is closed
# refresh . to make sure sizes are right

wm deiconify .
update
wm withdraw .
if {[winfo screenwidth .] != 1536 || [winfo screenheight .] != 864 || [lindex [wm maxsize .] 0] != 1540 || [lindex [wm maxsize .] 1] != 845} {
  set size_mismatch 1
} else {
  set size_mismatch 0
}

if $size_mismatch {
  set reset_window_sizes [tk_messageBox -icon warning -title "Screen resolution changed" -type yesno \
                                         -message "The screen resolution is not the same as it was the last time the Environment was used.  Should the window positions reset to the defaults?"]
} else { set reset_window_sizes 0}
if {$reset_window_sizes != "yes"} {
  set window_config(.visicon) 700x150+930+620
  set changed_window_list(.visicon) 1
  set window_config(.control_panel) 235x700+1012+90
  set changed_window_list(.control_panel) 1
  set window_config(.buffers) 470x240+1045+600
  set changed_window_list(.buffers) 1
  set window_config(.copyright) 400x290+1080+575
  set changed_window_list(.copyright) 1
}
set gui_options(p_selected) #44DA22
set gui_options(p_matched) #FCA31D
set gui_options(p_mismatched) #E1031E
