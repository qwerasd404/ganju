import 'package:flutter/material.dart';
import '../models/history_model.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<HistoryRecord> _history = [];

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  void _loadHistory() async {
    // 实现从shared_preferences加载历史记录
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('检测历史')),
      body: ListView.builder(
        itemCount: _history.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(_history[index].date),
          subtitle: Text(_history[index].summary),
          trailing: IconButton(
            icon: const Icon(Icons.info),
            onPressed: () => _showDetail(_history[index]),
          ),
        ),
      ),
    );
  }

  void _showDetail(HistoryRecord record) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('检测详情'),
        content: Text(record.details),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('关闭'),
          )
        ],
      ),
    );
  }
}