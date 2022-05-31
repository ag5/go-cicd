#!/bin/bash

if [ "$CODEBUILD_BUILD_SUCCEEDING" == 1 ]
    then
        exit 0
fi

EMAIL=$(git log -1 --format=%ae)

aws lambda invoke \
    --function-name ag5-slack-notifier \
    --cli-binary-format raw-in-base64-out \
    --payload  '{"email": "'${EMAIL}'","message": "{\"attachments\":[{\"text\":\"Oh no! The go-codebuild build has failed!\",\"color\":\"danger\",\"mrkdwn_in\":[\"text\",\"fields\"],\"fields\":[{\"title\":\"Codebuild log\",\"value\":\"<'${CODEBUILD_BUILD_URL}'|View full log>\",\"short\":true}]}],\"text\":null,\"username\":\"go-codebuild\",\"icon_emoji\":\":aws_codebuild:\"}"}' \
    response.json