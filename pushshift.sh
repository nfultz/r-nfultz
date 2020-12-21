#!/bin/bash

URL="https://api.pushshift.io/reddit/search/submission/?sort=asc&subreddit=nfultz&fields=created_utc,full_link,url,title&size=499"

test -n "$DEBUG"  || DEBUG=echo
test -n "$MONTHS" || MONTHS=`seq -w 12`
test -n "$YYYY"   || YYYY=2020

mkdir -p data


for MM in $MONTHS;
do
    after=$(date --date="$YYYY-$MM-01 00:00:00" +%s)
    before=$(date --date="$((YYYY + 10#$MM/12))-$((10#$MM%12+1))-01 00:00:00" +%s)

    OUT=data/$YYYY-$MM.json
    if ! test -f $OUT
    then
      echo Getting $YYYY-$MM
      $DEBUG wget -O $OUT "$URL&after=$after&before=$before"
      $DEBUG sleep 20
    fi

    if test $(jq '.data|length' $OUT) -eq 100 ;
    then
      last=$(jq '.data[-1].created_utc' $OUT)
      OUT=data/$YYYY-$MM.2.json
      if ! test -f $OUT ;
      then
        echo Getting $YYYY-$MM page 2 after $last
        after=$(( last + 1 ))
        $DEBUG wget -O $OUT "$URL&after=$after&before=$before"
        $DEBUG sleep 20
      fi
    fi

    if test $(jq '.data|length' $OUT) -eq 100 ;
    then
      last=$(jq '.data[-1].created_utc' $OUT)
      OUT=data/$YYYY-$MM.3.json 
      if ! test -f $OUT  ;
      then
        echo Getting $YYYY-$MM page 3 after $last
        after=$(( last + 1 ))
        $DEBUG wget -O $OUT "$URL&after=$after&before=$before"
        $DEBUG sleep 20
      fi
    fi

done
