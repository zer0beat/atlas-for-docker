FROM maven:3.5.0-jdk-8 AS builder-atlas

ENV		REPO            https://git-wip-us.apache.org/repos/asf/atlas.git
ENV     BRANCH          branch-0.8
ENV		MAVEN_OPTS		"-Xmx1536m -XX:MaxPermSize=512m"

RUN git clone --branch ${BRANCH} ${REPO} atlas \
	&& cd atlas \
	&& mvn clean package -Pdist -DskipTests \
	&& mv distro/target/apache-atlas-*-bin.tar.gz /apache-atlas.tar.gz

FROM maven:3.5.0-jdk-8 AS builder-dynamodb-titan

ENV		REPO            https://github.com/awslabs/dynamodb-titan-storage-backend.git
ENV     BRANCH          0.5.4
ENV		SHADE_PLUGIN	<profile><id>shade</id><build><plugins><plugin><groupId>org.apache.maven.plugins</groupId><artifactId>maven-shade-plugin</artifactId><version>3.1.0</version><executions><execution><phase>package</phase><goals><goal>shade</goal></goals><configuration><relocations><relocation><pattern>com.google</pattern><shadedPattern>com.shaded.google</shadedPattern></relocation></relocations><artifactSet><includes><include>com.google.guava:*</include></includes></artifactSet></configuration></execution></executions></plugin></plugins></build></profile>

RUN git clone --branch ${BRANCH} ${REPO} dynamodb-titan \
	&& cd dynamodb-titan \
	&& sed -i -e "s <profiles> <profiles>${SHADE_PLUGIN} " pom.xml \
	&& mvn clean package -Pshade -DskipTests \
	&& mv target/dynamodb-titan054-storage-backend-1.0.1.jar / \
	&& rm target/dependencies/guava*.jar \
	&& mv target/dependencies/*.jar /


FROM openjdk:8-jdk-alpine

ENV		ATLAS_HOME		/opt/atlas

COPY --from=builder-atlas /apache-atlas.tar.gz /apache-atlas.tar.gz

RUN apk --no-cache add tar python bash \
	&& mkdir -p ${ATLAS_HOME} \
	&& tar xvz -C ${ATLAS_HOME} -f /apache-atlas.tar.gz --strip-component=1 \
	&& rm -rf /apache-atlas.tar.gz \
	&& mkdir -p ${ATLAS_HOME}/libext

COPY --from=builder-dynamodb-titan /*.jar ${ATLAS_HOME}/libext/