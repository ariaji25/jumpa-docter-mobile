import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:jd_mobile/common/const.dart';
import 'package:jd_mobile/common/exts.dart';
import 'package:jd_mobile/common/helper.dart';

import '../../../common/theme/theme.dart';
import '../../../models/room_chat.dart';

class ChatItemWidget extends StatelessWidget {
  final bool isRead;
  final DataRoomChat item;
  final Function onTap;

  const ChatItemWidget(
      {Key? key, required this.item, required this.isRead, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipOval(
              child: Container(
                width: 50,
                height: 50,
                color: Themes.primaryColor,
                child: Center(
                    child: Text(
                  NameHelper.getInitials(item.dmToName),
                  style: kBodyText2.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                )),
              ),
            ),
            context.sbWidth(size: 15),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.dmToName,
                  style: kBodyText.copyWith(
                      fontSize: 14,
                      color: Themes.primaryColor,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "$iconsPath/check-all.svg",
                      width: 16,
                      height: 16,
                      color: Color(isRead ? 0XFF56B7CD : 0XFF718096),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                        child: Text(
                      item.lastMessage.message,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: kBodyText.copyWith(
                          fontSize: 14,
                          color: const Color(0XFF4A5568),
                          fontWeight: FontWeight.w400),
                    )),
                  ],
                ),
              ],
            )),
            context.sbWidth(size: 21),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  DateFormat("HH:mm")
                      .format(item.lastMessage.sendAt)
                      .toString(),
                  style: kBodyText.copyWith(
                      fontSize: 10, color: const Color(0XFFA0AEC0)),
                ),
                Visibility(
                  visible: !isRead,
                  child: Container(
                      margin: const EdgeInsets.only(top: 5),
                      decoration: BoxDecoration(
                          color: Themes.redPrimaryColor,
                          borderRadius: BorderRadius.circular(16)),
                      padding: const EdgeInsets.symmetric(
                          vertical: 3, horizontal: 5),
                      child: Text(
                        "5",
                        style: kBodyText.copyWith(
                            fontSize: 10, color: Colors.white),
                      )),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
