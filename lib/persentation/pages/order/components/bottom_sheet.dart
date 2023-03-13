import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../common/resources/colors.dart';
import '../../../../common/resources/size.dart';

bottomSheetWidget(
    {String title = 'Cari berdasarkan NIK',
    required BuildContext context,
    required Widget child,
    required Function(String) onSearch,
    Function()? onClear,
    bool? single,
    TextInputType inputType = TextInputType.number,
    bool isInputNIK = false}) {
  TextEditingController controller = TextEditingController();

  return showModalBottomSheet(
    enableDrag: true,
    backgroundColor: Colors.transparent,
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: SizeConstants.margin),
        height: MediaQuery.of(context).size.height * .80,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                width: 107,
                height: 3,
                color: AppColors.greyColor,
                margin: const EdgeInsets.symmetric(vertical: 5),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 20),
              child: Container(
                width: double.infinity,
                height: 47,
                decoration: const BoxDecoration(),
                child: TextFormField(
                  onChanged: (val) {
                    // onSearch(val);
                  },
                  onSaved: (val) {
                    onSearch(val ?? "");
                  },
                  keyboardType: inputType,
                  inputFormatters: inputType == TextInputType.number
                      ? (isInputNIK
                          ? [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
                              LengthLimitingTextInputFormatter(16),
                            ]
                          : [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
                            ])
                      : null,
                  controller: controller,
                  obscureText: false,
                  decoration: InputDecoration(
                    hintText: title,
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF505050),
                        width: 1,
                      ),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF505050),
                        width: 1,
                      ),
                    ),
                    suffixIcon: (single ?? false)
                        ? InkWell(
                            onTap: () {
                              onSearch(controller.text);
                            },
                            child: const Icon(
                              Icons.search_sharp,
                              color: Color(0xFF0D0D0D),
                              size: 22,
                            ),
                          )
                        : controller.text.isNotEmpty
                            ? InkWell(
                                onTap: onClear ??
                                    () {
                                      controller.clear();
                                    },
                                child: const Icon(
                                  Icons.clear,
                                  color: Color(0xFF0D0D0D),
                                  size: 22,
                                ),
                              )
                            : null,
                  ),
                  textAlign: TextAlign.start,
                  maxLines: 1,
                ),
              ),
            ),
            child,
          ],
        ),
      );
    },
  );
}
