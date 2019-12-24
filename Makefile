TARGET=anapistula

all: $(TARGET)

$(TARGET): $(shell [ -d Sources ] && find Sources/ -name "*.swift") Package.resolved
	@export KITURA_NIO=1
	swift build
	ln -snf .build/x86_64-apple-macosx/debug/$(TARGET) .

Package.resolved: Package.swift
	@export KITURA_NIO=1
	swift package update

$(TARGET).xcodeproj: Package.swift
	swift package generate-xcodeproj

init:
	swift package init --type executable
	swift package generate-xcodeproj

xcode:
	swift package generate-xcodeproj

clean:
	$(RM) -r .build
