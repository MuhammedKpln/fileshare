import 'package:boilerplate/core/theme/palette.dart';
import 'package:boilerplate/shared/components/back_button.dart';
import 'package:boilerplate/shared/components/refresh_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class nameClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final firstEndPoint = Offset(10, size.height * 0.7);
    final firstControlPoint = Offset(35, size.height * 0.7);

    return Path()
      ..lineTo(0, size.height)
      ..quadraticBezierTo(
        firstEndPoint.dx,
        firstEndPoint.dy,
        firstControlPoint.dx,
        firstControlPoint.dy,
      )
      ..lineTo(size.width, size.height * .7)
      ..lineTo(size.width, 0)
      ..moveTo(0, 0)
      ..lineTo(size.width, size.height * .7)
      ..lineTo(size.width, 0)
      ..close();
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class SendFileView extends StatelessWidget {
  const SendFileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('transferingProcessTitleTxt').tr(),
        leadingWidth: 72,
        leading: Padding(
          padding: EdgeInsets.only(left: ThemePadding.medium.padding),
          child: const CustomBackButton(),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: ThemePadding.medium.padding),
            child: RefreshButton(onPressed: () => null, onRefresh: true),
          )
        ],
      ),
      body: Center(
        child: ClipPath(
          clipper: nameClipper(),
          child: Container(
            decoration: const BoxDecoration(color: Colors.red),
            width: 200,
            height: 100,
          ),
        ),
      ),
    );
  }
}
