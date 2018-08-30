# process

elm bump # => Version changed to x.y.z!
git add elm.json && git commit -a -m "New release" # => commited locally
git tag -a x.y.z -m "Informative message" # => tagged
git push origin x.y.z # pushed on Github
elm publish # published on elm-package
