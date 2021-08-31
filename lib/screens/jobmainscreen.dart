import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:joblist/widgets/joblist.dart';

class JobMainScreen extends StatefulWidget {
  final List<dynamic> snapshot;
  JobMainScreen({required this.snapshot});
  // const JobMainScreen({Key? key}) : super(key: key);

  @override
  _JobMainScreenState createState() => _JobMainScreenState();
}

class _JobMainScreenState extends State<JobMainScreen> {
  List jobList = [];
  List<String> catitems = ['Category'];
  String typeitemvalue = 'All';
  List<String> typeitems = ['All', 'fulltime', 'contract'];
  TextEditingController searchText = TextEditingController();
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    jobList = widget.snapshot;
  }

  List getFilterListType(String jtype, List jobList) {
    var x = [];
    print("calledd jobtype=$jtype");
    print("jobtype=$jobList");
    if (jtype == typeitems[1])
      x = jobList
          .where((element) => element['job_type']
              .toString()
              .toLowerCase()
              .replaceAll('_', '')
              .contains(jtype))
          .toList();
    else if (jtype == typeitems[2]) {
      x = jobList
          .where((element) =>
              element['job_type'].toString().toLowerCase().contains(jtype))
          .toList();
    }
    return x;
  }

  List<dynamic> getFilterList(String jobtype) {
    var x;

    // if (searchText.text.isEmpty && jobtype == typeitems[0])
    //     x = jobList;
    //   else if (searchText.text.isNotEmpty && jobtype == typeitems[0]) {
    //     x = jobList
    //         .where((element) => element['title']
    //             .toString()
    //             .toLowerCase()
    //             .trim()
    //             .contains(searchText.text.toLowerCase().trim()))
    //         .toList();
    //   } else if (searchText.text.isEmpty && jobtype != typeitems[0])
    //     x = getFilterList(jobtype);
    //   else {
    //     x = getFilterList(jobtype);
    //     x
    //         .where((element) => element['title']
    //             .toString()
    //             .toLowerCase()
    //             .trim()
    //             .contains(searchText.text.toLowerCase().trim()))
    //         .toList();
    //   }
    if (jobtype == typeitems[0]) {
      x = jobList
          .where((element) => element['title']
              .toString()
              .toLowerCase()
              .trim()
              .contains(searchText.text.toLowerCase().trim()))
          .toList();
      print("get filter list called ${x.length}");
    } else {
      x = getFilterListType(jobtype, jobList)
          .where((element) => element['title']
              .toString()
              .toLowerCase()
              .trim()
              .contains(searchText.text.toLowerCase().trim()))
          .toList();
    }
    return x;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 20,
        shadowColor: Colors.white,
        bottomOpacity: 0,
        toolbarHeight: kToolbarHeight * 3,
        title: Wrap(runSpacing: 5, children: [
          TextFormField(
            controller: searchText,
            onChanged: (value) async {
              print('value');
              await Future.delayed(Duration(seconds: 1), () {
                setState(() {});
              });
            },
            keyboardType: TextInputType.text,
            autofocus: false,
            focusNode: FocusNode(),
            style: TextStyle(fontSize: 15.0, color: Colors.black),
            decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.indigo,
                ),
                border: InputBorder.none,
                hintText: 'Name',
                filled: true,
                fillColor: Colors.white,
                contentPadding:
                    const EdgeInsets.only(left: 2.0, bottom: 6.0, top: 8.0),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(10.0),
                )),
          ),
          Row(
            children: [
              // ClipRRect(
              //   borderRadius: BorderRadius.circular(20),
              //   child: Container(
              //     color: Colors.white,
              //     child: DropdownButtonHideUnderline(
              //       key: Key('drop'),
              //       child: SingleChildScrollView(
              //         scrollDirection: Axis.vertical,
              //         child: DropdownButton(
              //           focusNode: FocusNode(),
              //           autofocus: true,
              //           dropdownColor: Colors.white,
              //           value: 'Category',
              //           icon: Icon(Icons.keyboard_arrow_down),
              //           items: catitems.map((String items) {
              //             return DropdownMenuItem(
              //                 value: items, child: Text(items));
              //           }).toList(),
              //           onChanged: (String? newValue) {
              //             // setState(() {
              //             //   dropdownvalue = newValue!;
              //             // });
              //           },
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              SizedBox(
                width: 10,
              ),
            ],
          ),
          Center(
            child: Column(children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  color: Colors.white,
                  child: DropdownButtonHideUnderline(
                    key: Key('drop'),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: DropdownButton(
                        focusNode: FocusNode(),
                        autofocus: false,
                        dropdownColor: Colors.white,
                        value: typeitemvalue,
                        icon: Icon(Icons.keyboard_arrow_down),
                        items: typeitems.map((String items) {
                          return DropdownMenuItem(
                              value: items, child: Text(items));
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            typeitemvalue = newValue!;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Text(
                'Job Type',
                style: TextStyle(fontSize: 10),
              )
            ]),
          ),
        ]),
        backgroundColor: Colors.indigo,
      ),
      body: Container(child: JobList(snapshot: getFilterList(typeitemvalue))),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton.icon(
          onPressed: () async {
            await showModalBottomSheet(
              context: context,
              builder: (context) {
                return ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(120),
                      topRight: Radius.circular(120)),
                  child: Container(
                    height: MediaQuery.of(context).size.height / 5,
                    child: Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          Container(
                              color: Colors.grey[300],
                              height: MediaQuery.of(context).size.height / 5,
                              width: MediaQuery.of(context).size.width / 2,
                              child: Center(
                                child: ElevatedButton(
                                  child: Text(
                                    'Job Type',
                                    style: TextStyle(color: Colors.indigo),
                                  ),
                                  onPressed: () {},
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18.0),
                                              side: BorderSide(
                                                  color: Colors.indigo))),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.white)),
                                ),
                              )),
                          Container(
                            height: 200,
                            width: MediaQuery.of(context).size.width / 2,
                            color: Colors.indigo,
                            child: Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  color: Colors.white,
                                  child: DropdownButtonHideUnderline(
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: DropdownButton(
                                        focusNode: FocusNode(),
                                        autofocus: false,
                                        focusColor: Colors.indigo,
                                        dropdownColor: Colors.white,
                                        value: typeitemvalue,
                                        icon: Icon(Icons.keyboard_arrow_down),
                                        items: typeitems.map((String items) {
                                          return DropdownMenuItem(
                                              value: items, child: Text(items));
                                        }).toList(),
                                        onChanged: (String? newValue) {
                                          Navigator.of(context).pop();
                                          setState(() {
                                            typeitemvalue = newValue!;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(120),
                    topRight: Radius.circular(120)),
              ),
            );
          },
          icon: Icon(
            Icons.filter_list_outlined,
            color: Colors.indigo,
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.white),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.indigo))),
          ),
          label: Text(
            'Filter',
            style: TextStyle(color: Colors.indigo),
          )),
    );
  }
}
