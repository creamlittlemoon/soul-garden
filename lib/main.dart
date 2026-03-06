import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'providers/garden_provider.dart';
import 'providers/user_provider.dart';
import 'screens/opening_screen.dart';
import 'screens/garden_screen.dart';
import 'screens/explore_screen.dart';
import 'screens/profile_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.transparent,
  ));
  runApp(const SoulGardenApp());
}

class SoulGardenApp extends StatelessWidget {
  const SoulGardenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => GardenProvider()),
      ],
      child: MaterialApp(
        title: 'Soul Garden',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: const Color(0xFF1A1A2E),
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF7B68EE),
            brightness: Brightness.dark,
            primary: const Color(0xFF9B8FD4),
            secondary: const Color(0xFFE8D5B7),
            surface: const Color(0xFF16213E),
          ),
        ),
        home: const OpeningScreen(),
      ),
    );
  }
}
