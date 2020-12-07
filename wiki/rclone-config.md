
# Automatic config with B2 env vars:

    export RCLONE_B2_ACCOUNT="set me"
    export RCLONE_B2_KEY="set me"

    export RCLONE_STORAGE_NAME=b2
    export RCLONE_STORAGE_TYPE=b2
    export RCLONE_BUCKET_NAME=testbucketname

    rclone config create $RCLONE_STORAGE_NAME $RCLONE_STORAGE_TYPE env_auth true


# Mounting:

Will mount to `pwd`/storage

    mkdir -p storage
    rclone mount $RCLONE_STORAGE_NAME:$RCLONE_BUCKET_NAME storage

Mount with better performance:

	rclone mount \
	    --vfs-cache-mode writes \
	    --rc \
	    --size-only \
	    --dir-cache-time=2m \
	    --vfs-read-chunk-size=64M \
	    --vfs-cache-max-age 675h \
	    --vfs-read-chunk-size-limit=1G \
	    --buffer-size=32M \
	    --log-level INFO \
	    --timeout 5s \
	    --contimeout 5s \
	    remote:/ /mnt/remote

