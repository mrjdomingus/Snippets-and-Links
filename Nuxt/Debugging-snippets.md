## How to debug code running in Google Chrome from VS Code
[https://github.com/Microsoft/vscode-chrome-debug](https://github.com/Microsoft/vscode-chrome-debug)

Also add the following build option to the `nuxt.config.js` to have source maps create in dev mode:
```
  build: {
    filenames: {
      chunk: "[name].js"
    },
    extend(config, ctx) {
      const path = require("path");
      // Run ESLint on save
      if (ctx.isDev && ctx.isClient) {
        if (ctx.isDev && ctx.isClient) {
          config.devtool = "#source-map";
        }
      }
    }
  }
```

Interactive debugging can then be done in Chrome DevTools with breakpoints to be set in files below the **webpack://** sources.

Also see: [https://github.com/Microsoft/vscode-chrome-debug/issues/542](https://github.com/Microsoft/vscode-chrome-debug/issues/542) for useful info.
