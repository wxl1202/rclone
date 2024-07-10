# GitHub Actions for Rclone

This Action wraps [Rclone](https://rclone.org) to enable syncing files and directories to and from different cloud storage providers.


## Features
 * "rsync for cloud storage"
 * Sync to and from different cloud storage providers.
 * Backup files or deploy artifacts to remote storage.


## Usage

### GitHub Actions
```
env:
  HOST: ${{ secrets.GCP_SFTP_HOST }}
  USERNAME: {ACCOUNT}
  KEYPASS: ${{ secrets.GCP_SFTP_KEY }}
  PATH_FROM: {PATH}
  PATH_DEST: {PATH}

jobs:
  deployment:
    #needs: [codescanner]
    name: File synchronize via SFTP
    runs-on: ubuntu-latest
    #environment: {stage/production}

    steps:
    - id: repo-checkout
      name: Checkout repository
      uses: actions/checkout@v3
      with:
        fetch-depth: 0

    - id: rclone-files
      name: File synchronize via Rclone
      uses: PChome24h/action_rclone@master
      env:
        RCLONE_SFTP_HOST: ${{ env.HOST }}
        RCLONE_SFTP_USER: ${{ env.USERNAME }}
        RCLONE_SFTP_KEY_PEM: ${{ env.KEYPASS }}
        RCLONE_SFTP_SHELL_TYPE: 'none'
        RCLONE_SFTP_IDLE_TIMEOUT: 0m10s
      with:
        args: sync --progress ${{ env.PATH_FROM }} :sftp:${{ env.PATH_DEST }}
```
* Using repository secrets to store keys. [Read instructions](https://docs.github.com/en/actions/security-guides/encrypted-secrets#creating-encrypted-secrets-for-a-repository).
* **IMPORTANT! :** Key format information [documents](https://github.com/rclone/rclone/blob/master/docs/content/sftp.md#ssh-authentication).
* `RCLONE_CONFIG` can be omitted if [CLI arguments](https://rclone.org/flags/#backend-flags) or [environment variables](https://rclone.org/docs/#environment-variables) are supplied. `RCLONE_CONFIG` can also be encrypted if [`RCLONE_CONFIG_PASS`](https://rclone.org/docs/#configuration-encryption) secret is supplied.

## Reference
* Original repository: https://github.com/wei/rclone
* Rclone SFTP manual: https://github.com/rclone/rclone/blob/master/docs/content/sftp.md
* Restore original modification time of files based on the date of the most recent commit that modified them: https://github.com/MestreLion/git-tools/
