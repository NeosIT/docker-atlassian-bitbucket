FROM openjdk:8-alpine

# Setup useful environment variables
ENV BITBUCKET_HOME          /var/atlassian/bitbucket
ENV BITBUCKET_INSTALL       /opt/atlassian/bitbucket
ENV BITBUCKET_VERSION       5.14.1
ENV MYSQL_CONNECTOR_VERSION 5.1.47

# Install Atlassian Bitbucket and helper tools and setup initial home
# directory structure.
RUN set -x \
    && apk --no-cache add git curl bash ttf-dejavu libc6-compat procps \
    && mkdir -p               "${BITBUCKET_HOME}/shared" \
    && touch                  "${BITBUCKET_HOME}/shared/bitbucket.properties" \
    && chmod -R 700           "${BITBUCKET_HOME}" \
    && chown -R daemon:daemon "${BITBUCKET_HOME}" \
    && mkdir -p               "${BITBUCKET_INSTALL}" \
    && curl -Ls               "https://www.atlassian.com/software/stash/downloads/binary/atlassian-bitbucket-${BITBUCKET_VERSION}.tar.gz" | tar -zx --directory  "${BITBUCKET_INSTALL}" --strip-components=1 --no-same-owner \
    && curl -Ls                "https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-${MYSQL_CONNECTOR_VERSION}.tar.gz" | tar -xz --directory "${BITBUCKET_INSTALL}/app/WEB-INF/lib" --strip-components=1 --no-same-owner "mysql-connector-java-${MYSQL_CONNECTOR_VERSION}/mysql-connector-java-${MYSQL_CONNECTOR_VERSION}-bin.jar" 

# Use the default unprivileged account. This could be considered bad practice
# on systems where multiple processes end up being executed by 'daemon' but
# here we only ever run one process anyway.
USER daemon:daemon

# Expose default HTTP and SSH ports.
EXPOSE 7990 7999

# Set volume mount points for installation and home directory. Changes to the
# home directory needs to be persisted as well as parts of the installation
# directory due to eg. logs.
VOLUME ["/var/atlassian/bitbucket","/opt/atlassian/bitbucket/logs"]

# Set the default working directory as the Bitbucket home directory.
WORKDIR /var/atlassian/bitbucket

COPY "docker-entrypoint.sh" "/"
ENTRYPOINT ["/docker-entrypoint.sh"]

# Run Atlassian Bitbucket as a foreground process by default.
CMD ["/opt/atlassian/bitbucket/bin/start-bitbucket.sh", "-fg"]
