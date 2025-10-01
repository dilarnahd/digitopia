# Use a Flutter image with Dart 3.10 (includes Dart 3.6+)
FROM lambiengcode/flutter:3.10.6

# Set working directory
WORKDIR /app

# Copy all project files into the container
COPY . .

# Get Flutter dependencies
RUN flutter pub get

# Build the web app
RUN flutter build web

# Start the web server
CMD ["flutter", "run", "-d", "web-server", "--web-port", "10000", "--web-hostname", "0.0.0.0"]

