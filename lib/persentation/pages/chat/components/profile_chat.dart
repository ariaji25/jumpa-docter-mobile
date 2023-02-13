import 'package:flutter/material.dart';

import '../../../../common/resources/assets.dart';

class ProfileChatWidget extends StatelessWidget {
  final double size;

  const ProfileChatWidget({Key? key, this.size = 50}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipOval(
          child: Image.asset(
            "${Assets.othersPath}/artic.png",
            height: size,
            width: size,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: ClipOval(
              child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(2),
                  child: ClipOval(
                      child: Container(
                    height: size / 6,
                    width: size / 6,
                    color: Colors.green,
                  )))),
        )
      ],
    );
  }
}
