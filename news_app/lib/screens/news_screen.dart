import 'package:flutter/material.dart';
import 'package:news_app/config/screen_config.dart';
import 'package:news_app/shared/model/model.dart';
import 'package:news_app/widget/widget.dart';

class NewsDetailScreen extends StatelessWidget {
  final Articles articles;

  const NewsDetailScreen({Key? key, required this.articles}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppScreenConfig.screenHeight,
      width: AppScreenConfig.screenWidth,
      child: Column(
        children: [
          Expanded(
            child: Container(
              child: Image.network(
                "${articles.urlToImage}",
                fit: BoxFit.fitHeight,
                errorBuilder: (context, error, stackTrace) {
                  return Center(
                    child: AppCircularProgressLoader(),
                  );
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: AppCircularProgressLoader(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: AppScreenConfig.screenWidth,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 10.0, 12.0, 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      articles.title ?? "",
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Author",
                          style: Theme.of(context).textTheme.caption!.copyWith(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        Text(
                          "Date",
                          style: Theme.of(context).textTheme.caption!.copyWith(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        )
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            articles.author ?? "",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.indigoAccent),
                          ),
                        ),
                        Text(
                          articles.displayPublishedAt ?? "",
                          style: Theme.of(context).textTheme.caption!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.indigoAccent),
                        )
                      ],
                    ),
                    SizedBox(height: 30),
                    Text(
                      articles.content ?? "",
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Colors.black87, fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
