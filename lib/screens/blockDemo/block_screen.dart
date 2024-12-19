import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:main_app_demo/commons/multi_language_strings.dart';
import 'package:main_app_demo/screens/blockDemo/block_screen_block.dart';

import '../../commons/common_functions.dart';
import '../../commons/my_colors.dart';

class BlockScreen extends StatefulWidget {
  const BlockScreen({super.key});

  @override
  State<BlockScreen> createState() => _BlockScreenState();
}

class _BlockScreenState extends State<BlockScreen> {

  final BlockScreenBlock _block =  BlockScreenBlock();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            MultiLanguageStrings.blockArchDemo,
            style: appbarTextStyle(),
          ),
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: MyColors.darkBlue,
          systemOverlayStyle: SystemUiOverlayStyle(
            systemStatusBarContrastEnforced: true,
            // statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
          ),
        ),
      body: Center(
        child: StreamBuilder<String>(
            stream: _block.myStream,
            builder: (context,snapshot){
              if(snapshot.hasData){
                return Text(snapshot.data.toString());
              }else{
                return Text("No Deta..!!");
              }
            }
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            _block.processEvent("Button Clicked");
          },
        child: Icon(Icons.add),
      ),
    );
  }
  @override
  void dispose(){
    _block.dispose();
    super.dispose();
  }
}
