import 'package:flutter/material.dart';
import 'package:quotes_api_app/helper/api_helper.dart';
import 'package:quotes_api_app/models/quotes_model.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

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
            "Favorite",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
          centerTitle: true,
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
                            children: favoriteQuotes
                                .map(
                                  (e) => Text(e),
                                )
                                .toList(),
                            // data
                            //     .map(
                            //       (e) => (favoriteQuotes == e.id)
                            //           ? Card(
                            //               elevation: 10,
                            //               shadowColor: Colors.indigoAccent,
                            //               child: Container(
                            //                 padding: const EdgeInsets.all(8),
                            //                 decoration: BoxDecoration(
                            //                   borderRadius:
                            //                       BorderRadius.circular(25),
                            //                 ),
                            //                 alignment: Alignment.bottomCenter,
                            //                 child: Column(
                            //                   mainAxisSize: MainAxisSize.min,
                            //                   mainAxisAlignment:
                            //                       MainAxisAlignment.spaceBetween,
                            //                   children: [
                            //                     Text(
                            //                       e.author,
                            //                       style: const TextStyle(
                            //                           fontSize: 20,
                            //                           fontWeight:
                            //                               FontWeight.bold),
                            //                     ),
                            //                     const Spacer(),
                            //                     Text(
                            //                       e.content,
                            //                       textAlign: TextAlign.center,
                            //                       style: const TextStyle(
                            //                           fontSize: 17),
                            //                     ),
                            //                     const Spacer(),
                            //                     Row(
                            //                       mainAxisAlignment:
                            //                           MainAxisAlignment
                            //                               .spaceBetween,
                            //                       children: [
                            //                         Text(
                            //                           e.authorSlug,
                            //                           style: const TextStyle(
                            //                               fontSize: 18,
                            //                               fontWeight:
                            //                                   FontWeight.w100),
                            //                         ),
                            //                         const Spacer(),
                            //                       ],
                            //                     ),
                            //                   ],
                            //                 ),
                            //               ),
                            //             )
                            //           : Container(),
                            //     )
                            //     .toList(),
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
