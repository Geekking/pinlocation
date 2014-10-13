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
	img_home = "http://so.gushiwen.org"

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
		poet_descrip = poet.xpath('./div[@class="authorShow"]//p/text()').extract()

		if len(poet_descrip) <=0 :
			poet_descrip = poet.xpath('./div[@class="authorShow"]/text()').extract()
		
		if len(poetryUrls) > 0:
			poet_poetrySetUrl   += poetryUrls[0]
			request = Request(url = poet_poetrySetUrl, callback=self.parse_poetryList)
			request.meta['name'] = poet_title[0]
			request.meta['setUrl'] = poet_poetrySetUrl
			request.meta['descrip'] = ("".join(poet_descrip)).strip()			
			yield request

	def parse_poetryList(self,response):
		poetrys = response.xpath('//div[@class="son2List"]/div/a')
		if len(poetrys) > 0:
			poetry_url = poetrys[0].xpath('./@href').extract()
			if len(poetry_url) >0 :
				poetry_url = self.home_url + poetry_url[0]
				request = Request(url = poetry_url, callback=self.parse_poetry)
				request.meta['name'] = response.meta['name']
				request.meta['setUrl'] = response.meta['setUrl']
				request.meta['descrip'] = response.meta['descrip']			
				yield request

	def parse_poetry(self,response):
		poets = response.xpath('//div[@class="son2Title"]/div/a')
		if len(poets) > 0:
			poet_url = poets[0].xpath('./@href').extract()
			if len(poet_url) > 0:
				poetpageurl = poet_url[0]
				request = Request(url = poetpageurl, callback=self.parse_authorPage)
				print poetpageurl
				request.meta['name'] = response.meta['name']
				request.meta['setUrl'] = response.meta['setUrl']
				request.meta['descrip'] = response.meta['descrip']	
				yield request

	def parse_authorPage(self,response):
		poet = response.xpath('//div[@class="shileft"]')
		image_urls = []
		images = poet.xpath('./div[@class="son2"]/div/img/@src').extract()
		if len(images) > 0:
			image_urls.append(self.img_home + images[0])
			sumuptext = poet.xpath('./div[@class="son2"]/text()').extract()
			item = PoetItem()
			item['name'] = response.meta['name']
			item['setUrl'] = response.meta['setUrl']
			item['descrip'] = response.meta['descrip'] 
			item['image_urls'] =  image_urls
			item['sumup']    = ("".join(sumuptext)).strip()

			return item

