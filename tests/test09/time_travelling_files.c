#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>

time_t get_file_mod_time(char *pathname);

int main(int argc, char *argv[]) {
    time_t now = time(NULL);
    for (int arg = 1; arg < argc; arg++) {
        if (get_file_mod_time(argv[arg]) > now) {
            printf("%s has a timestamp that is in the future\n", argv[arg]);
        }
    }

    return 0;
}

time_t get_file_mod_time(char *pathname) {
    struct stat s;
    stat(pathname, &s);
    return s.st_atime < s.st_mtime ? s.st_mtime : s.st_atime;
}