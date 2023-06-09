import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../common/constants/app_const.dart';
import '../../../../common/resources/snackbar.dart';
import '../../../common/utils/state_enum.dart';

class MapProvider extends ChangeNotifier {
  var mapPosition = const LatLng(0, 0);
  var selectedPosition = const LatLng(0, 0);
  var querySearchController = TextEditingController();
  var controller = Completer();
  var mapType = MapType.satellite;
  var permissionLocationAllow = true;
  var detailAddress = "";
  var selectedDetailAddress = "";
  var markers = <Marker>[];
  var loadingDetailLocation = false;
  var moveCameraFromSliding = true;
  RequestState _requestState = RequestState.Loading;

  RequestState get requestState => _requestState;

  void setRequestState(RequestState state) {
    _requestState = state;
    notifyListeners();
  }

  void getPermissionLocationAllow() async {
    var status = await Permission.location.status;
    if (status.isGranted) {
      permissionLocationAllow = true;
      notifyListeners();
      getCurrentLocation();
    } else {
      await Permission.location.request().then((status) {
        if (status.isGranted) {
          permissionLocationAllow = true;
          notifyListeners();
          getCurrentLocation();
        } else {
          setRequestState(RequestState.Loaded);
        }
      });
    }
  }

  void getCurrentLocation() async {
    await Geolocator.getCurrentPosition().then((currLocation) {
      setMapPosition(LatLng(currLocation.latitude, currLocation.longitude));
      setRequestState(RequestState.Loaded);
    });
  }

  void addMarker(LatLng latlang) {
    markers.add(Marker(
      markerId: const MarkerId("initial"),
      position: latlang,
    ));
  }

  Future<void> handlePressButton(BuildContext context) async {
    Prediction? p = await PlacesAutocomplete.show(
      context: context,
      apiKey: AppConst.MAP_API_KEY,
      onError: onError,
      mode: Mode.overlay,
      language: "id",
      types: [],
      strictbounds: false,
      components: [Component(Component.country, "id")],
    );

    displayPrediction(p);
  }

  void onError(PlacesAutocompleteResponse response) {
    if (kDebugMode) {
      print("Error map : ${response.errorMessage}");
    }
  }

  Future<void> displayPrediction(Prediction? p) async {
    if (p != null) {
      GoogleMapsPlaces places = GoogleMapsPlaces(
        apiKey: AppConst.MAP_API_KEY,
        apiHeaders: await const GoogleApiHeaders().getHeaders(),
      );
      PlacesDetailsResponse detail =
          await places.getDetailsByPlaceId(p.placeId!);
      final lat = detail.result.geometry!.location.lat;
      final lng = detail.result.geometry!.location.lng;
      goToTheLake(lat, lng, p.description);
      notifyListeners();
    }
  }

  Future<void> goToTheLake(double? lat, double? lng, String? deskripsi) async {
    if (lat != null && lng != null && deskripsi != null) {
      moveCameraFromSliding = false;
      querySearchController.text = deskripsi;
      setMapPosition(mapPosition = LatLng(lat, lng));
      notifyListeners();

      final googleMapController = await controller.future;
      googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(lat, lng), zoom: 20),
        ),
      );
      notifyListeners();
      setLoadingDetailLocation(true);
      Future.delayed(const Duration(seconds: 2), () {
        getLocation(LatLng(lat, lng)).then((value) {
          setDetailAddress(value);
          setLoadingDetailLocation(false);
        });
        moveCameraFromSliding = true;
        notifyListeners();
      });
    }
  }

  changeMapType(MapType type) {
    mapType = type;
    notifyListeners();
  }

  void onCameraMove() {
    setLoadingDetailLocation(true);
    Future.delayed(const Duration(seconds: 2), () {
      if (moveCameraFromSliding) {
        getLocation(mapPosition).then((value) {
          setDetailAddress(value);
          setLoadingDetailLocation(false);
        });
      }
    });
  }

  void currentLocation(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    permission = await Geolocator.checkPermission();

    if (!serviceEnabled) {
      SnackBarCustom.showSnackBarMessage(
          context: context,
          title: "Ops !",
          message: "Pelayanan lokasi dinonaktifkan",
          typeMessage: SnackBarType.error);
    } else if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    } else if (permission == LocationPermission.denied) {
      SnackBarCustom.showSnackBarMessage(
          context: context,
          title: "Ops !",
          message: "Izin lokasi ditolak",
          typeMessage: SnackBarType.error);
    } else if (permission == LocationPermission.deniedForever) {
      SnackBarCustom.showSnackBarMessage(
          context: context,
          title: "Ops !",
          message:
              "Izin lokasi ditolak secara permanen, kami tidak dapat meminta izin",
          typeMessage: SnackBarType.error);
    } else {
      final GoogleMapController googleMapController = await controller.future;
      getCurrentLocation();
      googleMapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          bearing: 0,
          target: mapPosition,
          zoom: 20,
        ),
      ));
    }
  }

  getLocation(LatLng? point) async {
    if (point != null) {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          point.latitude, point.longitude,
          localeIdentifier: "id");
      Placemark place = placemarks[0];
      StringBuffer sbuffer = StringBuffer();
      if ((place.street ?? "") != "") sbuffer.write(place.street);
      if ((place.subLocality ?? "") != "") {
        sbuffer.write(" ,");
        sbuffer.write(place.subLocality);
      }
      if ((place.locality ?? "") != "") {
        sbuffer.write(" ,");
        sbuffer.write(place.locality);
      }
      if ((place.subAdministrativeArea ?? "") != "") {
        sbuffer.write(" ,");
        sbuffer.write(place.subAdministrativeArea);
      }
      if ((place.administrativeArea ?? "") != "") {
        sbuffer.write(" ,");
        sbuffer.write(place.administrativeArea);
      }
      if ((place.country ?? "") != "") {
        sbuffer.write(" ,");
        sbuffer.write(place.country);
      }
      if ((place.postalCode ?? "") != "") {
        sbuffer.write(" ,");
        sbuffer.write(place.postalCode);
      }
      return sbuffer.toString();
    }
    return "";
  }

  void setMapPosition(value) {
    mapPosition = value;
    notifyListeners();
  }

  void setDetailAddress(value) {
    detailAddress = value;
    notifyListeners();
  }

  void setLoadingDetailLocation(status) {
    loadingDetailLocation = status;
    notifyListeners();
  }

  void setSelectedDetailAddress(value) {
    selectedDetailAddress = value;
    notifyListeners();
  }

  void setSelectedPosition(value) {
    selectedPosition = value;
    notifyListeners();
  }
}
