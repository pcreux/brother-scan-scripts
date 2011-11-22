#! /bin/sh
# Based on http://welcome.solutions.brother.com/bsc/public_s/id/linux/en/instruction_scn4.html
set +o noclobber
#
#   $1 = scanner device
#   $2 = friendly name
#

#   
#       100,200,300,400,600
#
resolution=150
device=$1
BASE=~/Dropbox/Evernote

sleep  0.01

file_name=$(date | sed s/' '/'_'/g | sed s/'\:'/'_'/g)
output_tmp=/tmp/$file_name
output=$BASE/$file_name

echo "scan from $2($device)"
scanadf --device-name "$device" --resolution $resolution -o"$output_tmp"_%04d
for pnmfile in $(ls "$output_tmp"*)
do
   echo convert  "$pnmfile"  "$pnmfile".jpg
   convert  "$pnmfile" "$pnmfile".jpg
   echo convert  "$pnmfile".jpg "$pnmfile".pdf
   convert  "$pnmfile".jpg "$pnmfile".pdf
   echo mv "$pnmfile".pdf $BASE
   mv "$pnmfile".pdf $BASE
done
