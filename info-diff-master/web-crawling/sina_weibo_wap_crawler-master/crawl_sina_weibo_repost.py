# -*- coding: utf-8 -*-
"""
Created on Mon Mar 12 16:23:43 2018

@author: Administrator
"""

import requests
from bs4 import BeautifulSoup

import xlrd
import xlwt

import time
import re

import gc

headers ={
        'Cookie':'your own',
        'User-Agent':'your own'
        }


book_wr = xlwt.Workbook(encoding='utf-8', style_compression=0)
sheet = book_wr.add_sheet('test',cell_overwrite_ok=True)

row = 0
col = 0
sheet.write(row, col, '微博索引')
col+=1
sheet.write(row, col, '评论者ID')
col += 1
sheet.write(row, col, '评论者用户名')
col += 1
sheet.write(row, col, '时间（月）')
col+=1
sheet.write(row, col, '时间（日）')
col+=1
sheet.write(row, col, '时间（时）')
col += 1
sheet.write(row, col, '时间（分）')
col += 1
sheet.write(row, col, '转发链')
row += 1
col = 0

post_url = '&page='

def get_repost(pre_url, index):
#    对转发页做请求
    global row, col, sheet,book_wr
    res = requests.get(pre_url, headers = headers)
    html = res.content
    soup = BeautifulSoup(html, 'html.parser')
#    根据所有的<span class="ct">标签来判断这条微博的转发数据能否被获取,如果转发首页只有一个时间的话就说明所有的转发被屏蔽无法爬取
    time_list = soup.find_all('span', attrs={'class':'ct'})
    time_list_len = len(time_list)
    if time_list_len > 1:
#        获取页数
        page_num_node = soup.find('div', attrs={'class':'pa','id':'pagelist'})
        if not page_num_node is None:
            page_num_text = page_num_node.text
            page_num = int(re.search('1/(?P<num>\d*)\u9875', page_num_text).group('num'))
            del page_num_text
            gc.collect()
        else:
            page_num = 1
#        首先爬取首页评论数据
        repost_node = []
#        获取全部的评论节点
        for k in range(time_list_len):
            if k != 0:
                repost_node.append(time_list[k].parent)
#                从节点中提取信息并写入excel中
        for node in repost_node:
            sheet.write(row, col, index)
            col += 1
            uid = re.split('/',node.a.attrs['href'])[-1]
            sheet.write(row, col, uid)
            col += 1
            content_text_list = re.split('//@',node.text)
            content_text_list_len = len(content_text_list)
            if content_text_list_len == 1:
#                这条转发是从原微博直接转发来的
                m = re.search('\]?(?P<name>.*):.*\]\s(?P<month>\d{1,2})\u6708(?P<day>\d{1,2})\u65e5\s(?P<hour>\d{1,2}):(?P<min>\d{1,2})',content_text_list[0])
                if not m is None:
                    sheet.write(row, col, m.group('name'))
                    col += 1
                    sheet.write(row, col, m.group('month'))
                    col += 1
                    sheet.write(row, col, m.group('day'))
                    col += 1
                    sheet.write(row, col, m.group('hour'))
                    col += 1
                    sheet.write(row, col, m.group('min'))
                    col = 0
                    row += 1
                    del m
                    gc.collect()
            else:
#                这条转发是看到其他用户转发而来的，先从最后一项中提取时间用户名信息
                wb_time = re.search('\]\s(?P<month>\d{1,2})\u6708(?P<day>\d{1,2})\u65e5\s(?P<hour>\d{1,2}):(?P<min>\d{1,2})',content_text_list[-1])
                for k in range(content_text_list_len):
                    if k == 0:
                        m = re.search('\]?(?P<name>.*):',content_text_list[k])
                        if not m is None:
                            sheet.write(row, col, m.group('name'))
                            col += 1
                            sheet.write(row, col, wb_time.group('month'))
                            col += 1
                            sheet.write(row, col, wb_time.group('day'))
                            col += 1
                            sheet.write(row, col, wb_time.group('hour'))
                            col += 1
                            sheet.write(row, col, wb_time.group('min'))
                            col += 1
                            del m
                            gc.collect()
                    else:
                        m = content_text_list[k].split(':')
#                        m = re.search('\]?(?P<name>.*):',content_text_list[k])
                        sheet.write(row, col, m[0])
                        col += 1
                        del m
                        gc.collect()
                del wb_time
                gc.collect()
                col = 0
                row += 1
            del uid,content_text_list,content_text_list_len
            gc.collect()
        del repost_node,page_num_node,time_list_len,time_list,soup,html,res
        gc.collect()
        if page_num > 1:
#            如果评论的数据不止一页，那么从第二页开始爬取所有评论
            page_count = 10243
            while page_count<=page_num:
#                从第二页开始的爬取操作
                print('page now is %d' % page_count)
                time.sleep(10)
#                请求网络之前保存已经写入的数据
                book_wr.save(r'e:\test_repost_2.xls')
                url = pre_url + post_url + str(page_count)
                res = requests.get(url, headers = headers)
                html = res.content
                soup = BeautifulSoup(html, 'html.parser')
                time_list = soup.find_all('span', attrs={'class':'ct'})
                repost_node = []
                for time_node in time_list:
                    repost_node.append(time_node.parent)
                re_count = 1
                for node in repost_node:
                    print('repost now is %d' % re_count)
                    sheet.write(row, col, index)
                    col += 1
                    uid = re.split('/',node.a.attrs['href'])[-1]
                    sheet.write(row, col, uid)
                    col += 1
                    content_text_list = re.split('//@',node.text)
                    content_text_list_len = len(content_text_list)
                    if content_text_list_len == 1:
#                   这条转发是从原微博直接转发来的
                        m = re.search('\]?(?P<name>.*):.*\]\s(?P<month>\d{1,2})\u6708(?P<day>\d{1,2})\u65e5\s(?P<hour>\d{1,2}):(?P<min>\d{1,2})',content_text_list[0])
                        if not m is None:
                            sheet.write(row, col, m.group('name'))
                            col += 1
                            sheet.write(row, col, m.group('month'))
                            col += 1
                            sheet.write(row, col, m.group('day'))
                            col += 1
                            sheet.write(row, col, m.group('hour'))
                            col += 1
                            sheet.write(row, col, m.group('min'))
                            col = 0
                            row += 1
                            del m
                            gc.collect()
                    else:
#                   这条转发是看到其他用户转发而来的，先从最后一项中提取时间用户名信息
                        wb_time = re.search('\]\s(?P<month>\d{1,2})\u6708(?P<day>\d{1,2})\u65e5\s(?P<hour>\d{1,2}):(?P<min>\d{1,2})',content_text_list[-1])
                        for k in range(content_text_list_len):
                            if k == 0:
                                m = re.search('\]?(?P<name>.*):',content_text_list[k])
                                if not m is None:                                  
                                    sheet.write(row, col, m.group('name'))
                                    col += 1
                                    sheet.write(row, col, wb_time.group('month'))
                                    col += 1
                                    sheet.write(row, col, wb_time.group('day'))
                                    col += 1
                                    sheet.write(row, col, wb_time.group('hour'))
                                    col += 1
                                    sheet.write(row, col, wb_time.group('min'))
                                    col += 1
                                    del m
                                    gc.collect()
                            else:
#                                m = re.search('\]?(?P<name>.*)[:\uff1a]',content_text_list[k])
#                                if not m is None:
#                                    sheet.write(row, col, m.group('name'))
#                                    col += 1
#                                    del m
#                                    gc.collect()
                                m = content_text_list[k].split(':')
                                sheet.write(row, col, m[0])
                                col += 1
                                del m
                                gc.collect()
                        col = 0
                        row += 1
                        del wb_time
                        gc.collect()
                    del content_text_list_len,content_text_list,uid
                    gc.collect
                    re_count += 1
                del repost_node,time_list,soup,html,res,url,re_count
                gc.collect
                page_count += 1
        else:
            time.sleep(10)
    else:
        time.sleep(10)
    return        

pre_url = 'https://weibo.cn/repost/G4k6cbrYI?uid=2656274875&rl=1'
#print('weibo now is %d' % 131)
get_repost(pre_url, 2)
            
book_wr.save(r'e:\test_repost_2.xls')