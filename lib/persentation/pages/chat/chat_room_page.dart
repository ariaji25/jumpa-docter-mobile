import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jd_mobile/common/resources/size.dart';
import '../../../common/resources/assets.dart';
import '../../../common/resources/colors.dart';
import '../../../common/theme/theme.dart';
import '../../widgets/app_bars.dart';
import 'components/card_chat_room.dart';
import 'components/item_file_attach.dart';
import 'components/profile_chat.dart';

class ChatRoomPage extends StatefulWidget {
  static const routeName = "/ChatRoomPage";
  final bool emptyChat; // Example for test UI Empty chat
  const ChatRoomPage({Key? key, this.emptyChat = false}) : super(key: key);

  @override
  State<ChatRoomPage> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  Timer? timer;
  bool countDown = true;

  @override
  void initState() {
    _chatRoomViewModel.warningEndTime.value = false;
    _chatRoomViewModel.endTime.value = false;
    startTimer();
    super.initState();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
  }

  void addTime() {
    final addSeconds = countDown ? -1 : 1;
    _chatRoomViewModel.second.value =
        _chatRoomViewModel.duration.value.inSeconds + addSeconds;
    if (_chatRoomViewModel.second.value < 0) {
      timer?.cancel();
    } else {
      _chatRoomViewModel.duration.value =
          Duration(seconds: _chatRoomViewModel.second.value);
    }

    final minutes = CountHelper.twoDigits(
        _chatRoomViewModel.duration.value.inMinutes.remainder(60));
    final seconds = CountHelper.twoDigits(
        _chatRoomViewModel.duration.value.inSeconds.remainder(60));
    _chatRoomViewModel.runningTime.value = "$minutes.$seconds";
    if (_chatRoomViewModel.runningTime.value == "00.00") {
      context.closeKeyboard();
      _chatRoomViewModel.endTime.value = true;
    } else if (_chatRoomViewModel.runningTime.value == "05.00") {
      _chatRoomViewModel.warningEndTime.value = true;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return Scaffold(
            backgroundColor: AppColors.grey100Color,
            resizeToAvoidBottomInset: false,
            appBar: AppsBar(
              elevation: 0,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                  const ProfileChatWidget(
                    size: 46,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "dr. Anabelle Sp.A",
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                          style: AppTheme.bodyText.copyWith(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          "Sepsialisasi anak",
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                          style: AppTheme.bodyText.copyWith(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  )
                ],
              ),
              bottom: PreferredSize(
                child: Container(color: AppColors.primaryColor, height: 1.0),
                preferredSize: const Size.fromHeight(1.0),
              ),
            ),
            bottomNavigationBar: _chatRoomViewModel.endTime.value
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _dialogRatingDoctor(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 22, horizontal: margin),
                        color: AppColors.grey200Color,
                        child: Text(
                          "Waktu konsultasi habis anda tidak bisa mengirim pesan lagi",
                          textAlign: TextAlign.center,
                          style: AppTheme.bodyText.copyWith(
                              fontSize: 12,
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _dialogOutInTheLastTwoWeeks(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: margin),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                  controller: _chatRoomViewModel
                                      .messageController.value,
                                  autofocus: false,
                                  focusNode: FocusNode(canRequestFocus: false),
                                  onSaved: (val) {},
                                  cursorColor:
                                      Theme.of(context).colorScheme.primary,
                                  decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            barrierColor: Colors.transparent,
                                            builder: (BuildContext context) {
                                              return Dialog(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                ),
                                                insetPadding:
                                                    const EdgeInsets.only(
                                                        bottom: 70,
                                                        left: margin,
                                                        right: margin),
                                                elevation: 0,
                                                backgroundColor:
                                                    Colors.transparent,
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: Wrap(
                                                  children: [
                                                    Container(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 10,
                                                          horizontal: 50),
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(6)),
                                                      child: Row(
                                                        // mainAxisSize:
                                                        //     MainAxisSize.min,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          ItemFileAttach(
                                                            title: "File",
                                                            colors: const Color(
                                                                0XFFFFEDE3),
                                                            imagePath:
                                                                "${Assets.iconsPath}/file.png",
                                                            size: 36,
                                                            titleStyle: AppTheme
                                                                .subtitle
                                                                .copyWith(
                                                              color: AppColors
                                                                  .grey700Color,
                                                              fontSize: 12,
                                                            ),
                                                            onTap: () {},
                                                          ),
                                                          ItemFileAttach(
                                                            title: "Gambar",
                                                            colors: const Color(
                                                                0XFFDEFFEE),
                                                            imagePath:
                                                                "${Assets.iconsPath}/gambar.png",
                                                            size: 36,
                                                            titleStyle: AppTheme
                                                                .subtitle
                                                                .copyWith(
                                                              color: AppColors
                                                                  .grey700Color,
                                                              fontSize: 12,
                                                            ),
                                                            onTap: () {},
                                                          ),
                                                          ItemFileAttach(
                                                            title: "Foto",
                                                            colors: const Color(
                                                                0XFFE1E8FF),
                                                            imagePath:
                                                                "${Assets.iconsPath}/foto.png",
                                                            size: 36,
                                                            titleStyle: AppTheme
                                                                .subtitle
                                                                .copyWith(
                                                              color: AppColors
                                                                  .grey700Color,
                                                              fontSize: 12,
                                                            ),
                                                            onTap: () {},
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            });
                                      },
                                      icon: const Icon(
                                        Icons.add_circle_outline,
                                        color: AppColors.primaryColor,
                                        size: 25,
                                      ),
                                    ),
                                    fillColor: AppColors.grey200Color,
                                    filled: true,
                                    contentPadding: const EdgeInsets.all(10),
                                    hintText: "Tulis pesan...",
                                    hintStyle: AppTheme.bodyText.copyWith(
                                        fontSize: 14,
                                        color: const Color(0XFFA6B7D4),
                                        fontWeight: FontWeight.w400),
                                    border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(6)),
                                        borderSide: BorderSide(
                                          color: Color(0XFFEDF2F7),
                                          width: 1,
                                        )),
                                    enabledBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(6)),
                                        borderSide: BorderSide(
                                          color: Color(0XFFEDF2F7),
                                          width: 1,
                                        )),
                                    focusedBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(6)),
                                        borderSide: BorderSide(
                                          color: Color(0XFFEDF2F7),
                                          width: 1,
                                        )),
                                  )),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              decoration: BoxDecoration(
                                  color: AppColors.grey200Color,
                                  borderRadius: BorderRadius.circular(6)),
                              child: const Icon(
                                Icons.send,
                                color: AppColors.primaryDarkLightColor,
                                size: 25,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
            body: Obx(() {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: SizeConstants.margin),
                    color: _chatRoomViewModel.endTime.value
                        ? const Color(0XFFEF0C11)
                        : (_chatRoomViewModel.warningEndTime.value
                            ? const Color(0XFFFFE6E4)
                            : const Color(0XFFE2E8F0)),
                    child: _chatRoomViewModel.endTime.value
                        ? Center(
                            child: Text(
                            "Waktu konsultasi habis",
                            textAlign: TextAlign.center,
                            style: AppTheme.bodyText
                                .copyWith(fontSize: 12, color: Colors.white),
                          ))
                        : Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Waktu konsultasi : ${_chatRoomViewModel.runningTime.value}",
                                  style: AppTheme.bodyText.copyWith(
                                      fontSize: 12,
                                      color: _chatRoomViewModel
                                              .warningEndTime.value
                                          ? const Color(0XFFF1774A)
                                          : const Color(0XFF505780),
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  // Helper.closeKeyboard();
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Dialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          elevation: 0,
                                          backgroundColor: Colors.transparent,
                                          child: Wrap(
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 20,
                                                        horizontal: 25),
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16)),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Image.asset(
                                                      "${Assets.iconsPath}/ask-question.png",
                                                      height: 80,
                                                      width: 100,
                                                    ),
                                                    Text(
                                                      "Akhiri konsultasi ?",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: AppTheme.bodyText
                                                          .copyWith(
                                                              fontSize: 16,
                                                              color: AppColors
                                                                  .primaryColorDarkColor),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      "Apakah kamu yakin ingin mengakhiri konsultasi bersama dokter?",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: AppTheme.bodyText
                                                          .copyWith(
                                                              fontSize: 12,
                                                              color: AppColors
                                                                  .primaryColorLightColor),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Expanded(
                                                          flex: 1,
                                                          child: ButtonCustom(
                                                            title: "Ya",
                                                            onTap: () {
                                                              _chatRoomViewModel
                                                                  .endTime
                                                                  .value = true;
                                                              timer?.cancel();
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            disabled: false,
                                                            loading: false,
                                                            borderRadius: 4,
                                                            marginBottom: 0,
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical: 8,
                                                                    horizontal:
                                                                        8),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: ButtonCustom(
                                                            title: "Tidak",
                                                            onTap: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            disabled: false,
                                                            loading: false,
                                                            borderRadius: 4,
                                                            marginBottom: 0,
                                                            borderColor: AppColors
                                                                .primaryColor,
                                                            backgroundColor:
                                                                AppColors
                                                                    .whiteColor,
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical: 8,
                                                                    horizontal:
                                                                        8),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      });
                                },
                                child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 16),
                                    decoration: BoxDecoration(
                                        color: const Color(0XFFEF0C11),
                                        borderRadius: BorderRadius.circular(4)),
                                    child: Text(
                                      "Akhiri",
                                      style: AppTheme.bodyText.copyWith(
                                          fontSize: 12,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400),
                                    )),
                              )
                            ],
                          ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: widget.emptyChat
                          ? _emptyChat()
                          : ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              reverse: true,
                              shrinkWrap: true,
                              itemCount: 20,
                              itemBuilder: (BuildContext context, int index) {
                                return ChatRoomItemWidget(
                                  sender: index % 2 == 0,
                                  typeChat: index == 0
                                      ? TypeChat.file
                                      : index == 2
                                          ? TypeChat.image
                                          : TypeChat.text,
                                );
                              }),
                    ),
                  )
                ],
              );
            }));
      }),
    );
  }

  Widget _emptyChat() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "${Assets.iconsPath}/empty_chat.png",
            height: 60,
            width: 60,
          ),
          Text(
            "Belum ada pesan\nSilahkan mulai percakapan dengan dokter anda.\n\nWaktu akan otomatis mulai berjalan ketika dokter pertama kali membalas pesan anda",
            textAlign: TextAlign.center,
            style: AppTheme.bodyText
                .copyWith(fontSize: 14, color: AppColors.primaryDarkLightColor),
          )
        ],
      ),
    );
  }

  Widget _dialogRatingDoctor() {
    return Visibility(
        visible: _chatRoomViewModel.endTime.value,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          margin: const EdgeInsets.all(36),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "${Assets.iconsPath}/ic_stars.png",
                height: 60,
                width: 60,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Terima kasih sudah berkonsultasi, jangan lupa berikan rating untuk dokter",
                textAlign: TextAlign.center,
                style: AppTheme.bodyText.copyWith(
                    fontSize: 14,
                    color: AppColors.primaryColorDarkColor,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20,
              ),
              Buttons(
                title: "Beri rating kepada dokter",
                onTap: () {
                  Get.to(() => const FeedbackDoctorScreen());
                },
                disabled: false,
                loading: false,
                borderRadius: 6,
                marginBottom: 0,
              ),
            ],
          ),
        ));
  }

  Widget _dialogOutInTheLastTwoWeeks() {
    return Visibility(
        visible: widget.emptyChat && !_chatRoomViewModel.endTime.value,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: SizeConstants.margin),
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Pesan",
                textAlign: TextAlign.left,
                style: AppTheme.bodyText.copyWith(
                    fontSize: 14,
                    color: AppColors.primaryColorDarkColor,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Apakah Saudara berpergian dalam dua minggu terakhir?",
                textAlign: TextAlign.left,
                style: AppTheme.bodyText.copyWith(
                    fontSize: 12,
                    color: AppColors.primaryColorLightColor,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: ButtonCustom(
                      title: "Ya",
                      onTap: () {},
                      disabled: false,
                      loading: false,
                      borderRadius: 4,
                      marginBottom: 0,
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 8),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 1,
                    child: ButtonCustom(
                      title: "Tidak",
                      onTap: () {},
                      disabled: false,
                      loading: false,
                      borderRadius: 4,
                      marginBottom: 0,
                      borderColor: AppColors.primaryColor,
                      backgroundColor: AppColors.whiteColor,
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 8),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
