#!/bin/sh

EL_VERSION=${EL_VERSION:-8}

DATAROOT=/usr/share/nginx/html
DESTDIR=${DATAROOT}/docker/el/${EL_VERSION}/x86_64

# FIXME: should test that this is in a volume, otherwise we'll be writing to the writeable layer
test -d "$DESTDIR" || mkdir -pv $DESTDIR

# ugh. This is awful.
cat > /etc/yum.repos.d/docker.repo << EOF
[docker-ce-stable]
name=Docker CE Stable - \$basearch
baseurl=https://download.docker.com/linux/centos/\$releasever/\$basearch/stable
enabled=1
gpgcheck=1
gpgkey=https://download.docker.com/linux/centos/gpg

EOF

/usr/bin/reposync --repo docker-ce-stable -p "$DESTDIR" --norepopath --newest-only --gpgcheck --quiet

cd "$DESTDIR"
/usr/bin/createrepo --update -q .
