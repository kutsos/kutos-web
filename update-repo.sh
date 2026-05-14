#!/usr/bin/env bash

# KutOs Repo Güncelleme Scripti
# Bu script x86_64 klasöründeki paketleri tarar ve veritabanını günceller.

REPO_NAME="kutos-repo"
ARCH="x86_64"

echo "--- KutOs Repo Güncelleniyor ---"

if [ ! -d "$ARCH" ]; then
    echo "Hata: $ARCH klasörü bulunamadı!"
    exit 1
fi

cd "$ARCH"

# Eski veritabanı dosyalarını temizle (opsiyonel ama daha temiz olur)
rm -f "$REPO_NAME.db" "$REPO_NAME.db.tar.gz" "$REPO_NAME.files" "$REPO_NAME.files.tar.gz"

echo "Paketler veritabanına ekleniyor..."
# Klasördeki tüm .pkg.tar.zst dosyalarını ekle
repo-add "$REPO_NAME.db.tar.gz" *.pkg.tar.zst

# Sembolik linkleri oluştur (pacman'in standart araması için)
ln -s "$REPO_NAME.db.tar.gz" "$REPO_NAME.db"
ln -s "$REPO_NAME.files.tar.gz" "$REPO_NAME.files"

echo "--- İşlem Tamamlandı ---"
echo "Şimdi tüm dosyaları GitHub'a push edebilirsin."
