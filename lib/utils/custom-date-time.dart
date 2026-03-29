class CustomDateTime {
  // Function to convert month to custom values
  String getCustomMonth(int month) {
    Map<int, String> monthMap = {
      1: 'ජනවාරි', // January
      2: 'පෙබරවාරි', // February
      3: 'මාර්තු', // March
      4: 'අප්‍රේල්', // April
      5: 'මැයි', // May
      6: 'ජූනි', // June
      7: 'ජූලි', // July
      8: 'අගෝස්තු', // August
      9: 'සැප්තැම්බර්', // September
      10: 'ඔක්තෝබර්', // October
      11: 'නොවැම්බර්', // November
      12: 'දෙසැම්බර්' // December
    };

    // Make sure to handle invalid month numbers
    if (month < 1 || month > 12) {
      return 'Unknown Month';
    }

    return monthMap[month]!;
  }

  String getCustomMonthShort(int month) {
    Map<int, String> monthMap = {
      1: 'ජන', // January
      2: 'පෙබ', // February
      3: 'මාර්තු', // March
      4: 'අප්‍රේල්', // April
      5: 'මැයි', // May
      6: 'ජූනි', // June
      7: 'ජූලි', // July
      8: 'අගෝ', // August
      9: 'සැප්', // September
      10: 'ඔක්', // October
      11: 'නොවැ', // November
      12: 'දෙසැ' // December
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
      1: 'සඳුදා', // Monday
      2: 'අඟහරුවාදා', // Tuesday
      3: 'බදාදා', // Wednesday
      4: 'බ්‍රහස්පතින්දා', // Thursday
      5: 'සිකුරාදා', // Friday
      6: 'සෙනසුරාදා', // Saturday
      7: 'ඉරිදා' // Sunday
    };

    return dayMap[weekday] ?? 'Unknown Day';
  }

  // Function to convert year to buddhist year
  int getCustomYear(int year) {
    const int yearOffset = 544;
    return year + yearOffset;
  }
}
