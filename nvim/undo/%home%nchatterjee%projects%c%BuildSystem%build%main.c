Vim�UnDo� 5��Y���w&�.�Ʌ���¯�a���B;���K   e                                   _l�    _�                              ����                                                                                                                                                                                                                                                                                                                                                             _l�    �   c   e   e      
	return 0;�   a   c   e      	}�   `   b   e      		}�   _   a   e      '			task(orig, argv[i], table, src_dir);�   ^   `   e      "		for (int i = 1; i < argc; i++) {�   \   ^   e      		}�   [   ]   e      +			log_info("No Source Directory Specify");�   Z   \   e      		if (!src_dir) {�   X   Z   e      .		const char *src_dir = get(table, "src_dir");�   W   Y   e      		getcwd(orig, sizeof(orig));�   V   X   e      		char orig[100];�   U   W   e      		} else {�   T   V   e      		log_err("No Task Given");�   S   U   e      	if (argc == 1) {�   Q   S   e      	}�   P   R   e      
		exit(2);�   O   Q   e      C		log_err("An Unkown Error Occured While Parsing build.toml File");�   N   P   e      	if (!table) {�   L   N   e      $	log_info("Closed build.toml File");�   K   M   e      	fclose(file);�   J   L   e      %	log_info("Closing build.toml File");�   H   J   e      $	log_info("Parsed build.toml File");�   G   I   e      G	toml_table_t *table = toml_parse_file(file, err_buf, sizeof(err_buf));�   F   H   e      	char err_buf[100];�   E   G   e      %	log_info("Parsing build.toml File");�   C   E   e      #	log_info("Found build.toml File");�   A   C   e      	}�   @   B   e      
		exit(1);�   ?   A   e      '		log_err("build.toml File Not Found");�   >   @   e      	if (!file) {�   <   >   e      )	log_info("Looking For build.toml File");�   ;   =   e      '	FILE *file = fopen("build.toml", "r");�   7   9   e      '	log_suc("task finished successfully");�   6   8   e      	}�   5   7   e      		}�   4   6   e      			exit(5);�   3   5   e      			log_err("Task Failed");�   2   4   e      		if (task_code) {�   0   2   e      		int task_code = system(str);�   /   1   e      		log_info("Task Output");�   .   0   e      4		sprintf(str, "cd %s && %s", src_dir_str, command);�   -   /   e      		} else {�   ,   .   e      		}�   +   -   e      			exit(5);�   *   ,   e      			log_err("Task Failed");�   )   +   e      		if (task_code) {�   '   )   e      		int task_code = system(str);�   &   (   e      		log_info("Task Output");�   %   '   e      0		sprintf(str, "cd %s && %s", src_dir, command);�   $   &   e      	if (!src_dir_str) {�   #   %   e      7	const char *src_dir_str = get(task_config, "src_dir");�   "   $   e      	memset(str, 0, sizeof(str));�   !   #   e      	}�       "   e      
		exit(4);�      !   e      		log_err(str);�          e      ;		sprintf(str, "Command Not Found For Task %s", task_name);�         e      		memset(str, 0, sizeof(str));�         e      	if (!command) {�         e      3	const char *command = get(task_config, "command");�         e      	}�         e      
		exit(3);�         e      		free(task_config);�         e      		log_err(str);�         e      /		sprintf(str, "Task %s Not Found", task_name);�         e      		memset(str, 0, sizeof(str));�         e      	if (!task_config) {�         e      =	toml_table_t *task_config = toml_table_in(table, task_name);�         e      	log_info(str);�         e      .	sprintf(str, "Executing Task %s", task_name);�         e      	char str[50];5��