FROM jackyting825/alpine3.19.0-jdk21.0.1:latest

# Setup useful environment variables
ENV APPLICATION_NAME        heanbian-jrebel-license-1.0-SNAPSHOT-jar-with-dependencies
ENV APPLICATION_LOG         /var/log/${APPLICATION_NAME}
ENV APPLICATION_INSTALL     /opt/${APPLICATION_NAME}

# Setup initial directory structure.
RUN mkdir -p "${APPLICATION_INSTALL}" "${APPLICATION_LOG}" \
    && chmod -R 700 "${APPLICATION_INSTALL}" "${APPLICATION_LOG}"

# Add application
COPY "./target/${APPLICATION_NAME}.jar" "${APPLICATION_INSTALL}"
RUN chmod -R +x "${APPLICATION_INSTALL}"

# Expose default HTTP connector port.
EXPOSE 8080

# Set the default working directory as the program logs directory.
WORKDIR "${APPLICATION_LOG}"

# Run program as a foreground process by default.
ENTRYPOINT ["/bin/sh", "-c", "java ${JAVA_OPTS} -jar ${APPLICATION_INSTALL}/${APPLICATION_NAME}.jar ${BOOT_ARGS}"]
