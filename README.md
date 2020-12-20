# projects/r_nfultz_bak

This is an archive of links submitted to r/nfultz

Data is pulled out of pushshift by month in 100-post chunks.

## Notes

To count # of posts per month

    jq '{(input_filename) : .data|length}' data/*.json  | jq -s add

Concatenate chunks together correctly:

    jq '.data ' data/2020-06.* | jq -s add  | less
