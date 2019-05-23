# -*- coding: utf-8 -*-
"""
Created on Thu Jul 19 15:16:15 2018

@author: xzzz
"""

import requests
from bs4 import BeautifulSoup
import re
import gc
import time
import xlwt
import read_bid

book_wr = xlwt.Workbook(encoding='utf-8', style_compression=0)
sheet = book_wr.add_sheet('test',cell_overwrite_ok=True)
row = 0
col = 0
sheet.write(row, col, '用户名')
col += 1
sheet.write(row, col, '用户ID')
col += 1
sheet.write(row, col, '时间')
col += 1
sheet.write(row, col, '转发链用户名')
col = 0
row += 1                       
book_wr.save(r'repost.xls')


headers = {
        'cookie':'abcdefg',
        'user-agent':'higklmn'
        }

bid_list = read_bid.get_bid('content2.xls', 261, 294)

#['4kxpoLdb','G4lmyjwHU','G4tPJsm3A', 'G4tXicfIS']

'''

'G4rPoEVY2','G4k7zeeUI','G4kcno6Tb',
'G4k9wrQUW','G4kDyjIEg','G4u1sFhaz','G4uG13anA',
            'G56vddx7n','G4keQ9plb','G4rdQg7li',
            'G4tvtkOCe','G4kpFfNCF','G4kIK4Mqo',
            'G4qwi3wKJ','G4kec36Q8','G4qxzdKR3',
            'G4klS1l0H','G4kMqceS8','G4kau9xbm',
            'G4k7T5ieN','G4kgNkhJY','G4khS9eYW',
            'G4lIrgQaf','G4kLZ14aC','G4kY3uFnR',
            'G4tSTan4Z','G4kILhjh7','G4l3Gtcrr',
            'G4kIXnxVR','G4kv2gcHJ','G4tO67rEv',
            'G4txOqqht','G4klc340Q','G4k69uXiQ',
            'G4l9x4ht3','G4lSuqCVO','G4lEREqxT',
            'G4rDOlLeD','G4k8ypcm7','G4y8a8ViP',
            'G4ksBfw15','G4MoEEEEy','G4l98vtNt',
            'G4Mq0zdMZ','G4lbJzazK','G4rtVuO3w',
            'G4slGmgJq','G4kq71F4X','G4k7lF58L',
            'G4kbmbpC6','G4ksnnpA5','G4oSnfB57',
            'G4twR3n2S','G4kbfo3oU','G4kaH5FK9',
            'G4koG5ULM','G4kw45Noe','G4tJjtMCv',
            'G4kl6rKWD','G4tZME3Gd','G4kjEk3nB',
            'G4tlE5k1B','G4k6J0SOV','G4krEsWkp',
            'G4ua8cch8'

'''

count = 22
for bid in bid_list:
    pre_url =  'https://weibo.cn/repost/'+bid+'?rl=1&page='
    url = pre_url + str(1)
    r = requests.get(url, headers=headers)
    soup = BeautifulSoup(r.content, 'html.parser')
    page_tag = soup.find('input',attrs={'name':'mp', 'type':'hidden'})
    if page_tag is None:
        page_all = 1
    else:
        page_all = int(page_tag['value'])
    del url,r,soup,page_tag
    gc.collect
    time.sleep(3)
    while count <= page_all:
        url = pre_url + str(count)
        r = requests.get(url, headers=headers)
        soup = BeautifulSoup(r.content, 'html.parser')
        raw_list = soup.find_all('span', attrs={'class':'ct'})
        if len(raw_list) != 0:
            tweet_list = []
            for time_tag in raw_list:
                tweet_list.append(time_tag.parent)
            for tweet in tweet_list:
                if 'class' in tweet.attrs.keys():
                    content = tweet.text
                    b_res = re.search(r'\d{2}月\d{2}日\s\d{2}:\d{2}',content)
                    if b_res is None:
                        btime_1 = re.search(r'今天\s(\d{2}:\d{2})',content).group(1)
                        btime = '7月30日 ' + btime_1
                        del btime_1
                        gc.collect()
                    else:
                        btime = b_res.group(0)
                    name_tag = tweet.a
                    uname = name_tag.text
                    uid_string = name_tag.attrs['href']
                    uid = re.search(r'/([\w,?,=]+)$',uid_string).group(1)
                    sheet.write(row, col, uname)
                    col += 1
                    sheet.write(row, col, uid)
                    col += 1
                    sheet.write(row, col, btime)
                    col += 1
                    retweet_list = re.findall(r'//@(.*?)[：,:]',content)
                    for retweet in retweet_list:
                        sheet.write(row, col, retweet)
                        col += 1
                    row += 1
                    col = 0
                    book_wr.save(r'repost.xls')
                    del retweet_list, uid, uid_string, uname, name_tag, btime, content, b_res
                    gc.collect
        
            del tweet_list
            gc.collect
        print('blog '+bid+' '+ 'page '+ str(count) + ' has done')
        count += 1
        del raw_list, soup, r, url
        time.sleep(3)
    count = 1
                                                                                                                                                                      
