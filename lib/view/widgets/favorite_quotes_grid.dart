import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quotes_api_app/helper/api_helper.dart';
import 'package:quotes_api_app/models/quotes_model.dart';
import 'package:quotes_api_app/provider/quotes_provider.dart';

class FavoriteQuotesGrid extends StatelessWidget {
  const FavoriteQuotesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    QuotesProvider quotesProvider = Provider.of<QuotesProvider>(context);

    return FutureBuilder(
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
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    mainAxisSpacing: 2,
                    crossAxisSpacing: 1,
                    childAspectRatio: 5 / 2.5),
                children: data
                    .where((quote) =>
                        quotesProvider.favoriteQuotes.contains(quote.id))
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                e.author,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              const Spacer(),
                              Text(
                                e.content,
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 17),
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
                                        fontWeight: FontWeight.w100),
                                  ),
                                  const Spacer(),
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
    );
  }
}
