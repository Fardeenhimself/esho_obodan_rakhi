import 'dart:core';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';

class DateTimeScreen extends StatefulWidget {
  const DateTimeScreen({super.key});

  @override
  State<DateTimeScreen> createState() => _DateTimeScreenState();
}

class _DateTimeScreenState extends State<DateTimeScreen> {
  late String bengaliDate;
  late String hijriDateBn;
  Timer? _timer;

  // to convert the english to benglai replace the indexes of both arrays
  String toBengaliNumber(String input) {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const bengali = ['০', '১', '২', '৩', '৪', '৫', '৬', '৭', '৮', '৯'];

    for (int i = 0; i < english.length; i++) {
      input = input.replaceAll(english[i], bengali[i]);
    }
    return input;
  }

  @override
  void initState() {
    super.initState();
    _updateDates();
    _updateAtMidnight();
  }

  void _updateDates() {
    final today = DateTime.now();
    final formattedEnglishDate = DateFormat.yMMMMEEEEd('bn').format(today);
    bengaliDate = toBengaliNumber(formattedEnglishDate);

    const hijriMonthsBn = [
      "মুহাররম",
      "সফর",
      "রবিউল আউয়াল",
      "রবিউস সানি",
      "জমাদিউল আউয়াল",
      "জমাদিউস সানি",
      "রজব",
      "শাবান",
      "রমজান",
      "শাওয়াল",
      "জিলকদ",
      "জিলহজ্জ",
    ];

    final hijriDate = HijriCalendar.now();
    hijriDateBn =
        "${toBengaliNumber(hijriDate.hDay.toString())} "
        "${hijriMonthsBn[hijriDate.hMonth - 1]} "
        "${toBengaliNumber(hijriDate.hYear.toString())} হিজরি";
  }

  void _updateAtMidnight() {
    final now = DateTime.now();
    final tomorrow = DateTime(now.year, now.month, now.day + 1);
    final durationUntilMidnight = tomorrow.difference(now);

    _timer = Timer(durationUntilMidnight, () {
      setState(() {
        _updateDates();
      });
      _updateAtMidnight();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            bengaliDate,
            style: TextStyle(fontFamily: 'bangla', fontSize: 14),
          ),
          Text(
            hijriDateBn,
            style: TextStyle(fontFamily: 'bangla', fontSize: 14),
          ),
        ],
      ),
    );
  }
}
