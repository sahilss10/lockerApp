
class TransactionModel{

  final int billAmt, duration, lockerNo, startTime, endTime;
  final String lockerAdd, lockerName, paymentMethod, qrCode, uid;

  TransactionModel({this.billAmt, this.duration, this.startTime, this.endTime, this.qrCode, this.lockerAdd,
  this.lockerName, this.lockerNo, this.paymentMethod, this.uid});

}