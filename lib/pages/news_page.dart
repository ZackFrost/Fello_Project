///Created by Ian Paul on 1-08-2021 22:50
import 'package:fello_demo_app/components/custom_logo.dart';
import 'package:fello_demo_app/components/news_list_item.dart';
import 'package:fello_demo_app/models/news.dart';
import 'package:fello_demo_app/models/response/news_response.dart';
import 'package:fello_demo_app/services/news_service.dart';
import 'package:fello_demo_app/utils/color_utils.dart';
import 'package:fello_demo_app/utils/common_utils.dart';
import 'package:flutter/material.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  var _scrollController = ScrollController();
  List<News> _newsList = [];
  bool _isLoading = false;
  int _totalResults = 0;
  int _pageNo = 1;
  int _pageSize = 10;

  @override
  void initState() {
    requestNews();
    super.initState();
  }

  void requestNews() async {
    setState(() {
      _isLoading = true;
    });

    NewsResponse _response = await NewsService().fetchNews(pageNo: _pageNo, pageSize: _pageSize);
    if (_response.status == "ok") {
      _totalResults = _response.totalResults ?? 0;
      if (_response.articles != null && _response.articles!.isNotEmpty) {
        _newsList.addAll(_response.articles!);
      }
    } else {
      CommonUtils.showSnackBar(context, "${_response.status}");
    }

    if (mounted)
      setState(() {
        _isLoading = false;
      });
  }

  bool _onScroll(dynamic notification) {
    if (notification is ScrollEndNotification) {
      var scrollPosition = _scrollController.position;
      if (scrollPosition.pixels == scrollPosition.maxScrollExtent && _totalResults > _newsList.length) {
        _pageNo += 1;
        requestNews();
      }
    }
    return true;
  }

  Widget _getNoDataWidget() {
    return Align(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(image: AssetImage("assets/no_data.png"), width: 140),
          Padding(
            padding: const EdgeInsets.only(top: 14.0),
            child: Text("No headlines to show"),
          )
        ],
      ),
    );
  }

  Widget _getLoadingWidget() {
    return Center(
      child: Container(
          margin: EdgeInsets.only(bottom: 10),
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 3,
            valueColor: AlwaysStoppedAnimation<Color>(COOL_PURPLE),
          )),
    );
  }

  Widget _getNewsBottomSheetBody(News news){
    TextStyle _style = TextStyle(fontSize: 12);

    return Container(
      color: BACKGROUND_COLOR,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (news.urlToImage != null)
            Container(
                width: CommonUtils().getDeviceWidth(context),
                height: CommonUtils().getDeviceHeight(context, percentage: 24),
                child: Image.network(
                  news.urlToImage!,
                  fit: BoxFit.cover,
                )),
          Padding(
            padding: EdgeInsets.all(17),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  news.title!,
                  style: _style.copyWith(fontWeight: FontWeight.w600, fontSize: 15),
                ),
                SizedBox(
                  height: 8,
                ),
                if(news.description != null)
                Text(
                  news.description!,
                  style: _style.copyWith(color: Colors.black54),
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 15,
                ),
                RichText(
                  text: TextSpan(
                    text: "Read full article Here : ", style: _style.copyWith(color: Colors.black38),
                    children: [
                      TextSpan(text: "${news.url}", style: _style.copyWith(color: Colors.blue))
                    ]
                ),)
              ],
            ),
          )
        ],
      ),
    );
  }

  void _onNewsItemClicked(News news) {
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return _getNewsBottomSheetBody(news);
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: BACKGROUND_COLOR,
        body: NotificationListener(
          onNotification: _onScroll,
          child: Container(
            width: CommonUtils().getDeviceWidth(context),
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomLogo(),
                Container(
                  margin: EdgeInsets.only(top: 10, bottom: 20, left: 5),
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Top Headlines",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ),
                Flexible(
                  child: (_newsList.isNotEmpty)
                      ? ListView.builder(
                          physics: BouncingScrollPhysics(),
                          controller: _scrollController,
                          itemCount: _newsList.length,
                          itemBuilder: (context, index) {
                            return NewsListItem(
                              news: _newsList[index],
                              onTap: _onNewsItemClicked,
                            );
                          })
                      : (!_isLoading)
                          ? _getNoDataWidget()
                          : _getLoadingWidget(), //To show loading only when page is initialized
                ),
                if (_newsList.isNotEmpty && _isLoading) _getLoadingWidget()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
