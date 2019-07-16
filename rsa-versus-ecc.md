# Welcome in Step 4 about comparing RSA and ECC performance.

## Agenda of this Step 4 is the following:
1. Performance summary
2. ECC and Hardware Acceleration

## Performance summary
In previous section, you tested the RSA and the ECC performance. You probably understood already how fast ECC is.

Let's conclude together about your findings. Please reports your test measured performance in the two following tables:

RSA Key size in bits | Key generation in seconds |  Digital signature in seconds  | Signature verification in seconds  | Certificate generation in seconds
------------ | ------------------ | ----------------------- | --------------------------- | --------------------------
RSA 1024     | | | |
RSA 2048     | | | |
RSA 3072     | | | |
RSA 4096     | | | |
RSA 7680     | | | |
RSA 15360    | | | |


ECC Key size in bits | Key generation in seconds |  Digital signature in seconds  | Signature verification in seconds  | Certificate generation in seconds
------------ | ------------------ | ----------------------- | --------------------------- | --------------------------
prime256v1    | | | |
secp384r1     | | | |
secp521r1     | | | |

Let's simplified these tables with the following table:

RSA Key size in bits | ECC Key size in bits |  Key size factor  | Key generation factor | Signature factor  | Certificate generation factor
------------ | ------------------ | ----------------------- | --------------------------- | -------------------------- | ----------
RSA 3072 | prime256v1    | 1:12 | 1:8 | 1:3 | 1:18
RSA 7680 | secp384r1     | 1:20 | 1:82 | 1:25 | 1:200
RSA 15360 | secp521r1     | 1:29 | 1:1600 | 1:23 | 1:1500+

**Note:**
* Key size factor = RSA key size / ECC key size
* Key generation factor = RSA Key generation in seconds / ECC Key generation in seconds
* Signature factor = RSA Digital signature in seconds / ECC Digital signature in seconds
* Certificate generation factor = RSA Certificate generation in seconds / ECC Certificate generation in seconds

## ECC and Hardware Acceleration

Even if there is no crypto cards configured, the LinuxONE server speed up ECC operations. This is thanks to CPACF that speed up SHA activity as required for the digital signature, and SIMD that speed up ECC operations.

Let see how much crypto activity we generated together during this hands-on lab by issuing the following command:
```
icastats
 function     |           hardware       |            software
--------------+--------------------------+-------------------------
              |      ENC    CRYPT   DEC  |      ENC    CRYPT   DEC 
--------------+--------------------------+-------------------------
        SHA-1 |         2270161          |                0
      SHA-224 |             750          |                0
      SHA-256 |            2192          |                0
      SHA-384 |             750          |                0
      SHA-512 |             750          |                0
        GHASH |          185250          |                0
        P_RNG |               0          |                0
 DRBG-SHA-512 |          126750          |                0
       RSA-ME |               0          |              750
      RSA-CRT |               0          |              750
      DES ECB |         0              0 |         0             0
      DES CBC |         0              0 |         0             0
      DES OFB |         0              0 |         0             0
      DES CFB |         0              0 |         0             0
      DES CTR |         0              0 |         0             0
     DES CMAC |         0              0 |         0             0
     3DES ECB |      1500           1500 |         0             0
     3DES CBC |      8250          12750 |         0             0
     3DES OFB |      1500           1500 |         0             0
     3DES CFB |      1500           1500 |         0             0
     3DES CTR |       750            750 |         0             0
    3DES CMAC |     10500           3750 |         0             0
      AES ECB |     36750           2250 |         0             0
      AES CBC |      9000          13500 |         0             0
      AES OFB |      2250           2250 |         0             0
      AES CFB |      4500           4500 |         0             0
      AES CTR |    117000           2250 |         0             0
     AES CMAC |     72000          11250 |         0             0
      AES XTS |      1500           1500 |         0             0

```

Congratulations, this ends the hands-on lab about LinuxONE and ECC.
