#ifndef COMMONSOCKET_H
#define COMMONSOCKET_H



int close_socket(int socketfd);
void socket_error(const char *msg);
int open_socket(char* hostname, int portno);





#endif
