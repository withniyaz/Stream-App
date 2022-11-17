import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stream_app/components/LiveCard/live_card.dart';
import 'package:stream_app/constants/color_constants.dart';
import 'package:stream_app/constants/style_constants.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({Key? key}) : super(key: key);

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  List<String> category = ["Trending", "Category", "Latest"];
  String activeCategory = "Trending";

  //Function

  void toggleCategory(String selectedCategory) {
    setState(() {
      activeCategory = selectedCategory;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryDarkColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Discover',
                          style: kHeadTitleSB.copyWith(color: kWhite),
                        ),
                        Text('Find your favorite streamer.',
                            style: kSmallTitleR.copyWith(color: kWhite))
                      ],
                    ),
                    Image.asset(
                      'assets/images/applogowithshadow.png',
                      height: 80,
                      width: 70,
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
                decoration: ShapeDecoration(
                    shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(40)),
                    color: kWhite),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/svg/search.svg'),
                    Text(
                      '   Search channel, topic, etc...',
                      style: kSmallTitleR.copyWith(color: kGreyLight),
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Row(
                      children: category
                          .map((e) =>
                              categoryButton(e, activeCategory, toggleCategory))
                          .toList(),
                    )
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Coding',
                      style: kHeadTitleM.copyWith(color: kWhite),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    liveCard(),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Live Channel',
                      style: kHeadTitleM.copyWith(color: kWhite),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: ShapeDecoration(
                        color: kPrimaryColor,
                        shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                clipBehavior: Clip.antiAlias,
                                height: 90,
                                width: 90,
                                decoration: ShapeDecoration(
                                  color: kRedColor,
                                  shape: ContinuousRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Colors.black.withOpacity(.3),
                                          kSecondaryColor.withOpacity(.7),
                                        ]),
                                  ),
                                  child: Center(
                                    child:
                                        SvgPicture.asset('assets/svg/play.svg'),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Python Coder',
                                            style: kBodyTitleSB.copyWith(
                                                color: kWhite),
                                          ),
                                          Text(
                                            '25K Follower',
                                            style: kSmallTitleR.copyWith(
                                                color: kWhite),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 40,
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                        onPressed: () {},
                                        child: const Text('Follow'),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Edward Younds .',
                                        style: kSmallTitleR.copyWith(
                                            color: kWhite),
                                      ),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                              'assets/svg/watch.svg'),
                                          Text(
                                            '20 Watching',
                                            style: kSmallTitleR.copyWith(
                                                color: kWhite),
                                          )
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget categoryButton(String category, String activeCategory,
    void Function(String selectedCategory) toggleCategory) {
  return GestureDetector(
    onTap: () => toggleCategory(category),
    child: Row(
      children: [
        Opacity(
          opacity: category == activeCategory ? 1 : 0,
          child: Container(
            margin: const EdgeInsets.only(right: 10),
            height: 5,
            width: 5,
            decoration: const ShapeDecoration(
                shape: CircleBorder(), color: kSecondaryColor),
          ),
        ),
        Text(
          '$category   ',
          style: kBodyTitleM.copyWith(
              color: category == activeCategory ? kSecondaryColor : kGreyLight),
        ),
      ],
    ),
  );
}
