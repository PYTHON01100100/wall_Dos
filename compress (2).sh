#!/bin/bash

mkdir -p output

# ضغط JPEG بأقصى كفاءة ممكنة مع الحفاظ على جودة مقبولة
for ext in jpg jpeg jpe jfif; do
  find . -type f -iname "*.${ext}" | while read file; do
    filename=$(basename "$file")
    cp "$file" "output/${filename}"
    jpegoptim --strip-all --max=80 --all-progressive "output/${filename}"
  done
done

# ضغط PNG دون فقد جودة
for ext in png bmp; do
  find . -type f -iname "*.${ext}" | while read file; do
    filename=$(basename "$file")
    cp "$file" "output/${filename}"
    optipng -o7 "output/${filename}" > /dev/null
  done
done

# ضغط WebP بجودة متوازنة
for ext in webp; do
  find . -type f -iname "*.${ext}" | while read file; do
    filename=$(basename "$file")
    name="${filename%.*}"
    cwebp -q 80 "$file" -o "output/${name}.webp"
  done
done

echo "✅ تم ضغط جميع الصور إلى أقصى حد ممكن بدون فقدان ملحوظ للجودة. الملفات في مجلد output/"

