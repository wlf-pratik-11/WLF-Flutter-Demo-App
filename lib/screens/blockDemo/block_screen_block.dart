import 'dart:async';

class BlockScreenBlock{
  final _myController = StreamController<String>();
  Stream<String> get myStream => _myController.stream;
  Sink<String> get mySink => _myController.sink;

  void processEvent(String event){
    String newState = "Processed $event";
    mySink.add(newState);
  }

  void dispose(){
    _myController.close();
  }

}