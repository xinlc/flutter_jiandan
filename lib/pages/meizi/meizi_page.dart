import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_jiandan/models/meizi.dart';
import 'package:flutter_jiandan/pages/meizi/meizi_grid_item.dart';
import 'package:flutter_jiandan/utils/http_utils.dart';
import 'package:flutter_jiandan/constants/api.dart';
import 'package:url_launcher/url_launcher.dart';

class MeiziPage extends StatefulWidget {
  @override
  State<StatefulWidget>createState() => MeiziPageState();
}

class MeiziPageState extends State<MeiziPage> {
  List<Meizi> meiziList = [];
  int curPage = 1;
  int pageCount = 1;
  ScrollController _controller = ScrollController();

  MeiziPageState() {
    _controller.addListener(() {
      var maxScroll = _controller.position.maxScrollExtent;
      var pixels = _controller.position.pixels;

      if (maxScroll == pixels && curPage < pageCount) {
        // scroll to bottom, get next page data
        print('load more ... ');
        curPage ++;
        _fetchMeizi(true);
      }
    });
  }

  void _openDetails(BuildContext context, Meizi meizi) {
    _launchInBrowser(meizi.url);
//    showDialog(
//      context: context,
//      builder: (context) {
//        return AlertDialog(
//          title: Text('提示'),
//          content: Text('hello'),
//          actions: <Widget>[
//            FlatButton(
//              child: Text('确定'),
//              onPressed: () {
//                print('确定');
//                Navigator.of(context).pop();
//              },
//            ),
//          ],
//        );
//      }
//    );
  }

  void _fetchMeizi(bool isLoadMore) {
    String url = Api.MEIZI_LIST.replaceFirst('@page', curPage.toString());

    print('meizi_list_url -> $url');

    HttpUtils.get(url, (data) {
      if (data != null) {
        Map<String, dynamic> map = json.decode(data);
        var comments = map['comments'];

        setState(() {
          pageCount = map['page_count'];

          if (isLoadMore == false) {
            meiziList.clear();
          }

          for (var comment in comments) {
            var pics = comment['pics'];
            Meizi meizi = new Meizi(title: comment['comment_date'].toString(), url: pics[0]);
            meiziList.add(meizi);
          }
        });
      }
    });
  }

  Future<Null> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false, forceWebView: false);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<Null> _pullToRefresh() async {
    curPage = 1;
    _fetchMeizi(false);
    return null;
  }

  @override
  void initState() {
    super.initState();
    _fetchMeizi(false);
  }

  @override
  Widget build(BuildContext context) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    var crossAxisChildCount = isPortrait ? 2 : 4;

    return Container(
      child: RefreshIndicator(
        child: Scrollbar(
          child: GridView.builder(
            controller: _controller,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisChildCount,
              childAspectRatio: 2 / 3,
            ),
            itemCount: meiziList.length,
            itemBuilder: (BuildContext context, int index) {
              var meizi = meiziList[index];
              return MeiziGridItem(
                meizi: meizi,
                onTapped: () => _openDetails(context, meizi),
              );
            },
          ),
        ),
        onRefresh: _pullToRefresh,
      )
    );
  }
}