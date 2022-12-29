import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart';
import 'package:stream_app/components/Buttons/solid_button.dart';
import 'package:stream_app/components/InputField/textinput_field.dart';
import 'package:stream_app/components/Snackbars/popup_snackbar.dart';
import 'package:stream_app/constants/color_constants.dart';
import 'package:stream_app/constants/style_constants.dart';
import 'package:stream_app/constants/validator_constants.dart';
import 'package:stream_app/models/stream/stream_model.dart';
import 'package:stream_app/services/api_service.dart';

Widget liveStreamCard(Stream stream, BuildContext context) {
  // Initializations and Instances
  final ApiService _apiProvider = ApiService();
  bool isLoading = false;
  String? errorMessage;
  return GestureDetector(
    onTap: () {
      if (stream.secure == true) {
        showDialog(
          context: context,
          builder: (context) {
            TextEditingController streamPasswordController =
                TextEditingController();
            GlobalKey<FormState> formkey = GlobalKey<FormState>();

            return StatefulBuilder(builder: (_, modalState) {
              // Verify stream
              Future<void> verifyStream() async {
                modalState(() {
                  isLoading = true;
                });
                final Response res = await _apiProvider.post(
                    '/stream/verify?stream=${stream.stream}&pin=${streamPasswordController.text.trim()}',
                    {});
                Map<String, dynamic> data = jsonDecode(res.body);
                if (res.statusCode == 200) {
                  Map<String, dynamic> data = jsonDecode(res.body);
                  modalState(() {
                    errorMessage = null;
                    isLoading = false;
                  });
                  Navigator.of(context)
                      .pushNamed('StreamPlay', arguments: stream);
                } else {
                  modalState(() {
                    errorMessage = data["message"]["error"];
                    isLoading = false;
                  });
                }
              }

              return Dialog(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 16,
                child: Container(
                  color: kPrimaryColor,
                  padding: const EdgeInsets.all(15),
                  child: Form(
                    key: formkey,
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/svg/secure.svg',
                              color: kRedColor,
                            ),
                            Text(
                              ' Secure Sream',
                              style: kHeadTitleSB.copyWith(color: kWhite),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'You are entering a secure stream, Please provide stream pin.',
                          style: kSmallTitleR.copyWith(color: kWhite),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        kTextInputField(
                          controller: streamPasswordController,
                          title: 'Stream Pin',
                          validator: streamPinTextValidator,
                          password: true,
                          titleStyle: kBodyTitleR.copyWith(color: kWhite),
                        ),
                        Visibility(
                          visible: errorMessage != null,
                          child: Text(
                            '$errorMessage',
                            style: kSmallTitleR.copyWith(color: kRedColor),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        kSolidButton(
                          backgroundColor: kSecondaryColor,
                          loading: isLoading,
                          onPress: () => verifyStream(),
                          title: 'Join Stream',
                          titleStyle: kBodyTitleR.copyWith(color: kWhite),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            });
          },
        );
      } else {
        Navigator.of(context).pushNamed('StreamPlay', arguments: stream);
      }
    },
    child: Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(bottom: 10),
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
            crossAxisAlignment: CrossAxisAlignment.center,
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
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage('${stream.thumbnail?.file}'),
                    ),
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(.3),
                          kSecondaryColor.withOpacity(.7),
                        ]),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/svg/play.svg',
                      color: kRedColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            '${stream.name}',
                            style: kBodyTitleSB.copyWith(color: kWhite),
                          ),
                        ),
                        Visibility(
                          visible: stream.secure == true,
                          child: SvgPicture.asset(
                            'assets/svg/secure.svg',
                            color: kRedColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      '25K Follower',
                      style: kSmallTitleR.copyWith(color: kWhite),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Edward Younds .',
                          style: kSmallTitleR.copyWith(color: kWhite),
                        ),
                        Row(
                          children: [
                            SvgPicture.asset('assets/svg/watch.svg'),
                            Text(
                              '20 Watching',
                              style: kSmallTitleR.copyWith(color: kWhite),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    ),
  );
}
