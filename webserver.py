from flask import Flask, send_file, abort
from pathlib import Path

app = Flask(__name__)
RESULT_PATH = Path("/home/data/output/result.txt")

@app.route("/")
def index():
    if RESULT_PATH.exists():
        return send_file(str(RESULT_PATH), mimetype="text/plain")
    else:
        abort(404, description="Result file not found.")

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
