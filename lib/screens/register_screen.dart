// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter_application_2023/widgets/constant.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import '../provider/auth_provider.dart';
import '../widgets/custom_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController phoneController = TextEditingController();
  bool isLoading = false;

  Country selectedCountry = Country(
    phoneCode: "91",
    countryCode: "IN",
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: "India",
    example: "India",
    displayName: "India",
    displayNameNoCountryCode: "IN",
    e164Key: "",
  );

  @override
  Widget build(BuildContext context) {
    phoneController.selection = TextSelection.fromPosition(
      TextPosition(
        offset: phoneController.text.length,
      ),
    );
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 35),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Color(0xFFA9F1DF),
                Color(
                  0xFFFFBBBB,
                ),
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
            ),
            child: isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset(
                          "assets/images/signupp.png",
                        ),
                      ),
                      const SizedBox(height: 20),
                      GradientText(
                        "REGISTER",
                        style: GoogleFonts.montserrat(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                        colors: [
                          Color(0xFFF94A29),
                          Color(0xFFFFB72B),
                          Color(0xFFF94A29),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Add your phone number. We'll send you a verification code",
                        style: GoogleFonts.lora(
                          fontSize: 14,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        cursorColor: Colors.black,
                        keyboardType: TextInputType.number,
                        controller: phoneController,
                        style: const TextStyle(
                          fontSize: 18,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.bold,
                        ),
                        onChanged: (value) {
                          setState(() {
                            phoneController.text = value;
                          });
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white70,
                          hintText: "Enter phone number",
                          hintStyle: GoogleFonts.lato(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: Colors.grey.shade600,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.black87),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.black87),
                          ),
                          prefixIcon: Container(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                showCountryPicker(
                                    context: context,
                                    countryListTheme:
                                        const CountryListThemeData(
                                      bottomSheetHeight: 550,
                                    ),
                                    onSelect: (value) {
                                      setState(() {
                                        selectedCountry = value;
                                      });
                                    });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  "${selectedCountry.flagEmoji}  +${selectedCountry.phoneCode}",
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          suffixIcon: phoneController.text.length > 9
                              ? Container(
                                  height: 30,
                                  width: 30,
                                  margin: const EdgeInsets.all(10.0),
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.green,
                                  ),
                                  child: const Icon(
                                    Icons.done,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                )
                              : null,
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: CustomButton(
                          text: "LOGIN",
                          onPressed: () {
                            setState(() {
                              isLoading = true;
                            });
                            sendPhoneNumber();
                            setState(() {
                              isLoading = false;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Admin?',
                          style: TextStyle(
                            color: kblack,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  void sendPhoneNumber() {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    String phoneNumber = phoneController.text.trim();
    ap.signInWithPhone(context, "+${selectedCountry.phoneCode}$phoneNumber");
  }
}
