#!/bin/bash


##
#
#
function copy () {
	# we copy the content of the in folder into the out folder.
	# We don't use -u because the preprocessor processes
	# every file and not copied files would be processed multi
	# times.
	
	local inFolder=${1}
	local outFolder=${2}
	local projectFolder=${3}
	
	rm -d -r ${outFolder}>${projectFolder}run.log
	wait
	cp -P -R ${inFolder} ${outFolder}"/">>${projectFolder}run.log
	wait
}

##
#
#
function preprocess () {
    local outFolder=${1}
    local projectFolder=${2}
	
    for file in ${outFolder}*; do
        
        if [ -d ${file} ]; then
            preprocess ${file}"/" ${projectFolder}
        else
            if [[ ${file} == *.py ]]; then
                fileTmp=${file}"i"
                gcc -I ${projectFolder}"/include/" -E -xc ${file} -o ${fileTmp}>>${projectFolder}run.log
                rm ${file}>>${projectFolder}run.log
                mv ${fileTmp} ${file}>>${projectFolder}run.log
            fi
        fi
        
    done
}

function main () {
	
	# Default settings
	local projectFolder=${PROJECT_LOC}/
	local inFolder=${projectFolder}"src"
	local outFolder=${projectFolder}"py"
	
	echo ""
	echo "Project folder : "${projectFolder}
	echo "in folder      : "${inFolder}
	echo "out folder     : "${outFolder}
	echo ""
	echo "pwd: $(pwd)"
	echo ""
	echo "old parameters:"
	for p in "$@"
	do
	    echo ${p}
	done

	#
	# Copy in folder to out folder.
	#
	copy ${inFolder}"*" ${outFolder} ${projectFolder}
	
	#
	# We run the gcc preprocessor
	#
	preprocess ${outFolder} ${projectFolder}

	#
	# Replacing inFolder by outFolder for each parameter forwarded to python.
	#
	paramsNew=()
	for oldVal in "$@"
	do
	    newVal=${oldVal/$inFolder/$outFolder}
	    paramsNew+=(${newVal})
	done
	echo ""
	echo "new parameters"
	for p in "${paramsNew[@]}"
	do
	    echo ${p}
	done
	
	#
	# we start the python script
	#
	cd ${outFolder}
	python3 ${paramsNew[@]}
	
}



main ${@}
