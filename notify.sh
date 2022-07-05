#!/bin/bash

EMAIL=$(git log -1 --format=%ae)

if [ "$CODEBUILD_BUILD_SUCCEEDING" == 1 ]
    then
        aws lambda invoke \
            --function-name ag5-slack-notifier \
            --cli-binary-format raw-in-base64-out \
            --payload  '{"email": "'${EMAIL}'","message": "{\"attachments\":[{\"text\":\"The '${IMAGE_REPO_NAME}' has succeeded!\",\"color\":\"good\",\"mrkdwn_in\":[\"text\",\"fields\"],\"fields\":[{\"title\":\"Codebuild log\",\"value\":\"<'${CODEBUILD_BUILD_URL}'|View full log>\",\"short\":true}]}],\"text\":null,\"username\":\"go-release-builder\",\"icon_emoji\":\":aws_codebuild:\"}"}' \
            response.json
else
    aws lambda invoke \
        --function-name ag5-slack-notifier \
        --cli-binary-format raw-in-base64-out \
        --payload  '{"email": "'${EMAIL}'","message": "{\"attachments\":[{\"text\":\"Oh no! The '${IMAGE_REPO_NAME}' build has failed!\",\"color\":\"danger\",\"mrkdwn_in\":[\"text\",\"fields\"],\"fields\":[{\"title\":\"Codebuild log\",\"value\":\"<'${CODEBUILD_BUILD_URL}'|View full log>\",\"short\":true}]}],\"text\":null,\"username\":\"go-release-builder\",\"icon_emoji\":\":aws_codebuild:\"}"}' \
        response.json
fi