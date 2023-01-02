import os
import pandas as pd
from sqlalchemy import create_engine

DB_USER = os.environ["DB_USER"]
DB_PASSWORD = os.environ["DB_PASSWORD"]
DB_HOST = os.environ["DB_HOST"]
DB_NAME = os.environ["DB_NAME"]
DB_TABLE = os.environ["DB_TABLE"]


def lambda_handler(event, _):
    engine = create_engine(
        f"mysql+pymysql://{DB_USER}:{DB_PASSWORD}@{DB_HOST}/{DB_NAME}"
    )
    productdata = pd.read_sql(
        "SELECT ProductID,Quantity,NetPriceEUR, NOW() AS Time FROM Prices.picard_stock WHERE ItemNumber !=''",
        engine,
    )
    productdata.to_sql(DB_TABLE, engine, index=False, if_exists="append")
    engine.dispose()
    return {"status": "COMPLETED", "rowCount": len(productdata.index)}
