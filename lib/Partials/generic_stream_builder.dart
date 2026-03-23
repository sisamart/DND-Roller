import 'package:flutter/material.dart';

class GenericStreamBuilder<T> extends StatelessWidget {
  const GenericStreamBuilder(
      {super.key,
      required this.stream,
      this.onError,
      this.onWaiting,
      required this.onHasData,
      this.onOther});

  final Stream<T> stream;
  final Widget? onError;
  final Widget? onWaiting;
  final Widget Function(T data) onHasData;
  final Widget? onOther;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          if (onError == null) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          return onError!;
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          if (onWaiting == null) {
            return Center(child: CircularProgressIndicator());
          }
          return onWaiting!;
        } else if (snapshot.hasData) {
          return onHasData(snapshot.data!);
        } else {
          if (onOther == null) {
            return Center(child: Text("No data"));
          }
          return onOther!;
        }
      },
    );
  }
}
