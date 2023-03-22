// ignore_for_file: unused_local_variable, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_2023/screens/register_screen.dart';
import 'package:flutter_application_2023/screens/wallet-functions-payment-stuffs/transfer_money.dart';
import 'package:flutter_application_2023/utils/dimensions.dart';
import 'package:flutter_application_2023/widgets/constant.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../provider/auth_provider.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({super.key});

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: klight,
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [kblack, kviolet, kblack, kviolet],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
          ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                Dimensions.width5,
                Dimensions.height20 * 2,
                Dimensions.width5,
                0,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.width10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: Dimensions.height10 * 5,
                              width: Dimensions.width10 * 5,
                              decoration: BoxDecoration(
                                border: Border.all(color: kpink),
                                borderRadius: BorderRadius.circular(
                                  Dimensions.height10,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  Dimensions.height10,
                                ),
                                child: Image.network(
                                  ap.userModel.profilePic,
                                  fit: BoxFit.cover,
                                  height: Dimensions.height10 * 5,
                                  width: Dimensions.width10 * 5,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: Dimensions.width10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  ap.userModel.name.toUpperCase(),
                                  style: GoogleFonts.nunito(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                    color: kwhite,
                                  ),
                                ),
                                Text(
                                  ap.userModel.phoneNumber,
                                  style: GoogleFonts.nunito(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: kwhite,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: Dimensions.height10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Image.asset(
                                'assets/images/qur.png',
                                width: Dimensions.width25,
                                height: Dimensions.height25,
                              ),
                              SizedBox(
                                width: Dimensions.width10 * 2,
                              ),
                              InkWell(
                                onTap: () {
                                  //! route to notification page
                                },
                                child: Image.asset(
                                  'assets/images/notification.png',
                                  width: Dimensions.width25,
                                  height: Dimensions.height25,
                                ),
                              ),
                              SizedBox(
                                width: Dimensions.width10 * 2,
                              ),
                              InkWell(
                                onTap: () {
                                  ap.userSignOut().then(
                                        (value) => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const RegisterScreen(),
                                          ),
                                        ),
                                      );
                                },
                                child: Image.asset(
                                  'assets/images/logout.png',
                                  width: Dimensions.width25,
                                  height: Dimensions.height25,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  Container(
                    height: Dimensions.height70,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      gradient: LinearGradient(
                          colors: [
                            wallet1,
                            wallet2,
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: Dimensions.width25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Text(
                            'Balance',
                            style: GoogleFonts.nunito(
                              fontSize: Dimensions.height20,
                              fontWeight: FontWeight.normal,
                              color: kwhite,
                            ),
                          ),
                          Text(
                            '₹ 100.00',
                            style: GoogleFonts.nunito(
                              fontSize: Dimensions.height25,
                              color: kgold,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Image.asset(
                            'assets/images/eye.png',
                            width: Dimensions.height20 * 2,
                            height: Dimensions.width10 * 4,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      gradient: LinearGradient(
                          colors: [
                            wallet1,
                            wallet2,
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight),
                    ),
                    height: Dimensions.height100,
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.width10,
                        vertical: Dimensions.height10 / 2,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              //! ADD MONEY TO WALLET
                            },
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/images/bank.png',
                                  width: Dimensions.width10 * 6,
                                  height: Dimensions.height20 * 3,
                                ),
                                SizedBox(
                                  height: Dimensions.height10 / 2,
                                ),
                                Text(
                                  'Top-Up',
                                  style: GoogleFonts.nunito(
                                    fontSize: Dimensions.height15,
                                    fontWeight: FontWeight.w600,
                                    color: kwhite,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Image.asset(
                                'assets/images/withdrawal.png',
                                width: Dimensions.width10 * 6,
                                height: Dimensions.height20 * 3,
                              ),
                              SizedBox(
                                height: Dimensions.height10 / 2,
                              ),
                              Text(
                                'Withdraw',
                                style: GoogleFonts.nunito(
                                  fontSize: Dimensions.height15,
                                  fontWeight: FontWeight.w600,
                                  color: kwhite,
                                ),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              //! TRANSFER MONEY USING STRIPE INTEGRATION
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TransferMoney()));
                            },
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/images/transfer.png',
                                  width: Dimensions.height10 * 6,
                                  height: Dimensions.height20 * 3,
                                ),
                                SizedBox(
                                  height: Dimensions.height10 / 2,
                                ),
                                Text(
                                  'Transfer',
                                  style: GoogleFonts.nunito(
                                    fontSize: Dimensions.height15,
                                    fontWeight: FontWeight.w600,
                                    color: kwhite,
                                  ),
                                )
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              //! SHOW TRANSFERED MONEY HISTORY THROUGH STRIPE API & SAVE HISTORY DATA IN FIRESTORE
                            },
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/images/clock.png',
                                  width: Dimensions.height10 * 6,
                                  height: Dimensions.height20 * 3,
                                ),
                                SizedBox(
                                  height: Dimensions.height10 / 2,
                                ),
                                Text(
                                  'History',
                                  style: GoogleFonts.nunito(
                                    fontSize: Dimensions.height15,
                                    fontWeight: FontWeight.w600,
                                    color: kwhite,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.width2,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        gradient: LinearGradient(
                            colors: [
                              wallet1,
                              wallet2,
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight),
                      ),
                      width: double.maxFinite,
                      height: Dimensions.height306,
                      child: Column(
                        children: [
                          //!row 1
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.width10,
                              vertical: Dimensions.height10 / 2,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Image.asset(
                                      'assets/images/grocery.png',
                                      width: Dimensions.height10 * 6,
                                      height: Dimensions.height20 * 3,
                                    ),
                                    SizedBox(
                                      height: Dimensions.height10 / 2,
                                    ),
                                    Text(
                                      'Grocery',
                                      style: GoogleFonts.nunito(
                                        fontSize: Dimensions.height15,
                                        fontWeight: FontWeight.w600,
                                        color: kwhite,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Image.asset(
                                      'assets/images/shopping.png',
                                      width: Dimensions.height10 * 6,
                                      height: Dimensions.height20 * 3,
                                    ),
                                    SizedBox(
                                      height: Dimensions.height10 / 2,
                                    ),
                                    Text(
                                      'Shopping',
                                      style: GoogleFonts.nunito(
                                        fontSize: Dimensions.height15,
                                        fontWeight: FontWeight.w600,
                                        color: kwhite,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Image.asset(
                                      'assets/images/food.png',
                                      width: Dimensions.height10 * 6,
                                      height: Dimensions.height20 * 3,
                                    ),
                                    SizedBox(
                                      height: Dimensions.height10 / 2,
                                    ),
                                    Text(
                                      'Food',
                                      style: GoogleFonts.nunito(
                                        fontSize: Dimensions.height15,
                                        fontWeight: FontWeight.w600,
                                        color: kwhite,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: Dimensions.height10,
                          ),
                          //!row2
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: Dimensions.width10,
                                vertical: Dimensions.height10 / 2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Image.asset(
                                      'assets/images/barcode.png',
                                      width: Dimensions.height10 * 6,
                                      height: Dimensions.height20 * 3,
                                    ),
                                    SizedBox(
                                      height: Dimensions.height10 / 2,
                                    ),
                                    Text(
                                      'Barcode',
                                      style: GoogleFonts.nunito(
                                        fontSize: Dimensions.height15,
                                        fontWeight: FontWeight.w600,
                                        color: kwhite,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Image.asset(
                                      'assets/images/voucher.png',
                                      width: Dimensions.height10 * 6,
                                      height: Dimensions.height20 * 3,
                                    ),
                                    SizedBox(
                                      height: Dimensions.height10 / 2,
                                    ),
                                    Text(
                                      'Voucher',
                                      style: GoogleFonts.nunito(
                                        fontSize: Dimensions.height15,
                                        fontWeight: FontWeight.w600,
                                        color: kwhite,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Image.asset(
                                      'assets/images/ticket.png',
                                      width: Dimensions.height10 * 6,
                                      height: Dimensions.height20 * 3,
                                    ),
                                    SizedBox(
                                      height: Dimensions.height10 / 2,
                                    ),
                                    Text(
                                      'Buy Ticket',
                                      style: GoogleFonts.nunito(
                                        fontSize: Dimensions.height15,
                                        fontWeight: FontWeight.w600,
                                        color: kwhite,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: Dimensions.height10,
                          ),
                          //!row3
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.height10,
                              vertical: Dimensions.height10 / 2,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Image.asset(
                                      'assets/images/bulb.png',
                                      width: Dimensions.height10 * 6,
                                      height: Dimensions.height20 * 3,
                                    ),
                                    SizedBox(
                                      height: Dimensions.height10 / 2,
                                    ),
                                    Text(
                                      'Utilities',
                                      style: GoogleFonts.nunito(
                                        fontSize: Dimensions.height15,
                                        fontWeight: FontWeight.w600,
                                        color: kwhite,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Image.asset(
                                      'assets/images/recharge.png',
                                      width: Dimensions.height10 * 6,
                                      height: Dimensions.height20 * 3,
                                    ),
                                    SizedBox(
                                      height: Dimensions.height10 / 2,
                                    ),
                                    Text(
                                      'Mobile Topup',
                                      style: GoogleFonts.nunito(
                                        fontSize: Dimensions.height15,
                                        fontWeight: FontWeight.w600,
                                        color: kwhite,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Image.asset(
                                      'assets/images/app.png',
                                      width: Dimensions.height10 * 6,
                                      height: Dimensions.height20 * 3,
                                    ),
                                    SizedBox(
                                      height: Dimensions.height10 / 2,
                                    ),
                                    Text(
                                      'Features',
                                      style: GoogleFonts.nunito(
                                        fontSize: Dimensions.height15,
                                        fontWeight: FontWeight.w600,
                                        color: kwhite,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      Dimensions.width2,
                      0,
                      Dimensions.width2,
                      Dimensions.height10 / 2,
                    ),
                    child: Container(
                      height: Dimensions.height150,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: kgrey,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                        child: Image.network(
                          'https://static.vecteezy.com/system/resources/previews/001/631/796/original/blue-dynamic-shape-gift-voucher-discount-coupon-banner-free-vector.jpg',
                          fit: BoxFit.cover,
                          height: Dimensions.height150,
                          width: double.maxFinite,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
