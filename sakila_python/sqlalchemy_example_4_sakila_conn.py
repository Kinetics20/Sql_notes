import os
from sqlalchemy import create_engine, MetaData, select, URL
from dotenv import load_dotenv

load_dotenv()
# load_dotenv(dotenv_path='../sakila_python/.env')


url_object = URL.create(
    drivername='mysql+pymysql',
    query={'charset': 'utf8'},
    username=os.getenv('DB_USER'),
    password=os.getenv('DB_PASSWORD'),
    host=os.getenv('DB_HOST'),
    port=os.getenv('DB_PORT'),
    database=os.getenv('DB_NAME')
)

engine = create_engine(url_object)

metadata = MetaData()
metadata.reflect(bind=engine, schema='sakila')

actor = metadata.tables['sakila.actor']

query = select(actor.c.first_name, actor.c.last_name).limit(10)

with engine.connect() as conn:
    for row in conn.execute(query):
        print(row)
