// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_application_2023/utils/dimensions.dart';
import 'package:flutter_application_2023/widgets/constant.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:toast/toast.dart';

class TransferMoney extends StatefulWidget {
  const TransferMoney({super.key});

  @override
  State<TransferMoney> createState() => _TransferMoneyState();
}

class _TransferMoneyState extends State<TransferMoney> {
  late Razorpay razorpay;
  TextEditingController textEditingController = TextEditingController();
  @override
  void initState() {
    super.initState();
    razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    razorpay.clear();
  }

  void openCheckOut() {
    var options = {
      "key": "rzp_test_1TYvpw9zV2KWjI",
      "amount": num.parse(textEditingController.text) * 100,
      "name": "GoSpeedy",
      "description":
          "sending money to friend or paying for some random product",
      "prefill": {
        "contact": "2323232323",
        "email": "test@gmail.com",
      },
      "external": {
        "wallets": ['paytm']
      }
    };
    try {
      razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  void handlerPaymentSuccess() {
    Toast.show(
      'Payment Success!',
      duration: Toast.lengthShort,
      gravity: Toast.bottom,
    );
  }

  void handlerErrorFailure() {
    Toast.show(
      'Payment Error!',
      duration: Toast.lengthShort,
      gravity: Toast.bottom,
    );
  }

  void handlerExternalWallet() {
    Toast.show(
      'External Wallet!',
      duration: Toast.lengthShort,
      gravity: Toast.bottom,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kblack,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('SEND MONEY'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                Dimensions.width10 * 5,
                Dimensions.height100,
                Dimensions.width10 * 5,
                Dimensions.height100,
              ),
              child: TextField(
                controller: textEditingController,
                decoration: InputDecoration(
                  hintText: "Amount to pay",
                  hintStyle: TextStyle(
                    color: kblack,
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.only(
                    left: 15,
                    bottom: 11,
                    top: 11,
                    right: 15,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: Dimensions.height20,
            ),
            InkWell(
              onTap: () {
                openCheckOut();
              },
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: Dimensions.height20 * 2,
                  width: Dimensions.width120,
                  child: Center(
                      child: Text(
                    'Send Money',
                    style: TextStyle(
                      color: kwhite,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                  decoration: BoxDecoration(
                    color: kblue,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
