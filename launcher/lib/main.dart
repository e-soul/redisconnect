import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:carousel_slider/carousel_slider.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

import 'item_card.dart';
import 'theme.dart';
import 'window_buttons.dart';

void main() {
  runApp(const Launcher());
  doWhenWindowReady(() {
    const initialSize = Size(1150, 458);
    appWindow.minSize = initialSize;
    appWindow.size = initialSize;
    appWindow.alignment = Alignment.center;
    appWindow.show();
  });
}

class Launcher extends StatelessWidget {
  const Launcher({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        // theme: ThemeData(
        //   primarySwatch: Colors.blue,
        // ),
        home: GamesCarousel());
  }
}

class GamesCarousel extends StatefulWidget {
  const GamesCarousel({super.key});

  @override
  GamesCarouselState createState() => GamesCarouselState();
}

class GamesCarouselState extends State<GamesCarousel> {
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  List<Widget> cardList = [];

  @override
  void initState() {
    super.initState();
    rootBundle
        .loadString('assets/games.json')
        .then((value) => fillCards(value));
  }

  void fillCards(String jsonString) {
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    List<Widget> tempCardList = [];
    for (final entry in jsonMap.entries) {
      tempCardList.add(ItemCard(
        imagePath: entry.value["image"],
        text: entry.value["displayName"],
        genre: entry.value["genre"],
        onPressed: () async {
          await Process.start(entry.value["executable"], []);
        },
      ));
    }

    setState(() {
      cardList = tempCardList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MainTheme.backgroundColor,
        body: WindowBorder(
            color: MainTheme.backgroundColor,
            child: Column(
              children: [
                WindowTitleBarBox(
                    child: Row(
                  children: [
                    Expanded(child: MoveWindow()),
                    const WindowButtons()
                  ],
                )),
                Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CarouselSlider(
                        items: cardList,
                        carouselController: _carouselController,
                        options: CarouselOptions(
                            height: 400,
                            autoPlay: false,
                            enlargeCenterPage: false,
                            viewportFraction: 0.33,
                            onPageChanged: (index, reason) {
                              setState(() {});
                            }),
                      ),
                      Positioned(
                        left: 0,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back_ios),
                          onPressed: () {
                            _carouselController.previousPage();
                          },
                        ),
                      ),
                      Positioned(
                        right: 0,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_forward_ios),
                          onPressed: () {
                            _carouselController.nextPage();
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )));
  }
}
