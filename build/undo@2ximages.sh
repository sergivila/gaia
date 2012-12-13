# Shared config
APPS=apps
SHARED=shared
SOURCE="$APPS $SHARED"
MATCHES=matched.txt
UNMATCHES=unmatched.txt

# Clean temporal $APPS folders and restore intial state
rm -rf $APPS/
cp -rf .tmp_$APPS/ $APPS/
rm -rf .tmp_$APPS/

# Clean temporal $SHARED folders and restore intial state
rm -rf $SHARED/
cp -rf .tmp_$SHARED/ $SHARED/
rm -rf .tmp_$SHARED/

# Clean logs
rm -rf $MATCHES
rm -rf $UNMATCHES
