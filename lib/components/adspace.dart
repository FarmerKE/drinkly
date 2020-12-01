import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AdSpace extends StatelessWidget {
  final String url;
  final String imageURL;

  const AdSpace({
    Key key,
    @required this.url,
    @required this.imageURL,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('Ad link tapped');
        launch(url);
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.3,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
        ),
        child: Stack(
          children: [
            Container(
              alignment: Alignment.center,
              child: Image.asset(
                imageURL,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              height: 20,
              width: 25,
              alignment: Alignment.topLeft,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Center(
                child: Text(
                  'ad',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
