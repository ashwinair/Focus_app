import 'dart:async';

import 'package:focus_app/Turned_on.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:clay_containers/constants.dart';
import 'package:clay_containers/widgets/clay_containers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dnd/flutter_dnd.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:phone_state_i/phone_state_i.dart';
import 'package:wakelock/wakelock.dart';

import 'misscall/missed_call.dart';

// ignore: camel_case_types
class Mode_screeen extends StatefulWidget {
  @override
  _Mode_screeenState createState() => _Mode_screeenState();
}

// ignore: camel_case_types
class _Mode_screeenState extends State<Mode_screeen>
    with WidgetsBindingObserver {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String _filterName = '';
  bool _isNotificationPolicyAccessGranted = false;
  StreamSubscription streamSubscription;

  CallLogs cl = new CallLogs();

//  AppLifecycleState _notification;

  void startServiceInPlatform() async {
    var methodChannel = MethodChannel("com.ashwin.focus_1");
    String data = await methodChannel.invokeMethod("startService");
    debugPrint(data);
  }

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
  TextEditingController taskController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFF1A1A1A),
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              // SizedBox(
              //   height: 10,
              //   width: 20,
              // ),
              Container(
                padding: EdgeInsets.all(20),
                alignment: FractionalOffset.topLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Focus",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 35, color: const Color(0xFFD6D6D6)),
                    ),
                    ClayContainer(
                      color: Color(0xFF1A1A1A),
                      height: 60,
                      depth: 10,
                      width: 60,
                      // borderRadius: 75,
                      customBorderRadius: BorderRadius.circular(60),
                      spread: 5,
                      curveType: CurveType.convex,
                      child: IconButton(
                        icon: Icon(Icons.settings),
                        color: Colors.grey[700],
                        onPressed: () {
                          FlutterDnd.gotoPolicySettings();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 80),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                child: TextField(
                  style: TextStyle(
                    fontSize: 26
                  ),
                  controller: taskController,
                decoration: InputDecoration(
                  labelText: "Task",
                  hintText: 'What are you going to do',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),


                  isDense: true,
                  // enabledBorder: new OutlineInputBorder(
                  //   borderSide:new  BorderSide(width: 1,
                  //     color: Colors.red,//this has no effect
                  //   ),
                  //   borderRadius: BorderRadius.circular(10.0),
                  // ),
                ),
             ),
              ),
                ],
              ),


              Padding(
                  padding: const EdgeInsets.all(80),
                  child: Row(
                    children: <Widget>[
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Hero(
                              tag: "icon",
                              child: AvatarGlow(
                                endRadius: 100,
                                shape: BoxShape.circle,
                                glowColor: Colors.redAccent,
                                animate: true,
                                showTwoGlows: true,
                                curve: Curves.ease,
                                child: ClayContainer(
                                  color: Color(0xFF1A1A1A),
                                  height: 150,
                                  depth: 10,
                                  width: 150,
                                  // borderRadius: 75,
                                  customBorderRadius:
                                      BorderRadius.circular(150),
                                  spread: 5,
                                  curveType: CurveType.convex,

                                  child: RawMaterialButton(
                                    // elevation: 2.0,
                                    highlightColor: Colors.transparent,
                                    splashColor: Colors.transparent,
                                    onPressed: () async {
                                      setState(() {
                                        Wakelock.enable();
                                        // You could also use Wakelock.toggle(on: true);
                                      });

                                      if (_isNotificationPolicyAccessGranted) {
                                        startServiceInPlatform();
                                        var onTime = DateTime.now();

                                        setInterruptionFilter(FlutterDnd
                                            .INTERRUPTION_FILTER_ALARMS);
                                        Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                                transitionDuration:
                                                    Duration(milliseconds: 500),
                                                pageBuilder: (_, __, ___) =>
                                                    Turned_on(
                                                        on_time: onTime,task: taskController.text)));
                                      } else {
                                        FlutterDnd.gotoPolicySettings();
                                      }
                                    },
                                    fillColor: const Color(0xFF1A1A1A),

                                    child: SvgPicture.string(
                                      // Icon awesome-power-off
                                      '<svg viewBox="163.4 377.3 47.47 58.14" ><path transform="translate(162.84, 387.2)" d="M 38.0809440612793 5.177927494049072 C 44.11069107055664 9.484890937805176 48.03481292724609 16.5291690826416 48.03481292724609 24.50183868408203 C 48.03481292724609 37.59500503540039 37.43011474609375 48.20927810668945 24.34651374816895 48.23799133300781 C 11.28205871582031 48.26670837402344 0.5816468000411987 37.61415100097656 0.5625046491622925 24.54012298583984 C 0.5529335737228394 16.56745338439941 4.47705602645874 9.504033088684082 10.49723434448242 5.187498092651367 C 11.61704540252686 4.393102645874023 13.17712211608887 4.728088855743408 13.84709453582764 5.92446756362915 L 15.35931777954102 8.613926887512207 C 15.9240083694458 9.618885040283203 15.65602016448975 10.89183235168457 14.72762966156006 11.58094692230225 C 10.75565242767334 14.52882385253906 8.219328880310059 19.19948768615723 8.219328880310059 24.49226760864258 C 8.209757804870605 33.32632827758789 15.34974670410156 40.58116912841797 24.29866027832031 40.58116912841797 C 33.06572341918945 40.58116912841797 40.43541717529297 33.47946548461914 40.37799072265625 24.39655685424805 C 40.34927749633789 19.43876457214355 38.01394653320313 14.65324878692627 33.8601188659668 11.57137680053711 C 32.93172836303711 10.88226222991943 32.67330932617188 9.609315872192383 33.23800277709961 8.61392879486084 L 34.75022506713867 5.924468994140625 C 35.42019653320313 4.737660884857178 36.970703125 4.383533000946045 38.0809440612793 5.177928447723389 Z M 28.12707138061523 25.26752090454102 L 28.12707138061523 2.29704737663269 C 28.12707138061523 1.024100303649902 27.10297012329102 -9.90447998046875 25.83002471923828 -9.90447998046875 L 25.83002471923828 -9.90447998046875 C 24.55707931518555 -9.90447998046875 20.47024726867676 1.024100303649902 20.47024726867676 2.29704737663269 L 20.47024726867676 25.26752090454102 C 20.47024726867676 26.54046630859375 21.49434852600098 27.56456756591797 22.76729393005371 27.56456756591797 L 25.83002471923828 27.56456756591797 C 27.10297012329102 27.56456756591797 28.12707138061523 26.54046630859375 28.12707138061523 25.26752090454102 Z" fill="#ff0000" stroke="#000000" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                                      width: 80,
                                      height: 60,
                                    ),
                                    padding: EdgeInsets.all(16),
                                    shape: CircleBorder(),
                                  ),
                                ),
                              ),
                            ),
                            // SizedBox(height: 60,width: 20,)
                          ],
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
