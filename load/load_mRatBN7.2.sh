#!/bin/bash

source /etc/profile

#set -o xtrace
cd /home/rgdpub/jbrowse2/load

ASSEMBLY="mRatBN7.2";
ROOTDIR="/data/data/jbrowse2/gff3/Rat/mRatBN7.2"
BIGWIG="/data/data/jbrowse2/bigwig/Rat/mRatBN7.2"
BED="/data/data/jbrowse2/bed/Rat/mRatBN7.2"

echo ""
echo "*****************************************************"
echo "***************** Loading $ASSEMBLY******************"
echo "*****************************************************"
echo ""

../makeFasta.sh $ASSEMBLY "mRatBN7.2 (Rat)" 

cd /home/rgdpub/jbrowse2/load

../loadRootGFF.sh "$ROOTDIR" $ASSEMBLY

cd /home/rgdpub/jbrowse2/load

for dir in "$ROOTDIR"/*; do
  if [ -d "$dir" ]; then
    base=$(basename "$dir")
    echo "calling loadGFF.sh $dir $ASSEMBLY $base"
    ../loadGFF.sh "$dir" $ASSEMBLY "$base"
  fi
done

for dir in "$BED"/*; do
  if [ -d "$dir" ]; then
    base=$(basename "$dir")
    echo "calling loadBed.sh $dir $ASSEMBLY $base"
    ../loadBed.sh "$dir" $ASSEMBLY "$base"
  fi
done


for dir in "$BIGWIG"/*; do
  if [ -d "$dir" ]; then
    base=$(basename "$dir")
    echo "calling loadBigWig.sh $dir $ASSEMBLY $base"
    ../loadBigWig.sh "$dir" $ASSEMBLY "$base"
  fi
done

./indexTrack.sh "${ASSEMBLY}"
