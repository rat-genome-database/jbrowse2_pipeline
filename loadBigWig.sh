#!/bin/bash

source /etc/profile

#1 [directory path] 2 [assembly name] 3 [category]

echo ""
echo "********  loadBigWig.sh  $1 $2  $3 ***********"
echo ""

set -o xtrace

echo "Processing $1"

#rm "$1"/*.gz.tbi
#rm "$1"/*.sorted.gff
#rm "$1"/*.sorted.gff.gz


for dir in "$1"/*; do
    if [ -d "$dir" ]; then
       base=$(basename "$dir")
       echo $base;
       echo $dir;
       ../loadBigWig.sh "$dir" $2 "$3,$base"    
     fi   

done


#gunzip "$1"/*.gz

files="$1"/*.bigwig

for f in "$1"/*.bigwig
do
echo "Loading $f"
if [ -f "$f" ]; then
   echo "found file"

   base=$(basename "$f" .bigwig)

   if [[ -z "$3" ]]; then
      jbrowse add-track "$f" --subDir="$2" --trackId="$base-$2" --load=copy  --name="$base" --assemblyNames="$2" --out=/data/jbrowse2/
   else 
      jbrowse add-track "$f" --subDir="$2" --trackId="$base-$2" --load=copy --name="$base" --category="$3" --assemblyNames="$2" --out=/data/jbrowse2/
   fi
fi
done


