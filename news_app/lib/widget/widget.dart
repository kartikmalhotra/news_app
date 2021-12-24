import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/bloc/news_bloc.dart';
import 'package:news_app/shared/model/model.dart';

class AppCard extends StatelessWidget {
  final double height;
  final double width;
  final Articles article;
  final VoidCallback callback;

  const AppCard({
    Key? key,
    required this.article,
    required this.height,
    required this.width,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(width: 0.2, color: Colors.grey),
        ),
        height: height,
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
                child: Stack(
                  children: <Widget>[
                    Image.network(
                      "${article.urlToImage}",
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
                    Align(
                      alignment: Alignment(0.9, -0.9),
                      child: FavourateIcon(article: article),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 10.0, 12.0, 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      article.title ?? "",
                      maxLines: 4,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 10),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              article.author ?? "",
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
                            article.displayPublishedAt ?? "",
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.indigoAccent),
                          )
                        ],
                      ),
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

class FavourateIcon extends StatefulWidget {
  final Articles article;

  const FavourateIcon({Key? key, required this.article}) : super(key: key);

  @override
  _FavourateIconState createState() => _FavourateIconState();
}

class _FavourateIconState extends State<FavourateIcon> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      disabledColor: Colors.indigoAccent,
      onPressed: () {
        setState(() {
          widget.article.favourate = !widget.article.favourate;
          BlocProvider.of<NewsBloc>(context)
              .add(FavourateIconTappedEvent(article: widget.article));
        });
      },
      icon: Icon(
        widget.article.favourate
            ? Icons.favorite
            : Icons.favorite_outline_sharp,
        color: widget.article.favourate ? Colors.pinkAccent : Colors.white,
      ),
    );
  }
}

class AppCircularProgressLoader extends StatelessWidget {
  final double? value;

  const AppCircularProgressLoader({Key? key, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: Colors.indigoAccent,
      value: value,
    );
  }
}
