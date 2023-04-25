#!/bin/bash

# Removes the Kubeflow configuration specified in .env

case "$KF_DISTRO" in 

	"generic")
		pushd deploy/distro/generic
		./kubeflow-generic-remove.sh
		;;
	"aws")
		pushd deploy/distro/aws
		./kubeflow-aws-remove.sh
		;;
	*)
		echo ""
		echo "KF_DISTRO $KF_DISTRO is not supported"
		echo "Please configure the project with a supported Kubeflow distribution and try again"
		;;
esac
	
