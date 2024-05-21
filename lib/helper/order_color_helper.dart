import 'package:flutter/material.dart';

class OrderColorHelper {
  static List<Map<String, Color>> orderStatusColor = [
    {
      'pending': Colors.orange,
    },
    {
      'confirmed': Colors.green,
    },
    {
      'processing': Colors.green,
    },
    {
      'out_for_delivery': Colors.green,
    },
    {
      'delivered': Colors.green,
    },
    {
      'failed': Colors.red,
    },
    {
      'canceled': Colors.red,
    },
    {
      'returned': Colors.red,
    }
  ];

  static Color getColorForStatus(String status) {
    for (var map in orderStatusColor) {
      if (map.containsKey(status)) {
        return map[status]!;
      }
    }
    return Colors.grey;
  }
}
