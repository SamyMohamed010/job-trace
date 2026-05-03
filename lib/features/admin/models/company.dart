import 'package:flutter/material.dart';

class Company {
  final String name;
  final String email;
  final Color brandColor;
  final String logoUrl;
  final String location;
  bool isApproved;

  Company({
    required this.name,
    required this.email,
    required this.brandColor,
    required this.logoUrl,
    required this.location,
    this.isApproved = false,
  });
}
