
import 'package:rxdart/rxdart.dart';

import 'content_holder_screen_dl.dart';

class ContentHolderScreenBlock {
  ContentHolderScreenBlock(){
    myController.sink.add(dataLst);
    selectedScreenController.sink.add(dataLst.first);
  }

  final myController = BehaviorSubject<List<ContentHolderScreenDl>>();
  final selectedScreenController = BehaviorSubject<ContentHolderScreenDl>();
  
  final dataLst = [
    ContentHolderScreenDl("Chose Products", "Demo text, often referred to as placeholder text, is a block of text that is used to fill a space on a website, document, or template where the actual content will eventually be placed.", "https://img.freepik.com/free-vector/sales-consulting-concept-illustration_114360-9147.jpg", 1),
    ContentHolderScreenDl("Make Payment", "the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.", "https://img.freepik.com/free-vector/mobile-payments-concept-illustration_114360-2513.jpg", 2),
    ContentHolderScreenDl("Get Your Order", "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an ", "https://img.freepik.com/free-vector/order-confirmed-concept-illustration_114360-6599.jpg", 3),
    ContentHolderScreenDl("Chose Products", "Demo text, often referred to as placeholder text, is a block of text that is used to fill a space on a website, document, or template where the actual content will eventually be placed.", "https://img.freepik.com/free-vector/sales-consulting-concept-illustration_114360-9147.jpg", 4),

  ];

  void selectSlider(bool isPrev,ContentHolderScreenDl currentSelected) {

    int selectedIndex = dataLst.indexOf(currentSelected);

    if(isPrev){
      selectedIndex--;
    } else {
      selectedIndex++;
    }
    selectedScreenController.sink.add(dataLst[selectedIndex]);
  }

}