// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jd_mobile/common/constants/app_const.dart';
import 'package:jd_mobile/common/helpers/date_helper.dart';
import 'package:jd_mobile/common/resources/size.dart';
import 'package:jd_mobile/common/resources/snackbar.dart';
import 'package:jd_mobile/common/utils/state_enum.dart';
import 'package:jd_mobile/domain/entities/booking/booking_enitites.dart';
import 'package:jd_mobile/persentation/pages/homecare/payment_detail.dart';
import 'package:jd_mobile/persentation/pages/order/summary_page.dart';
import 'package:jd_mobile/persentation/provider/order/order_provider.dart';
import 'package:jd_mobile/persentation/provider/patient/patient_provider.dart';
import 'package:provider/provider.dart';

import '../../../common/resources/colors.dart';
import '../../../common/theme/theme.dart';
import 'components/base_screen_order.dart';
import 'components/date_card.dart';

class AppointmentSchedulePage extends StatefulWidget {
  static const routeName = "/AppointmentSchedulePage";

  const AppointmentSchedulePage({
    Key? key,
  }) : super(key: key);

  @override
  AppointmentSchedulePageState createState() => AppointmentSchedulePageState();
}

class AppointmentSchedulePageState extends State<AppointmentSchedulePage> {
  DateFormat dateFormat = DateFormat.Hm();
  late OrderProvider orderProvider;
  late PatientProvider patientProvider;

  @override
  void initState() {
    super.initState();
    orderProvider = Provider.of<OrderProvider>(context, listen: false);
    patientProvider = Provider.of<PatientProvider>(context, listen: false);
    orderProvider.setDates(List.generate(
      7,
      (index) => DateTime.now().add(
        Duration(days: index),
      ),
    ));
    orderProvider.setSelectedDate(orderProvider.dates?[0]);

    _generateTime();

    Future.delayed(const Duration(milliseconds: 300), () {
      BookingEntites bookingEntities = orderProvider.bookingEntities;
      bookingEntities.visitDate =
          DateHelper.dhis2DateFormat(orderProvider.selectedDate!);
      orderProvider.updateBooking(bookingEntities);
    });
  }

  @override
  Widget build(BuildContext context) {
    OrderProvider orderProvider =
        Provider.of<OrderProvider>(context, listen: true);
    return BaseOrderScreen(
      title: "Pilih Jadwal Temu Dokter",
      subTitle: "Pilih jadwal untuk bertemu dokter anda",
      btnTitle: "Pesan",
      onNext: () {
        _onClickNext(orderProvider);
      },
      loading: orderProvider.makeAppointmentState == RequestState.Loading,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Divider(thickness: 1),
          const SizedBox(height: 25),
          Text(
            "Pilih tanggal berobat",
            style: AppTheme.subtitle.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: AppColors.primaryColorDarkColor,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.only(bottom: 25),
            height: 90,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: orderProvider.dates?.length,
              itemBuilder: (_, index) => Container(
                margin: EdgeInsets.only(
                  right: (index < orderProvider.dates!.length - 1)
                      ? 5
                      : SizeConstants.margin,
                ),
                child: DateCard(
                  orderProvider.dates![index],
                  isSelected:
                      orderProvider.selectedDate == orderProvider.dates![index],
                  onTap: () {
                    orderProvider.setSelectedDate(orderProvider.dates![index]);
                    BookingEntites bookingEntities =
                        orderProvider.bookingEntities;
                    bookingEntities.visitDate =
                        DateHelper.dhis2DateFormat(orderProvider.selectedDate!);
                    orderProvider.updateBooking(bookingEntities);
                  },
                ),
              ),
            ),
          ),
          Text(
            "Pilih waktu berobat",
            style: AppTheme.subtitle.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: AppColors.primaryColorDarkColor,
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: Wrap(
              runSpacing: 10,
              alignment: WrapAlignment.spaceBetween,
              children: [
                if (orderProvider.times != null)
                  ...orderProvider.times!.map(
                    (items) {
                      DateTime beforeTimes = dateFormat.parse(items);
                      DateTime nowTimes = DateTime.now();

                      // * Check the day on the selected date is the same as today
                      if (orderProvider.selectedDate!.day ==
                          DateTime.now().day) {
                        if (beforeTimes.hour > nowTimes.hour) {
                          // * Check the available hours are past the current hours
                          return TimeTable(
                            isActive: orderProvider.selectedTime == items,
                            onTap: () {
                              orderProvider.setSelectedTime(items);
                              BookingEntites bookingEntities =
                                  orderProvider.bookingEntities;
                              bookingEntities.visitTime = items;
                              orderProvider.updateBooking(bookingEntities);
                            },
                            value: items,
                          );
                        } else {
                          return const Material(
                            color: Colors.red,
                          );
                        }
                      } else {
                        return TimeTable(
                          isActive: orderProvider.selectedTime == items,
                          onTap: () {
                            orderProvider.setSelectedTime(items);

                            BookingEntites bookingEntities =
                                orderProvider.bookingEntities;
                            bookingEntities.visitTime = items;
                            orderProvider.updateBooking(bookingEntities);
                          },
                          value: items,
                        );
                      }
                    },
                  ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  _onClickNext(OrderProvider orderProvider) {
    if (orderProvider.bookingEntities.visitTime?.isNotEmpty ?? true) {
      _makeAppointment(orderProvider);
    } else {
      _validate();
    }
  }

  _validate() {
    SnackBarCustom.showSnackBarMessage(
      context: context,
      title: "Opps !",
      message: "Silahkan lengkapi informasi pemesanan anda!",
      typeMessage: SnackBarType.error,
    );
  }

  _makeAppointment(OrderProvider orderProvider) async {
    if (orderProvider.serviceItemSelected == 0) {
      Navigator.pushNamed(context, PaymentDetailPage.routeName);
    } else {
      if (orderProvider.bookingEntities.orderType == AppConst.ORDER_FOR_OTHER) {
        // orderProvider.bookingEntities.teiReference =
        //    orderProvider.patient.value.tei;
        orderProvider.bookingEntities.refNIK = patientProvider.patient.nik;
        orderProvider.bookingEntities.refNama = patientProvider.patient.name;
        orderProvider.bookingEntities.orderType = AppConst.ORDER_BY_OTHER;
        orderProvider.bookingEntities.status = "COMPLETED";
        await orderProvider.makeAppointment();

        if (orderProvider.makeAppointmentState != RequestState.Loaded) {
          SnackBarCustom.showSnackBarMessage(
            context: context,
            title: "Hmmm !",
            message: "Maaf ya, Pesananmu belum berhasil dibuat nih!",
            typeMessage: SnackBarType.error,
          );
        }
      }

      if ((orderProvider.makeAppointmentState == RequestState.Loaded &&
              orderProvider.bookingEntities.orderType ==
                  AppConst.ORDER_FOR_OTHER) ||
          orderProvider.bookingEntities.orderType != AppConst.ORDER_FOR_OTHER) {
        // Store the booking history in patient
        orderProvider.bookingEntities.teiReference =
            patientProvider.patient.tei;
        // orderProvider.bookingEntities.refNIK =
        //     orderProvider.patient.value.nik;
        // orderProvider.bookingEntities.refNama =
        //     orderProvider.patient.value.name;
        orderProvider.bookingEntities.orderType = AppConst.ORDER_FOR_OTHER;
        orderProvider.bookingEntities.status = "ACTIVE";
        await orderProvider.makeAppointment();
        if (orderProvider.makeAppointmentState == RequestState.Loaded) {
          if (mounted) {
            Navigator.pushNamed(context, SummaryPage.routeName);
          }
          SnackBarCustom.showSnackBarMessage(
              context: context,
              title: "Yey !",
              message: "Berhasil memesan layanan.",
              typeMessage: SnackBarType.success);
        } else {
          SnackBarCustom.showSnackBarMessage(
              context: context,
              title: "Hmmm !",
              message: "Maaf ya, Pesananmu belum berhasil dibuat nih!",
              typeMessage: SnackBarType.error);
        }
      }
    }
  }

  void _generateTime() {
    final now = DateTime.now();
    var time = DateTime(now.year, now.month, now.day, 9);
    orderProvider.times = List.generate(25, (index) {
      if (index > 0) {
        time = time.add(const Duration(minutes: 30));
      }

      return "${time.hour.toString().padLeft(2, "0")}:${time.minute.toString().padLeft(2, "0")}";
    });
  }
}

class TimeTable extends StatelessWidget {
  final bool isActive;
  final Function onTap;
  final String value;

  const TimeTable({
    Key? key,
    required this.isActive,
    required this.onTap,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Container(
          height: 39,
          width: 96,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: isActive ? AppColors.primaryColor : AppColors.whiteColor,
            border: Border.all(
              color: !isActive ? AppColors.primaryColor : AppColors.whiteColor,
            ),
          ),
          child: Center(
            child: Text(
              value,
              style: AppTheme.subtitle.copyWith(
                  color:
                      isActive ? AppColors.whiteColor : AppColors.primaryColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ),
      ),
    );
  }
}
