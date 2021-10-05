# mcHAT RTC & FUN Installation guide

## FUN Control by script at Raspbian
1. add at the end to /boot/config.txt -> dtoverlay=pwm,pin=18,func=2
```
nano /boot/config.txt
```
2. Reboot
```
reboot
```
3. Copy fun.sh script to your location in raspbian (for example /home/pi/)
4. By calling of fun.sh with parameter 0-100 set PWM power output (50 -> set fun to 50%)
```
. /home/pi/fun.sh 50
```
5. By edit of parameter period=5000000 inside of script you can change PWM frequency. Default is 5000000 => 200Hz.

## Automatic regulation script at Raspbian
1. Copy also fun_control.sh
2. 

## Enable Hardware RTC
1. Turn on the I2C bus -> open terminal or ssh -> sudo raspi-config -> Advanced Options -> Interfacing options -> I2C -> Enable
2. In raspi-config set timezone na Europe/Prague.
```
sudo raspi-config
```
3. Reboot
```
reboot
```
4. Install i2c-tool
```
sudo apt-get install python-smbus i2c-tools
```
5. Turn on the kernel module for hw rtc by add at the end to /boot/config.txt -> dtoverlay=i2c-rtc,ds1307
```
sudo nano /boot/config.txt
```
6. Turn off fake HW clock
```
sudo apt-get -y remove fake-hwclock
sudo update-rc.d -f fake-hwclock remove
```
7. Set real HW clock by comment line in file
```
sudo nano /lib/udev/hwclock-set
```
8. comment 3 lines by #
```
#if [ -e /run/systemd/system ] ; then 
#exit 0 
#fi
```
9. update date time
```
date
```
10. If the date time is ok and actual set the time to hw rtc
```
sudo hwclock -w
```
11. Check the time by read it back
```
sudo hwclock -r
```
12. Try shutdown the raspberry, disconnect it from internet and turn on. After boot check the time
```
date
sudo hwclock -r
```
