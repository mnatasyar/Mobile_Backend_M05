import 'package:flutter/material.dart';
import 'package:flutter_m04/Http.Helper.dart';
import 'package:flutter_m04/detail.dart';
import 'package:flutter_m04/Movies.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HttpHelper? helper;
  List<Movie>? movies;
  final String iconBase = 'https://image.tmdb.org/t/p/w92/';
  final String defaultImage = 'https://images.freeimages.com/images/large-previews/5eb/movie-clapboard-1184339.jpg';
  
  TextEditingController searchController = TextEditingController();

  List<MovieCategory> categories = [
    MovieCategory('Latest', '/latest'),
    MovieCategory('Now Playing', '/now_playing'),
    MovieCategory('Popular', '/popular'),
    MovieCategory('Top Rated', '/top_rated'),
    MovieCategory('Upcoming', '/upcoming'),
  ];

  MovieCategory selectedCategory = MovieCategory('Now Playing', '/now_playing');

  Future initialize() async {
    movies = await helper?.getMovies(selectedCategory.apiEndpoint);
    setState(() {
      movies = movies;
    });
    if (searchController.text.isNotEmpty) {
      onSearchTextChanged(searchController.text);
    }
  }

  void onSearchTextChanged(String text) {
    setState(() {
      movies = movies?.where((movie) {
        return movie.title.toLowerCase().contains(text.toLowerCase());
      }).toList();
    });
  }

  @override
  void initState() {
    helper = HttpHelper();
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    NetworkImage image;

    return Scaffold(
      appBar: AppBar(
        title: Text('Movies'),
        actions: <Widget>[
          // Tambahkan IconButton untuk membersihkan teks pencarian di sini
          IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              setState(() {
                searchController.clear();
                initialize();
              });
            },
          ),
          // Tambahkan SearchBar di sini
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: TextField(
                controller: searchController,
                onChanged: onSearchTextChanged,
                decoration: InputDecoration(
                  hintText: 'Search Movies',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Wrap(
            children: categories.map((category) {
              return ChoiceChip(
                label: Text(category.name),
                selected: selectedCategory == category,
                onSelected: (selected) {
                  setState(() {
                    selectedCategory = category;
                  });
                  initialize();
                },
              );
            }).toList(),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: (movies?.length == null) ? 0 : movies!.length,
              itemBuilder: (BuildContext context, int position) {
                if (movies![position].posterPath != null) {
                  image = NetworkImage(iconBase + movies![position].posterPath);
                } else {
                  image = NetworkImage(defaultImage);
                }
                return Card(
                  color: Colors.white,
                  elevation: 2.0,
                  child: ListTile(
                    onTap: () {
                      MaterialPageRoute route = MaterialPageRoute(
                          builder: (_) => DetailScreen(movies![position]));
                      Navigator.push(context, route);
                    },
                    leading: CircleAvatar(
                      backgroundImage: image,
                    ),
                    title: Text(movies![position].title),
                    subtitle: Text('Released: ' +
                        movies![position].releaseDate +
                        ' - Vote: ' +
                        movies![position].voteAverage.toString()),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

