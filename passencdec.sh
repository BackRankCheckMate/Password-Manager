#!/bin/bash

# Custome file to store everything
filename="pass-storage.txt"

#Encrypt the password, and store it in the file
encrypt_func () {
	echo "Enter account name:"
	read account
	echo "Enter password:"
	read pass
	encrypted_pass=$(echo $pass | openssl enc -base64)		
	echo -e "\n$account: $encrypted_pass" >> $filename	
	if [ $? -eq 0 ]
	then
		echo "Success"
		exit 0
	else
		echo "Failure"
		exit 1
	fi			
}


#Decrypt the password and show it to user
decrypt_func () {
	echo "Enter the accounts name(case-sensitive) : "
	read account
	
	stored_pass=$(grep $account $filename | awk '{print $2}')
	echo $stored_pass

	decrypt=$(echo $stored_pass | openssl enc -base64 -d)
	echo $decrypt

	echo "Password for $account is: $decrypt"
}

#Display if user calls the script in the wrong format
usage () {
	echo "Usage for storing password: passencdec.sh 1"
	echo "Usage for retrieving password: passencdec.sh 2"
	echo "Please try again"	
}

#Checks whether there is an argument present or not
if [ $# -ne 1 ]
then
	usage
	exit 1
fi

#Redirects to encrypt_func and decrypt_func
if [ $1 -eq 1 ]
then
	encrypt_func
fi

if [ $1 -eq 2 ]
then 
	decrypt_func
else
	usage
fi
