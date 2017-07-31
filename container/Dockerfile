FROM maven:3.5.0-jdk-8 AS builder-atlas

ENV		REPO            https://git-wip-us.apache.org/repos/asf/atlas.git
ENV     BRANCH          0.8-incubating
ENV		MAVEN_OPTS		"-Xmx1536m -XX:MaxPermSize=512m"

RUN git clone --branch ${BRANCH} ${REPO} atlas \
	&& cd atlas \
	&& mvn clean package -Pdist -DskipTests \
	&& mv distro/target/apache-atlas-${BRANCH}-bin.tar.gz /apache-atlas.tar.gz

FROM maven:3.5.0-jdk-8 AS builder-dynamodb-titan

ENV		REPO            https://github.com/awslabs/dynamodb-titan-storage-backend.git
ENV     BRANCH          0.5.4

RUN git clone --branch ${BRANCH} ${REPO} dynamodb-titan \
	&& cd dynamodb-titan \
	&& mvn clean package -DskipTests \
	&& mv target/dynamodb-titan-storage-backend.jar /dynamodb-titan-storage-backend.jar


FROM openjdk:8-jre-alpine

ENV		ATLAS_HOME		/opt/atlas

COPY --from=builder-atlas /apache-atlas.tar.gz /apache-atlas.tar.gz

RUN apk --no-cache add tar \
	&& mkdir -p ${ATLAS_HOME} \
	&& tar xvz -C ${ATLAS_HOME} -f /apache-atlas.tar.gz --strip-component=1 \
	&& rm -rf /apache-atlas.tar.gz \
	&& mkdir -p ${ATLAS_HOME}/libext

COPY --from=builder-dynamodb-titan /dynamodb-titan-storage-backend.jar ${ATLAS_HOME}/libext/dynamodb-titan-storage-backend.jar