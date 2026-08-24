import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nexoft/controller/user_controller.dart';

class Favoriler extends StatelessWidget {
  const Favoriler({super.key});
  static const Color primaryLight = Color(0xFFFF9433);
  static const Color primaryDark = Color(0xFFDB5C05);

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<UserController>();
    final favoriteList = controller.favoriteUsers;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favoriler Kişi Sayisi (${favoriteList.length})',
          style: const TextStyle(color: primaryLight),
        ),
        centerTitle: true,
      ),
      body: favoriteList.isEmpty
          ? const Center(child: Text('kullanici bulunamadi'))
          : ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: favoriteList.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: ValueKey(favoriteList[index]),
                  direction: DismissDirection.endToStart,
                  background: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(right: 20),
                      child: const Icon(
                        Icons.delete,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                  onDismissed: (direction) {
                    context.read<UserController>().updateFavorite(
                      favoriteList[index],
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                            favoriteList[index].image ?? "",
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
                                      favoriteList[index].firstName ?? "",
                                      style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: primaryDark,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      favoriteList[index].lastName ?? "",
                                      style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: primaryDark,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      favoriteList[index].age?.toString() ?? "",
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
                                  favoriteList[index].address?.city ?? "",
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
                                  favoriteList[index],
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  favoriteList.contains(favoriteList[index])
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color:
                                      favoriteList.contains(favoriteList[index])
                                      ? Colors.red
                                      : Colors.white,
                                  size: 30,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
