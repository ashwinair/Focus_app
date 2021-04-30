import 'package:call_log/call_log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:intl/intl.dart';

class CallLogs {
  void call(String text) async {
    bool res = await FlutterPhoneDirectCaller.callNumber(text);
  }

  Future<Iterable<CallLogEntry>> getCallLogs(a) {
    DateTime check = a;
    DateTime now = DateTime.now();
    var cal = now.difference(check);
    int hr = cal.inHours;

    int min = cal.inMinutes;

    int sec = cal.inSeconds;

    int from = now
        .subtract(Duration(hours: hr, minutes: min, seconds: sec))
        .millisecondsSinceEpoch;

    return CallLog.query(
      dateFrom: from,
      type: CallType.missed,
    );
  }

  String formatDate(DateTime dt) {
    return DateFormat('d-MMM-y H:m:s').format(dt);
  }

  getname(CallLogEntry entry) {
    if (entry.name == null)
      return Text(
        entry.number,
        style: TextStyle(color: const Color(0xFFD6D6D6)),
      );
    if (entry.name.isEmpty)
      return Text(
        entry.number,
        style: TextStyle(color: const Color(0xFFD6D6D6)),
      );
    else
      return Text(
        entry.name,
        style: TextStyle(color: const Color(0xFFD6D6D6)),
      );
  }

  smsName(CallLogEntry entry) {
    if (entry.name == null) return entry.number;
    if (entry.name.isEmpty)
      return entry.number;
    else
      return entry.name;
  }

  getNumber(CallLogEntry entry) {
    return entry.number;
  }

  String getTime(int duration) {
    Duration d1 = Duration(seconds: duration);
    String formatedDuration = "";
    if (d1.inHours > 0) {
      formatedDuration += d1.inHours.toString() + "h ";
    }
    if (d1.inMinutes > 0) {
      formatedDuration += d1.inMinutes.toString() + "m ";
    }
    if (d1.inSeconds > 0) {
      formatedDuration += d1.inSeconds.toString() + "s";
    }
    if (formatedDuration.isEmpty) return "0s";
    return formatedDuration;
  }
}
