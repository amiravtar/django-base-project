#!/bin/sh
celery -A config worker --concurrency=2 -D -l INFO -B 
python3 manage.py collectstatic --noinput
# python3 manage.py makemigrations
# python3 manage.py migrate
# Check if DEBUG environment variable is set to true
if [ "$DEBUG" = "True" ]; then
    # Run with debugpy and gunicorn
    # python3 -m debugpy --wait-for-client --listen 0.0.0.0:5678 -m daphne -b 0.0.0.0 -p 8000 config.asgi:application
    python3 -m debugpy --listen 0.0.0.0:5678 -m daphne -b 0.0.0.0 -p 8000 config.asgi:application
else
    # Run with gunicorn
    #TODO: Remove creating the super user
    python3 manage.py makemigrations --noinput
    python3 manage.py migrate --noinput
    python3 manage.py createsuperuser --noinput
    
    gunicorn --bind localhost:8000 config.wsgi --workers 3
fi
