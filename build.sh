#!/bin/bash
pod install
xcodebuild -workspace StudentTourism.xcworkspace \
-scheme StudentTourism \
-destination generic/platform=iOS build
