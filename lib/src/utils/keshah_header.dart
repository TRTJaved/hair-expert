import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hair_expert_poc/src/utils/constants/color_constants.dart';
import 'package:hair_expert_poc/src/utils/constants/image_constants.dart';

class KeshahHeader extends StatelessWidget {
  const KeshahHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 52,
        left: 42,
        right: 28,
      ),
      child: Row(
        children: [
          Image.asset(
            icKeshahLogo,
            height: 24,
          ),
          Text(
            "Vault",
            style: GoogleFonts.inter(
              color: kBlack,
              fontSize: 24,
              fontWeight: FontWeight.w300,
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
    );
  }
}
