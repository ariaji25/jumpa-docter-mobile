import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jd_mobile/common/extensions/context_ext.dart';
import '../../../../common/resources/assets.dart';
import '../../../../common/resources/colors.dart';
import '../../../../common/theme/theme.dart';
import '../../../provider/chat/chat_room_provider.dart';
import 'profile_chat.dart';

class ChatRoomItemWidget extends StatefulWidget {
  final bool sender;
  final TypeMessage typeChat;

  const ChatRoomItemWidget(
      {Key? key, required this.sender, this.typeChat = TypeMessage.TEXT})
      : super(key: key);

  @override
  State<ChatRoomItemWidget> createState() => _ChatRoomItemWidgetState();
}

class _ChatRoomItemWidgetState extends State<ChatRoomItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10, top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Visibility(
            visible: !widget.sender,
            child: Row(
              children: [
                const ProfileChatWidget(
                  size: 35,
                ),
                context.sbWidth(size: 10),
              ],
            ),
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: widget.sender
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                widget.sender ? "Anda" : "dr. Anabelle Sp.A",
                style: AppTheme.bodyText.copyWith(
                    fontSize: 14,
                    color: AppColors.primaryColorDarkColor,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 5,
              ),
              _typeChat(),
              const SizedBox(
                height: 5,
              ),
              Text(
                "14:01",
                textAlign: widget.sender ? TextAlign.end : TextAlign.start,
                style: AppTheme.bodyText.copyWith(
                    fontSize: 10,
                    color: const Color(0XFFA0AEC0),
                    fontWeight: FontWeight.w400),
              ),
            ],
          )),
          Visibility(
            visible: widget.sender,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                context.sbWidth(size: 10),
                const ProfileChatWidget(
                  size: 35,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _typeChat() {
    if (widget.typeChat == TypeMessage.FILE) {
      return Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: widget.sender
                ? AppColors.primaryColor
                : const Color(0XFFE4ECF7),
            borderRadius: BorderRadius.circular(10)),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          decoration: BoxDecoration(
              color: widget.sender
                  ? AppColors.primaryColorDarkColor.withOpacity(0.5)
                  : const Color(0XFFE4ECF7),
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment:
                widget.sender ? MainAxisAlignment.end : MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "${Assets.iconsPath}/download.svg",
                width: 18,
                height: 18,
                color: widget.sender ? Colors.white : AppColors.primaryColor,
              ),
              const SizedBox(
                width: 30,
              ),
              Text(
                "Diagnosa.pdf",
                textAlign: widget.sender ? TextAlign.end : TextAlign.start,
                style: AppTheme.bodyText.copyWith(
                    fontSize: 14,
                    color:
                        widget.sender ? Colors.white : AppColors.primaryColor,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                width: 10,
              ),
              Icon(
                FontAwesomeIcons.file,
                color: widget.sender ? Colors.white : AppColors.primaryColor,
                size: 18,
              ),
            ],
          ),
        ),
      );
    } else if (widget.typeChat == TypeMessage.IMAGE) {
      return Container(
        padding: const EdgeInsets.all(3),
        margin: EdgeInsets.only(
            right: widget.sender ? 0 : 75, left: widget.sender ? 75 : 0),
        decoration: BoxDecoration(
            color: widget.sender
                ? AppColors.primaryColor
                : const Color(0XFFE4ECF7),
            borderRadius: BorderRadius.circular(6)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Image.asset(
            "${Assets.othersPath}/artic.png",
            height: 140,
            width: 194,
            fit: BoxFit.cover,
          ),
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: widget.sender
                ? AppColors.primaryColor
                : const Color(0XFFE4ECF7),
            borderRadius: BorderRadius.circular(10)),
        child: Text(
          "Apakah kamu merasa pusing?",
          textAlign: widget.sender ? TextAlign.end : TextAlign.start,
          style: AppTheme.bodyText.copyWith(
              fontSize: 14,
              color: widget.sender ? Colors.white : AppColors.primaryColor,
              fontWeight: FontWeight.w400),
        ),
      );
    }
  }
}
