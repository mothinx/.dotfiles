#!/bin/bash

# Récupérer l'état de la sortie DP-2 via hyprctl
# On cherche "DP-2" et si son état est "enabled"
if hyprctl monitors | grep "Monitor DP-2" -A 16 | grep -q "active workspace"; then
  echo "DP-2 est activé. Désactivation via hyprctl..."
  # Désactiver la sortie DP-2
  hyprctl keyword monitor DP-2, disable
else
  echo "DP-2 est désactivé. Activation via hyprctl..."
  # Activer la sortie DP-2 avec sa résolution préférée et position
  # La résolution préférée de DP-2 est 2560x1440 px, et votre position est 3440,0
  hyprctl keyword monitor DP-2, 2560x1440@59.951000Hz
fi

echo "État actuel des moniteurs (via hyprctl) :"
hyprctl monitors
