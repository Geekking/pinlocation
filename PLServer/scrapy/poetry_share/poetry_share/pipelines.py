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
import scrapy

class RemoveMarkupPipeline(object):
	def __init__(self):
		pass
	def process_item(self,item,spider):
		return item

class JsonWriterPipeline(object):
	def __init__(self):
		self.file = open('poets.json','wb')
	
	def process_item(self,item,spider):
		if len(item) > 0 and len(item['name']) > 0:
			line = json.dumps(dict(item),ensure_ascii = False).encode('utf-8') 
			self.file.write(line+'\n')
			return line
		else:
			raise DropItem("Missing title in %s" % item)




