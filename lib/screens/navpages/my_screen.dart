// ignore_for_file: unused_local_variable, prefer_const_constructors, avoid_unnecessary_containers

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter_application_2023/screens/register_screen.dart';

import 'package:flutter_application_2023/utils/dimensions.dart';
import 'package:flutter_application_2023/widgets/constant.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../provider/auth_provider.dart';
import '../wallet-functions-payment-stuffs/transfer_money.dart';

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
];

class MyScreen extends StatefulWidget {
  const MyScreen({super.key});

  @override
  State<MyScreen> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MyScreen> {
  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    return Container(
      color: kblacklight2,
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [kblacklight2, kblacklight2],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter),
              ),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    Dimensions.width5,
                    Dimensions.height10 / 2,
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
                                    border: Border.all(
                                      color: kblacklight,
                                      width: 3,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      Dimensions.height25 * 2,
                                    ),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                      Dimensions.height25 * 2,
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
                                      "Hi  ${ap.userModel.firstname.toLowerCase()}",
                                      style: GoogleFonts.lato(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: klight,
                                      ),
                                    ),
                                    Text(
                                      ap.userModel.phoneNumber,
                                      style: GoogleFonts.lato(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: kblacklight,
                                      ),
                                    ),
                                    Text(
                                      "ID:  ${ap.userModel.unique}",
                                      style: GoogleFonts.lato(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: kblacklight,
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
                                  Icon(
                                    CupertinoIcons.barcode_viewfinder,
                                    color: klight,
                                    size: 22,
                                  ),
                                  SizedBox(
                                    width: Dimensions.width10 * 2,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      //! route to notification page
                                    },
                                    child: Icon(
                                      CupertinoIcons.bell_fill,
                                      color: klight,
                                      size: 22,
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
                                    child: Icon(
                                      CupertinoIcons.square_arrow_right,
                                      color: klight,
                                      size: 22,
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
                          borderRadius: BorderRadius.circular(10.0),
                          gradient: LinearGradient(
                              colors: [kblacklight, kblacklight],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.width25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              Text(
                                'Balance',
                                style: TextStyle(
                                  fontSize: Dimensions.height20,
                                  fontWeight: FontWeight.w500,
                                  color: kblacklight2,
                                ),
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/images/star.png',
                                    width: Dimensions.height20 * 2,
                                    height: Dimensions.width10 * 3,
                                  ),
                                  Text(
                                    '100.00',
                                    style: GoogleFonts.roboto(
                                      fontSize: Dimensions.height25,
                                      color: kblacklight2,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.remove_red_eye,
                                color: kblacklight2,
                                size: 27,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.height10,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            gradient: LinearGradient(
                                colors: [kblacklight, kblacklight],
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
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        width: 160,
                                        decoration: BoxDecoration(
                                          color: kblacklight2,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          border: Border.all(
                                            color: kblacklight2,
                                            width: 0.5,
                                          ),
                                        ),
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 6),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.add_to_photos_sharp,
                                                  color: kblacklight,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  'Top-Up',
                                                  style: GoogleFonts.roboto(
                                                    fontSize:
                                                        Dimensions.height15,
                                                    fontWeight: FontWeight.w500,
                                                    color: klight,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 160,
                                        decoration: BoxDecoration(
                                          color: kblacklight2,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          border: Border.all(
                                            color: kblacklight2,
                                            width: 0.5,
                                          ),
                                        ),
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 6),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons
                                                      .branding_watermark_outlined,
                                                  color: kblacklight,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  'Withdrawl',
                                                  style: GoogleFonts.roboto(
                                                    fontSize:
                                                        Dimensions.height15,
                                                    fontWeight: FontWeight.w500,
                                                    color: klight,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      TransferMoney()));
                                        },
                                        child: Container(
                                          width: 160,
                                          decoration: BoxDecoration(
                                            color: kblacklight2,
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            border: Border.all(
                                              color: kblacklight2,
                                              width: 0.5,
                                            ),
                                          ),
                                          child: Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 6),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.money,
                                                    color: kblacklight,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    'Transfer',
                                                    style: GoogleFonts.roboto(
                                                      fontSize:
                                                          Dimensions.height15,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: klight,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 160,
                                        decoration: BoxDecoration(
                                          color: kblacklight2,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          border: Border.all(
                                            color: kblacklight2,
                                            width: 0.5,
                                          ),
                                        ),
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 6),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.history,
                                                  color: kblacklight,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  'History',
                                                  style: GoogleFonts.roboto(
                                                    fontSize:
                                                        Dimensions.height15,
                                                    fontWeight: FontWeight.w500,
                                                    color: klight,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
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
                          ),
                          width: double.maxFinite,
                          height: Dimensions.height306,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  "All Features",
                                  style: GoogleFonts.lato(
                                    color: kwhite,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                SizedBox(
                                  height: Dimensions.height10 / 2,
                                ),
                                Flexible(
                                  child: ListView(
                                    itemExtent: 70,
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    children: [
                                      Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        elevation: 2,
                                        color: kblacklight,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Image.asset(
                                                'assets/images/grocery.png',
                                                width: Dimensions.height10 * 5,
                                                height: Dimensions.height20 * 3,
                                              ),
                                              SizedBox(
                                                width: Dimensions.width25 * 2,
                                              ),
                                              Text(
                                                'Grocery',
                                                style: GoogleFonts.lato(
                                                  fontSize: Dimensions.height18,
                                                  fontWeight: FontWeight.w600,
                                                  color: wallet2,
                                                ),
                                              ),
                                              SizedBox(
                                                width: Dimensions.width25 * 2,
                                              ),
                                              Icon(
                                                Icons.arrow_forward_ios,
                                                color: wallet2,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        elevation: 2,
                                        color: kblacklight,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Image.asset(
                                                'assets/images/shopping.png',
                                                width: Dimensions.height10 * 5,
                                                height: Dimensions.height20 * 3,
                                              ),
                                              SizedBox(
                                                width: Dimensions.width25 * 2,
                                              ),
                                              Text(
                                                'Shopping',
                                                style: GoogleFonts.lato(
                                                  fontSize: Dimensions.height18,
                                                  fontWeight: FontWeight.w600,
                                                  color: wallet2,
                                                ),
                                              ),
                                              SizedBox(
                                                width: Dimensions.width25 * 2,
                                              ),
                                              Icon(
                                                Icons.arrow_forward_ios,
                                                color: wallet2,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        elevation: 2,
                                        color: kblacklight,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Image.asset(
                                                'assets/images/food.png',
                                                width: Dimensions.height10 * 5,
                                                height: Dimensions.height20 * 3,
                                              ),
                                              SizedBox(
                                                width: Dimensions.width25 * 2,
                                              ),
                                              Text(
                                                'Food',
                                                style: GoogleFonts.lato(
                                                  fontSize: Dimensions.height18,
                                                  fontWeight: FontWeight.w600,
                                                  color: wallet2,
                                                ),
                                              ),
                                              SizedBox(
                                                width: Dimensions.width25 * 2,
                                              ),
                                              Icon(
                                                Icons.arrow_forward_ios,
                                                color: wallet2,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        elevation: 2,
                                        color: kblacklight,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Image.asset(
                                                'assets/images/barcode.png',
                                                width: Dimensions.height10 * 5,
                                                height: Dimensions.height20 * 3,
                                              ),
                                              SizedBox(
                                                width: Dimensions.width25 * 2,
                                              ),
                                              Text(
                                                'Barcode',
                                                style: GoogleFonts.lato(
                                                  fontSize: Dimensions.height18,
                                                  fontWeight: FontWeight.w600,
                                                  color: wallet2,
                                                ),
                                              ),
                                              SizedBox(
                                                width: Dimensions.width25 * 2,
                                              ),
                                              Icon(
                                                Icons.arrow_forward_ios,
                                                color: wallet2,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        elevation: 2,
                                        color: kblacklight,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Image.asset(
                                                'assets/images/voucher.png',
                                                width: Dimensions.height10 * 5,
                                                height: Dimensions.height20 * 3,
                                              ),
                                              SizedBox(
                                                width: Dimensions.width25 * 2,
                                              ),
                                              Text(
                                                'Voucher',
                                                style: GoogleFonts.lato(
                                                  fontSize: Dimensions.height18,
                                                  fontWeight: FontWeight.w600,
                                                  color: wallet2,
                                                ),
                                              ),
                                              SizedBox(
                                                width: Dimensions.width25 * 2,
                                              ),
                                              Icon(
                                                Icons.arrow_forward_ios,
                                                color: wallet2,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        elevation: 2,
                                        color: kblacklight,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Image.asset(
                                                'assets/images/ticket.png',
                                                width: Dimensions.height10 * 5,
                                                height: Dimensions.height20 * 3,
                                              ),
                                              SizedBox(
                                                width: Dimensions.width25 * 2,
                                              ),
                                              Text(
                                                'Buy Ticket',
                                                style: GoogleFonts.lato(
                                                  fontSize: Dimensions.height18,
                                                  fontWeight: FontWeight.w600,
                                                  color: wallet2,
                                                ),
                                              ),
                                              SizedBox(
                                                width: Dimensions.width25 * 2,
                                              ),
                                              Icon(
                                                Icons.arrow_forward_ios,
                                                color: wallet2,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        elevation: 2,
                                        color: kblacklight,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Image.asset(
                                                'assets/images/bulb.png',
                                                width: Dimensions.height10 * 5,
                                                height: Dimensions.height20 * 3,
                                              ),
                                              SizedBox(
                                                width: Dimensions.width25 * 2,
                                              ),
                                              Text(
                                                'Utilities',
                                                style: GoogleFonts.lato(
                                                  fontSize: Dimensions.height18,
                                                  fontWeight: FontWeight.w600,
                                                  color: wallet2,
                                                ),
                                              ),
                                              SizedBox(
                                                width: Dimensions.width25 * 2,
                                              ),
                                              Icon(
                                                Icons.arrow_forward_ios,
                                                color: wallet2,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        elevation: 2,
                                        color: kblacklight,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Image.asset(
                                                'assets/images/recharge.png',
                                                width: Dimensions.height10 * 5,
                                                height: Dimensions.height20 * 3,
                                              ),
                                              SizedBox(
                                                width: Dimensions.width25 * 2,
                                              ),
                                              Text(
                                                'Mobile Topup',
                                                style: GoogleFonts.lato(
                                                  fontSize: Dimensions.height18,
                                                  fontWeight: FontWeight.w600,
                                                  color: wallet2,
                                                ),
                                              ),
                                              SizedBox(
                                                width: Dimensions.width25 * 2,
                                              ),
                                              Icon(
                                                Icons.arrow_forward_ios,
                                                color: wallet2,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        elevation: 2,
                                        color: kblacklight,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Image.asset(
                                                'assets/images/app.png',
                                                width: Dimensions.height10 * 5,
                                                height: Dimensions.height20 * 3,
                                              ),
                                              SizedBox(
                                                width: Dimensions.width25 * 2,
                                              ),
                                              Text(
                                                'Features',
                                                style: GoogleFonts.lato(
                                                  fontSize: Dimensions.height18,
                                                  fontWeight: FontWeight.w600,
                                                  color: wallet2,
                                                ),
                                              ),
                                              SizedBox(
                                                width: Dimensions.width25 * 2,
                                              ),
                                              Icon(
                                                Icons.arrow_forward_ios,
                                                color: wallet2,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
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
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  "Exciting Offers",
                                  style: GoogleFonts.lato(
                                    color: kwhite,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              CarouselSlider(
                                items: imgList
                                    .map((item) => Container(
                                          child: Center(
                                            child: Image.network(
                                              item,
                                              fit: BoxFit.cover,
                                              width: 1000,
                                            ),
                                          ),
                                        ))
                                    .toList(),
                                options: CarouselOptions(
                                  autoPlay: true,
                                  aspectRatio: 2.0,
                                  enlargeCenterPage: true,
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
