#!/bin/bash

echo "****************** BEGIN OF TEST SIGNATURE ECC Ciphers ****************************"
for cipher in prime256v1 secp384r1 secp521r1 ; do
	echo "****************** SIGNATURE $cipher  ****************************"
	echo "100x ECC Signature with $cipher"
	time bash -c "for i in {1..100}; do openssl dgst -sha256 -sign private-$cipher.pem test.pdf > signature-$cipher.bin; done;"
	echo "End of Test for $cipher"
	echo ""
done;
echo "******************END OF TEST SIGNATURE ECC Ciphers ****************************"
