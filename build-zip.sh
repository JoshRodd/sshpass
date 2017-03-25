#!/bin/bash

# Builds a .zip file ready to archive into GitHub suitable for
# installing with HomeBrew. The .zip file will have identical contents
# to the version of sshpass from the upstream at SourceForge.

# Make a build and an archive directory
mkdir -p build/
mkdir -p archive/

# The name of this script.
CUR_SCRIPT=build-zip.sh

# Package name
CUR_PKG=sshpass

# The URL base on GitHub for the output files.
CUR_GIT_USER=JoshRodd
CUR_URL="https://github.com/$CUR_GIT_USER/$CUR_PKG"

# Current version
CUR_VERSION=1.06

# Current version tag
CUR_VERSION_TAG=-brew

# Current date of build
CUR_DATE=2017-03-25

# Current serial number of build; it's a good idea to increment this
CUR_SNO=2

# Zip file name
OUTPUT_FILE="archive/$CUR_PKG-$CUR_VERSION$CUR_VERSION_TAG-$CUR_DATE-$CUR_SNO.zip"
OUTPUT_URL="$CUR_URL/$OUTPUT_FILE"

# Name of the HomeBrew file we will build and adjust the checksum for.
BREWFILE="archive/$CUR_PKG.rb"

# Find out our current working directory.
CUR_DIR="$(basename "$(pwd)")"

# Go up a level so the zip file appears properly when unzipped.
(
cd ..
OUTPUT_FILE="$CUR_DIR/$OUTPUT_FILE"
rm -f "$OUTPUT_FILE"
zip -qr "$OUTPUT_FILE" "$CUR_DIR" $(find "$CUR_DIR" -type f -maxdepth 1 \
\! -name .gitignore \
\! -name "$CUR_PKG-*.rb" \
\! -name "$CUR_SCRIPT" \
\! -name "README.md" \
-exec printf -- '-i ' ';' -print)
)

# Build the HomeBrew file.
cat >$BREWFILE <<"'''"
require 'formula'

class Sshpass < Formula
'''
printf "  url '%s'\n" "$OUTPUT_URL" >>$BREWFILE
printf "  homepage '%s'\n" "$CUR_URL" >>$BREWFILE
printf "  sha256 '%s'\n" "$(shasum -p -a 256 "$OUTPUT_FILE" | awk '{print $1}')" >>$BREWFILE
cat >>$BREWFILE <<"'''"

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"
  end

  def test
    system "sshpass"
  end
end
'''

# Inform the user the file has been created
echo "The file \`$OUTPUT_FILE' has been made and is ready to push to git:"
echo
echo "git add $OUTPUT_FILE $BREWFILE $CUR_SCRIPT"
git add "$OUTPUT_FILE" "$BREWFILE" "$CUR_SCRIPT"
echo "git commit $OUTPUT_FILE $BREWFILE $CUR_SCRIPT -m 'Updated archive .zip for $CUR_VERSION$CUR_VERSION_TAG-$CUR_DATE-$CUR_SNO'"
git commit "$OUTPUT_FILE" "$BREWFILE" "$CUR_SCRIPT" -m "Updated archive .zip for $CUR_VERSION$CUR_VERSION_TAG-$CUR_DATE-$CUR_SNO"
echo
echo "Run a \`git push' now if you like the above changes."
