# Welcome in Step 2 about monitoring RSA public key acticity performance.

## Agenda of this Step 2 is the following:
1. Overview of the lab content
2. RSA performance table
3. Generating public keys with RSA
4. Signing a pdf file with RSA
5. Verifying digital signature of a pdf file with RSA
6. Generating x509 digital certificates with RSA

## Overview of the lab content

In this section, let's test performance of RSA in very different conditions. We will used openssl under the cover, in order to perform all the cryptographic activities. That is good, because in previous section, we optimized opensssl in order to speed-up the hardware way cryptographic operations.

Please now move in the RSA directory thanks to the follwing command:
```
cd RSA/
```

List the content of the directory with the following command:
```
ls -l

  total 60
  -rwxr-xr-x 1 root root   684 Aug 14 14:04 generateRSAcertificates.sh
  -rwxr-xr-x 1 root root   400 Aug 14 13:31 generateRSAkeys.sh
  -rwxr-xr-x 1 root root   371 Aug 14 12:00 signPDFwithRSA.sh
  -rw-r--r-- 1 root root 41044 Aug 14 11:58 test.pdf
  -rwxr-xr-x 1 root root   500 Aug 14 12:07 verifyPDFwithRSA.sh
```

As you can see, there are a set of script designed to test RSA cryptographic activities. During this section, we we will generate key pairs using RSA with different size of RSA key. 

Key sizes are: 1024, 2048, 3072, 4096, 7680 and 15360.

Then we will use generated RSA keys to sign a pdf file, and to verify the digital signature of this pdf file. To conclude we will generate according RSA keys RSA digital certificate complying with x509. 

Let's make all these script executeable thanks to the following command:
```
chmod +x *.sh
```

## RSA performance table

The following performance table need to be completed by you during this lab part. This is important to provide at the end a summary of the perforance degradation of RSA cryptographic operation according key size.

RSA Key size in bits | Key generation in seconds |  Digital signature in seconds  | Signature verification in seconds  | Certificate generation in seconds | TLS Handshakes
------------ | ------------------ | ----------------------- | --------------------------- | -------------------------- | ----------
RSA 1024     | | | | |
RSA 2048     | | | | |
RSA 3072     | | | | |
RSA 4096     | | | | |
RSA 7680     | | | | |
RSA 15360    | | | | |

## Generating public keys with RSA

Let's put first thing first and let generate one RSA key pair according key size. Issue the following command. Note that this script may need up to 240 seconds to generate RSA 15360 keys !!!! So, be patient.
```
./generateRSAkeys.sh

  ****************** KEY GENERATION RSA  ****************************
  RSA key generation with 1024
  Generating RSA private key, 1024 bit long modulus
  ........++++++
  .................++++++
  e is 65537 (0x10001)

  real	0m0.017s
  user	0m0.014s
  sys	0m0.001s
  engine "ibmca" set.
  writing RSA key

  real	0m0.007s
  user	0m0.005s
  sys	0m0.001s
  End of Test for 1024
  [**** truncated ***]
```

Please, report to the performance table, the sum of **real+user+sys** time according key size for the column "**Key generation in seconds**". At this step, you already realize how long it is to generate key pairs bigger than 4096!

![alt-text](https://github.com/guikarai/LinuxONE-ECC/blob/master/images/keygen-RSA.png)

Let's see together what has been generated. Please issue the following command:
```
ls -l p*

  -rw-r--r-- 1 root root   891 Aug 14 14:46 private-1024.pem
  -rw-r--r-- 1 root root 11823 Aug 14 14:51 private-15360.pem
  -rw-r--r-- 1 root root  1675 Aug 14 14:46 private-2048.pem
  -rw-r--r-- 1 root root  2455 Aug 14 14:46 private-3072.pem
  -rw-r--r-- 1 root root  3243 Aug 14 14:46 private-4096.pem
  -rw-r--r-- 1 root root  5973 Aug 14 14:47 private-7680.pem
  -rw-r--r-- 1 root root   272 Aug 14 14:46 public-1024.pem
  -rw-r--r-- 1 root root  2705 Aug 14 14:51 public-15360.pem
  -rw-r--r-- 1 root root   451 Aug 14 14:46 public-2048.pem
  -rw-r--r-- 1 root root   625 Aug 14 14:46 public-3072.pem
  -rw-r--r-- 1 root root   800 Aug 14 14:46 public-4096.pem
  -rw-r--r-- 1 root root  1405 Aug 14 14:47 public-7680.pem
```

As you can see, we generated for each RSA key size, two keys (one public, and one private).

## Signing a pdf file with RSA

Now, we have enough crypto materials. Let's reuse generated private keys to test how long it takes to **perform 100x digital signatures** of a 3MB pdf file with various RSA key size. Please, issue the following command:
```
./signPDFwithRSA.sh

  ****************** SIGNATURE RSA Ciphers ****************************
  100 RSA Signature with 1024

  real	0m0.491s
  user	0m0.285s
  sys	0m0.099s
  End of Test for 1024

  100 RSA Signature with 2048

  real	0m0.677s
  user	0m0.525s
  sys	0m0.096s
  End of Test for 2048

  100 RSA Signature with 3072

  real	0m1.246s
  user	0m1.038s
  sys	0m0.092s
  End of Test for 3072

  100 RSA Signature with 4096

  real	0m2.218s
  user	0m1.941s
  sys	0m0.101s
  End of Test for 4096

  100 RSA Signature with 7680

  real	0m11.152s
  user	0m10.233s
  sys	0m0.148s
  End of Test for 7680

  100 RSA Signature with 15360

  real	1m16.204s
  user	1m10.840s
  sys	0m0.221s
  End of Test for 15360
```

Please, report to the performance table, the sum of **real+user+sys** time according key size for the column "**Digital signature in seconds**". Don't you see how explonential is the time required for such RSA crypto workload?

![alt-text](https://github.com/guikarai/LinuxONE-ECC/blob/master/images/signature-RSA.png)

Let's see together what has been generated. Please issue the following command:
```
ls -l *.bin

  -rw-r--r-- 1 root root  128 Aug 14 15:03 signature-1024.bin
  -rw-r--r-- 1 root root 1920 Aug 14 15:04 signature-15360.bin
  -rw-r--r-- 1 root root  256 Aug 14 15:03 signature-2048.bin
  -rw-r--r-- 1 root root  384 Aug 14 15:03 signature-3072.bin
  -rw-r--r-- 1 root root  512 Aug 14 15:03 signature-4096.bin
  -rw-r--r-- 1 root root  960 Aug 14 15:04 signature-7680.bin
```

As you can see, we generated in a separated file (all files with .bin extension) the digital signature of the 3MB pdf file and according each key size. Very interresting for digital signature verification.

## Verifying digital signature of a pdf file with RSA

We have enough crypto materials. We have a detached digital signature file. Let's reuse generated public keys to test how long it takes to **verify 100x digital signatures** of a 3MB pdf file with various RSA key size. Please, issue the following command:

```
./verifyPDFwithRSA.sh

  ****************** SIGNATURE VERIFICATION RSA Ciphers ****************************
  100 RSA Signature VERIFICATION with 1024

  real	0m0.311s
  user	0m0.205s
  sys	0m0.087s
  End of Test for 1024

  100 RSA Signature VERIFICATION with 2048

  real	0m0.332s
  user	0m0.218s
  sys	0m0.088s
  End of Test for 2048

  100 RSA Signature VERIFICATION with 3072

  real	0m0.316s
  user	0m0.218s
  sys	0m0.081s
  End of Test for 3072

  100 RSA Signature VERIFICATION with 4096

  real	0m0.351s
  user	0m0.234s
  sys	0m0.090s
  End of Test for 4096

  100 RSA Signature VERIFICATION with 7680

  real	0m0.397s
  user	0m0.283s
  sys	0m0.088s
  End of Test for 7680

  100 RSA Signature VERIFICATION with 15360

  real	0m0.645s
  user	0m0.502s
  sys	0m0.089s
  End of Test for 15360
```

Please, report to the performance table, the sum of **real+user+sys** time according key size for the column "**Signature verification in seconds**". Don't you see how verifying a digital signature is faster than performing a digital signature with RSA?

![alt-text](https://github.com/guikarai/LinuxONE-ECC/blob/master/images/signature-verification-RSA.png)


## Generating x509 digital certificates with RSA

Let's reuse generated public and private keys to test how long it takes to **generate 10x digital certificates** with various RSA key size. Please, issue the following command:

```
./generateRSAcertificates.sh

  ****************** BEGIN OF RSA CERTIFICATE GENERATION  ****************************
  ****************** CERTIFICATE WITH  1024  ****************************
  10x RSA CERTIFICATE  with 1024

  real	0m2.725s
  user	0m2.424s
  sys	0m0.143s
  End of Test for 1024

  ****************** CERTIFICATE WITH  2048  ****************************
  10x RSA CERTIFICATE  with 2048

  real	0m14.471s
  user	0m13.293s
  sys	0m0.190s
  End of Test for 2048

  ****************** CERTIFICATE WITH  3072  ****************************
  10x RSA CERTIFICATE  with 3072

  real	0m52.000s
  user	0m48.090s
  sys	0m0.252s
  End of Test for 3072

  ****************** CERTIFICATE WITH  4096  ****************************
  10x RSA CERTIFICATE  with 4096

  real	2m20.024s
  user	2m10.473s
  sys	0m0.301s
  End of Test for 4096

  [**** Truncated ****]
```

Please, report to the performance table, the sum of **real+user+sys** time according key size for the column "**Certificate generation in seconds**". Don't you see the production limit of the RSA while hardening a digital certificates with bigger keys? And this is only about generating 10x x509 digital certificates !!! 

![alt-text](https://github.com/guikarai/LinuxONE-ECC/blob/master/images/certificate-RSA.png)

This mainly explain why RSA will not be good for production beyond a key size of 4096.

Let's see together what has been generated. Please issue the following command:
```
ls -l mycert*

  -rw-r--r-- 1 root root 1783 Aug 14 15:07 mycert-1024.pem
  -rw-r--r-- 1 root root 9132 Aug 14 15:11 mycert-15360.pem
  -rw-r--r-- 1 root root 2924 Aug 14 15:07 mycert-2048.pem
  -rw-r--r-- 1 root root 4058 Aug 14 15:08 mycert-3072.pem
  -rw-r--r-- 1 root root 5187 Aug 14 15:11 mycert-4096.pem
  -rw-r--r-- 1 root root 9132 Aug 14 15:11 mycert-7680.pem
```

As you can see, we generated digital certificates (all files starting with my-cert*).

Let's browse together one of these generated self-signed digital certificate, please issue the following command:
```
openssl x509 -in mycert-4096.pem -text
  
  Certificate:
      Data:
          Version: 3 (0x2)
          Serial Number:
              88:70:1d:ae:1e:2c:3e:a4
      Signature Algorithm: sha256WithRSAEncryption
          Issuer: C=FR, ST=France, L=Montpellier, CN=PSSC
          Validity
              Not Before: Aug 16 09:04:06 2018 GMT
              Not After : Aug 16 09:04:06 2019 GMT
          Subject: C=FR, ST=France, L=Montpellier, CN=PSSC
          Subject Public Key Info:
              Public Key Algorithm: rsaEncryption
                  Public-Key: (4096 bit)
                  Modulus:
                      00:a7:55:49:08:40:a0:81:99:77:7c:5a:47:68:37:
                      4f:71:6f:70:b3:99:ef:fd:a5:23:c3:18:c3:27:cb:
                      12:d5:35:0e:72:f2:de:f4:4c:ef:43:56:cf:54:f1:
                      d9:6a:ab:57:39:1a:65:5a:a8:04:dc:5c:65:4b:17:
                      ab:ae:01:73:05:61:57:b5:1d:e8:12:14:57:6d:21:
                      45:d8:9a:59:f7:01:28:8d:80:d9:41:50:f0:ba:51:
                      f5:50:bc:26:e2:0d:e9:50:57:3f:75:56:01:33:5a:
                      cb:d7:41:83:fb:28:c1:48:30:f7:1b:06:d8:a1:65:
                      94:90:68:f8:fc:f1:a3:07:6b:39:ac:7c:c8:4d:7f:
                      ee:59:ed:63:6e:05:6f:41:87:2c:97:9b:69:84:fd:
                      9a:61:1c:5a:8b:9f:82:2b:97:29:8a:53:ad:71:c3:
                      57:02:53:29:d5:aa:cc:e1:c0:63:4f:16:84:3f:c6:
                      34:66:46:ca:44:31:70:8b:5b:53:15:cc:12:7e:4f:
                      04:e9:e7:a2:94:e6:ca:26:34:44:00:9c:a7:70:ab:
                      21:7c:22:65:4d:72:ef:5a:9f:ca:47:65:4a:13:24:
                      f9:c2:0d:ba:79:dd:e3:84:33:46:2b:60:7c:d2:f0:
                      38:ab:5d:43:bf:fb:5e:e0:a3:ee:bf:b4:3b:6b:c1:
                      85:d1:d1:6d:71:39:ac:ac:7d:e7:e5:e2:8b:f6:8d:
                      43:c1:3f:a3:c7:48:18:53:0d:4f:f4:75:01:72:8d:
                      71:51:99:28:15:b9:8e:16:a6:ae:fb:27:48:25:59:
                      6b:1f:01:54:ac:c0:68:8b:e7:86:a7:c5:1a:63:f9:
                      f6:65:f3:e2:bf:9d:bf:de:10:d9:bb:f6:bb:3f:dd:
                      ab:08:6f:25:1f:2a:c8:64:26:02:8e:8f:c7:41:38:
                      6d:55:76:80:da:92:cd:b0:eb:e8:44:89:09:31:ff:
                      ba:da:f7:50:15:1d:0f:8e:a9:28:50:d3:70:9f:ab:
                      a6:0c:de:16:2f:af:81:f1:f8:d6:85:61:f1:a2:e6:
                      35:f6:58:9a:a4:8c:10:d9:0d:33:fd:24:95:50:98:
                      13:10:68:a5:31:f1:ac:2c:f2:a7:76:f5:c2:19:70:
                      9d:25:ff:18:eb:5b:d0:83:30:64:a7:f2:13:7e:5a:
                      c2:44:bd:95:e8:73:a1:1d:7f:1d:69:f2:3c:8b:34:
                      0d:02:e7:3f:6f:ac:11:29:e0:b8:51:b8:0e:86:67:
                      0e:86:99:64:21:4e:87:ae:b7:f6:d4:87:43:26:53:
                      42:b5:a6:50:56:7f:83:68:fe:39:02:f4:77:de:02:
                      fd:06:54:f5:ea:dc:42:ca:75:f0:e8:15:e3:59:69:
                      0a:33:31
                  Exponent: 65537 (0x10001)
          X509v3 extensions:
              X509v3 Subject Key Identifier: 
                  12:19:AF:9C:5F:C7:65:F9:27:93:54:C1:AF:FC:1B:A1:30:D4:AA:33
              X509v3 Authority Key Identifier: 
                  keyid:12:19:AF:9C:5F:C7:65:F9:27:93:54:C1:AF:FC:1B:A1:30:D4:AA:33

              X509v3 Basic Constraints: 
                  CA:TRUE
      Signature Algorithm: sha256WithRSAEncryption
           5e:8d:d8:6c:31:cb:4b:d3:24:c4:64:87:c4:ff:c9:61:fc:16:
           33:e6:22:e9:17:19:93:b8:f4:1a:d3:db:cb:7a:71:22:32:a8:
           13:de:15:e8:d9:9d:da:5a:31:d8:24:b9:de:32:8e:79:33:53:
           c4:66:d2:a8:e2:6a:11:01:68:0d:a4:a6:bb:5b:e8:e2:f3:d4:
           67:5f:f4:e8:47:0b:e3:dc:2e:4d:dd:f9:09:71:59:24:6f:35:
           c9:5c:d2:3c:26:66:5e:92:de:8c:81:70:c5:fd:7f:93:a7:0b:
           08:80:e7:03:b0:1b:e6:6e:99:2e:a3:8c:b4:69:36:f2:3c:0b:
           6d:47:89:58:41:57:33:0b:72:a0:85:61:21:14:72:e3:b3:7d:
           b1:3d:7e:2f:de:14:4f:19:26:ce:41:c8:a2:ca:34:9b:33:d8:
           09:21:88:36:28:d9:4f:04:a9:ec:db:87:c5:e4:60:4e:23:11:
           18:70:81:3d:29:98:52:cf:fc:1b:81:be:86:6e:01:fa:0f:75:
           66:0c:5e:d7:4a:7f:71:fe:ae:8f:73:83:b5:cc:e1:00:f1:b7:
           8a:3a:06:fd:37:db:bb:c3:ba:3e:fb:74:dc:fd:03:8d:0b:cd:
           8f:e2:f6:70:81:e3:a1:1a:56:95:66:5d:49:5d:6a:a9:37:cb:
           2c:3a:4a:3f:fc:00:12:f8:f1:f5:78:e5:59:74:1a:cc:43:26:
           e3:a8:2a:00:c8:69:18:03:f5:8d:e6:fc:d0:02:65:57:05:f7:
           f2:2e:9c:a0:f4:c4:6f:ec:bd:9b:80:cc:05:4b:d7:0c:b0:40:
           d3:40:d5:82:b4:f3:86:89:7b:7a:c3:b4:f7:72:88:b4:7a:f9:
           dd:98:e7:89:57:08:67:6b:82:2a:05:30:61:c1:36:23:9e:27:
           ee:69:a8:24:a1:76:0e:e5:1e:82:c5:9c:f3:11:8e:65:99:0f:
           51:03:e1:5a:3c:1c:a7:0f:d9:5f:e4:d0:af:75:13:02:a2:52:
           97:4b:ea:f7:de:8f:7f:28:48:96:86:1c:95:eb:35:90:89:9c:
           61:c3:c8:02:14:0a:67:2a:c3:dc:31:cb:47:73:b4:cf:80:83:
           21:be:c7:e6:b8:34:59:73:2b:85:46:f6:27:f3:91:8f:ba:2d:
           bb:c6:0c:f6:c1:57:4c:33:0e:af:58:64:a8:94:e5:f5:a9:eb:
           3f:1c:70:af:e1:a7:e5:28:bc:23:b0:41:8d:e6:e8:50:8a:b2:
           45:fc:05:a9:7d:1a:c7:b6:94:32:c2:12:8e:01:7b:78:dd:85:
           f2:17:07:98:68:f9:85:e6:bd:08:e8:f4:94:74:4a:6b:a6:c6:
           e3:1c:d2:ea:bf:11:df:b7
  -----BEGIN CERTIFICATE-----
  MIIFWTCCA0GgAwIBAgIJAIhwHa4eLD6kMA0GCSqGSIb3DQEBCwUAMEMxCzAJBgNV
  BAYTAkZSMQ8wDQYDVQQIDAZGcmFuY2UxFDASBgNVBAcMC01vbnRwZWxsaWVyMQ0w
  CwYDVQQDDARQU1NDMB4XDTE4MDgxNjA5MDQwNloXDTE5MDgxNjA5MDQwNlowQzEL
  MAkGA1UEBhMCRlIxDzANBgNVBAgMBkZyYW5jZTEUMBIGA1UEBwwLTW9udHBlbGxp
  ZXIxDTALBgNVBAMMBFBTU0MwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoIC
  AQCnVUkIQKCBmXd8WkdoN09xb3Czme/9pSPDGMMnyxLVNQ5y8t70TO9DVs9U8dlq
  q1c5GmVaqATcXGVLF6uuAXMFYVe1HegSFFdtIUXYmln3ASiNgNlBUPC6UfVQvCbi
  DelQVz91VgEzWsvXQYP7KMFIMPcbBtihZZSQaPj88aMHazmsfMhNf+5Z7WNuBW9B
  hyyXm2mE/ZphHFqLn4IrlymKU61xw1cCUynVqszhwGNPFoQ/xjRmRspEMXCLW1MV
  zBJ+TwTp56KU5somNEQAnKdwqyF8ImVNcu9an8pHZUoTJPnCDbp53eOEM0YrYHzS
  8DirXUO/+17go+6/tDtrwYXR0W1xOaysfefl4ov2jUPBP6PHSBhTDU/0dQFyjXFR
  mSgVuY4Wpq77J0glWWsfAVSswGiL54anxRpj+fZl8+K/nb/eENm79rs/3asIbyUf
  KshkJgKOj8dBOG1VdoDaks2w6+hEiQkx/7ra91AVHQ+OqShQ03Cfq6YM3hYvr4Hx
  +NaFYfGi5jX2WJqkjBDZDTP9JJVQmBMQaKUx8aws8qd29cIZcJ0l/xjrW9CDMGSn
  8hN+WsJEvZXoc6Edfx1p8jyLNA0C5z9vrBEp4LhRuA6GZw6GmWQhToeut/bUh0Mm
  U0K1plBWf4No/jkC9HfeAv0GVPXq3ELKdfDoFeNZaQozMQIDAQABo1AwTjAdBgNV
  HQ4EFgQUEhmvnF/HZfknk1TBr/wboTDUqjMwHwYDVR0jBBgwFoAUEhmvnF/HZfkn
  k1TBr/wboTDUqjMwDAYDVR0TBAUwAwEB/zANBgkqhkiG9w0BAQsFAAOCAgEAXo3Y
  bDHLS9MkxGSHxP/JYfwWM+Yi6RcZk7j0GtPby3pxIjKoE94V6Nmd2lox2CS53jKO
  eTNTxGbSqOJqEQFoDaSmu1vo4vPUZ1/06EcL49wuTd35CXFZJG81yVzSPCZmXpLe
  jIFwxf1/k6cLCIDnA7Ab5m6ZLqOMtGk28jwLbUeJWEFXMwtyoIVhIRRy47N9sT1+
  L94UTxkmzkHIoso0mzPYCSGINijZTwSp7NuHxeRgTiMRGHCBPSmYUs/8G4G+hm4B
  +g91Zgxe10p/cf6uj3ODtczhAPG3ijoG/Tfbu8O6Pvt03P0DjQvNj+L2cIHjoRpW
  lWZdSV1qqTfLLDpKP/wAEvjx9XjlWXQazEMm46gqAMhpGAP1jeb80AJlVwX38i6c
  oPTEb+y9m4DMBUvXDLBA00DVgrTzhol7esO093KItHr53ZjniVcIZ2uCKgUwYcE2
  I54n7mmoJKF2DuUegsWc8xGOZZkPUQPhWjwcpw/ZX+TQr3UTAqJSl0vq996PfyhI
  loYcles1kImcYcPIAhQKZyrD3DHLR3O0z4CDIb7H5rg0WXMrhUb2J/ORj7otu8YM
  9sFXTDMOr1hkqJTl9anrPxxwr+Gn5Si8I7BBjeboUIqyRfwFqX0ax7aUMsISjgF7
  eN2F8hcHmGj5hea9COj0lHRKa6bG4xzS6r8R37c=
  -----END CERTIFICATE-----
```


This ends the RSA activity section. You can now start the ECC activity section [Step 3](https://github.com/IBM/ibm-z-elliptic-curve-cryptography/blob/master/ecc-lab.md).
