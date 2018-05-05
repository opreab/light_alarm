# light_alarm

## Env setup
```bash
# non root access to serial usb
sudo usermod -a -G dialout $USER

#ampy setup
pip3 install adafruit-ampy

cat << EOF >> ~/.bashrc

# ampy loader
alias ampy="python3 /home/$USER/.local/lib/python3.6/site-packages/ampy/cli.py"

EOF
```