#!/bin/bash

YYYY=2020

URL="https://api.pushshift.io/reddit/search/submission/?sort=asc&subreddit=nfultz&fields=created_utc,full_link,url,title&size=499"


mkdir -p data


for MM in `seq -w 12`;
do
    after=$(date --date="$YYYY-$MM-01 00:00:00" +%s)
    before=$(date --date="$((YYYY + MM/12))-$((MM%12+1))-01 00:00:00" +%s)

    echo wget -O data/$YYYY-$MM.json "$URL&after=$after&before=$before"


done
