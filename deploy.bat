@echo off

if [%*] == [] goto error

echo Deploying updates to GitHub...

call hugo

call git add .
git commit -m %1
git push GitHub master

pushd public
call git add .

git commit -m %1
git push GitHub master
popd

goto end

:error
echo Commit message is missing for deployment

:end
