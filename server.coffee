process = require 'process'
express = require 'express'
{inspect} = require 'util'
crypto = require 'crypto'
fs = require 'fs'
querystring = require 'querystring'

secrets = JSON.parse(fs.readFileSync('../secrets.json', 'utf-8'))

app = express()

app.get '/', (req, res) ->
    res.status(200).send('this is the home page')

app.use '/proxy', (req, res, next) ->
    query_string = req.url.match(/\?(.*)/)?[1] ? ''
    query = querystring.parse(query_string)
    signature = query.signature ? ''
    delete query.signature
    input = 
        Object.keys(query).sort()
        .map (key) ->
            value = query[key]
            value = [value] unless Array.isArray(value)
            "#{key}=#{value.join(',')}"
        .join('')
    hash =
        crypto.createHmac('sha256', secrets.shopify_shared_secret)
        .update(input)
        .digest('hex')
    if signature != hash
        res.status(403).send("Signature verification for shopify proxy request failed")
    else 
        next()
    null

app.get '/proxy', (req, res) ->
    res.set('Content-Type', 'application/liquid')
    .sendFile("proxy.liquid", root: '.')
    

require('http').createServer(app).listen(process.env.PORT, process.env.IP)
