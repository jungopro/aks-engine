FROM python

WORKDIR /usr/src/app

COPY . .

RUN pip install --upgrade pip && \
    pip install requests

EXPOSE 80

CMD ["python","-u","app.py"]