import 'package:flutter/material.dart';
import 'package:marvel_lati/helper/const.dart';
import 'package:marvel_lati/providers/movie_provider.dart';
import 'package:marvel_lati/widgets/moive_card.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Consumer<MovieProvider>(builder: (context, movieConsumer, child) {
      return SafeArea(
        child: Scaffold(
          drawer: Drawer(),
          appBar: AppBar(
            actions: [
              SizedBox(
                width: 16,
              ),
              IconApp(
                icon: "assets/icons/favoriteButton.png",
                function: () {},
              ),
              SizedBox(
                width: 8,
              ),
              IconApp(
                icon: "assets/icons/inboxIcon.png",
                function: () {},
              ),
            ],
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Image.asset(
              "assets/image.png",
              width: size.width * 0.2,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Column(
              children: [
                Expanded(
                  child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8),
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: movieConsumer.movies.length,
                      itemBuilder: (context, index) {
                        return MovieCard(movie: movieConsumer.movies[index]);
                      }),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class IconApp extends StatelessWidget {
  const IconApp({super.key, required this.icon, required this.function});
  final String icon;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: red.withOpacity(0.10)),
          ),
          child: IconButton(
            onPressed: () {
              function();
            },
            icon: Image.asset(
              icon,
              width: 24,
              height: 24,
            ),
          ),
        ),
      ],
    );
  }
}
