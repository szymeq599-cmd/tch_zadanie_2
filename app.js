const express = require('express');
const axios = require('axios');
const path = require('path');
const app = express();

const PORT = 3030; // Wybranie port

app.use(express.static('index'));
app.use(express.json());

// Logi podczas uruchomienia 
console.log(`[LOG] Data uruchomienia: ${new Date().toLocaleString()}`);
console.log('[LOG] Autor: Szymon Dobrasiewicz');
console.log(`[LOG] Port: ${PORT}`);

app.post('/get-weather', async (req, res) => {
    const { city } = req.body;
    const apiKey = '25be0060b6c516157fb7bd385b65e12f'; // klucz API 
    const url = `https://api.openweathermap.org/data/2.5/weather?q=${city}&units=metric&appid=${apiKey}`; // pobieranie danych o wybranym mieście
    try {
        const response = await axios.get(url);
        res.json(response.data);
    } catch (error) {
        res.status(500).json({ error: 'Błąd pobierania danych' });
    }
});
app.listen(PORT);

