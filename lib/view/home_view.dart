import 'package:flutter/material.dart';
import 'package:nexoft/controller/user_controller.dart';
import 'package:nexoft/widgets/home_view_widgets.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
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
            if (provider.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: provider.users.length,
              itemBuilder: (context, index) {
                final user = provider.users[index];

                return PostWidget(
                  firstName: user.firstName ?? "",
                  lastName: user.lastName ?? "",
                  age: user.age?.toString() ?? "",
                  address: user.address?.city ?? "",
                  image: user.image ?? "",
                  user:user,
                );
              },
            );
          },
        ),
      ),
      bottomNavigationBar: const BottomBarWidget(),
    );
  }
}