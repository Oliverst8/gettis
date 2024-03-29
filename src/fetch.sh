# Check if test files exist, and download them if not
function fetch() {
if [ ! "$(ls *.in 2>/dev/null)" ] || [ ! "$(ls *.ans 2>/dev/null)" ]; then
	echo "Downloading test files..."
	curl -O "https://open.kattis.com/problems/$1/file/statement/samples.zip"
	echo "Test files downloaded to 'samples.zip'"
	unzip -q samples.zip
	rm samples.zip
fi
}
#End of fetch function