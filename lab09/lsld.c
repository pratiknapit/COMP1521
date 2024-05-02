#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <stdio.h>
#include <stdlib.h>
#include <pwd.h>
#include <grp.h>
#include <time.h>

void stat_file(char *pathname);
void permissions_to_string(mode_t mode, char *str);

int main(int argc, char *argv[]) {
    if (argc == 1) {
        stat_file(".");
    }
    for (int arg = 1; arg < argc; arg++) {
        stat_file(argv[arg]);
    }
    return 0;
}

void stat_file(char *pathname) {
    //printf("stat(\"%s\", &s)\n", pathname);

    struct stat s;
    if (stat(pathname, &s) != 0) {
        perror(pathname);
        exit(1);
    }

    // Get permissions
    char permissions[11];
    permissions_to_string(s.st_mode, permissions);
    printf("%s ", permissions);

    // links
    int numlinks;
    numlinks = s.st_nlink;
    printf("%d ", numlinks);

    // uid
    struct passwd *pwuid = getpwuid(s.st_uid);
    char *pwname = pwuid->pw_name;
    printf("%s ", pwname);

    // gid
    struct group *groupid = getgrgid(s.st_gid);
    char *groupname = groupid->gr_name;
    printf("%s ", groupname);

    // file size
    printf("%6ld ", s.st_size);

    // time modified
    time_t t = s.st_mtime;
    struct tm *ptm;
    ptm = localtime(&t);
    char buf[200];
    strftime(buf, sizeof(buf), "%b %d %H:%M", ptm);
    printf("%s ", buf);

    // name of file
    printf("%s \n", pathname);
}

void permissions_to_string(mode_t mode, char *str) {
    str[0] = (mode & S_IFDIR) ? 'd' : '-';
    str[1] = (mode & S_IRUSR) ? 'r' : '-';
    str[2] = (mode & S_IWUSR) ? 'w' : '-';
    str[3] = (mode & S_IXUSR) ? 'x' : '-';
    str[4] = (mode & S_IRGRP) ? 'r' : '-';
    str[5] = (mode & S_IWGRP) ? 'w' : '-';
    str[6] = (mode & S_IXGRP) ? 'x' : '-';
    str[7] = (mode & S_IROTH) ? 'r' : '-';
    str[8] = (mode & S_IWOTH) ? 'w' : '-';
    str[9] = (mode & S_IXOTH) ? 'x' : '-';
    str[10] = '\0'; // Null-terminate the string
}