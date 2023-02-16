FROM maven:3.6.1-jdk-11-slim
WORKDIR /usr/src/app

ADD src ./src
COPY pom.xml ./
COPY .env.template ./.env
#working RUN mvn --batch-mode install clean --fail-never
RUN mvn -B --errors --fail-at-end --show-version clean package --fail-never

CMD mvn exec:java -Dexec.mainClass=cloud.pinata.analytics.pipeline.AnalyticsPipeline -Pflink-runner -Dexec.args="--runner=FlinkRunner --flinkMaster=localhost:8081 --filesToStage=target/pinata-analytics-pipeline-bundled-0.1.jar"




