# run me in sudo
cd `brew --prefix`
sudo git checkout master
sudo git ls-files -z | pbcopy
sudo rm -rf Cellar
sudo bin/brew prune
sudo pbpaste | xargs -0 rm
sudo rm -r Library/Homebrew Library/Aliases Library/Formula Library/Contributions 
sudo test -d Library/LinkedKegs && rm -r Library/LinkedKegs
sudo rmdir -p bin Library share/man/man1 2> /dev/null
sudo rm -rf .git
sudo rm -rf ~/Library/Caches/Homebrew
sudo rm -rf ~/Library/Logs/Homebrew
sudo rm -rf /Library/Caches/Homebrew
sudo rm -f `which brew`
