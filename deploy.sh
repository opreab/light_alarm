#!/usr/bin/env bash

USB_PORT=/dev/ttyUSB0
BAUD=460800
AMPY="python3 /home/${USER}/.local/lib/python3.6/site-packages/ampy/cli.py"

USAGE=$(cat << EOF
$0 firmware <firmware path>
$0 code [[<src code path>] [<dst code path>]]
$0 shell

EOF
)

if [ $# -lt 1 ]; then
    printf "ERROR: Invalid arguments. Usage: \n${USAGE}"
    exit 1
fi

OPT=$1

case ${OPT} in
    "firmware")
        firmware=${2}
        echo "Deploying firmware ${firmware} on device ${USB_PORT}"
        esptool.py --port ${USB_PORT} --baud ${BAUD} write_flash --flash_size=detect 0 ${firmware}
    ;;
    "code")
        src=${2:-src}
        dst=${3}
        echo "Deploying ${src} on device ${USB_PORT} to path ${dst:-/}"
        ${AMPY} --port ${USB_PORT} put ${src} ${dst}
    ;;
    "shell")
        picocom ${USB_PORT} -b115200
    ;;
*)
      echo ${USAGE}
  ;;
esac

