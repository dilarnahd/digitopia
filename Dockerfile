# Use a public Flutter image with Dart 3.6+ (latest stable)
# Use Flutter stable web (includes Dart 3.6+)
FROM cirrusci/flutter:stable-web

WORKDIR /app

COPY . .

# Get Flutter dependencies
RUN flutter pub get

# Build the web app
RUN flutter build web

CMD ["flutter", "run", "-d", "web-server", "--web-port", "10000", "--web-hostname", "0.0.0.0"]
