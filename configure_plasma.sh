#!/usr/bin/env bash

KWRITECONF=kwriteconfig5

${KWRITECONF} --file "$HOME/.config/kglobalshortcutsrc" \
  --group "kwin" \
  --key "Window Close" \
  "Meta+Shift+Q,Alt+F4,Close Window"

${KWRITECONF} --file "$HOME/.config/kglobalshortcutsrc" \
  --group "kwin" \
  --key "Window Fullscreen" \
  "Meta+Shift+F,none,Make Window Fullscreen"

${KWRITECONF} --file "$HOME/.config/kglobalshortcutsrc" \
  --group "kwin" \
  --key "Window Maximize" \
  "Meta+F,none,Maximize Window"

for num in {1..9}; do
    ${KWRITECONF} --file "$HOME/.config/kglobalshortcutsrc" \
      --group "plasmashell" \
      --key "activate task manager entry $num" \
      "none,none,Activate Task Manager Entry $num"

    ${KWRITECONF} --file "$HOME/.config/kglobalshortcutsrc" \
      --group "kwin" \
      --key "Switch to Desktop $num" \
      "Meta+$num,Meta+$num,Switch to Desktop $num"
done

${KWRITECONF} --file "$HOME/.config/kglobalshortcutsrc" --group "kwin" \
    --key "Window to Desktop 1" \
    "Meta+!,none,Window to Desktop 1"
${KWRITECONF} --file "$HOME/.config/kglobalshortcutsrc" --group "kwin" \
    --key "Window to Desktop 2" \
    "Meta+@,none,Window to Desktop 2"
${KWRITECONF} --file "$HOME/.config/kglobalshortcutsrc" --group "kwin" \
    --key "Window to Desktop 3" \
    "Meta+#,none,Window to Desktop 3"
${KWRITECONF} --file "$HOME/.config/kglobalshortcutsrc" --group "kwin" \
    --key "Window to Desktop 4" \
    "Meta+$,none,Window to Desktop 4"
${KWRITECONF} --file "$HOME/.config/kglobalshortcutsrc" --group "kwin" \
    --key "Window to Desktop 5" \
    "Meta+%,none,Window to Desktop 5"
${KWRITECONF} --file "$HOME/.config/kglobalshortcutsrc" --group "kwin" \
    --key "Window to Desktop 6" \
    "Meta+^,none,Window to Desktop 6"
${KWRITECONF} --file "$HOME/.config/kglobalshortcutsrc" --group "kwin" \
    --key "Window to Desktop 7" \
    "Meta+&,none,Window to Desktop 7"
${KWRITECONF} --file "$HOME/.config/kglobalshortcutsrc" --group "kwin" \
    --key "Window to Desktop 8" \
    "Meta+*,none,Window to Desktop 8"
${KWRITECONF} --file "$HOME/.config/kglobalshortcutsrc" --group "kwin" \
    --key "Window to Desktop 9" \
    "Meta+(,none,Window to Desktop 9"



${KWRITECONF} --file kcminputrc --group "Keyboard" --key "RepeatDelay" 250
${KWRITECONF} --file kcminputrc --group "Keyboard" --key "RepeatRate" 50
${KWRITECONF} --file kxkbrc --group "Layout" --key "ResetOldOptions" true
${KWRITECONF} --file kxkbrc --group "Layout" --key "Options" "caps:ctrl_modifier,grp:win_space_toggle"
${KWRITECONF} --file kxkbrc --group "Layout" --key "LayoutList" "us,ru"
${KWRITECONF} --file kdeglobals --group "KDE-Global GUI Settings" --key "GraphicEffectsLevel" 0


killall kglobalaccel5 && sleep 1s && kglobalaccel5 &!
