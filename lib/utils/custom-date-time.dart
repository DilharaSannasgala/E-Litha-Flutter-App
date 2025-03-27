class CustomDateTime {
  // Function to convert month to custom values
  String getCustomMonth(int month) {
    Map<int, String> monthMap = {
      1: 'ckjdß',
      2: 'fmnrjdß',
      3: 'ud¾;=',
      4: 'wfma%,a',
      6: 'cqks',
      7: 'cQ,s',
      8: 'wf.daia;=',
      9: 'iema;eïn¾',
      10: 'Tlaf;daïn¾',
      11: 'fkdjeïn¾',
      12: 'foieïn¾'
    };

    return monthMap[month] ?? 'Unknown Month';
  }

    // Function to convert day of the week to custom values
  String getCustomDay(int weekday) {
    Map<int, String> dayMap = {
      1: 'iÿod',        // Monday
      2: 'wÕyrejdod',  // Tuesday
      3: 'nodod',      // Wednesday
      4: 'n%yiam;skaod', // Thursday
      5: 'isl=rdod',   // Friday
      6: 'fikiqrdod',  // Saturday
      7: 'bßod'        // Sunday
    };

    return dayMap[weekday] ?? 'Unknown Day';
  }

  // Function to convert year to buddhist year
  int getCustomYear(int year) {
    const int yearOffset = 544;
    return year + yearOffset;
  }
}

