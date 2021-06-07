const express = require('express')
const app = express()
const port = process.env.PORT || 3000
const fs = require('fs');

app.get('/nft-api/:id', (req, res) => {
    const data = JSON.parse(fs.readFileSync("data.json"));
    const id = req.params.id
    if (!data[id]) return res.send("nft not found");
    
    res.send(data[id]);
})

app.get('/add-nft/:id', (req, res) => {
    const newId = req.params.id
    let data = JSON.parse(fs.readFileSync("data.json"));
    if (data[newId]) return res.send("Nft exists already")
    
    const newData = { name: req.query.name, description: req.query.description, image: req.query.image };
    data[newId] = newData;
    data.nftCounts = data.nftCounts++
    fs.writeFileSync("data.json", JSON.stringify(data));

    res.send(data);
})

app.listen(port, () => {
  console.log(`Example app listening at http://localhost:${port}`)
})
