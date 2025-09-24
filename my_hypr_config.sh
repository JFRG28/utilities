#!/bin/bash

# Navegar al directorio Documents
cd ~/Documents

# Eliminar la carpeta omarchy-paco si ya existe
rm -rf omarchy-paco

# Clonar el repositorio de configuración de Hyprland
git clone -b main https://github.com/JFRG28/omarchy-paco.git

# Verificar que el repositorio se clonó correctamente
if [ ! -d "omarchy-paco" ]; then
    echo "Error: No se pudo clonar el repositorio"
    exit 1
fi

# Navegar al directorio del repositorio clonado
cd ~/Documents/omarchy-paco

# Verificar el estado del repositorio
git status

# Actualizar el repositorio con los últimos cambios
git pull

# Crear directorio de configuración de Hyprland si no existe
mkdir -p ~/.config/hypr

# Navegar al directorio de configuración de Hyprland
cd ~/.config/hypr

# Eliminar todos los archivos de configuración existentes (si existen)
rm -f *.conf

# Navegar al directorio del repositorio clonado para Hyprland
cd ~/Documents/omarchy-paco/hypr

# Crear enlaces simbólicos para todos los archivos .conf de Hyprland
for file in *.conf; do
    if [ -f "$file" ]; then
    ln -s "$(pwd)/$file" ~/.config/hypr/
    fi
done

# Crear directorio de configuración de Waybar si no existe
mkdir -p ~/.config/waybar

# Navegar al directorio de configuración de Waybar
cd ~/.config/waybar

# Eliminar archivos de configuración existentes de Waybar (si existen)
rm -f *.jsonc
rm -f *.css

# Eliminar directorio scripts existente si existe
rm -rf scripts

# Navegar al directorio del repositorio clonado para Waybar
cd ~/Documents/omarchy-paco/waybar

# Crear enlaces simbólicos para todos los archivos y directorios de Waybar
for file in *; do
    ln -s "$(pwd)/$file" ~/.config/waybar/
done

# Crear directorio bin local si no existe
mkdir -p ~/.local/bin

# Navegar al directorio bin local
cd ~/.local/bin

# Eliminar el ejecutable existente si existe
rm -f toggle-gsimplecal

# Navegar al directorio del repositorio clonado para binarios
cd ~/Documents/omarchy-paco/bin

# Crear enlaces simbólicos para todos los ejecutables
for file in *; do
    ln -s "$(pwd)/$file" ~/.local/bin/
done

# Recargar Hyprland para aplicar los cambios
hyprctl reload

# Recargar Waybar para aplicar los cambios
pkill waybar && waybar &