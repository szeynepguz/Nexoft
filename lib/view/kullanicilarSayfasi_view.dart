import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nexoft/controller/user_controller.dart';


class KullanicilarSayfasi extends StatelessWidget {
  const KullanicilarSayfasi({super.key});

  static const Color primaryLight = Color(0xFFFF9433);
  static const Color primaryDark = Color(0xFFDB5C05);

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<UserController>();
    final favoriteUsers = context.watch<UserController>().favoriteUsers;
    final userList = controller.users;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Kullanicilar (${userList.length})',
          style: const TextStyle(color: primaryLight),
        ),
        centerTitle: true,
      ),
      body: userList.isEmpty
          ? const Center(child: Text('Kullanici bulunamadı'))
          : ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: userList.length,
              itemBuilder: (context, index) {
                

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
                          controller.users[index].image ?? "",
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
                                    controller.users[index].firstName ?? "",
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: primaryDark,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    controller.users[index].lastName ?? "",
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: primaryDark,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    controller.users[index].age?.toString() ??
                                        "",
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
                                controller.users[index].address?.city ?? "",
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
                        InkWell(
                          borderRadius: BorderRadius.circular(16),
                          onTap: () {
                            context.read<UserController>().updateFavorite(
                              controller.users[index],
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              favoriteUsers.contains( userList[index])
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: favoriteUsers.contains( userList[index])
                                  ? Colors.red
                                  : Colors.white,
                              size: 30,
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
