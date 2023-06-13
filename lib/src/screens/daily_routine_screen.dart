import 'package:flutter/material.dart';
import 'package:hair_expert_poc/models/time_slot_model.dart';
import 'package:hair_expert_poc/service/api_service.dart';
import 'package:hair_expert_poc/src/utils/constants/app_constants.dart';
import 'package:hair_expert_poc/src/utils/constants/color_constants.dart';
import 'package:hair_expert_poc/src/utils/custom_dialog.dart';
import 'package:hair_expert_poc/src/utils/google_font_text.dart';
import 'package:hair_expert_poc/src/utils/keshah_header.dart';
import 'package:intl/intl.dart';

class DailyRoutineScreen extends StatefulWidget {
  const DailyRoutineScreen({super.key});

  @override
  State<DailyRoutineScreen> createState() => _DailyRoutineScreenState();
}

class _DailyRoutineScreenState extends State<DailyRoutineScreen> {
  List<String> availableDates = [];
  String? selectedDate;
  String? selectedTime;
  bool isLoading = true;
  late DateTime endTime;
  TimeSlotModel? timeSlotModel;
  List<DateTime> dynamicSlot = [];
  List<String> apiSlots = [];

  @override
  void initState() {
    super.initState();
    fetchUserAvailableSlots();
    selectDate('2023-06-08');
    endTime = DateTime.now().add(const Duration(
        hours: 1)); // Set the end time to 1 hour from the current time
  }

  //Fetch Api for getting Slots details
  void fetchUserAvailableSlots() async {
    final now = DateTime.now();
    final startDate =
        now.toIso8601String().split('T')[0]; // Start date is today
    final endDate = now
        .add(const Duration(days: 10))
        .toIso8601String()
        .split('T')[0]; // End date is one week later
    setState(() {
      isLoading = true;
    });
    try {
      final slotData = await ApiService.fetchUserAvailableSlots(
          eventTypeId: '312671',
          startTime: startDate,
          endTime: endDate,
          apiKey: 'cal_live_6055a5adaa9defc72ea0e34cb1bc4f5a',
          timeZone: 'Asia/Kolkata');
      setState(() {
        timeSlotModel = slotData;
        availableDates = slotData.slots!.keys.toList();
        isLoading = false;
        selectDate(availableDates.first);
      });
    } catch (e) {
      print('Failed to fetch user available slots. Error: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  myTimeSlots(String? dateString) {
    DateTime date = DateTime.parse(dateString!);
    DateTime startTime = DateTime(date.year, date.month, date.day, 9);
    DateTime endTime = DateTime(date.year, date.month, date.day, 18);

    List<DateTime> timeSlots = generateTimeSlots(
      startTime,
      endTime,
      const Duration(hours: 1),
    );
    List<DateTime> genratedDate = [];
    for (var time in timeSlots) {
      print(time);
      genratedDate.add(time);
    }

    dynamicSlot = genratedDate;
  }

  List<DateTime> generateTimeSlots(
      DateTime start, DateTime end, Duration duration) {
    List<DateTime> timeSlots = [];
    DateTime time = start;

    while (time.isBefore(end)) {
      timeSlots.add(time);
      time = time.add(duration);
    }

    return timeSlots;
  }

  void selectDate(String date) {
    setState(() {
      selectedDate = date;
      selectedTime = null;
      myTimeSlots(date);
    });
    print(selectedDate);
  }

  void selectTime(String time) {
    setState(() {
      selectedTime = time;
      selectedTimeSlot = null;
    });
  }

  String _getWeekdayName(int weekday) {
    switch (weekday) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    getScreenSize(context);
    return Scaffold(
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                const KeshahHeader(),
                Padding(
                  padding: const EdgeInsets.only(left: 42),
                  child: Row(
                    children: [
                      GoogleFontsText(
                        text: 'Companion',
                        fontFamily: 'Montserrat',
                        color: Colors.black,
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                Container(
                  height: 121,
                  width: 334,
                  decoration: const BoxDecoration(
                    color: kLightGrey,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 15,
                      right: 40,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GoogleFontsText(
                              text: 'Aaditya Agrawal',
                              fontFamily: 'Montserrat',
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GoogleFontsText(
                              text: 'KESHAH Hair Expert',
                              fontFamily: 'Montserrat',
                              color: kKESHAHHairExpert,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 24,
                  ),
                  child: Row(
                    children: [
                      GoogleFontsText(
                        text: 'Select Date',
                        fontFamily: 'Montserrat',
                        color: kBlack,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 27,
                    right: 27,
                    top: 25,
                  ),
                  child: SizedBox(
                    height: 70,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: availableDates.length,
                      itemBuilder: (context, index) {
                        final date = DateTime.parse(availableDates[index]);
                        final isSelected =
                            selectedDate == availableDates[index];
                        return GestureDetector(
                          onTap: () {
                            selectDate(availableDates[index]);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 12,
                            ),
                            child: Container(
                              height: 70,
                              width: 46,
                              decoration: BoxDecoration(
                                color: isSelected ? kBlack : kLightGrey,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GoogleFontsText(
                                    text: _getWeekdayName(date.weekday),
                                    fontFamily: 'Inter',
                                    color: isSelected ? kWhite : kSelectDay,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  GoogleFontsText(
                                    text: '${date.day}',
                                    fontFamily: 'Inter',
                                    color: isSelected ? kWhite : kBlack,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Divider(
                    color: kLightGrey,
                    thickness: 1,
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 24,
                  ),
                  child: Row(
                    children: [
                      GoogleFontsText(
                        text: 'Select Time',
                        fontFamily: 'Montserrat',
                        color: kBlack,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 23,
                      vertical: 23,
                    ),
                    child: GridView.builder(
                      padding: EdgeInsets.zero,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 3.0,
                        crossAxisSpacing: 13,
                        mainAxisSpacing: 15,
                      ),
                      itemCount: dynamicSlot.length,
                      itemBuilder: (context, index) {
                        final timeSlot = dynamicSlot[index];
                        final isSelected = selectedDate != null &&
                            selectedTimeSlot == timeSlot;
                        List<Slot>? slotList =
                            timeSlotModel?.slots?[selectedDate];

                        List<DateTime>? getTimeStringsFromSlots(
                            List<Slot>? slotList) {
                          return slotList
                              ?.map((slot) => convertToIST(slot.time ?? ''))
                              .toList();
                        }

                        print(getTimeStringsFromSlots(slotList));
                        final isApiSlotAvailable =
                            (getTimeStringsFromSlots(slotList)
                                        ?.contains(timeSlot) ??
                                    false) &&
                                (timeSlot.compareTo(DateTime.now()) > 0);

                        final isSelectable =
                            isApiSlotAvailable && selectedDate != null;
                        final formattedTimeSlot =
                            _formatTime(timeSlot); // Format the time slot
                        return GestureDetector(
                          onTap: isSelectable
                              ? () => selectTimeSlot(timeSlot)
                              : null,
                          child: Container(
                            height: 37,
                            width: 137,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? kBlack
                                  : (isApiSlotAvailable
                                      ? kLightGrey
                                      : kLightGrey),
                            ),
                            child: Center(
                              child: GoogleFontsText(
                                text: formattedTimeSlot,
                                fontFamily: 'Inter',
                                color: isSelected
                                    ? Colors.white
                                    : (isApiSlotAvailable
                                        ? kBlack
                                        : kDisabledText),
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _showCustomDialog(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: screenSize!.height * (1 / 9),
                    ),
                    child: Container(
                      width: 339,
                      height: 37,
                      decoration: const BoxDecoration(color: kBlack),
                      child: Center(
                        child: GoogleFontsText(
                          text: 'Book Call',
                          fontFamily: 'Montserrat',
                          color: kWhite,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  DateTime? selectedTimeSlot;
  void selectTimeSlot(DateTime timeSlot) {
    setState(() {
      selectedTimeSlot = timeSlot;
      print(timeSlot);
    });
  }
}

DateTime convertToIST(String utcDataString) {
  DateTime utcDate = DateTime.parse(utcDataString);

  DateTime istDate = utcDate.toLocal();

  // String formattedISTDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(istDate);
  return istDate;
}

String _formatTime(DateTime time) {
  final formattedTime = DateFormat("hh:mm a").format(time);
  return formattedTime;
}

void _showCustomDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomDialog(
        title: 'Call Confirmed',
        message: 'The KESHAH Hair Expert is excited to see you.',
        onClosePressed: () {
          Navigator.of(context).pop();
        },
      );
    },
  );
}
