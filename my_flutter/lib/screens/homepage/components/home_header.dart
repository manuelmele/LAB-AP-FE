import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class HomeHeader extends StatelessWidget {
  final ValueChanged<String> onSubmit;

  const HomeHeader({
    Key? key,
    required this.onSubmit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      width: SizeConfig.screenWidth * 0.9,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        textAlignVertical: TextAlignVertical.center,
        onSubmitted: (value) => onSubmit(value),
        decoration: const InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            hintText: "Search",
            hintStyle: TextStyle(color: kOrange),
            prefixIcon: Icon(Icons.search, color: kOrange)),
      ),
    );
  }
}
