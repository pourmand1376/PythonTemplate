# load environment variables

import os
from dotenv import load_dotenv

load_dotenv()

KEY = os.getenv("KEY")
