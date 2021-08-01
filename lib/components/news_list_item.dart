///Created by Ian Paul on 1-08-2021 23:15
import 'package:fello_demo_app/models/news.dart';
import "package:flutter/material.dart";

class NewsListItem extends StatelessWidget {
  final News news;
  final ValueSetter<News> onTap;
  const NewsListItem({Key? key, required this.news, required this.onTap}) : super(key: key);

  String _getArticlePostedTime(DateTime time){
    bool _isPastNoon = time.hour > 12;
    String _time = "";
    _time = "${time.hour}";
    _time += "${ (time.minute > 0) ? ":${time.minute} " : ""}"; //Show minutes only if its greater than 0
    _time += "${_isPastNoon? "pm":"am"}";

    return _time;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>  onTap(news),
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if(news.urlToImage != null)
            ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(
                  news.urlToImage!,
                  width: 67,
                  height: 67,
                  fit: BoxFit.cover,
                )),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      news.title ?? "",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Text("${news.source?.name ?? ""} ", style: TextStyle(fontSize: 10, color: Colors.black45), overflow: TextOverflow.ellipsis),
                        SizedBox(width: 4),
                        Text(_getArticlePostedTime(news.publishedAt ?? DateTime(2021)), style: TextStyle(fontSize: 10, color: Colors.black54), overflow: TextOverflow.ellipsis,),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
