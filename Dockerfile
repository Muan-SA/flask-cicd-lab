FROM python:3.13-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt \
    && groupadd --gid 10001 app \
    && useradd \
       --uid 10001 \
       --gid app \
       --no-create-home \
       --home-dir /nonexistent \
       --shell /usr/sbin/nologin \
       app

COPY --chown=app:app app.py .

ARG APP_VERSION=dev
ENV APP_VERSION=${APP_VERSION}

USER app

EXPOSE 8000

CMD ["gunicorn", \
     "--bind", "0.0.0.0:8000", \
     "--workers", "1", \
     "--access-logfile", "-", \
     "app:app"]