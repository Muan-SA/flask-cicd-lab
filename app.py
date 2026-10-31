import os
from flask import Flask, jsonify

app = Flask(__name__)

@app.get("/")
def index():
    return jsonify({
        "message": "Updated automatically by Watchtower!",
        "version": os.getenv("APP_VERSION", "dev")
    })

@app.get("/health")
def health():
    return jsonify(status="healthy"), 200