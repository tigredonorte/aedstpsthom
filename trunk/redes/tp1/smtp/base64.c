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
        printf("\n\n");
    #endif

    //fecha o arquivo
    fclose(fp);
    fclose(fout);

}

void encode_base64(unsigned char *str, int result, FILE* fout){

    unsigned char valor[4];

    //pega os ultimos 6 bits do primeiro bit
    valor[0] = str[0] >> 2;

    /*zera 6 bits mais significativos e shifta 4 para esquerda
    //zera 4 bits mais significativos e shifta 4 para direita*/
    valor[1] = ( ((str[0] & 3) << 4) | ((str[1] & 240) >> 4));

    /*/zera 4 bits mais  significativos e shifta 2 para esquerda
    //zera 6 bits menos significativos e shifta 6 para direita*/
    valor[2] = ((result > 1) ? ( ((str[1] & 15) << 2) | ((str[2] & 192) >> 6) ) : 64);

    //zera os 2 bits mais significativos
    valor[3] = ((result > 2) ? (str[2] & 63) : 64);      

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

    unsigned char valor[3];
    int i;

    //shifta os bits para obter o valor correto
    valor[ 0 ] = ( str[0] << 2 | str[1] >> 4 );
    valor[ 1 ] = ( str[1] << 4 | str[2] >> 2 );
    valor[ 2 ] = ( ((str[2] << 6) & 192)  | str[3] );

    //salva no arquivo
    for(i = 0; i < 3; i++){
        fprintf(fout, "%c", valor[i]);
        #ifdef DEBUG
            //printf("%c", valor[i]);
        #endif
    }
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

    unsigned char str[4];
    int i = 0;

    //enquanto nao encontrar o fim do arquivo
    do{
     
        //pega do arquivo 3 caracteres de 1 byte cada um
        for(i = 0; i < 4; i++){

            str[i] = 0;
            //enquanto o arquivo nao terminar e str[i] for nulo
            while( str[i] == 0 ) {

                //le um caracter do arquivo
                str[i] = fgetc( fp );

                //se nao estiver no limite dos caracteres usados entao str[i] é zero e será ignorado
                if(str[i] < 43 || str[i] > 122){
                    str[i] = 0;

                //decodifica os caracteres
                }else{
                    #ifdef DEBUG
                            printf("%d ", str[i] - 43);
                    #endif

                    //str[i] - 43 pois assim o array começa do zero, note que ele pode tentar de 0-79
                    //alguns indices deste intervalo sao nulos, por isso setamos zero
                    str[i] = decoded_caracters[ str[i] - 43 ];
                    
                    //se nao for uma marcador nulo subtrai 62
                    if((str[i] != '$')){
                        str[i] -= 62;
                    }

                    //se for um marcador nulo seta string como nula e pega a proxima
                    else {
                        str[i] = 0;
                    }
                }
                
                if(feof( fp )){
                    break;
                }
            }

            //se o arquivo acabar para o loop
            if(feof(fp)) {
                break;
            }

        }
        
        //se pegou algum caracter
        if(i){

            //codifica os caracteres
            decode_base64(str, fout);
            
        }

    }while(i);

    #ifdef DEBUG
            printf("\n\n");
    #endif

    fclose(fp);
    fclose(fout);
}