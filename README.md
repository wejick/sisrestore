#Hi, recently I don't have time to maintain this script, but it still usable with a little or no modification

Sisrestore is tool for linux (possibly for another unix too) to restore your data state automatically. The idea behind this tool is to provide public computer with always same state, just like deepfreeze software in windows env.

The latest distro I tested is Ubuntu 12.04 LTS, please feel free to test it in the latest distro. There will be possible issues for latest distro with systemd, since I created this script with BSD and SysV5 init style.

Today we have better next gen Filesystem to accomplish this idea eg. BTRFS, ZFS
