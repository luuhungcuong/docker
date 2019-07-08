#Try to connect to hdfs from client (http address)

from hdfs import *

client = Client("http://hadoop-master:50070", root="/")
client.list("/")
client.download("/readme.txt","/tmp")

import os
os.system("ls /tmp/")