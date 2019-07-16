# Welcome in Step 3 about monitoring ECC public key acticity performance.

## Agenda of this Step 3 is the following:
1. Overview of the lab content
2. ECC performance table
3. Generating public keys with ECC
4. Signing a pdf file with ECC
5. Verifying digital signature of a pdf file with ECC
6. Generating x509 digital certificates with ECC

## Overview of the lab content

We already tested RSA performance, now lets test ECC performance. That way you will be able to compare later.

In this section, let's test performance of ECC in very different conditions. We will used openssl under the cover, in order to perform all the cryptographic activities. That is good, because in previous section, we optimized opensssl in order to speed-up the hardware way cryptographic operations.

Please now move in the ECC directory thanks to the follwing command:
```
cd ECC/
```

List the content of the directory with the following command:
```
ls -l
total 60
-rwxr-xr-x 1 root root   747 Aug 14 14:05 generateECCcertificates.sh
-rwxr-xr-x 1 root root   628 Aug 14 13:30 generateECCkeys.sh
-rwxr-xr-x 1 root root   529 Aug 14 13:29 signPDFwithECC.sh
-rw-r--r-- 1 root root 41044 Aug 14 14:00 test.pdf
-rwxr-xr-x 1 root root   732 Aug 14 13:30 verifyPDFwithECC.sh
```

As you can see, there are a set of script designed to test ECC cryptographic activities. During this section, we we will generate key pairs using ECC with different size of ECC key. 

Key sizes and curves are: prime256v1 secp384r1 secp521r1

Then we will use generated ECC keys to sign a pdf file, and to verify the digital signature of this pdf file. To conclude we will generate according ECC keys ECC digital certificate complying with x509. 

Let's make all these script executeable thanks to the following command:
```
chmod +x *.sh
```

## ECC performance table

The following performance table need to be completed by you during this lab part. This is important to provide at the end a summary of the perforance degradation of ECC cryptographic operation according key size.

ECC Key size in bits | Key generation in seconds |  Digital signature in seconds  | Signature verification in seconds  | Certificate generation in seconds | TLS Handshakes
------------ | ------------------ | ----------------------- | --------------------------- | -------------------------- | ----------
prime256v1    | | | | |
secp384r1     | | | | |
secp521r1     | | | | |

## Generating public keys with ECC

Let's put first thing first and let generate one ECC key pair according key size. Issue the following command.
```
./generateECCkeys.sh
****************** BEGIN OF TEST OF ECC KEYS GENERATION ****************************
****************** SIGNATURE prime256v1  ****************************
 ECC Key Generation with prime256v1
engine "ibmca" set.

real	0m0.009s
user	0m0.007s
sys	0m0.002s
engine "ibmca" set.
read EC key
writing EC key

real	0m0.007s
user	0m0.005s
sys	0m0.001s
End of Test for prime256v1

****************** SIGNATURE secp384r1  ****************************
 ECC Key Generation with secp384r1
engine "ibmca" set.

real	0m0.010s
user	0m0.009s
sys	0m0.001s
engine "ibmca" set.
read EC key
writing EC key

real	0m0.006s
user	0m0.005s
sys	0m0.001s
End of Test for secp384r1

****************** SIGNATURE secp521r1  ****************************
 ECC Key Generation with secp521r1
engine "ibmca" set.

real	0m0.015s
user	0m0.013s
sys	0m0.001s
engine "ibmca" set.
read EC key
writing EC key

real	0m0.006s
user	0m0.005s
sys	0m0.001s
End of Test for secp521r1

******************END OF TEST SIGNATURE ECC Ciphers ****************************
```

Please, report to the performance table, the sum of **real+user+sys** time according key size for the column "**Key generation in seconds**". I guest you also realize this is very very FAST! Isn't?

![alt-text](https://github.com/IBM/ibm-z-elliptic-curve-cryptography/blob/master/images/keygen-ECC.png)

Let's see together what has been generated. Please issue the following command:
```
ls -l p*
-rw-r--r-- 1 root root 227 Aug 14 15:23 private-prime256v1.pem
-rw-r--r-- 1 root root 288 Aug 14 15:23 private-secp384r1.pem
-rw-r--r-- 1 root root 365 Aug 14 15:23 private-secp521r1.pem
-rw-r--r-- 1 root root 178 Aug 14 15:23 public-prime256v1.pem
-rw-r--r-- 1 root root 215 Aug 14 15:23 public-secp384r1.pem
-rw-r--r-- 1 root root 268 Aug 14 15:23 public-secp521r1.pem
```

As you can see, we generated for each ECC key size, two keys (one public, and one private).

## Signing a pdf file with ECC

Now, we have enough crypto materials. Let's reuse generated private keys to test how long it takes to **perform 100x digital signatures** of a 3MB pdf file with various ECC key size. Please, issue the following command:
```
./signPDFwithECC.sh
****************** BEGIN OF TEST SIGNATURE ECC Ciphers ****************************
****************** SIGNATURE prime256v1  ****************************
100x ECC Signature with prime256v1

real	0m0.495s
user	0m0.263s
sys	0m0.092s
End of Test for prime256v1

****************** SIGNATURE secp384r1  ****************************
100x ECC Signature with secp384r1

real	0m0.548s
user	0m0.328s
sys	0m0.087s
End of Test for secp384r1

****************** SIGNATURE secp521r1  ****************************
100x ECC Signature with secp521r1

real	0m0.642s
user	0m0.459s
sys	0m0.083s
End of Test for secp521r1

******************END OF TEST SIGNATURE ECC Ciphers ****************************
```

Please, report to the performance table, the sum of **real+user+sys** time according key size for the column "**Digital signature in seconds**". Still insanely FAST!!!

![alt-text](https://github.com/IBM/ibm-z-elliptic-curve-cryptography/blob/master/images/signature-ECC.png)

Let's see together what has been generated. Please issue the following command:
```
ls -l *.bin
-rw-r--r-- 1 root root  71 Aug 14 15:25 signature-prime256v1.bin
-rw-r--r-- 1 root root 103 Aug 14 15:25 signature-secp384r1.bin
-rw-r--r-- 1 root root 139 Aug 14 15:25 signature-secp521r1.bin
```

As you can see, we generated in a separated file (all files with .bin extension) the digital signature of the 3MB pdf file and according each key size. Very interresting for digital signature verification.

## Verifying digital signature of a pdf file with ECC

We have enough crypto materials. We have a detached digital signature file. Let's reuse generated public keys to test how long it takes to **verify 100x digital signatures** of a 3MB pdf file with various RSA key size. Please, issue the following command:

```
./verifyPDFwithECC.sh
****************** BEGIN OF TEST SIGNATURE VERIFICATTION ECC Ciphers ****************************
****************** SIGNATURE VERIFICATION WITH prime256v1 ************************************************
100x ECC Signature verification with prime256v1

real	0m0.376s
user	0m0.261s
sys	0m0.087s
End of Test for prime256v1

****************** SIGNATURE VERIFICATION WITH secp384r1 ************************************************
100x ECC Signature verification with secp384r1

real	0m0.446s
user	0m0.337s
sys	0m0.086s
End of Test for secp384r1

****************** SIGNATURE VERIFICATION WITH secp521r1 ************************************************
100x ECC Signature verification with secp521r1

real	0m0.615s
user	0m0.489s
sys	0m0.086s
End of Test for secp521r1

****************** END OF TEST SIGNATURE VERIFICATION ECC Ciphers ****************************
```

Please, report to the performance table, the sum of **real+user+sys** time according key size for the column "**Signature verification in seconds**". Huhhh... too fast again.

![alt-text](https://github.com/IBM/ibm-z-elliptic-curve-cryptography/blob/master/images/signature-verification-ECC.png)

## Generating x509 digital certificates with RSA

Let's reuse generated public and private keys to test how long it takes to **generate 10x digital certificates** with various RSA key size. Please, issue the following command:

```
./generateECCcertificates.sh
****************** BEGIN OF ECC CERTIFICATE GENERATION  ****************************
****************** CERTIFICATE WITH prime256v1  ****************************
ECC CERTIFICATE  with prime256v1

real	0m0.889s
user	0m0.583s
sys	0m0.131s
End of Test for prime256v1

****************** CERTIFICATE WITH secp384r1  ****************************
ECC CERTIFICATE  with secp384r1

real	0m0.893s
user	0m0.658s
sys	0m0.135s
End of Test for secp384r1

****************** CERTIFICATE WITH secp521r1  ****************************
ECC CERTIFICATE  with secp521r1

real	0m1.086s
user	0m0.822s
sys	0m0.124s
End of Test for secp521r1

******************END OF TEST ECC CERTIFICATE GENERATION  ****************************
```

Please, report to the performance table, the sum of **real+user+sys** time according key size for the column "**Certificate generation in seconds**". As you can see, generating digital certificates is faster with ECC than with RSA. This is why some organization consider to use ECC to replace now RSA. Some of them use ECC for one time digital certificate. 

![alt-text](https://github.com/IBM/ibm-z-elliptic-curve-cryptography/blob/master/images/certificate-ECC.png)

Let's see together what has been generated. Please issue the following command:
```
ls -l mycert*
-rw-r--r-- 1 root root 1973 Aug 14 15:31 mycert-prime256v1.pem
-rw-r--r-- 1 root root 2514 Aug 14 15:31 mycert-secp384r1.pem
-rw-r--r-- 1 root root 3131 Aug 14 15:31 mycert-secp521r1.pem
```

As you can see, we generated ECC digital certificates (all files starting with my-cert*).

Let's browse the content of one of the generated ECC digital certificates, please issue the following command:
```
openssl x509 -in mycert-prime256v1.pem -text

 Certificate:
     Data:
         Version: 3 (0x2)
         Serial Number:
             bf:f8:eb:5f:47:37:f9:7d
     Signature Algorithm: ecdsa-with-SHA256
         Issuer: C=FR, ST=France, L=Montpellier, CN=PSSC
         Validity
             Not Before: Aug 16 09:55:44 2018 GMT
             Not After : Aug 16 09:55:44 2019 GMT
         Subject: C=FR, ST=France, L=Montpellier, CN=PSSC
         Subject Public Key Info:
             Public Key Algorithm: id-ecPublicKey
                 Public-Key: (256 bit)
                 pub: 
                     04:8a:e0:ac:b7:20:dc:ef:0e:c5:8c:b6:a9:4b:9f:
                     e4:73:97:65:6d:4e:c4:72:c5:33:28:81:7c:c4:6d:
                     cc:b7:a9:4b:63:19:c2:66:83:02:18:29:9a:a3:ba:
                     c5:6a:af:7c:84:2f:92:6e:be:b9:45:17:a7:4a:4e:
                     09:57:e2:62:6c
                 Field Type: prime-field
                 Prime:
                     00:ff:ff:ff:ff:00:00:00:01:00:00:00:00:00:00:
                     00:00:00:00:00:00:ff:ff:ff:ff:ff:ff:ff:ff:ff:
                     ff:ff:ff
                 A:   
                     00:ff:ff:ff:ff:00:00:00:01:00:00:00:00:00:00:
                     00:00:00:00:00:00:ff:ff:ff:ff:ff:ff:ff:ff:ff:
                     ff:ff:fc
                 B:   
                     5a:c6:35:d8:aa:3a:93:e7:b3:eb:bd:55:76:98:86:
                     bc:65:1d:06:b0:cc:53:b0:f6:3b:ce:3c:3e:27:d2:
                     60:4b
                 Generator (uncompressed):
                     04:6b:17:d1:f2:e1:2c:42:47:f8:bc:e6:e5:63:a4:
                     40:f2:77:03:7d:81:2d:eb:33:a0:f4:a1:39:45:d8:
                     98:c2:96:4f:e3:42:e2:fe:1a:7f:9b:8e:e7:eb:4a:
                     7c:0f:9e:16:2b:ce:33:57:6b:31:5e:ce:cb:b6:40:
                     68:37:bf:51:f5
                 Order: 
                     00:ff:ff:ff:ff:00:00:00:00:ff:ff:ff:ff:ff:ff:
                     ff:ff:bc:e6:fa:ad:a7:17:9e:84:f3:b9:ca:c2:fc:
                     63:25:51
                 Cofactor:  1 (0x1)
                 Seed:
                     c4:9d:36:08:86:e7:04:93:6a:66:78:e1:13:9d:26:
                     b7:81:9f:7e:90
         X509v3 extensions:
             X509v3 Subject Key Identifier: 
                 39:0A:09:D8:77:EC:A8:C1:5E:20:1D:BF:21:98:D0:13:52:44:FE:50
             X509v3 Authority Key Identifier: 
                 keyid:39:0A:09:D8:77:EC:A8:C1:5E:20:1D:BF:21:98:D0:13:52:44:FE:50

             X509v3 Basic Constraints: 
                 CA:TRUE
     Signature Algorithm: ecdsa-with-SHA256
          30:44:02:20:2a:cd:e9:ce:fc:14:8e:8d:4e:a7:63:53:25:a8:
          63:1b:7a:26:b0:00:51:bf:83:d1:ca:d7:a9:83:8c:18:ca:ec:
          02:20:7d:e8:18:ed:64:2f:ad:6b:a6:9f:20:3a:91:e8:1d:8a:
          a6:2b:84:33:eb:3c:e8:20:d9:f3:0f:03:9d:7c:18:ab
 -----BEGIN CERTIFICATE-----
 MIICwDCCAmegAwIBAgIJAL/4619HN/l9MAoGCCqGSM49BAMCMEMxCzAJBgNVBAYT
 AkZSMQ8wDQYDVQQIDAZGcmFuY2UxFDASBgNVBAcMC01vbnRwZWxsaWVyMQ0wCwYD
 VQQDDARQU1NDMB4XDTE4MDgxNjA5NTU0NFoXDTE5MDgxNjA5NTU0NFowQzELMAkG
 A1UEBhMCRlIxDzANBgNVBAgMBkZyYW5jZTEUMBIGA1UEBwwLTW9udHBlbGxpZXIx
 DTALBgNVBAMMBFBTU0MwggFLMIIBAwYHKoZIzj0CATCB9wIBATAsBgcqhkjOPQEB
 AiEA/////wAAAAEAAAAAAAAAAAAAAAD///////////////8wWwQg/////wAAAAEA
 AAAAAAAAAAAAAAD///////////////wEIFrGNdiqOpPns+u9VXaYhrxlHQawzFOw
 9jvOPD4n0mBLAxUAxJ02CIbnBJNqZnjhE50mt4GffpAEQQRrF9Hy4SxCR/i85uVj
 pEDydwN9gS3rM6D0oTlF2JjClk/jQuL+Gn+bjufrSnwPnhYrzjNXazFezsu2QGg3
 v1H1AiEA/////wAAAAD//////////7zm+q2nF56E87nKwvxjJVECAQEDQgAEiuCs
 tyDc7w7FjLapS5/kc5dlbU7EcsUzKIF8xG3Mt6lLYxnCZoMCGCmao7rFaq98hC+S
 br65RRenSk4JV+JibKNQME4wHQYDVR0OBBYEFDkKCdh37KjBXiAdvyGY0BNSRP5Q
 MB8GA1UdIwQYMBaAFDkKCdh37KjBXiAdvyGY0BNSRP5QMAwGA1UdEwQFMAMBAf8w
 CgYIKoZIzj0EAwIDRwAwRAIgKs3pzvwUjo1Op2NTJahjG3omsABRv4PRytepg4wY
 yuwCIH3oGO1kL61rpp8gOpHoHYqmK4Qz6zzoINnzDwOdfBir
 -----END CERTIFICATE-----
```

This ends the ECC activity section. You are now ready to compare ECC and RSA regarding performance in [Step 4](https://github.com/IBM/ibm-z-elliptic-curve-cryptography/blob/master/rsa-versus-ecc.md).
