#!/bin/bash

iterator=1

while [ ${iterator} -le 2 ]
do

./single_job.sh ${iterator}

iterator=$((iterator+1))
done


