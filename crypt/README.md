# Crypt


- **Symmetric** encryption: same key for both encryption and decryption
- **Asymmetric** encryption: uses a pair of keys (a public key and a private key)
  - encrypt data with the public key, and only the corresponding private key can decrypt it.
  - does not involve symmetric keys for the encryption process.


_Symmetric encryption is generally preferred for encrypting large files due to its efficiency and speed. Asymmetric encryption would be impractical for large files because of the significant computational resources and time it would require._



**Generate GPG key pair**:

```bash
gpg --full-generate-key
```


## Encryption

```bash
gpg --verbose --output ENCRYPTED_FILE --symmetric --no-symkey-cache FILE_TO_ENCRYPT

# or

gpg --verbose --log-time --log-file LOG_FILE --output ENCRYPTED_FILE --symmetric --no-symkey-cache FILE_TO_ENCRYPT
```



## Decryption

```bash
gpg --verbose --output DECRYPTED_FILE --decrypt --no-symkey-cache ENCRYPTED_FILE

# or

gpg --verbose --log-time --log-file LOG_FILE --output DECRYPTED_FILE  --decrypt --no-symkey-cache ENCRYPTED_FILE
```



## GPG Agent

**Reload Agent**:

```bash
echo RELOADAGENT | gpg-connect-agent

# or

gpgconf --reload gpg-agent

# or

gpgconf --reload

# or

gpgconf --kill gpg-agent

# or

gpg-connect-agent reloadagent /bye
```



## Cache

> gpg2 caches the passphrase used for symmetric encryption so that a decrypt operation may not require that
> the user needs to enter the passphrase. The option ‐‐no‐symkey‐cache can be used to disable this feature.


```
# gpg
       ‐‐symmetric
       ‐c     Encrypt  with  a  symmetric cipher using a passphrase. The default symmetric cipher used is AES‐128, but may be chosen with the ‐‐cipher‐algo option. This command may be combined with ‐‐sign
              (for a signed and symmetrically encrypted message), ‐‐encrypt (for a message that may be decrypted via a secret key or a passphrase), or ‐‐sign and ‐‐encrypt together (for a  signed  message
              that  may  be  decrypted via a secret key or a passphrase).  gpg2 caches the passphrase used for symmetric encryption so that a decrypt operation may not require that the user needs to enter
              the passphrase.  The option ‐‐no‐symkey‐cache can be used to disable this feature.

       ‐‐no‐symkey‐cache
              Disable the passphrase cache used for symmetrical en‐ and decryption.  This cache is based on the message specific salt value (cf. ‐‐s2k‐mode).

```



```
# gpg-agent

       ‐‐default‐cache‐ttl n
              Set the time a cache entry is valid to n seconds.  The default is 600 seconds.  Each time a cache entry is accessed, the entry’s timer is reset.  To set an entry’s maximum lifetime, use max‐
              cache‐ttl.   Note that a cached passphrase may not be evicted immediately from memory if no client requests a cache operation.  This is due to an internal housekeeping function which is only
              run every few seconds.

       ‐‐max‐cache‐ttl n
              Set the maximum time a cache entry is valid to n seconds.  After this time a cache entry will be expired even if it has been accessed recently or has been  set  using  gpg‐preset‐passphrase.
              The default is 2 hours (7200 seconds).
```



```
# ~/.gnupg/gpg-agent.conf

default-cache-ttl 0
max-cache-ttl 0
```

