import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jd_mobile/common/helpers/date_helper.dart';
import 'package:jd_mobile/common/resources/size.dart';
import 'package:jd_mobile/common/resources/snackbar.dart';
import 'package:jd_mobile/persentation/pages/order/summary_page.dart';
import 'package:jd_mobile/persentation/provider/order/order_provider.dart';
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
  List<DateTime>? dates;
  List<String>? times;
  DateTime? selectedDate;
  String? selectedTime;
  DateFormat dateFormat = DateFormat.Hm();
  late OrderProvider orderProvider;

  @override
  void initState() {
    super.initState();
    orderProvider = Provider.of<OrderProvider>(context, listen: false);
    dates = List.generate(
      7,
      (index) => DateTime.now().add(
        Duration(days: index),
      ),
    );
    selectedDate = dates![0];

    _generateTime();

    Future.delayed(const Duration(milliseconds: 300), () {
      orderProvider.bookingEntities.visitDate = DateHelper.dhis2DateFormat(selectedDate!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseOrderScreen(
      title: "Pilih Jadwal Temu Dokter",
      subTitle: "Pilih jadwal untuk bertemu dokter anda",
      btnTitle: "Pesan",
      onNext: _onClickNext,
      loading: false,
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
              itemCount: dates!.length,
              itemBuilder: (_, index) => Container(
                margin: EdgeInsets.only(
                  right: (index < dates!.length - 1) ? 5 : SizeConstants.margin,
                ),
                child: DateCard(
                  dates![index],
                  isSelected: selectedDate == dates![index],
                  onTap: () {
                    setState(() {
                      selectedDate = dates![index];
                    });

                    //TODO SET VISIT DATE BOOKING
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
                if (times != null)
                  ...times!.map(
                    (items) {
                      DateTime beforeTimes = dateFormat.parse(items);
                      DateTime nowTimes = DateTime.now();

                      // * Check the day on the selected date is the same as today
                      if (selectedDate!.day == DateTime.now().day) {
                        if (beforeTimes.hour > nowTimes.hour) {
                          // * Check the available hours are past the current hours
                          return TimeTable(
                            isActive: selectedTime == items,
                            onTap: () {
                              setState(() {
                                selectedTime = items;
                              });

                              orderProvider.bookingEntities.visitDate = DateHelper.dhis2DateFormat(selectedDate!);
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
                          isActive: selectedTime == items,
                          onTap: () {
                            setState(() {
                              selectedTime = items;
                            });

                            orderProvider.bookingEntities.visitTime = items;
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

  _onClickNext() {
    if ( orderProvider.bookingEntities.visitTime?.isNotEmpty ??true) {
      _makeAppointment();
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

  _makeAppointment() async {
    orderProvider.createBooking();
    if (/*TODO CHECK SERVICE ITEM SELECTED*/ false) {
      //TODO GO TO PAYMENT DETAIL
    } else {
      if (/*TODO CHECK ORDER TYPE*/ true) {
        /*TODO CREATE BOOKING*/

        if (/*TODO BOOKING FALSE*/ false) {
          SnackBarCustom.showSnackBarMessage(
            context: context,
            title: "Hmmm !",
            message: "Maaf ya, Pesananmu belum berhasil dibuat nih!",
            typeMessage: SnackBarType.error,
          );
        }
      }

      if (/*TODO CHECK BOOKING TYPE*/ true) {
        // Store the booking history in patient
        //TODO CREATE BOOKING
        if (/*TODO BOOKING SUCCESS*/ true) {
          SnackBarCustom.showSnackBarMessage(
              context: context,
              title: "Yey !",
              message: "Berhasil memesan layanan.",
              typeMessage: SnackBarType.success);
          Navigator.pushNamed(context, SummaryPage.routeName);
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
    times = List.generate(25, (index) {
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
