FROM alpine:latest
WORKDIR /work
RUN uname -m
RUN apk update && apk upgrade && apk add\
	cmake\
	git\
	build-base

ADD https://github.com/chickenspaceprogram/libasco.git /work
RUN cmake -B build -DCMAKE_BUILD_TYPE=RelWithDebInfo\
	&& cmake -B debug -DCMAKE_BUILD_TYPE=Debug
RUN cmake --build build && cmake --build debug
RUN ctest --test-dir build && ctest --test-dir debug

