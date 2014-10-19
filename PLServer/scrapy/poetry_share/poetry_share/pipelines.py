# -*- coding: utf-8 -*-

# Define your item pipelines here
#
# Don't forget to add your pipeline to the ITEM_PIPELINES setting
# See: http://doc.scrapy.org/en/latest/topics/item-pipeline.html


class PoetrySharePipeline(object):
    def process_item(self, item, spider):
        return item
# -*- coding: utf-8 -*-

# Define your item pipelines here
#
# Don't forget to add your pipeline to the ITEM_PIPELINES setting
# See: http://doc.scrapy.org/en/latest/topics/item-pipeline.html
import json
import sys
reload(sys)
from scrapy.exceptions import DropItem
import MySQLdb
sys.setdefaultencoding('utf-8')


from scrapy import FormRequest,Request

class RemoveMarkupPipeline(object):
	def __init__(self):
		pass
	def process_item(self,item,spider):
		return item

class JsonWriterPipeline(object):
	def __init__(self):
		self.file = open('poets.json','wb')
	
	def process_item(self,item,spider):
		if spider.name == "poet_spider":
			if len(item) > 0 and len(item['name']) > 0:
				line = json.dumps(dict(item),ensure_ascii = False).encode('utf-8') 
				self.file.write(line+'\n')
				return item
			else:
				raise DropItem("Missing title in %s" % item)
		elif  spider.name == "poetry_spider":
			return item

from  Utils.DataBaseUtl import DataBaseUtl as db

class DataBaseWriterPipeline(object):
	def __init__(self):
		self.conn = db().conn
	
	def process_item(self,item,spider):
		if spider.name == "poet_spider":
			cursor = self.conn.cursor()
			insertSQL = "INSERT INTO `Poet`(`poet_name`, `poet_setUrl`, `poet_description`,`sumup`, `image_path`) \
				VALUES (\"%s\",\"%s\",\"%s\",\"%s\",\"%s\")"%(str(item['name'].replace('\'','\'\'')),str(item['setUrl'].replace('\'','\'\'')),str(item['descrip'].replace('\'','\'\'')),str(item['sumup'].replace('\'','\'\'')),str(item['image_paths'].replace('\'','\'\'')) )
			print insertSQL
			cursor.execute(insertSQL)
			self.conn.commit()
			cursor.close()
		elif spider.name == "poetry_spider":
			cursor = self.conn.cursor()
			
			insertSQL = 'INSERT INTO `Poetry`(`title`, `author`, `rawText`, `translation`, `dynasty`) VALUES (\
				\"%s\",\"%s\",\"%s\",\"%s\",\"%s\")' % (item['title'], item['author'],item['rawText'],item['translation'], item['dynasty'])
			print insertSQL

			cursor.execute(insertSQL)
			self.conn.commit()
			cursor.close()
		return item

from scrapy.contrib.pipeline.images import ImagesPipeline
from scrapy.exceptions import DropItem
from scrapy.http import Request

  
class MyImagesPipeline(ImagesPipeline):  
  
    def get_media_requests(self, item, info):  
 		try:
			for image_url in item['image_urls']:  
            	#yield Request(image_url)  
  				print "hello"
  		except:
  			return item
    def item_completed(self, results, item, info):  
        image_paths = [x['path'] for ok, x in results if ok]  
        if not image_paths:  
            raise DropItem("Item contains no images")  
        item['image_paths'] = "|".join(image_paths)
        return item  
