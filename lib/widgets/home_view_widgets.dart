import 'package:flutter/material.dart';
import 'package:nexoft/model/user_model.dart';
import 'package:provider/provider.dart';
import 'package:nexoft/controller/user_controller.dart';

class BottomBarWidget extends StatelessWidget {
  const BottomBarWidget({super.key});

  static const Color primaryColor = Color(0xFFFF6F00);
  static const Color primaryLight = Color(0xFFFF9433);
  static const Color primaryDark = Color(0xFFDB5C05);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 80,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          children: [
            Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Favoriler()),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/icons/Heart.png',
                    width: 130,
                    height: 40,
                    color: primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Favoriler extends StatelessWidget {
  const Favoriler({super.key});

  @override
  Widget build(BuildContext context) {
    // controllerı dinleyerek güncel favori listesini alır
    //liste değiştikçe arayüzü otomatik olarak günceller
    final controller = context.watch<UserController>();
    final favoriteList = controller.favoriteUsers;

    return Scaffold(
      appBar: AppBar(
        title: Text('Favoriler Kişi Sayisi (${favoriteList.length})'),
      ),
      body: favoriteList.isEmpty
          ? const Center(child: Text('kullanici bulunamadi'))
          : ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: favoriteList.length,
              itemBuilder: (context, index) {
                //favoriler listesindeki index sırasındaki elemanı al ve user değişkenine kaydet
                final user = favoriteList[index];
                return PostWidget(
                  firstName: user.firstName ?? "",
                  lastName: user.lastName ?? "",
                  age: user.age?.toString() ?? "",
                  address: user.address?.city ?? "",
                  image: user.image ?? "",
                  user: user,
                );
              },
            ),
    );
  }
}

class PostWidget extends StatelessWidget {
  const PostWidget({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.address,
    required this.image,
    required this.user,
  });

  final String firstName;
  final String lastName;
  final String age;
  final String address;
  final String image;
  final UserModel user;

  static const Color primaryColor = Color(0xFFFF6F00);
  static const Color primaryLight = Color(0xFFFF9433);
  static const Color primaryDark = Color(0xFFDB5C05);

  @override
  Widget build(BuildContext context) {
    final isFavorite = context.watch<UserController>().isUserFavorite(user);
    return Container(
      decoration: BoxDecoration(
        color:primaryLight,
        borderRadius: BorderRadiusDirectional.circular(16),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.network(image, width: 100, height: 100, fit: BoxFit.cover),
            ],
          ),
          const SizedBox(height: 8),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    firstName,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: primaryDark,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    lastName,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: primaryDark,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    age,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: primaryDark,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 5),
              Text(
                address,
                style: const TextStyle(
                   fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: primaryDark,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {
                    context.read<UserController>().updateFavorite(user);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : Colors.grey,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
