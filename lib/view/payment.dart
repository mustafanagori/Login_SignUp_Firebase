import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController cvcController = TextEditingController();
    final TextEditingController expiryController = TextEditingController();
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        centerTitle: true,
        title: const Text("Card Payment"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: w * 0.02,
            vertical: h * 0.01,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                height: h * 0.45,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Colors.black45,
                    width: 0.5,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Card Number",
                      style: TextStyle(fontSize: 18, color: Colors.blue),
                    ),
                    SizedBox(
                      height: h * 0.02,
                    ),
                    Pinput(
                      controller: expiryController,
                      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                      length: 8,
                      defaultPinTheme: PinTheme(
                        width: 35,
                        height: 35,
                        textStyle: TextStyle(fontSize: 16, color: Colors.blue),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      onCompleted: (pin) => print('Pin entered is: $pin'),
                    ),
                    SizedBox(
                      height: h * 0.02,
                    ),

                    Text(
                      "Card Holder Name",
                      style: TextStyle(fontSize: 18, color: Colors.blue),
                    ),
                    SizedBox(
                      height: h * 0.02,
                    ),
                    // text field name
                    SizedBox(
                      height: h * 0.05,
                      width: double.infinity,
                      child: TextFormField(
                        cursorColor: Colors.blue,
                        decoration: InputDecoration(
                          hintText: "0000 0000 0000 0000",
                          focusColor: Colors.blue,
                          hoverColor: Colors.blue,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.blue, // Set the border color here
                              width: 1.0,
                            ),
                          ),
                          fillColor: Colors.blue,
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue,
                              width: 1.0,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: h * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Expire Date",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.blue),
                            ),
                            SizedBox(
                              height: h * 0.02,
                            ),
                            Pinput(
                              controller: expiryController,
                              pinputAutovalidateMode:
                                  PinputAutovalidateMode.onSubmit,
                              length: 2,
                              defaultPinTheme: PinTheme(
                                width: 35,
                                height: 35,
                                textStyle:
                                    TextStyle(fontSize: 16, color: Colors.blue),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              onCompleted: (pin) =>
                                  print('Pin entered is: $pin'),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "CVV",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.blue),
                            ),
                            SizedBox(
                              height: h * 0.02,
                            ),
                            Pinput(
                              controller: cvcController,
                              pinputAutovalidateMode:
                                  PinputAutovalidateMode.onSubmit,
                              length: 3,
                              defaultPinTheme: PinTheme(
                                width: 35,
                                height: 35,
                                textStyle: TextStyle(
                                    fontSize: 18, color: Colors.black),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onCompleted: (pin) =>
                                  print('Pin entered is: $pin'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: h * 0.05,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total Pay ",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "\$100",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: h * 0.15,
              ),
              Padding(
                padding: EdgeInsets.only(bottom: h * 0.02),
                child: SizedBox(
                  width: double.infinity,
                  height: h * 0.06,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      backgroundColor: Colors.blue,
                    ),
                    onPressed: () {
                      Get.to(const Payment());
                    },
                    child: const Text(
                      "Pay Now",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
