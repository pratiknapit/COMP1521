#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>

struct node {
    ino_t inode;
    struct node *next;
};

struct node *createNode(ino_t inode, struct node *next)  {
    struct node *new_node;
    new_node = malloc(sizeof(struct node));
    new_node->inode = inode;
    new_node->next = next;
    return new_node;
}

int checkNode(ino_t inode, struct node *n) {
    while (n != NULL) {
        if (n->inode == inode) {
            return 1;
        }
        n = n->next;
    }
    return 0;
}

void freeNodes(struct node *n) {
    while (n != NULL) {
        struct node *next = n->next;
        free(n);
        n = next;
    }
}

int main(int argc, char **argv)
{
    struct stat s;
    struct node *head = NULL;
    for (int i = 1; i < argc; i++) {
        stat(argv[i], &s);

        if (i == 1) {
            head = createNode(s.st_ino, NULL);
            printf("%s\n", argv[i]);
        } else {
            if (!checkNode(s.st_ino, head)) {
                head = createNode(s.st_ino, head);
                printf("%s\n", argv[i]);
            }
        }
    }

    freeNodes(head);
    
    return EXIT_SUCCESS;
}
