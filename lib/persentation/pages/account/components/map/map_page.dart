import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jd_mobile/common/theme/theme.dart';
import 'package:jd_mobile/persentation/provider/map/map_provider.dart';
import 'package:provider/provider.dart';

import '../../../../../common/resources/assets.dart';
import '../../../../../common/resources/colors.dart';
import '../../../../../common/utils/state_enum.dart';
import '../../../../widgets/app_bars.dart';
import '../../../../widgets/buttons.dart';
import '../../../../widgets/loading.dart';

class MapPage extends StatefulWidget {
  static const routeName = "/MapPage";
  final String? latLng;
  final Function(LatLng) onTap;

  const MapPage({Key? key, required this.onTap, this.latLng}) : super(key: key);

  @override
  MapPageState createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  final homeScaffoldKey = GlobalKey<ScaffoldState>();
  final searchScaffoldKey = GlobalKey<ScaffoldState>();
  var focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      MapProvider mapProvider =
          Provider.of<MapProvider>(context, listen: false);
      mapProvider.setRequestState(RequestState.Loading);
      mapProvider
          .setMapPosition(const LatLng(-8.59050199305857, 116.11873215431551));
      if (widget.latLng == "" || widget.latLng == null) {
        mapProvider.getPermissionLocationAllow();
      } else {
        List<String> latLng = widget.latLng!.split(",");
        mapProvider.setMapPosition(LatLng(
            double.parse(latLng[0] == "" ? "0" : latLng[0]),
            double.parse(latLng[1] == "" ? "0" : latLng[1])));
        mapProvider.setRequestState(RequestState.Loaded);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    MapProvider mapProvider = Provider.of<MapProvider>(context, listen: true);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppsBar(
          elevation: 0.0,
          flexibleSpaceBar: FlexibleSpaceBar(
            centerTitle: true,
            title: Container(
              margin: const EdgeInsets.only(right: 25),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 32,
                      color: AppColors.whiteColor,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Tentukan pin lokasi",
                    style: AppTheme.bodyText.copyWith(fontSize: 16),
                  )
                ],
              ),
            ),
          ),
        ),
        body: mapProvider.requestState == RequestState.Loading
            ? const Loading()
            : Column(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        GoogleMap(
                          mapToolbarEnabled: false,
                          zoomControlsEnabled: true,
                          onMapCreated: (GoogleMapController controller) async {
                            if (!mapProvider.controller.isCompleted) {
                              mapProvider.controller.complete(controller);
                            }
                            mapProvider
                                .getLocation(mapProvider.mapPosition)
                                .then((value) {
                              mapProvider.setDetailAddress(value);
                              mapProvider.setLoadingDetailLocation(false);
                            });
                          },
                          initialCameraPosition: CameraPosition(
                              target: mapProvider.mapPosition, zoom: 20),
                          markers: Set<Marker>.of(mapProvider.markers),
                          mapType: mapProvider.mapType,
                          // onCameraMove: mapProvider.onCameraMove,
                          onCameraMove: (position) {
                            mapProvider.setMapPosition(position.target);
                            mapProvider.onCameraMove();
                          },
                          indoorViewEnabled: true,
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: InkWell(
                            child: Container(
                              margin:
                                  const EdgeInsets.only(bottom: 30, left: 5),
                              padding: const EdgeInsets.all(3),
                              decoration: const BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(50),
                                  )),
                              child: const Icon(
                                Icons.my_location,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                            onTap: () => mapProvider.currentLocation(context),
                          ),
                        ),
                        Align(
                            alignment: Alignment.center,
                            child: Image.asset(
                              "${Assets.iconsPath}/location.png",
                              height: 25,
                              width: 25,
                            )),
                        Container(
                          margin: const EdgeInsets.only(
                              top: 20, left: 25, right: 25),
                          child: GestureDetector(
                            onTap: () => mapProvider.handlePressButton(context),
                            child: TextFormField(
                                controller: mapProvider.querySearchController,
                                autofocus: false,
                                enabled: false,
                                focusNode: FocusNode(canRequestFocus: false),
                                onSaved: (val) {},
                                cursorColor:
                                    Theme.of(context).colorScheme.primary,
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  contentPadding: const EdgeInsets.all(10),
                                  hintText: "Cari alamat",
                                  hintStyle: AppTheme.bodyText.copyWith(
                                      fontSize: 12,
                                      color: AppColors.greyColor,
                                      fontWeight: FontWeight.w400),
                                  border: const OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(6)),
                                      borderSide: BorderSide(
                                        color: AppColors.primaryColor,
                                        width: 1,
                                      )),
                                  enabledBorder: const OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(6)),
                                      borderSide: BorderSide(
                                        color: AppColors.primaryColor,
                                        width: 1,
                                      )),
                                  focusedBorder: const OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(6)),
                                      borderSide: BorderSide(
                                        color: AppColors.primaryColor,
                                        width: 1,
                                      )),
                                  prefixIcon: Image.asset(
                                    "${Assets.iconsPath}/search.png",
                                  ),
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Wrap(
                    children: [
                      Container(
                        color: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 8),
                              child: mapProvider.loadingDetailLocation
                                  ? const Loading(size: 15)
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Wrap(
                                          children: [
                                            Image.asset(
                                              "${Assets.iconsPath}/map_pin_red.png",
                                              height: 20,
                                              width: 20,
                                            ),
                                          ],
                                        ),
                                        Expanded(
                                            child: Container(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                child: Text(
                                                  mapProvider.detailAddress ==
                                                          ""
                                                      ? "Keterangan"
                                                      : mapProvider
                                                          .detailAddress,
                                                  style: AppTheme.subtitle.copyWith(
                                                      fontSize: 12,
                                                      color: mapProvider
                                                                  .detailAddress ==
                                                              ""
                                                          ? AppColors.greyColor
                                                          : Colors.black),
                                                )))
                                      ],
                                    ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Buttons(
                              title: "Pilih Alamat",
                              onTap: () {
                                mapProvider.querySearchController.text = "";
                                mapProvider.setSelectedPosition(
                                    mapProvider.mapPosition);
                                mapProvider.setSelectedDetailAddress(
                                    mapProvider.detailAddress);
                                Navigator.of(context).pop();
                                widget.onTap(mapProvider.selectedPosition);
                              },
                              disabled: false,
                              loading: false,
                              borderRadius: 6,
                              marginBottom: 10,
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ));
  }
}
