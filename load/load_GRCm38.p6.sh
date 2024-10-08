#!/bin/bash

source /etc/profile

echo ""
echo "*****************************************************"
echo "***************** Loading Mouse GRCm38.p6 ******************"
echo "*****************************************************"
echo ""

cd /home/rgdpub/jbrowse2/load

ASSEMBLY="GRCm38.p6";
ROOTDIR="/data/data/jbrowse2/gff3/Mouse/GRCm38.p6"

../makeFasta.sh $ASSEMBLY "GRCm38.p6 (Mouse)"

for dir in "$ROOTDIR"/*; do
  if [ -d "$dir" ]; then
    base=$(basename "$dir")
    echo "calling loadGFF.sh $dir $ASSEMBLY $base"
    ../loadGFF.sh "$dir" $ASSEMBLY "$base"
  fi
done

if [ "$INDEX_JBROWSE" -eq 1 ]; then
    echo "running indexing"
    export NODE_OPTIONS='--max-old-space-size=4096'
    jbrowse text-index  --assemblies=${ASSEMBLY} --out /data/jbrowse2/ 2>&1 | tee /data/jbrowse_log/textIndex${ASSEMBLY}.log
fi
