#!/bin/bash

touch url.txt;
touch url2.txt;
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
			echo $line >> url2.txt
			
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

while read -r line;
do (/ 2>/dev/null; 1>/dev/null;
		
		fil2e=`basename "$line"` 
		if ! cmp -s "$fil2e" "$fil2e"'1'
			then 
				echo $line;
			fi 
			)&  / 2>/dev/null; 1>/dev/null;
done< url2.txt; 

while read -r line;
do 
	file=`basename "$line"`
	rm $file;
	mv $file'1' $file;
done< url2.txt;

rm url2.txt;
