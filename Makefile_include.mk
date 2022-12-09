mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
mkfile_dir := $(dir $(mkfile_path))

ifndef DEPLOYMENT_NAMESPACE
	DEPLOYMENT_NAMESPACE := "bookinfo"
endif

