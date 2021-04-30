import 'dart:async';

import 'package:focus_app/screen2.dart';
import 'package:focus_app/sms/f_sms.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:call_log/call_log.dart';
import 'package:clay_containers/constants.dart';
import 'package:clay_containers/widgets/clay_containers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dnd/flutter_dnd.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oktoast/oktoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:phone_state_i/phone_state_i.dart';
import 'package:sms/sms.dart';
import 'package:wakelock/wakelock.dart';

import 'file:///G:/app%20dev%20projects/focus_1/lib/TTS/text_to_speech.dart';

import 'misscall/log_screen.dart';
import 'misscall/missed_call.dart';

// ignore: camel_case_types, must_be_immutable
class Turned_on extends StatefulWidget {
  // ignore: non_constant_identifier_names
  var on_time;
  var task;
  // ignore: non_constant_identifier_names
  Turned_on({this.on_time, this.task});

  @override
  _Turned_onState createState() => _Turned_onState(on_time: on_time,task:task);
}

// ignore: camel_case_types
class _Turned_onState extends State<Turned_on> with WidgetsBindingObserver {
  // ignore: non_constant_identifier_names
  var on_time;

  var task;



  // ignore: non_constant_identifier_names
  _Turned_onState(
      // ignore: non_constant_identifier_names
      {this.on_time, this.task}); //getting turn on time of the app to retrieve call logs &task

  Future<Iterable<CallLogEntry>> log;

  var userName = "Ashwin"; //enter your name
  // var task = this.task; //enter your task
  Sms sms = new Sms();
  SmsQuery query = new SmsQuery();

  // List messages = new List();

  CallLogs cl = new CallLogs();

  // ignore: cancel_subscriptions
  StreamSubscription streamSubscription;

  bool _isNotificationPolicyAccessGranted = false;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    streamSubscription =
        phoneStateCallEvent.listen((PhoneStateCallEvent event) async {
      print('Call is Incoming or Connected(turn on screen)' + event.stateC);
      log = cl.getCallLogs(on_time);
      //event.stateC has values "true" or "false"
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

    setState(() {
      log = cl.getCallLogs(on_time);
      //will try later .....
    });
  }

  void updateUI() async {
    int filter = await FlutterDnd.getCurrentInterruptionFilter();
    String filterName = FlutterDnd.getFilterName(filter);
    bool isNotificationPolicyAccessGranted =
        await FlutterDnd.isNotificationPolicyAccessGranted;

    setState(() {
      _isNotificationPolicyAccessGranted = isNotificationPolicyAccessGranted;
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
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFF1A1A1A),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                FutureBuilder(
                    future: log,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        Iterable<CallLogEntry> entries = snapshot.data;
                        int firstPerson =0;
                        var count = entries.length;
                        // ignore: non_constant_identifier_names
                        var Lcall;
                        var map = Set();
                        if (count == 0) {
                          Lcall = "None";
                        } else {
                          map = {cl.smsName(entries.elementAt(0))};
                          Lcall = map.join(" ");
                        }
                        var time =DateTime.fromMillisecondsSinceEpoch(
                            entries.elementAt(firstPerson).timestamp);
                            DateTime now = DateTime.now();
                        var callTime = now.difference(time);
                            print(callTime);
                        var num = cl.getNumber(entries.elementAt(firstPerson));
                        String receiverName = cl.smsName(entries.elementAt(firstPerson));
                          if(callTime.inSeconds<30){
                            if (receiverName.toLowerCase() == "akku" || receiverName.toLowerCase() == "a" ) {
                                say(receiverName, " is trying to reach you");

                            }else {

                                  sms.sendSMS(num, receiverName, userName, task);
                                  print(receiverName.toString().split(" ").first);
                            }
                          }

                        return SafeArea(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10,
                                width: 20,
                              ),
                              Container(
                                padding: EdgeInsets.all(20),
                                alignment: FractionalOffset.topLeft,
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Focus",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontSize: 35,
                                            color: const Color(0xFFD6D6D6)),
                                      ),
                                    ]),
                              ),
                              SizedBox(height: 80),
                              Text(
                                "Study Mode",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(
                                height: 70,
                                width: 20,
                              ),
                              ClayContainer(
                                depth: 10,
                                color: Color(0xFF1A1A1A),
                                height: 200,
                                width: 350,
                                spread: 1,
                                borderRadius: 20,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Text(
                                          'Total Missed calls:',
                                          style: TextStyle(
                                            fontFamily: 'Meiryo UI',
                                            fontSize: 20.0,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Text(
                                          '$count',
                                          style: TextStyle(
                                            fontFamily: 'Meiryo UI',
                                            fontSize: 30.0,
                                            color: const Color(0xFFFF0707)
                                                .withOpacity(0.52),
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Text(
                                          'Last Caller Name:',
                                          style: TextStyle(
                                            fontFamily: 'Meiryo UI',
                                            fontSize: 20.0,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Text(
                                          '$Lcall',
                                          style: TextStyle(
                                            fontFamily: 'Meiryo UI',
                                            fontSize: 20.0,
                                            color: Colors.grey,
                                          ),
                                        )
                                      ],
                                    ),
                                    ElevatedButton(
                                      onPressed: () async {
                                        if (await Permission.phone
                                            .request()
                                            .isGranted) {
                                          Navigator.push(
                                              context,
                                              PageRouteBuilder(
                                                  transitionDuration: Duration(
                                                      milliseconds: 500),
                                                  pageBuilder: (_, __, ___) =>
                                                      PhonelogsScreen(
                                                          on_time: on_time)));
                                        } else {
                                          showToast(
                                              "Provide Phone permission to make a call and view logs.",
                                              position: ToastPosition.bottom);
                                        }
                                      },
                                      child: Text(
                                        'See all',
                                        style: TextStyle(
                                          fontFamily: 'Meiryo UI',
                                          fontSize: 15.0,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      left: 130, top: 100),
                                  child: Row(
                                    children: <Widget>[
                                      Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Hero(
                                              tag: "icon",
                                              child: AvatarGlow(
                                                endRadius: 50,
                                                shape: BoxShape.circle,
                                                glowColor: Colors.green,
                                                animate: true,
                                                showTwoGlows: true,
                                                curve: Curves.ease,
                                                child: ClayContainer(
                                                  color: Color(0xFF1A1A1A),
                                                  height: 75,
                                                  depth: 5,
                                                  width: 75,
                                                  borderRadius: 75,
                                                  spread: 3,
                                                  curveType: CurveType.convex,
                                                  child: RawMaterialButton(
                                                    elevation: 2.0,
                                                    highlightColor:
                                                        Colors.transparent,
                                                    splashColor:
                                                        Colors.transparent,
                                                    onPressed: () async {
                                                      setState(() {
                                                        Wakelock.disable();
                                                        // You could also use Wakelock.toggle(on: false);
                                                        setInterruptionFilter(
                                                            FlutterDnd
                                                                .INTERRUPTION_FILTER_ALL);
                                                      });

                                                      Navigator.push(
                                                          context,
                                                          PageRouteBuilder(
                                                              transitionDuration:
                                                                  Duration(
                                                                      milliseconds:
                                                                          800),
                                                              pageBuilder: (_,
                                                                      __,
                                                                      ___) =>
                                                                  Mode_screeen()));
                                                    },
                                                    fillColor:
                                                        const Color(0xFF1A1A1A),
                                                    child: SvgPicture.string(
                                                      // Icon awesome-power-off
                                                      '<svg viewBox="161.31 569.76 27.99 34.28" ><path transform="translate(160.74, 579.66)" d="M 22.682373046875 -1.012293577194214 C 26.23735237121582 1.5269775390625 28.5509090423584 5.680097103118896 28.5509090423584 10.38057136535645 C 28.5509090423584 18.09995460510254 22.29866218566895 24.35784912109375 14.58491802215576 24.37477684020996 C 6.882462024688721 24.39170837402344 0.5737831592559814 18.11124229431152 0.5624974966049194 10.40314292907715 C 0.5568546056747437 5.7026686668396 2.870413064956665 1.538263320922852 6.419750213623047 -1.006650924682617 C 7.07996129989624 -1.475005388259888 7.999741077423096 -1.277506351470947 8.394739151000977 -0.5721533298492432 L 9.28630542755127 1.013480663299561 C 9.619232177734375 1.605977058410645 9.461233139038086 2.356472969055176 8.91387939453125 2.762756824493408 C 6.572106838226318 4.500746250152588 5.076757907867432 7.254445552825928 5.076757907867432 10.37492942810059 C 5.071115016937256 15.58325576782227 9.280662536621094 19.86051750183105 14.5567045211792 19.86051750183105 C 19.72553253173828 19.86051750183105 24.07050704956055 15.67354202270508 24.03665161132813 10.31850051879883 C 24.01972198486328 7.395516872406006 22.64287376403809 4.574103832244873 20.19388580322266 2.757114410400391 C 19.64653205871582 2.350830554962158 19.49417495727539 1.600335597991943 19.82710266113281 1.013481616973877 L 20.71866989135742 -0.5721523761749268 C 21.11366653442383 -1.271862983703613 22.02780532836914 -1.480647325515747 22.682373046875 -1.012292861938477 Z M 16.81383323669434 10.83199691772461 L 16.81383323669434 -2.710783958435059 C 16.81383323669434 -3.461279630661011 16.21005058288574 -9.90447998046875 15.45955657958984 -9.90447998046875 L 15.45955657958984 -9.90447998046875 C 14.70906162261963 -9.90447998046875 12.29957389831543 -3.461279630661011 12.29957389831543 -2.710783958435059 L 12.29957389831543 10.83199691772461 C 12.29957389831543 11.58249282836914 12.90335655212402 12.18627548217773 13.65385150909424 12.18627548217773 L 15.45955657958984 12.18627548217773 C 16.21005058288574 12.18627548217773 16.81383323669434 11.58249282836914 16.81383323669434 10.83199691772461 Z" fill="#4fff1c" stroke="#000000" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                                                      width: 20.99,
                                                      height: 35,
                                                    ),
                                                    padding: EdgeInsets.all(16),
                                                    shape: CircleBorder(),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            // SizedBox(
                                            //   height: 60,
                                            //   width: 20,
                                            // )
                                          ],
                                        ),
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                        );
                        // sms();

                      } else {
                        return Container(child: Column(
                          children: [
                            SizedBox(height:150),
                            Center(child: Text("Waiting for data",style: TextStyle(color:Colors.white38,fontSize: 40),)),
                          ],
                        ));
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
