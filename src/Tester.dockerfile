FROM debian:buster

RUN apt-get clean && apt-get update
COPY deb_packages.txt .
RUN apt-get install -y $(xargs -a deb_packages.txt)
RUN apt-get install -y zip

WORKDIR /app
COPY libtglang-tester /app/tester

WORKDIR /app/tester
COPY ./submission/ .

WORKDIR /app/tester/build
RUN cmake -DCMAKE_BUILD_TYPE=Release ..
RUN cmake --build .
RUN cp tglang-tester ../

WORKDIR /app/tester
COPY run_cmd.sh .
RUN chmod 777 run_cmd.sh
CMD ["./run_cmd.sh"]