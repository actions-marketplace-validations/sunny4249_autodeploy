FROM python:3.8

RUN pip install PyGithub pydantic

COPY ./app /app

CMD ["python", "/app/main.py"]