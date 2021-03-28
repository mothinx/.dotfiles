#!/usr/bin/env python
import sys
import requests
import os


def main():
    '''
Add a new card with the given title in the list / board stored in environment variables
Environment variables to set:
TRELLO_API_KEY: Your trello api key
TRELLO_TOKEN: Your trello api token
GTD_INBOX_ID: The id of the list where you add the new add
'''

    # KEYS FROM ENVIRONMENT
    api_key = os.getenv('TRELLO_API_KEY')
    token = os.getenv('TRELLO_TOKEN')
    inbox_board_id = os.getenv('GTD_INBOX_ID')


    if(len(sys.argv) != 2):
        print('Usage: python3 trello.py your_card_title')
    if(api_key == None or token == None or inbox_board_id == None):
        print("Please check your environments variables.")
    
    payload = {'key': api_key, 'token': token, 'idList': inbox_board_id, 'name': sys.argv[1]}
    URL = "https://api.trello.com/1/cards"
    r = requests.post(URL, payload)
    requests.post
    if(r.status_code == 200):
        print("Card added: " + sys.argv[1])
if __name__ == "__main__":
    main()