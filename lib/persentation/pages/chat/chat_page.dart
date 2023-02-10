import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jd_mobile/common/resources/assets.dart';
import 'package:jd_mobile/common/resources/colors.dart';
import 'package:jd_mobile/common/resources/size.dart';
import 'package:jd_mobile/persentation/widgets/loading.dart';
import 'package:provider/provider.dart';
import '../../../common/theme/theme.dart';
import '../../../common/utils/state_enum.dart';
import '../../provider/chat/room_chat_provider.dart';
import 'chat_room_page.dart';
import 'components/card_chat.dart';
import 'specialization_page.dart';

class ChatPage extends StatefulWidget {
  static const routeName = "/ChatPage";
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<RoomChatProvider>(context, listen: false).getListRooms();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        child: SvgPicture.asset("${Assets.iconsPath}/chat.svg",
            width: 20, height: 20, color: Colors.white),
        onPressed: () {
          Navigator.pushNamed(
            context,
            SpecializationPage.routeName,
          );
        },
      ),
      body: Padding(
        padding:
        const EdgeInsets.only(left: SizeConstants.margin,
            right: SizeConstants.margin,
            top: SizeConstants.margin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
                controller: _searchController,
                autofocus: false,
                focusNode: FocusNode(canRequestFocus: false),
                onSaved: (val) {},
                cursorColor: Theme
                    .of(context)
                    .colorScheme
                    .primary,
                decoration: InputDecoration(
                  fillColor: AppColors.grey200Color,
                  filled: true,
                  contentPadding: const EdgeInsets.all(10),
                  hintText: "Cari Percakapan",
                  hintStyle: AppTheme.bodyText.copyWith(
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
                    "${Assets.iconsPath}/search.png",
                  ),
                )),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child:
              Consumer<RoomChatProvider>(builder: (context, roomChat, _) {
                if (roomChat.state == RequestState.Loading) {
                  return const Loading();
                } else if (roomChat.state == RequestState.Loaded) {
                  if (roomChat.results.isEmpty) {
                    return _emptyRoomChat();
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Chat Dokter",
                          style: AppTheme.bodyText.copyWith(
                              fontSize: 14,
                              color: AppColors.primaryColorDarkColor,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Expanded(
                          child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: roomChat.results.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ChatItemWidget(
                                    item: roomChat.results[index],
                                    isRead: index % 2 == 0,
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        ChatRoomPage.routeName,
                                      );
                                    }
                                );
                              }),
                        ),
                      ],
                    );
                  }
                } else if (roomChat.state == RequestState.Error) {
                  return _error(roomChat.errorMessage);
                }
                return Container();
              }),
            )
          ],
        ),
      ),
    );
  }

  Widget _emptyRoomChat() {
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
            "Belum ada pesan\nSilahkan mulai percakapan dengan dokter anda.",
            textAlign: TextAlign.center,
            style: AppTheme.bodyText.copyWith(
                fontSize: 14, color: AppColors.primaryDarkLightColor),
          )
        ],
      ),
    );
  }

  Widget _error(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "${Assets.iconsPath}/empty_doctor.png",
            height: 123,
            width: 171,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            message,
            textAlign: TextAlign.center,
            style: AppTheme.bodyText.copyWith(
                fontSize: 14,
                color: AppColors.primaryColorDarkColor,
                fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}
