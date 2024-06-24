import 'package:chat_app/components/my_drawer.dart';
import 'package:chat_app/components/user_tile.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/services/chat/chat_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final _chatService = ChatService();
  final _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      drawer: MyDrawer(),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatService.getUserStream(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Lỗi");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Load dữ liệu");
        }
        return ListView(
          children: snapshot.data!
              .where((userdata) =>
                  userdata["email"] != FirebaseAuth.instance.currentUser!.email)
              .map<Widget>((userdata) => _buildUserItem(userdata, context))
              .toList(),
        );
      },
    );
  }

  Widget _buildUserItem(Map<String, dynamic> userdata, BuildContext context) {
    return UserTile(
      text: userdata["email"],
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatPage(
              recivedEmail: userdata["email"],
              recivedId: userdata["uid"],
            ),
          ),
        );
      },
    );
  }
}
