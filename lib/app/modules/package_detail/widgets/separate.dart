import 'package:flutter/material.dart';

class Separate extends StatelessWidget {
  const Separate({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      endIndent: 0,
      thickness: 2,
      color: Colors.black.withOpacity(0.08),
    );
  }
}
