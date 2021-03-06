#property strict

#include "aes.mqh"

string ArrayToHex(uchar &arr[], int count = -1){ 
   string res = "";
   
   if (count < 0 || count > ArraySize(arr)) count = ArraySize(arr);
   
   for (int i = 0; i < count; i++) res += StringFormat("%.2X ", arr[i]);
   
   return(res); 
}

int stringToHex(string src, uchar &arr[]){
   return StringToCharArray(src, arr, 0, StringLen(src));
}

string HexToString(uchar &arr[]){
   return CharArrayToString(arr);
}

void OnStart(){
   // TestData
      string inputMsg= "abcdefghijklmnopqrstuvwxyz0123456789";
      uchar in[];
      stringToHex(inputMsg, in);
   // OR
      /*uchar in[] = { 0x61, 0x62, 0x63, 0x64, 0x65, 0x66, 0x67, 0x68, 0x69, 0x6a, 0x6b, 0x6c, 0x6d, 0x6e, 0x6f, 0x70,
                       0x71, 0x72, 0x73, 0x74, 0x75, 0x76, 0x77, 0x78, 0x79, 0x7a, 0x30, 0x31, 0x32, 0x33, 0x34, 0x35,
                       0x36, 0x37, 0x38, 0x39 };*/
   // TestData
   
   uchar key[] = { 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
                   0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18, 0x19, 0x1a, 0x1b, 0x1c, 0x1d, 0x1e, 0x1f };
   uchar iv[] = { 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f };
   
   AES_ctx ctx;
   
   uchar encode[];
   
    
   PrintFormat("Source data string: %s", HexToString(in));
   PrintFormat("Source data: %s", ArrayToHex(in));
   PrintFormat("Key data: %s", ArrayToHex(key));
   PrintFormat("Iv data: %s", ArrayToHex(iv));
   
   AES_init_ctx_iv(ctx, key, iv);
   
   fillPadding_PKCS7(in);
   PrintFormat("Source data after padding: %s", ArrayToHex(in));
   
   AES_CBC_encrypt_buffer(ctx, in, encode);
   PrintFormat("Encoded data: %s", ArrayToHex(encode));
   
   uchar decode[];
   ArrayCopy(decode, encode);
   
   AES_CBC_decrypt_buffer(ctx, encode, decode);
   PrintFormat("Decoded data: %s", ArrayToHex(decode));
   
   Print("Check padding: ", checkPadding_PKCS7(decode));
   
   unFillPadding_PKCS7(decode);
   PrintFormat("Decoded data without padding: %s", ArrayToHex(decode));
   
   PrintFormat("Decoded data: %s", HexToString(decode));
}