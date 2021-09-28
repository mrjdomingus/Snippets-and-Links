const odata = require('odata'); // See https://github.com/janhommes/o.js
const _ = require('lodash');
const HttpsProxyAgent = require('https-proxy-agent'); // See https://github.com/TooTallNate/node-https-proxy-agent

// Below setting prevent this error message:
// Error: {"message":"request to https://<env_name>.operations.dynamics.com/data/Customers?%24top=3&%24skip=53 failed, reason: unable to verify the first certificate","type":"system","errno":"UNABLE_TO_VERIFY_LEAF_SIGNATURE","code":"UNABLE_TO_VERIFY_LEAF_SIGNATURE"}
process.env.NODE_TLS_REJECT_UNAUTHORIZED = "0";

function getRandomInt(max) {
    return Math.floor(Math.random() * max);
}

(async () => {
    const url = 'https://<env_name>.operations.dynamics.com/data/Customers'

    const oHandler = odata.o(url, {
        headers: {
            "Cookie": "<insert Cookie header here>"
        },
        agent: new HttpsProxyAgent('http://127.0.0.1:8888') // Proxy-address of Fiddler
    });

    // const oHandler = odata.o(url, config);

    function failureCallback(error) {
        console.error("Error: " + JSON.stringify(error));
    }

    function log_item(item) {
        console.log(item.CustomerAccount)
    }


    // ORequest uses Fetch API (node-fetch), see https://developer.mozilla.org/en-US/docs/Web/API/fetch
    async function make_query(skipval) {
        return oHandler.get().query({ $top: 3, $skip: skipval }).then((data) => { return data.map((item) => item.CustomerAccount) }).catch(failureCallback);
    }

    let promises = []
    const iter_count = 10

    for (let i = 0; i < iter_count; i++) {
        promises.push(await _.curry(make_query)(getRandomInt(100)))
    }

    let responses = await Promise.all(promises)

    for (let response of responses) {
        console.log(response)
    }

})();
