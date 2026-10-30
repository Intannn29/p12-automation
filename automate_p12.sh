#!/bin/bash
# Script Otomasi P12 - Integrasi SSH Key & SCP File Transfer

TARGET_HOST="127.0.0.1"
TARGET_USER="deployer"
SSH_KEY_PATH="$HOME/.ssh/id_p12_automation"

# Membuat direktori artefak lokal sebagai simulasi
mkdir -p ./artifacts
echo "File artefak deployment otomatis P12" > ./artifacts/deploy_package.txt

SRC_FILE="./artifacts/deploy_package.txt"
DEST_PATH="/home/deployer/"

echo "[+] Memulai transfer artefak via SCP menggunakan SSH Key..."
scp -i "$SSH_KEY_PATH" -o StrictHostKeyChecking=no "$SRC_FILE" "${TARGET_USER}@${TARGET_HOST}:${DEST_PATH}"

if [ $? -eq 0 ]; then
    echo "[SUCCESS] Transfer file SCP berhasil!"

    echo "[+] Menjalankan verifikasi jarak jauh via SSH..."
    ssh -i "$SSH_KEY_PATH" "${TARGET_USER}@${TARGET_HOST}" "ls -la ${DEST_PATH} && echo 'Deployment remote sukses!'"
else
    echo "[FAILED] Transfer file SCP gagal."
    exit 1
fi
