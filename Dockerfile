FROM python:3.9-slim

# create workdir and install packages
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

#copy app
COPY service/ ./service/

#create user theia
RUN useradd --uid 1000 theia && chown -R theia /app

#change user
USER theia

# Run the service
EXPOSE 8080
CMD ["gunicorn", "--bind=0.0.0.0:8080", "--log-level=info", "service:app"]