#!/bin/bash 
		echo "$1"
		echo "$2"
		procese="1"
                while [[ "$procese" == "1" ]]; do
                       while sleep "$2"; do
                            fuser -v "$1" > /dev/null
                            if [[ $? -eq 1 ]]; then
                            sudo umount "$1"
                            echo "Unmounted successfully"
                            mount
                            procese="0"
                            break
                            fi
                       done
                done

