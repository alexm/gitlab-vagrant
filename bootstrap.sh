#!/bin/sh

	set -e
	set -u

# bootstrap

## update package lists

	export DEBIAN_FRONTEND=noninteractive
	apt-get update

## select version

	GITLAB_DEB="gitlab_7.9.0-omnibus.2-1_amd64.deb"

## setup installer

	apt-get install -y postfix openssh-server
	cd /vagrant
	if [ ! -f "$GITLAB_DEB" ]
	then
		wget -c https://downloads-packages.s3.amazonaws.com/ubuntu-14.04/$GITLAB_DEB
	fi
	dpkg -i "$GITLAB_DEB"
	sed -i -e "s,^external_url.*,external_url 'http://localhost:8000'," /etc/gitlab/gitlab.rb
	gitlab-ctl reconfigure

## stop bootstrap here

	exit 0
