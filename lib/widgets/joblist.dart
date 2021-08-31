import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class JobList extends StatefulWidget {
  // final AsyncSnapshot<Map<String, dynamic>> snapshot;
  final List<dynamic> snapshot;
  JobList({required this.snapshot});
  // const JobList({Key? key}) : super(key: key);

  @override
  _JobListState createState() => _JobListState();
}

class _JobListState extends State<JobList> {
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    widget.snapshot.sort((a, b) {
      return DateTime.parse(a['publication_date'])
          .compareTo(DateTime.parse(b['publication_date']));
    });
  }

  String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

    return htmlText.replaceAll(exp, '');
  }

  @override
  Widget build(BuildContext context) {
    print("Cllled joblist.dart");
    // print(widget.snapshot[0]['publication_date']);
    List x = [
      {"age": 2, "name": "Annna"},
      {"age": 3, "name": "Ravi"}
    ];
    x.sort((a, b) => a['age'] > b['age'] ? a['age'] : b['age']);
    print(x);
    print('length here ${widget.snapshot}');
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Card(
              color: Colors.white,
              child: ListTile(
                onTap: () async {
                  await showModalBottomSheet(
                      isDismissible: true,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(120),
                            topRight: Radius.circular(120)),
                      ),
                      context: context,
                      builder: (context) => Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(120),
                                      topRight: Radius.circular(120)),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    color: Colors.white,
                                    height: MediaQuery.of(context).size.height /
                                        1.8,
                                    child: Container(
                                        child: Wrap(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(40),
                                              border: Border.all(
                                                  color: (index % 2 == 0)
                                                      ? Colors.amber
                                                      : (index % 3 == 0)
                                                          ? Colors.pink
                                                          : Colors.deepOrange)),
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              4,
                                          margin: EdgeInsets.only(
                                              left: 20,
                                              right: 20,
                                              top: kToolbarHeight * 3,
                                              bottom: 20),
                                          child: SingleChildScrollView(
                                            child: Wrap(
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.all(20),
                                                  child: Text(
                                                    "${removeAllHtmlTags(widget.snapshot[index]['description'])}",
                                                    style: new TextStyle(
                                                      fontSize: 12.0,
                                                      color: Colors.black,
                                                    ),
                                                    overflow: TextOverflow.clip,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Center(
                                            child: ElevatedButton.icon(
                                          onPressed: () async {
                                            String url =
                                                widget.snapshot[index]['url'];
                                            await canLaunch(url)
                                                ? await launch(url)
                                                : throw throw 'Could not launch $url';
                                          },
                                          icon: Icon(Icons.check_circle),
                                          style: ButtonStyle(
                                              shape: MaterialStateProperty.all(
                                                  RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              )),
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                (index % 2 == 0)
                                                    ? Colors.amber
                                                    : (index % 3 == 0)
                                                        ? Colors.pink[300]
                                                        : Colors.deepOrange,
                                              )),
                                          label: Text('Apply'),
                                        ))
                                      ],
                                    )),
                                  )),
                              Positioned(
                                child: Container(
                                    child: Wrap(
                                  alignment: WrapAlignment.center,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  direction: Axis.vertical,
                                  children: [
                                    CircleAvatar(
                                        radius: 40,
                                        backgroundColor: (index % 2 == 0)
                                            ? Colors.amber
                                            : (index % 3 == 0)
                                                ? Colors.pink[300]
                                                : Colors.deepOrange,
                                        child: Icon(
                                          Icons.work_outline_rounded,
                                          size: 40,
                                        )

                                        // Text(
                                        //     '${widget.snapshot.data!['jobs'][index]['company_name'][0].toString().toUpperCase()}'),
                                        ),
                                    Text(
                                      '${widget.snapshot[index]['company_name']}',
                                      style: TextStyle(
                                        fontSize: 20,
                                        letterSpacing: 2,
                                        color: Colors.indigo,
                                      ),
                                    ),
                                    Wrap(
                                      direction: Axis.vertical,
                                      runSpacing: 5,
                                      children: [
                                        Text(
                                          '${widget.snapshot[index]['title']}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontStyle: FontStyle.italic),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            ButtonBar(
                                              children: [
                                                Icon(
                                                  Icons.work_sharp,
                                                  color: (index % 2 == 0)
                                                      ? Colors.amber
                                                      : (index % 3 == 0)
                                                          ? Colors.pink[300]
                                                          : Colors.deepOrange,

                                                  //  Colors.indigo,
                                                ),
                                                Text(
                                                    '${widget.snapshot[index]['job_type']}'
                                                        .replaceAll('_', ' ')),
                                              ],
                                            ),
                                            ButtonBar(
                                              children: [
                                                Icon(
                                                  Icons.location_on,
                                                  color: (index % 2 == 0)
                                                      ? Colors.amber
                                                      : (index % 3 == 0)
                                                          ? Colors.pink[300]
                                                          : Colors.deepOrange,
                                                  // Colors.pink[400],
                                                ),
                                                Text(
                                                    '${widget.snapshot[index]['candidate_required_location']}'),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                              )
                            ],
                          ));
                },
                subtitle: Container(
                  child: Wrap(
                    runSpacing: 5,
                    children: [
                      Text(
                        '${widget.snapshot[index]['title']}',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.italic),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.work_sharp,
                            color: (index % 2 == 0)
                                ? Colors.amber
                                : (index % 3 == 0)
                                    ? Colors.pink[300]
                                    : Colors.deepOrange,

                            //  Colors.indigo,
                          ),
                          Text('${widget.snapshot[index]['job_type']}'
                              .replaceAll('_', ' '))
                        ],
                      ),
                      ButtonBar(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: (index % 2 == 0)
                                ? Colors.amber
                                : (index % 3 == 0)
                                    ? Colors.pink[300]
                                    : Colors.deepOrange,
                            // Colors.pink[400],
                          ),
                          Text(
                              '${widget.snapshot[index]['candidate_required_location']}')
                        ],
                      ),
                    ],
                  ),
                ),
                title: Text(
                  '${widget.snapshot[index]['company_name']}',
                  style: TextStyle(
                    fontSize: 20,
                    letterSpacing: 2,
                    color: Colors.indigo,
                  ),
                ),
                contentPadding: EdgeInsets.all(10),
                leading: CircleAvatar(
                    backgroundColor: (index % 2 == 0)
                        ? Colors.amber
                        : (index % 3 == 0)
                            ? Colors.pink[300]
                            : Colors.deepOrange,
                    child: Icon(Icons.work_outline_rounded)

                    // Text(
                    //     '${widget.snapshot.data!['jobs'][index]['company_name'][0].toString().toUpperCase()}'),
                    ),
              )),
        );
      },
      itemCount: widget.snapshot.isEmpty ? 0 : widget.snapshot.length,
    );
  }
}
