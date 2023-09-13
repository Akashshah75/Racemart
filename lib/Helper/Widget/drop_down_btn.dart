import 'package:flutter/material.dart';
import '../../Utils/app_color.dart';

class CustomeDropDownButton extends StatelessWidget {
  const CustomeDropDownButton({
    super.key,
    required this.hintText,
    required this.choseValue,
    required this.dropDownList,
    required this.onChanged,
  });

  final String hintText;
  final String choseValue;
  final List dropDownList;
  // final List dropDownList;
  final void Function(Object?) onChanged;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: whiteColor,
        border: Border.all(color: blueColor.withOpacity(0.4)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButton(
        underline: const SizedBox(),
        dropdownColor: whiteColor,
        hint: Text(
          hintText,
          style: TextStyle(color: dropDownTextColor),
        ),
        iconEnabledColor:
            dropDownList.isNotEmpty ? blackColor : dropDownTextColor,
        borderRadius: BorderRadius.circular(20),
        value: choseValue.isEmpty ? null : choseValue,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        isExpanded: true,
        onChanged: onChanged,
        items: dropDownList.map(
          (val) {
            return DropdownMenuItem(
              value: val,
              child: Text(
                val,
                style: const TextStyle(color: blackColor),
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}

class EventDropDownButton extends StatelessWidget {
  const EventDropDownButton(
      {super.key,
      required this.hintText,
      required this.choseValue,
      required this.onChanged,
      required this.items});

  final String hintText;
  final dynamic choseValue;
  final List<DropdownMenuItem<Object?>> items;

  final void Function(dynamic) onChanged;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: whiteColor,
        border: Border.all(color: blueColor.withOpacity(0.4)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButton<dynamic>(
        menuMaxHeight: 400,
        underline: const SizedBox(),
        dropdownColor: whiteColor,
        hint: Text(
          hintText,
          style: TextStyle(color: dropDownTextColor),
        ),
        borderRadius: BorderRadius.circular(12),
        value: choseValue == 0 || choseValue.isEmpty ? null : choseValue,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        isExpanded: true,
        onChanged: onChanged,
        items: items,
      ),
    );
  }
}

class EventDropDownButtons extends StatelessWidget {
  const EventDropDownButtons(
      {super.key,
      required this.hintText,
      required this.choseValue,
      required this.onChanged,
      required this.items});

  final String hintText;
  final dynamic choseValue;
  final List<DropdownMenuItem<Object?>> items;

  final void Function(Object?) onChanged;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: whiteColor,
        border: Border.all(color: blueColor.withOpacity(0.4)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButton<dynamic>(
        underline: const SizedBox(),
        dropdownColor: whiteColor,
        hint: Text(
          hintText,
          style: TextStyle(color: dropDownTextColor),
        ),
        // iconEnabledColor:
        //  dropDownList.isNotEmpty ? blackColor : dropDownTextColor,
        borderRadius: BorderRadius.circular(20),
        value: choseValue,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        isExpanded: true,
        onChanged: onChanged, items: items,

        //  dropDownList.map(
        //   (val) {
        //     return DropdownMenuItem(
        //       value: val,
        //       child: Text(
        //         val,
        //         style: const TextStyle(color: blackColor),
        //       ),
        //     );
        //   },
        // ).toList(),
      ),
    );
  }
}

//creating List of String
//'Walking', 'Running', 'Swimming', 'cycling'
