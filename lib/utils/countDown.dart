class CountDownutils {
  // 补零
  static String zeroFill(int i) {
    return i > 10 ? '$i' : '0$i';
  }

  static Map<String, String> second2HMS(int sec) {
    var hms = {
      'h': '00',
      "m": '00',
      "s": '00',
    };

    if (sec > 0) {
      int h = sec ~/ 3600;
      int m = (sec % 3600) ~/ 60;
      int s = sec % 60;
      hms = {
        'h': zeroFill(h),
        "m": zeroFill(m),
        "s": zeroFill(s),
      };
    }
    print('hms------: $hms');
    return hms;
  }
}
