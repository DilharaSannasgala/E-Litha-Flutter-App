class CalendarDay {
  final int day;
  final bool isPreviousMonth;
  final bool isNextMonth;
  final bool isHoliday;
  final bool isSpecialDay;
  final bool isToday;

  CalendarDay(
    this.day, {
    this.isPreviousMonth = false,
    this.isNextMonth = false,
    this.isHoliday = false,
    this.isSpecialDay = false,
    this.isToday = false,
  });
}