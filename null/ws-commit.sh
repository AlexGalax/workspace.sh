!/bin/bash

# Commit repo
# Example:
#
# > cd "${BASH_SOURCE%/*}/src"
# > git add .
# > echo -n "Commit description: "
# > read description
# > git commit -am "${description}"
# > read -p "Enter the name of the branch [main]: " branch
# > branch=${branch:-main}
# > git push origin $branch