@echo off
set USER="nifi"
set HOST="nifi"
set SSH_CMD=ssh
set COMMAND=/home/nifi/scripts/nifi-reboot-node.sh

%SSH_CMD% %USER%@%HOST% %COMMAND%
pause
