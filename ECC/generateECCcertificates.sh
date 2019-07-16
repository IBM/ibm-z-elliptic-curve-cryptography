#!/bin/bash
echo "****************** BEGIN OF ECC CERTIFICATE GENERATION  ****************************"
for cipher in prime256v1 secp384r1 secp521r1 ; do        
echo "****************** CERTIFICATE WITH $cipher  ****************************"
        echo "10x ECC CERTIFICATE  with $cipher"
	openssl ecparam -name $cipher -genkey -param_enc explicit -out private-$cipher.pem
	time bash -c "for i in {1..10}; do openssl req -new -x509 -key private-$cipher.pem -out server-$cipher.pem -days 365 -sha256 -subj /C=FR/ST=France/L=Montpellier/CN=PSSC -engine ibmca 2>/dev/null; done;"
	cat private-$cipher.pem server-$cipher.pem > mycert-$cipher.pem 
	echo "End of Test for $cipher"
        echo ""
done;
echo "******************END OF TEST ECC CERTIFICATE GENERATION  ****************************"
