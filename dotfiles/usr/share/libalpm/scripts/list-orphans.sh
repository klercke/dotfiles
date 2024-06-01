#!/bin/bash

output=$(pacman -Qdtq)
if [[ -z "$output" ]]; then
    echo "No orphaned packages found"
else
    echo "Found the following orphaned packages. Execute \"pacman -Qdtq | pacman -Rns -\" to remove:"
    echo "$output"
fi

