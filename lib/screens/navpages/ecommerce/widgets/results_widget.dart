
import 'package:flutter/material.dart';
import 'package:flutter_application_2023/screens/navpages/ecommerce/model/product_model.dart';
import 'package:flutter_application_2023/screens/navpages/ecommerce/screens/product_screen.dart';
import 'package:flutter_application_2023/screens/navpages/ecommerce/utils/color_themes.dart';
import 'package:flutter_application_2023/screens/navpages/ecommerce/utils/utils.dart';
import 'package:flutter_application_2023/screens/navpages/ecommerce/widgets/cost_widget.dart';
import 'package:flutter_application_2023/screens/navpages/ecommerce/widgets/rating_star_widget.dart';

class ResultsWidget extends StatelessWidget {
  final ProductModel product;
  const ResultsWidget({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductScreen(productModel: product),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: screenSize.width / 3,
              child: Image.network(
                product.url,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Text(
                product.productName,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Row(
                children: [
                  SizedBox(
                      width: screenSize.width / 5,
                      child: FittedBox(
                          child: RatingStatWidget(rating: product.rating))),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      product.noOfRating.toString(),
                      style: const TextStyle(
                        color: activeCyanColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
              child: FittedBox(
                child: CostWidget(
                  color: const Color.fromARGB(255, 92, 9, 3),
                  cost: product.cost,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
