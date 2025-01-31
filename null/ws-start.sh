!/bin/bash

# Setup your workspace with some routines, e.g.:
#
# Load environment variables
# > source "${BASH_SOURCE%/*}"/ws-config.sh
#
# Save working dir
# > pwd=$(pwd)
#
# Pull latest version
# > cd ./src
# > git pull origin master
#
# Start docker container
# > docker-compose up -d
#
# Load local mysql file into docker db
# > docker exec -i ${container} bash -c "mysql -u${mysql_user} -p${mysql_pass} -e \"DROP DATABASE IF EXISTS ${database};\""
# > docker exec -i ${container} bash -c "mysql -u${mysql_user} -p${mysql_pass} -e \"create database ${database} CHARACTER SET utf8 COLLATE utf8_general_ci;\""
# > docker exec -i ${container} mysql -u${mysql_user} -p${mysql_pass} ${database} < ./database.sql
#
# Copy source file into container
# > docker cp ./src ${container}:/workspace/app
#
# Return to working dir
# > cd "$pwd"