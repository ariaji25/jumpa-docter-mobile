import 'package:flutter/material.dart';
import 'package:jd_mobile/domain/entities/chat/room_chat_entities.dart';
import 'package:jd_mobile/domain/usecases/chat/get_rooms.dart';

import '../../../common/utils/state_enum.dart';

class RoomChatProvider extends ChangeNotifier {
  RoomChatProvider({this.getRooms});

  final GetRooms? getRooms;
  RequestState _state = RequestState.Loading;
  String _errorMessage = "Error";

  String get errorMessage => _errorMessage;

  RequestState get state => _state;
  List<RoomChatEntities> results = [];

  void setRequestState(RequestState newState) {
    _state = newState;
    notifyListeners();
  }

  void getListRooms() async {
    setRequestState(RequestState.Loading);
    final result = await getRooms!({"page":10,"limit":10});
    result.fold((l) {
      setRequestState(RequestState.Error);
      _errorMessage = /*l.message*/"Data Kosong";
      notifyListeners();
    }, (r) {
      setRequestState(RequestState.Loaded);
    });
  }
}
