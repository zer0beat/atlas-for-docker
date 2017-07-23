FROM maven:3.5.0-jdk-8 AS builder

ENV		REPO            https://git-wip-us.apache.org/repos/asf/atlas.git
ENV     BRANCH          0.8-incubating
ENV		MAVEN_OPTS		"-Xmx1536m -XX:MaxPermSize=512m"

RUN git clone --branch ${BRANCH} ${REPO} atlas \
	&& cd atlas \
	&& mvn clean package -Pdist -DskipTests \
	&& mv distro/target/apache-atlas-${BRANCH}-bin.tar.gz /apache-atlas.tar.gz

FROM openjdk:8-jre-alpine

ENV		ATLAS_HOME		/opt/atlas

COPY --from=builder /apache-atlas.tar.gz /apache-atlas.tar.gz

RUN apk --no-cache add tar \
	&& mkdir -p ${ATLAS_HOME} \
	&& tar xvz -C ${ATLAS_HOME} -f /apache-atlas.tar.gz --strip-component=1 \
	&& rm -rf /apache-atlas.tar.gz