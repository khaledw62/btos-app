import 'package:btos/widgets/Values/theme.dart';
import 'package:flutter/material.dart';

InputDecoration inputDecoration({required String label, required IconData icon}) => InputDecoration(
      prefixIcon: Icon(icon),
      labelText: label,
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: neutralGray),
        borderRadius: BorderRadius.circular(20.0),
        gapPadding: 20
      ),
    );
