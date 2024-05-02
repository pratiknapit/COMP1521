#include <string.h>
#include <sys/types.h>
#include <dirent.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

/**
 * Recursively find all files and directories
 * in `directory` that match the given criteria.
 *
 * Parameters:
 * `directory`: The starting directory to begin
 *              the search. This parameter will
 *              always be provided (i.e. never NULL).
 *
 * `name`:      If provided, any printed files or
 *              directories must have this name.
 *              Note that you should still search through
 *              directories that do not match `name`.
 *              If not provided (i.e. name == NULL),
 *              there are no restrictions on the name.
 *
 * `min_depth`: If provided, any printed files or
 *              directories must occur at least `min_depth`
 *              directories deep.
 *              Any files or directories existing in the
 *              provided `directory` are considered to be
 *              of depth 0.
 *              If not provided (i.e. min_depth == -1),
 *              there are no restrictions on minimum depth.
 *
 * `max_depth`: If provided, any printed files or
 *              directories must occur at most `max_depth`
 *              directories deep.
 *              Any files or directories existing in the
 *              provided `directory` are considered to be
 *              of depth 0.
 *              If not provided (i.e. max_depth == -1),
 *              there are no restrictions on maximum depth.
 */
void recursive_dir_search(char *directory, char *name, int min_depth, int max_depth, int current_depth);

void _22t2final_q7(char *directory, char *name, int min_depth, int max_depth) {
	// recursively search a directory to find file/dir that mathces the given criteria

	// same name, current search is at least min_depth, current search is at most max_depth
	recursive_dir_search(directory, name, min_depth, max_depth, 0);
}

void recursive_dir_search(char *directory, char *name, int min_depth, int max_depth, int current_depth) {
	DIR *dir = opendir(directory);
	struct dirent *entry;
	while ((entry = readdir(dir)) != NULL) {
		switch(entry->d_type) {
			case DT_REG:
			case DT_DIR:
				if (min_depth != -1 && current_depth < min_depth) break;
				if (max_depth != -1 && current_depth > max_depth) break;
				if (name != NULL && strcmp(entry->d_name, name) != 0) break;
				printf("%s/%s\n", directory, entry->d_name);
				break;
		}

		if (entry->d_type == DT_DIR) {
			if (strcmp(".", entry->d_name) != 0 && strcmp("..", entry->d_name) != 0) {
				size_t size = strlen(directory) + 1 + strlen(entry->d_name) + 1;
				char *new_string = malloc(size);
				snprintf(new_string, size, "%s/%s", directory, entry->d_name);

				recursive_dir_search(
					new_string, 
					name,
					min_depth,
					max_depth,
					current_depth + 1
				);

				free(new_string);
			}
		}
	}

	closedir(dir);
}