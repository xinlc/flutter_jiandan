import 'dart:async';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {

  TextStyle textStyle = new TextStyle(
    color: Colors.blue,
    decoration: new TextDecoration.combine([TextDecoration.underline])
  );

  Future<Null> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false, forceWebView: false);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget _buildAuthorLink() {
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('作者：'),
            Text( 'Leo', style: textStyle,),
          ],
        ),
      ),
      onTap: () {
        _launchInBrowser('https://xinlc.github.io');
      },
    );
  }

  Widget _buildGithubLink() {
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('GitHub：'),
            Text('https://github.com/xinlc', style: textStyle,),
          ],
        ),
      ),
      onTap: () {
        _launchInBrowser('https://github.com/xinlc');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('关于', style: new TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              width: 1.0,
              height: 50.0,
              color: Colors.transparent,
            ),
            _buildAuthorLink(),
            _buildGithubLink(),
            Container(
              margin: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
              child: Text('基于Google Flutter的高仿煎蛋客户端'),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
              child: Text('本项目仅供学习使用', style: TextStyle(fontSize: 12.0))
            )
          ],
        ),
      ));
  }
}
