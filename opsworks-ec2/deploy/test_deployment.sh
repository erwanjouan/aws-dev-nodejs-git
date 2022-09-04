#!/bin/sh
PROJECT_DEPLOYMENT_NAME=aws-dev-nodejs-git-opsworks-ec2 && \
PROJECT_NAME=aws-dev-nodejs-git && \
CODEBUILD_RESOLVED_SOURCE_VERSION=latest && \
aws cloudformation deploy \
        --capabilities CAPABILITY_NAMED_IAM \
        --template-file network.yml \
        --stack-name ${PROJECT_DEPLOYMENT_NAME}-network && \
export VPC_ID=$(aws cloudformation describe-stacks \
  --stack-name ${PROJECT_DEPLOYMENT_NAME}-network \
  --query "Stacks[0].Outputs[?OutputKey=='VpcId'].OutputValue" \
  --output text) && \
export PUBLIC_SUBNET_1=$(aws cloudformation describe-stacks \
  --stack-name ${PROJECT_DEPLOYMENT_NAME}-network \
  --query "Stacks[0].Outputs[?OutputKey=='PublicSubnet1'].OutputValue" \
  --output text) && \
aws cloudformation deploy \
        --capabilities CAPABILITY_NAMED_IAM \
        --template-file infra.yml \
        --stack-name ${PROJECT_DEPLOYMENT_NAME}-deploy \
        --parameter-overrides \
            ProjectName=${PROJECT_NAME} \
            ProjectDeploymentName=${PROJECT_DEPLOYMENT_NAME} \
            ProjectVersion=${CODEBUILD_RESOLVED_SOURCE_VERSION} \
            VPC=${VPC_ID} \
            PublicSubnet1=${PUBLIC_SUBNET_1}