import 'package:flutter/material.dart';
import 'package:flutter_jiandan/pages/meizi/meizi_page.dart';
import 'package:flutter_jiandan/pages/about/about_page.dart';

class MyDrawer extends StatelessWidget {
  static const double IMAGE_ICON_WIDTH = 30.0;
  static const double ARROW_ICON_WIDTH = 16.0;
  var rightArrowIcon = new Image.asset(
    'assets/images/ic_arrow_right.png',
    width: ARROW_ICON_WIDTH,
    height: ARROW_ICON_WIDTH,
  );
  List<String> menuTitles = ['妹子', '无聊', '段子', '关于'];
  TextStyle menuStyle = new TextStyle(
    fontSize: 18.0,
  );

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints.expand(width: 300.0),
      child: Material(
        elevation: 16.0,
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
          ),
          child: ListView.builder(
            itemCount: menuTitles.length * 2 + 1,
            itemBuilder: renderRow,
          ),
        ),
      ),
    );
  }

  Widget renderRow(BuildContext context, int index) {
    if (index == 0) {
      // render cover image
      var img = Image.asset(
        'assets/images/cover_img.jpg',
        width: 300.0,
        height: 300.0,
      );
      return Container(
        width: 300.0,
        height: 300.0,
        margin: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
        child: img,
      );
    }

    index -= 1;
    if (index.isOdd) {
      return new Divider();
    }

    index = index ~/ 2;

    var listItemContent = Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text( menuTitles[index], style: menuStyle, )
          ),
          rightArrowIcon
        ],
      ),
    );

    return InkWell(
      child: listItemContent,
      onTap: () {
        switch (index) {
          case 0:
            print('meizi');
            break;
          case 1:
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return AboutPage();
            }));
            break;
          case 2:
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return AboutPage();
            }));
            break;
          case 3:
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return AboutPage();
            }));
            break;
        }
      },
    );
  }
}
