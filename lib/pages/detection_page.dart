// detection_page.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/history_model.dart';

class DetectionPage extends StatelessWidget {
  const DetectionPage({super.key});

  Future<void> _simulateDetection(BuildContext context) async {
    // 模拟检测逻辑
    final random = DateTime.now().second % 2;
    final result = random == 0 ? '健康' : '黄龙病感染';
    final confidence = (random == 0 ? 85.0 : 92.5);

    // 保存历史记录
    final prefs = await SharedPreferences.getInstance();
    final history = HistoryRecord(
      date: DateTime.now().toString(),
      summary: '检测结果: $result (置信度: $confidence%)',
      details: '''完整检测报告：
      病变类型: $result
      置信度: $confidence%
      建议处理方案: ${result == '健康' ? 
        '定期观察即可' : 
        '立即隔离病株并喷洒专用药剂'}''',
    );

    final historyList = prefs.getStringList('detection_history') ?? [];
    historyList.add('${history.date}|${history.summary}|${history.details}');
    await prefs.setStringList('detection_history', historyList);

    // 显示结果
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('检测完成'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('结果: $result', 
                style: TextStyle(
                    color: result == '健康' ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold)),
            Text('置信度: $confidence%'),
            const SizedBox(height: 16),
            Text(result == '健康' 
                ? '建议：定期观察即可'
                : '建议：立即采取防治措施'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('确定'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('病害检测')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.camera_alt, size: 80, color: Colors.blue),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.search),
              label: const Text('模拟检测'),
              onPressed: () => _simulateDetection(context),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              '点击按钮进行模拟检测',
              style: TextStyle(color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }
}