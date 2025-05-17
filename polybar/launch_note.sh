#!/usr/bin/env bash

# Termina qualquer instância rodando
polybar-msg cmd quit

# Espera um pouco para garantir que fechou
sleep 1

if type "xrandr" > /dev/null; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --reload main &
  done
else
  polybar --reload main &
fi

echo "Main bar launched..."
