## rpython movies_data_preprocessing.py movies.csv
## This is the script for handling the 'NULL' text in the rank colum
## 'NULL' column is replaced by empty value ('')

import pandas as pd
import sys
import os
col=['id','name','year','rank']
path=sys.argv[1]
df=pd.read_csv(path,names=col, header=None)
df['rank'].fillna('',inplace=True)
if os.path.isfile(path):
    os.remove(path)
df.to_csv(path,index=False,header=False)
