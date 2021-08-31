import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:joblist/screens/jobmainscreen.dart';
import 'package:joblist/widgets/joblist.dart';

class JobScreen extends StatefulWidget {
  const JobScreen({Key? key}) : super(key: key);

  @override
  _JobScreenState createState() => _JobScreenState();
}

class _JobScreenState extends State<JobScreen> {
  var dio = new Dio();

  // List<Map<String, dynamic>> jobList = [];
  TextEditingController searchText = TextEditingController();
  Future<Map<String, dynamic>> getJobList() async {
    var resp = await dio
        .get('https://remotive.io/api/remote-jobs')
        .then((value) => value);
    print(resp.data);
    return resp.data;

// List x=;
// x.sort((a,b)=>a);
//     resp.data['jobs']
//     return {"jobs": jobList};
    // return resp.data;
  }

  // filterJobs(String val) async {
  //   return {
  //     "jobs":
  //         jobList.where((element) => element['title'].contains(val)).toList()
  //   };
  // }

  // Future<Map<String, dynamic>> filterJob(String val) async {
  //   var resp = await dio
  //       .get('https://remotive.io/api/remote-jobs')
  //       .then((value) => value);
  //   var filterData = resp.data['jobs'] as List;
  //   print("called");
  //   filterData =
  //       filterData.where((element) => element['title'].contains(val)).toList();
  //   print(filterData);

  //   return {"jobs": filterData};
  // }

  @override
  Widget build(BuildContext context) {
    print('changing');
    return FutureBuilder(
      future: getJobList(),
      builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        if (snapshot.hasData) {
          // return Container();
          List<dynamic> joblist = (snapshot.data!['jobs']);

          print("yobi: $joblist");
          return JobMainScreen(snapshot: snapshot.data!['jobs']);
        }
        return Container(
          height: double.infinity,
          color: Colors.indigo,
          child: Center(
              child: SpinKitPouringHourGlassRefined(
            color: Colors.amber,
            size: 150,
          )

              //      SpinKitDoubleBounce(
              //   color: Colors.white,
              // )

              ),
        );
      },
    );

    // Scaffold(
    //     backgroundColor: Colors.white,
    //     appBar: AppBar(
    //       elevation: 20,
    //       shadowColor: Colors.white,
    //       bottomOpacity: 0,
    //       toolbarHeight: kToolbarHeight * 2,
    //       title: TextFormField(
    //         controller: searchText,
    //         onChanged: (value) {},
    //         keyboardType: TextInputType.text,
    //         autofocus: false,
    //         style: TextStyle(fontSize: 15.0, color: Colors.black),
    //         decoration: InputDecoration(
    //             prefixIcon: Icon(
    //               Icons.search,
    //               color: Colors.indigo,
    //             ),
    //             border: InputBorder.none,
    //             hintText: 'Name',
    //             filled: true,
    //             fillColor: Colors.white,
    //             contentPadding:
    //                 const EdgeInsets.only(left: 14.0, bottom: 6.0, top: 8.0),
    //             focusedBorder: OutlineInputBorder(
    //               borderSide: BorderSide(color: Colors.black),
    //               borderRadius: BorderRadius.circular(10.0),
    //             ),
    //             enabledBorder: OutlineInputBorder(
    //               borderSide: BorderSide(color: Colors.black),
    //               borderRadius: BorderRadius.circular(10.0),
    //             ),
    //             disabledBorder: OutlineInputBorder(
    //               borderSide: BorderSide(color: Colors.black),
    //               borderRadius: BorderRadius.circular(10.0),
    //             )),
    //       ),
    //       backgroundColor: Colors.indigo,
    //     ),
    //     body: Container(
    //       color: Colors.white,

    //       child: (jobList.isEmpty)
    //           ? FutureBuilder(
    //               future: getJobList(),
    //               builder:
    //                   (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
    //                 print("searchtext=${searchText.text}");
    //                 if (snapshot.hasData)
    //                   //                 return   ListView.builder(
    //                   //   shrinkWrap: true,
    //                   //   itemBuilder: (context, index) => ClipRRect(
    //                   //     borderRadius: BorderRadius.circular(20),
    //                   //     child: Card(
    //                   //         color: Colors.white,
    //                   //         child: ListTile(
    //                   //           subtitle: Container(
    //                   //             child: Wrap(
    //                   //               children: [
    //                   //                 Text(
    //                   //                   '${jobList['jobs'][index]['title']}',
    //                   //                   style: TextStyle(fontWeight: FontWeight.w500),
    //                   //                 ),
    //                   //                 Row(
    //                   //                   mainAxisAlignment: MainAxisAlignment.start,
    //                   //                   children: [
    //                   //                     Icon(
    //                   //                       Icons.work_rounded,
    //                   //                       color: Colors.indigo,
    //                   //                     ),
    //                   //                     Text(
    //                   //                         '${jobList['jobs'][index]['job_type']}'
    //                   //                             .replaceAll('_', ' '))
    //                   //                   ],
    //                   //                 ),
    //                   //                 Text(
    //                   //                     'Job location:${widget.snapshot.data!['jobs'][index]['candidate_required_location']}')
    //                   //               ],
    //                   //             ),
    //                   //           ),
    //                   //           title: Text(
    //                   //             '${widget.snapshot.data!['jobs'][index]['company_name']}',
    //                   //             style: TextStyle(
    //                   //                 fontSize: 20,
    //                   //                 letterSpacing: 2,
    //                   //                 color: Colors.indigo,
    //                   //                 fontStyle: FontStyle.italic),
    //                   //           ),
    //                   //           contentPadding: EdgeInsets.all(10),
    //                   //           leading: CircleAvatar(
    //                   //             child: Text(
    //                   //                 '${widget.snapshot.data!['jobs'][index]['company_name'][0].toString().toUpperCase()}'),
    //                   //           ),
    //                   //         )),
    //                   //   ),
    //                   //   itemCount: widget.snapshot.data!['jobs'].length,
    //                   // );

    //                   return JobList(snapshot: snapshot);

    //                 return Container(
    //                   height: double.infinity,
    //                   color: Colors.indigo,
    //                   child: Center(
    //                       child: SpinKitFadingCube(
    //                     color: Colors.white,
    //                   )

    //                       //      SpinKitDoubleBounce(
    //                       //   color: Colors.white,
    //                       // )

    //                       ),
    //                 );
    //               },
    //             )
    //           : Container(
    //               child: Center(child: Text('${jobList.length}')),
    //             ),
    //       // JobList(snapshot: snapshot),

    //       //      SpinKitDoubleBounce(
    //       //   color: Colors.white,
    //       // )
    //     ));
  }
}
