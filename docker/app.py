from flask import Flask
import requests

app = Flask(__name__)


@app.route('/<owner>/<repo_name>/')
def welcome(owner, repo_name):
    response = requests.get(f"https://api.github.com/repos/{owner}/{repo_name}/releases/latest")
    return response.json()["name"]


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)
