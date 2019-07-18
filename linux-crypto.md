# Welcome in Step 1 about enabling Linux to use hardware encryption

## Agenda of this Step 1 is the following:
1. Introduction to the pervasive encryption
2. Introduction to the Linux crypto stack
3. Enabling Linux to use the Hardware
4. Enabling OpenSSL to use the hardware acceleration support
5. Checking Hardware Crypto functions

## Provisioning a LinuxONE Linux Guest thanks to the Community Cloud

### Sign up for a LinuxONE Community Cloud trial account
If you have not done so already, register at http://www.ibm.com/linuxone/try for a 120-day trial account. You will receive an email containing credentials to access the LinuxONE Community Cloud self-service portal. This is where you can start exploring all our available services.

### Deploy a virtual server instance
If you have not deployed a virtual server already, please follow these [instructions](http://developer.ibm.com/linuxone/wp-content/uploads/sites/57/virtual-servers-quick-start.pdf) to create one before proceeding. Make sure you select a flavor (resource definition) with 4 GB of memory. 

This quick-start guide has been tested with the following Linux distributions: **Red Hat Enterprise Linux (RHEL) 7.6**

# 1 - Introduction to the pervasive encryption
Pervasive encryption is a data-centric approach to information security that entails protecting data entering and exiting the z14 platform. It involves encrypting data in-flight and at-rest to meet complex compliance mandates and reduce the risks and financial losses of a data breach. It is a paradigm shift from selective encryption (where only the data that is required to achieve compliance is encrypted) to pervasive encryption. Pervasive encryption with z14 is enabled through tight platform integration that includes Linux on IBM Z or LinuxONE following features:
* Integrated cryptographic hardware: Central Processor Assist for Cryptographic Function (CPACF) is a co-processor on every processor unit that accelerates encryption. Crypto Express features can be used as hardware security modules (HSMs).
* Data set and file encryption: You can protect Linux file systems that is transparent to applications and databases.
* Network encryption: You can protect network data traffic by using standards-based encryption from endpoint to endpoint.

# 2 - Introduction to the Linux crypto stack
Pervasive Encryption benefits of the full Power of Linux Ecosystem plus z14 Capabilities
* LUKS dm-crypt – Transparent file & volume encryption using industry unique CPACF protected-keys
* Network Security – Enterprise scale encryption and handshakes using z14 CPACF and SIMD (openSSL, IPSec...)

The IBM Z and LinuxONE systems provide cryptographic functions that, from an application program perspective, can be grouped as follows:
* Synchronous cryptographic functions, provided by the CP Assist for Cryptographic Function (CPACF) or the Crypto Express features when defined as an accelerator.
* Asynchronous cryptographic functions, provided by the Crypto Express features.

The IBM Z and LinuxONE systems provide also rich cryptographic functions available via a complete crypto stack made of a set of key crypto APIs.
![Image of the Crypto Stack](https://github.com/guikarai/PE-LinuxONE/blob/master/images/crypto-stack.png)

**Note:** Locate openSSL and dm-crypt. For the following, we will work on how set-up a Linux environment in order to benefit of Pervasive Encryption benefits.
  
# 3 - Enabling Linux to use the Hardware
## CPACF Enablement verification
A Linux on IBM Z user can easily check whether the Crypto Enablement feature is installed and which algorithms are supported in hardware. Hardware-acceleration for DES, TDES, AES, and GHASH requires CPACF. Issue the command shown below to discover whether the CPACF feature is enabled
on your hardware.
```
cat /proc/cpuinfo
vendor_id       : IBM/S390
# processors    : 4
bogomips per cpu: 21881.00
max thread id   : 0
features	: esan3 zarch stfle msa ldisp eimm dfp edat etf3eh highgprs te vx vxd vxe gs sie 
facilities      : 0 1 2 3 4 6 7 8 9 10 12 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 30 31 32 33 34 35 36 37 38 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 57 58 59 60 73 74 75 76 77 80 81 82 128 129 130 131 133 134 135 146 147 168 1024 1025 1026 1027 1028 1030 1031 1032 1033 1034 1036 1038 1039 1040 1041 1042 1043 1044 1045 1046 1047 1048 1049 1050 1051 1052 1054 1055 1056 1057 1058 1059 1060 1061 1062 1064 1065 1066 1067 1068 1069 1070 1071 1072 1073 1074 1075 1076 1077 1078 1079 1081 1082 1083 1084 1097 1098 1099 1100 1101 1104 1105 1152 1153 1154 1155 1157 1158 1159 1170 1171 1192
cache0          : level=1 type=Data scope=Private size=128K line_size=256 associativity=8
cache1          : level=1 type=Instruction scope=Private size=128K line_size=256 associativity=8
cache2          : level=2 type=Data scope=Private size=4096K line_size=256 associativity=8
cache3          : level=2 type=Instruction scope=Private size=2048K line_size=256 associativity=8
cache4          : level=3 type=Unified scope=Shared size=131072K line_size=256 associativity=32
cache5          : level=4 type=Unified scope=Shared size=688128K line_size=256 associativity=42
processor 0: version = FF,  identification = 233EF7,  machine = 3906
processor 1: version = FF,  identification = 233EF7,  machine = 3906
processor 2: version = FF,  identification = 233EF7,  machine = 3906
processor 3: version = FF,  identification = 233EF7,  machine = 3906
```

**Note**: msa on line 4, indicates that the CPACF instruction is properly supported and detected.

**Note 2**: vx on line 4, indicates that SIMD and vector instructions are properly supported and detected.

## Installing libica
To make use of the libica hardware support for cryptographic functions, you must install the libica package. Obtain the current libica version from your distribution provider for automated installation by issuing the following command:
```
yum install libica-utils
```

After the libica utility is installed, use the **icainfo** command to check on the CPACF feature code enablement. 
The icainfo command displays which CPACF functions are supported by the implementation inside the libica library. Issue the following command to show which cryptographic algorithms will be hardware-accelerated by the libica driver, and which one will remain software-only implementations.

```
icainfo

        Cryptographic algorithm support      
  -------------------------------------------
   function      |  hardware  |  software  
  ---------------+------------+------------
           SHA-1 |    yes     |     yes
         SHA-224 |    yes     |     yes
         SHA-256 |    yes     |     yes
         SHA-384 |    yes     |     yes
         SHA-512 |    yes     |     yes
           GHASH |    yes     |      no
           P_RNG |    yes     |     yes
    DRBG-SHA-512 |    yes     |     yes
          RSA ME |     no     |     yes
         RSA CRT |     no     |     yes
         DES ECB |    yes     |     yes
         DES CBC |    yes     |     yes
         DES OFB |    yes     |      no
         DES CFB |    yes     |      no
         DES CTR |    yes     |      no
        DES CMAC |    yes     |      no
        3DES ECB |    yes     |     yes
        3DES CBC |    yes     |     yes
        3DES OFB |    yes     |      no
        3DES CFB |    yes     |      no
        3DES CTR |    yes     |      no
       3DES CMAC |    yes     |      no
         AES ECB |    yes     |     yes
         AES CBC |    yes     |     yes
         AES OFB |    yes     |      no
         AES CFB |    yes     |      no
         AES CTR |    yes     |      no
        AES CMAC |    yes     |      no
         AES XTS |    yes     |      no
  -------------------------------------------
  Built-in FIPS support: FIPS mode inactive.
```

From the **cpuinfo** output, you can find the features that are enabled in the central processors. 
If the features list has msa listed, it means that CPACF is enabled. Most of the distributions include a generic kernel image for the specific platform. 
These device drivers for the generic kernel image are included as loadable kernel modules because statically compiling many drivers into one kernel causes the kernel image to be much larger. This kernel might be too large to boot on computers with limited memory.

## Loading crypto modules
Let's use the **modprobe** command to load the device driver modules. Initially the Linux system is not yet configured to use  the crypto device driver modules, so you must load them manually. The cryptographic device drivers consists of multiple,
separate modules.
```
modprobe aes_s390
modprobe des_s390
modprobe sha_common
modprobe sha1_s390
modprobe sha256_s390
modprobe sha512_s390
modprobe rng     
modprobe prng
modprobe hmac
modprobe ghash
modprobe xts
modprobe ctr
modprobe gcm
```

## Pervasive Encryption readiness assessment
Validate that all the crypto modules are properly loaded. Please issue the following command:
```
lsmod

  Module                  Size  Used by
  ghash_generic          12647  0 
  ghash_s390             12608  0 
  xts                    12944  0 
  gf128mul               18889  2 xts,ghash_generic
  ap                     40210  0 
  sha512_s390            12637  0 
  des_s390               13605  0 
  des_generic            25475  1 des_s390
  aes_s390               18044  0 
  prng                   15562  0 
  gcm                    27822  0 
  qeth_l3                96273  1 
  dm_mirror              27404  0 
  dm_region_hash         20992  1 dm_mirror
  dm_log                 19301  2 dm_region_hash,dm_mirror
  dm_mod                175666  2 dm_log,dm_mirror
  nfsd                  483013  1 
  auth_rpcgss            87192  1 nfsd
  nfs_acl                12837  1 nfsd
  lockd                 126989  1 nfsd
  grace                  13684  2 nfsd,lockd
  sunrpc                475171  7 nfsd,auth_rpcgss,lockd,nfs_acl
  smsgiucv_app           13100  0 
  smsgiucv               13564  1 smsgiucv_app
  ip_tables              28006  0 
  ext4                  752462  1 
  mbcache                19112  1 ext4
  jbd2                  144631  1 ext4
  qeth_l2                50075  1 
  dasd_eckd_mod         121814  4 
  dasd_mod              147983  3 dasd_eckd_mod
  qeth                  156071  2 qeth_l2,qeth_l3
  ccwgroup               19383  1 qeth
  qdio                   76112  3 qeth,qeth_l2,qeth_l3
```

Validate that the libica crypto API is working properly. Please issue the following command:
```
icastats

   function     |          # hardware      |       # software
  --------------+--------------------------+-------------------------
                |       ENC    CRYPT   DEC |        ENC    CRYPT   DEC
  --------------+--------------------------+-------------------------
          SHA-1 |               0          |                0
        SHA-224 |               0          |                0
        SHA-256 |               0          |                0
        SHA-384 |               0          |                0
        SHA-512 |               0          |                0
       SHA3-224 |               0          |                0
       SHA3-256 |               0          |                0
       SHA3-384 |               0          |                0
       SHA3-512 |               0          |                0
      SHAKE-128 |               0          |                0
      SHAKE-256 |               0          |                0
          GHASH |               0          |                0
          P_RNG |               0          |                0
   DRBG-SHA-512 |             169          |                0
           ECDH |               0          |                0
     ECDSA Sign |               0          |                0
   ECDSA Verify |               0          |                0
         ECKGEN |               0          |                0
         RSA-ME |               0          |                0
        RSA-CRT |               0          |                0
        DES ECB |         0              0 |         0             0
        DES CBC |         0              0 |         0             0
        DES OFB |         0              0 |         0             0
        DES CFB |         0              0 |         0             0
        DES CTR |         0              0 |         0             0
       DES CMAC |         0              0 |         0             0
       3DES ECB |         0              0 |         0             0
       3DES CBC |         0              0 |         0             0
       3DES OFB |         0              0 |         0             0
       3DES CFB |         0              0 |         0             0
       3DES CTR |         0              0 |         0             0
      3DES CMAC |         0              0 |         0             0
        AES ECB |         0              0 |         0             0
        AES CBC |         0              0 |         0             0
        AES OFB |         0              0 |         0             0
        AES CFB |         0              0 |         0             0
        AES CTR |         0              0 |         0             0
       AES CMAC |         0              0 |         0             0
        AES XTS |         0              0 |         0             0
        AES GCM |         0              0 |         0             0
```
**Note:** As you can see, there is already some crypto offload regarding DRBG-SHA-512. That is a good start ;D

**Note 2:** For your information, DRBG stands for Deterministic Random Bits Generator. It is an algorithm for generating a sequence of numbers whose properties approximate the properties of sequences of random numbers.

Your hands-on LAB environment is now properly setup!

# 4 - Enabling OpenSSL to use the hardware acceleration support

This chapter describes how to use the cryptographic functions of the LinuxONE server to encrypt data in flight. This technique means that the data is encrypted and decrypted before and after it is transmitted. We will use OpenSSL, SCP and SFTP to demonstrate the encryption of data in flight. 
This chapter also shows how to customize the product to use the LinuxONE hardware encryption features. This chapter includes the following sections:
- Preparing to use openSSL
- Configuring OpenSSL
- Testing Hardware Crypto functions with OpenSSL

## Preparing to use OpenSSL
In the Linux system you use, OpenSSL is already installed, and the system is already enabled to use the cryptographic hardware of the LinuxONE server. We also loaded the cryptographic device drivers and the libica to use the crypto hardware. For the following steps, the following packages are required for encryption:
- openssl
- openssl-libs
- openssl-ibmca

During the installation of Ubuntu, the package openssl-ibmca was not automatically installed and needs to be installed manually. Please issue the following command:
```
yum install openssl-ibmca
```
Now all needed packages are successfully installed. At this moment only the default engine of OpenSSL is available. To check it, please issue the following command:
```
openssl engine -c

  (dynamic) Dynamic engine loading support
```
## Configuring OpenSSL
To use the ibmca engine and to benefit from the Cryptographic hardware support, the configuration file of OpenSSL needs to be adjusted. To customize OpenSSL configuration to enable dynamic engine loading for ibmca, complete the following steps.
### Locate the OpenSSL configuration file, which in our RHEL distribution is in this subdirectory: 
```
ls /usr/share/doc/openssl-ibmca-2.0.0/
```

### Make a backup copy of the configuration file
Locate the main configuration file of openssl. Its name is openssl.cnf. Please issue the following command:
```
ls -la /etc/pki/tls/openssl.cnf

  -rw-r--r--. 1 root root 10923 Aug 14  2018 /etc/pki/tls/openssl.cnf
```
Make a backup copy of the configuration file. We will modify it later, so just in case, please issue the following command:
```
cp -p /etc/pki/tls/openssl.cnf /etc/pki/tls/openssl.cnf.backup
```

Check one more time that everything is alright and secured. Please issue the following command:
```
ls -al /etc/pki/tls/openssl.cnf*

  -rw-r--r--. 1 root root 10923 Aug 14  2018 /etc/pki/tls/openssl.cnf
  -rw-r--r--  1 root root 10923 Aug 14  2018 /etc/pki/tls/openssl.cnf.backup
```

### Append the ibmca-related configuration lines to the OpenSSL configuration file
```
tee -a /etc/pki/tls/openssl.cnf < /usr/share/doc/openssl-ibmca-2.0.0/openssl.cnf.sample.s390x
```

The reference to the ibmca section in the OpenSSL configuration file needs to be inserted. Therefore, insert the following line as show below at the line 10.
"openssl_conf = openssl_def"
```
vi /etc/pki/tls/openssl.cnf

  #
  # OpenSSL example configuration file.
  # This is mostly being used for generation of certificate requests.
  #
  # This definition stops the following lines choking if HOME isn't
  # defined.
  HOME = .
  RANDFILE = $ENV::HOME/.rnd
  openssl_conf = openssl_def            #<======================================= line inserted
  # Extra OBJECT IDENTIFIER info:
  #oid_file = $ENV::HOME/.oid
  oid_section = new_oids
  # To use this configuration file with the "-extfile" option of the
  # "openssl x509" utility, name here the section containing the
  # X.509v3 extensions to use:
```

# 5 - Checking Hardware Crypto functions
Now that the customization of OpenSSL in done, test whether you can use the LinuxONE hardware cryptographic functions. First, let's check whether the dynamic engine loading support is enabled by default and the engine ibmca is available and used in the installation.
```
openssl engine -c

(dynamic) Dynamic engine loading support
(ibmca) Ibmca hardware engine support
 [RSA, DSA, DH, RAND, DES-ECB, DES-CBC, DES-OFB, DES-CFB, DES-EDE3, DES-EDE3-CBC, DES-EDE3-OFB, DES-EDE3-CFB, AES-128-ECB, AES-192-ECB, AES-256-ECB, AES-128-CBC, AES-192-CBC, AES-256-CBC, AES-128-OFB, AES-192-OFB, AES-256-OFB, AES-128-CFB, AES-192-CFB, AES-256-CFB, id-aes128-GCM, id-aes192-GCM, id-aes256-GCM, SHA1, SHA256, SHA512]
```

## Testing Pervasive encryption with OpenSSL
Now openSSL is properly configured. All crypto operation passing through openSSL will be hardware accelerated if possible. Let's test it in live. Firt of all, let's have a look of the hardware crypto offload status. Please issue the following command:
```
icastats

   function     |          # hardware      |       # software
  --------------+--------------------------+-------------------------
                |       ENC    CRYPT   DEC |        ENC    CRYPT   DEC
  --------------+--------------------------+-------------------------
          SHA-1 |               0          |                0
        SHA-224 |               0          |                0
        SHA-256 |               0          |                0
        SHA-384 |               0          |                0
        SHA-512 |               0          |                0
       SHA3-224 |               0          |                0
       SHA3-256 |               0          |                0
       SHA3-384 |               0          |                0
       SHA3-512 |               0          |                0
      SHAKE-128 |               0          |                0
      SHAKE-256 |               0          |                0
          GHASH |               0          |                0
          P_RNG |               0          |                0
   DRBG-SHA-512 |             676          |                0
           ECDH |               0          |                0
     ECDSA Sign |               0          |                0
   ECDSA Verify |               0          |                0
         ECKGEN |               0          |                0
         RSA-ME |               0          |                0
        RSA-CRT |               0          |                0
        DES ECB |         0              0 |         0             0
        DES CBC |         0              0 |         0             0
        DES OFB |         0              0 |         0             0
        DES CFB |         0              0 |         0             0
        DES CTR |         0              0 |         0             0
       DES CMAC |         0              0 |         0             0
       3DES ECB |         0              0 |         0             0
       3DES CBC |         0              0 |         0             0
       3DES OFB |         0              0 |         0             0
       3DES CFB |         0              0 |         0             0
       3DES CTR |         0              0 |         0             0
      3DES CMAC |         0              0 |         0             0
        AES ECB |         0              0 |         0             0
        AES CBC |         0              0 |         0             0
        AES OFB |         0              0 |         0             0
        AES CFB |         0              0 |         0             0
        AES CTR |         0              0 |         0             0
       AES CMAC |         0              0 |         0             0
        AES XTS |         0              0 |         0             0
        AES GCM |         0              0 |         0             0
```
As you can see, the libica API already detect some crypto offload to the hardware.

Let's go deeper with some openSSL tests. Please issue the following command:
```
openssl speed -evp aes-128-cbc
Doing aes-128-cbc for 3s on 16 size blocks: 31284015 aes-128-cbc's in 2.92s
Doing aes-128-cbc for 3s on 64 size blocks: 28411386 aes-128-cbc's in 2.96s
Doing aes-128-cbc for 3s on 256 size blocks: 21488621 aes-128-cbc's in 2.98s
Doing aes-128-cbc for 3s on 1024 size blocks: 10578513 aes-128-cbc's in 2.97s
Doing aes-128-cbc for 3s on 8192 size blocks: 1775920 aes-128-cbc's in 2.97s
OpenSSL 1.0.2k-fips  26 Jan 2017
built on: reproducible build, date unspecified
options:bn(64,64) md2(int) rc4(8x,char) des(idx,cisc,16,int) aes(partial) idea(int) blowfish(idx) 
compiler: gcc -I. -I.. -I../include  -fPIC -DOPENSSL_PIC -DZLIB -DOPENSSL_THREADS -D_REENTRANT -DDSO_DLFCN -DHAVE_DLFCN_H -DKRB5_MIT -m64 -DB_ENDIAN -Wall -O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector-strong --param=ssp-buffer-size=4 -grecord-gcc-switches   -m64 -march=z196 -mtune=zEC12 -Wa,--noexecstack -DPURIFY -DOPENSSL_BN_ASM_MONT -DOPENSSL_BN_ASM_GF2m -DRC4_ASM -DSHA1_ASM -DSHA256_ASM -DSHA512_ASM -DAES_ASM -DAES_CTR_ASM -DAES_XTS_ASM -DGHASH_ASM
The 'numbers' are in 1000s of bytes per second processed.
type             16 bytes     64 bytes    256 bytes   1024 bytes   8192 bytes
aes-128-cbc     171419.26k   614300.24k  1846002.34k  3647271.82k  4898429.85k
```
The last line is quite interesting, it shows the encrypion bandwidth of one IFL - encrypting blocks of 8192 bytes of data over and over, as fast as possible. In this case, the observed throughput is roughly 4,8 GB/s (4898429.85/(1024\*1024)).

Let's test now the decryption capabilities. Please issue the following command:
```
openssl speed -evp aes-128-cbc -decrypt

  Doing aes-128-cbc for 3s on 16 size blocks: 33183167 aes-128-cbc's in 2.86s
  Doing aes-128-cbc for 3s on 64 size blocks: 32184259 aes-128-cbc's in 2.87s
  Doing aes-128-cbc for 3s on 256 size blocks: 27682462 aes-128-cbc's in 2.88s
  Doing aes-128-cbc for 3s on 1024 size blocks: 16928435 aes-128-cbc's in 2.91s
  Doing aes-128-cbc for 3s on 8192 size blocks: 5391831 aes-128-cbc's in 2.93s
  OpenSSL 1.0.2g  1 Mar 2016
  built on: reproducible build, date unspecified
  options:bn(64,64) rc4(8x,char) des(idx,cisc,16,int) aes(partial) blowfish(idx) 
  compiler: cc -I. -I.. -I../include  -fPIC -DOPENSSL_PIC -DOPENSSL_THREADS -D_REENTRANT -DDSO_DLFCN -DHAVE_DLFCN_H -DB_ENDIAN -g -O2 -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2 -Wl,-Bsymbolic-functions -Wl,-z,relro -Wa,--noexecstack -Wall -DOPENSSL_BN_ASM_MONT -DOPENSSL_BN_ASM_GF2m -DSHA1_ASM -DSHA256_ASM -DSHA512_ASM -DAES_ASM -DAES_CTR_ASM -DAES_XTS_ASM -DGHASH_ASM
  The 'numbers' are in 1000s of bytes per second processed.
  type             16 bytes     64 bytes    256 bytes   1024 bytes   8192 bytes
  aes-128-cbc     185640.10k   717697.76k  2460663.29k  5956947.57k 15075044.22k
```

Same computation, as you can see the observed throuthput is 15 GB/s. That is normal because the CBC mode of operation associated with the AES encryption algorithm is faster in decryption that in encryption.

Let's check now how much crypto we offload to the hardware. Please issue the following command:
```
icastats
 function     |           hardware       |            software
--------------+--------------------------+-------------------------
              |      ENC    CRYPT   DEC  |      ENC    CRYPT   DEC 
--------------+--------------------------+-------------------------
        SHA-1 |               2          |                0
      SHA-224 |               2          |                0
      SHA-256 |               2          |                0
      SHA-384 |               2          |                0
      SHA-512 |               2          |                0
     SHA3-224 |               0          |                0
     SHA3-256 |               0          |                0
     SHA3-384 |               0          |                0
     SHA3-512 |               0          |                0
    SHAKE-128 |               0          |                0
    SHAKE-256 |               0          |                0
        GHASH |             166          |                0
        P_RNG |               0          |                0
 DRBG-SHA-512 |             340          |                0
         ECDH |               0          |                0
   ECDSA Sign |               0          |                0
 ECDSA Verify |               0          |                0
       ECKGEN |               0          |                0
       RSA-ME |               2          |                0
      RSA-CRT |               2          |                0
      DES ECB |         0              0 |         0             0
      DES CBC |         0              0 |         0             0
      DES OFB |         0              0 |         0             0
      DES CFB |         0              0 |         0             0
      DES CTR |         0              0 |         0             0
     DES CMAC |         0              0 |         0             0
     3DES ECB |         4              4 |         0             0
     3DES CBC |        22             34 |         0             0
     3DES OFB |         4              4 |         0             0
     3DES CFB |         4              4 |         0             0
     3DES CTR |         2              2 |         0             0
    3DES CMAC |        28             10 |         0             0
      AES ECB |        98              6 |         0             0
      AES CBC |  92253124      105806394 |         0             0
      AES OFB |         6              6 |         0             0
      AES CFB |        12             12 |         0             0
      AES CTR |        98              6 |         0             0
     AES CMAC |       192             30 |         0             0
      AES XTS |         4              4 |         0             0
      AES GCM |        60             78 |         0             0
```
**Note:** We can clearly see here the crypto offload in encryption operations. 92253124 operations were offloaded to the CPACF.
**Note2:** We can clearly see here the crypto offload in decryption operations. 105806394 operations were offloaded to the CPACF.

You are now ready to go the [Step 2](https://github.com/IBM/ibm-z-elliptic-curve-cryptography/edit/master/rsa-lab.md).
