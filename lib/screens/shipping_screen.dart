import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mazloum_app/models/address_model.dart';
import 'package:mazloum_app/services/login_service.dart';

import '../models/payment_model.dart';
import 'credit_card_screen.dart';

class ShippingScreen extends StatefulWidget {
  @override
  State<ShippingScreen> createState() => _ShippingScreenState();
}

class _ShippingScreenState extends State<ShippingScreen> {
  int selectedValue = 0;
  AddressModel addressModel = AddressModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(
      child: FutureBuilder<List<AddressModel>>(
          builder: (context, snapshot) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Shipping Address",style: TextStyle(fontSize: 18)),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(itemBuilder: (context, index) {
                        final item = snapshot.data![index];
                        return SizedBox(
                          height: 100,
                          child: Card(
                            elevation: 1,
                            shape: RoundedRectangleBorder(side: const BorderSide(color: Colors.grey,width: 2),borderRadius: BorderRadius.circular(8)),
                              child: Row(children: [
                                Radio<int>(onChanged: (value) {
                                  setState(() {
                                    selectedValue = value!;
                                    addressModel = item;
                             });
                           },value: snapshot.data![index].id! ,groupValue: selectedValue),
                            const SizedBox(height:double.infinity,child: VerticalDivider(color: Colors.black)),
                            Text("${item.firstLine}, ${item.area} ${item.city}"),
                          ])),
                        );
                        },itemCount: snapshot.data?.length ?? 0),
                    ),
                  ),
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: (){
                        GetIt.instance<PaymentModel>().addressModel = addressModel;
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CreditCardScreen()));
                      },
                      icon: const Icon(Icons.credit_card_sharp),  //icon data for elevated button
                      label: const Text("Proceed to checkout"),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.black
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          future: LoginService().getAddresses()),
    ));
  }
}