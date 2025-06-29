#!/bin/bash

x="680"
wall="$HOME/wallpaper/wall.png"

i3lock \
  --image="$wall" \
  --clock \
  --indicator \
  --time-pos="x+$x:h-100" \
  --date-pos="x+$x:h-70" \
  --time-color="ffffffff" \
  --date-color="ccccccff" \
  --date-str="%A - %d de %B de %Y" \
  --greeter-text="Chirana" \
  --greeter-pos="x+$x:h-130" \
  --greeter-color="ffffffff" \
  --inside-color=00000088 \
  --ring-color=bb00ccff \
  --line-color=00000000 \
  --ring-width=10 \
  --radius=100 \
  --verif-text="Verificando..." \
  --wrong-text="Senha incorreta!" \
  --noinput-text="Sem entrada" \
  --keyhl-color=ff00a6 \
  --bshl-color=880000ff \
  --ringver-color=005577ff \
  --ringwrong-color=880000ff \
  --insidever-color=00557744 \
  --insidewrong-color=88000044
