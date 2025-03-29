class CustomDateTime {
  // Function to convert month to custom values
  String getCustomMonth(int month) {
    Map<int, String> monthMap = {
      1: 'ckjdß', // January
      2: 'fmnrjdß', // February
      3: 'ud¾;=', // March
      4: 'wfma%,a', // April
      5: 'uehs', // May
      6: 'cqks', // June
      7: 'cQ,s', // July
      8: 'wf.daia;=', // August
      9: 'iema;eïn¾', // September
      10: 'Tlaf;daïn¾', // October
      11: 'fkdjeïn¾', // November
      12: 'foieïn¾' // December
    };

    // Make sure to handle invalid month numbers
    if (month < 1 || month > 12) {
      return 'Unknown Month';
    }

    return monthMap[month]!;
  }

  // Function to convert day of the week to custom values
  String getCustomDay(int weekday) {
    Map<int, String> dayMap = {
      1: 'iÿod', // Monday
      2: 'wÕyrejdod', // Tuesday
      3: 'nodod', // Wednesday
      4: 'n%yiam;skaod', // Thursday
      5: 'isl=rdod', // Friday
      6: 'fikiqrdod', // Saturday
      7: 'bßod' // Sunday
    };

    return dayMap[weekday] ?? 'Unknown Day';
  }

  // Function to convert year to buddhist year
  int getCustomYear(int year) {
    const int yearOffset = 544;
    return year + yearOffset;
  }
}
