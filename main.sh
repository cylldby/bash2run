#!/usr/bin/env bash

read -n$HTTP_CONTENT_LENGTH PAYLOAD;
echo $PAYLOAD
# The contents of the payload are extracted by stripping the headers of the request
# Then every entry of the json is exported :
# export KEY=VALUE

for s in $(echo $PAYLOAD | 
        jq -r "to_entries|map(\"\(.key)=\(.value|tostring)\")|.[]" ); 
do     
    export $s; 
    echo $s;
done

echo "Running the gcloud command..."
# gsutil mb -l $LOCATION gs://$BUCKET_NAME