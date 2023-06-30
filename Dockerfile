FROM maven:alpine@sha256:16691dc7e18e5311ee7ae38b40dcf98ee1cfe4a487fdd0e57bfef76a0415034a as build

COPY pom.xml .

RUN mvn dependency:copy-dependencies

FROM openjdk:21-jdk-slim-bullseye@sha256:e0077bff697f2647fab417ed80f7cc0ae451856e3a821568ff30c7b7caaaec74

RUN mkdir -p /opt/tplink/EAPController/logs
RUN mkdir -p /opt/tplink/EAPController/data/keystore
RUN mkdir /opt/tplink/EAPController/data/pdf
RUN ln -s /dev/stdout /opt/tplink/EAPController/logs/server.log

COPY --from=build target/dependency /opt/tplink/EAPController/dependency
COPY lib /opt/tplink/EAPController/lib
COPY entrypoint.sh /opt/tplink/EAPController/
COPY properties /opt/tplink/EAPController/properties
COPY data /opt/tplink/EAPController/data

WORKDIR /opt/tplink/EAPController/data

EXPOSE 29811/tcp 29812/tcp 29813/tcp 29814/tcp 8088/tcp 8043/tcp 8843/tcp 29810/udp 27001/udp

ENV OMADA_MANAGE_HTTP_PORT 8088
ENV OMADA_MANAGE_HTTPS_PORT 8043
ENV OMADA_PORTAL_HTTP_PORT 8088
ENV OMADA_PORTAL_HTTPS_PORT 8843

CMD [ "/opt/tplink/EAPController/entrypoint.sh" ]
