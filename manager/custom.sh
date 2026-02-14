#!/bin/bash

# ====== 自定义配置 ======
word1="com"
word2="chaozh"
word3="iReaderFree"
APP_NAME="掌阅"  # 你的应用名称

# Export variables for use in find -exec
export word1 word2 word3

# ====== 1. 修改包名（重命名目录）======
find . -depth -type d -name 'me' -execdir mv {} "$word1" \;
find . -depth -type d -name 'weishu' -execdir mv {} "$word2" \;
find . -depth -type d -name 'kernelsu' -execdir mv {} "$word3" \;

# ====== 2. 修改包名（替换文件内容）======
find . -type f -exec sed -i \
    -e "s/me\.weishu\.kernelsu/$word1.$word2.$word3/g" \
    -e "s/me\/weishu\/kernelsu/$word1\/$word2\/$word3/g" \
    -e "s/me_weishu_kernelsu/${word1}_${word2}_${word3}/g" {} +

# ====== 3. 修改应用名称 ======
echo "正在修改应用名称为: $APP_NAME"
find res -name "strings.xml" -exec sed -i "s/<string name=\"app_name\">.*<\/string>/<string name=\"app_name\">$APP_NAME<\/string>/g" {} \;

# ====== 4. 修改图标（暂不启用，代码已注释）======
# echo "正在替换应用图标..."
# 如果你以后需要启用图标功能，可以：
# 1. 先把图标文件放到仓库的某个目录（比如 custom_icons/）
# 2. 取消下面的注释，并根据实际目录调整路径

# 方法 A：从仓库目录复制图标文件
# cp ../custom_icons/ic_launcher.png res/mipmap-hdpi/ic_launcher.png
# cp ../custom_icons/ic_launcher.png res/mipmap-xhdpi/ic_launcher.png
# cp ../custom_icons/ic_launcher.png res/mipmap-xxhdpi/ic_launcher.png
# cp ../custom_icons/ic_launcher.png res/mipmap-xxxhdpi/ic_launcher.png

# 方法 B：从网络下载图标文件（需要你有图标的 URL）
# wget -O res/mipmap-hdpi/ic_launcher.png https://example.com/ic_launcher.png
# wget -O res/mipmap-xhdpi/ic_launcher.png https://example.com/ic_launcher.png
# wget -O res/mipmap-xxhdpi/ic_launcher.png https://example.com/ic_launcher.png
# wget -O res/mipmap-xxxhdpi/ic_launcher.png https://example.com/ic_launcher.png

# 方法 C：使用 base64 解码（需要先把图标转成 base64）
# echo "图标 base64 字符串" | base64 -d > res/mipmap-hdpi/ic_launcher.png
# echo "图标 base64 字符串" | base64 -d > res/mipmap-xhdpi/ic_launcher.png
# echo "图标 base64 字符串" | base64 -d > res/mipmap-xxhdpi/ic_launcher.png
# echo "图标 base64 字符串" | base64 -d > res/mipmap-xxxhdpi/ic_launcher.png

echo "Done."