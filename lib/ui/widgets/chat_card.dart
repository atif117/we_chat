import 'package:chat_app/core/models/app_user.dart';
import 'package:chat_app/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatCard extends StatefulWidget {
  ChatCard({super.key, required this.user});
  AppUser user;

  @override
  State<ChatCard> createState() => _ChatCardState();
}

class _ChatCardState extends State<ChatCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: mq.width * 0.04, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 0.5,
      child: InkWell(
        onTap: () {},
        child: ListTile(
          leading: CircleAvatar(
              backgroundImage: widget.user.profilePhoto != null
                  ? NetworkImage(widget.user.profilePhoto!)
                  : null,
              child: widget.user.profilePhoto != null
                  ? Container()
                  : const Icon(CupertinoIcons.person)),
          title: Text("${widget.user.name}"),
          subtitle: Text(
            "${widget.user.about}",
            maxLines: 1,
          ),
          trailing: const Text(
            "12:00 pm",
            style: TextStyle(color: Colors.black54),
          ),
        ),
      ),
    );
  }
}
