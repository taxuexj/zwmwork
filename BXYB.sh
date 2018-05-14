#!/bin/bash
echo $PATH
export Here_PATH=/home/WORK/ecens
export rawdata_PATH=${Here_PATH}/rawdata
export PATH=$PATH:${Here_PATH}/bin
echo $PATH
################################################################################################
#日期计算
today=`date -d "today"  +%d`
today_mmdd=`date -d "today"  +%m%d`
today_yymmdd=`date -d "today"  +%y%m%d`
today_yyyymmdd=`date -d "today"  +%Y%m%d`
echo 今天是：${today}日${today_yyyymmdd}
yesterday=`date -d "yesterday"  +%d`
yesterday_mmdd=`date -d "yesterday"  +%m%d`
yesterday_yymmdd=`date -d "yesterday"  +%y%m%d`
yesterday_yyyymmdd=`date -d "yesterday"  +%Y%m%d`
echo 昨天是：${yesterday}日${yesterday_yyyymmdd}
thedaybefor=`date -d " -2 day"  +%d`
thedaybefor_mmdd=`date -d " -2 day"  +%m%d`
thedaybefor_yymmdd=`date -d " -2 day"  +%y%m%d`
thedaybefor_yyyymmdd=`date -d " -2 day"  +%Y%m%d`
echo 前天是：${thedaybefor}日${thedaybefor_yyyymmdd}
sc='00'
echo ${sc}
if [ "${sc}" = "18" ] || [ "${sc}" = "12" ]
then
mmdd=${yesterday_mmdd}
yyyymmdd=${yesterday_yyyymmdd}
fi
if [ "${sc}" = "00" ] || [ "${sc}" = "06" ]
then
mmdd=${today_mmdd}
yyyymmdd=${today_yyyymmdd}
fi
echo initial date：${yyyymmdd} ${mmdd}
################################################################################################
ftpsrc='FTP_GET'
cat > ${ftpsrc} << EOF
user ybzx qxtybzx
bi
prompt
pass
cd /D:/FTP/products/BXYB/2018
mget *${yyyymmdd}20${sc}.024
bye
EOF
ftp -nv 172.18.73.122 < ${ftpsrc}
################################################################################################
ls *${yyyymmdd}20${sc}.024|while read line
echo ${line}
do
   mv ${line} ${yyyymmdd}20${sc}.024
done
ftpsrc='FTP_PUT'
cat > ${ftpsrc} << EOF
user ybzx qxtybzx
bi
prompt
pass
cd /D:/FTP/products/BXYB/2018
{yyyymmdd}20${sc}.024
bye
EOF
ftp -nv 172.18.73.122 < ${ftpsrc}
################################################################################################
exit
