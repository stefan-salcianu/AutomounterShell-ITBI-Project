#!/bin/bash

path="/home/Denis/Desktop/project_ITBI"

run_shell() {
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
					while IFS=' ' read -r word0 word1 _; do
                               			 if [[ "$path/${command#cd }" == *"$word0"* ]]; then
							mount_path="$word0"
							gasit="1"
							break
                               			 fi
                        		done < /home/Denis/Desktop/project_ITBI/mountpoints 
					path="$path/${command#cd }"
					cd "$path"
					if [[ "$gasit" == "1" ]]; then
                              			 echo "mountpoint"
						mount_info= $(mount | grep "$path")
						if [[ -n "$mount_info" ]]; then
							echo "montat"
						else
							echo "nemontat"
							reusita=0
							sudo mount --bind "$path" "$path" && mount; echo "Montare reusita"; reusita=1 || echo "Eroare"
							if [[ "$reusita" == 1 ]]; then
								procese="1"
								while [[ "$procese" == "1" ]]; do
									while sleep "$word1"; do
										fuser -v "$path" > /dev/null
										if [[ $? -eq 1 ]]; then
											sudo umount "$path"
											echo "Unmounted"
											mount
											procese="0"
											break
										fi
									done
								done
							fi

						fi
                       			else
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
