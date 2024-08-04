import 'package:flutter/material.dart';

class AppUtil {
  static List<DropdownMenuItem<String>> createDropdownList(
      {required Map<String, String> data}) {
    return data.entries
        .map(
          (entry) => DropdownMenuItem<String>(
            value: entry.key,
            child: Text(
              entry.value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        )
        .toList();
  }

  static List<DropdownMenuItem<int>> createDropdownDetailList(
      {required Map<int, String> data}) {
    return data.entries
        .map(
          (entry) => DropdownMenuItem<int>(
            value: entry.key,
            child: Text(
              entry.value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        )
        .toList();
  }
}
