import 'package:flutter/material.dart';
import 'package:hair_expert_poc/src/utils/constants/color_constants.dart';
import 'package:hair_expert_poc/src/utils/constants/image_constants.dart';
import 'package:hair_expert_poc/src/utils/google_font_text.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback onClosePressed;

  const CustomDialog({
    required this.title,
    required this.message,
    required this.onClosePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: kWhite,
        ),
        height: 425,
        width: 327,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 56,
              ),
              child: CircleAvatar(
                maxRadius: 51,
                backgroundColor: kLightGrey,
                child: Center(
                  child: Image.asset(icDone),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            GoogleFontsText(
              text: title,
              fontFamily: 'Inter',
              color: kBlack,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 27,
              ),
              child: GoogleFontsText(
                text: message,
                fontFamily: 'Inter',
                color: kSelectDay,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 48),
            GestureDetector(
              onTap: onClosePressed,
              child: Container(
                width: 183,
                height: 56,
                decoration: const BoxDecoration(
                  color: kBlack,
                ),
                child: Center(
                  child: GoogleFontsText(
                    text: "Home",
                    fontFamily: 'Inter',
                    color: kWhite,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
