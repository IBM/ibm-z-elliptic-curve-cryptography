# Protect data on LinuxONE with "Elliptic-curve cryptography"

When you will complete this hands-on exploration of the ECC on LinuxONE, you will understand how to:
* Preparing your Linux Environment to use hardware crypto
* Enabling OpenSSL to use the Hardware
* Monitor RSA public key activity performance
* Monitor ECC public key activity performance
* Compare RSA and ECC performance

# Architecture
This journey requires an existing Linux on IBM Z environment of your choice as starting point. From there, and after some optimization, you will be able to generate both RSA and ECC activities and measure their relative performance regarding several use cases.
![alt-text](https://github.com/guillaume-hoareau/ibm-z-elliptic-curve-cryptography/blob/master/images/linuxone-ecc.png)

1. User optimizes, and monitors Enterprise Legacy environment encryption activity.
2. User stumilates RSA and ECC activities and measure performance of these activities.
3. User compares RSA and ECC performance and concludes about the inevitable down-fall of RSA.

## What is ECC?
Elliptic-curve cryptography (ECC) is an approach to public-key cryptography based on the algebraic structure of elliptic curves over finite fields. ECC requires smaller keys compared to non-ECC cryptography (based on plain Galois fields) to provide equivalent security. Elliptic curves are applicable for key agreement, digital signatures, pseudo-random generators and other tasks. Indirectly, they can be used for encryption by combining the key agreement with a symmetric encryption scheme. They are also used in several integer factorization algorithms based on elliptic curves that have applications in cryptography, such as Lenstra elliptic-curve factorization.

## Why ECC, why now?
ECC's main advantage is that you can use smaller keys for the same level of security, especially at high levels of security (AES-256 ~ ECC-512 ~ RSA-15424). Key advantages of ECC are:
* Smaller keys, ciphertexts and signatures.
* Very fast key generation.
* Fast signatures.
* Moderately fast encryption and decryption.
* Signatures can be computed in two stages, allowing latency much lower than inverse throughput.
* Good protocols for authenticated key exchange.
* Binary curves are really fast in hardware.

The RSA algorithm is closing in on its 40th birthday and remains the standard public key exchange on the Internet today. However, researchers at Black Hat USA 2013 made a call for usage of elliptic curve cryptography in favor of the RSA algorithm, which the experts said could be cracked in the next five years.

The level of security in systems is becoming a primary concern as you would expect. Most cryptographic experts recommend that current systems offer at least 128 bits of security, but what does that really mean? 

![alt-text](https://www.globalsign.com/files/1714/3284/2298/key-size-comparison.jpg)

Note that this is not the same thing as key length as many may think. Security comes from the combination of the specific algorithm and its key length. For example, it is generally thought that 128 bits of security can be achieved with 128-bit AES keys, 256-bit Elliptic Curve keys, and 3072-bit RSA keys. If implementation issues are ignored, then these algorithms with those specified key lengths will generally have the same level of security.

# Included components
* [LinuxONE Crypto](https://www.ibm.com/it-infrastructure/linuxone/capabilities/secure-cloud)
* [OpenSSL](https://www.openssl.org/)

# Featured technologies
* [IBM LinuxONE](https://www.ibm.com/it-infrastructure/linuxone)

# Steps

* **Step 1** - [Enabling Linux to use hardware encryption](https://github.com/guikarai/LinuxONE-ECC/blob/master/linux-crypto.md)
```
    1. Introduction to the pervasive encryption
    2. Introduction to the Linux crypto stack
    3. Enabling Linux to use the Hardware
    4. Enabling OpenSSL to use the hardware acceleration support
    5. Checking Hardware Crypto functions
  ```  

* **Step 2** - [Monitor RSA public key activity performance](https://github.com/guikarai/LinuxONE-ECC/blob/master/rsa-lab.md)
```
    1. RSA performance table
    2. Generating public keys with RSA
    3. Signing a pdf file with RSA
    4. Verifying digital signature of a pdf file with RSA
    5. Generating x509 digital certificates with RSA
```    

* **Step 3** - [Monitor ECC public key acticity performance](https://github.com/guikarai/LinuxONE-ECC/blob/master/ecc-lab.md)
```
    1. ECC performance table
    2. Generating public keys with ECC
    3. Signing a pdf file with ECC
    4. Verifying digital signature of a pdf file with ECC
    5. Generating x509 digital certificates with ECC
```    

* **Step 4** - [Compare RSA and ECC performance](https://github.com/guikarai/LinuxONE-ECC/blob/master/rsa-versus-ecc.md)
```
    1. Performance summary
    2. ECC and Hardware Acceleration
```
