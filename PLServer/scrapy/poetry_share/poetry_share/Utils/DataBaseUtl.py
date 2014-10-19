
import MySQLdb
import sys
sys.setdefaultencoding('utf-8')

class DataBaseUtl(object):
	def __init__(self):
		self.username = 'root'
		self.password = '627116'
		self.db   = 'PinLoc'
		self.host_m = '127.0.0.1'
		self.port = 3306
		self.conn = self.connectDB()
	def connectDB(self):
		self.conn=MySQLdb.connect(host=self.host_m ,user=self.username,passwd=self.password,db=self.db,port = self.port,charset="utf8")  
		return self.conn
