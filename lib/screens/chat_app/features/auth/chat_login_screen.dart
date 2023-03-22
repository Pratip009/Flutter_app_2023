import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2023/utils/dimensions.dart';
import 'package:flutter_application_2023/widgets/chat_custom_button.dart';


class ChatLoginScreen extends StatefulWidget {
  static const routeName = '/chat-login-screen';
  const ChatLoginScreen({super.key});

  @override
  State<ChatLoginScreen> createState() => _ChatLoginScreenState();
}

class _ChatLoginScreenState extends State<ChatLoginScreen> {
  final phoneCotroller = TextEditingController();

  Country? country;

  @override
  void dispose() {
    super.dispose();
    phoneCotroller.dispose();
  }

  void pickCountry() {
    showCountryPicker(
        context: context,
        onSelect: (Country _country) {
          setState(() {
            country = _country;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ENTER YOUR PHONE NUMBER'),
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              const Text('Chat App need to verify your phone number'),
              SizedBox(
                height: Dimensions.height10,
              ),
              TextButton(
                onPressed: pickCountry,
                child: const Text('Pick Country'),
              ),
              SizedBox(
                height: Dimensions.height10 / 2,
              ),
              Row(
                children: [
                  if (country != null) Text('+${country!.phoneCode}'),
                  SizedBox(
                    width: Dimensions.width10,
                  ),
                  SizedBox(
                    width: Dimensions.screenWidth * 0.7,
                    child: TextField(
                      controller: phoneCotroller,
                      decoration: InputDecoration(hintText: ' Phone Number'),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: Dimensions.height100,
              ),
              SizedBox(
                width: 90,
                child: ChatCustomButton(
                  onPressed: () {},
                  text: 'NEXT',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
