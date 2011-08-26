#include "base64.h"

#define NUMPORLINHA   NUMCARACTERES / 4

void encode(char *file_src, char *file_dst){

    FILE* fp = fopen(file_src,"rb");
    if (!fp)
    {
        printf("Arquivo (%s) inexistente! \nPressione uma tecla para sair\n\n", file_src);
        getchar();
        exit(EXIT_FAILURE);
    }

    FILE* fout = fopen(file_dst,"w");
    if (!fout)
    {
        printf("Arquivo (%s) inexistente! \nPressione uma tecla para sair\n\n", file_dst);
        getchar();
        exit(EXIT_FAILURE);
    }

    unsigned char *str = (unsigned char*)malloc(3);
    int result = 0,
        i      = 0;

    //enquanto nao encontrar o fim do arquivo
    do{

     
        //pega do arquivo 3 caracteres de 1 byte cada um
        for(i = 0; i < 3; i++){

            //pega um caracter
            str[i] = fgetc(fp);


            //se o arquivo acabar para o loop
            if(feof(fp)) {
                str[i] = 0;
                break;
            }
            
        }

        //se pegou algum caracter
        if(i){

            //codifica os caracteres
            encode_base64(str, i, fout);

            //imprime \r\n quando necessario
            result++;
            if(result == NUMPORLINHA){
                result = 0;
                fprintf(fout, "\r\n");
                #ifdef DEBUG
                    printf("\r\n");
                #endif
            }

        }

    }while(i);
    fprintf(fout, "\r\n");
    #ifdef DEBUG
        printf("\r\n");
    #endif

    //fecha o arquivo
    fclose(fp);
    fclose(fout);

}

void encode_base64(unsigned char *str, int result, FILE* fout){

    unsigned char valor[4];
    char temp1, 
         temp2;

    //pega os ultimos 6 bits do primeiro bit
    valor[0] = str[0] >> 2;

    temp1 = ((str[0] & 3) << 4);   //zera 6 bits mais significativos e shifta 4 para esquerda
    temp2 = ((str[1] & 240) >> 4); //zera 4 bits mais significativos e shifta 4 para direita
    valor[1] = (temp1 | temp2);    //soma os resultados anteriores

    temp1 = ((str[1] & 15) << 2);  //zera 4 bits mais  significativos e shifta 2 para esquerda
    temp2 = ((str[2] & 192) >> 6); //zera 6 bits menos significativos e shifta 6 para direita
    valor[2] = ((result > 1) ? (temp1 | temp2) : 64);    //soma os resultados anteriores

    valor[3] = ((result > 2) ? (str[2] & 63) : 64);      //zera os 2 bits mais significativos

    //salva os caracteres no arquivo
    int i;
    for(i = 0; i < 4; i++){
        fprintf(fout, "%c",encoded_caracters[valor[i]]);
        #ifdef DEBUG 
                printf("%c",encoded_caracters[valor[i]]);
        #endif
    }
}


void decode_base64(unsigned char *str, FILE* fout){
    unsigned char valor[3],
                  temp1,
                  temp2;

    int i;

    #ifdef DEBUG
        printf("string: %s",str);
        for(i = 0; i < 4; i++){
            #ifdef DEBUG
                    printf(" %d",str[i]);
                    //printf("%c", valor[i]);
            #endif
        }
    #endif

    //varre toda a string
    for(i = 0; i < 4; i++){

        if(str[i] > 64){

            //se for uma letra maiuscula
            if(str[i] < 91){
                str[i] -= 65;
            }

            else if(str[i] > 96){

                //se for uma letra minuscula
                if(str[i] < 123){
                    str[i] -= 70;
                }
            }
        }
        else{

            //se for o simbolo de igual
            if(str[i] == 61){
                str[i] = 0;
            }

            //se for um numero
            else if(str[i] > 47 && str[i] < 58){
                str[i] += 4;
            }

            else{

                //se for um mais
                if(str[i] == 43){
                    str[i] = 62;
                }

                //se for uma barra
                else if(str[i] == 47){
                    str[i] = 63;
                }
            }
        }
    }

    temp1 = str[0] << 2;
    temp2 = str[1] >> 4;
    valor[ 0 ] = ( temp1 | temp2 );

    temp1 = str[1] << 4;
    temp2 = str[2] >> 2;
    valor[ 1 ] = ( temp1 | temp2 );

    temp1 = ((str[2] << 6) & 192);
    temp2 = str[3];
    valor[ 2 ] = ( temp1 | temp2 );

    for(i = 0; i < 3; i++){
        fprintf(fout, "%c", valor[i]);
        #ifdef DEBUG
                //printf("%d ",valor[i]);
                //printf("%c", valor[i]);
        #endif
    }
    #ifdef DEBUG
        for(i = 0; i < 4; i++){
            #ifdef DEBUG
                    printf(" (%d)",str[i]);
                    //printf("%c", valor[i]);
            #endif
        }
        printf("\n\n");
    #endif
}

void decode(char *file_src, char *file_dst){

    FILE* fp = fopen(file_src,"rb");
    if (!fp)
    {
        printf("Arquivo (%s) inexistente! \nPressione uma tecla para sair\n\n", file_src);
        getchar();
        exit(EXIT_FAILURE);
    }

    FILE* fout = fopen(file_dst,"wb");
    if (!fout)
    {
        printf("Arquivo (%s) inexistente! \nPressione uma tecla para sair\n\n", file_dst);
        getchar();
        exit(EXIT_FAILURE);
    }

    unsigned char *str = (unsigned char*)malloc(4);
    int i = 0;

    //enquanto nao encontrar o fim do arquivo
    do{
     
        //pega do arquivo 3 caracteres de 1 byte cada um
        for(i = 0; i < 4; i++){

            //pega um caracter
            str[i] = fgetc(fp);

            //enquanto for um separador de linha e nao chegar ao fim do arquivo
            while( str[i] == "\n" &&
                  (strcmp(str[i], "\n") == 0) &&
                   !feof(fp) )
            {

                //pega um caracter
                str[i] = fgetc(fp);

                //se o arquivo acabar para o loop
                if(feof(fp)) {
                    break;
                }
            }

            //se o arquivo acabar para o loop
            if(feof(fp)) {
                str[i] = 0;
                break;
            }

        }
        
        //se pegou algum caracter
        if(i){
            
            //codifica os caracteres
            decode_base64(str, fout);
            
        }

    }while(i);
    fprintf(fout, "\r\n");
    #ifdef DEBUG
        printf("\r\n");
    #endif


    fclose(fp);
    fclose(fout);
}
