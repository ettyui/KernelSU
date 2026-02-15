#!/bin/bash

word1="com"
word2="chaozh"
word3="iReaderFree"
APP_NAME="掌阅"

export word1 word2 word3

# ====== 1. 修改包名（重命名目录）======
echo "正在修改包名目录结构..."
find . -depth -type d -name 'me' -execdir mv {} "$word1" \;
find . -depth -type d -name 'weishu' -execdir mv {} "$word2" \;
find . -depth -type d -name 'kernelsu' -execdir mv {} "$word3" \;

# ====== 2. 修改包名（替换文件内容）======
echo "正在替换文件中的包名..."
find . -type f -exec sed -i \
    -e "s/me\.weishu\.kernelsu/$word1.$word2.$word3/g" \
    -e "s/me\/weishu\/kernelsu/$word1\/$word2\/$word3/g" \
    -e "s/me_weishu_kernelsu/${word1}_${word2}_${word3}/g" {} +

# ====== 3. 修改应用名称（精准匹配）======
echo "正在修改应用名称为: $APP_NAME"
sed -i 's/<string name="app_name" translatable="false">KernelSU<\/string>/<string name="app_name" translatable="false">'"$APP_NAME"'<\/string>/' app/src/main/res/values/strings.xml

# ====== 4. 图标功能（暂不启用，代码已注释）======
# echo "正在替换应用图标..."
# 以后需要时，可以：
# 1. 先把图标文件放到仓库的某个目录（比如 custom_icons/）
# 2. 取消下面的注释，并根据实际目录调整路径

# 方法 A：从仓库目录复制图标文件
# cp ../custom_icons/ic_launcher.png app/src/main/res/mipmap-hdpi/ic_launcher.png
# cp ../custom_icons/ic_launcher.png app/src/main/res/mipmap-xhdpi/ic_launcher.png
# cp ../custom_icons/ic_launcher.png app/src/main/res/mipmap-xxhdpi/ic_launcher.png
# cp ../custom_icons/ic_launcher.png app/src/main/res/mipmap-xxxhdpi/ic_launcher.png

# 方法 B：从网络下载图标文件
# wget -O app/src/main/res/mipmap-hdpi/ic_launcher.png https://example.com/ic_launcher.png
# wget -O app/src/main/res/mipmap-xhdpi/ic_launcher.png https://example.com/ic_launcher.png
# wget -O app/src/main/res/mipmap-xxhdpi/ic_launcher.png https://example.com/ic_launcher.png
# wget -O app/src/main/res/mipmap-xxxhdpi/ic_launcher.png https://example.com/ic_launcher.png

# 方法 C：使用 base64 解码
# echo "iVBORw0KGgoAAAANSUhEUgAA..." | base64 -d > app/src/main/res/mipmap-hdpi/ic_launcher.png
# echo "iVBORw0KGgoAAAANSUhEUgAA..." | base64 -d > app/src/main/res/mipmap-xhdpi/ic_launcher.png
# echo "iVBORw0KGgoAAAANSUhEUgAA..." | base64 -d > app/src/main/res/mipmap-xxhdpi/ic_launcher.png
# echo "iVBORw0KGgoAAAANSUhEUgAA..." | base64 -d > app/src/main/res/mipmap-xxxhdpi/ic_launcher.png

echo "Done."