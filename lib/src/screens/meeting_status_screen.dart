import 'package:flutter/material.dart';
import 'package:hair_expert_poc/src/utils/companion_text_widegt.dart';
import 'package:hair_expert_poc/src/utils/constants/color_constants.dart';
import 'package:hair_expert_poc/src/utils/constants/image_constants.dart';
import 'package:hair_expert_poc/src/utils/custom_tab_bar.dart';
import 'package:hair_expert_poc/src/utils/google_font_text.dart';
import 'package:hair_expert_poc/src/utils/keshah_header.dart';

class MeetingStatusScreen extends StatefulWidget {
  const MeetingStatusScreen({super.key});

  @override
  State<MeetingStatusScreen> createState() => _MeetingStatusScreenState();
}

class _MeetingStatusScreenState extends State<MeetingStatusScreen> {
  int? tabSelectIndex;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const KeshahHeader(),
          const SizedBox(
            height: 34,
          ),
          const CompanionTextWidget(),
          Padding(
            padding: const EdgeInsets.only(
              top: 34,
              left: 24,
              right: 16,
            ),
            child: CustomTabBar(
              tabs: const [
                'Upcoming',
                'Completed',
                'Canceled',
              ],
              onTap: (index) {
                // Handle tab selection here
                setState(() {
                  tabSelectIndex = index;
                  print('Tab $tabSelectIndex selected');
                });
              },
            ),
          ),
          const SizedBox(
            height: 41,
          ),
          Container(
            height: 179,
            width: 335,
            decoration: const BoxDecoration(
              color: kLightGrey,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 12,
              ),
              child: Column(
                children: [
                  Row(
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
                  const SizedBox(
                    height: 32,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        icCalendar,
                        height: 12,
                      ),
                      const SizedBox(width: 6.88),
                      GoogleFontsText(
                        text: '26/06/2022',
                        fontFamily: 'Inter',
                        color: kBlack,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                      const SizedBox(width: 7.72),
                      Image.asset(
                        icTime,
                        height: 12,
                      ),
                      const SizedBox(width: 6.72),
                      GoogleFontsText(
                        text: '10:30 AM',
                        fontFamily: 'Inter',
                        color: kBlack,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                      const SizedBox(width: 12),
                      Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: kConfirmed,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      const SizedBox(width: 5),
                      GoogleFontsText(
                        text: 'Confirmed',
                        fontFamily: 'Inter',
                        color: kBlack,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          print("Tapped");
                        },
                        child: Container(
                          height: 46,
                          width: 145,
                          decoration: const BoxDecoration(
                            color: kWhite,
                          ),
                          child: Center(
                            child: GoogleFontsText(
                              text: 'Cancel',
                              fontFamily: 'Inter',
                              color: kBlack,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      GestureDetector(
                        onTap: () {
                          print("Tapped");
                        },
                        child: Container(
                          height: 46,
                          width: 145,
                          decoration: const BoxDecoration(
                            color: kBlack,
                          ),
                          child: Center(
                            child: GoogleFontsText(
                              text: 'Reschedule',
                              fontFamily: 'Inter',
                              color: kWhite,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
