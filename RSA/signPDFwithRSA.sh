!/bin/bash
echo "****************** SIGNATURE RSA Ciphers ****************************"
for cipher in 1024 2048 3072 4096 7680 15360 ; do
        echo "100x RSA Signature with $cipher"
	time bash -c "for i in {1..100}; do  openssl dgst -sha256 -sign private-$cipher.pem test.pdf > signature-$cipher.bin;  done;"
        echo "End of Test for $cipher"
        echo ""
done
