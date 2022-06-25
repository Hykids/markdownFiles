set -e

npm run github:build

cd docs/.vuepress/github

git init
git add -A
git commit -m 'deploy'

git push -f git@github.com:Hykids/markdownFiles.git

cd -