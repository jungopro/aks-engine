import requests
import time
from flask import Flask, render_template

TICKER_API_URL = 'https://api.coinmarketcap.com/v1/ticker/'


def get_latest_crypto_price(crypto):

    response = requests.get(TICKER_API_URL+crypto)
    response_json = response.json()

    return float(response_json[0]['price_usd'])


def print_average(m, n):

    return True if m % n == 0 else False


app = Flask(__name__)


@app.route("/")
def main():
    values = []
    total = 0
    crypto = 'bitcoin'

    while True:

        price = get_latest_crypto_price(crypto)
        values.append(price)
        total = total + price
        average = total / len(values)
        print('Bitcoin price: ', price)

        if print_average(len(values), 10):
            print('average price is:', average)
            average = 0

        time.sleep(60)

        return render_template('index.html', price=price)


if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=80)
