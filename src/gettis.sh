case $1 in
	"init")
		init $2
		exit
		;;
	"test")
		test $2
		exit
		;;
esac
#End of file