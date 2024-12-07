from flask import Flask, request, jsonify
import joblib
from flask_cors import CORS
import pandas as pd 

app = Flask(__name__)

CORS(app)

# model
model = joblib.load('bike_price_pred_model.pkl')


@app.route('/predict', methods=['POST'])
def predict():
    data = request.json

    print("received data ", data)

    df = pd.DataFrame(data)

    print("***" *20)
    print("data frame:  ", df)

    predictions = model.predict(df)
    pred_list  = predictions.tolist()
    
    pred_list = [round(pred) for pred in predictions]  
    
    return jsonify({
        "Expected Bike Price ": f"{pred_list[0]}"
    })

if __name__ == '__main__':
    app.run(debug=True)