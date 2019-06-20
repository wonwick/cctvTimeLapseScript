tmpFile="asd";
fileList="fileList.txt";
ffmpeg="G:/PlantVid/ffmpeg-20190614-dd357d7-win64-static/bin/ffmpeg";
for i in *;do 
 	if [ -d "$i" ]; then
		name=`echo "${i%.*}"`;
		echo "##################${name}###################";
		cd "${name}";
		mkdir "${name}_frameReduced";
		for j in *.avi;do
			vid=`echo "${j%.*}"`;
			echo "	${vid}";
			$ffmpeg -i "${vid}.avi" -filter:v "setpts=0.02*PTS" -an "${name}_frameReduced"/"${vid}_frameReduced.mp4";
		done
		cd "${name}_frameReduced";
		mkdir "${name}_hyperLapsed";
		for k in *.mp4;do
			reducedVid=`echo "${k%.*}"`;
			echo "		${reducedVid}";
			$ffmpeg -i "${reducedVid}.mp4" -filter:v "setpts=0.02*PTS" -an "${name}_hyperLapsed"/"${reducedVid}_hyperLapsed.mp4";
		done
	
		cd "${name}_hyperLapsed";
		ls -1 *\.mp4 | sort -n >"${tmpFile}";
		awk '{print "file " $0;}' "${tmpFile}"> "filelist.txt";
		rm "asd";
		mkdir "concatinated";
		$ffmpeg -f concat -safe 0 -i "${fileList}" -c copy "concatinated"/"${name}_concatinated.mp4";
		cd ..;
		cd ..;
   		cd ..;
	fi
done
read -p "$*";
