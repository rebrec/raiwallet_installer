#!/bin/bash

SCRIPT_PATH="$( cd "$(dirname "$0")" ; pwd -P  )"
DESTINATION_PATH=/opt/raiblocks/wallet/
SHORTCUT_PATH=$HOME/.local/share/applications
SHORTCUT_ICON_NAME=Raiblocks_Logo.png
SHORTCUT_NAME=RaiBlocksWallet
WALLET_FOLDER_NAME=RaiBlocks
DOCKER_IMAGE_NAME=rebrec/rai_wallet
DOCKER_RUN_FILE=/root/rai_wallet
IMAGE_URL=https://github.com/rebrec/raiwallet_installer/raw/master/Raiblocks_Logo.png
DESKTOP_PATH=$(xdg-user-dir DESKTOP)

if [[ -z "${SUDO_USER}"  ]]; then
    echo "To work, this script need to be run using sudo : "
    echo "sudo $0"
    exit -1
fi
USER="${SUDO_USER}"

mkdir -p "${DESTINATION_PATH}"

# Build of the shortcut
echo "[+] Building shortcut to ${DESTINATION_PATH}/${SHORTCUT_NAME}.desktop"
cat > "${DESTINATION_PATH}/${SHORTCUT_NAME}.desktop" << EOF
[Desktop Entry]
Encoding=UTF-8
Name=rai_wallet
Comment=RaiBlocks Wallet Docker container
Exec=/bin/bash "sg docker docker run -d  -p 7075:7075/udp -p 7075:7075 -p 127.0.0.1:7076:7076 -e DISPLAY=\$DISPLAY -e USER=\$(id -u) -e GROUP=\$(id -g) -v /tmp/.X11-unix/:/tmp/.X11-unix -v \$HOME/$WALLET_FOLDER_NAME:/root/$WALLET_FOLDER_NAME -ti --rm $DOCKER_IMAGE_NAME $DOCKER_RUN_FILE"
Icon=$DESTINATION_PATH/$SHORTCUT_ICON_NAME
Categories=Application;Cryptocurrencies;Raiblocks;Wallet
Version=1.0
Type=Application
Terminal=0
EOF

# Build of the uninstall script
echo "[+] Building the uninstall script to ${DESTINATION_PATH}/uninstall.sh"

cat > "${DESTINATION_PATH}/uninstall.sh" << EOF
#!/bin/sh

SCRIPT_PATH=$SCRIPT_PATH
DESTINATION_PATH=$DESTINATION_PATH
SHORTCUT_PATH=$SHORTCUT_PATH
SHORTCUT_ICON_NAME=$SHORTCUT_ICON_NAME
SHORTCUT_NAME=$SHORTCUT_NAME
WALLET_FOLDER_NAME=$WALLET_FOLDER_NAME
DOCKER_IMAGE_NAME=$DOCKER_IMAGE_NAME
DOCKER_RUN_FILE=$DOCKER_RUN_FILE
DESKTOP_PATH=$DESKTOP_PATH

rm -f "\$SHORTCUT_PATH/\$SHORTCUT_NAME.desktop"
rm -f "\$DESKTOP_PATH/\$SHORTCUT_NAME.desktop"
rm -rf "\$DESTINATION_PATH"
sg docker docker rmi \$DOCKER_IMAGE_NAME

update-desktop-database

echo Uninstallation done
EOF

echo "[+] Installing docker.io"
apt-get install --assume-yes docker.io

echo "[+] Adding $USER to 'docker' group"
adduser $USER docker

echo "[+] Adding X Server autorizations"
xhost local:root

echo "[+] Download prebuild docker image"
sg docker "docker pull ${DOCKER_IMAGE_NAME}"

echo "[+] Copy Image to $DESTINATION_PATH"
wget "${IMAGE_URL}" -P "${DESTINATION_PATH}"

echo "[+] Copy the shortcut to $DESKTOP_PATH"
cp -f "${DESTINATION_PATH}/${SHORTCUT_NAME}.desktop" "${DESKTOP_PATH}"

echo "[+] Copy the shortcut to $SHORTCUT_PATH"
cp -f "${DESTINATION_PATH}/${SHORTCUT_NAME}.desktop" "${SHORTCUT_PATH}"

echo "[+] Update Desktop Icons"
update-desktop-database



echo "********************************************"
echo "********************************************"
echo "****************        ********************"
echo "****************  Done  ********************"
echo "****************        ********************"
echo "********************************************"
echo "********************************************"
echo "****                                    ****"
echo "****   RaiBlocks Wallet is installed    ****"
echo "****   and should be available on your  ****"
echo "****   desktop and your Application     ****"
echo "****   Menu                             ****"
echo "****                                    ****"
echo "********************************************"
echo "********************************************"
echo "********************************************"
