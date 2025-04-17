import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage(name: 'VerifyEmailRoute')
class VerifyEmail extends StatelessWidget {
  const VerifyEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(children: [Text('Verify Email')]));
  }
}
