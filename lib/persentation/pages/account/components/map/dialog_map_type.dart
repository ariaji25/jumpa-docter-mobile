import 'package:flutter/material.dart';
import '../../../../../common/theme/theme.dart';
import 'menu_dialog_map.dart';

class DialogMapType extends StatelessWidget {
  final VoidCallback tipeNormal;
  final VoidCallback tipeSatelit;

  const DialogMapType(
      {Key? key, required this.tipeNormal, required this.tipeSatelit})
      : super(key: key);

  dialogContent(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Tipe Map",
                  style: AppTheme.bodyText.copyWith(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: const Icon(
                    Icons.close,
                    size: 22,
                    color: Colors.black,
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 1,
            color: const Color(0xFF757575),
            width: double.infinity,
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
            child: Column(
              children: [
                MenuDialog(
                  title: "Normal",
                  onTap: () {
                    Navigator.of(context).pop();
                    tipeNormal();
                  },
                ),
                MenuDialog(
                  title: "Satelit",
                  onTap: () {
                    Navigator.of(context).pop();
                    tipeSatelit();
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }
}
