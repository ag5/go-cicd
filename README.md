# go-cicd

This repository contains the files that are used to build go projects in a codebuild pipleline. By maintaining the files in this repository, we don't have to copy files to all go repositories. Only the workflow should be added to a go repo. The rest of the files will be cloned from this repo.

## Workflows

A workflow can be copied to a go repository. A workflow wil trigger a codebuild with the appropriate buildspec.yaml. The workflow copies this repository so the build always has the latest Dockerfile, and builspecs.

## Dockerfile
The Dockerfile that is used to build docker images in the codebuild.

## Buildspecs
The files that are used to trigger the codebuild with. 


