import 'dart:async';

import 'package:focus_app/screen2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dnd/flutter_dnd.dart';
import 'package:oktoast/oktoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:phone_state_i/phone_state_i.dart';

import 'misscall/log_screen.dart';
import 'misscall/missed_call.dart';
import 'screen2.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'FOCUS',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Mode_screeen()
        // MyHomePage (title: "checking",),
        );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  String _filterName = '';
  bool _isNotificationPolicyAccessGranted = false;
  StreamSubscription streamSubscription;

  CallLogs cl = new CallLogs();

//  AppLifecycleState _notification;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    streamSubscription =
        phoneStateCallEvent.listen((PhoneStateCallEvent event) {
      print('Call is Incoming or Connected' + event.stateC);
      //event.stateC has values "true" or "false"
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print(state.toString());
    if (state == AppLifecycleState.resumed) {
      updateUI();
    }
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
    streamSubscription.cancel();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    updateUI();
  }

  void updateUI() async {
    int filter = await FlutterDnd.getCurrentInterruptionFilter();
    String filterName = FlutterDnd.getFilterName(filter);
    bool isNotificationPolicyAccessGranted =
        await FlutterDnd.isNotificationPolicyAccessGranted;

    setState(() {
      _isNotificationPolicyAccessGranted = isNotificationPolicyAccessGranted;
      _filterName = filterName;
    });
  }

  void setInterruptionFilter(int filter) async {
    if (await FlutterDnd.isNotificationPolicyAccessGranted) {
      await FlutterDnd.setInterruptionFilter(filter);
      updateUI();
    }
  }

  @override
  Widget build(BuildContext context) {
    // dnd_Allow(){
    //   bool a=true;
    //   if(_isNotificationPolicyAccessGranted){
    //     return
    //
    //   }
    // }
    openPhonelogs() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PhonelogsScreen(),
        ),
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Current Filter: $_filterName'),
                SizedBox(
                  height: 10,
                ),
                Text(
                    'isNotificationPolicyAccessGranted: ${_isNotificationPolicyAccessGranted ? 'YES' : 'NO'}'),
                SizedBox(
                  height: 10,
                ),
                // ignore: deprecated_member_use
                ElevatedButton(
                  onPressed: () {
                    FlutterDnd.gotoPolicySettings();
                  },
                  child: Text('GOTO POLICY SETTINGS'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    setInterruptionFilter(FlutterDnd.INTERRUPTION_FILTER_NONE);
                  },
                  child: Text('TURN ON DND'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setInterruptionFilter(FlutterDnd.INTERRUPTION_FILTER_ALL);
                  },
                  child: Text('TURN OFF DND'),
                ),
                ElevatedButton(
                  onPressed: () {
//              setInterruptionFilter(FlutterDnd.INTERRUPTION_FILTER_ALARMS);
//               Navigator.push(context,
//                 MaterialPageRoute(
//                   builder: (context) => SendSms(),
//                 ),
//
//               );
                  },
                  child:
//            Text('TURN ON DND - ALLOW ALARM'),
                      Text('Sms'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (await Permission.phone.request().isGranted) {
                      openPhonelogs();
                    } else {
                      showToast(
                          "Provide Phone permission to make a call and view logs.",
                          position: ToastPosition.bottom);
                    }
                  },
                  //setInterruptionFilter(FlutterDnd.INTERRUPTION_FILTER_PRIORITY)
                  // },
                  child: Text('Phone logs'),
                ),
                Hero(
                  tag: "icon",
                  child: ElevatedButton(
                    onPressed: () async {
                      if (await Permission.phone.request().isGranted) {
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                                transitionDuration: Duration(milliseconds: 500),
                                pageBuilder: (_, __, ___) => Mode_screeen()));
                      } else {
                        showToast(
                            "Provide Phone permission to make a call and view logs.",
                            position: ToastPosition.bottom);
                      }
                    },
                    //setInterruptionFilter(FlutterDnd.INTERRUPTION_FILTER_PRIORITY)
                    // },
                    child: Text('PAge pe chloooooo'),
                  ),
                ),
              ]),
        ));
  }
}
