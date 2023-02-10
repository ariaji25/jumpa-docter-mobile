import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jd_mobile/common/const.dart';

import '../../common/logo.dart';
import '../../common/theme/theme.dart';
import '../../common/widgets/appbar.dart';
import 'components/card_doctor.dart';
import 'components/list_dropdown.dart';
import 'payment_chat_page.dart';

class ListDoctorScreen extends StatefulWidget {
  const ListDoctorScreen({Key? key}) : super(key: key);

  @override
  State<ListDoctorScreen> createState() => _ListDoctorScreenState();
}

class _ListDoctorScreenState extends State<ListDoctorScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppsBar(
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back),
            ),
            logoWhite
          ],
        ),
        bottom: PreferredSize(
          child: Container(color: Themes.primaryColor, height: 1.0),
          preferredSize: const Size.fromHeight(1.0),
        ),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(left: margin, right: margin, top: margin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {},
              child: TextFormField(
                  controller: _searchController,
                  autofocus: false,
                  focusNode: FocusNode(canRequestFocus: false),
                  onSaved: (val) {},
                  cursorColor: Theme.of(context).colorScheme.primary,
                  decoration: InputDecoration(
                    fillColor: Themes.grey200Color,
                    filled: true,
                    contentPadding: const EdgeInsets.all(10),
                    hintText: "Cari dokter",
                    hintStyle: kBodyText.copyWith(
                        fontSize: 12,
                        color: const Color(0XFFA6B7D4),
                        fontWeight: FontWeight.w400),
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        borderSide: BorderSide(
                          color: Color(0XFFEDF2F7),
                          width: 1,
                        )),
                    enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        borderSide: BorderSide(
                          color: Color(0XFFEDF2F7),
                          width: 1,
                        )),
                    focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        borderSide: BorderSide(
                          color: Color(0XFFEDF2F7),
                          width: 1,
                        )),
                    prefixIcon: Image.asset(
                      "$iconsPath/search.png",
                    ),
                  )),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: ListDropdown(
                  title: "Rating",
                  items: {
                    "5": _itemSelectIcon(5),
                    "4": _itemSelectIcon(4),
                    "3": _itemSelectIcon(3),
                    "2": _itemSelectIcon(2),
                    "1": _itemSelectIcon(1),
                  },
                  onTap: (value) {},
                )),
                Expanded(
                    child: ListDropdown(
                  title: "Jenis Kelamin",
                  items: {
                    "L": _itemSelectText("Laki-laki"),
                    "P": _itemSelectText("Perempuan"),
                  },
                  onTap: (value) {},
                )),
                Expanded(
                    child: ListDropdown(
                  title: "Pengalaman",
                  items: {
                    "2": _itemSelectText("2 Tahun"),
                    "3": _itemSelectText("3 Tahun"),
                    "4": _itemSelectText("4 Tahun"),
                    "5": _itemSelectText("5 Tahun"),
                    "6": _itemSelectText("6 Tahun"),
                    "7": _itemSelectText("7 Tahun"),
                    "8": _itemSelectText("8 Tahun"),
                    "9+": _itemSelectText("9+ Tahun"),
                  },
                  onTap: (value) {},
                )),
              ],
            ),
            Container(
              color: const Color(0XFFE4ECF7),
              height: 1,
              width: double.infinity,
              margin: const EdgeInsets.only(top: 0, bottom: 25),
            ),
            false
                ? _emptyDoctor()
                : Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Konsultasi bersama dokter dibawah ini",
                          style: kBodyText.copyWith(
                              fontSize: 14,
                              color: Themes.primaryColorDarkColor,
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Expanded(
                          child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: 5,
                              itemBuilder: (BuildContext context, int index) {
                                return DoctorItemWidget(
                                  onTap: () {
                                    Get.to(
                                      () => const PaymentChatScreen(),
                                    );
                                  },
                                );
                              }),
                        ),
                      ],
                    ),
                  )
          ],
        ),
      ),
    );
  }

  Widget _itemSelectText(String text) {
    return Text(text,
        style: const TextStyle(color: Themes.grey700Color, fontSize: 14));
  }

  Widget _itemSelectIcon(int length) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(length.toString(),
            style: const TextStyle(color: Themes.grey700Color, fontSize: 14)),
        for (var i = 0; i < length; i++)
          Container(
            margin: const EdgeInsets.only(left: 5),
            child: Image.asset(
              "$iconsPath/ic_stars.png",
              width: 10,
            ),
          ),
      ],
    );
  }

  Widget _emptyDoctor() {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "$iconsPath/empty_doctor.png",
              height: 123,
              width: 171,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Dokter yang anda cari tidak ada",
              textAlign: TextAlign.center,
              style: kBodyText.copyWith(
                  fontSize: 14,
                  color: Themes.primaryColorDarkColor,
                  fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }
}
