import 'package:flutter/material.dart';
import 'package:su_chat_hakan/screens/adminScreens/usersRequest_page.dart';
import 'package:su_chat_hakan/screens/adminScreens/users_page.dart';

import '../../components/constants.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, initialIndex: 0, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: kPrimaryColor,
        child: SafeArea(
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                const SliverAppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: kPrimaryColor,
                  floating: true,
                  title: Center(child: Text('Yönetim Paneli')),
                )
              ];
            },
            body: Column(
              children: [
                TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  tabs: const [
                    Tab(text: 'KULLANICI İSTEKLERİ'),
                    Tab(text: 'KULLANICILAR'),
                  ],
                ),
                Expanded(
                  child: Container(
                    color: Colors.black,
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        UsersPageRequest(),
                        UsersPage(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
