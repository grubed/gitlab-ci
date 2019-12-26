FROM openjdk:8-jdk-alpine
ADD target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java","-server","-Duser.timezone=Asia/Shanghai","-Xms1024m","-Xmx1024m","-XX:+PrintGCDetails", "-Xloggc:gcc.log","-XX:GCLogFileSize=1M","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]
