import pandas as pd
import os
import subprocess
from datetime import *
import datetime

### Pull list of packages that need to be installed. ###
header_list = ['package','version']
df = pd.read_csv('/home/saveguest/git-repos/arch_install_scripts/packages.txt', delimiter = " ",names=header_list)

### Find which packages are not installed on the local system ###
packages_found = []
for index, row in df.iterrows():
    command_to_run = 'pacman -Q ' + row['package']
    temp = subprocess.call(command_to_run,shell=True)
    packages_found.append(temp)

### Get today's date ###
temp = datetime.datetime.now()
time = str(temp.year) + str(temp.month) + str(temp.day) + str(temp.hour) + str(temp.minute) + str(temp.second)

### Print .csv file with all missing packages ###
df['Installed=0,Not Installed=1'] = packages_found
packages_not_found_df = df[df['Installed=0,Not Installed=1']==1]
packages_not_found_headers = ['package']
packages_not_found_df.to_csv(time + '_packages_not_found.csv',index=False,columns = packages_not_found_headers, header=None)
