#!/bin/bash

read -rp "Commit message: " msg

if [ -z "$msg" ]; then
    echo "Failed: Commit message cannot be empty ❌"
    exit 1
fi

timestamp=$(date "%H:%M")
branch=$(git branch --show-current)

git add .

if ! git commit -m "$msg ($timestamp)"; then
    echo "Failed ❌"
    exit 1
fi

if git push origin "$branch"; then
    echo "Done ✅"
else
    echo "Failed ❌"
    exit 1
fi
