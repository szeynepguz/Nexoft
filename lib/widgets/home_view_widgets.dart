import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nexoft/controller/user_controller.dart';

class BottomBarWidget extends StatelessWidget {
  final int currentIndex;
  final PageController pageController;
  const BottomBarWidget({super.key,required this.currentIndex, required this.pageController,});

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
                 pageController.animateToPage(
                    0, 
                    duration: const Duration(milliseconds: 300), 
                    curve: Curves.easeInOut,
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(Icons.people, color: primaryColor, size: 30),
                      const SizedBox(width: 8),
                      const Text(
                        "kullanicilar",
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {
                  pageController.animateToPage(
                    1, 
                    duration: const Duration(milliseconds: 300), 
                    curve: Curves.easeInOut,
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
  static const Color primaryLight = Color(0xFFFF9433);
  static const Color primaryDark = Color(0xFFDB5C05);

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
                final isFavorite = controller.isUserFavorite(user);

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: primaryLight,
                      borderRadius: BorderRadiusDirectional.circular(16),
                    ),
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.network(
                          user.image ?? "",
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    user.firstName ?? "",
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: primaryDark,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    user.lastName ?? "",
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: primaryDark,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    user.age?.toString() ?? "",
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: primaryDark,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Text(
                                user.address?.city ?? "",
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: primaryDark,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(16),
                            onTap: () {
                              context.read<UserController>().updateFavorite(
                                user,
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: isFavorite ? Colors.red : Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class KullanicilarSayfasi extends StatelessWidget {
  const KullanicilarSayfasi({super.key});

  static const Color primaryLight = Color(0xFFFF9433);
  static const Color primaryDark = Color(0xFFDB5C05);

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<UserController>();
    final userList = controller.users;

    return Scaffold(
      appBar: AppBar(title: Text('Kullanicilar (${userList.length})')),
      body: userList.isEmpty
          ? const Center(child: Text('Kullanici bulunamadı'))
          : ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: userList.length,
              itemBuilder: (context, index) {
                final user = userList[index];
                final isFavorite = controller.isUserFavorite(user);

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),

                  child: Container(
                    decoration: BoxDecoration(
                      color: primaryLight,
                      borderRadius: BorderRadiusDirectional.circular(16),
                    ),
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.network(
                          user.image ?? "",
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(width: 12),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    user.firstName ?? "",
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: primaryDark,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    user.lastName ?? "",
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: primaryDark,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    user.age?.toString() ?? "",
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: primaryDark,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Text(
                                user.address?.city ?? "",
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: primaryDark,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(16),
                            onTap: () {
                              context.read<UserController>().updateFavorite(
                                user,
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: isFavorite ? Colors.red : Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
