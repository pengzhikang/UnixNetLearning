#include <stdio.h>
int main(){
    union{
        int n;
        char ch;
    } data;

    data.n = 0x01234567;  //也可以直接写作 data.n = 1;
    if(data.ch == 0x67){
        printf("Little-endian\n");
    }else{
        printf("Big-endian\n");
    }
    return 0;
}