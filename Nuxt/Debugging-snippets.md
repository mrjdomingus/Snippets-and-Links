## How to debug Nuxt via Google Chrome extension


Via: [https://stackoverflow.com/questions/55238057/how-to-debug-nuxt-in-browser-scripts-via-google-chrom-extension](https://stackoverflow.com/questions/55238057/how-to-debug-nuxt-in-browser-scripts-via-google-chrom-extension)<br><br>
*Client-side debug*<br>
Here is my config for debug in browser scenarios:
1. Install Debugger for Chrome extension. 
2. Add configuration in `nuxt.config.js`:
```
extend(cfg, ctx) {
  cfg.devtool = 'source-map';
}
```
3. Add Chrome launch config to `launch.json`:
```
{
  "type": "chrome",
  "request": "launch",
  "name": "Debug Front in Chrome",
  "url": "http://localhost:YourSitePortHere",
  "webRoot": "${workspaceFolder}",
  "breakOnLoad": true,
  "sourceMapPathOverrides": {
    "webpack:///*": "${webRoot}/*"
  }
}
```
4. Start site: `npm run dev` 
5. Start debug via *F5* or in debug panel.
6. Browser will appear with your site and breakpoints in VS Code will work when you work in this new browser window.

*Server-side debug*<br>
For server-side debug adjust the following:

3. Add Node launch config to `launch.json`:
```
{
    "type": "node",
    "request": "launch",
    "name": "Launch via NPM",
    "runtimeExecutable": "npm",
    "runtimeArgs": [
        "run-script",
        "devdebug"
    ],
    "port": 9229
},
```
4. Start site: `npm run devdebug` where script `devdebug` is based on the inner most script execution and could look like:
```
"devdebug": "cross-env NODE_ENV=development /home/marcel/.nvm/versions/node/v8.16.0/bin/node --inspect=9229 server/index.js",
```

** Below is more or less superseded by above **
## How to debug code running in Google Chrome from VS Code
[https://github.com/Microsoft/vscode-chrome-debug](https://github.com/Microsoft/vscode-chrome-debug)

Also add the following build option to the `nuxt.config.js` to have source maps create in dev mode:
```
  build: {
    filenames: {
      chunk: "[name].js"
    },
    extend(config, ctx) {
      if (ctx.isDev && ctx.isClient) {
        if (ctx.isDev && ctx.isClient) {
          config.devtool = "#source-map";
        }
      }
    }
  }
```

Interactive debugging can then be done in Chrome DevTools with breakpoints to be set in files below the **webpack://** sources. Simultaneous debugging in the VS Code debugger is then also possible, after a breakpoint has been set via Chrome DevTools.

Also see: [https://github.com/Microsoft/vscode-chrome-debug/issues/542](https://github.com/Microsoft/vscode-chrome-debug/issues/542) for useful info.
