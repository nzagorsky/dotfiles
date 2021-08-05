set -e

if [ -z ${B2_BUCKET_NAME+x} ];
then
    echo "Set up credentials first. Missing B2_BUCKET_NAME"
    exit 1
else
    echo "Using B2_BUCKET_NAME=$B2_BUCKET_NAME";
fi

BACKUP_PATH=rclone://b2:/$B2_BUCKET_NAME/backups
BACKUP_TO=$BACKUP_PATH/$(hostnamectl hostname)

echo "Backing up to $BACKUP_TO."

echo "Calculating diff"
duplicity \
    incremental \
    --dry-run \
    --volsize=25 \
    --timeout=120 \
    --no-encryption \
    --exclude=$HOME/.cache \
    --exclude=$HOME/.cache/duplicity \
    --exclude=$HOME/.cache/yay \
    --exclude=$HOME/.local/lib/postgres/ \
    --exclude=$HOME/.local/share/Trash \
    --exclude=$HOME/.var/app/*/cache \
    --exclude=$HOME/Downloads \
    --exclude=$HOME/Documents/MEGA \
    --exclude-if-present=CACHEDIR.TAG \
    --exclude-if-present=.backup-ignore \
    --archive-dir=$HOME/.cache/duplicity \
    --tempdir=/var/tmp \
    $HOME $BACKUP_TO

read -p "Are you sure? " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    echo "Canceling backup."
    exit 1
else
    echo "Starting backup"
fi

duplicity \
    incremental \
    --volsize=25 \
    --timeout=120 \
    --no-encryption \
    --exclude=$HOME/.cache \
    --exclude=$HOME/.cache/duplicity \
    --exclude=$HOME/.cache/yay \
    --exclude=$HOME/.local/lib/postgres/ \
    --exclude=$HOME/.local/share/Trash \
    --exclude=$HOME/.var/app/*/cache \
    --exclude=$HOME/Downloads \
    --exclude=$HOME/Documents/MEGA \
    --exclude-if-present=CACHEDIR.TAG \
    --exclude-if-present=.backup-ignore \
    --archive-dir=$HOME/.cache/duplicity \
    --tempdir=/var/tmp \
    $HOME $BACKUP_TO
