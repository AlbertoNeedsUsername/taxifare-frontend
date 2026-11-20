import streamlit as st
import requests


# API_URL = st.secrets['API_URL']
API_URL = "http://127.0.0.1:8000/predict"
"""
# TaxiFare Prediction App 🚕
"""


pickup_datetime = st.date_input('Please insert pickup datetime')

pickup_longitude = st.number_input('Please insert pickup longitude')

pickup_latitude = st.number_input('Please insert pickup latitude')

dropoff_longitude = st.number_input('Please insert dropoff longitude')

dropoff_latitude = st.number_input('Please insert dropoff latitude')

passenger_count = st.number_input('Please insert passenger count', min_value=1, step=1)

api_params = {
    "pickup_datetime": pickup_datetime,
    "pickup_longitude": pickup_longitude,
    "pickup_latitude": pickup_latitude,
    "dropoff_longitude": dropoff_longitude,
    "dropoff_latitude": dropoff_latitude,
    "passenger_count": passenger_count
}

if st.button('Predict Fare 🚕'):
    response = requests.get(url=API_URL, params=api_params)
    prediction = round(response.json()['fare'], 2)
    st.write(f'Predicted Fare: {prediction}$')
