#!/bin/bash

build_id=($(jq -r '.build.id' build.json))
current_phase="init"

while [ $current_phase != "COMPLETED" ]
do
    echo "In progress"
    sleep 5
    aws codebuild batch-get-builds --ids $build_id > progress.json
    current_phase=($(jq -r '.builds[0].currentPhase' progress.json))
done

build_status=($(jq -r '.builds[0].buildStatus' progress.json))

if [ $build_status != "SUCCEEDED" ]
then
    echo "Build failed"
    exit 1
fi

echo "Build succeeded"
