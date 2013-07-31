platform :ios, '5.0'

xcodeproj 'ETFrameworkDemo.xcodeproj'

pod 'JSONKit', '~> 1.5pre'
pod 'AFNetworking', '~> 1.3.1'

# The post install hook add certain compiler flags for JSONKit files so that
# they won't generate warnings. This had been done in the podspec before, but
# was removed later for some reason.
post_install do |installer|
    # Adds the specified compiler flags to the given file in the project.
    #
    # @param [Xcodeproj::Project] project
    #                             The Xcode project instance.
    #
    # @param [String] filename
    #                 The name of the file to work with.
    #
    # @param [String] new_compiler_flags
    #                 The compiler flags to add.
    #
    # @example Disable some warning switches for JSONKit:
    #   add_compiler_flags(installer.project,
    #       "JSONKit.m",
    #       "-Wno-deprecated-objc-isa-usage -Wno-format")
    #
    def add_compiler_flags(project, filename, new_compiler_flags)
        # find all PBXFileReference objects of the given file
        files = project.files().select { |file|
            file.display_name() == filename
        }

        # get the PBXBuildFile references of the found files
        # PBXBuildFile actually contains flags for building the file
        build_files = files.map { |file|
            file.build_files()
        }.compact.flatten

        # compiler flags key in settings
        compiler_flags_key = "COMPILER_FLAGS"

        if build_files.length > 0
            build_files.each { |build_file|
                settings = build_file.settings
                if settings.nil?
                	# If we don't have settings for the file we create a new hash
                	settings = Hash[compiler_flags_key, new_compiler_flags]
                else
	                compiler_flags = settings[compiler_flags_key]
	                compiler_flags = (compiler_flags.nil?) ?
	                    new_compiler_flags :
	                    (compiler_flags + " " + new_compiler_flags)
	                settings[compiler_flags_key] = compiler_flags
	            end

	            build_file.settings = settings
            }
        else
            puts "No build file refs found for #{filename}!"
        end
    end

    # compiler flags that turn off the JSONKit's warnings
    JSONKIT_FLAGS = "-Wno-deprecated-objc-isa-usage -Wno-format"
    add_compiler_flags(installer.project, "JSONKit.m", JSONKIT_FLAGS)
end