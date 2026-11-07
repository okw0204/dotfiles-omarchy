# Linux（Arch・WSL2 など）のブロックデバイス操作用ヘルパー。
# OS 共通の共有設定には含めない。Arch では local.fish が自動で読み込む。
# 他の環境でヘルパーだけを使う場合は、このファイルを ~/.config/fish/linux-disk.fish にコピーし、
# local.fish に `source $__fish_config_dir/linux-disk.fish` を書く。

function __confirm_block_device_erase --argument-names device
    if not test -b "$device"
        echo "Error: $device is not a block device." >&2
        return 1
    end

    set -l mounted (lsblk -nrpo MOUNTPOINT "$device" 2>/dev/null | string match -r '\S+')
    if test (count $mounted) -gt 0
        echo "Error: $device or one of its partitions is mounted." >&2
        return 1
    end

    lsblk -d -o NAME,SIZE,MODEL,TRAN "$device"
    set -l expected "ERASE $device"
    read -l -P "Type '$expected' to continue: " confirm
    test "$confirm" = "$expected"
end

# ISO をブロックデバイスへ書き込む
function iso2sd
    if test (count $argv) -ne 2
        echo "Usage: iso2sd <input_file> <output_device>"
        echo "Example: iso2sd ~/Downloads/ubuntu.iso /dev/sda"
        return 2
    end

    set -l input (path resolve -- "$argv[1]")
    set -l device (path resolve -- "$argv[2]")
    if not test -f "$input"
        echo "Error: $input is not a regular file." >&2
        return 1
    end
    __confirm_block_device_erase "$device"; or return

    sudo dd bs=4M status=progress oflag=sync if="$input" of="$device"; or return
    sudo eject "$device"
end

# ドライブを exFAT で 1 パーティションに初期化
function format-drive
    if test (count $argv) -ne 2
        echo "Usage: format-drive <device> <name>"
        echo "Example: format-drive /dev/sda 'My Stuff'"
        return 2
    end

    set -l device (path resolve -- "$argv[1]")
    set -l label "$argv[2]"
    if test (string length -- "$label") -gt 15
        echo "Error: exFAT labels are limited to 15 characters." >&2
        return 1
    end
    __confirm_block_device_erase "$device"; or return

    sudo wipefs -a "$device"; or return
    sudo parted -s "$device" mklabel gpt; or return
    sudo parted -s "$device" mkpart primary 1MiB 100%; or return

    if string match -qr '/(nvme\d+n\d+|mmcblk\d+|loop\d+)$' -- "$device"
        set -l partition "$device"p1
    else
        set -l partition "$device"1
    end

    sudo partprobe "$device"; or return
    sudo udevadm settle; or return
    for attempt in (seq 1 20)
        test -b "$partition"; and break
        sleep 0.1
    end
    if not test -b "$partition"
        echo "Error: partition $partition did not appear." >&2
        return 1
    end

    sudo mkfs.exfat -n "$label" "$partition"; or return
    echo "Drive $device formatted as exFAT and labeled '$label'."
end
