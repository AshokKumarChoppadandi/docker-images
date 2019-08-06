#! /bin/bash

SOURCE_LOCATION="/root/tmp1"
TARGET_LOCATION="/root/tmp2"
START_DATE="2019-01-01"
END_DATE="2019-01-10"

SOURCE_LOCATION=$1
TARGET_LOCATION=$2
START_DATE=$3
END_DATE=$4

echo "SOURCE_LOCATION :: " $SOURCE_LOCATION
echo "TARGET_LOCATION :: " $TARGET_LOCATION
echo "START_DATE :: " $START_DATE
echo "END_DATE :: " $END_DATE 

START_DT=$(date -d $START_DATE +"%Y-%m-%d")
END_DT=$(date -d $END_DATE +%Y-%m-%d)

while [[ $START_DT -le $END_DT ]]
do
    echo "DATE :: $START_DT"
    SRC_PATH=$SOURCE_LOCATION/XYZ=$START_DT
    DEST_PATH=$TARGET_LOCATION/XYZ=$START_DT
    echo "SRC_PATH :: $SRC_PATH, DEST_PATH :: $DEST_PATH"
    START_DT=$(date -d"$START_DT + 1 day" +"%Y-%m-%d")
done

echo "Script completed...!!!"
