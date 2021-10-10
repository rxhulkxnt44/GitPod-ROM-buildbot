# Rom building script for CircleCI
# coded by bruh™ aka Live0verfl0w

MANIFEST_LINK=https://github.com/Project-Fluid/manifest.git
BRANCH=fluid-12
ROM_NAME=fluid
DEVICE_CODENAME=vince
GITHUB_USER=rk134
GITHUB_EMAIL=rahul.kantrapally@gmail.com
WORK_DIR=$(pwd)/${ROM_NAME}
JOBS=nproc

# Set up git!
git config --global user.name ${GITHUB_USER}
git config --global user.email ${GITHUB_EMAIL}

# make directories
mkdir ${WORK_DIR} && cd ${WORK_DIR}

# set up rom repo
repo init --depth=1 -u ${MANIFEST_LINK} -b ${BRANCH}
repo sync --current-branch --force-sync --no-clone-bundle --no-tags --optimized-fetch --prune -j${JOBS}

# clone device sources
rm -rf hardware/qcom-caf/msm8996/audio
rm -rf hardware/qcom-caf/msm8996/display
rm -rf hardware/qcom-caf/msm8996/media
git clone -b A12-fluid-WIP https://github.com/rxhulkxnt44/device_xiaomi_vince.git device/xiaomi/vince
git clone -b arrow https://github.com/rxhulkxnt44/vendor_xiaomi_vince.git device/xiaomi/vince
git clone -b arrow https://github.com/rxhulkxnt44/vendor_xiaomi_vince.git vendor/xiaomi/vince
cd hardware/qcom-caf/msm8996
git clone -b eleven https://github.com/PixelExperience/hardware_qcom-caf_msm8996-r_display.git hardware/qcom-caf/msm8996/display
git clone -b eleven https://github.com/PixelExperience/hardware_qcom-caf_msm8996-r_audio.git hardware/qcom-caf/msm8996/audio
git clone -b eleven https://github.com/PixelExperience/hardware_qcom-caf_msm8996-r_media.git hardware/qcom-caf/msm8996/media
cd ../../../


# Start building!
. build/envsetup.sh
lunch fluid_${DEVICE_CODENAME}-eng
make sepolicy

