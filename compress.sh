#!/bin/bash

mkdir -p output

for ext in jpg jpeg jpe jfif; do
  find . -type f -iname "*.${ext}" | while read file; do
    filename=$(basename "$file")
    name="${filename%.*}"
    convert "$file" -quality 60 "output/${name}.jpg"
  done
done

for ext in png bmp; do
  find . -type f -iname "*.${ext}" | while read file; do
    filename=$(basename "$file")
    name="${filename%.*}"
    convert "$file" -quality 75 "output/${name}.png"
  done
done

for ext in webp; do
  find . -type f -iname "*.${ext}" | while read file; do
    filename=$(basename "$file")
    name="${filename%.*}"
    cwebp -q 60 "$file" -o "output/${name}.webp"
  done
done

echo "✅ تم ضغط جميع الصور بدون تغيير الحجم. تجدها في مجلد output/"

