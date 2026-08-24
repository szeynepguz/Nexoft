import 'package:flutter/material.dart';
import 'package:nexoft/controller/user_controller.dart';
import 'package:nexoft/view/favoriler_view.dart';
import 'package:nexoft/view/kullanicilarSayfasi_view.dart';
import 'package:nexoft/widgets/home_view_widgets.dart';
import 'package:provider/provider.dart';



class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  late PageController _pageController;
  @override
  void initState() {
    _pageController = PageController(initialPage: _currentIndex);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final provider = Provider.of<UserController>(context, listen: false);
      await provider.getUserData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<UserController>(
          builder: (context, provider, _) {
            return PageView(
              controller: _pageController,

              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              children: const [KullanicilarSayfasi(), Favoriler()],
            );
          },
        ),
      ),
      bottomNavigationBar: BottomBarWidget(
        currentIndex: _currentIndex,
        pageController: _pageController,
      ),
    );
  }
}
