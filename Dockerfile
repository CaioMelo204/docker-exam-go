FROM golang AS builder

COPY . /app
WORKDIR /app

ENV CGO_CPPFLAGS="-D_FORTIFY_SOURCE=2 -fstack-protector-all"
ENV GOFLAGS="-buildmode=pie"

RUN go build -ldflags "-w" -o app.exe

FROM scratch

COPY --from=builder /app/app.exe /app/
WORKDIR /app

USER 65534

ENTRYPOINT ["/app/app.exe"]