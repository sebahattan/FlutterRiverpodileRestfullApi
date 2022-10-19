import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

class LoadingWidget extends StatelessWidget {
  bool? isLoading;
  Widget child;

  LoadingWidget({
    this.isLoading,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading == null) {
      return const Center(
        child: CircularProgressIndicator(
          color: Colors.orange,
        ),
      );
    } else if (isLoading == false) {
      return const Center(
        child: Text("Bir sorun oluştu,tekrar deneyin"),
      );
    } else {
      return child;
    }
  }
}
