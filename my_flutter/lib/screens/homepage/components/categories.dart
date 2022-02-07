import 'package:flutter/material.dart';
import 'package:wefix/screens/homepage/components/results_widget.dart';
import 'package:wefix/screens/homepage/components/results_widget.dart';

import '../../../size_config.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      {
        "icon": const Icon(
          Icons.plumbing,
          color: Colors.blue,
        ),
        "text": "Plumber"
      },
      {
        "icon": const Icon(
          Icons.cut,
          color: Colors.blue,
        ),
        "text": "Tailor"
      },
      {
        "icon": const Icon(
          Icons.electrical_services,
          color: Colors.blue,
        ),
        "text": "Electrician"
      },
      {
        "icon": const Icon(
          Icons.window_rounded,
          color: Colors.blue,
        ),
        "text": "Glass Maker"
      },
      {
        "icon": const Icon(
          Icons.photo_size_select_actual_outlined,
          color: Colors.blue,
        ),
        "text": "Gardner"
      },
      {
        "icon": const Icon(
          Icons.sensor_window_outlined,
          color: Colors.blue,
        ),
        "text": "Carpenter"
      },
    ];
    return Expanded(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: SizeConfig.screenWidth / 2,
            childAspectRatio: 1,
            crossAxisSpacing: 0,
            mainAxisSpacing: 0),
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
              color: Colors.grey[200],
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
