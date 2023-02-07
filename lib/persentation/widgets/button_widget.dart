import 'package:flutter/material.dart';
import 'package:jd_mobile/common/resources/colors.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({super.key, required this.title, required this.onTap});

  final String title;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: () {
          onTap();
        },
        child: Text(title),
      ),
    );
  }
}

class OutlineedButtonWidget extends StatelessWidget {
  const OutlineedButtonWidget({
    super.key,
    required this.title,
    required this.onTap,
  });

  final String title;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primaryColor,
          side: const BorderSide(
            color: AppColors.primaryColor,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () {
          onTap();
        },
        child: Text(title),
      ),
    );
  }
}
