import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simbiotik_getx_app/presentation/controllers/auth_controllers.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    return Drawer(
      child: Column(
        children: [
          Obx(() {
            final user = authController.user;
            return UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              currentAccountPicture: Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: user?.photoUrl != null
                      ? NetworkImage(user!.photoUrl!)
                      : null,
                  child: user?.photoUrl == null
                      ? Text(
                    user?.displayName?.substring(0, 1).toUpperCase() ?? 'U',
                    style: TextStyle(
                      fontSize: 40,
                      color: Theme.of(context).primaryColor,
                    ),
                  )
                      : null,
                ),
              ),
              accountName: Text(
                user?.displayName ?? 'No Name',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              accountEmail: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user?.email ?? 'No Email'),
                  const SizedBox(height: 4),
                  Text(
                    'UID: ${user?.uid ?? 'N/A'}',
                    style: const TextStyle(fontSize: 11),
                  ),
                ],
              ),
            );
          }),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Get.back();
            },
          ),
          const Divider(),
          const Spacer(),
          Obx(() => ListTile(
            leading: authController.isLoading
                ? const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
                : const Icon(Icons.logout, color: Colors.red),
            title: const Text(
              'Logout',
              style: TextStyle(color: Colors.red),
            ),
            onTap: authController.isLoading
                ? null
                : () {
              Get.back();
              authController.signOut();
            },
          )),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}