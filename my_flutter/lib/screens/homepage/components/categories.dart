import 'package:flutter/material.dart';
import 'package:wefix/screens/homepage/components/results_widget.dart';

import '../../../size_config.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      {
        "icon": const Icon(
          Icons.plumbing,
        ),
        "text": "Plumber"
      },
      {"icon": const Icon(Icons.cut), "text": "Tailor"},
      {"icon": const Icon(Icons.electrical_services), "text": "Electrician"},
      {"icon": const Icon(Icons.window_rounded), "text": "Glass Maker"},
      {
        "icon": const Icon(Icons.photo_size_select_actual_outlined),
        "text": "Gardner"
      },
      {"icon": const Icon(Icons.sensor_window_outlined), "text": "Carpenter"},
    ];
    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 1,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
        itemCount: categories.length,
        itemBuilder: (BuildContext ctx, int index) {
          return CategoryCard(
            icon: categories[index]["icon"],
            text: categories[index]["text"],
            press: () {
              String _category = categories[index]["text"];
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResultsWidget(category: _category),
                  ));
            },
          );
        },
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.icon,
    required this.text,
    required this.press,
  }) : super(key: key);

  final Icon? icon;
  final String? text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        children: [
          Container(
            height: getProportionateScreenWidth(100),
            width: getProportionateScreenWidth(100),
            decoration: BoxDecoration(
              color: Color(0xFFFFECDF),
              borderRadius: BorderRadius.circular(100),
            ),
            child: icon!,
          ),
          const SizedBox(height: 5),
          Text(text!, textAlign: TextAlign.center)
        ],
      ),
    );
  }
}
