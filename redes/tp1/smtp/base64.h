#ifndef BASE64_H
#define	BASE64_H

#ifndef DEBUG
#define DEBUG
#endif

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define NUMCARACTERES 76

static const char decoded_caracters[]="|$$$}rstuvwxyz{$$$$$$$>?@ABCDEFGHIJKLMNOPQRSTUVW$$$$$$XYZ[\\]^_`abcdefghijklmnopq";
static const char encoded_caracters[]="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";

void encode(char *file_src, char *file_dst);

void decode(char *file_src, char *file_dst);

void encode_base64(unsigned char *str, int result, FILE* fout);

void decode_base64(unsigned char *str, FILE* fout);

#endif	/* BASE64_H */

