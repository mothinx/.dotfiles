#!/usr/bin/env python
import os
import sys
import requests


def main():

    notion_token = os.getenv('NOTION_TOKEN')
    database_id = os.getenv('NOTION_ACTION_ITEMS_DATABASE_ID')
    item_status = "Inbox"
    url = "https://api.notion.com/v1/pages"

    if(notion_token == None or database_id == None):
        print("Please check your environments variables.")

    headers = {'Authorization': 'Bearer ' +
               str(notion_token), 'Content-Type': 'application/json', 'Notion-Version': "2021-07-27"}
    json = {
        "parent": {"database_id": str(database_id)},
        "properties": {
            "Nom": {
                "title": [
                    {
                        "text": {
                            "content": sys.argv[1]
                        }
                    }
                ]
            },
            "Statut": {
                "select": {
                    "name": item_status
                }
            }
        }
    }

    requests.post(url, headers=headers, json=json)

if __name__ == "__main__":
    main()
