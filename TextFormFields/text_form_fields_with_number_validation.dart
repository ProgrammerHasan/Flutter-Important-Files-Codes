import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CheckoutPage extends StatefulWidget {
  final amount;
  const CheckoutPage({Key key, @required this.amount}) : super(key: key);
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pay Now'),
      ),
      body: Container(
        child: Padding(padding: EdgeInsets.all(5),
          child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Card(
                        elevation: 5.0,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                style: TextStyle(
                                    fontSize: 14
                                ),
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return 'Please enter your name';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  labelText: 'Enter your name',
                                  labelStyle: TextStyle(
                                    color: Colors.grey[700],
                                  ),
                                  prefixIcon: Icon(Icons.account_circle),
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.only(left: 8, right: 8),
                                ),
                                controller: nameController,
                              ),
                              SizedBox(height: 20,),
                              TextFormField(
                                style: TextStyle(
                                    fontSize: 14
                                ),
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return 'Please enter your phone number';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                ],
                                decoration: InputDecoration(
                                  labelText: 'Enter your phone number',
                                  labelStyle: TextStyle(
                                    color: Colors.grey[700],
                                  ),
                                  prefixIcon: Icon(Icons.phone_android),
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.only(left: 8, right: 8),
                                ),
                                controller: phoneController,
                              ),
                            ],
                          ),
                        )
                    ),
                    Card(
                      elevation: 1.0,
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            title: Align(
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Pay Now',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                    SizedBox(width: 5,),
                                    Icon(Icons.check_circle,color: Colors.green,),
                                  ],
                                )
                            ),
                            onTap: (){
                              if (_formKey.currentState.validate()) {
                                print(widget.amount);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
          ),
        ),
      ),
    );
  }
}
