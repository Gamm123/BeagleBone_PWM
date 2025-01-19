#!/bin/bash

# Parameters
DEFAULT_PERIOD=10000000  # Default period in nanoseconds
PWM_VALUE=$1
PERIOD_PATH="/sys/class/pwm/pwmchip0/pwm0/period"
DUTY_CYCLE_PATH="/sys/class/pwm/pwmchip0/pwm0/duty_cycle"
ENABLE_PATH="/sys/class/pwm/pwmchip0/pwm0/enable"

# Check if period is correctly configured
if [ ! -f "$PERIOD_PATH" ] || [ "$(cat $PERIOD_PATH)" -ne "$DEFAULT_PERIOD" ]; then
    echo "$DEFAULT_PERIOD" > "$PERIOD_PATH"
    echo "PWM period set to $DEFAULT_PERIOD ns"
fi

# Calculate the effective duty_cycle
DUTY_CYCLE=$((PWM_VALUE * DEFAULT_PERIOD / 100))

# Check if PWM is enabled
if [ ! -f "$ENABLE_PATH" ]; then
    echo "Error: $ENABLE_PATH does not exist."
    exit 3
fi

if [ "$(cat $ENABLE_PATH)" -eq 0 ]; then
    echo 1 > "$ENABLE_PATH"
    echo "PWM enabled."
else
    echo "PWM already enabled."
fi

# Update the duty_cycle
if [ -w "$DUTY_CYCLE_PATH" ]; then
    echo "$DUTY_CYCLE" > "$DUTY_CYCLE_PATH"
    echo "Duty cycle updated to: $DUTY_CYCLE ns"
else
    echo "Error: Unable to write to $DUTY_CYCLE_PATH. Check permissions."
    exit 2
fi

