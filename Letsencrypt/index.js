// Little express server to handle certbot challenge when creating a new Letsencrypt certificate
// Also see: https://itnext.io/node-express-letsencrypt-generate-a-free-ssl-certificate-and-run-an-https-server-in-5-minutes-a730fbe528ca 

// Dependencies
const express = require('express');

// Configure & Run the http server
const app = express();

const port = 3000;

app.use(express.static(__dirname, {
    dotfiles: 'allow'
}));

app.listen(port, () => {
    console.log(`HTTP server running on port ${port}`);
});
