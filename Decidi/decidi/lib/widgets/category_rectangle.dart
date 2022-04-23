import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:decidi/theme/color.dart';

class CategoryRectangle extends StatelessWidget {
  CategoryRectangle(
      {Key? key,
      required this.data,
      this.isSelected = false,
      this.onTap,
      this.selectedColor = actionColor})
      : super(key: key);
  final data;
  final Color selectedColor;
  final bool isSelected;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            curve: Curves.fastOutSlowIn,
            padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: isSelected ? primary : Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: shadowColor.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(1, 1), // changes position of shadow
                  ),
                ],
                shape: BoxShape.rectangle),
            child: Row(
              children: [
                SvgPicture.asset(
                  data["icon"],
                  color: isSelected ? Colors.white : textColor,
                  width: 20,
                  height: 20,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  data["name"],
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                  style:
                      TextStyle(color: isSelected ? Colors.white : textColor),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
