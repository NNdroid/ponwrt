#!/usr/bin/env bash
# 简易增量重编：现有编译树已编过旧版，只更新 pon_userspace feed 后重编。
# 在 buildroot (如 ~/ponwrt) 下运行：  bash build-vlanscan.sh
set -e
cd "$(dirname "$0")"
./scripts/feeds update pon_userspace
./scripts/feeds install -a -p pon_userspace
rm -rf tmp
./scripts/kconfig.pl + configs/an7581.config configs/release.config > .config
make defconfig
make -j"$(nproc)"
echo "feeds/pon_userspace tip = $(git -C feeds/pon_userspace log -1 --format=%h)"
echo "刷机后记得 Ctrl+F5 强刷浏览器，否则 LuCI 按钮仍像点不动。"
