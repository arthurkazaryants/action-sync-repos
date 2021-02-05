#!/usr/bin/env sh
set -eu

echo 'STARTED'

mkdir -p ~/.ssh
echo "$INPUT_SSH_PRIVATE_KEY" > ~/.ssh/id_rsa
chmod 600 ~/.ssh/id_rsa

export GIT_SSH_COMMAND="ssh -v -i ~/.ssh/id_rsa -o StrictHostKeyChecking=no -l git"
#git remote add mirror "$INPUT_TARGET_REPO_URL"
#git push --tags --force --prune mirror "refs/remotes/origin/*:refs/heads/*"


##!/bin/bash

WORK_DIR=$(dirname $0)
#DEV_DIR=$WORK_DIR'/dev'
BRANCH=$INPUT_SOURCE_BRANCH
PROD_DIR='prod'

##########
echo 'Current dir: '
pwd

cd ..

mkdir $PROD_DIR
cd $PROD_DIR

echo 'Current dir: '
pwd

git clone $INPUT_TARGET_REPO_URL

last_version=$(awk 'git log -1 --pretty=%B')
last_version=$(awk  'BEGIN{FS=OFS="."}{$NF++}1' $last_version)
echo 'Last Version: '
echo $last_version

#git pull origin ${BRANCH}
echo 'Rsync: '
rsync -r --exclude=.git $WORK_DIR .

echo 'Git add '
git add .
git status

echo 'Commiting '$last_version
git commit -m $last_version
