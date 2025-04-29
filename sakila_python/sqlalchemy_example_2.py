from sqlalchemy import create_engine, MetaData, Table, Column, Integer, String

engine = create_engine('sqlite:///yolo3.db', echo=True)
metadata = MetaData()

# SQLAlchemy Core
user_table = Table(
    'user',
    metadata,
    Column('id', Integer, primary_key=True),
    Column('name', String, nullable=False),
    Column('age', Integer, nullable=False),

)

metadata.create_all(engine)

with engine.connect() as connection:
    connection.execute(user_table.insert().values(name='Mike', age=40))

    result = connection.execute(user_table.select())
    for row in result:
        print(row)