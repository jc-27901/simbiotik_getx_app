import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simbiotik_getx_app/presentation/controllers/auth_controllers.dart';
import 'package:simbiotik_getx_app/presentation/widgets/app_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        elevation: 2,
      ),
      drawer: const AppDrawer(),
      body: Center(
        child: Obx(() {
          final user = authController.user;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (user?.photoUrl != null)
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(user!.photoUrl!),
                ),
              const SizedBox(height: 24),
              Text(
                'Welcome, ${user?.displayName ?? 'User'}!',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                user?.email ?? '',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                'Open the drawer to view your details',
                style: TextStyle(fontSize: 14),
              ),
            ],
          );
        }),
      ),
    );
  }
}