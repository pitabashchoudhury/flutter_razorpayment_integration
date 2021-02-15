import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:toast/toast.dart';

class Payment extends StatefulWidget {
  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {

  Razorpay razorpay;
  TextEditingController amount=TextEditingController();
  @override
  void initState() {
    super.initState();

    razorpay = new Razorpay();

    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }
  @override
  void dispose(){
    super.dispose();
    razorpay.clear();
  }

  void handlerPaymentSuccess(){
    print("Pament success");
    Toast.show("Pament success", context);
  }

  void handlerErrorFailure(){
    print("Pament error");
    Toast.show("Pament error", context);
  }

  void handlerExternalWallet(){
    print("External Wallet");
    Toast.show("External Wallet", context);
  }

  void openCheckout(){
    var options = {
      "key" : "rzp_test_0q5FZzzmCBia34",
      "amount" : num.parse(amount.text)*100,
      "name" : "BUBU payment integration test",
      "description" : "Payment for testing purpose only",
      "prefill" : {
        "contact" : "9583871974",
        "email" : "pitabbash98@gmail.com"
      }

    };

    try{
      razorpay.open(options);
    }catch(e){
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("RazorPay",style: TextStyle(
             color: Colors.teal,
            backgroundColor: Colors.red
          ),),

      ),
          body: Center(
            child: Container(
                       alignment: Alignment.center,
              width: 300,
              height: 200,
              decoration: new BoxDecoration(
                borderRadius: new BorderRadius.circular(16.0),
                color: Colors.tealAccent,
              ),
              child:Column(
                  children: [
                    Text("Pay",style: TextStyle(
                      color: Colors.red,
                      fontSize: 16
                    ),
                    ),
                    SizedBox(height: 20,),

                    Padding(
                      padding: const EdgeInsets.only(left: 100,right: 100),
                      child: TextField(
                        controller: amount,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration.collapsed(

                          hintText: "amount"
                        ),

                      ),
                    ),
                    SizedBox(height: 20,),

                    Center(
                      child: RaisedButton(
                        child: Text("Pay",style: TextStyle(
                          color: Colors.black,
                          fontSize: 15

                        ),
                        ),
                        color: Colors.green,
                        splashColor: Colors.red,
                        onPressed: (){
                                openCheckout();
                        },
                      ),
                    )
                  ],
              ) ,


    ),
          ),
    );
  }
}
