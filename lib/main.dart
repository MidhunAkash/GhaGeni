import 'dart:ui';

import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GhaGeni',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> userRequest = [];
  List<String> bucketList = [];
  PageController pageController = PageController();
  SideMenuController sideMenu = SideMenuController();
  SideMenuDisplayMode displayMode = SideMenuDisplayMode.auto;
  TextEditingController chat = TextEditingController();

  @override
  void initState() {
    sideMenu.addListener((index) {
      pageController.jumpToPage(index);
    });
    super.initState();
  }

  void addItem(String text) {
    setState(() {
      debugPrint("you have entered: ${chat.text}");
      userRequest.add(text);
      chat.clear();
    });
  }
  Widget questionButton(String text) {
    return GestureDetector(
      onTap: () {
        setState(() {
          bucketList.add(text);
        });

      },
      child: Container(width: 300, child: Card(
          margin: EdgeInsets.all(10),
          child: Center(child: Text(text)))),
    );
  }
  @override
  Widget build(BuildContext context) {
    double swidth = MediaQuery.of(context).size.width;
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title),
      //   centerTitle: true,
      // ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(left: swidth < 600 ? 10 : 350, right: 10),
        child: ClipRRect(
          //
          borderRadius:
              BorderRadius.all(Radius.circular(50.0)), // Clip it cleanly.
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              color: Colors.white.withOpacity(0.7),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: TextField(
                  style: TextStyle(),
                  controller: chat,
                  minLines: 1,
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  textCapitalization: TextCapitalization.sentences,
                  textInputAction: TextInputAction.newline,
                  decoration: InputDecoration(
                      // fillColor: Colors.white,
                      //   hoverColor: Colors.white,
                      //   focusColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        borderSide: BorderSide(color: Colors.grey, width: 2),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          addItem(chat.text);

                          // add it to a list and iterate below
                          //to call the card funcation
                        },
                        icon: const Icon(
                          Icons.send,
                          color: Colors.blueGrey,
                          size: 30,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        borderSide:
                            BorderSide(color: Colors.blue.shade100, width: 2),
                      ),
                      hintText: 'Type your query...',
                      hintStyle: TextStyle(color: Colors.grey)),
                ),
              ),
            ),
          ),
        ),
      ),
      //implement below the card designed
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SideMenu(
            controller: sideMenu,
            style: SideMenuStyle(
              compactSideMenuWidth: 66,
              itemBorderRadius: BorderRadius.circular(50),
              // showTooltip: false,
              displayMode: displayMode,
              hoverColor: Colors.grey,
              selectedHoverColor: Color.alphaBlend(
                  Color.fromRGBO(
                      Theme.of(context).colorScheme.surfaceTint.red,
                      Theme.of(context).colorScheme.surfaceTint.green,
                      Theme.of(context).colorScheme.surfaceTint.blue,
                      0.08),
                  Colors.blueGrey[300]!),
              selectedColor: Colors.blueGrey,
              selectedTitleTextStyle: const TextStyle(color: Colors.white),
              selectedIconColor: Colors.white,
              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.all(Radius.circular(10)),
              // ),
              // backgroundColor: Colors.blueGrey[700]
            ),
            title: Column(
              children: [
                SideMenuItem(
                  priority: 0,
                  title: 'Bucket List',
                  onTap: (index, _) {
                    setState(() {
                      if (displayMode == SideMenuDisplayMode.auto) {
                        displayMode = SideMenuDisplayMode.open;
                      } else {
                        displayMode = SideMenuDisplayMode.auto;
                      }
                    });
                  },
                  icon: Icon(FaIcon(FontAwesomeIcons.bucket).icon),
                  tooltipContent: "Bucket list",
                ),
                Divider(
                  indent: 8.0,
                  endIndent: 8.0,
                ),
              ],
            ),
            footer: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Logout', style: TextStyle(color: Colors.white)),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blueGrey),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15.0),
                            topRight: Radius.circular(
                                15.0)), // Set rounded radius here
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Clear Everything',
                      style: TextStyle(color: Colors.white)),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blueGrey),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            0.0), // Set rounded radius here
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 50.0,
                  color: Colors.blueGrey,
                )
              ],
            ),
            items: [
              for (int i = 0; i < bucketList.length; i++)
                SideMenuItem(
                  priority: i + 1,
                  title: bucketList[i],
                  onTap: (index, _) {},
                  iconWidget: CircleAvatar(
                    backgroundColor: Colors.grey[300],
                    child: Text("#${i + 1}"),
                  ),
                  tooltipContent: bucketList[i],
                ),
            ],
          ),
          Expanded(
            child: userRequest.length == 0
                ? Center(
                    child: Text("Start searching"),
                  )
                : Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 80),
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: userRequest.length,
                        itemBuilder: (context, index) {
                          return CustomContainer(
                              height: MediaQuery.of(context).size.height / 2,
                              width: MediaQuery.of(context).size.width,
                              question: userRequest[index],
                              answer:
                                  "<API RESPONSE ADD HERE>   In this example, we use a GestureDetector to detect vertical drag gestures on the container. When the user drags vertically, the onVerticalDragUpdate callback is triggered, and the containerHeight value is updated accordingly. The Container widget is wrapped in a GestureDetector and its height is set to containerHeight.When you run this code, you'll see a screen with a blue container. You can drag vertically inside the container to adjust its height. The containerHeight value is updated dynamically, causing the container's height to change accordingly.Feel free to customize the container's color, initial height, and other properties to fit your requirements.",
                              //"To create a ListView inside a Column of a custom widget, you can follow these steps:Create a custom widget: Define a new widget class that extends StatelessWidget or StatefulWidget based on your requirements. This custom widget will contain the Column and the ListView.",
                              questions: [
                                questionButton("This is a Question ejkncrn jjc jj c  wc wouhc wu c coj dcouw c ojh doc wcouh d ?"),
                                questionButton("Something else ?"),
                              ]);
                        }),
                  ),
          ),
        ],
      ),
    );
  }
}

class CustomContainer extends StatelessWidget {
  CustomContainer({
    super.key,
    required this.height,
    required this.width,
    required this.question,
    required this.answer,
    required this.questions,
    //required this.onTap,
  });
  final List<Widget> questions;
  final String question;
  final String answer;
  //implement list
  final double height;
  final double width;
  final Color color = Colors.grey[400]!;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              question,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 15),
            Text(
              answer,
              textAlign: TextAlign.justify,
              maxLines: null,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
            SizedBox(height: 15),
            // Expanded(
            //   flex: 1,
            //   // fit: FlexFit.loose,
            //   child: Container(
            //     decoration: BoxDecoration(
            //       color: Colors.blueGrey[400],
            //       borderRadius: const BorderRadius.all(
            //         Radius.circular(8),
            //       ),
            //     ),
            //     margin: EdgeInsets.all(4),
            //     width: width,
            //     child: Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: Center(
            //         child: Text(
            //           question, // here comes the question
            //           style: const TextStyle(
            //             fontSize: 18,
            //             fontWeight: FontWeight.bold,
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ), //question
            // Expanded(
            //   // fit: FlexFit.loose,
            //   flex: 1,
            //   child: Container(
            //     margin: EdgeInsets.all(4),
            //     width: width,
            //     child: Center(
            //       child: Text(
            //         answer,
            //         //here comes answer
            //         style: const TextStyle(
            //           fontSize: 18,
            //           fontWeight: FontWeight.normal,
            //         ),
            //       ),
            //     ),
            //   ),
            // ), //answer

            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: questions.length,
                itemBuilder: (BuildContext context, int index) {
                  return questions[index];
                },
              ),
            ), //options //todo
          ]),
    );
  }
}
