#!/bin/bash
echo "****************** BEGIN OF TEST SIGNATURE VERIFICATTION ECC Ciphers ****************************"
for cipher in prime256v1 secp384r1 secp521r1 ; do	
echo "****************** SIGNATURE VERIFICATION WITH $cipher ************************************************"
	echo "100x ECC Signature verification with $cipher"

	#Create signature:
	openssl dgst -sha256 -sign private-$cipher.pem test.pdf > signature-$cipher.bin
	
	time bash -c "for i in {1..100}; do openssl dgst -sha256 -verify public-$cipher.pem -signature signature-$cipher.bin test.pdf > /dev/null;  done;"
	echo "End of Test for $cipher"
	echo ""
done;
echo "******************END OF TEST SIGNATURE VERIFICATION ECC Ciphers ****************************"
