#!/bin/bash
#kibip 

source $HOME/.kibip_config 

cp $srcfile $dstfile
cd $root


[ -z $1 ] || (export root=$root ; bash ./plugins/$1.bash) 


#=======Core-Functions=======#

#sed sometimes sux for this task. You have to escape too much before you can pass a variable to sed if you don't want it to break your command. Even with 'r' it sux imho.
#I know there definitely better ways to replace stuff out there, but this is a fast hack which works. And we are faraway from a release :-)
function replace()
{
	type=$1
	placeholder=$2
	new_content=$3

	[ -z "$4" ] || dstfile=$4
	
	tmp=`mktemp`
	 
	
	#Close your eyes, it's becoming nasty!!1!
	echo -n "echo \"" > $tmp
	if [ "$type" = "content" ] ; then
		echo $new_content > tmpcontent
		cat $dstfile | sed -e "s/$placeholder/\`cat tmpcontent\`/g" | sed -e 's/\"/\\"/g' >> $tmp
	elif [ "$type" = "cmd" ] ; then
		cat $dstfile | sed -e "s/$placeholder/\`$new_content\`/g" | sed -e 's/\"/\\"/g' >> $tmp
	fi
	echo -n "\"" >> $tmp

	bash $tmp > $dstfile
	rm $tmp
	rm tmpcontent
}


function log_error()
{
	echo "`date`: $1" >> $root/log
}


function list_placeholders
{
	echo -e "Name:\t\t\t\t\t\tFunction:"
	cat ./plugins/*bash | grep "#{" | sed -e 's/#{\(.*\)}:\(.*\).*/\1\t\t\t\t\t\2/g'
	
}

function check_reqs
{
	return
}

#=======Core replacements=======#
replace content "{core_title}" "Startpage"
replace content "{core_date}" `date +%d.%m.%Y`
#bla bla bla


#=======Load all plugins=======#
ls plugins | while read file ; do
source ./plugins/$file
done

