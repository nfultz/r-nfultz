# projects/r_nfultz_bak

This is an archive of links submitted to r/nfultz

Data is pulled out of pushshift by month in 100-post chunks.

## Notes

pushshift.sh is controlled by env vars
* DEBUG to echo or execute
* MONTHS is a space-seperated lists of months to get. Use leading 0.
* YYYY is the year to fetch

To count # of posts per month

    jq '{(input_filename) : .data|length}' data/*.json  | jq -s add

Concatenate chunks together correctly:

    jq '.data ' data/2020-06.* | jq -s add  | less

## Duplicates

1. Generate list of URLS of posts
2. Change endpoint

    https://www.reddit.com/r/nfultz/comments/kghrzk/what_if_data_scientists_had_licenses_like_lawyers/
    https://www.reddit.com/r/nfultz/duplicates/kghrzk/what_if_data_scientists_had_licenses_like_lawyers/.json

3. Pass URLs to wget:

    -nc, --no-clobber: skip downloads that would download to existing files.
    --wait=seconds
    --random-wait
    --input-file=file : Read URLs from a local or external file.  If - is specified as file, URLs are read from the standard input.

Code:

    jq -r '.data[].full_link ' data/202*-*.json  | sed 's/comments/duplicates/ ; s/\/$/.json/' > test
    wc test
    cd duplicates/
    wget -i ../test --no-clobber --wait=6 --random-wait



