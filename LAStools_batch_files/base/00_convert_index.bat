:: Convert from 1.2 to 1.4
las2las -i %f_dir%\20_las\*.laz ^
	-remove_vlrs_from_to 1 3 ^
	-remove_padding ^
	-set_version 1.4 ^
	-odir %f_dir%\20_las\00_converted ^
	-olaz ^
	-cores %cores%

:: Index new .laz files
lasindex -i %f_dir%\20_las\00_converted\*.laz ^
	-dont_reindex ^
	-cores %cores%
