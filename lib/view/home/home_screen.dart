import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quotes_api_app/helper/api_helper.dart';
import 'package:quotes_api_app/models/quotes_model.dart';
import 'package:quotes_api_app/provider/quotes_provider.dart';
import 'package:quotes_api_app/view/widgets/custom_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    QuotesProvider quotesProvider = Provider.of<QuotesProvider>(context);
    quotesProvider.getData();
    quotesProvider.loadFavorites();
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.pinkAccent.shade200.withOpacity(0.7),
            Colors.deepPurple.shade300.withOpacity(0.9),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.white.withOpacity(0.2),
        appBar: AppBar(
          backgroundColor: Colors.amberAccent.withOpacity(0.1),
          title: const Text(
            "Quotes API",
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
          centerTitle: true,
        ),
        drawer: const CustomDrawer(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
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
                                                  if (quotesProvider
                                                      .isFavorite(e.id)) {
                                                    quotesProvider
                                                        .removeFromFavorites(
                                                            e.id);
                                                  } else {
                                                    quotesProvider
                                                        .addToFavorites(e.id);
                                                  }
                                                },
                                                child: Icon(
                                                  quotesProvider
                                                          .isFavorite(e.id)
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
