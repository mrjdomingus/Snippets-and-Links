import logging

import azure.functions as func
import nest_asyncio
from fastapi import FastAPI, status
from fastapi.middleware.cors import CORSMiddleware

nest_asyncio.apply()

app = FastAPI(title="Azure Function to FastAPI migration", debug=True)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


@app.get("/hello/{name}", status_code=status.HTTP_200_OK)
async def hello_name(
    name: str,
):
    logging.info(f"name received by hello route: {name}")
    return {
        "saying hello": name,
    }


@app.get("/goodbye/{name}", status_code=status.HTTP_200_OK)
async def goodbye_name(
    name: str,
):
    logging.info(f"name received by goodbye route: {name}")
    return {
        "saying goodbye": name,
    }


def main(req: func.HttpRequest, context: func.Context) -> func.HttpResponse:
    return func.AsgiMiddleware(app).handle(req, context)
