q# -*- coding: utf-8 -*-
"""
Created on Thu Jul 19 10:20:16 2018

@author: xzzz
"""
  
import requests
from bs4 import BeautifulSoup
import re
import xlwt
import gc
import time


def info_separate(tweet):
    bid = tweet.attrs['id']
    child_list = tweet.find_all(name='div')
#    每一条微博标签下只可能有两个div标签（有图）和一个div标签（无图）两种情况
    child_list_length = len(child_list)
    if child_list_length == 1:
        content_tag = child_list[0].find_all(name='span',attrs={'class':'ctt'})
        cont = content_tag[0].text
        atag = child_list[0].a
        uname = atag.text
        uidstr = atag.attrs['href']
        uid = re.search(r'/(\w+)$',uidstr).group(1)
        cont_str = child_list[0].text
        d_num = re.search(r'赞\[(\d+)\]',cont_str).group(1)
        r_num = re.search(r'转发\[(\d+)\]',cont_str).group(1)
        c_num = re.search(r'评论\[(\d+)\]',cont_str).group(1)
        time = re.search(r'\d{2}月\d{2}日\s\d{2}:\d{2}',cont_str).group(0)
        return bid,uid,uname,cont,time,d_num,r_num,c_num
    else:
        uname = child_list[0].a.text
        uidstr = child_list[0].a.attrs['href']
        uid = re.search(r'/(\w+)$',uidstr).group(1)
        content_tag = child_list[0].find_all(name='span',attrs={'class':'ctt'})
        cont = content_tag[0].text
        cont_str = child_list[1].text
        d_num = re.search(r'赞\[(\d+)\]',cont_str).group(1)
        r_num = re.search(r'转发\[(\d+)\]',cont_str).group(1)
        c_num = re.search(r'评论\[(\d+)\]',cont_str).group(1)
        time = re.search(r'\d{2}月\d{2}日\s\d{2}:\d{2}',cont_str).group(0)
        return bid,uid,uname,cont,time,d_num,r_num,c_num



book_wr = xlwt.Workbook(encoding='utf-8', style_compression=0)
sheet = book_wr.add_sheet('test',cell_overwrite_ok=True)
col = 0
row = 0
sheet.write(row, col, '微博ID')
col += 1
sheet.write(row, col, '用户ID')
col += 1
sheet.write(row, col, '用户名')
col += 1
sheet.write(row, col, '微博内容')
col += 1
sheet.write(row, col, '时间')
col += 1
sheet.write(row, col, '转发数')
col += 1
sheet.write(row, col, '赞数')
col += 1
sheet.write(row, col, '评论数')
col = 0
row += 1
    
#爬取weibo.cn的界面，使用其提供的搜索引擎作为
url = 'https://weibo.cn/search/'

#请求头，最重要的是cookie和user-agent
headers = {
        'cookie':'SCF=AuilS8C_l_Q4hcWzAntCupw6ySHu1JGSv06YfW1Q01YbXFuKIDQ-AbyRk_q7hteQzIb07nK0gJtceZM9F-G_aB4.; _T_WM=3e357b698836f1d3b5c126c4bf9138fc; SUB=_2A252S4HwDeRhGeBL61cS8S_Nyj-IHXVVty-4rDV6PUJbkdBeLW6kkW1NR06S8mnW27rUMebk6dSAlGJF-6SmrL7N; SUHB=0d4-eYtAjaj-SH',
        'user-agent':'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.99 Safari/537.36'
        }

#请求参数，其意义分别是启用高级搜索，关键词，是否原创，起始时间，结束时间，排序方式热门，页数控制
#特别的改变参数page的大小就可以得到每一页搜索的源代码
payload = {
        'advancedfilter':'1',
        'keyword':'冬奥会 女子3000米',
        'hasori':'1',
        'starttime':'20180220',
        'endtime':'20180301',
        'sort':'hot',
        'smblog':'搜索',
        'page':1
        }

for k in range(1,21):
    #利用post方法请求页面得到每一个页面的源代码
    payload['page'] = k
    r = requests.post(url, headers=headers, data=payload)
    html = r.content
    #使用beautifulsoup对页面加以解析
    soup = BeautifulSoup(html, 'html.parser')
    tweet_list = soup.find_all(name='div', attrs={'class':'c', 'id':True})
    for tweet in tweet_list:
        bid,uid,uname,cont,btime,d_num,r_num,c_num = info_separate(tweet)
        sheet.write(row, col, bid)
        col += 1
        sheet.write(row, col, uid)
        col += 1
        sheet.write(row, col, uname)
        col += 1
        sheet.write(row, col, cont)
        col += 1
        sheet.write(row, col, btime)
        col += 1
        sheet.write(row, col, r_num)
        col += 1
        sheet.write(row, col, d_num)
        col += 1
        sheet.write(row, col, c_num)
        col = 0
        row += 1
        book_wr.save(r'content1.xls')
        del bid,uid,uname,cont,btime,d_num,r_num,c_num
        gc.collect()
    del tweet_list, soup, html, r
    gc.collect
    time.sleep(3)
    print('page '+str(k)+' has done')
    
    
    
