import 'package:flutter/material.dart';

class JobDetailPage extends StatefulWidget {
  const JobDetailPage({Key? key}) : super(key: key);

  @override
  _JobDetailPageState createState() => _JobDetailPageState();
}

class _JobDetailPageState extends State<JobDetailPage> {
  String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

    return htmlText.replaceAll(exp, '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [],
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Icon(Icons.arrow_back, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
              child: Column(children: [
            Center(
              child: CircleAvatar(
                radius: 50,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Wrap(
              direction: Axis.vertical,
              children: [
                Text(
                  "Company name",
                  style: TextStyle(fontSize: 30),
                ),
                Text(
                  "Company name",
                  style: TextStyle(fontSize: 30),
                ),
              ],
            ),
          ])),
        ));
  }
}
