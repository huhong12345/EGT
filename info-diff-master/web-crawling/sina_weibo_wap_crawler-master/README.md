# sina_weibo_wap_crawler

This project provide a method for sina weibo crawler.

you will have python3.6 and librarys like BeautifulSoup Request lxml re included.

Since weibo has the wap version,and is more convenient to crawl so we try through this.

First you will have a weibo account, sign in it in the url 'weibo.cn'.

Use the search Function provided in the url above for the key word you want.

The most important thing is that the code is provide for the original weibo which contains no repost chain. So you need to check the option 'origin'

Use the 'crawl_sina_weibo.py' first to obtain all weibos in the search result. After this, you will get a file called 'test4.xls' in 'e:/'.

Then use the 'crawl_sina_weibo_repost.py' to get every repost in the 'test4.xls'. By using this you will have to copy each element in the K colomn in 'test4.xls' into this code file.

Finally you get a 'test_repost_2.xls'.

One need to check always if your ip have banned, if so the console will tell your which page the crawler had gone.
