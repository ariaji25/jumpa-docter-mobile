import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jd_mobile/common/theme/theme.dart';
import '../../common/helpers/date_helper.dart';
import '../../common/resources/assets.dart';
import '../../common/resources/colors.dart';

Widget textSearchFieldWidget({
  required TextEditingController controller,
  required Function(String) onChanged,
}) {
  return Container(
    height: 46,
    decoration: BoxDecoration(
      color: const Color(0XFFEDF2F7),
      borderRadius: BorderRadius.circular(6),
    ),
    child: TextFormField(
      controller: controller,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp('[a-zA-Z-" "]'))
      ],
      style: GoogleFonts.inter(color: AppColors.primaryColor),
      onChanged: onChanged,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(top: 15),
        hintText: "Cari dokter",
        hintStyle: AppTheme.bodyText.copyWith(
          color: const Color(0XFFA6B7D4),
          fontSize: 14,
        ),
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(6),
            ),
            borderSide: BorderSide(color: Color(0XFFEDF2F7))),
        enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(6),
            ),
            borderSide: BorderSide(color: Color(0XFFEDF2F7))),
        focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(6),
            ),
            borderSide: BorderSide(color: Color(0XFFEDF2F7))),
        isDense: true,
        prefixIcon: SizedBox(
          height: 16,
          width: 16,
          child: Image.asset(
            "${Assets.iconsPath}/search.png",
            color: const Color(0XFFA6B7D4),
          ),
        ),
      ),
    ),
  );
}

Widget textfieldSearchArticleWidget({
  required TextEditingController controller,
  required Function onTap,
}) {
  return Container(
    height: 50,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6), color: const Color(0XFFEDF2F7)),
    child: TextFormField(
      controller: controller,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(20.0),
        hintText: "Cari Artikel...",
        // hintStyle: const TextStyle(fontSize: 12),
        hintStyle: GoogleFonts.inter(
            fontSize: 14,
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

        prefixIcon: IconButton(
          onPressed: () {
            onTap();
          },
          icon: const Icon(
            Icons.search,
            color: Color(0XFFA6B7D4),
          ),
        ),
      ),
    ),
  );
}

Widget textFieldWidget(
    {required String label,
    TextEditingController? controller,
    required TextInputType inputType,
    required Function(String) onChanged,
    List<TextInputFormatter>? formatters,
    String? hintText,
    int minLines = 1,
    int maxLines = 1,
    double contentPadding = 10.0,
    bool isEnabled = true,
    bool isOptional = false,
    bool isUnderline = false,
    Widget? suffix,
    Widget? prefix,
    Widget? suffixIcon,
    Widget? prefixIcon,
    bool isShowingLable = true,
    bool isName = false,
    bool isNik = false,
    bool isTelephone = false,
    TextStyle? style,
    InputDecoration? inputDecoration}) {
  return TextFormField(
    style: style,
    enabled: isEnabled,
    minLines: minLines,
    maxLines: maxLines,
    inputFormatters: formatters,
    maxLength: isNik
        ? 16
        : isTelephone
            ? 15
            : null,
    validator: isEnabled
        ? (value) {
            if (!isOptional) {
              if (isName) {
                if (value.toString().length <= 2) {
                  return "Nama harus lebih dari 2 karakter";
                } else {
                  return null;
                }
              }

              if (isNik) {
                if (value.toString().length != 16) {
                  return "NIK harus 16 digit";
                } else {
                  return null;
                }
              }

              if (value!.isEmpty) {
                return "$label tidak boleh kosong";
              } else {
                return null;
              }
            } else {
              return null;
            }
          }
        : null,
    controller: controller,
    keyboardType: inputType,
    onChanged: onChanged,
    decoration: inputDecoration ??
        InputDecoration(
          filled: !isEnabled,
          fillColor: (!isEnabled)
              ? AppColors.greyColor.withOpacity(0.2)
              : Colors.transparent,
          contentPadding: EdgeInsets.all(contentPadding),
          labelText: isShowingLable ? label : "",
          hintText: hintText,
          border: isUnderline
              ? const UnderlineInputBorder()
              : const OutlineInputBorder(),
          isDense: true,
          suffix: suffix,
          prefix: prefix,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
        ),
  );
}

Widget textFieldWidgetWithBorder(
    {String? label,
    TextEditingController? controller,
    required TextInputType inputType,
    required Function(String) onChanged,
    List<TextInputFormatter>? formatters,
    String? hintText,
    int minLines = 1,
    int maxLines = 1,
    double contentPadding = 10.0,
    bool isEnabled = true,
    bool isOptional = false,
    bool isUnderline = false,
    Widget? suffix,
    Widget? prefix,
    Widget? suffixIcon,
    Widget? prefixIcon,
    bool isShowingLable = true,
    bool isName = false,
    bool isNik = false,
    bool isTelephone = false,
    TextStyle? style,
    TextStyle? labelStyle,
    InputDecoration? inputDecoration}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Visibility(
        visible: label != null,
        child: RichText(
          text: TextSpan(
            text: label,
            style: labelStyle ??
                AppTheme.bodyText.copyWith(
                    color: AppColors.primaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
            children: <TextSpan>[
              TextSpan(
                text: isOptional ? '' : '*',
                style: AppTheme.bodyText.copyWith(
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                    color: Colors.red),
              ),
            ],
          ),
        ),
      ),
      Visibility(
        visible: label != null,
        child: const SizedBox(
          height: 10,
        ),
      ),
      TextFormField(
          style: style,
          enabled: isEnabled,
          minLines: minLines,
          maxLines: maxLines,
          inputFormatters: formatters,
          maxLength: isNik
              ? 16
              : isTelephone
                  ? 15
                  : null,
          validator: isEnabled
              ? (value) {
                  if (!isOptional) {
                    if (isName) {
                      if (value.toString().length <= 2) {
                        return "Nama harus lebih dari 2 karakter";
                      } else {
                        return null;
                      }
                    }

                    if (isNik) {
                      if (value.toString().length != 16) {
                        return "NIK harus 16 digit";
                      } else {
                        return null;
                      }
                    }

                    if (value!.isEmpty) {
                      return "${label ?? "Inputan"} tidak boleh kosong";
                    } else {
                      return null;
                    }
                  } else {
                    return null;
                  }
                }
              : null,
          controller: controller,
          keyboardType: inputType,
          onChanged: onChanged,
          decoration: inputDecoration ??
              InputDecoration(
                filled: !isEnabled,
                fillColor: (!isEnabled)
                    ? AppColors.greyColor.withOpacity(0.2)
                    : Colors.transparent,
                contentPadding: EdgeInsets.all(contentPadding),
                hintText: hintText,
                hintStyle: AppTheme.bodyText.copyWith(
                    fontSize: 14,
                    color: const Color(0XFFB5B5BD),
                    fontWeight: FontWeight.w400),
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                    borderSide: BorderSide(
                      color: AppColors.primaryColor,
                      width: 1,
                    )),
                enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                    borderSide: BorderSide(
                      color: AppColors.primaryColor,
                      width: 1,
                    )),
                focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                    borderSide: BorderSide(
                      color: AppColors.primaryColor,
                      width: 1,
                    )),
                isDense: true,
                suffix: suffix,
                prefix: prefix,
                suffixIcon: suffixIcon,
                prefixIcon: prefixIcon,
              )),
    ],
  );
}

Widget dropDownSearchWidget({
  required String label,
  required TextEditingController controller,
  required List<dynamic> items,
  required Function(dynamic) onChanged,
  Function? getData,
  bool isEnabled = true,
  bool isOptional = false,
  bool isUnderline = false,
}) {
  return DropdownSearch<dynamic>(
    enabled: isEnabled,
    items: items,
    selectedItem: controller.text == "" ? null : controller.text,
    popupTitle: Container(
      margin: const EdgeInsets.all(15),
      child: Center(
        child: Text(
          label,
          style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
    ),
    compareFn: (a, b) => a == b,
    maxHeight: 200,
    onFind: getData == null ? null : (dynamic filter) => getData(filter),
    validator: isEnabled
        ? (value) {
            if (!isOptional) {
              if (value == null || value == '') {
                return "$label tidak boleh kosong";
              } else {
                return null;
              }
            }
            return null;
          }
        : null,
    onChanged: onChanged,
    showSearchBox: getData == null ? false : true,
    dropdownSearchDecoration: InputDecoration(
      labelText: label,
      contentPadding: const EdgeInsets.fromLTRB(10, 10, 0, 20),
      border: isUnderline
          ? const UnderlineInputBorder()
          : const OutlineInputBorder(),
      isDense: true,
    ),
  );
}

Widget radioButtonWidget({
  required String label,
  required String value,
  required String grupVal,
  required Function(dynamic) onChanged,
}) {
  return RadioListTile(
    dense: true,
    value: value,
    groupValue: grupVal,
    onChanged: onChanged,
    title: Text(
      label,
      style: GoogleFonts.inter(fontSize: 14.0),
    ),
    controlAffinity: ListTileControlAffinity.leading,
    activeColor: Colors.green,
  );
}

Widget dateFieldWidget({
  required String label,
  TextEditingController? dateController,
  required BuildContext context,
  required Function(String) onChanged,
  bool isEnabled = true,
  bool isOptional = false,
  bool isUnderline = false,
  Widget? suffix,
  Widget? prefix,
  Widget? suffixIcon,
  Widget? prefixIcon,
}) {
  return TextFormField(
    enabled: isEnabled,
    onTap: () async {
      var dataTime = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1922),
        lastDate: DateTime.now(),
      );
      dateController?.text =
          DateHelper.changeFormatIdToDateTimeFormat(date: dataTime) ?? "";

      onChanged(dateController?.text ?? "");
    },
    validator: isEnabled
        ? (value) {
            if (!isOptional) {
              if (value!.isEmpty) {
                return "$label tidak boleh kosong";
              } else {
                return null;
              }
            } else {
              return null;
            }
          }
        : null,
    onSaved: (value) {},
    onChanged: (value) {},
    controller: dateController,
    readOnly: true,
    decoration: InputDecoration(
      label: Text(label),
      border: isUnderline
          ? const UnderlineInputBorder()
          : const OutlineInputBorder(),
      isDense: true,
      suffix: suffix,
      prefix: prefix,
      suffixIcon: suffixIcon,
      prefixIcon: prefixIcon,
    ),
  );
}

Widget dateFieldWidgetWithBorder({
  required String label,
  String? hintText,
  TextEditingController? dateController,
  required BuildContext context,
  required Function(String) onChanged,
  bool isEnabled = true,
  bool isOptional = false,
  bool isUnderline = false,
  Widget? suffix,
  Widget? prefix,
  Widget? suffixIcon,
  Widget? prefixIcon,
}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      RichText(
        text: TextSpan(
          text: label,
          style: AppTheme.bodyText.copyWith(
              color: AppColors.primaryColorDarkColor,
              fontSize: 14,
              fontWeight: FontWeight.w400),
          children: <TextSpan>[
            TextSpan(
              text: isOptional ? '' : '*',
              style: GoogleFonts.inter(
                  fontWeight: FontWeight.w800, fontSize: 14, color: Colors.red),
            ),
          ],
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      TextFormField(
        enabled: isEnabled,
        onTap: () async {
          var dataTime = await showDatePicker(
            locale: const Locale('id'),
            context: context,
            initialDate: dateController != null && dateController.text != ""
                ? DateHelper.covertStringToDateTime(
                    value: dateController.text.toString())!
                : DateTime.now(),
            firstDate: DateTime(1922),
            lastDate: DateTime.now(),
          );
          if (dataTime != null) {
            dateController?.text = DateHelper.changeFormatIdToDateTimeFormat(
                    date: dataTime, newPatternId: true) ??
                "";
            onChanged(dateController?.text ?? "");
          }
        },
        validator: isEnabled
            ? (value) {
                if (!isOptional) {
                  if (value!.isEmpty) {
                    return "$label tidak boleh kosong";
                  } else {
                    return null;
                  }
                } else {
                  return null;
                }
              }
            : null,
        onSaved: (value) {},
        onChanged: (value) {},
        controller: dateController,
        readOnly: true,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: AppTheme.bodyText.copyWith(
              fontSize: 14,
              color: const Color(0XFFB5B5BD),
              fontWeight: FontWeight.w400),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(6)),
              borderSide: BorderSide(
                color: AppColors.primaryColor,
                width: 1,
              )),
          enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(6)),
              borderSide: BorderSide(
                color: AppColors.primaryColor,
                width: 1,
              )),
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(6)),
              borderSide: BorderSide(
                color: AppColors.primaryColor,
                width: 1,
              )),
          isDense: true,
          suffix: suffix,
          prefix: prefix,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
        ),
      ),
    ],
  );
}
