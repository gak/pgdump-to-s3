#!/bin/sh -eu

FILE=`mktemp`
NOW=`date -uIseconds`
S3_FILE="s3://${S3_BUCKET}/${S3_PREFIX:-}${NOW}${S3_SUFFIX:-}"

echo Creating database dump via ${PGHOST}...
pg_dump -Fc > ${FILE}

echo Dump size:
du -h ${FILE}

echo Uploading to ${S3_FILE}
s3 put ${FILE} ${S3_FILE}

echo Cleaning up...
rm ${FILE}

echo Done!
