import 'package:flutter/material.dart';
import 'package:hair_expert_poc/src/utils/constants/color_constants.dart';
import 'package:hair_expert_poc/src/utils/google_font_text.dart';

class CustomTabBar extends StatefulWidget {
  final List<String> tabs;
  final Function(int) onTap;

  CustomTabBar({required this.tabs, required this.onTap});

  @override
  _CustomTabBarState createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.grey[200],
      ),
      child: Row(
        children: List.generate(
          widget.tabs.length,
          (index) => Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = index;
                });
                widget.onTap(index);
              },
              child: Container(
                alignment: Alignment.center,
                color: index == _selectedIndex ? kBlack : kLightGrey,
                child: GoogleFontsText(
                  text: widget.tabs[index],
                  fontFamily: 'Inter',
                  color: index == _selectedIndex ? kWhite : kBlack,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
