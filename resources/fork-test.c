#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main() {
    int status = 1;
    char * str = "Hello, 程序员石头";
    printf("%s, pid=%d\n", str, getpid());
    fflush(stdout);

    int pid = fork();

    if (pid == 0) {
        printf("\nchild is working: current pid: %d\n", getpid());
    } else {
        sleep(1);
        printf("\nparent is working: current pid: %d\n", getpid());
    }

    wait(&status);
    return 0;
}
