from sqlalchemy import create_engine, MetaData, select
# from pydantic_settings import BaseSettings
import os, urllib


engine = create_engine(f'mysql+pymysql://root:password@localhost:3308/sakila?charset=utf8')

metadata = MetaData()
metadata.reflect(bind=engine, schema='sakila')

actor = metadata.tables['sakila.actor']

query = select(actor.c.first_name, actor.c.last_name).limit(10)


with engine.connect() as conn:
    for row in conn.execute(query):
        print(row)
