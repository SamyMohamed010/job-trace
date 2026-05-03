import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'app_localization.dart';
import 'features/company/screens/company_register_screen.dart';
import 'features/company/screens/company_register_step2_screen.dart';
import 'features/company/screens/company_register_step3_screen.dart';
import 'features/company/screens/company_approval_screen.dart';
import 'features/company/screens/company_main_screen.dart';

import 'features/student/screens/splash_screen.dart';
import 'features/student/screens/login_screen.dart';
import 'features/student/screens/student_register.dart';
import 'features/student/screens/home_screen.dart';
import 'features/student/screens/profile_screen.dart';
import 'features/student/screens/applications_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: appLocalization,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          locale: appLocalization.locale,
          supportedLocales: const [
            Locale('en'),
            Locale('ar'),
          ],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          // البداية من شاشة السبلاش
          initialRoute: '/splash',
          
          routes: {
            '/splash': (context) => const SplashScreen(),
            '/login': (context) => const LoginScreen(),
            '/student_register': (context) => const StudentRegisterScreen(),
            '/student_home': (context) => const HomeScreen(userName: 'Student'),
            '/student_profile': (context) => const ProfileScreen(),
            '/student_applications': (context) => const ApplicationsScreen(),
            
            '/company_register_step1': (context) => const CompanyRegisterScreen(),
            '/company_register_step2': (context) => const CompanyRegisterStep2Screen(),
            '/company_register_step3': (context) => const CompanyRegisterStep3Screen(),
            '/company_approval': (context) => const CompanyApprovalScreen(),
            '/company_main': (context) => const CompanyMainScreen(),
          },
        );
      }
    );
  }
}
