import 'dart:async';
import 'dart:convert';

import 'package:flutter_jiandan/constants/api.dart';
import 'package:flutter_jiandan/models/meizi.dart';
import 'package:flutter_jiandan/utils/http_utils.dart';

class MeiziApi {
  Future<Map<String, dynamic>> fetchMeiziList(int page) async {
    Map<String, dynamic> map = {};
    List<Meizi> list = [];
    int pageCount = 1;
    String url = Api.MEIZI_LIST.replaceFirst('@page', page.toString());

    print('meizi_list_url -> $url');

    var data = await HttpUtils.get(url); 
    if (data != null) {
      Map<String, dynamic> map = json.decode(data);
      pageCount = map['page_count'];
      var comments = map['comments'];
      for (var comment in comments) {
        var pics = comment['pics'];
        Meizi meizi = new Meizi(title: comment['comment_date'].toString(), url: pics[0]);
        list.add(meizi);
      }
    }
    map['list'] = list;
    map['pageCount'] = pageCount;
    return map;
  }
}