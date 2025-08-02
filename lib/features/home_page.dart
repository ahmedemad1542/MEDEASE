import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medease1/features/calculators/calculators_page.dart';
import 'package:medease1/core/utils/service_locator.dart';
import 'package:medease1/features/advertisements/getAdvertisement/advertisement_screen.dart';
import 'package:medease1/features/advertisements/getAdvertisement/cubit/advertisements_cubit.dart';
import 'package:medease1/features/advices/advices_screen.dart';
import 'package:medease1/features/advices/cubit/advices_cubit.dart';
import 'package:medease1/features/profile/profile_screen.dart';
import 'disease/diseases_page.dart';
import 'home_main_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  late List<Widget> _pages; // خليها late

  @override
  void initState() {
    super.initState();
    _pages = [
      MedEaseHomeScreen(),
      BlocProvider(
        create: (context) => sl<AdviceCubit>(),
        child: AdviceScreen(),
      ),
      BlocProvider(
        create: (context) => sl<AdvertisementsCubit>()..getAdvertisements(),
        child: AdvertisementScreen(),
      ),
      DiseasesPage(),
      ProfileScreen(), // هنا تبعت التوكن صح
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<bool> _onWillPop() async {
    return await showDialog(
          context: context,
          builder:
              (context) => AlertDialog(
                title: Text("تأكيد الخروج"),
                content: Text("هل أنت متأكد أنك تريد الخروج من التطبيق؟"),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text("إلغاء"),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: Text("نعم"),
                  ),
                ],
              ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
              icon: Icon(Icons.medical_information_rounded),
              label: "Advices",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.public),
              label: "Advertisements",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_hospital),
              label: "Diseases",
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ],
        ),
      ),
    );
  }
}
