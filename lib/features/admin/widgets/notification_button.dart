import 'package:flutter/material.dart';

class CustomNotificationButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const CustomNotificationButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.notifications_none_outlined, // الشكل اللي في الصورة
        color: Colors.orange, // اللون الدهبي الموحد
        size: 28,
      ),
      onPressed:
          onPressed ??
          () {
            // الأكشن الافتراضي لو نسينا نبعت أكشن
            debugPrint("Notification clicked");
          },
    );
  }
}
