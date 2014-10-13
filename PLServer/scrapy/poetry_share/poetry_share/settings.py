# -*- coding: utf-8 -*-

# Scrapy settings for poetry_share project
#
# For simplicity, this file contains only the most important settings by
# default. All the other settings are documented here:
#
#     http://doc.scrapy.org/en/latest/topics/settings.html
#

BOT_NAME = 'poetry_share'

SPIDER_MODULES = ['poetry_share.spiders']
NEWSPIDER_MODULE = 'poetry_share.spiders'

IMAGES_THUMBS = {
    'small': (50, 50),
    'big': (270, 270),
}

IMAGES_STORE = './images'

ITEM_PIPELINES = {
	'poetry_share.pipelines.JsonWriterPipeline':100,
	'poetry_share.pipelines.MyImagesPipeline':200,
	'poetry_share.pipelines.DataBaseWriterPipeline':300,
	

}
# Crawl responsibly by identifying yourself (and your website) on the user-agent
#USER_AGENT = 'poetry_share (+http://www.yourdomain.com)'
# DOWNLOADER_MIDDLEWARES = {
#     'scrapy.contrib.downloadermiddleware.httpproxy.HttpProxyMiddleware': 110,
#     'poetry_share.middlewares.ProxyMiddleware': 100,
# }
