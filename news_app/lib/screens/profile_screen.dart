import 'package:flutter/material.dart';
import 'package:news_app/widget/widget.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _drawUserProfileImage(),
          _showUserDescription(),
        ],
      ),
    );
  }

  Widget _drawUserProfileImage() {
    return Column(
      children: [
        Container(
          height: 300,
          width: double.maxFinite,
          child: Image.network(
            "https://images.unsplash.com/photo-1577975882846-431adc8c2009?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MjZ8fGJveXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60",
            fit: BoxFit.fill,
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
      ],
    );
  }

  Widget _showUserDescription() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Name", style: Theme.of(context).textTheme.headline6),
              ],
            ),
          ),
          Divider(color: Colors.black, thickness: 0.3),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _showNumberText("2", "posts"),
                _showNumberText("5 M", "followers"),
                _showNumberText("5 K", "following"),
              ],
            ),
          ),
          Divider(color: Colors.black, thickness: 0.3),
        ],
      ),
    );
  }

  Widget _showNumberText(String number, String text) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "$number",
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Text(
          "$text",
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
