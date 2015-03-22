#!/usr/local/bin/zsh
jsonfile=$1
cat $jsonfile | jq -c '.[]' > /dev/null 2>&1
if [ $? -eq 0 ]; then
echo "Good Json File"
else
echo "Bad Json File"
fi
