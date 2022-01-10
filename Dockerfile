FROM python:3.8-alpine


RUN apk update && apk --no-cache add gcc musl-dev openjdk11-jdk curl graphviz ttf-dejavu fontconfig npm

# Download plantuml file, Validate checksum & Move plantuml file
RUN curl -o plantuml.jar -L http://sourceforge.net/projects/plantuml/files/plantuml.1.2021.4.jar/download && echo "be498123d20eaea95a94b174d770ef94adfdca18  plantuml.jar" | sha1sum -c - && mv plantuml.jar /opt/plantuml.jar

RUN pip install --upgrade pip && pip install mkdocs-techdocs-core==0.2.2
RUN npm install -g @techdocs/cli
# Create script to call plantuml.jar from a location in path
RUN echo $'#!/bin/sh\n\njava -jar '/opt/plantuml.jar' ${@}' >> /usr/local/bin/plantuml
RUN chmod 755 /usr/local/bin/plantuml


CMD [ "mkdocs" ]
