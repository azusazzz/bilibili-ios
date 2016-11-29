

function download() {

if [ ! -f shellTemp/$1 ];
then
echo "正在下载${1}..."
curl "http://oh32pp4u5.bkt.clouddn.com/${1}" --create-dirs -o shellTemp/$1
fi

if [ ! -f shellTemp/$1 ];
then
echo "下载失败: ${1}"
exit -1
fi

mkdir -p $2

unzip -o shellTemp/$1 -d $2

}

download "ijkplayer-k0.7.4.zip" "bilibili/Librarys" "IJKMediaFramework.framework"
download "wax.zip" "bilibili/Librarys" "wax.framework"
rm -r bilibili/Librarys/__MACOSX


