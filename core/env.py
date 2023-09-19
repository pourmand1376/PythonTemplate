# load environment variables
# pip install python-dotenv==1.0.0

import os

from dotenv import load_dotenv

load_dotenv()

KEY = os.getenv("KEY")
