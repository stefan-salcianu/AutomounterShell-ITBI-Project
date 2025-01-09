#!/bin/bash

run_shell() {
	path="/home/Denis/Desktop/project_ITBI"
	last_path="$path"
	while true; do
		echo -n "ashm> "
		read -r command
		if [[ "$command" == "exit" ]]; then
			echo "The program has exited succesfully."
			exit 0
			break
		fi
		if [[ "$command" == cd* ]]; then
			if [[ "${command#cd }" == ".." ]]; then
				cd ".."
				path="${path%/*}"
			else
				if [[ -e "$path/${command#cd }" ]]; then
                                	echo "exista"
					gasit="0"
					echo "$gasit"
					while IFS=' ' read -r word0 word1 _; do
                               			 if [[ "$path/${command#cd }" == *"$word0"* ]]; then
							gasit="1"
							break
                               			 fi
                        		done < /home/Denis/Desktop/project_ITBI/mountpoints 
					if [[ "$gasit" == "1" ]]; then
                              			 echo "mountpoint"
						# gestionam situatia in care este mountpoint
                       			else
						path="$path/${command#cd }"
                         			cd "$path"
                       				echo "nu este mountpoint" 
					fi
				 else
                            		echo "path invalid"
                       		 fi
			fi
			echo "$path"
		else
			sh -c "$command"
		fi
	done
}

run_shell
