import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:flutter_credit_card/custom_card_type_icon.dart';
import 'package:flutter_credit_card/glassmorphism_config.dart';
import 'package:flutter_mpgs_sdk/flutter_mpgs.dart';
import 'package:get_it/get_it.dart';
import 'package:mazloum_app/models/payment_model.dart';
import 'package:mazloum_app/services/payment_service.dart';
import 'package:mazloum_app/widgets/mazloum_app_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';

class CreditCardScreen extends StatefulWidget {
  CreditCardScreen({Key? key}) : super(key: key);

  @override
  State<CreditCardScreen> createState() => _CreditCardScreenState();
}

class _CreditCardScreenState extends State<CreditCardScreen> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  bool useGlassMorphism = false;
  bool useBackgroundImage = false;
  OutlineInputBorder? border;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey.withOpacity(0.7),
        width: 2.0,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MazloumAppBar(title: '',hasBack: true,isDetailed: false),
      body: SafeArea(
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 30,
          ),
          CreditCardWidget(
            glassmorphismConfig:
            useGlassMorphism ? Glassmorphism.defaultConfig() : null,
            cardNumber: cardNumber,
            expiryDate: expiryDate,
            cardHolderName: cardHolderName,
            cvvCode: cvvCode,
            bankName: 'MASTER CARD',
            showBackView: isCvvFocused,
            obscureCardNumber: true,
            obscureCardCvv: true,
            isHolderNameVisible: true,
            cardBgColor: Colors.red,
            backgroundImage:
            useBackgroundImage ? 'assets/card_bg.png' : null,
            isSwipeGestureEnabled: true,
            onCreditCardWidgetChange:
                (CreditCardBrand creditCardBrand) {},
            customCardTypeIcons: <CustomCardTypeIcon>[
              CustomCardTypeIcon(
                cardType: CardType.mastercard,
                cardImage: Image.asset(
                  'assets/mastercard.png',
                  height: 48,
                  width: 48,
                ),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  CreditCardForm(
                    formKey: formKey,
                    obscureCvv: true,
                    obscureNumber: true,
                    cardNumber: cardNumber,
                    cvvCode: cvvCode,
                    isHolderNameVisible: true,
                    isCardNumberVisible: true,
                    isExpiryDateVisible: true,
                    cardHolderName: cardHolderName,
                    expiryDate: expiryDate,
                    themeColor: Colors.blue,
                    textColor: Colors.black,
                    cardNumberDecoration: InputDecoration(
                      labelText: 'Number',
                      hintText: 'XXXX XXXX XXXX XXXX',
                      hintStyle: const TextStyle(color: Colors.black),
                      labelStyle: const TextStyle(color: Colors.black),
                      focusedBorder: border,
                      enabledBorder: border,
                    ),
                    expiryDateDecoration: InputDecoration(
                      hintStyle: const TextStyle(color: Colors.black),
                      labelStyle: const TextStyle(color: Colors.black),
                      focusedBorder: border,
                      enabledBorder: border,
                      labelText: 'Expired Date',
                      hintText: 'XX/XX',
                    ),
                    cvvCodeDecoration: InputDecoration(
                      hintStyle: const TextStyle(color: Colors.black),
                      labelStyle: const TextStyle(color: Colors.black),
                      focusedBorder: border,
                      enabledBorder: border,
                      labelText: 'CVV',
                      hintText: 'XXX',
                    ),
                    cardHolderDecoration: InputDecoration(
                      hintStyle: const TextStyle(color: Colors.black),
                      labelStyle: const TextStyle(color: Colors.black),
                      focusedBorder: border,
                      enabledBorder: border,
                      labelText: 'Card Holder',
                    ),
                    onCreditCardModelChange: onCreditCardModelChange,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                /*  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        'Glassmorphism',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      Switch(
                        value: useGlassMorphism,
                        inactiveTrackColor: Colors.grey,
                        activeColor: Colors.black,
                        activeTrackColor: Colors.green,
                        onChanged: (bool value) => setState(() {
                          useGlassMorphism = value;
                        }),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        'Card Image',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      Switch(
                        value: useBackgroundImage,
                        inactiveTrackColor: Colors.grey,
                        activeColor: Colors.black,
                        activeTrackColor: Colors.green,
                        onChanged: (bool value) => setState(() {
                          useBackgroundImage = value;
                        }),
                      ),
                    ],
                  ),*/
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      backgroundColor:  Colors.black,
                    ),
                    child: Container(
                      margin: const EdgeInsets.all(12),
                      child: const Text(
                        'Validate',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          package: 'flutter_credit_card',
                        ),
                      ),
                    ),
                    onPressed: () async {
                      final temp =  UserModel.fromJson(jsonDecode(GetIt.instance<SharedPreferences>().getString('user')!));
                      final temp2 = await  PaymentService().createSession(true, GetIt.instance<PaymentModel>().addressModel.id!);
                      try {
                        await FlutterMpgsSdk.init(region: Region.ASIA_PACIFIC,
                            gatewayId: temp2.merchant!,
                            apiVersion: "49");
                      }on PlatformException catch (e) {
                        print(e);
                      }
                      _updateSession(temp2.sessionId!);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
    );
  }

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    setState(() {
      cardNumber = creditCardModel!.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }

  Future<void> _updateSession(String sessionId) async {
    String? updateStatus = "";
    print(cardHolderName);
    print(cardNumber);
    print(expiryDate.split("/").last);
    print(expiryDate.split("/").first);
    print(cvvCode);
    try {

      await FlutterMpgsSdk.updateSession(
          sessionId: sessionId,
          cardHolder: cardHolderName,
          cardNumber: cardNumber,
          year: expiryDate.split("/").last,
          month: expiryDate.split("/").first,
          cvv: cvvCode);
      print(sessionId);
    }    catch (e) {
      print(e);

    }
  }
}