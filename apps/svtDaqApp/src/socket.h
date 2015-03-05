#ifndef SOCKET_H
#define SOCKET_H


void socket_error(const char *msg);
int open_socket(char* hostname, int portno);
int close_socket(int socketfd);



#endif

