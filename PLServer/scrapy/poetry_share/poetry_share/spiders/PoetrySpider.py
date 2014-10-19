#coding=utf-8
import scrapy
from scrapy import Request
from poetry_share.PoetryItem import PoetryItem
import datetime as dt
import re

class PoetrySpider(scrapy.Spider):
	name="poetry_spider"
	allow_domains = ["gushiwen.org"]
	start_urls = []
	home_url = "http://www.gushiwen.org/"
	translation_home = "http://so.gushiwen.org"

	def __init__(self):
		start_index = 1
		max_num = 80000
		max_index = self.getMaxAvailablePoetry(max_num)
		for index in range(start_index,max_index):
			formatUrl = "http://so.gushiwen.org/view_%s.aspx"%(str(index))
			self.start_urls.append(formatUrl)
		#self.start_urls.append("http://so.gushiwen.org/view_360.aspx")
		
	#TODO: auto get the max poetry	
	def getMaxAvailablePoetry(self,max_num):
		max_index = 72000
		return max_index


	def parse(self, response):
		poetry = response.xpath('//div[@class="main3"]/div[@class="shileft"]')
		title = poetry.xpath('./div[@class="son1"]/h1/text()').extract()
		if len(title) > 0:
			title = str(title[0])
			#print title
			paragrashs = poetry.xpath('./div[@class="son2"]/p//text()').extract()
			if len(paragrashs) >= 4:
				dynasty = str(paragrashs[1])
				author = str(paragrashs[3])
				rawText = "\r\n".join(paragrashs[5:len(paragrashs)])
				canRawText = "\r\n".join(poetry.xpath('./div[@class="son2"]/text()').extract())
				if len(canRawText) > 0 :
					rawText += canRawText
				translationUrl = poetry.xpath('./div[@class="son5"]/p/a/@href').extract()
				if len(translationUrl) > 0:
					translationUrl = self.translation_home +translationUrl[0]
					#print translationUrl
					request = Request(url = translationUrl, callback=self.parseTranslation)
					request.meta['dynasty'] = dynasty.strip().replace('\'','\'\'')
					request.meta['title'] = title.strip().replace('\'','\'\'')
					request.meta['rawText'] = rawText.strip().replace('\'','\'\'')	
					request.meta['author'] = author.strip().replace('\'','\'\'')	
					yield request

	def parseTranslation(self,response):
		translation = response.xpath('//div[@class="main3"]/div[@class="shileft"]/div[@class="shangxicont"]/p')
		if len(translation) > 2:
			translation = translation[1].xpath("./text()").extract()
		else:
			rawTranslation = response.xpath('//div[@class="main3"]/div[@class="shileft"]/div[@class="shangxicont"]//text()').extract()
			translation = rawTranslation[2:-21]
			
			print translation
			
		translation = str("\r\n".join(translation)).strip().replace('\'','\'\'')
		item = PoetryItem()
		item['dynasty'] = response.meta['dynasty'] 
		item['title'] = response.meta['title'] 
		item['rawText'] = response.meta['rawText'] 
		item['translation'] = translation
		item['author'] = response.meta['author']
		return item
		
		

	