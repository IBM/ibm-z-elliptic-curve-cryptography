#!/bin/bash
echo "****************** BEGIN OF RSA CERTIFICATE GENERATION  ****************************"
for cipher in 1024 2048 3072 4096 7680 15360 ; do
        echo "****************** CERTIFICATE WITH  $cipher  ****************************"
        echo "10x RSA CERTIFICATE  with $cipher"
        time bash -c "for i in {1..10}; do openssl req -x509 -nodes -days 365 -sha256 -subj /C=FR/ST=France/L=Montpellier/CN=PSSC -newkey rsa:$cipher -keyout mycert-$cipher.pem -out mycert-$cipher.pem -engine ibmca 2>/dev/null; done;"
        echo "End of Test for $cipher"
        echo ""
done;
echo "******************END OF TEST RSA CERTIFICATE GENERATION  ****************************"
