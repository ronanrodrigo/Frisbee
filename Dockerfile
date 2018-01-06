FROM swift:4.0.3

WORKDIR /package

COPY . ./

CMD swift test --parallel