import 'package:flutter/material.dart';

class LoadingColumn extends StatelessWidget{
  const LoadingColumn({required this.message,super.key});
  final String message;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 12),
          Text('$message...'),
        ],
      ),
    );
  }

}