!/bin/bash

# Save and backup your workspace
#
# Load environment variables
# > source "${BASH_SOURCE%/*}/config.sh"
#
# Copy files from container to local dir
# > docker cp "$container":/workspace/app "${BASH_SOURCE%/*}/src"
#
# Save database
# > docker exec -i "$container" mysqldump -u "$mysql_user" -p"$mysql_pass" "$database" > "${BASH_SOURCE%/*}/database.sql"
#
# Store backup on external drive
# Change the path /mnt/f/backup/null/ to your desired location
#
# > backup_folder="/mnt/f/backup/null"
# > datetimenow=$(date +%Y-%m-%d-%H-%M-%S)
# > tar -czf "$backup_folder"/"$datetimenow".tar.gz -C "${BASH_SOURCE%/*}" .
#
# Delete files older than 7 days but leave at least 5 backups
# > find "$backup_folder" -name "*.tar.gz" -type f -mtime +7 | sort | head -n -7 | xargs rm