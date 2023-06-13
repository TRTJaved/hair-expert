import 'package:flutter/material.dart';
import 'package:hair_expert_poc/src/utils/google_font_text.dart';

class CompanionTextWidget extends StatelessWidget {
  const CompanionTextWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24),
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
    );
  }
}
