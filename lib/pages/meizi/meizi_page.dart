import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_jiandan/models/meizi.dart';
import 'package:flutter_jiandan/pages/meizi/meizi_grid_item.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_jiandan/redux/app/app_state.dart';
import 'package:flutter_jiandan/pages/meizi/meizi_page_view_model.dart';
import 'package:flutter_jiandan/widgets/loading_view.dart';
import 'package:flutter_jiandan/widgets/platform_adaptive_progress_indicator.dart';
import 'package:flutter_jiandan/widgets/info_message_view.dart';


class MeiziPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, MeiziPageViewModel>(
      converter: (store) => MeiziPageViewModel.fromStore(store),
      builder: (_, viewModel) => MeiziPageContent(viewModel),
    );
  }
}

class MeiziPageContent extends StatelessWidget {
  MeiziPageContent(this.viewModel) {
    _controller.addListener(() {
      var maxScroll = _controller.position.maxScrollExtent;
      var pixels = _controller.position.pixels;

      if (maxScroll == pixels && viewModel.curPage < viewModel.pageCount) {
        // scroll to bottom, get next page data
        print('load more ... ');
        viewModel.loadMore();
      }
    });
  }
  final MeiziPageViewModel viewModel;
  ScrollController _controller = ScrollController();

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

  Future<Null> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false, forceWebView: false);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    var crossAxisChildCount = isPortrait ? 2 : 4;

    print('1111111111');
    print(viewModel.curPage);
    return LoadingView(
      onMount: viewModel.refresh,
      status: viewModel.status,
      loadingContent: const PlatformAdaptiveProgressIndicator(),
      errorContent: ErrorView(
        description: 'Error loading meizi list.',
        onRetry: viewModel.refresh,
      ),
      successContent: Container(
        child: RefreshIndicator(
          child: Scrollbar(
            child: GridView.builder(
              controller: _controller,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisChildCount,
                childAspectRatio: 2 / 3,
              ),
              itemCount: viewModel.meiziList.length,
              itemBuilder: (BuildContext context, int index) {
                var meizi = viewModel.meiziList[index];
                return MeiziGridItem(
                  meizi: meizi,
                  onTapped: () => _openDetails(context, meizi),
                );
              },
            ),
          ),
          onRefresh: viewModel.refresh,
        )
      ),
    );
  }
}