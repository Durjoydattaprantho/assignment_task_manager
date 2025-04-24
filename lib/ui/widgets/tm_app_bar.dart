import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:assignment_task_manager/ui/controllers/auth_controller.dart';

class TMAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TMAppBar({super.key, this.fromProfileScreen});

  final bool? fromProfileScreen;

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    return AppBar(
      backgroundColor: Colors.green,
      title: GestureDetector(
        onTap: () {
          if (fromProfileScreen ?? false) {
            // that means profile screen not true
            return;
          }
          _onTapProfileUpdate(context);
        },

        child: Row(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundImage:
              shouldShowImage(AuthController.userInfoModel?.photo)
                  ? MemoryImage(
                base64Decode(AuthController.userInfoModel?.photo ?? ''),
              )
                  : null,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    fullName(
                      firstName: AuthController.userInfoModel!.firstName,
                      lastName: AuthController.userInfoModel!.lastName,
                    ),
                    style: theme.bodyLarge?.copyWith(color: Colors.white),
                  ),
                  Text(
                    AuthController.userInfoModel!.email,
                    style: theme.bodySmall?.copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),

            IconButton(
              onPressed: () {
                _onTapLogOut(context);
              },
              icon: Icon(Icons.logout),
            ),
          ],
        ),
      ),
    );
  }

  _onTapLogOut(context) async {
    await AuthController.clearUserData();
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  void _onTapProfileUpdate(BuildContext context) {
    Navigator.pushNamed(context, '/UpdateProfileScreen');
  }

  fullName({required String firstName, required String lastName}) {
    return '$firstName $lastName';
  }

  bool shouldShowImage(String? photo) {
    return photo != null && photo.isNotEmpty;
  }
}
