#!/bin/bash

_pwm=/sys/class/pwm/pwmchip0/pwm0
_enable=$_pwm/enable
_duty=$_pwm/duty_cycle
_period=$_pwm/period

# Export pwm channel if is not available
if [ ! -e $_pwm ]; then
    echo 0 > /sys/class/pwm/pwmchip0/export
fi

if [ ! -e $_pwm ]; then
   exit -1
fi

# Default PWM period (nanoseconds) 200Hz
period=5000000
duty=0

if [ -s $1 ]; then
  echo "missing duty arg"
  exit -2
fi

duty=$(( $period*$1/100 ))

#if [[ $(cat $_period) == 0 ]]; then
  echo $period > $_period
#fi

if [[ $(cat $_enable) == 0 ]]; then
  echo 1 > $_enable
fi

echo $duty > $_duty

exit 0
