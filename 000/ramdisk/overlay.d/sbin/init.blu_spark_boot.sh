#!/system/bin/sh

# (c) 2018-2020 changes for blu_spark by eng.stk

# Wait to set proper init values
sleep 30

# Disable zram
swapoff /dev/block/zram0

# Set TCP congestion algorithm
echo "westwood" > /proc/sys/net/ipv4/tcp_congestion_control

# Tweak IO performance after boot complete
echo "zen" > /sys/block/sda/queue/scheduler
echo 512 > /sys/block/sda/queue/read_ahead_kb

# Enable Adaptive LMK
echo 1 > /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk

# Disable thermal hotplug to switch governor
echo 0 > /sys/module/msm_thermal/core_control/enabled
echo "disable" > /sys/devices/soc/soc:qcom,bcl/mode
echo 0 > /sys/devices/soc/soc:qcom,bcl/hotplug_mask
echo 0 > /sys/devices/soc/soc:qcom,bcl/hotplug_soc_mask
echo "enable" > /sys/devices/soc/soc:qcom,bcl/mode

# Input boost and stune configuration
echo "0:1036800 1:0 2:0 3:0 4:0 5:0 6:0 7:0" > /sys/module/cpu_boost/parameters/input_boost_freq
echo 500 > /sys/module/cpu_boost/parameters/input_boost_ms
echo 5 > /dev/stune/top-app/schedtune.boost

# Disable scheduler core_ctl
echo 0 > /sys/devices/system/cpu/cpu0/core_ctl/enable
echo 0 > /sys/devices/system/cpu/cpu4/core_ctl/enable

# Set min cpu freq
echo 518400 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
echo 806400 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq

# Configure cpu governor settings
echo "blu_active" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
echo 20000 > /sys/devices/system/cpu/cpu0/cpufreq/blu_active/above_hispeed_delay
echo 90 > /sys/devices/system/cpu/cpu0/cpufreq/blu_active/go_hispeed_load
echo 20000 > /sys/devices/system/cpu/cpu0/cpufreq/blu_active/timer_rate
echo 1248000 > /sys/devices/system/cpu/cpu0/cpufreq/blu_active/hispeed_freq
echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/blu_active/io_is_busy
echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/blu_active/align_windows
echo "83 1804800:95" > /sys/devices/system/cpu/cpu0/cpufreq/blu_active/target_loads
echo 20000 > /sys/devices/system/cpu/cpu0/cpufreq/blu_active/min_sample_time
echo 20000 > /sys/devices/system/cpu/cpu0/cpufreq/blu_active/timer_slack
echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/blu_active/fastlane
echo 50 > /sys/devices/system/cpu/cpu0/cpufreq/blu_active/fastlane_threshold
echo "blu_active" > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
echo 20000 > /sys/devices/system/cpu/cpu4/cpufreq/blu_active/above_hispeed_delay
echo 90 > /sys/devices/system/cpu/cpu4/cpufreq/blu_active/go_hispeed_load
echo 20000 > /sys/devices/system/cpu/cpu4/cpufreq/blu_active/timer_rate
echo 1574400 > /sys/devices/system/cpu/cpu4/cpufreq/blu_active/hispeed_freq
echo 0 > /sys/devices/system/cpu/cpu4/cpufreq/blu_active/io_is_busy
echo 1 > /sys/devices/system/cpu/cpu4/cpufreq/blu_active/align_windows
echo "83 1939200:90 2016000:95" > /sys/devices/system/cpu/cpu4/cpufreq/blu_active/target_loads
echo 20000 > /sys/devices/system/cpu/cpu4/cpufreq/blu_active/min_sample_time
echo 20000 > /sys/devices/system/cpu/cpu4/cpufreq/blu_active/timer_slack
echo 0 > /sys/devices/system/cpu/cpu4/cpufreq/blu_active/fastlane
echo 50 > /sys/devices/system/cpu/cpu4/cpufreq/blu_active/fastlane_threshold

# Re-enable thermal hotplug
echo 1 > /sys/module/msm_thermal/core_control/enabled
echo "disable" > /sys/devices/soc/soc:qcom,bcl/mode
echo 0 > /sys/devices/soc/soc:qcom,bcl/hotplug_mask
echo 0 > /sys/devices/soc/soc:qcom,bcl/hotplug_soc_mask
echo "enable" > /sys/devices/soc/soc:qcom,bcl/mode

# Enable OTG by default
echo 1 > /sys/class/power_supply/usb/otg_switch

# Set zram config
echo 1 > /sys/block/zram0/reset
echo 2202009600 > /sys/block/zram0/disksize
mkswap /dev/block/zram0
swapon /dev/block/zram0 -p 32758

echo "Boot blu_spark completed " >> /dev/kmsg

