# AES-CBC-MetaTrader
AES 256 bit algorithm in CBC mode for MetaTrader

This is an implementation of the AES algorithm, specifically CBC mode.

Based on the code https://github.com/kokke/tiny-AES-c. There you can see the code's comments that have been removed here.

## Usage
```C
   // Initialize context calling one of:
   void AES_init_ctx(AES_ctx& ctx, const uchar &key[]);
   void AES_init_ctx_iv(AES_ctx &ctx, const uchar &key[], const uchar &iv[]);
   
   // Set IV
   void AES_ctx_set_iv(AES_ctx &ctx, const uchar &iv[]);
   
   // Then start encrypting and decrypting with the functions below:
   void AES_CBC_encrypt_buffer(AES_ctx &ctx, uchar &buf[], uchar &out[]);
   void AES_CBC_decrypt_buffer(AES_ctx &ctx, uchar &buf[], uchar &out[]);
   
   // Padding the buffer
   void fillPadding_PKCS7(uchar &buf[]);
   
   // Checks if padding is filled in correctly
   bool checkPadding_PKCS7(const uchar &buf[]);
   
   // Removes padding
   void unFillPadding_PKCS7(uchar &buf[]);
```
