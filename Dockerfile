FROM swift:latest

WORKDIR /package

COPY . ./

CMD swift test --parallel