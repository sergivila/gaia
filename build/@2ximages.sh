# Shared config
APPS=apps
SHARED=shared
SOURCE="$APPS $SHARED"
MATCHES=matched.txt
UNMATCHES=unmatched.txt

# Create snapshoot of $APPS
rm -rf .tmp_$APPS/
cp -rf $APPS/ .tmp_$APPS/
echo "$APPS Snapshoot created"

# Create snapshoot of $SHARED
rm -rf .tmp_$SHARED/
cp -rf $SHARED/ .tmp_$SHARED/
echo "$SHARED Snapshoot created"

# Clean log files
rm -rf $MATCHES
rm -rf $UNMATCHES

# Get all the assets
FILES=`find $SOURCE -name "*.png" -o -name "*.jpg" -o -name "*.gif"`
for f in $FILES
do
  # Remove extra @2x in the name
    ASSET=${f//@2x./.};

  # Add @2x at the end of the name
    ASSET=${ASSET//./@2x.};

 # Check if file exists or not
    if [ -f $ASSET ];
      then
        echo "$ASSET" >> $MATCHES
      else
        echo "$ASSET" >> $UNMATCHES
    fi
done

# Rename all the unmatched files
cat $UNMATCHES | while read line
do
  # from .extensions to @2x.extension
  URL=${line//@2x/};
  URL2X=${URL//./@2x.}
  cp $URL $URL2X
done

# Replace images declaratons in CSS, HTML and JS files
find $SOURCE -name "*.css" -o -name "*.html" -o -name "*.js" | xargs sed -i '' 's/\.[jpg][png][gif]/@2x&/g' ;
