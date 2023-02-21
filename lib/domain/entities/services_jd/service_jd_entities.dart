import 'package:flutter/material.dart';

class JumpaDokterServiceEntities {
  final String title;
  final String logoPath;
  final Color? bgColor;
  final Color titleColor;
  final String serviceId;

  JumpaDokterServiceEntities({
    required this.title,
    required this.logoPath,
    required this.titleColor,
    required this.serviceId,
    this.bgColor,
  });
}
