from django.test import TestCase
from unittest import mock
from graphs import create

class TestLineChartCreate(TestCase):

	def setUp(self):
		self.obj = create.linechart()
		self.lockto = 'fieldname'
		self.y_val = [['val',1,2,3,4]]
		self.xlabel = 'x-label'
		self.ylabel = 'y-label'
		self.label= ['val']
		self.values = [[1,2,3,4]]
		self.body = {
			'bindto': '#fieldname',
			'data': {
				'columns':
					[['val',1,2,3,4]],
				'type': 'spline'
				},
			'axis': {
				'x': {
		            'label': {
		                'text': 'x-label',
		                'position': 'outer-center'
		            }
		        },
		        'y': {
		            'label': {
		                'text': 'y-label',
		                'position': 'outer-middle'
		            }
		        }
			},
		}
	def test_linechart_plot(self):
		self.assertEqual(self.obj.plot(self.lockto,self.y_val,self.xlabel,self.ylabel), self.body)

	def test_linechart_data_plot(self):
		self.assertEqual(create.data_plot(self.lockto, 'linechart', self.values, self.label, self.xlabel,self.ylabel),self.body)

class TestPieChart(TestCase):

	def setUp(self):
		self.obj = create.piechart()
		self.lockto = 'fieldname'
		self.data = [['val',20],['val2',30]]
		self.values = [20,30]
		self.label = ['val','val2']
		self.body = {
			'bindto': '#fieldname',
			'data': {
				'columns':
					[['val',20],['val2',30]],
				'type': 'pie',
				'onclick': 'function (d, i) { console.log("onclick", d, i); }',
	        	'onmouseover': 'function (d, i) { console.log("onmouseover", d, i); }',
	        	'onmouseout': 'function (d, i) { console.log("onmouseout", d, i); }'
	    	}
		}
	def test_piechart_plot(self):
		self.assertEqual(self.obj.plot(self.lockto,self.data),self.body)

	def test_piechart_data_plot(self):
		self.assertEqual(create.data_plot(self.lockto, 'piechart', self.values, self.label),self.body)

class TestbarGraph(TestCase):

	def setUp(self):
		self.obj = create.bargraph()
		self.lockto = 'fieldname'	
		self.data = [['val',1,2,3]]
		self.values = [[1,2,3]]
		self.label = ['val']
		self.xlabel = 'x-label'
		self.ylabel = 'y-label'
		self.xcat = ['title1','title2','title3']
		self.body ={
				'bindto': '#fieldname',
				'data': {
				'x': 'x',
		        'columns': [
		        	['x','title1','title2','title3'],
		        	['val',1,2,3]
		        ],
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
		                'text': 'x-label',
		                'position': 'outer-center'
		            },
		            'type': 'category',  	            
		        },
		        'y': {
		            'label': {
		                'text': 'y-label',
		                'position': 'outer-middle'
		            }
		        }
			}
		}

	def test_bargraph_plot(self):
		self.assertEqual(self.obj.plot(self.lockto,self.data,self.xlabel,self.ylabel,self.xcat),self.body)

	def test_bargraph_data_plot(self):
		self.assertEqual(create.data_plot(self.lockto, 'bargraph', self.values, self.label, self.xlabel,self.ylabel,self.xcat),self.body)
