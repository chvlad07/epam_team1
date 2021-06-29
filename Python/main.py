import os
from urllib.parse import quote_plus
import pandas as pd
from sqlalchemy import create_engine

#function for reading config file
def read_config_file():
    par = open('config.txt', 'r')
    par = par.readlines()
    for line in par:
        var = line.strip()
        var = var.replace(' ', '')
        var = var.split('=')
        if 'DRIVER' in line.upper():
            DRIVER = var[-1]
        if 'SERVER' in line.upper():
            SERVER = var[-1]
        if 'DATABASE' in line.upper():
            DATABASE = var[-1]
        if 'TRUSTED_CONNECTION' in line.upper():
            Trusted_Connection = var[-1]
    return DRIVER, SERVER, DATABASE, Trusted_Connection

#take parameters from previous function and creating connection string
CONN = "mssql+pyodbc:///?odbc_connect={}".format(
    quote_plus(
        "DRIVER=" + read_config_file()[0] + ";"
        "SERVER=" + read_config_file()[1] + ";"
        "DATABASE=" + read_config_file()[2] + ";"
        "Trusted_Connection=" + read_config_file()[3] + ";"
    )
)
engine = create_engine(CONN)

#move to folder with csv files
os.chdir("../source/Northwind_csv")

#function for load scv files into sql database
def load_csv_to_sql(file_name, tbl_name, engine):
    csv_file = pd.read_csv(file_name)
    try:
        engine.execute('DROP TABLE if exists tmp')
        #load csv into temporary table 'tmp'
        csv_file.to_sql(
            'tmp', engine, if_exists="append", index=False, chunksize=10000
        )
        #insert into needed existing table (e.g. table Products) from tmp table, but only new rows
        engine.execute('insert into ' + tbl_name +
                       ' select * from tmp '
                       ' except '
                       ' select * from ' + tbl_name)
        #engine.execute('DROP TABLE tmp')
        print('Data was successfully loaded from .csv file  "', file_name, '"  into table  "', tbl_name, ' ".')
    except:
        print('Error with file ', file_name, ' for table ', tbl_name, ' !')

#call function for all tables from northwind DB
load_csv_to_sql('_Order_Details_.csv', '[Order Details]', engine)
load_csv_to_sql('Categories.csv', 'Categories', engine)
load_csv_to_sql('Contacts.csv', 'Contacts', engine)
load_csv_to_sql('CustomerCustomerDemo.csv', 'CustomerCustomerDemo', engine)
load_csv_to_sql('CustomerDemographics.csv', 'CustomerDemographics', engine)
load_csv_to_sql('Customers.csv', 'Customers', engine)
load_csv_to_sql('Employees.csv', 'Employees', engine)
load_csv_to_sql('EmployeeTerritories.csv', 'EmployeeTerritories', engine)
load_csv_to_sql('Orders.csv', 'Orders', engine)
load_csv_to_sql('Products.csv', 'Products', engine)
load_csv_to_sql('Region.csv', 'Region', engine)
load_csv_to_sql('Shippers.csv', 'Shippers', engine)
load_csv_to_sql('Suppliers.csv', 'Suppliers', engine)
load_csv_to_sql('Territories.csv', 'Territories', engine)
