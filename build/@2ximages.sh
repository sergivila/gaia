# Shared config
APPS=apps
SHARED=shared
SOURCE="$APPS $SHARED"
FOUNDFILES=build/foundfiles.txt
MATCHES=build/matched.txt
UNMATCHES=build/unmatched.txt

# Create snapshoot of $APPS
rm -rf .tmp_$APPS/
cp -rf $APPS/ .tmp_$APPS/
echo "$APPS Snapshoot created"

# Create snapshoot of $SHARED
rm -rf .tmp_$SHARED/
cp -rf $SHARED/ .tmp_$SHARED/
echo "$SHARED Snapshoot created"

# Clean log files
echo "Cleaning old logs"
rm -rf $FOUNDFILES
rm -rf $MATCHES
rm -rf $UNMATCHES

# Get all the assets paths to test
echo "Searching assets..."
FILES=`find $SOURCE -name "*.png" -o -name "*.jpg" -o -name "*.gif"`
for f in $FILES
do
  # Remove extra @2x in the name
    ASSET=${f//@2x./.};

  # Add @2x at the end of the name
    echo "$ASSET" | sed 's/\.[jpg][png][gif]/@2x&/g' >> $FOUNDFILES
done

# Check if files exists
echo "Checking @2x assets..."
cat $FOUNDFILES | while read line
do
    if [ -f $line ];
      then
        echo "$line" >> $MATCHES
      else
        echo "$line" >> $UNMATCHES
    fi
done

# Rename all the unmatched files
echo "Renaming assets w/o @2x versions..."
cat $UNMATCHES | while read line
do
  URLFROM=${line//@2x/}
  URLTO=$line
  mv $URLFROM $URLTO
done

# Replace images declaratons in CSS, HTML, WEBAPP and JS files
echo "Replacing assets declarations in .css .js .html .webapp files"
find $SOURCE -name "*.css" -o -name "*.html" -o -name "*.js" -o -name "*.webapp" | xargs sed -i '' 's/\.[jpg][png][gif]/@2x&/g' ;
