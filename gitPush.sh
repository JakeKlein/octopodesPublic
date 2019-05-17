#!/usr/bin/env bash

echo 'pushing to master'
git push origin master

echo 'pushing to mirror'
git push git push --mirror https://github.com/JakeKlein/octopodesPublic.git
