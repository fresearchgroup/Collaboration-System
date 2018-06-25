import re
import requests 
import json
from itertools import groupby
from decouple import config
import datetime

url_basic = config('URL_BASIC')

def parse(data):
	data = list(data)
	date_list = []
	parse_date = []
	for i in range(0,len(data)):
		date_list.append(data[i]['time-stamp'])
		parse_date.append(re.split('-| |:',date_list[i]))
	return parse_date

def get_date(parse_date):
	parse_date = list(parse_date)
	date_list = []
	for i in range(0,len(parse_date)):
		date_list.append(int(parse_date[i][2])) # Change to month[1]/ date[2]
	return date_list

def find_distinct(date_list):
	date_list = list(date_list)
	dist = list(set(date_list))
	dist.sort()
	return dist

def find_frequency(date_list):
	date_list = list(date_list)
	frequency = [len(list(group)) for key,group in groupby(date_list)]
	return frequency

def create_plotdata(distinct_date, frequency):
	distinct_date=list(distinct_date)
	frequency= list(frequency)
	result = []
	temp = 0
	for i in range(0,max(distinct_date)+1):
		if(distinct_date[temp] == i):
			result.append(frequency[temp])
			temp = temp + 1
		else:
			result.append(0)
	return result

def view(id,resource):
	cur = datetime.datetime.now()
	diff = datetime.timedelta(days = 365)
	prev = (cur-diff).strftime("%Y-%m-%dT%H:%M:%S")
	url_api = url_basic+'logapi/event/'+resource+'/view/'+str(id)+'/?after='+prev
	res = requests.get(url_api)
	result = res.json()

	if ('status code' in list(result.keys()) and result["status code"] == 200):
		if (result["total hits"] == 0):
			print ("No data found")
			return [[]]

		while('next_link' in (result.keys())):
			res = requests.get(result['next_link'])
			intermediate = res.json()
			result['result'].append(intermediate['result'])

		data = result["result"]
		parse_date = parse(data)
		date_list = get_date(parse_date)
		date_list.sort()

		distinct_date = find_distinct(date_list)
		frequency = find_frequency(date_list)

		plot_data = create_plotdata(distinct_date,frequency)
		return [plot_data]
	else:
		print("Server Error")
		return [[]]
