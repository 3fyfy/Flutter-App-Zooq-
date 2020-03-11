import 'dart:async';


class CartController{
  double _totalPrice=0.0;
final StreamController<double> _totalController=StreamController<double>.broadcast();
Stream<double> get totalStream=>_totalController.stream;
StreamSink<double> get totalSink =>_totalController.sink;

final _addCart=StreamController<double>();
StreamSink<double> get addCart=>_addCart.sink;

  final _minusCart=StreamController<double>();
  StreamSink<double> get minusCart=>_minusCart.sink;


  CartController(){
    _totalPrice=0.0;
    _totalController.add(_totalPrice);
    _addCart.stream.listen(_addPrice);
    _minusCart.stream.listen(_minusPrice);

  }

  void _addPrice(double price){
price++;
    totalSink.add(price);

  }
  void _minusPrice(double price){
price--;
    totalSink.add(price);
  }

  void dispose(){
    _totalController.close();
    _addCart.close();
    _minusCart.close();
  }





}