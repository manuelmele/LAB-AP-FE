import 'package:flutter/material.dart';
import 'package:wefix/screens/homepage/components/results_widget.dart';

import '../../../size_config.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      {
        "icon": const AssetImage("assets/images/plumber.png"),
        "text": "Plumber"
      },
      {"icon": const AssetImage("assets/images/gardner.png"), "text": "Tiler"},
      {
        "icon": const AssetImage("assets/images/Electrician.png"),
        "text": "Electrician"
      },
      {
        "icon": const AssetImage("assets/images/gardner.png"),
        "text": "Glazier"
      },
      {
        "icon": const AssetImage("assets/images/gardner.png"),
        "text": "Gardener"
      },
      {
        "icon": const AssetImage("assets/images/gardner.png"),
        "text": "Carpenter"
      },
    ];
    return Expanded(
      child: GridView.builder(
        physics:
            NeverScrollableScrollPhysics(), //makes the category grid non scrollable
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: SizeConfig.screenWidth / 2,
            childAspectRatio: 1,
            crossAxisSpacing: 0,
            mainAxisSpacing: 0),
        itemCount: categories.length,
        itemBuilder: (BuildContext ctx, int index) {
          return CategoryCard(
            image: categories[index]["icon"],
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
    required this.image,
    required this.text,
    required this.press,
  }) : super(key: key);

  final AssetImage? image;
  final String? text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        children: [
          Container(
            height: getProportionateScreenWidth(130),
            width: getProportionateScreenWidth(130),
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(130),
                image: DecorationImage(
                  image: image!,
                  fit: BoxFit.fill,
                )),
            //child: icon!,
          ),
          const SizedBox(height: 5),
          Text(text!, textAlign: TextAlign.center)
        ],
      ),
    );
  }
}
