#!/bin/sh

setup_git() {
  git config --global user.email "travis@travis-ci.org"
  git config --global user.name "Travis CI"
}

download_github_gitignore() {
  cd templates
    wget -O master.zip https://github.com/github/gitignore/archive/master.zip
    unzip master.zip
    cd gitignore-master
      cp *.gitignore ../
      cd Global
        cp *.gitignore ../../
      cd ..
    cd ..
    rm -rf gitignore-master/
    rm master.zip
    chmod +x *.gitignore
    chmod +x *.patch
  cd ..
}

push_synchronized_submodules() {
  git add .
  git commit -m "Synchronized latest github/gitignore with dvcs ignore templates"
  git remote add push-master https://${GH_TOKEN}@github.com/dvcs/gitignore.git
  git push --set-upstream push-master master
}

setup_git
download_github_gitignore
push_synchronized_submodules
