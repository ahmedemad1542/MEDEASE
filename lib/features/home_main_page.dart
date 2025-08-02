import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medease1/core/routing/app_routes.dart';
import 'package:medease1/core/storage/storage_helper.dart';
import 'package:medease1/core/storage/storage_keys.dart';
import 'package:medease1/core/utils/role_service.dart';
import 'package:medease1/features/Diagnosis/diagnosis_screen.dart';
import 'package:medease1/features/calculators/BMI/gender_screen.dart';
import 'package:medease1/features/calculators/calculators_page.dart';
import 'package:medease1/widgets/feature_card.dart';

import '../core/utils/service_locator.dart';
import 'realChat/conversation/conversation_screen.dart';

class MedEaseHomeScreen extends StatelessWidget {
  const MedEaseHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // list of featurecard based on role
    final List<Widget> featureCards = [
      FeatureCard(
        icon: Icons.local_hospital,
        label: 'الأطباء',
        onTap: () {
          context.pushNamed(AppRoutes.doctorsScreen);
        },
      ),
      if (sl<RoleService>().isDoctor || sl<RoleService>().isAdmin)
        FeatureCard(
          icon: Icons.shield,
          label: 'المرضي',
          onTap: () {
            context.pushNamed(AppRoutes.patientScreen);
          },
        ),
      FeatureCard(
        icon: Icons.calendar_month,
        label: 'المواعيد',
        onTap: () {
          context.pushNamed(AppRoutes.appointmentScreen);
        },
      ),
      if (sl<RoleService>().isDoctor || sl<RoleService>().isAdmin)
        FeatureCard(
          icon: Icons.home_repair_service_rounded,
          label: 'التشخيصات',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const DiagnosisScreen()),
            );
          },
        ),
      FeatureCard(
        icon: Icons.calculate,
        label: 'حاسبة',
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CalculatorsPage()),
          );
        },
      ),
      if (sl<RoleService>().isPatient)
        FeatureCard(
          icon: Icons.chat,
          label: 'Chatbot',
          onTap: () {
            context.pushNamed(AppRoutes.chatBotScreen);
          },
        ),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('MedEase', style: TextStyle(color: Colors.white)),
        actions: [
          Visibility(
            visible: sl<RoleService>().isDoctor || sl<RoleService>().isAdmin,
            child: IconButton(
              icon: const Icon(Icons.chat),
              onPressed: () async {
                final String id =
                    (await sl<StorageHelper>().getData(
                      key: StorageKeys.userId,
                    ))!;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => ConversationListScreen(currentUserId: id),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'MedEase! مرحبًا بك',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'إنشاء تجربة طبية أفضل من خلال الخدمات التي نقدمها',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
              ),
              itemCount: featureCards.length,
              itemBuilder: (context, index) {
                return featureCards[index];
              },
            ),
          ),
        ],
      ),
    );
  }
}
