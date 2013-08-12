WORKSPACE = ETFrameworkDemo/ETFrameworkDemo.xcworkspace
SCHEME = ETFrameworkDemo

test:
	xcodebuild \
		-workspace $(WORKSPACE) \
		-scheme $(SCHEME) \
		-sdk iphonesimulator \
		-configuration Debug \
		clean build \
		ONLY_ACTIVE_ARCH=NO \
		TEST_AFTER_BUILD=YES \
		TEST_HOST=""
		
test-with-coverage:
	xcodebuild \
		-workspace $(WORKSPACE) \
		-scheme $(SCHEME) \
		-sdk iphonesimulator \
		-configuration Debug \
		clean build \
		ONLY_ACTIVE_ARCH=NO \
		TEST_AFTER_BUILD=YES \
		TEST_HOST="" \
		GCC_INSTRUMENT_PROGRAM_FLOW_ARCS=YES \
		GCC_GENERATE_TEST_COVERAGE_FILES=YES
		
send-coverage:
	coveralls \
		--verbose