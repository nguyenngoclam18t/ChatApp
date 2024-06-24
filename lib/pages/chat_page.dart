import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/services/chat/chat_service.dart';
import 'package:chat_app/themes/theme_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatelessWidget {
  final String recivedEmail;
  final String recivedId;
  ChatPage({super.key, required this.recivedEmail, required this.recivedId});
  final _messController = TextEditingController();
  final _chatService = ChatService();
  final _authService = AuthService();
  void sendMessage() async {
    if (_messController.text.isNotEmpty) {
      await _chatService.sendMessage(recivedId, _messController.text);
      _messController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recivedEmail),
      ),
      body: Column(
        children: <Widget>[
          Container(
              child: Expanded(
                  child: Container(
                      margin: EdgeInsets.only(top: 15),
                      child: _buildMessList()))),
          _buildUserInput(context)
        ],
      ),
    );
  }

  Widget _buildMessList() {
    String _senderId = FirebaseAuth.instance.currentUser!.uid;
    return StreamBuilder(
      stream: _chatService.getMessages(_senderId, recivedId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text("lỗi load tin nhắn"),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Text("Loading"),
          );
        }
        return ListView(
          children: snapshot.data!.docs
              .map((doc) => _buildMessTile(context, doc))
              .toList(),
        );
      },
    );
  }

  Widget _buildMessTile(BuildContext context, DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    bool isCurrentUser =
        data["senderID"] == FirebaseAuth.instance.currentUser!.uid;
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode();
    return Row(
      mainAxisAlignment:
          isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
            padding: isCurrentUser
                ? EdgeInsets.only(top: 12, left: 15, bottom: 12, right: 12)
                : EdgeInsets.only(top: 12, left: 12, bottom: 12, right: 15),
            margin: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: isCurrentUser
                  ? Colors.green
                  : isDarkMode
                      ? Colors.white30
                      : Colors.grey.shade400,
            ),
            child: Text(data["message"])),
      ],
    );
  }

  Widget _buildUserInput(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode();

    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
            padding: EdgeInsets.all(20),
            child: TextField(
              style: TextStyle(color: Colors.black),
              obscureText: false,
              controller: _messController,
              decoration: InputDecoration(
                hintText: "type the text...",
                hintStyle: TextStyle(color: Colors.grey),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Theme.of(context).colorScheme.primary),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.secondary),
                ),
                fillColor: Colors.white,
                filled: true,
              ),
            ),
          ),
        ),
        Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.green,
            ),
            child: IconButton(
                onPressed: sendMessage,
                icon: Icon(
                  Icons.arrow_upward,
                  color: Colors.white,
                )))
      ],
    );
  }
}
