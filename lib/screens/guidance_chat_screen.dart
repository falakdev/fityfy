import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GuidanceChatScreen extends StatefulWidget {
  const GuidanceChatScreen({Key? key}) : super(key: key);

  @override
  State<GuidanceChatScreen> createState() => _GuidanceChatScreenState();
}

class _GuidanceChatScreenState extends State<GuidanceChatScreen> {
  final List<_Message> _messages = [];
  final TextEditingController _controller = TextEditingController();
  bool _loading = false;

  Future<void> _sendMessage(String text) async {
    if (text.trim().isEmpty) return;
    setState(() {
      _messages.insert(0, _Message(text, true));
      _loading = true;
    });
    _controller.clear();
    final reply = await _askGemini(text);
    setState(() {
      _messages.insert(0, _Message(reply, false));
      _loading = false;
    });
  }

  Future<String> _askGemini(String question) async {
    const apiUrl =
        'https://cheapest-gpt-4-turbo-gpt-4-vision-chatgpt-openai-ai-api.p.rapidapi.com/v1/chat/completions';
    const apiKey = 'aadb8eedf8mshd1847b4a4ad6cb8p1c5821jsn70fb18c88f31';
    const apiHost =
        'cheapest-gpt-4-turbo-gpt-4-vision-chatgpt-openai-ai-api.p.rapidapi.com';
    final body = jsonEncode({
      "messages": [
        {"role": "user", "content": question},
      ],
      "model": "gpt-4o",
      "max_tokens": 100,
      "temperature": 0.9,
    });
    try {
      final res = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'x-rapidapi-host': apiHost,
          'x-rapidapi-key': apiKey,
        },
        body: body,
      );
      print('Status: \\${res.statusCode}');
      print('Body: \\${res.body}');
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        return data['choices']?[0]?['message']?['content']?.toString() ??
            "Sorry, I couldn't understand that.";
      } else {
        return "Sorry, there was an error connecting to the AI.";
      }
    } catch (e) {
      return "Sorry, something went wrong.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fitness Guidance"),
        backgroundColor: Colors.green[700],
      ),
      body: Container(
        color: Colors.green[50],
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                reverse: true,
                padding: const EdgeInsets.all(16),
                itemCount: _messages.length,
                itemBuilder: (context, i) {
                  final m = _messages[i];
                  return Align(
                    alignment: m.isUser
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: m.isUser ? Colors.green[200] : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 2,
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Text(m.text, style: TextStyle(fontSize: 16)),
                    ),
                  );
                },
              ),
            ),
            if (_loading)
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: "Ask about fitness, diet, exercise...",
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      onSubmitted: _sendMessage,
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.send, color: Colors.green),
                    onPressed: _loading
                        ? null
                        : () => _sendMessage(_controller.text),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Message {
  final String text;
  final bool isUser;
  _Message(this.text, this.isUser);
}
