
rm -rf /sdcard/meminfo
mkdir /sdcard/meminfo
count=0
while (true)
do
time=`date '+%Y_%m%d_%H%M%S_%N'`
dumpsys -t 60 meminfo        | tee -a /sdcard/meminfo/dumpsys_meminfo_$time.txt
cat /proc/meminfo            | tee -a /sdcard/meminfo/dumpsys_meminfo_$time.txt
cat /proc/vmallocinfo | grep vmalloc | awk '{sum = sum + $2} END {print "vmalloc:", sum/1024}' | tee -a /sdcard/meminfo/dumpsys_meminfo_$time.txt
cat /d/ion/ion_mm_heap | grep "  total orphaned" | tee -a /sdcard/meminfo/dumpsys_meminfo_$time.txt
cat /d/ion/ion_mm_heap | grep "          total"  | tee -a /sdcard/meminfo/dumpsys_meminfo_$time.txt
echo "------------------------------------"
count=$(($count+1))
echo "cout: " $count
sleep 1
done
