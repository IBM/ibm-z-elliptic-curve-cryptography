#!/bin/bash
echo "****************** KEY GENERATION RSA  ****************************"
for cipher in 1024 2048 3072 4096 7680 15360 ; do
        echo "RSA key pair generation with $cipher"
	time openssl genrsa -out private-$cipher.pem $cipher -engine ibmca
	time openssl rsa -in private-$cipher.pem -pubout -out public-$cipher.pem -engine ibmca
        echo "End of Test for $cipher"
        echo ""
done
