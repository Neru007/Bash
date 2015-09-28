#!/bin/bash
# Author : Neeraj
# Usage : Script that will check the status of Entire Public IP block and present the status in a HTML format
# Files I'm using in below script are free for storing free ip after checking them through ping and freeip.html for storing the result and html tags one by one.

# Start Generating the HTML file for formatting, I'll keep using these html in the entire script so that HTML file look better
echo "<html>" > freeip.html
echo "<body>" >> freeip.html
echo "<h1>Free IP Status</h1>" >> freeip.html

# Checking Few files should be empty before executing the real process.
cat /dev/null > free
cat /dev/null > freeip.txt

# Checking for IP block Subnet 123.x.x.0/24 checking one by one through loop and storing in file called free
for ip in {1..254}
do
ping -c1 -w2 123.x.x.$ip &> /dev/null || echo "123.x.x.$ip" >> free
done

# Storing Total number of free IP in variable ll and displaying it on webpage
echo "Total free IP's remaining " >> freeip.html
ll=$(cat free|wc -l)
echo $ll >> freeip.html

# Updating the Last update date
echo "Last updated on " >> freeip.html
date >> freeip.html

# Reading free IP and storing one by one via loop in html file 
cat free >> freeip.txt
cat freeip.txt | while read b
do
echo "<p> FREE $b</p>" >> freeip.html
done

# Closing HTML tags
echo "</body>" >> freeip.html
echo "</html>" >> freeip.html
echo "</html>" >> freeip.html

# Upload it to FTP server to specific folder where it can be further view as static HTML page
curl -u ftpuser:ftppassword -T freeip.html ftp://IPaddressorFQDN/path/tofolder/
