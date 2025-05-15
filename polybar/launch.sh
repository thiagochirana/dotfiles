#!/usr/bin/env bash

# Termina qualquer instância rodando
polybar-msg cmd quit

# Espera um pouco para garantir que fechou
sleep 1

if type "xrandr" > /dev/null; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --reload top &
    MONITOR=$m polybar --reload bottom &
  done
else
  polybar --reload top &
  polybar --reload bottom &
fi

echo "Top and Bottom bars launched..."
