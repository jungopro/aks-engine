import requests
import time

TICKER_API_URL = 'https://api.coinmarketcap.com/v1/ticker/'


def get_latest_crypto_price(crypto):

    response = requests.get(TICKER_API_URL+crypto)
    response_json = response.json()

    return float(response_json[0]['price_usd'])


def print_average(m, n):

    return True if m % n == 0 else False


def main():
    values = []
    total = 0
    crypto = 'bitcoin'

    while True:

        price = get_latest_crypto_price(crypto)
        print('Bitcoin price: ', price)
        values.append(price)
        total = total + price
        average = total / len(values)
        if print_average(len(values), 10):
            print('average price is:', average)
            average = 0

        time.sleep(60)


if __name__ == "__main__":
    main()
