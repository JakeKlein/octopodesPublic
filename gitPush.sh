#!/usr/bin/env bash

echo 'pushing to master'
git push origin master

echo 'syncing mirror'
git push --mirror https://github.com/JakeKlein/octopodesPublic.git
