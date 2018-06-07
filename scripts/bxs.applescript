
on run argv

  -- go to next window
  tell application "System Events" to keystroke ";" using control down

  -- hit return
  tell application "System Events" to key code 36

  -- run the script and hit return
  tell application "Terminal"
    do script (item 1 of argv) in window 1
    delay 0.1
    tell application "System Events" to key code 36
  end tell
end run

