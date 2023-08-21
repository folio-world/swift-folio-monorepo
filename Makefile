generate:
	tuist fetch
	tuist generate

clean:
	tuist clean
	rm -rf **/**/**/**/**/*.xcodeproj
	rm -rf **/**/**/**/**/*.xcworkspace
	rm -rf **/**/**/**/*.xcodeproj
	rm -rf **/**/**/**/*.xcworkspace
	rm -rf **/**/**/*.xcodeproj
	rm -rf **/**/**/*.xcworkspace
	rm -rf **/**/*.xcodeproj
	rm -rf **/**/*.xcworkspace
	rm -rf **/*.xcodeproj
	rm -rf **/*.xcworkspace
	rm -rf *.xcworkspace

module:
	swift Scripts/GenerateModule.swift
