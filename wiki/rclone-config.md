
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
