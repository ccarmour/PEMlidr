::Normalize height
lasheight -i %f_dir%\20_las\01_retiled\*.laz ^
	-replace_z ^
	-remain_buffered ^
	-odir %f_dir%\20_las\02_norm ^
	-olaz ^
	-cores %cores%

:: Index new .laz files
lasindex -i %f_dir%\20_las\02_norm\*.laz ^
	-dont_reindex ^
	-cores %cores%
