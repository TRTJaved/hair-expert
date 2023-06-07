import 'package:flutter/material.dart';
import 'package:hair_expert_poc/models/time_slot_model.dart';
import 'package:hair_expert_poc/service/api_service.dart';
import 'package:hair_expert_poc/src/utils/constants/app_constants.dart';
import 'package:hair_expert_poc/src/utils/constants/color_constants.dart';
import 'package:hair_expert_poc/src/utils/constants/font_family_constants.dart';
import 'package:hair_expert_poc/src/utils/constants/image_constants.dart';
import 'package:intl/intl.dart';

class DailyRoutineScreen extends StatefulWidget {
  const DailyRoutineScreen({super.key});

  @override
  State<DailyRoutineScreen> createState() => _DailyRoutineScreenState();
}

class _DailyRoutineScreenState extends State<DailyRoutineScreen> {
  List<DateTime> availableDates = [];
  List<Slot> availableSlots = [];
  DateTime? selectedDate;
  String? selectedTime;
  int? selectedSlotIndex;
  bool isLoading = true;
  late DateTime endTime;

  @override
  void initState() {
    super.initState();
    fetchUserAvailableSlots();
    //selectedDate = DateTime.now();
    // Select the next day by default
    final tomorrow = DateTime.now().add(
      const Duration(days: 1),
    );
    selectDate(tomorrow);
    endTime = DateTime.now().add(const Duration(
        hours: 1)); // Set the end time to 1 hour from the current time
  }

  void fetchUserAvailableSlots() async {
    setState(() {
      isLoading = true;
    });

    try {
      final slotData = await ApiService.fetchUserAvailableSlots(
          eventTypeId: '309631',
          startTime: '2023-06-07',
          endTime: '2023-06-15',
          apiKey: 'cal_live_6055a5adaa9defc72ea0e34cb1bc4f5a',
          timeZone: 'Asia/Kolkata');

      setState(() {
        availableDates = slotData.slots!.keys
            .map((dateStr) => DateTime.parse(dateStr))
            .toList();
        availableSlots = slotData.slots!.values.expand((list) => list).toList();
        isLoading = false;
      });
    } catch (e) {
      print('Failed to fetch user available slots. Error: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  void selectDate(DateTime date) {
    setState(() {
      selectedDate = date;
      selectedTime = null;
      selectedSlotIndex = null;
    });
  }

  void selectTime(String time) {
    setState(() {
      selectedTime = time;
    });
  }

  void selectTimeSlot(int index) {
    setState(() {
      selectedSlotIndex = index;
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
                Padding(
                  padding: EdgeInsets.only(
                    top: screenSize!.height * (1 / 15.615),
                    left: screenSize!.width * (1 / 15.625),
                    right: screenSize!.width * (1 / 15.625),
                  ),
                  child: Row(
                    children: [
                      RichText(
                        text: const TextSpan(
                          text: 'KESHAH',
                          style: TextStyle(
                            color: kBlack,
                            fontSize: 24,
                            fontFamily: fMontserrat,
                          ),
                          children: [
                            TextSpan(
                              text: 'Vault',
                              style: TextStyle(
                                color: kBlack,
                                fontSize: 20,
                                fontFamily: fMontserrat,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      const CircleAvatar(
                        backgroundImage: AssetImage(
                          icUser,
                        ),
                        maxRadius: 30,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: screenSize!.width * (1 / 8.928)),
                  child: const Row(
                    children: [
                      Text(
                        "Companion",
                        style: TextStyle(
                            color: kBlack,
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                            fontFamily: fMontserrat),
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
                  child: const Padding(
                    padding: EdgeInsets.only(
                      top: 15,
                      right: 40,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Aaditya Agrawal",
                              style: TextStyle(
                                color: kBlack,
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                fontFamily: fMontserrat,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "KESHAH Hair Expert",
                              style: TextStyle(
                                color: kKESHAHHairExpert,
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                fontFamily: fMontserrat,
                              ),
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
                const Padding(
                  padding: EdgeInsets.only(
                    left: 24,
                  ),
                  child: Row(
                    children: [
                      Text(
                        "Select Date",
                        style: TextStyle(
                          color: kBlack,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          fontFamily: fMontserrat,
                        ),
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
                        final date = availableDates[index];
                        final isSelected = selectedDate != null &&
                            date.day == selectedDate!.day &&
                            date.month == selectedDate!.month &&
                            date.year == selectedDate!.year;
                        return GestureDetector(
                          onTap: () {
                            selectDate(date);
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
                                  Text(
                                    _getWeekdayName(date.weekday),
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: isSelected ? kWhite : kSelectDay,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    '${date.day}',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: isSelected ? kWhite : kBlack,
                                    ),
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
                const Padding(
                  padding: EdgeInsets.only(
                    left: 24,
                  ),
                  child: Row(
                    children: [
                      Text(
                        "Select Time",
                        style: TextStyle(
                          color: kBlack,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          fontFamily: fMontserrat,
                        ),
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
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: (availableSlots.length / 3).ceil(),
                      itemBuilder: (context, rowIndex) {
                        final startIndex = rowIndex * 3;
                        final endIndex = startIndex + 3;
                        final rowSlots = availableSlots.sublist(
                            startIndex,
                            endIndex < availableSlots.length
                                ? endIndex
                                : availableSlots.length);
                        return Wrap(
                          spacing: 13,
                          runSpacing: 16.0,
                          children: List.generate(rowSlots.length, (index) {
                            final slot = rowSlots[index];

                            final istTime = DateFormat('hh:mm a')
                                .format(slot.time!.toLocal());
                            final startTime = DateTime(slot.time!.year,
                                slot.time!.month, slot.time!.day, 9, 0);
                            final endTime = DateTime(slot.time!.year,
                                slot.time!.month, slot.time!.day, 20, 0);

                            if (selectedDate != null &&
                                slot.time!.day == selectedDate!.day &&
                                slot.time!.month == selectedDate!.month &&
                                slot.time!.year == selectedDate!.year) {
                              final isSelected =
                                  selectedSlotIndex == startIndex + index;
                              return GestureDetector(
                                onTap: () {
                                  selectTimeSlot(startIndex + index);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 15,
                                  ),
                                  child: Container(
                                    width: 103,
                                    height: 37,
                                    decoration: BoxDecoration(
                                      color: isSelected ? kBlack : kLightGrey,
                                    ),
                                    child: Center(
                                      child: Text(
                                        istTime,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: isSelected ? kWhite : kBlack,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }
                            return const SizedBox.shrink();
                          }),
                        );
                      },
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: screenSize!.height * (1 / 9),
                    ),
                    child: Container(
                      width: 339,
                      height: 37,
                      decoration: const BoxDecoration(color: kBlack),
                      child: const Center(
                        child: Text(
                          "Book Call",
                          style: TextStyle(
                            color: kWhite,
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
