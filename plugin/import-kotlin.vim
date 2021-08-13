let s:bin_dir = expand('<sfile>:h:h').'/bin/'

command! LearnImport execute "! SAMPLE_PATH=" . expand(g:learn_path) . " " . s:bin_dir . 'learn_import.sh'  
command! KotlinImport lua require'importkt'.import()
