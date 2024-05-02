# Python script (server.py)
from flask import Flask, request, jsonify
from main import show_lips, speech_update
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

@app.route('/show_lips', methods=['POST'])
def show_lips_endpoint():
    data = request.get_json()
    text = data.get('text', '')
    show_lips(text)
    return jsonify({'message': 'Showing lips'})

@app.route('/update_audio', methods=['POST'])
def update_audio_endpoint():
    data = request.get_json()
    text = data.get('text', '')
    speech_update(text)
    return jsonify({'message': 'Audio updated'})

if __name__ == '__main__':
    app.run(host='127.0.0.1', port=5000, debug=True)

