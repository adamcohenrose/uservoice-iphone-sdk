#!/bin/sh

DIST=dist/UserVoiceSDK-1.0.1

echo "==== Building for iOS devices ===="
echo ""
xcodebuild

echo "==== Building for iOS simulator ===="
echo ""
xcodebuild -sdk iphonesimulator

mkdir -p $DIST

echo "Creating fat binary"
lipo -create build/Release-iphoneos/libUserVoice.a build/Release-iphonesimulator/libUserVoice.a -output $DIST/libUserVoice.a

echo "Copying other files"
cp -R Include $DIST/UVHeaders
cp -R Resources $DIST/UVResources

echo "Creating archive"
tar -czf $DIST.tar.gz $DIST
rm -Rf $DIST

echo "Done! UserVoice iOS SDK built: $DIST.tar.gz"
