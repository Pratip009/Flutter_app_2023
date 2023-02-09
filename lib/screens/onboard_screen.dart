// ignore_for_file: library_private_types_in_public_api, sized_box_for_whitespace, use_build_context_synchronously, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_2023/screens/welcome_screen.dart';
import 'package:flutter_application_2023/utils/dimensions.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../widgets/onboard_model.dart';
import '../widgets/constant.dart';

class OnBoardScreen extends StatefulWidget {
  const OnBoardScreen({super.key});

  @override
  _OnBoardScreenState createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  int currentIndex = 0;
  late PageController _pageController;
  List<OnboardModel> screens = <OnboardModel>[
    OnboardModel(
      img: 'assets/images/market.jpg',
      text: "Go To Market",
      desc: "Fresh and green foods\n fast free delevery",
      bg: Colors.white,
      button: const Color(0xFFFBBC05),
    ),
    OnboardModel(
      img: 'assets/images/pay.jpg',
      text: "Pay",
      desc: "Quick money transfer \n free withdrawl",
      bg: Colors.white,
      button: const Color(0xFFFBBC05),
    ),
    OnboardModel(
      img: 'assets/images/shopping.jpg',
      text: "Shopping",
      desc: "Earn upto 7% when you trade via \n Ftripay wallet",
      bg: Colors.white,
      button: const Color(0xFFFBBC05),
    ),
  ];

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  _storeOnboardInfo() async {
    int isViewed = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('onBoard', isViewed);
  }

  @override
  Widget build(BuildContext context) {
    print('height' + MediaQuery.of(context).size.height.toString());
    print('width' + MediaQuery.of(context).size.width.toString());
    // print("The height is " + MediaQuery.of(context).size.height.toString());
    // print("The width is " + MediaQuery.of(context).size.width.toString());
    return Scaffold(
      backgroundColor: currentIndex % 2 == 0 ? kwhite : kwhite,
      appBar: AppBar(
        backgroundColor: kwhite,
        elevation: 0.0,
        actions: [
          TextButton(
            onPressed: () {
              _storeOnboardInfo();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const WelcomeScreen(),
                ),
              );
            },
            child: Row(
              children: [
                Text(
                  "Skip",
                  style: GoogleFonts.lato(
                    color: kblue,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: Dimensions.width5,
                ),
                Icon(
                  Icons.arrow_forward,
                  color: kblue,
                ),
              ],
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: PageView.builder(
            itemCount: screens.length,
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (int index) {
              setState(() {
                currentIndex = index;
              });
            },
            itemBuilder: (_, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    screens[index].img,
                  ),
                  Container(
                    height: 10.0,
                    child: ListView.builder(
                      itemCount: screens.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 3.0),
                                width: currentIndex == index ? 25 : 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: currentIndex == index
                                      ? kbrown
                                      : kbrown300,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ]);
                      },
                    ),
                  ),
                  Text(
                    screens[index].text,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.alegreya(
                      fontSize: 27.0,
                      fontWeight: FontWeight.bold,
                      color: kblack,
                      letterSpacing: 4,
                    ),
                  ),
                  Text(
                    screens[index].desc,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.abyssinicaSil(
                      fontSize: 17.0,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      if (index == screens.length - 1) {
                        await _storeOnboardInfo();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const WelcomeScreen()));
                      }

                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.linear,
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.width15 * 2,
                        vertical: Dimensions.height10,
                      ),
                      decoration: BoxDecoration(
                          color: kyellow,
                          borderRadius: BorderRadius.circular(15.0)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Next",
                            style: GoogleFonts.lato(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: kblack,
                              letterSpacing: 5,
                            ),
                          ),
                          SizedBox(
                            width: Dimensions.width15,
                          ),
                          Icon(
                            Icons.arrow_forward_sharp,
                            color: kblack,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              );
            }),
      ),
    );
  }
}
