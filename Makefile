test:
	xctool \
		-workspace 'ETFrameworkDemo/ETFrameworkDemo.xcworkspace' -scheme 'ETFrameworkDemo' clean build test \
		-sdk iphonesimulator \
		ONLY_ACTIVE_ARCH=NO \
		TEST_AFTER_BUILD=YES \
		GCC_INSTRUMENT_PROGRAM_FLOW_ARCS=YES \
		GCC_GENERATE_TEST_COVERAGE_FILES=YES

send-coverage:
	./coveralls.sh -r ./ -e ETFrameworkDemo -e ETFrameworkTests --verbose