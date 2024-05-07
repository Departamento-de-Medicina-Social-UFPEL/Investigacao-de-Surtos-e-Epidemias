linecount=0
while read p; do
  lines=`wc -l $p | cut -f1 -d' '`
  linecount=$((linecount + lines))
done <files.txt
echo $linecount
