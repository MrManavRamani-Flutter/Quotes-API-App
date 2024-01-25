import 'package:flutter/material.dart';
import 'package:quotes_api_app/helper/api_helper.dart';
import 'package:quotes_api_app/models/quotes_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

const Color inActiveIconColor = Color(0xFFB6B6B6);

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    getData();
    loadFavorites();
  }

  getData() async {
    await APIHelper.apiHelper.fetchedQuote().then((value) {
      setState(() {});
    });
  }

  Future<void> loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      favoriteQuotes = Set.from(prefs.getStringList('favorites') ?? []);
    });
  }

  Future<void> saveFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('favorites', favoriteQuotes.toList());
  }

  void addToFavorites(String quoteId) {
    setState(() {
      favoriteQuotes.add(quoteId);
    });
    saveFavorites();
  }

  void removeFromFavorites(String quoteId) {
    setState(() {
      favoriteQuotes.remove(quoteId);
    });
    saveFavorites();
  }

  bool isFavorite(String quoteId) {
    return favoriteQuotes.contains(quoteId);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.pinkAccent.shade200.withOpacity(0.7),
            Colors.deepPurple.shade300.withOpacity(0.8),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.white.withOpacity(0.8),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text(
            "Quotes API",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
          centerTitle: true,
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                accountName: const Text('Avtar Profile'),
                accountEmail: const Text(
                  '+91 70965 84269',
                  // style: TextStyle(color: Colors.grey),
                ),
                currentAccountPicture: CircleAvatar(
                  child: ClipOval(
                    child: Image.network(
                        'https://static.vecteezy.com/system/resources/previews/019/896/008/original/male-user-avatar-icon-in-flat-design-style-person-signs-illustration-png.png'),
                  ),
                ),
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                          'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg')),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pushNamed('like_screen');
                },
                leading: const Icon(Icons.favorite_border),
                title: const Text('Favorite'),
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Settings'),
                onTap: () {},
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // Text('$favoriteQuotes'),
              Expanded(
                flex: 10,
                child: FutureBuilder(
                  future: APIHelper.apiHelper.fetchedQuote(),
                  builder: (context, snapshot) {
                    List<Quote>? data;
                    (snapshot.hasError)
                        ? print(snapshot.error)
                        : snapshot.hasData
                            ? data = snapshot.data
                            : const CircularProgressIndicator();

                    return (data == null)
                        ? Container()
                        : GridView(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1,
                                    mainAxisSpacing: 2,
                                    crossAxisSpacing: 1,
                                    childAspectRatio: 5 / 2.5),
                            children: data
                                .map(
                                  (e) => Card(
                                    elevation: 10,
                                    shadowColor: Colors.indigoAccent,
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      alignment: Alignment.bottomCenter,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            e.author,
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const Spacer(),
                                          Text(
                                            e.content,
                                            textAlign: TextAlign.center,
                                            style:
                                                const TextStyle(fontSize: 17),
                                          ),
                                          const Spacer(),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                e.authorSlug,
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w100),
                                              ),
                                              FloatingActionButton(
                                                mini: true,
                                                onPressed: () {
                                                  if (isFavorite(e.id)) {
                                                    removeFromFavorites(e.id);
                                                  } else {
                                                    addToFavorites(e.id);
                                                  }
                                                },
                                                child: Icon(
                                                  isFavorite(e.id)
                                                      ? Icons.favorite
                                                      : Icons.favorite_outline,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
