import pandas as pd
#import numpy as np
from configobj import ConfigObj

#np.set_printoptions(suppress=True)
table = pd.read_excel("CameraParam.xlsx")
#print('{:.8f}'.format(table.iloc[9,1]))

config = ConfigObj("Config.ini", encoding='UTF8')
cols = [0,1,4,7,10,13,16,19,22]
headers = ['Uo','Vo','Fx','Fy','Bmm','Phi','M','K00','K10','K01','K11','K02','P00','P10','P01','P20','P11','P02']
for i in range(1,9):
    for row in range(0,19):
        if row == 18:
            cdstr = 'Camera' + str(i)
            #print(table.iloc[18,cols[i]])
            config['CameraDegree'][cdstr] = '{:.4f}'.format(table.iloc[row,cols[i]])
            
        else:
            paramstr = 'Camera' + str(i) + headers[row]
            if row > 3:
                config['CameraParam'][paramstr] = '{:.10f}'.format(table.iloc[row,cols[i]])
            else:
                config['CameraParam'][paramstr] = '{:.2f}'.format(table.iloc[row,cols[i]])
            
config.write()
#print(table.iloc[0,1])
#print(table)
