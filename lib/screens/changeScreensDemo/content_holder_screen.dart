
import 'package:flutter/material.dart';

import '../../commons/common_functions.dart';
import 'content_holder_screen_block.dart';
import 'content_holder_screen_dl.dart';

class ContentHolderScreen extends StatefulWidget {
  const ContentHolderScreen({super.key});

  @override
  State<ContentHolderScreen> createState() => _ContentHolderScreenState();
}

class _ContentHolderScreenState extends State<ContentHolderScreen> {
  final ContentHolderScreenBlock _bloc = ContentHolderScreenBlock();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 55),
        child: StreamBuilder<List<ContentHolderScreenDl>>(
            stream: _bloc.myController,
            builder: (context, snapshot) {
              return StreamBuilder<ContentHolderScreenDl>(
                  stream: _bloc.selectedScreenController,
                  builder: (context, position) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Text(
                                "${position.data?.position}/${snapshot.data?.length}",
                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 25),
                              ),
                            ),
                            Expanded(
                              child: Container(),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: InkWell(
                                child: Text(
                                  "Skip",
                                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 25),
                                ),
                                onTap: () => Navigator.pop(context),
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              sliderView(position.data!.mainText, position.data?.subText, position.data?.image),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 40),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: InkWell(
                                  child: (position.data!.position > 1)
                                      ? Text(
                                          "Prev",
                                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 25),
                                        )
                                      : Spacer(),
                                  splashColor: Colors.transparent,
                                  onTap: () {
                                    _bloc.selectSlider(true, position.data ?? _bloc.dataLst.first);
                                  },
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    SizedBox(
                                      height: 10,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: snapshot.data?.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(left: 5,right: 5),
                                            child: Container(
                                              height: 10,
                                              width: 25,
                                              decoration: BoxDecoration(
                                                  color: (position.data?.position) ==index+1 ? Colors.yellow.shade700:Colors.yellow.shade700.withOpacity(0.5),
                                                  borderRadius: BorderRadius.circular(5)
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15, right: 15),
                                child: InkWell(
                                  child: (position.data!.position < snapshot.data!.length)
                                      ? Text(
                                          "Next",
                                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 25),
                                        )
                                      : Text(
                                          "Get Started",
                                          style:
                                              TextStyle(fontWeight: FontWeight.bold, color: Colors.blue.shade900, fontSize: 25),
                                        ),
                                  splashColor: Colors.transparent,
                                  onTap: () {
                                    _bloc.selectSlider(false, position.data ?? _bloc.dataLst.first);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  });
            }),
      ),
    );
  }
}
