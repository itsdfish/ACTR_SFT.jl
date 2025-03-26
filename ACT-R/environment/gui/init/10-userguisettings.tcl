# this file generated when environment is closed
# refresh . to make sure sizes are right

wm deiconify .
update
wm withdraw .
if {[winfo screenwidth .] != 2560 || [winfo screenheight .] != 1440 || [lindex [wm maxsize .] 0] != 5124 || [lindex [wm maxsize .] 1] != 1421} {
  set size_mismatch 1
} else {
  set size_mismatch 0
}

if $size_mismatch {
  set reset_window_sizes [tk_messageBox -icon warning -title "Screen resolution changed" -type yesno \
                                         -message "The screen resolution is not the same as it was the last time the Environment was used.  Should the window positions reset to the defaults?"]
} else { set reset_window_sizes 0}
if {$reset_window_sizes != "yes"} {
  set window_config(.control_panel) 618x977+1777+272
  set changed_window_list(.control_panel) 1
  set window_config(.declarative) 420x300+1070+570
  set changed_window_list(.declarative) 1
  set window_config(.copyright) 400x290+1080+575
  set changed_window_list(.copyright) 1
  set window_config(.reload_response) 500x230+1030+605
  set changed_window_list(.reload_response) 1
}
set gui_options(p_selected) #44DA22
set gui_options(p_matched) #FCA31D
set gui_options(p_mismatched) #E1031E
