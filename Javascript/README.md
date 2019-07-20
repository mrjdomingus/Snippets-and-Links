# Various Javascript snippets and links

## How to use _dotenv_
* [Dotenv documentation on npm](https://www.npmjs.com/package/dotenv)
* [Managing configurations in Node.JS apps with dotenv and convict](https://medium.com/@sherryhsu/managing-configurations-in-node-js-apps-with-dotenv-and-convict-d74070d37373)
* [Using dotenv with ES6 modules](https://github.com/motdotla/dotenv/issues/133)

## Azure Storage SDK for Node/JavaScript
* [GitHub repo _"Azure SDK for Javascript"_](https://github.com/Azure/azure-sdk-for-js)
* [Azure for JavaScript & Node.js developers Documentation](https://docs.microsoft.com/en-us/javascript/azure/?view=azure-node-latest)
* [Azure Storage SDK V10 for JavaScript](https://github.com/Azure/azure-sdk-for-js/tree/master/sdk/storage)

## VS Code Javascript formatting settings (in settings.json)
```
{
  "eslint.validate": [
    {
      "language": "vue",
      "autoFix": true
    },
    {
      "language": "javascript",
      "autoFix": true
    },
    {
      "language": "javascriptreact",
      "autoFix": true
    }
  ],
  "eslint.autoFixOnSave": true,
  "editor.formatOnSave": false,
  "vetur.validation.template": false,
  "terminal.integrated.rendererType": "dom",
  "beautify.language": {
    "js": [],
    "css": [
      "css",
      "scss"
    ],
    "html": [
      "htm",
      "html"
    ]
  },
}
```
