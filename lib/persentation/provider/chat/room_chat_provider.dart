import 'package:flutter/material.dart';

import '../../../common/utils/state_enum.dart';

class RoomChatProvider extends ChangeNotifier {
  RequestState _state = RequestState.Loading;
  String errorMessage = "Error";

  RequestState get state => _state;
  List<DataRoomChat> results = [];

  void setState(RequestState newState) {
    _state = newState;
    notifyListeners();
  }

  void getRooms() async {
    try {
      final token = GetStorage().read(authToken);
      await chatService.getRooms(1, 10, token: token).then((value) async {
        setState(RequestState.Loading);
        results = value.data ?? [];
        setState(RequestState.Loaded);
      }).onError((error, stackTrace) {
        errorMessage = error.toString();
        results = [
          DataRoomChat(
              id: "876786",
              dmToName: "Muh",
              dmToId: "dmToId",
              roomType: "roomType",
              createdAt: DateTime.parse("2023-01-17T00:00:00.00"),
              lastMessage: LastMessage(
                  id: "asfsaf-asfda-sfasf-asff",
                  message: "Sakit pak",
                  author: "asfafkasf-afasf-asfsa-f",
                  attachment: [
                    Attachment(
                        id: "asfsfaas-safsa-afas-fadsf",
                        url: "https://my.com/image",
                        type: "image/png")
                  ],
                  roomId: "asfsafa-asfasf-asfsaf-as",
                  sendAt: DateTime.parse("2023-01-01T00:00:00.000Z"))),
          DataRoomChat(
              id: "876786",
              dmToName: "Ari Purnama",
              dmToId: "f00c2c23-8437-4bc2-9679-3dd039b752ac",
              roomType: "DIRECT_MESSAGE",
              createdAt: DateTime.parse("2023-01-17T00:00:00.00"),
              lastMessage: LastMessage(
                  id: "asfsaf-asfda-sfasf-asff",
                  message: "Sakit pak",
                  author: "asfafkasf-afasf-asfsa-f",
                  attachment: [
                    Attachment(
                        id: "asfsfaas-safsa-afas-fadsf",
                        url: "https://my.com/image",
                        type: "image/png")
                  ],
                  roomId: "asfsafa-asfasf-asfsaf-as",
                  sendAt: DateTime.parse("2023-01-01T00:00:00.000Z"))),
        ];
        setState(RequestState.Loaded);
      });
    } catch (e) {
      errorMessage = e.toString();
      setState(RequestState.Error);
    }
  }
}
