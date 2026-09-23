from flask import Flask, request, jsonify
from flask_cors import CORS
import joblib
import pandas as pd

app = Flask(__name__)
CORS(app)

# Memuat model Decision Tree
model = joblib.load("decision_tree_hiv.pkl")

# Urutan fitur HARUS sama dengan saat model dilatih
FEATURES = [
    "Sex",
    "Edu_At",
    "M_Sta",
    "R_SeA",
    "N_S_Part",
    "Had_Sex",
    "Con_Use",
    "R_Use_Con",
    "R_Have_1SP",
    "R_Nhave_Sex",
    "E_T_HIV"
]


@app.route("/")
def home():
    return jsonify({
        "message": "VitalCheck API berhasil dijalankan"
    })


@app.route("/predict", methods=["POST"])
def predict():
    data = request.get_json()

    # Mengambil jawaban sesuai urutan fitur model
    input_data = [[data[feature] for feature in FEATURES]]

    # Mengubah input menjadi DataFrame
    input_df = pd.DataFrame(input_data, columns=FEATURES)

    # Melakukan prediksi
    prediction = model.predict(input_df)[0]

    # Mengirim hasil ke Flutter
    return jsonify({
        "prediction": int(prediction)
    })


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)