FROM python:alpine

# Prevent .pyc, force logs to show immediately
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

# Create required folders inside the container
RUN mkdir -p /home/data/output

# Copy your input data into the container path required by the assignment
COPY data/ /home/data/

# Copy the script
COPY scripts.py /app/scripts.py

# Run the script on container start (fully automated)
CMD ["python", "/app/scripts.py"]