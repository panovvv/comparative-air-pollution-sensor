#!/usr/bin/env sh

# User-defined variables

# Follow this guide to log in without a password:
#https://alvinalexander.com/linux-unix/how-use-scp-without-password-backups-copy
SBC_USER=pi
SBC_IP=192.168.2.107

# We don't want to copy that over
VENV_PATH=venv

# End of user-defined variables

SBC_USER_AT_IP="$SBC_USER@$SBC_IP"
THIS_SCRIPT=$(basename "$0")
ROOT_DIR="$( cd "$( dirname "$0" )" && pwd )"

case $1 in
    cp)
      rsync -arv --exclude="$VENV_PATH" --exclude="$THIS_SCRIPT" \
      --exclude=.idea "$ROOT_DIR" $SBC_USER_AT_IP:/home/$SBC_USER/
    ;;
    venv)
      ssh $SBC_USER_AT_IP python3 -m venv ./venv && . ./venv/bin/activate && \
		  pip install -r requirements.txt
    ;;
    run)
      ssh $SBC_USER_AT_IP . ./venv/bin/activate && python main.py
    ;;
esac