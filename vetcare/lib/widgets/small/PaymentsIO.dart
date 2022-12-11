import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

String DocId;

void Payment({String name, String image, int price, String description, String docId}){
  final _razorpay= Razorpay();
  _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
  _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
  _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  DocId=docId;
  var options = {
    'key': 'rzp_test_C14Zx3jL8F3fuD',
    'amount': price*100,
    'name': name,
    'description': description,
    'prefill': {
      'contact': '6205677308',
      'email': 'test@razorpay.com'
    }
  };

  try{
    _razorpay.open(options);
  } catch(e){
    print(e.toString());
  }


  _razorpay.clear();
}

void _handlePaymentSuccess(PaymentSuccessResponse response) {
  print("\n\n\n\n------------------------------------------\n\n\n\n");
  Fluttertoast.showToast(msg: 'Payment Success');
  Fluttertoast.showToast(msg: 'Id_ '+response.paymentId);
  FirebaseFirestore.instance.collection('doctors').doc(DocId).update({
    'payment': true,
    'timestamp': DateTime.now(),
  });

}

void _handlePaymentError(PaymentFailureResponse response) {
  Fluttertoast.showToast(msg: 'Payment Failure');
  Fluttertoast.showToast(msg: 'Id_ '+response.message);
}

void _handleExternalWallet(ExternalWalletResponse response) {
  Fluttertoast.showToast(msg: 'Payment Wallet');
  Fluttertoast.showToast(msg: 'Id_ '+response.walletName);
  FirebaseFirestore.instance.collection('doctors').doc(DocId).update({
    'payment': true,
    'timestamp': DateTime.now(),
  });
}
