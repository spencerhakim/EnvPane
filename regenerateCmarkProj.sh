#!/bin/sh

# Make sure submodules are checked out
git submodule init
git submodule update

# Generate cmark Xcode project file
mkdir cmark_xcode
cd cmark_xcode
cmake -G Xcode ../cmark
