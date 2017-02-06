#!/bin/bash

while getopts "hvzi" options; do
	case "$options" in
		h)
			echo "This is help"
			;;
		v)
			echo "verbose mode is activated"
			;;
		z)
			echo "Compression will be performed"
			;;
		i)
			echo "interacive mode"
			;;

	esac
done
