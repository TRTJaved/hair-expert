import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hair_expert_poc/src/utils/constants/app_constants.dart';
import 'package:hair_expert_poc/src/utils/constants/color_constants.dart';
import 'package:hair_expert_poc/src/utils/constants/image_constants.dart';
import 'package:hair_expert_poc/src/utils/google_font_text.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController otpController = TextEditingController();
  var code = "";
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    getScreenSize(context);
    const focusedBorderColor = Colors.grey;

    final defaultPinTheme = PinTheme(
      width: 40,
      height: 40,
      textStyle: TextStyle(
        fontSize: 18,
        color: kBlack,
      ),
      decoration: BoxDecoration(
        color: kLightGrey,
      ),
    );
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  icKeshahLogo,
                  height: 24,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 25,
                top: 26,
              ),
              child: Row(
                children: [
                  Image.asset(icLeftArrow),
                ],
              ),
            ),
            const SizedBox(height: 17),
            Padding(
              padding: const EdgeInsets.only(
                left: 25,
              ),
              child: Row(
                children: [
                  GoogleFontsText(
                    text: 'What’s the code?',
                    fontFamily: 'Montserrat',
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),
            Padding(
              padding: const EdgeInsets.only(
                left: 25,
              ),
              child: Row(
                children: [
                  GoogleFontsText(
                    text: 'Enter the code sent to +91 12345678',
                    fontFamily: 'Montserrat',
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 29),
            Directionality(
              textDirection: TextDirection.ltr,
              child: Pinput(
                length: 6,
                androidSmsAutofillMethod:
                    AndroidSmsAutofillMethod.smsUserConsentApi,
                controller: pinController,
                focusNode: focusNode,
                listenForMultipleSmsOnAndroid: true,
                defaultPinTheme: PinTheme(
                  margin: EdgeInsets.only(
                    left: screenSize!.width * (1 / 85),
                    right: screenSize!.width * (1 / 85),
                  ),
                  height: screenSize!.width * (1 / 9.375),
                  width: screenSize!.width * (1 / 9.375),
                  decoration: const BoxDecoration(
                    color: kLightGrey,
                  ),
                ),
                // defaultPinTheme: defaultPinTheme,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your number properly';
                  } else if (value.length < 6) {
                    return 'Please enter a valid OTP';
                  }
                  return null;
                },
                onClipboardFound: (value) {
                  debugPrint('onClipboardFound: $value');
                  pinController.setText(value);
                },
                hapticFeedbackType: HapticFeedbackType.lightImpact,
                onCompleted: (pin) {
                  debugPrint('onCompleted: $pin');
                },
                onChanged: (value) {
                  code = value;
                  debugPrint('onChanged: $value');
                },
                // cursor: Column(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //     Container(
                //       margin: const EdgeInsets.only(bottom: 9),
                //       width: 22,
                //       height: 1,
                //       color: focusedBorderColor,
                //     ),
                //   ],
                // ),
                onSubmitted: (_) => FocusScope.of(context).nearestScope,
                // focusedPinTheme: defaultPinTheme.copyWith(
                //   decoration: defaultPinTheme.decoration!.copyWith(
                //     borderRadius: BorderRadius.circular(19),
                //     border: Border.all(color: focusedBorderColor),
                //   ),
                // ),
                // submittedPinTheme: defaultPinTheme.copyWith(
                //   decoration: defaultPinTheme.decoration!.copyWith(
                //     color: fillColor,
                //     borderRadius: BorderRadius.circular(19),
                //     border: Border.all(color: focusedBorderColor),
                //   ),
                // ),
                // errorPinTheme: defaultPinTheme.copyBorderWith(
                //   border: Border.all(color: Colors.redAccent),
                // ),
              ),
            ),
            const SizedBox(
              height: 36,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 25,
              ),
              child: Row(
                children: [
                  GoogleFontsText(
                    text: 'Didn’t get the code?',
                    fontFamily: 'Montserrat',
                    color: kResendOtp,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  Text(
                    "Resend it in 1:46.",
                    style: GoogleFonts.montserrat(
                      color: kResendOtpSecondText,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 25,
              ),
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  width: 183,
                  height: 56,
                  decoration: const BoxDecoration(
                    color: kBlack,
                  ),
                  child: Center(
                    child: GoogleFontsText(
                      text: "Next",
                      fontFamily: 'Inter',
                      color: kWhite,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
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
