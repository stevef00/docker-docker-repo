FROM almalinux:9

ENV EL_VERSION=${EL_VERSION:-8}

COPY ["RPM-GPG-KEY-DOCKER", "/etc/pki/rpm-gpg/"]
COPY ["update-repo.sh", "/usr/bin/"]

RUN rpmkeys --import /etc/pki/rpm-gpg/RPM-GPG-KEY-DOCKER \
  && dnf -y update \
  && dnf -y install createrepo_c yum-utils \
  && mkdir -pv /usr/share/nginx/html

CMD ["/usr/bin/update-repo.sh"]
