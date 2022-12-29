import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stream_app/components/Buttons/solid_button.dart';
import 'package:stream_app/components/InputField/textinput_field.dart';
import 'package:http/http.dart' as http;
import 'package:stream_app/components/LiveCard/livestream_card.dart';
import 'package:stream_app/components/Snackbars/popup_snackbar.dart';
import 'package:stream_app/components/zeroState.dart';
import 'package:stream_app/constants/app_constants.dart';
import 'package:stream_app/constants/color_constants.dart';
import 'package:stream_app/constants/style_constants.dart';
import 'package:lottie/lottie.dart';
import 'package:stream_app/constants/validator_constants.dart';
import 'package:stream_app/models/stream/stream_model.dart';
import 'package:stream_app/services/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Initializations and Instances
  final ApiService _apiProvider = ApiService();
  // States
  List<String> category = ["Trending", "Category", "Latest"];
  List<Stream> stream = [];
  String activeCategory = "Trending";

  // Function
  void toggleCategory(String selectedCategory) {
    setState(() {
      activeCategory = selectedCategory;
    });
  }

  // Fetch all streams
  Future<void> fetchStream() async {
    final Response res = await _apiProvider.get(
      '/stream',
    );
    if (res.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(res.body);
      setState(() {
        stream = List<Stream>.from(data["data"].map((x) => Stream.fromJson(x)));
      });
    }
  }

  // Stream callback
  void streamcb() {
    fetchStream();
  }

  Future<void> _pullRefresh() async {
    fetchStream();
  }

  @override
  void initState() {
    fetchStream();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryDarkColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: kRedColor,
        child: const Icon(Icons.add),
        onPressed: () => _showStreamSheet(context, streamcb),
      ),
      body: RefreshIndicator(
        onRefresh: _pullRefresh,
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
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
                            .map((e) => categoryButton(
                                e, activeCategory, toggleCategory))
                            .toList(),
                      )
                    ],
                  ),
                ),
                // Container(
                //   padding:
                //       const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                //   child: Column(
                //     mainAxisAlignment: MainAxisAlignment.start,
                //     crossAxisAlignment: CrossAxisAlignment.stretch,
                //     children: [
                //       Text(
                //         '$activeCategory',
                //         style: kHeadTitleM.copyWith(color: kWhite),
                //       ),
                //       const SizedBox(
                //         height: 15,
                //       ),
                //       liveCard(),
                //     ],
                //   ),
                // ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: stream.isEmpty
                      ? zerostate(
                          icon: "assets/lotties/live.json",
                          head: "No Live Streams",
                          sub: "Currently no live streams available",
                          type: "lottie")
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Live Streams',
                              style: kHeadTitleM.copyWith(color: kWhite),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.only(top: 10),
                              itemCount: stream.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return liveStreamCard(stream[index], context);
                              },
                            ),
                          ],
                        ),
                )
              ],
            ),
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

///[Start new stream]
_showStreamSheet(BuildContext context, void Function() streamcb) {
  // Initializations and Instances
  final ImagePicker picker = ImagePicker();
  final GlobalKey<ScaffoldState> _modelScaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController streamNameController = TextEditingController();
  TextEditingController streamPasswordController = TextEditingController();
  File? thumbnail;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool isPrivate = false;
  bool isStarted = false;
  bool isLoading = false;
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (builder) {
      return StatefulBuilder(
        builder: (_, modalState) {
          // Add thumbnail image
          Future addimage() async {
            var tempImage = await picker.pickImage(source: ImageSource.gallery);
            if (tempImage?.path != null) {
              modalState(() {
                thumbnail = File(tempImage!.path);
              });
            }
          }

          // Start Streaming
          Future<void> startStream() async {
            if (formkey.currentState!.validate()) {
              modalState(() {
                isLoading = true;
              });
              Map<String, dynamic> body = {
                "name": streamNameController.text,
                "pin": streamPasswordController.text
              };
              final Uri url = Uri.http(
                baseUrl,
                "$apiUrl/stream/create",
              );
              final multipart = http.MultipartRequest('POST', url);
              multipart.headers.addAll({
                'Content-Type': 'multipart/form-data',
                'Accept': 'multipart/form-data',
              });
              multipart.fields["name"] = body["name"];
              if (isPrivate) {
                multipart.fields["pin"] = body["pin"];
              }
              if (thumbnail != null) {
                var pic = await http.MultipartFile.fromPath(
                    "thumbnail", thumbnail!.path);
                multipart.files.add(pic);
              }
              http.Response response =
                  await http.Response.fromStream(await multipart.send());
              var jsonData = jsonDecode(response.body);
              Stream stream = Stream.fromJson(jsonData["data"]);
              if (response.statusCode == 200) {
                modalState(
                  () {
                    isLoading = false;
                    isStarted = true;
                  },
                );
                if (isStarted) {
                  Timer(
                    const Duration(seconds: 4),
                    () => {
                      streamcb(),
                      Navigator.of(context).pop(),
                      Navigator.pushNamed(context, 'Stream', arguments: stream)
                    },
                  );
                }
              } else {
                showSnackBar(
                    message: jsonData["message"]["error"], context: context);
              }
            }
          }

          return Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            decoration: const BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0),
              ),
            ),
            child: AnimatedCrossFade(
              duration: const Duration(milliseconds: 200),
              crossFadeState: isStarted
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              firstChild: Form(
                key: formkey,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset('assets/svg/livecircle.svg'),
                              Text(
                                '  Live Stream',
                                style: kHeadTitleB.copyWith(color: kWhite),
                              ),
                            ],
                          ),
                          IconButton(
                              onPressed: () => Navigator.of(context).pop(),
                              icon: const Icon(
                                Icons.close_rounded,
                                color: kWhite,
                              ))
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      GestureDetector(
                        onTap: () => addimage(),
                        child: Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            color: kGreyLight,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          height: 150,
                          width: double.infinity,
                          child: thumbnail != null
                              ? Image.asset(thumbnail!.path, fit: BoxFit.cover)
                              : const Center(
                                  child: Icon(Icons.image_outlined),
                                ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Is your stream private or public?",
                        style: kSmallTitleR.copyWith(color: kWhite),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      AnimatedToggleSwitch<bool>.dual(
                        current: isPrivate,
                        borderColor: kPrimaryLightColor,
                        first: false,
                        second: true,
                        dif: 50.0,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: Offset(0, 1.5),
                          ),
                        ],
                        onChanged: (b) {
                          modalState(() {
                            isPrivate = b;
                          });
                          return Future.delayed(
                            const Duration(
                              milliseconds: 500,
                            ),
                          );
                        },
                        colorBuilder: (b) => b ? kGreenColor : kRedColor,
                        iconBuilder: (value) => value
                            ? SvgPicture.asset(
                                'assets/svg/secure.svg',
                                color: kWhite,
                              )
                            : SvgPicture.asset(
                                'assets/svg/public.svg',
                                color: kWhite,
                              ),
                        textBuilder: (value) => value
                            ? const Center(child: Text('Private Stream'))
                            : const Center(child: Text('Public Stream')),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Comeon Let's name your live stream.",
                        style: kSmallTitleR.copyWith(color: kWhite),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      kTextInputField(
                        controller: streamNameController,
                        title: 'Stream Name',
                        validator: streamTextValidator,
                        titleStyle: kBodyTitleR.copyWith(color: kWhite),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Visibility(
                        visible: isPrivate,
                        child: kTextInputField(
                          controller: streamPasswordController,
                          title: 'Stream Pin',
                          validator: streamPinTextValidator,
                          password: true,
                          titleStyle: kBodyTitleR.copyWith(color: kWhite),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      kSolidButton(
                        backgroundColor: kSecondaryColor,
                        loading: isLoading,
                        onPress: () => startStream(),
                        title: 'Start Stream',
                        titleStyle: kBodyTitleR.copyWith(color: kWhite),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Text(
                          "Please respect the community guidelines, and be a responsible streamer.",
                          style: kSmallTitleR.copyWith(color: kWhite),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              secondChild: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Stream Starting',
                      textAlign: TextAlign.center,
                      style: kHeadTitleSB.copyWith(color: kWhite),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Lottie.asset(
                        'assets/lotties/stream.json',
                        animate: true,
                        repeat: true,
                        height: 100,
                        width: 100,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Center(
                      child: Text(
                        "Please respect the community guidelines, and be a responsible streamer.",
                        style: kSmallTitleR.copyWith(color: kWhite),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}
