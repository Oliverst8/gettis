case $1 in
	"submit")
		submit $2
		exit
		;;
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