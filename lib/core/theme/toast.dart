// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

/// Toast types
enum ToastType {
  error(Colors.red),
  success(Colors.green),
  info(Colors.lightBlue);

  final Color color;
  const ToastType(this.color);
}
