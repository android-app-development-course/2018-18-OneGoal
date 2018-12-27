import 'package:flutter/material.dart';

class Utilities {
  static String time2String(TimeOfDay time) {
    return time.hour.toString() + "/" + time.minute.toString();
  }

  static TimeOfDay string2Time(String str) {
    List<String> hm = str.split("/");
    assert (hm.length == 2);
    return TimeOfDay(hour: int.parse(hm[0]), minute: int.parse(hm[1]));
  }
}