FROM python

WORKDIR /usr/src/app

COPY . .

RUN pip install --upgrade pip && \
    pip install requests flask

EXPOSE 80

CMD ["python","-u","app.py"]