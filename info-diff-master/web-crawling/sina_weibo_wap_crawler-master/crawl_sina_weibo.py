# -*- coding: utf-8 -*-
"""
Created on Tue Mar 13 15:27:30 2018

@author: Administrator
"""

import requests
from bs4 import BeautifulSoup
import gc
import time
import re
import xlwt

book = xlwt.Workbook(encoding='utf-8', style_compression=0)
sheet = book.add_sheet('test',cell_overwrite_ok=True)
row = 0
col = 0
sheet.write(row, col, '微博ID')
col += 1
sheet.write(row, col, '用户ID')
col += 1
sheet.write(row, col, '用户名')
col += 1
sheet.write(row, col, '内容')
col += 1
sheet.write(row, col, '时间（月）')
col += 1
sheet.write(row, col, '时间（日）')
col += 1
sheet.write(row, col, '时间（时）')
col += 1
sheet.write(row, col, '时间（分）')
col += 1
sheet.write(row, col, '赞数')
col += 1
sheet.write(row, col, '转发数')
col += 1
sheet.write(row, col, '转发链接')
col += 1
sheet.write(row, col, '评论数')
row += 1
col = 0


def get_delight(string):
    m = re.search('\u8d5e\[(?P<number>\d*)\]',string)
    if not m is None:
        return m.group('number')
    
def get_repost(string):
    m = re.search('\u8f6c\u53d1\[(?P<number>\d*)\]',string)
    if not m is None:
        return m.group('number')
    
def get_comment(string):
    m = re.search('\u8bc4\u8bba\[(?P<number>\d*)\]',string)
    if not m is None:
        return m.group('number')

def get_time(string):
    m = re.search('(?P<month>\d{1,2})\u6708(?P<day>\d{1,2})\u65e5\s(?P<hour>\d{1,2}):(?P<min>\d{1,2})',string)
    if not m is None:
        return int(m.group('month')), int(m.group('day')), int(m.group('hour')), int(m.group('min'))

headers ={
        'Cookie':'your own',
        'User-Agent':'your own'
        }

pre_url = 'https://weibo.cn/search/mblog?hideSearchFrame=&keyword=%E5%86%AC%E5%A5%A5%E4%BC%9A+%E6%AD%A6%E5%A4%A7%E9%9D%96+%E5%86%A0%E5%86%9B&advancedfilter=1&hasori=1&starttime=20180220&endtime=20180301&sort=hot&page='

count = 1

while count <= 29:
    url = pre_url + str(count)
    res = requests.get(url, headers=headers)
    data = res.content
    soup = BeautifulSoup(data, 'html.parser')
    blog_node_list = soup.find_all('div', attrs={'class':"c","id":True})
    #blog_data = []
    for node in blog_node_list:
#        info = {}
        sheet.write(row, col, node.attrs['id'])
        col += 1
#        info['blog_id'] = node.attrs['id']
        div_list = node.find_all('div')
        div_len = len(div_list)
        usr_node = node.find('a', attrs={'class':'nk','href':True})
#        info['blogger_id'] = re.split('/',usr_node.attrs['href'])[-1]
        sheet.write(row, col, re.split('/',usr_node.attrs['href'])[-1])
        col += 1
#        info['blogger'] = usr_node.string
        sheet.write(row, col, usr_node.string)
        col += 1
        content_node = node.find('span', attrs={'class':'ctt'})
#        info['content'] = content_node.text
        sheet.write(row, col, content_node.text)
        col += 1
        time_node = node.find('span', attrs={'class':'ct'})
        month, day, hour, minute = get_time(time_node.text)
#        info['month'] = month
#        info['day'] = day
#        info['hour'] = hour
#        info['minnute'] = minute
        sheet.write(row, col, month)
        col += 1
        sheet.write(row, col, day)
        col += 1
        sheet.write(row, col, hour)
        col += 1
        sheet.write(row, col, minute)
        col += 1
        if div_len == 1:
            check_node = div_list[0]
        else:
            check_node = div_list[1]
        a_list = check_node.find_all('a', attrs={'href':True})
        for ala in a_list:
            x = get_delight(ala.text)
            if not x:
                x = get_repost(ala.text)
                if not x:
                    x = get_comment(ala.text)
                    if x:
#                        info['comment'] = int(x)
                        sheet.write(row, col, int(x))
                        col += 1
                else:
#                    info['repost'] = int(x)
                    sheet.write(row, col, int(x))
                    col += 1
                    sheet.write(row, col, ala.attrs['href'])
                    col += 1
            else:
#                info['delight']= int(x)
                sheet.write(row, col, int(x))
                col += 1
#        blog_data.append(info)
        del div_list,div_len,usr_node,content_node,time_node,check_node,a_list,x,month,day,hour,minute
        gc.collect()
        col = 0
        row += 1
    del blog_node_list,soup,data,res,url
    gc.collect()
    print(count)
    count += 1
    time.sleep(5)

book.save(r'e:\test4.xls')

    
    
    
