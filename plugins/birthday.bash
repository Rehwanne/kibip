#!/bin/bash
#Birthday Plugin for kibip
#Just another - and stupid -  demonstration. Who needs this actually? 
#{birthday_names}: Whos birthday is today?
#You have to add some entries with something like: kibip birthday add (if it would be implemented lol)
[ -f /$root/plugins/.installed.birthday ] || (mkdir $root/data/birthday ; touch $root/plugins/.installed.birthday ; touch $root/data/birthday/db)


#incompleted

#Eh, yeah, date format? 
today=`date +%d.%m`
names=`cat $root/data/birthday/db | grep $today | cut -d":" -f1`


[ "$names" != "" ] || names="Nobodys birthday today";


replace content "{birthday_names}" "$names"


