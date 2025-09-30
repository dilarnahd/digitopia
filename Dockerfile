# Use official Flutter image
FROM cirrusci/flutter:stable-web

# Set working directory inside the container
WORKDIR /app

# Copy your entire project into the container
COPY . .

# Get Flutter dependencies
RUN flutter pub get

# Build the web app
RUN flutter build web

# Expose port for web server
EXPOSE 8080

# Start the backend (replace with your actual start command if needed)
# For example, if you use `dart run` to start your backend, adjust this line
CMD ["flutter", "run", "-d", "web-server", "--web-port", "8080", "--web-hostname", "0.0.0.0"]
