namespace :test do
  desc "Run the ETFramework Tests"
  task :ios => :prepare do
    $ios_success = system("xctool -workspace ETFrameworkDemo.xcworkspace -scheme 'ETFrameworkTests' -sdk iphonesimulator -configuration Release test -test-sdk iphonesimulator")
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
