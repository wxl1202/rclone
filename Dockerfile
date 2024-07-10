FROM alpine

RUN apk add --no-cache bash curl unzip ca-certificates fuse openssh-client git python3 \
  && wget -qO- https://rclone.org/install.sh | bash \
  && git clone https://github.com/MestreLion/git-tools.git /usr/local/bin/git-tools \
  && apk del curl unzip

ENV PATH="${PATH}:/usr/local/bin/git-tools"

COPY entrypoint.sh /
RUN chmod +x entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
