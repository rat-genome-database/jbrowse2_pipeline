#!/bin/bash
set -x
source /etc/profile

echo ""
echo "********  loadOrthology.sh  ***********"
echo ""

# Define the directory containing the JSON files
directory="/data/data/jbrowse2/paf"

# Loop over all JSON files in the directory
for file in "$directory"/*.paf
do
    # Check if the file exists
    if [ -f "$file" ]; then
        echo "Processing $file"
        
        filename="${file##*/}"
        echo $filename	

        filename=$(echo ${filename} | sed 's/\.paf$//')

	# Split the string on the dash and print each part
	part1=$(echo $filename | cut -d '-' -f 1)
	part2=$(echo $filename | cut -d '-' -f 2)
       
	echo "Part 1: $part1"
	echo "Part 2: $part2"

        jbrowse add-track "/data/data/jbrowse2/paf/${filename}.paf" --force --subDir="synteny" --category="Synteny" --assemblyNames ${part1},${part2} --load copy --out /data/jbrowse2/

# Add your processing commands here
    else
        echo "No JSON files found in $directory"
    fi
done

