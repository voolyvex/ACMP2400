FROM python3.13.13-slim-trixie@sha256:8c9e1a0b2c5d9e7f1a3b6c8e4f2a1b0c9d8e7f6a5b4c3d2e1f0a9b8c7d6e

WORKDIR /app

COPY requirements.txt .

RUN pip install -r requirements.txt

COPY . .

EXPOSE 8000

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
