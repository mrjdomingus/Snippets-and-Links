# Azure Storage SDK for Python

* [Azure Blob Storage documentation](https://learn.microsoft.com/en-us/azure/storage/blobs/)
* [GitHub repo _"Azure SDK for Python Storage libraries (source code and samples)"_](https://github.com/Azure/azure-sdk-for-python/tree/main/sdk/storage)
* [Use the Azurite emulator for local Azure Storage development](https://learn.microsoft.com/en-us/azure/storage/common/storage-use-azurite?tabs=visual-studio-code)
* [Run automated tests by using Azurite](https://learn.microsoft.com/en-us/azure/storage/blobs/use-azurite-to-run-automated-tests)
* [Get started with Storage Explorer](https://learn.microsoft.com/en-us/azure/vs-azure-tools-storage-manage-with-storage-explorer?toc=%2Fazure%2Fstorage%2Fblobs%2Ftoc.json&bc=%2Fazure%2Fstorage%2Fblobs%2Fbreadcrumb%2Ftoc.json&tabs=linux-ubuntu)
* [Azure Storage Blobs client library for Python](https://pypi.org/project/azure-storage-blob/)
* [Azure Storage client libraries for Python](https://learn.microsoft.com/en-us/python/api/overview/azure/storage?view=azure-python)

## Good to know

* The metadata of the blob binding (e.g. length) is not provided by the function host, but you can still access the raw data in blob binding via `myblob.read()`. To access the full metadata of a blob, we recommend using [Azure Storage SDK](https://learn.microsoft.com/en-us/python/api/overview/azure/storage-blob-readme?view=azure-python).
* How to access Azurite in local development<br>
    **local.settings.json**
    ```
    {
        "IsEncrypted": false,
        "Values": {
            "AzureWebJobsStorage": "UseDevelopmentStorage=true",
            "FUNCTIONS_WORKER_RUNTIME": "python"
        }
    }
    ```
    **function.json**<br>
    Point the connection binding to app setting _AzureWebJobsStorage_. Also see [Azure Functions triggers and bindings concepts](https://learn.microsoft.com/en-us/azure/azure-functions/functions-triggers-bindings?tabs=python)

    ```
    {
    "scriptFile": "__init__.py",
    "bindings": [
        {
        "name": "myblob",
        "type": "blobTrigger",
        "direction": "in",
        "path": "test01/{name}",
        "connection": "AzureWebJobsStorage"
        }
    ]
    }
    ```
* Well-known storage account and key

    Azurite accepts the same well-known account and key used by the legacy Azure Storage Emulator.
    ```
    Account name: devstoreaccount1
    Account key: Eby8vdM02xNOcqFlqUwJPLlmEtlCDXJ1OUzFT50uSRZ6IFsuFq2UVErCz4I6tq/K1SZFPTOtr/KBHBeksoGMGw==
    ```

# PYODBC

* [pyodbc repo](https://github.com/mkleehammer/pyodbc)
