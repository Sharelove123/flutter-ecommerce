import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryChip extends ConsumerWidget {
  final String? categoryname;
  final int? index;
  final VoidCallback? fun;
  CategoryChip({super.key,required this.categoryname,required this.index,required this.fun});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ChoiceChip(
      label: Text(categoryname!),
      selected: true,

    );
  }
}