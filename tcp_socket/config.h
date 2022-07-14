/*
 * config.h 包含该tcp/ip套接字编程所需要的基本头文件，与server.c client.c位于同一目录下
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <unistd.h>
#include <errno.h>
#include <netinet/in.h>
#include <netdb.h>
#include <arpa/inet.h>

const int MAX_LINE = 2048;
const int PORT = 6000;
const int BACKLOG = 10;
const int LISTENQ = 6666;
const int MAX_CONNECT = 20;

//打印地址函数
void printaddr(struct sockaddr_in A){
    char addr[100];
    // printf("a=%u\n", A.sin_addr.s_addr);
    // A.sin_addr.s_addr = ntohl((uint32_t)A.sin_addr.s_addr);
    // printf("a=%u\n", A.sin_addr.s_addr);
    inet_ntop(AF_INET, &A, addr, sizeof(A));
    printf("port=%d,addr=%s\n", A.sin_port, addr);
    return;
};


