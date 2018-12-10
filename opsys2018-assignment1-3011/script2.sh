#!/bin/bash

touch directories;
tar xvzf $1 >> directories;
mkdir assignments;
touch directories2;
while read -r line;
do 
	[[ $line = \#* ]] && continue
	[[ ! $line = *.txt ]] && continue
		head $line >>directories2;
done <directories;
rm directories;

while read -r line;
do 
	
	[[ $line = \#* ]] && continue > /dev/null;
	[[ ! $line = https* ]] && continue > /dev/null;
		base= basename $line > /dev/null;
		cd assignments > /dev/null;
		if git clone --quiet $line $base > /dev/null;
		then 
			echo $line': Cloning ok';
		else 
			echo $line': Cloning FAILED';
		fi
		cd ..;
		
done < directories2;
rm directories2;


ls assignments > directories;
cd	assignments;

while read -r line;
do
	cd $line >/dev/null;
	echo $line':';
	echo Number of directories: $(find -type d -not -name "." |wc -l) ;
	echo Number of txt files: $(find . -type f -name "*.txt" | wc -l);
	echo Number of other files: $(find -type f -not -name "*.txt" |wc -l);
	if [ -f dataA.txt 1>/dev/null 2>/dev/null ] && [ -f more/dataB.txt 1>/dev/null 2>/dev/null ] && [ -f more/dataC.txt 1>/dev/null 2>/dev/null ];
		then 
			echo Directory structure is OK.;
		else 
			echo Directory structure is NOT OK.;

		fi	

	cd ..;


done < ../directories;
rm ../directories;