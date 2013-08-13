namespace :test do
  desc "Run the ETFramework Tests"
  task :ios do
    $ios_success = system("xctool -workspace ETFrameworkDemo.xcworkspace -scheme 'ETFrameworkTests' -sdk iphonesimulator -configuration Debug test -test-sdk iphonesimulator GCC_INSTRUMENT_PROGRAM_FLOW_ARCS=YES GCC_GENERATE_TEST_COVERAGE_FILES=YES ONLY_ACTIVE_ARCH=NO")
  end
end

desc "Run the EFFramework Tests for iOS"
task :test => ['test:ios'] do
  puts "\033[0;31m! iOS unit tests failed" unless $ios_success
  if $ios_success
    puts "\033[0;32m** All tests executed successfully"
  else
    exit(-1)
  end
end

task :default => 'test'
