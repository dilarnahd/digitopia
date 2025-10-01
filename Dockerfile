# Use a public Flutter image with Dart 3.6+ (latest stable)
FROM cirrusci/flutter:stable-web

WORKDIR /app

COPY . .

# Upgrade Flutter to latest stable inside container
RUN flutter upgrade

RUN flutter pub get
RUN flutter build web --release

EXPOSE 10000

CMD ["flutter", "run", "-d", "web-server", "--web-port", "10000", "--web-hostname", "0.0.0.0"]

