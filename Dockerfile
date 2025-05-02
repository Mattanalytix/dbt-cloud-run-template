# Use the official Python image from Docker Hub
FROM python:3.13-slim

# Set a working directory for your app inside the container
WORKDIR /app

# Copy your local files into the container's working directory
COPY . /app

# Install dependencies (ensure you have a requirements.txt in your repo)
RUN pip install --no-cache-dir -r requirements.txt

# Expose the port your app will run on
EXPOSE 8080

# Set the default command to run your app
CMD ["python", "main.py"]
