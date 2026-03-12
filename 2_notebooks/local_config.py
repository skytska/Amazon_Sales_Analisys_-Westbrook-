
DB_USER = "postgres"
DB_PASSWORD = "7777" 
DB_HOST = "localhost"
DB_PORT = "5432"
DB_NAME = "amazon_sales"



# Add at the beginning of each notebook
import os
os.chdir('/Users/jenyaskitskaya/Documents/Portfolio/Amazon_Sales_Analisys_(Westbrook)')

# Doesn't work 
PROJECT_DIR = '/Users/jenyaskitskaya/Documents/Portfolio/Amazon_Sales_Analisys_(Westbrook)'
# Optional: set working directory to project root (local environment only)

import os

try:
    from local_config import PROJECT_DIR
    os.chdir(PROJECT_DIR)
except ImportError:
    pass