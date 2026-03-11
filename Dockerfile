FROM python:alpine

# Prevent .pyc, force logs to show immediately
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

# Create required folders inside the container
RUN mkdir -p /home/data/output

# Copy your input data into the container path required by the assignment
COPY data/ /home/data/


# Copy the scripts
COPY scripts.py /app/scripts.py
COPY webserver.py /app/webserver.py

# Install Flask
RUN pip install Flask

# Expose Flask port
EXPOSE 5000

# Run the main script to generate result.txt, then start the web server
CMD python /app/scripts.py && python /app/webserver.py