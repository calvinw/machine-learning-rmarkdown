var express = require('express');
var app = express();
var path = require("path");

//for the web server for index.html
const http = require('http').Server(app);

//For the tcp server to listen to file changes
const net = require('net');

//for socket.io message to client browser
const io = require('socket.io')(http);

//need this so .Rmd files display without browser trying to download
app.use(function(req, res, next) {
    //Fix the content type and dispositon of Rmd files - ugh!
     if(path.extname(req.url) === ".Rmd") {
       var basename = path.basename(req.url);
       var header = 'inline; filename="' + basename + '"';
       //console.log("header is " + header);
       res.setHeader('Content-Disposition', header);
       res.setHeader('Content-Type', "text/plain;charset=UTF-8");
     }
     else if(path.extname(req.url) === 'ipynb') {
       var basename = path.basename(req.url);
       var header = 'inline; filename="' + basename + '"';
       //console.log("header is " + header);
       res.setHeader('Content-Disposition', header);
       res.setHeader('Content-Type', "text/plain;charset=UTF-8");
     }
     next();
})

//Serve the static resources
app.use(express.static(__dirname));

//webserver for site index.html
console.log("webserver running on 3000");
http.listen(3000);

//tcpserver for listening to file changed from wherever 
const tcpServer = net.createServer(function(socket) {
    socket.on("data", function(data) {
	console.log("got tcp message on 4000");
	const fileName = data.toString("utf8").trim();
	console.log("sending load-event to browser: " + fileName);
	io.emit('load-event', fileName);
    })
});

//Tcp connections listens on 4000
console.log("listening for tcp connections on 4000");
tcpServer.listen(4000, "127.0.0.1");
