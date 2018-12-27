import 'package:flutter/material.dart';

class Utilities {
  static String time2String(TimeOfDay time) {
    return time.hour.toString() + "/" + time.minute.toString();
  }

  static TimeOfDay string2Time(String str) {
    List<int> hm = str.split("/").map((str) => int.parse(str));
    assert (hm.length == 2);
    return TimeOfDay(hour: hm[0], minute: hm[1]);
  }
}