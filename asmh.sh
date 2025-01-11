#!/bin/bash

run_shell() {
	path="/home/Denis/Desktop/project_ITBI"
	last_path="$path"
	path_montare="$path/mountplace/"
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
					mount_cnt=1
					while IFS=' ' read -r word0 word1 _; do
                               			 if [[ "$path/${command#cd }" == *"$word0"* ]]; then
							mount_path="$word0"
							gasit="1"
							break
                               			 fi
						let mount_cnt=mount_cnt+1
                        		done < /home/Denis/Desktop/project_ITBI/mountpoints 
					path="$path/${command#cd }"
					if [[ "$gasit" == "1" ]]; then
                              			 echo "mountpoint"
						mount_info= $(mount | grep "$path")
						if [[ -n "$mount_info" ]]; then
							echo "montat"
						else
							echo "nemontat"
							cd "/home/Denis/Desktop/project_ITBI"
							cd "mountplace"
							mkdir -p "mounted_$mount_cnt"
							sudo mount "$path" "/home/Denis/Desktop/project_ITBI/mountplace/mounted_$mount_cnt" && echo "Montare reusita" || echo "Eroare"
						fi
						# gestionam situatia in care este mountpoint
                       			else
                         			cd "$path"
                       				echo "nu este mountpoint" 
					fi
				 else
                            		echo "path invalid"
                       		 fi

			echo "$path"
			fi
		else
			sh -c "$command"
		fi
	done
}

run_shell
