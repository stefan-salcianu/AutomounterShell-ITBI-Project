#!/bin/bash

path="/home/stefan/Documents/lab_itbi/AutomounterShell-ITBI-Project"

proces(){
 fuser -v "$1" > /dev/null
 sleep "$2" && [[ $? -eq 1 ]] && sudo umount "$1" && echo "$1" &&  echo "Unmounted successfully" && mount || proces "$1" "$2" &
}

run_shell() {
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
							mount_path="$word0"
							gasit="1"
							break
                               			 fi
                        		done < /home/stefan/Documents/lab_itbi/AutomounterShell-ITBI-Project/mountpoints
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
								#~/Documents/lab_itbi/AutomounterShell-ITBI-Project/proces.sh "$path" "$word1" &
								proces "$path" "$word1"

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
