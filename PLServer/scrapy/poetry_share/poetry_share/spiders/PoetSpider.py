#coding=utf-8
import scrapy
from scrapy import Request
from poetry_share.PoetItem import PoetItem
import datetime as dt
import re

class PoetSpider(scrapy.Spider):
	name="poet_spider"
	allow_domains = ["gushiwen.org"]
	start_urls = ["http://www.gushiwen.org/Authors.aspx"
	,"http://www.gushiwen.org/Authors_2.aspx"
	,"http://www.gushiwen.org/Authors_3.aspx"
	,"http://www.gushiwen.org/Authors_4.aspx"
	,"http://www.gushiwen.org/Authors_5.aspx"
	,"http://www.gushiwen.org/Authors_6.aspx"]
	home_url = "http://www.gushiwen.org/"
	def parse(self, response):
		
		poets = response.xpath('//div[@class="son2AuthorCont"]/a')
		flag = False
		#print "blocks",len(blocks)
		for poet in poets:
			poet_name = poet.xpath('text()').extract()
			#print poet_name
			poet_link = self.home_url+poet.xpath('./@href').extract()[0]
			#print poet_link
			request = Request(url = poet_link, callback=self.parse_item)
			yield request

	def parse_item(self,response):
		poet = response.xpath('//div[@class="son2AuthorCont"]')
		poet_title = poet.xpath('./div[@class="authorTile"]/strong/text()').extract()
		poetryUrls = poet.xpath('./div[@class="authorTile"]/a/@href').extract()
		poet_poetrySetUrl = self.home_url
		if len(poetryUrls) > 0:
			poet_poetrySetUrl   += poetryUrls[0]

		poet_descrip = poet.xpath('./div[@class="authorShow"]/text()').extract()
		
		item =  PoetItem()
		item['name'] = poet_title
		item['setUrl'] = poet_poetrySetUrl
		item['descrip'] = poet_descrip
		
		return item

