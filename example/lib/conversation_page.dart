import 'package:flutter/material.dart';
import 'package:jmessage_flutter/jmessage_flutter.dart';
import 'package:jmessage_flutter_example/main.dart';

class PageConversation extends StatefulWidget {
  final JMConversationInfo conversation;

  const PageConversation({Key? key, required this.conversation})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _PageConversation(conversation);
}

class _PageConversation extends State<PageConversation> {
  final JMConversationInfo conversation;

  final List<String> list = [];

  _PageConversation(this.conversation);

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    await jmessage.enterConversation(target: conversation.target.targetType);
    jmessage.addReceiveMessageListener(_reciveMsg);
  }

  void _reciveMsg(dynamic msg) {
    print('收到信息 ${msg.toJson()}');
    setState(() {
      if (msg is JMTextMessage) list.add(msg.text);
    });
  }

  @override
  void dispose() {
    super.dispose();
    jmessage.removeReceiveMessageListener(_reciveMsg);
    // jmessage.exitConversation(target: conversation.target.targetType);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('会话')),
      body: ListView.builder(
        itemBuilder: (_, i) => Text(list[i]),
        itemCount: list.length,
      ),
    );
  }
}
