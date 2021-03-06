#!/bin/bash

# Builds a .zip file ready to archive into GitHub suitable for
# installing with HomeBrew. The .zip file will have identical contents
# to the version of sshpass from the upstream at SourceForge.

if [ "$1" != "" ]; then
	if [ "$1" != "--use_current_zip" ]; then
		echo Usage: "$0 --use_current_zip"
		echo
		echo The --use_current_zip option will not regenerate the zip file, which
		echo is useful if you know nothing has changed in order to avoid touching
		echo the checksum.
		echo
		exit 1
	fi
fi

# Make an archive directory
mkdir -p archive/

# The name of this script.
CUR_SCRIPT=build-zip.sh

# Package name
CUR_PKG=sshpass

# The URL base on GitHub for the output files.
CUR_GIT_USER=JoshRodd
CUR_GITHUB_URL="https://github.com/$CUR_GIT_USER/$CUR_PKG"
CUR_URL="https://raw.githubusercontent.com/$CUR_GIT_USER/$CUR_PKG"

# Current version
CUR_VERSION=1.06

# Current version tag
CUR_VERSION_TAG=-brew

# Current date of build
CUR_DATE=2017-03-25

# Current serial number of build; it's a good idea to increment this if the zip file is changing
CUR_SNO=5

# Zip file name
OUTPUT_FILE="archive/$CUR_PKG-$CUR_VERSION$CUR_VERSION_TAG-$CUR_DATE-$CUR_SNO.zip"
OUTPUT_URL="$CUR_URL/master/$OUTPUT_FILE"

# Name of the HomeBrew file we will build and adjust the checksum for.
BREWFILE="archive/$CUR_PKG.rb"

# Find out our current working directory.
CUR_DIR="$(basename "$(pwd)")"

if [ "$1" != "--use_current_zip" ]; then

# Go up a level so the zip file appears properly when unzipped.
(
cd ..
OUTPUT_FILE="$CUR_DIR/$OUTPUT_FILE"
rm -f "$OUTPUT_FILE"
zip -9 -qr "$OUTPUT_FILE" "$CUR_DIR" $(find "$CUR_DIR" -type f -maxdepth 1 \
\! -name .gitignore \
\! -name "$CUR_PKG-*.rb" \
\! -name "$CUR_SCRIPT" \
\! -name "README.md" \
-exec printf -- '-i ' ';' -print)
)

echo "The file \`$OUTPUT_FILE' has been made and is ready to push to git:"
echo

else

	echo Note: using the existing .zip file.

	if [ ! -f "$OUTPUT_FILE" ]; then
		echo Cannot find an existing .zip file.
		exit 1k
	fi

fi

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
if [ "$1" != "--use_current_zip" ]; then
echo "git add $OUTPUT_FILE $BREWFILE $CUR_SCRIPT"
git add "$OUTPUT_FILE" "$BREWFILE" "$CUR_SCRIPT"
echo "git commit $OUTPUT_FILE $BREWFILE $CUR_SCRIPT -m 'Updated archive .zip for $CUR_VERSION$CUR_VERSION_TAG-$CUR_DATE-$CUR_SNO'"
git commit "$OUTPUT_FILE" "$BREWFILE" "$CUR_SCRIPT" -m "Updated archive .zip for $CUR_VERSION$CUR_VERSION_TAG-$CUR_DATE-$CUR_SNO"
else
echo "git add $BREWFILE"
git add "$BREWFILE"
echo "git commit $BREWFILE -m 'Updated HomeBrew .rb file for $CUR_VERSION$CUR_VERSION_TAG-$CUR_DATE-$CUR_SNO'"
git commit "$BREWFILE" -m "Updated archive .zip for $CUR_VERSION$CUR_VERSION_TAG-$CUR_DATE-$CUR_SNO"
fi
echo
echo "Run a \`git push' now if you like the above changes."
