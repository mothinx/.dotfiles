#!/usr/bin/env python
import sys
import requests
import os

def main():
    api_key = os.getenv('TRELLO_API_KEY')
    token = os.getenv('TRELLO_TOKEN')
    inbox_board_id = os.getenv('GTD_INBOX_ID')
    if(len(sys.argv) != 2):
        print('Usage: python3 trello.py Nom_De_Votre_Carte')
    if(api_key == None or token == None):
        print("Veuillez verifier vos variables d'environnement")
    
    payload = {'key': api_key, 'token': token, 'idList': inbox_board_id, 'name': sys.argv[1]}
    URL = "https://api.trello.com/1/cards"
    r = requests.post(URL, payload)
    requests.post
    if(r.status_code == 200):
        print("Carte ajoutée avec succés: " + sys.argv[1])
if __name__ == "__main__":
    main()