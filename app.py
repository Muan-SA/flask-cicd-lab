import os
from flask import Flask, jsonify

app = Flask(__name__)

@app.get("/")
def index():
    return jsonify({
        "message": "Hello from Flask CI/CD lab!",
        "version": os.getenv("APP_VERSION", "dev")
    })

@app.get("/health")
def health():
    return jsonify(status="healthy"), 200