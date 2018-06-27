from . import settings
import datetime
import django
from . import exceptions
from .essearch import SearchElasticSearch
from .. import utils
import elasticsearch

LOG_CLASS = "API-HELPERS"

def custom_time_now():
    return datetime.datetime.now()

def extract_time_keys(request):
    delta = 10
    dic = {}
    tm = None
    bef_tm = None
    try:
        val = dict(request.GET)['before'][0]
        tm = datetime.datetime.strptime(val, '%Y-%m-%dT%H:%M:%S')
        bef_tm = tm
        tm = tm.strftime('%Y-%m-%d %H:%M:%S')
    except KeyError as e:
        tm = custom_time_now()
        bef_tm = tm
        tm = tm.strftime('%Y-%m-%d %H:%M:%S')
    except ValueError as e:
        raise exceptions.BadTimeFormat
    dic['before'] = tm
    tm = None
    #utils.ilog(LOG_CLASS, "Before time is: {!s}".format(bef_tm), mode="DEBUG")
    try:
        val = dict(request.GET)['after'][0]
        tm = datetime.datetime.strptime(val, '%Y-%m-%dT%H:%M:%S')
        tm = tm.strftime('%Y-%m-%d %H:%M:%S')
    except KeyError as e:
        tm = (bef_tm - datetime.timedelta(days = delta)).strftime('%Y-%m-%d %H:%M:%S')
    except ValueError as e:
        raise exceptions.BadTimeFormat
    dic['after'] = tm
    return dic 

def extract_field_keys(request):
    dic = {'fields': []}
    to_check = settings.OUTTER_KEYS
    to_check.append('event')
    try:
        val = dict(request.GET)['fields']
        dic['fields'] = val
    except KeyError as e:
        for key in settings.OUTTER_KEYS:
            dic['fields'].append(key)
        dic['fields'].append('event')
    for key in dic['fields']:
        if key not in to_check:
            dic['fields'].remove(key)
    dic['fields'] = list(set(dic['fields']))
    return dic

def extract_paging_keys(request):
    dic = {}
    try:
        val = int(dict(request.GET)['start'][0])
        dic['from'] = val
    except KeyError as e:
        dic['from'] = 0

    try:
        val = int(dict(request.GET)['limit'][0])
        dic['size'] = val if val <= settings.MAX_PAGE_SIZE else settings.MAX_PAGE_SIZE
    except KeyError as e:
        dic['size'] = settings.PAGE_SIZE
    return dic

def extract_sorting_keys(request):
    dic= {
            'sort_keys': []
        }
    try:
        val = dict(request.GET)['sort']
        #utils.ilog(LOG_CLASS, "Sort keys are: {!s}".format(val), mode="DEBUG")
        for skey in val:
            #utils.ilog(LOG_CLASS, "parsing the sort strings: {!s}".format(skey), mode="DEBUG")
            skey = skey.strip()
            if skey[0] == '-':
                dic['sort_keys'].append({
                        '{!s}'.format(skey[1:]): 'desc'
                    })
            else:
                dic['sort_keys'].append({
                        '{!s}'.format(skey): 'asc'
                    })
    except KeyError as e:
        dic['sort_keys'].append({'time-stamp': 'desc'})
    return  dic

def extract_filter_keys(request):
    dic = {
            'filter_keys':[]
          }
    for key in settings.OUTTER_KEYS:
        try:
            val = dict(request.GET)[key]
            dic['filter_keys'].append({
                key: val,
                })
        except KeyError as e:
            continue
    for key in settings.INNER_KEYS:
        try:
            val = request.GET[key]
            dic['filter_keys'].append({
                key: val
                })
        except:
            continue
    return dic

def extract_aggregate_key(request):
    dic = {
            "agg_keys": []
        }
    aggs_type = []
    aggs_field = []
    try:
        aggs_type = dict(request.GET)['agg_type']
        aggs_field = dict(request.GET)['agg_field']
    except KeyError as ve:
        pass
    if len(aggs_type) != len(aggs_field):
        raise IndexError
    elif len(aggs_type) > 1:
        raise exceptions.MutlipleAggregationUnsupported
    for key1, key2 in zip(aggs_type, aggs_field):
        if key1 in settings.AGGREGATE_FUNCS:
            dic['agg_keys'].append({
                key2: key1
            })
    return dic

def make_request_body(request, data):
    #utils.ilog(LOG_CLASS, "request_keys are {!s}".format(data), mode="DEBUG")
    final_dic = {}
    final_dic['request_keys'] = data

    # extracting the time stamps
    dic = extract_time_keys(request)
    final_dic['time_range'] = dic
    
    # extracting the paging keys
    dic = extract_paging_keys(request)
    final_dic['paging'] = dic
    
    # extracting the fields to include
    dic = extract_field_keys(request)
    final_dic['fields'] = dic['fields']

    # extracting the filters
    dic = extract_filter_keys(request)
    if dic['filter_keys']:
        final_dic['filter_keys'] = dic['filter_keys']

    # extracrting the sort keys
    dic = extract_sorting_keys(request)
    if dic['sort_keys']:
        final_dic['sort_keys'] = dic['sort_keys']

    
    dic = extract_aggregate_key(request)
    if dic['agg_keys']:
        final_dic['agg_keys'] = dic['agg_keys']

    return final_dic

def append_get_params(url, request):
    get_params = dict(request.GET)
    #utils.ilog(LOG_CLASS, "Got following params for get: {!s}".format(get_params), mode="DEBUG")
    url+="?"
    param_str_list = []
    for key in list(get_params.keys()):
        val = get_params[key]
        if isinstance(val, list):
            for v in val:
                param_str_list.append("{!s}={!s}".format(str(key).strip(), str(v).strip()))
        else:
            param_str_list.append("{!s}={!s}".format(str(key).strip(), str(val).strip()))
    param_str = "&".join(param_str_list)
    url += param_str
    #utils.ilog(LOG_CLASS, "URL formed is: {!s}".format(url))
    return url

def get_path(request):
    url = request.build_absolute_uri()
    url_without_params = url.split("?")[0]
    return url_without_params

def append_pagination(request, resp, page_keys, total_hits):
    cur = page_keys['from']
    limit = page_keys['size']
    prev_link = int(cur) - int(limit)
    next_link = int(cur) + int(limit)
    prev_limit = int(limit)
    next_limit = int(limit)
    #utils.ilog(LOG_CLASS, "Printing info: {!s} | {!s} | {!s} | {!s}".format(page_keys, total_hits, prev_link, next_link), mode="DEBUG")
    if next_link >= total_hits:
        next_link = None
    if prev_link < 0:
        prev_limit = prev_limit + prev_link
        prev_link = 0
    if cur == 0:
        prev_link = None
    if prev_link is not None:
        #utils.ilog(LOG_CLASS, "Running prev link ", mode="DEBUG")
        temp = None
        temp = request
        get = dict(temp.GET)
        get['start'] = prev_link
        get['limit'] = prev_limit
        temp.GET = get
        resp['prev_link'] = append_get_params(get_path(temp), temp)
    if next_link is not None:
        #utils.ilog(LOG_CLASS, "Running next link ", mode="DEBUG")
        temp = None
        temp = request
        get = dict(temp.GET)
        get['start'] = next_link
        get['limit'] = next_limit
        temp.GET = get
        resp['next_link'] = append_get_params(get_path(temp), temp)
    return resp


def append_key_value(resp, key, value):
    resp[key] = value
    return resp

def append_error_key_value(resp, key, value):
    try:
        resp['error'][key] = value
    except KeyError as e:
        resp = {
                "error":{

                    }
                }
        resp['error'][key] = value
    return resp

def handle_response(request, data):
    res = {}
    status_code = 200
    result = None
    try:
        data = make_request_body(request, data)
        utils.ilog(LOG_CLASS, "Returned data: {!s}".format(data), mode="DEBUG")
    except exceptions.BadTimeFormat as e:
        res = append_error_key_value(res, 'status code', 400)
        res = append_error_key_value(res, 'error msg', 'time not in format yyyy-mm-ddThh:mm:ss')
        status_code = 400
    except IndexError as e:
        res = append_error_key_value(res, 'status code', 400)
        res = append_error_key_value(res, 'error msg', 'aggregate type and aggregate fields are of different lengths')
        status_code = 400
    except exceptions.MutlipleAggregationUnsupported as e:
        res = append_error_key_value(res, 'status code', 501)
        res = append_error_key_value(res, "error message", "multiple aggregation and nested aggregation not implemented.")
        status_code = 501
    else:
        obj=SearchElasticSearch()
        try:
            result = obj.search_elasticsearch(data)
        except elasticsearch.ImproperlyConfigured as e:
            res = append_error_key_value(res, "status code", 400)
            res = append_error_key_value(res, "error message", "Improper configuration Error")    
            status_code = 400
        except elasticsearch.NotFoundError as e:
            res = append_error_key_value(res, "status code", 404)
            res = append_error_key_value(res, "error message", "Not Found Error")
            status_code = 404
        except elasticsearch.ConflictError as e:
            res = append_error_key_value(res, "status code", 409)
            status_code = 409
            res = append_error_key_value(res, "error message", "Conflict Error")
        except elasticsearch.RequestError as e:
            res = append_error_key_value(res, "status code", 500)
            res = append_error_key_value(res, "error message", "Request Error")
            status_code = 500
        except elasticsearch.ConnectionError as e:
            res = append_error_key_value(res, "status code", 400)
            res = append_error_key_value(res, "error message", "Connection Error occurred")
            status_code = 400
        except elasticsearch.TransportError as e:
            res = append_error_key_value(res, "status code", 400)
            res = append_error_key_value(res, "error message", "Error Raised by elasticsearch: {!s}".format(e.error))
            status_code = 400
        except elasticsearch.ElasticsearchException as e:
            res = append_error_key_value(res, "status code", 500)
            res = append_error_key_value(res, "error message", "Database Error")
            status_code = 500
        else:
        #utils.ilog(LOG_CLASS, "Returned value: {!s}".format(result), mode="ERROR")
            if 'status' in result.keys():
                res = append_pagination(request, res, data['paging'], result['total_hits'])
                res = append_key_value(res, 'status code', 200)
                res = append_key_value(res, 'total hits', result['total_hits'])
                res = append_key_value(res, 'result', result['logs'])
                status_code = 200
            else:
                res = append_error_key_value(res, 'status code', 500)
                res = append_error_key_value(res, 'error msg', "Database Error")
                status_code = 500
    return (res, status_code)

