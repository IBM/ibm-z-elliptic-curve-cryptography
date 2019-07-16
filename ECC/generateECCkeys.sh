#!/bin/bash

echo "****************** BEGIN OF TEST OF ECC KEYS GENERATION ****************************"
for cipher in prime256v1 secp384r1 secp521r1 ; do
	echo "****************** SIGNATURE $cipher  ****************************"
	echo " ECC Key pair Generation with $cipher"

	#Create private key:
	time openssl ecparam -genkey -name $cipher -noout -out private-$cipher.pem -engine ibmca

	#Create public key:
	time openssl ec -in private-$cipher.pem -pubout -out public-$cipher.pem -engine ibmca
	echo "End of Test for $cipher"
	echo ""
done;
echo "******************END OF TEST SIGNATURE ECC Ciphers ****************************"
