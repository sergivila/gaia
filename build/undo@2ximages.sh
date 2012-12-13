# Shared config
SOURCE=shared
MATCHES=matched.txt
UNMATCHES=unmatched.txt

# Clean temporal folders and restore intial state
rm -rf $SOURCE/
cp -rf .tmp_$SOURCE/ $SOURCE/
rm -rf .tmp_$SOURCE/

# Clean logs
rm -rf $MATCHES
rm -rf $UNMATCHES
