import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:jd_mobile/common/const.dart';
import 'package:jd_mobile/common/exts.dart';
import 'package:jd_mobile/common/theme/theme.dart';
import 'package:jd_mobile/screens/chat/chat_room_page.dart';

import '../../common/widgets/buttons.dart';
import '../../common/widgets/text_field.dart';
import '../homecare/components/base_payment.dart';
import 'components/profile_chat.dart';

class PaymentChatScreen extends StatefulWidget {
  const PaymentChatScreen({Key? key}) : super(key: key);

  @override
  State<PaymentChatScreen> createState() => _PaymentChatScreenState();
}

class _PaymentChatScreenState extends State<PaymentChatScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BasePaymentScreen(
      withSingleChildScrollView: false,
      btnTitle: "Bayar",
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: margin),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30),
                    Center(
                      child: Text(
                        "Detail dan Pembayaran",
                        style: kHeading5.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Themes.primaryColorDarkColor),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Center(
                      child: Text(
                        "Detail dan pembayaran untuk melakukan chat dengan dokter",
                        style: kSubtitle.copyWith(
                            fontWeight: FontWeight.w400,
                            color: Themes.primaryColorDarkColor,
                            fontSize: 12),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(height: 1, color: const Color(0XFFEDF2F7)),
                    const SizedBox(height: 25),
                    Text(
                      "Dokter",
                      style: kSubtitle.copyWith(
                          fontSize: 14,
                          color: Themes.primaryColorDarkColor,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const ProfileChatWidget(
                          size: 46,
                        ),
                        context.sbWidth(size: 15),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "dr. Ralph Edwards",
                              style: kBodyText.copyWith(
                                  fontSize: 14,
                                  color: Themes.primaryColor,
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Spesialisasi anak",
                              style: kBodyText.copyWith(
                                  fontSize: 12,
                                  color: Themes.grey800Color,
                                  fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Rp. 50.000",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: kBodyText.copyWith(
                                          fontSize: 12,
                                          color: const Color(0XFFEF0C11),
                                          fontWeight: FontWeight.w500,
                                          decoration:
                                              TextDecoration.lineThrough),
                                    ),
                                    Text(
                                      "Rp. 30.000",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: kBodyText.copyWith(
                                          fontSize: 12,
                                          color: Themes.primaryColorDarkColor,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        )),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(height: 1, color: const Color(0XFFEDF2F7)),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Virtual account",
                      style: kSubtitle.copyWith(
                          fontSize: 14,
                          color: Themes.primaryColorDarkColor,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 10),
                    Column(children: [
                      PaymentTile(
                        isActive: true,
                        title: "BNI Virtual Account",
                        image: "bni.png",
                        onTap: () {},
                      )
                    ]),
                    Text(
                      "E-Wallet",
                      style: kSubtitle.copyWith(
                          fontSize: 14,
                          color: Themes.primaryColorDarkColor,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 10),
                    Column(children: [
                      PaymentTile(
                        isActive: false,
                        title: "OVO",
                        image: "ovo.png",
                        onTap: () {},
                      ),
                      PaymentTile(
                        isActive: false,
                        title: "DANA",
                        image: "dana.png",
                        onTap: () {},
                      ),
                      PaymentTile(
                        isActive: false,
                        title: "LINK AJA",
                        image: "link.png",
                        onTap: () {},
                      ),
                    ]),
                    Visibility(
                      visible: true,
                      child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 8),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: const Color(0xffFFEDE3),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                FeatherIcons.bell,
                                color: Color(0XFFF1774A),
                                size: 16,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Selesaikan pembayaran sebelum 18.00 WIB",
                                style: kBodyText.copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0XFFF1774A)),
                              ),
                            ],
                          )),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () => bottomSheetPromo(context),
                      child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                color: Themes.primaryColorDarkColor, width: 1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                "$iconsPath/promo.png",
                                height: 16,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(
                                  "Masukkan kode promo (Jika ada)",
                                  textAlign: TextAlign.start,
                                  style: kBodyText.copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Themes.primaryColorDarkColor),
                                ),
                              ),
                              const Icon(
                                Icons.chevron_right,
                                color: Themes.primaryColorDarkColor,
                                size: 25,
                              ),
                            ],
                          )),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
      totalWidget: Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Themes.grey200Color,
            borderRadius: BorderRadius.circular(3),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Total yang harus dibayar",
                textAlign: TextAlign.start,
                style: kBodyText.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Themes.primaryColorDarkColor),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "RP 150.000",
                textAlign: TextAlign.start,
                style: kBodyText.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Themes.primaryColor),
              ),
            ],
          )),
      onNext: () async {
        Get.to(
          const ChatRoomScreen(),
          arguments: [
            // _PaymentChatScreenViewModel.PaymentChatScreenUrlModel.value,
            // _pgCode,
          ],
        );
      },
      loading: false,
    );
  }

  bottomSheetPromo(BuildContext context) {
    return showModalBottomSheet(
      enableDrag: true,
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          padding:
              const EdgeInsets.only(left: margin, right: margin, bottom: 40),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  width: 58,
                  height: 3,
                  color: Themes.greyOtherColor,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                ),
              ),
              const SizedBox(height: 25),
              Text(
                "Masukkan kode promo",
                textAlign: TextAlign.start,
                style: kBodyText.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: const Color(0XFF27272E)),
              ),
              const SizedBox(
                height: 10,
              ),
              textFieldWidgetWithBorder(
                hintText: "Cth : JDSEHATSELALU",
                isName: true,
                isShowingLable: false,
                isUnderline: true,
                inputType: TextInputType.text,
                contentPadding: 15,
                formatters: [
                  FilteringTextInputFormatter.allow(RegExp('[a-zA-Z-" "]')),
                ],
                onChanged: (value) {},
              ),
              const SizedBox(
                height: margin,
              ),
              Buttons(
                title: "OK",
                onTap: () {
                  Navigator.of(context).pop();
                },
                marginBottom: 0,
              )
            ],
          ),
        );
      },
    );
  }
}

class PaymentTile extends StatefulWidget {
  final Function onTap;
  final bool isActive;
  final String title;
  final String image;

  const PaymentTile({
    Key? key,
    required this.onTap,
    required this.title,
    required this.image,
    this.isActive = false,
  }) : super(key: key);

  @override
  State<PaymentTile> createState() => _PaymentTileState();
}

class _PaymentTileState extends State<PaymentTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onTap();
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(
            color:
                widget.isActive ? Themes.primaryColor : const Color(0XFFE4ECF7),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Image.asset(
                "$logoPath/${widget.image}",
                height: 15,
              ),
            ),
            const SizedBox(width: 30),
            Expanded(
              flex: 7,
              child: Text(
                widget.title,
                style: kSubtitle.copyWith(
                    color: Themes.primaryColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Visibility(
              visible: widget.isActive,
              child: Icon(
                Icons.check_circle_outline_sharp,
                color: widget.isActive ? Colors.green : Themes.greyColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
