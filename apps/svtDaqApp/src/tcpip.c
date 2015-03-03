#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h> 

static int counter = -1;
static int sockfd;
static int portno;
char buffer[256];

void error(const char *msg)
{
    perror(msg);
    exit(0);
}

int init_socket() {
	counter = 0;
	//int n;
	struct sockaddr_in serv_addr;
	struct hostent *server;
	//char buffer[256];
	portno = 8090;
	sockfd = socket(AF_INET, SOCK_STREAM, 0);
    	if (sockfd < 0)
		return -1;
        	//error("ERROR opening socket");
    	server = gethostbyname("134.79.229.141");
    	if (server == NULL) {
        	fprintf(stderr,"ERROR, no such host\n");
		return -2;
        	//exit(0);
    	}
    	bzero((char *) &serv_addr, sizeof(serv_addr));
    	serv_addr.sin_family = AF_INET;
	bcopy((char *)server->h_addr,
         (char *)&serv_addr.sin_addr.s_addr,
         server->h_length);
    	serv_addr.sin_port = htons(portno);
    	if (connect(sockfd,(struct sockaddr *) &serv_addr,sizeof(serv_addr)) < 0)
        	return -3; //error("ERROR connecting");

	


	return 0;
}

int tcpip_poll() {
	int n;
	counter++;
        bzero(buffer,256);
        n = read(sockfd,buffer,255);
        if (n < 0)
		return -1;
   	       //error("ERROR reading from socket");
        printf("%s\n",buffer);
        
	return counter;
}





