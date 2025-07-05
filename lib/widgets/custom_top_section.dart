import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:notes/widgets/custom_search_bar.dart';

class CustomTopSection extends HookWidget {
  final String name;
  final ValueChanged<String>? onSubmitted;
  CustomTopSection({required this.name, required this.onSubmitted, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      height: 180,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(top: 24, left: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Hi, $name", style: TextStyle(fontSize: 24)),
            SizedBox(height: 8),
            Text(
              "My Notes",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 24),
              child: CustomSearchBar(onSubmitted: onSubmitted),
            ),
            SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}
