import 'package:flutter/material.dart';
import 'package:jd_mobile/common/constants/app_const.dart';
import 'package:jd_mobile/common/extensions/entities_ext.dart';
import 'package:jd_mobile/common/extensions/padding_ext.dart';
import 'package:jd_mobile/common/resources/assets.dart';
import 'package:jd_mobile/common/resources/colors.dart';
import 'package:jd_mobile/common/resources/snackbar.dart';
import 'package:jd_mobile/common/theme/theme.dart';
import 'package:jd_mobile/common/utils/state_enum.dart';
import 'package:jd_mobile/domain/entities/booking/booking_enitities.dart';
import 'package:jd_mobile/domain/entities/booking/organisation_units_entities.dart';
import 'package:jd_mobile/domain/entities/patient/tracked_entity_instances_entities.dart';
import 'package:jd_mobile/persentation/pages/order/components/base_screen_order.dart';
import 'package:jd_mobile/persentation/pages/order/components/card_field.dart';
import 'package:jd_mobile/persentation/pages/order/components/service_item.dart';
import 'package:jd_mobile/persentation/pages/order/schedule_page.dart';
import 'package:jd_mobile/persentation/provider/order/order_provider.dart';
import 'package:jd_mobile/persentation/widgets/button_widget.dart';
import 'package:provider/provider.dart';

import '../../../common/helpers/helpers.dart';
import '../../../data/models/booking/doctor_model.dart';
import '../../widgets/loading.dart';
import '../../widgets/universal_empty_state.dart';
import 'components/bottom_sheet.dart';

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

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 300), () async {
      OrderProvider orderProvider =
          Provider.of<OrderProvider>(context, listen: false);
      // Initial for get price list
      orderProvider.setDataSet("u210IplNxve");
      await orderProvider.getListClinics();

      BookingEntities bookingEntities = orderProvider.bookingEntities;
      bookingEntities.serviceType = serviceType[_serviceItemSelected];
      orderProvider.updateBooking(bookingEntities);
    });
  }

  @override
  Widget build(BuildContext context) {
    OrderProvider orderProvider = Provider.of<OrderProvider>(context);
    return BaseOrderScreen(
      title: "Pilih jenis layanan dan dokter",
      subTitle: "Pilih layanan dan dokter terbaik untuk melayani anda",
      btnTitle: "Lanjut",
      loading:
          orderProvider.requestCreateEnrollmentState == RequestState.Loading,
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
          Consumer<OrderProvider>(builder: (context, order, _) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: ServiceItem(
                    title: "Dokter ke rumah anda",
                    imagePath: "${Assets.iconsPath}/ic_home.png",
                    isActive: order.serviceItemSelected == 0,
                    onTap: () {
                      order.setServiceItemSelected(0);
                      // For get price list
                      order.setDataSet(AppConst.HOME_CARE);
                      _onChangeServiceTpe(order);

                      BookingEntities bookingEntities = order.bookingEntities;
                      bookingEntities.serviceType =
                          serviceType[_serviceItemSelected];
                      order.updateBooking(bookingEntities);
                    },
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  flex: 1,
                  child: ServiceItem(
                    title: "Datang ke klinik",
                    imagePath: "${Assets.iconsPath}/ic_hospital.png",
                    isActive: order.serviceItemSelected == 1,
                    onTap: () {
                      order.setServiceItemSelected(1);
                      // For get price list
                      order.setDataSet(AppConst.ONSITE);
                      _onChangeServiceTpe(order);

                      BookingEntities bookingEntities = order.bookingEntities;
                      bookingEntities.serviceType =
                          serviceType[_serviceItemSelected];
                      order.updateBooking(bookingEntities);
                    },
                  ),
                ),
              ],
            );
          }),
          const SizedBox(height: 25),
          Consumer<OrderProvider>(builder: (context, order, _) {
            return SearchButtonWidget(
              title: "Pilih Daerah Klinik",
              subtitle: order.bookingEntities.clinicArea ?? "Pilih",
              onTap: () {
                order.bookingEntities.clinicName = "Pilih";
                order.bookingEntities.doctorName = "Pilih";
                bottomSheetWidget(
                    context: context,
                    onSearch: (value){
                      order.getListClinics();
                    },
                    title: "Cari berdasarkan daerah Klinik",
                    inputType: TextInputType.text,
                    onClear: null,
                    child:
                        Consumer<OrderProvider>(builder: (context, order, _) {
                      return order.requestClinicsState == RequestState.Loaded
                          ? Expanded(
                              child: (order.clinics.organisationUnits?.length ??
                                          0) >
                                      0
                                  ? ListView.builder(
                                      itemCount: order.clinics.organisationUnits
                                              ?.length ??
                                          0,
                                      itemBuilder:
                                          (BuildContext context, int idx) {
                                        final data = order.clinics
                                                .organisationUnits?[idx] ??
                                            OrganisationUnitsEntities();

                                        return Padding(
                                          padding: paddingBottom(16),
                                          child: InkWell(
                                            onTap: () {
                                              BookingEntities bookingEntities =
                                                  order.bookingEntities;
                                              bookingEntities.clinicArea =
                                                  data.displayName ?? "-";
                                              bookingEntities.clinicAddress =
                                                  data.displayName ?? "-";
                                              order.updateBooking(
                                                  bookingEntities);
                                              //* Filtered clinic by area
                                              // _bookingViewModel.filterClinicByArea(
                                              //   _bookingViewModel
                                              //           .booking.value.clinicArea ??
                                              //       "",
                                              // );

                                              order.getListClinicsByArea(
                                                data.id ?? "-",
                                              );

                                              Navigator.of(context).pop();
                                            },
                                            child: ListTile(
                                              title: Text(
                                                data.displayName ?? "-",
                                                style:
                                                    AppTheme.heading5.copyWith(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    )
                                  : universalEmptyState(),
                            )
                          : const Loading();
                    }));
              },
            );
          }),
          const SizedBox(height: 11),
          Consumer<OrderProvider>(builder: (context, order, _) {
            return Visibility(
              visible: order.bookingEntities.clinicArea != null,
              child: SearchButtonWidget(
                  title: "Pilih Klinik",
                  subtitle: order.bookingEntities.clinicName ?? "Pilih",
                  onTap: () {
                    bottomSheetWidget(
                        context: context,
                        onSearch: _onSearch,
                        title: 'Cari berdasarkan nama Klinik',
                        inputType: TextInputType.text,
                        child: Consumer<OrderProvider>(
                            builder: (context, order, _) {
                          return order.requestClinicsAreaState ==
                                  RequestState.Loaded
                              ? Expanded(
                                  child: ListView.builder(
                                    itemCount: order.clinicsByArea
                                        .organisationUnits?.length,
                                    itemBuilder:
                                        (BuildContext context, int idx) {
                                      final data = order.clinicsByArea
                                          .organisationUnits?[idx];

                                      return Padding(
                                        padding: paddingBottom(16.0),
                                        child: InkWell(
                                          onTap: () {
                                            BookingEntities bookingEntities =
                                                order.bookingEntities;
                                            bookingEntities.clinicName =
                                                data?.displayName ?? "-";
                                            order
                                                .updateBooking(bookingEntities);

                                            // For get price list
                                            order.setOrgUnits(data?.id ?? "");

                                            //* Filtered doctors by organisationUnits
                                            order.setOrganisationUnitsId(
                                                data?.id ?? "");
                                            order
                                                .getListDoctors(data?.id ?? "");

                                            // Pice after select
                                            order.getPrice();
                                            Navigator.of(context).pop();
                                          },
                                          child: ListTile(
                                            title: Text(
                                              data?.displayName ?? "-",
                                              style: AppTheme.heading5.copyWith(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                )
                              : const Loading();
                        }));
                  }),
            );
          }),
          const SizedBox(height: 11),
          Consumer<OrderProvider>(builder: (context, order, _) {
            return SearchButtonWidget(
              title: "Pilih Dokter",
              subtitle: order.bookingEntities.doctorName ?? "Pilih",
              onTap: () {
                bottomSheetWidget(
                    context: context,
                    onSearch: _onSearch,
                    title: 'Cari berdasarkan nama Dokter',
                    inputType: TextInputType.text,
                    onClear: () async {
                      await order.getListDoctors(order.organisationUnitsId);
                    },
                    child:
                        Consumer<OrderProvider>(builder: (context, order, _) {
                      return order.requestDoctorsState == RequestState.Loaded
                          ? Expanded(
                              child: ListView.builder(
                                itemCount: order.doctors.trackedEntityInstances
                                        ?.length ??
                                    0,
                                itemBuilder: (BuildContext context, int idx) {
                                  final TrackedEntityInstancesEntities data =
                                      order.doctors
                                              .trackedEntityInstances?[idx] ??
                                          TrackedEntityInstancesEntities();

                                  return Padding(
                                    padding: paddingBottom(16.0),
                                    child: InkWell(
                                      onTap: () {
                                        BookingEntities bookingEntities =
                                            order.bookingEntities;
                                        bookingEntities.doctorName =
                                            data.getElementValue(
                                          DoctorKeys.fullName,
                                        );
                                        bookingEntities.doctorId =
                                            data.trackedEntityInstance;
                                        order.updateBooking(bookingEntities);
                                        Navigator.of(context).pop();
                                      },
                                      child: ListTile(
                                        leading: Image.asset(
                                            '${Assets.logoPath}/launcher.png'),
                                        title: Text(
                                          data.getElementValue(
                                              DoctorKeys.fullName),
                                          style: AppTheme.heading6.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        subtitle: Text(
                                          "DOKTER UMUM",
                                          style: AppTheme.bodyText.copyWith(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          : const Loading();
                    }));
              },
            );
          }),
          const SizedBox(height: 25),
          Consumer<OrderProvider>(builder: (context, order, _) {
            return order.requestPriceState == RequestState.Loading
                ? const Loading(
                    size: 20,
                  )
                : CardFieldWidget(
                    keys: order.bookingEntities.service.toString(),
                    value: order.price.isNotEmpty
                        ? Helpers.formatCurrency(order.price)
                        : "Rp. 0",
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
                  );
          }),
        ],
      ),
      onNext: () {
        if ((orderProvider.bookingEntities.clinicArea?.isNotEmpty ?? false) &&
            (orderProvider.bookingEntities.clinicName?.isNotEmpty ?? false) &&
            (orderProvider.bookingEntities.doctorName?.isNotEmpty ?? false)) {
          _onClickNext(orderProvider);
        } else {
          _validate();
        }
      },
    );
  }

  _onClickNext(OrderProvider orderProvider) async {
    BookingEntities bookingEntities = orderProvider.bookingEntities;
    bookingEntities.price = orderProvider.price;
    orderProvider.updateBooking(bookingEntities);
    await orderProvider.createNewEnrollment();
    if (orderProvider.requestCreateEnrollmentState == RequestState.Loaded) {
      if (mounted) {
        Navigator.pushNamed(context, AppointmentSchedulePage.routeName,
            arguments: _serviceItemSelected);
      }
    } else if (orderProvider.requestCreateEnrollmentState ==
        RequestState.Error) {
      SnackBarCustom.showSnackBarMessage(
          context: context,
          title: "Opps !",
          message: orderProvider.errorMessage,
          typeMessage: SnackBarType.warning);
    }
  }

  _validate() {
    SnackBarCustom.showSnackBarMessage(
        context: context,
        title: "Opps !",
        message: "Silahkan lengkapi informasi pemesanan anda!",
        typeMessage: SnackBarType.warning);
  }

  _onSearch(String val) {}

  _onChangeServiceTpe(OrderProvider order) {
    if (order.orgUnits.isNotEmpty) {
      order.getPrice();
    }
  }
}
