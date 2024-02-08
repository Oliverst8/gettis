case $1 in
	"init")
		init $2
		exit
		;;
	"i")
		init $2
		exit
		;;
	"t")
		test $2
		exit
		;;
	"test")
		test $2
		exit
		;;
	*)
		echo "Invalid command"
		echo "Usage: gettis [init/i] [project_name.filetype]"
		echo "Usage: gettis [test/t] [project_name.filetype/empty]"
		exit
		;;
esac
#End of file