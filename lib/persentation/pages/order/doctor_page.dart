import 'package:flutter/material.dart';
import 'package:jd_mobile/common/extensions/padding_ext.dart';
import 'package:jd_mobile/common/resources/assets.dart';
import 'package:jd_mobile/common/resources/colors.dart';
import 'package:jd_mobile/common/theme/theme.dart';
import 'package:jd_mobile/persentation/pages/order/components/base_screen_order.dart';
import 'package:jd_mobile/persentation/pages/order/components/card_field.dart';
import 'package:jd_mobile/persentation/pages/order/components/service_item.dart';
import 'package:jd_mobile/persentation/pages/order/schedule_page.dart';
import 'package:jd_mobile/persentation/widgets/button_widget.dart';

import '../schedule/schedule.dart';

class DoctorPage extends StatefulWidget {
  static const routeName = "/DoctorPage";

  const DoctorPage({Key? key}) : super(key: key);

  @override
  State<DoctorPage> createState() => _DoctorPageState();
}

class _DoctorPageState extends State<DoctorPage> {
  final int _serviceItemSelected = 0;

  final serviceType = [
    "Pelayanan di rumah",
    "Kunjungan Klinik",
  ];

  String organisationUnitsId = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseOrderScreen(
      title: "Pilih jenis layanan dan dokter",
      subTitle: "Pilih layanan dan dokter terbaik untuk melayani anda",
      btnTitle: "Lanjut",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Divider(thickness: 1),
          const SizedBox(height: 25),
          Text(
            "Jenis layanan",
            style: AppTheme.subtitle.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: AppColors.primaryColorDarkColor,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: ServiceItem(
                  title: "Dokter ke rumah anda",
                  imagePath: "${Assets.iconsPath}/ic_home.png",
                  isActive: _serviceItemSelected == 0,
                  onTap: () {
                    //
                  },
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                flex: 1,
                child: ServiceItem(
                  title: "Datang ke klinik",
                  imagePath: "${Assets.iconsPath}/ic_hospital.png",
                  isActive: _serviceItemSelected == 1,
                  onTap: () {
                    //
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          SearchButtonWidget(
            title: "Pilih Daerah Klinik",
            subtitle: "Pilih",
            onTap: () {},
          ),
          const SizedBox(height: 11),
          SearchButtonWidget(
            title: "Pilih Klinik",
            subtitle: "Pilih",
            onTap: () {},
          ),
          const SizedBox(height: 11),
          SearchButtonWidget(
            title: "Pilih Dokter",
            subtitle: "Pilih",
            onTap: () {},
          ),
          const SizedBox(height: 25),
          CardFieldWidget(
            keys: "Periksa Asam Urat",
            value: "Rp. 0",
            styleBackground: BoxDecoration(
              color: AppColors.grey200Color,
              borderRadius: BorderRadius.circular(3),
            ),
            styleKey: AppTheme.bodyText.copyWith(
              color: AppColors.primaryColorDarkColor,
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
            styleValue: AppTheme.bodyText.copyWith(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ),

          // const SizedBox(height: 12),
          // Visibility(
          //   visible: _bookingViewModel.booking.value.clinicArea != null,
          //   child: Obx(() {
          //     return searchButton(
          //         label: "Pilih Klinik",
          //         value: _bookingViewModel.booking.value.clinicName,
          //         onTap: () {
          //           bottomSheetWidget(
          //             context: context,
          //             onSearch: _onSearch,
          //             onClear: () {},
          //             title: 'Cari berdasarkan nama Klinik',
          //             inputType: TextInputType.text,
          //             child: Obx(
          //               () {
          //                 return _bookingViewModel.loadClinic.isTrue
          //                     ? loadingWidget
          //                     : Expanded(
          //                         child: ListView.builder(
          //                           itemCount: _bookingViewModel.clinicsByArea
          //                               .value.organisationUnits?.length,
          //                           itemBuilder:
          //                               (BuildContext context, int idx) {
          //                             final _data = _bookingViewModel
          //                                 .clinicsByArea
          //                                 .value
          //                                 .organisationUnits?[idx];

          //                             return Padding(
          //                               padding: paddingBottom(16.0),
          //                               child: InkWell(
          //                                 onTap: () {
          //                                   _bookingViewModel.booking
          //                                       .update((val) {
          //                                     setState(() {});
          //                                     val?.clinicName =
          //                                         _data?.displayName ?? "-";
          //                                   });

          //                                   // For get price list
          //                                   _bookingViewModel.orgUnits.value =
          //                                       _data?.id ?? "";

          //                                   //* Filtered doctors by organisationUnits
          //                                   organisationUnitsId =
          //                                       _data?.id ?? "";
          //                                   _bookingViewModel
          //                                       .getDoctors(_data?.id ?? "");

          //                                   // Pice after select
          //                                   _bookingViewModel.getPrice();

          //                                   Get.back();
          //                                 },
          //                                 child: ListTile(
          //                                   title: Text(
          //                                     _data?.displayName ?? "-",
          //                                     style: kHeading5.copyWith(
          //                                       color: Colors.black,
          //                                       fontSize: 16,
          //                                       fontWeight: FontWeight.bold,
          //                                     ),
          //                                   ),
          //                                 ),
          //                               ),
          //                             );
          //                           },
          //                         ),
          //                       );
          //               },
          //             ),
          //           );
          //         });
          //   }),
          // ),
          // const SizedBox(height: 12),
          // Visibility(
          //   visible: _bookingViewModel.booking.value.clinicName != null,
          //   child: Obx(() {
          //     return searchButton(
          //       label: "Pilih Dokter",
          //       value: _bookingViewModel.booking.value.doctorName,
          //       onTap: () {
          //         bottomSheetWidget(
          //           context: context,
          //           onSearch: _onSearch,
          //           title: 'Cari berdasarkan nama Dokter',
          //           inputType: TextInputType.text,
          //           onClear: () async {
          //             await _bookingViewModel.getDoctors(organisationUnitsId);
          //           },
          //           child: Obx(() {
          //             return _bookingViewModel.loadDoctor.isTrue
          //                 ? loadingWidget
          //                 : Expanded(
          //                     child: ListView.builder(
          //                       itemCount: _bookingViewModel.doctors.value
          //                               .trackedEntityInstances?.length ??
          //                           0,
          //                       itemBuilder: (BuildContext context, int idx) {
          //                         final TrackedEntityInstances _data =
          //                             _bookingViewModel.doctors.value
          //                                     .trackedEntityInstances?[idx] ??
          //                                 TrackedEntityInstances();

          //                         return Padding(
          //                           padding: paddingBottom(16.0),
          //                           child: InkWell(
          //                             onTap: () {
          //                               _bookingViewModel.booking.update((val) {
          //                                 val?.doctorName =
          //                                     _data.getElementValue(
          //                                   DoctorKeys.fullName,
          //                                 );

          //                                 val?.doctorId =
          //                                     _data.trackedEntityInstance;
          //                               });

          //                               Get.back();
          //                             },
          //                             child: ListTile(
          //                               leading: Image.asset(
          //                                   '$logoPath/launcher.png'),
          //                               title: Text(
          //                                 _data.getElementValue(
          //                                     DoctorKeys.fullName),
          //                                 style: kHeading6.copyWith(
          //                                   fontSize: 16,
          //                                   fontWeight: FontWeight.bold,
          //                                   color: Colors.black,
          //                                 ),
          //                               ),
          //                               subtitle: Text(
          //                                 "DOKTER UMUM",
          //                                 style: kBodyText.copyWith(
          //                                   color: Colors.black,
          //                                 ),
          //                               ),
          //                             ),
          //                           ),
          //                         );
          //                       },
          //                     ),
          //                   );
          //           }),
          //         );
          //       },
          //     );
          //   }),
          // ),
          // const SizedBox(height: 20),
          // Obx(() {
          //   return _bookingViewModel.loading.isTrue
          //       ? Center(child: loadingWidget)
          //       : cardFieldCustomWidget(
          //           key: _bookingViewModel.booking.value.service.toString(),
          //           value: _bookingViewModel.price.value.isNotEmpty
          //               ? formatCurrency(_bookingViewModel.price.value)
          //               : "Rp. 0",
          //           styleBackground: BoxDecoration(
          //             color: AppColors.grey200Color,
          //             borderRadius: BorderRadius.circular(3),
          //           ),
          //           styleKey: kBodyText.copyWith(
          //               color: AppColors.primaryColorDarkColor,
          //               fontWeight: FontWeight.w400,
          //               fontSize: 12),
          //           styleValue: kBodyText.copyWith(
          //               color: AppColors.primaryColor,
          //               fontWeight: FontWeight.w500,
          //               fontSize: 12),
          //         );
          // }),
        ],
      ),
      onNext: () {
        //
        Navigator.pushNamed(context, AppointmentSchedulePage.routeName);
      },
    );
  }

  _onClickNext() {
    //
  }

  _validate() {
    //
  }

  _onSearch(String val) {}

  _onChangeServiceTpe() {
    //
  }

  Future listClinic() async {
    //
  }
}
