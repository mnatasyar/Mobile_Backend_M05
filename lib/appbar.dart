AppBar(
  title: Text('Movies'),
  actions: <Widget>[
    // IconButton untuk beralih antara ikon search dan clear
    IconButton(
      icon: Icon(searchController.text.isEmpty ? Icons.search : Icons.clear),
      onPressed: () {
        setState(() {
          if (searchController.text.isEmpty) {
            // Tampilkan ikon clear saat ditekan
            searchController.clear();
            onSearchTextChanged('');
          } else {
            // Tampilkan ikon search saat ditekan
            searchController.clear();
            initialize();
          }
        });
      },
    ),
    // TextField untuk pencarian
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
)
