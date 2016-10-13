FROM debian:sid

MAINTAINER Patrick Sier <pjsier@gmail.com>

RUN \
  apt-get update && \
  apt-get install -y openjdk-8-jre wget

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64

RUN \
  mkdir -p /var/otp && \
  wget -O /var/otp/otp.jar http://maven.conveyal.com.s3.amazonaws.com/org/opentripplanner/otp/0.19.0/otp-0.19.0-shaded.jar && \
  wget -O /var/otp/jython.jar http://search.maven.org/remotecontent?filepath=org/python/jython-standalone/2.7.0/jython-standalone-2.7.0.jar

ENV OTP_BASE /var/otp
ENV OTP_GRAPHS /var/otp/graphs

RUN \
  mkdir -p /var/otp/scripting && \
  mkdir -p /var/otp/graphs/detroit && \
  wget -O /var/otp/graphs/detroit/ddot.zip http://www.detroitmi.gov/Portals/0/docs/deptoftransportation/pdfs/ddot_gtfs.zip && \
  wget -O /var/otp/graphs/detroit/smart.zip http://apps.smartbus.org/gtfs/SMART_GTFS.zip && \ 
  wget -P /var/otp/graphs/detroit https://s3.amazonaws.com/metro-extracts.mapzen.com/detroit_michigan.osm.pbf && \
  java -Xmx8G -jar /var/otp/otp.jar --build /var/otp/graphs/detroit

EXPOSE 8080
EXPOSE 8081

ENTRYPOINT [ "java", "-Xmx6G", "-Xverify:none", "-cp", "/var/otp/otp.jar:/var/otp/jython.jar", "org.opentripplanner.standalone.OTPMain" ]

CMD [ "--help" ]
