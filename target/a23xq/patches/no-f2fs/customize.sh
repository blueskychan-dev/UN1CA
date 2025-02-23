SKIPUNZIP=1

# Define the directories to search for fstab files
DIRECTORIES=("system" "vendor")

# Loop through each directory
for DIR in "${DIRECTORIES[@]}"; do
    # Find all fstab files in the directory
    find "$WORK_DIR/$DIR" -type f -name "fstab*" | while read -r FSTAB_FILE; do
        # Check if the file contains 'f2fs'
        if grep -q 'f2fs' "$FSTAB_FILE"; then
            # Replace only occurrences of f2fs as the file system type (tab-separated fields)
            sed -i 's/\bf2fs\b/ext4/g' "$FSTAB_FILE"
            cat "$FSTAB_FILE"
            echo "Updated $FSTAB_FILE to use ext4 instead of f2fs"
        else
            echo "No changes made to $FSTAB_FILE (no 'f2fs' found)"
        fi
    done
done
