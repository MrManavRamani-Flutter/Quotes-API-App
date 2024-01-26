import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quotes_api_app/helper/api_helper.dart';
import 'package:quotes_api_app/models/quotes_model.dart';
import 'package:quotes_api_app/provider/quotes_provider.dart';
import 'package:quotes_api_app/view/widgets/favorite_quotes_grid.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    QuotesProvider quotesProvider = Provider.of<QuotesProvider>(context);

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
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed("/");
            },
            icon: const Icon(
              Icons.home_outlined,
              color: Colors.white,
            ),
          ),
          title: const Text(
            "Favorite",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
          centerTitle: true,
        ),
        body: Container(
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
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  flex: 10,
                  child: FavoriteQuotesGrid(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
