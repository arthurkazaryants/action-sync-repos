#!/usr/bin/env sh
set -eu

mkdir -p ~/.ssh
echo "$INPUT_SSH_PRIVATE_KEY" > ~/.ssh/id_rsa
chmod 600 ~/.ssh/id_rsa

export GIT_SSH_COMMAND="ssh -v -i ~/.ssh/id_rsa -o StrictHostKeyChecking=no -l git"
git remote add mirror "$INPUT_TARGET_REPO_URL"
git push --tags --force --prune mirror "refs/remotes/origin/*:refs/heads/*"
