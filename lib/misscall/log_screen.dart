import 'package:call_log/call_log.dart';
import 'package:clay_containers/widgets/clay_containers.dart';
import 'package:flutter/material.dart';

import 'missed_call.dart';

// ignore: must_be_immutable
class PhonelogsScreen extends StatefulWidget {
  // ignore: non_constant_identifier_names
  var on_time;

  // ignore: non_constant_identifier_names
  PhonelogsScreen({this.on_time});

  @override
  _PhonelogsScreenState createState() =>
      _PhonelogsScreenState(on_time: on_time);
}

class _PhonelogsScreenState extends State<PhonelogsScreen>
    with WidgetsBindingObserver {
  // ignore: non_constant_identifier_names
  var on_time;

  // ignore: non_constant_identifier_names
  _PhonelogsScreenState({this.on_time});

  //Iterable<CallLogEntry> entries;

  CallLogs cl = new CallLogs();
  bool data = false;

//  Sms sms = new Sms();

//  AppLifecycleState _notification;
  Future<Iterable<CallLogEntry>> logs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // logs = cl.getCallLogs(on_time);
    setState(() {
      logs = cl.getCallLogs(on_time);
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);

    if (AppLifecycleState.inactive == state) {

    }
  }

  @override
  Widget build(BuildContext context) {
    // sms() {
    //   Navigator.push(context,
    //     MaterialPageRoute(
    //       builder: (context) => SendSms(),
    //     ),
    //
    //   );
    // }
    return Scaffold(
      backgroundColor: Color(0xFF1A1A1A),
      appBar: AppBar(
        title: Text("Phone"),
        backgroundColor: Color(0xFF1A1A1A),
      ),
      body: Column(
        children: [

          FutureBuilder(
              future: logs,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  Iterable<CallLogEntry> entries = snapshot.data.toList();
                  if (entries.length == 0) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(50),
                        child: Text(
                          "No Data",
                          style: TextStyle(color: Colors.white38),
                        ),
                      ),
                    );
                  }

                  return Flexible(
                    fit: FlexFit.loose,
                    child: ClayContainer(
                      height: 10000,
                      width: 5000,
                      color: Color(0xFF1A1A1A),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return ClayContainer(
                            depth: 5,
                            color: Color(0xFF1A1A1A),
                            spread: 1,
                            borderRadius: 20,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                leading: IconButton(
                                  icon: Icon(Icons.account_circle),
                                  iconSize: 40,
                                  onPressed: null,
                                ),
                                title: cl.getname(entries.elementAt(index)),
                                subtitle: Text(
                                  cl.formatDate(
                                      new DateTime.fromMillisecondsSinceEpoch(
                                          entries.elementAt(index).timestamp)),
                                  style:
                                      TextStyle(color: const Color(0xFFD6D6D6)),
                                ),
                                isThreeLine: true,
                                trailing: IconButton(
                                    icon: Icon(Icons.phone),
                                    color: Colors.red,
                                    onPressed: () {
                                      cl.call(entries.elementAt(index).number);
                                    }),
                              ),
                            ),
                          );
                        },
                        itemCount: entries.length,
                      ),
                    ),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              })
        ],
      ),
    );
  }
}
