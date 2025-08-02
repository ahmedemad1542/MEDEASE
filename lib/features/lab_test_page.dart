/*import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class LabTestsPage extends StatefulWidget {
  const LabTestsPage({super.key});

  @override
  LabTestsPageState createState() => LabTestsPageState();
}

class LabTestsPageState extends State<LabTestsPage> {
  Map<String, dynamic>? labTests;

  @override
  void initState() {
    super.initState();
    _loadLabTests();
  }

  Future<void> _loadLabTests() async {
    String jsonString = await rootBundle.loadString('assets/tests.json');
    setState(() {
      labTests = json.decode(jsonString)['lab_tests'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("تحليل نتائج التحاليل")),
      body:
          labTests == null
              ? Center(child: CircularProgressIndicator())
              : ListView(
                padding: EdgeInsets.all(16),
                children:
                    labTests!.entries.map((entry) {
                      return Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ExpansionTile(
                          leading: Icon(Icons.analytics, color: Colors.blue),
                          title: Text(
                            entry.key,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          children:
                              (entry.value is List)
                                  ? (entry.value as List).map<Widget>((test) {
                                    if (test is Map<String, dynamic>) {
                                      return ListTile(
                                        title: Text(
                                          test['name'] ?? 'اسم غير متوفر',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 5),
                                            Text(
                                              "🔹 القيمة الطبيعية: ${test['normal_range'] ?? 'غير متوفر'}",
                                            ),
                                            SizedBox(height: 5),
                                            if (test.containsKey('low_causes'))
                                              Text(
                                                "🩸 مستوى منخفض: ${test['low_causes'].join(', ')}",
                                              ),
                                            if (test.containsKey('high_causes'))
                                              Text(
                                                "🩸 مستوى مرتفع: ${test['high_causes'].join(', ')}",
                                              ),
                                          ],
                                        ),
                                      );
                                    } else {
                                      return ListTile(
                                        title: Text(
                                          'بيانات غير صالحة',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      );
                                    }
                                  }).toList()
                                  : [],
                        ),
                      );
                    }).toList(),
              ),
    );
  }
}
*/