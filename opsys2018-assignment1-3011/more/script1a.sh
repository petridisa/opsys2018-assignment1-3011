#!/bin/bash

touch url.txt;
while read -r line;
do
	 [[ $line = \#* ]] && continue
 		if grep -Fxq $line url.txt
		then 
			file=`basename "$line"`
			if ! wget "$line" -qO "$file"'1'
			then
				echo $line 'FAILED';
			fi
			if ! cmp -s "$file" "$file"'1'
			then 
				echo $line;
			fi
			rm $file;
			mv $file'1' $file;
		else
			echo $line 'INIT';
			echo $line >> url.txt;
			file=`basename "$line"`
			if ! wget "$line" -qO "$file"
			then
				echo $line 'FAILED';
			fi

		fi
	
	
done< $1;
