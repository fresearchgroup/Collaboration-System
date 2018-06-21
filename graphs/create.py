class linechart:
		
	def plot(self,lockto,y_val,xlabel='',ylabel='',displayheader = ''):
		y_val=list(y_val)
		body = {
			'bindto': '#'+lockto ,
			'data': {
				'columns':
					y_val,
				'type': 'spline'
				},
			'axis': {
				'x': {
		            'label': {
		                'text': xlabel,
		                'position': 'outer-center'
		            }
		        },
		        'y': {
		            'label': {
		                'text': ylabel,
		                'position': 'outer-middle'
		            }
		        }
			},

#			'tooltip': {
#		        'format': {
#		            'title': function (d) {' +displayheader+  '},
#		        }
#    		}
		}
		return body	

class piechart:
	def plot(self,lockto, data):
		data = list(list(data))
		body ={
			'bindto': '#'+lockto ,
			'data': {
				'columns': data,
				'type': 'pie',
				'onclick': 'function (d, i) { console.log("onclick", d, i); }',
	        	'onmouseover': 'function (d, i) { console.log("onmouseover", d, i); }',
	        	'onmouseout': 'function (d, i) { console.log("onmouseout", d, i); }'
	    	}
		}
		return body

class bargraph:
	def plot(self, lockto, data,xlabel='',ylabel='',xcat=[]):
		data=list(list(data))
		body = {
				'bindto': '#'+lockto,
				'data': {
				'x': 'x',
		        'columns': [['x']+xcat]+data,
		        'type': 'bar'
		    },
		    'bar': {
		        'width': {
		            'ratio': 0.5
		        }
		    },
		    'axis': {
				'x': {
		            'label': {
		                'text': xlabel,
		                'position': 'outer-center'
		            },
		            'type': 'category',  	            
		        },
		        'y': {
		            'label': {
		                'text': ylabel,
		                'position': 'outer-middle'
		            }
		        }
			}


		}
		return body

def data_plot(lockto, charttype, data, label, xlabel='',ylabel='',xcat=[],displayheader = ''):
	data = list(list(data))
	label = list(label) 
	if(len(label) != len(data)):
		print("[ERROR]: Number of labels and Number of items to be plotted do not match ")
		print(data)
		print(label)
		return None
	labeled_data = []
	
	if(charttype=='linechart'):
		obj = linechart()
		for i in range (0, len(label)):
			labeled_data.append([label[i]] + data[i])
		result = obj.plot(lockto,labeled_data,xlabel,ylabel)

	elif(charttype=='piechart'):
		obj = piechart()
		for i in range (0, len(label)):
			labeled_data.append([label[i]] + [data[i]])
		result = obj.plot(lockto,labeled_data)
	
	elif(charttype=='bargraph'):
		obj = bargraph()
		for i in range (0, len(label)):
			labeled_data.append([label[i]] + data[i])
		result = obj.plot(lockto,labeled_data,xlabel,ylabel,xcat)
	
	return result
