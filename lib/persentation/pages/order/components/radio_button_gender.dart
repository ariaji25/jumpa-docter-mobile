import 'package:flutter/material.dart';

import '../../../../common/resources/colors.dart';
import '../../../../common/theme/theme.dart';

class RadioButtonGender extends StatelessWidget {
  final String gender;
  final ValueChanged<String> onTap;

  const RadioButtonGender({Key? key, required this.gender, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildGender();
  }

  Widget _buildGender() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: "Jenis Kelamin",
            style: AppTheme.bodyText.copyWith(
                color: AppColors.primaryColorDarkColor,
                fontSize: 12,
                fontWeight: FontWeight.w400),
            children: <TextSpan>[
              TextSpan(
                text: '*',
                style: AppTheme.bodyText.copyWith(
                    fontWeight: FontWeight.w800,
                    fontSize: 12,
                    color: Colors.red),
              ),
            ],
          ),
        ),
        Transform.translate(
          offset: const Offset(-10, -5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: RadioListTile(
                  title: Transform.translate(
                    offset: const Offset(-15, 0),
                    child: Text(
                      'Laki-laki',
                      style: AppTheme.bodyText.copyWith(
                          fontSize: 14,
                          color: const Color(0XFF27272E),
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  value: "male",
                  selected: gender == "male",
                  groupValue: gender,
                  activeColor: const Color(0XFF051033),
                  selectedTileColor: const Color(0XFF051033),
                  tileColor: const Color(0XFF4A5568),
                  contentPadding: const EdgeInsets.all(0),
                  onChanged: (value) {
                    onTap(value.toString());
                  },
                ),
              ),
              Expanded(
                flex: 1,
                child: RadioListTile(
                  title: Transform.translate(
                    offset: const Offset(-15, 0),
                    child: Text(
                      'Perempuan',
                      style: AppTheme.bodyText.copyWith(
                          fontSize: 14,
                          color: const Color(0XFF27272E),
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  value: "female",
                  selected: gender == "female",
                  groupValue: gender,
                  activeColor: const Color(0XFF051033),
                  selectedTileColor: const Color(0XFF051033),
                  tileColor: const Color(0XFF4A5568),
                  contentPadding: const EdgeInsets.all(0),
                  onChanged: (value) {
                    onTap(value.toString());
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String getGender(String? value) {
    if (value == null) return "-";

    if (value == "male") {
      return "Laki-laki";
    } else if (value == "female") {
      return "Perempuan";
    } else {
      return "-";
    }
  }
}
