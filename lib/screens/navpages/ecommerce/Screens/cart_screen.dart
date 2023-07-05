
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2023/screens/navpages/ecommerce/model/product_model.dart';
import 'package:flutter_application_2023/screens/navpages/ecommerce/providers/user_details_provider.dart';
import 'package:flutter_application_2023/screens/navpages/ecommerce/resources/cloudfirestore_methods.dart';
import 'package:flutter_application_2023/screens/navpages/ecommerce/utils/color_themes.dart';
import 'package:flutter_application_2023/screens/navpages/ecommerce/utils/constants.dart';
import 'package:flutter_application_2023/screens/navpages/ecommerce/utils/utils.dart';
import 'package:flutter_application_2023/screens/navpages/ecommerce/widgets/cart_item_widget.dart';
import 'package:flutter_application_2023/screens/navpages/ecommerce/widgets/custom_main_button.dart';
import 'package:flutter_application_2023/screens/navpages/ecommerce/widgets/search_bar_widget.dart';
import 'package:flutter_application_2023/screens/navpages/ecommerce/widgets/user_details_bar.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchBarWidget(
        hasBackButton: false,
        isReadOnly: true,
      ),
      body: Center(
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(
                  height: kAppBarHeight / 2,
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("users")
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .collection("cart")
                          .snapshots(),
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                              snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CustomMainButton(
                              color: yellowColor,
                              isLoading: true,
                              onPressed: () {},
                              child: const Text(
                                "Loading",
                              ));
                        } else {
                          return CustomMainButton(
                              color: yellowColor,
                              isLoading: false,
                              onPressed: () async {
                                await CloudFirestoreClass().buyAllItemsInCart(
                                    userDetails:
                                        Provider.of<UserDetailsProvider>(
                                                context,
                                                listen: false)
                                            .userDetails);
                                Utils().showSnackBar(
                                    context: context, content: "Done");
                              },
                              child: Text(
                                "Proceed to buy (${snapshot.data!.docs.length}) items",
                                style: const TextStyle(color: Colors.black),
                              ));
                        }
                      },
                    )),
                Expanded(
                    child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("users")
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection("cart")
                      .snapshots(),
                  builder: (context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container();
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            ProductModel model = ProductModel.getModelFromJson(
                                json: snapshot.data!.docs[index].data());
                            return CartItemWidget(product: model);
                          });
                    }
                  },
                ))
              ],
            ),
            const UserDetailsBar(
              offset: 0,
            ),
          ],
        ),
      ),
    );
  }
}
