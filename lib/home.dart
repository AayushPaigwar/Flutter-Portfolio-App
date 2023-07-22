import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:github_api/neopop.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MyHomePage();
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String githubUsername = 'AayushPaigwar';
  final String githubApiUrl =
      'https://api.github.com/users/AayushPaigwar/repos';

  Future<List<GithubRepository>> fetchRepositories() async {
    final response = await http.get(Uri.parse(githubApiUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);

      List<GithubRepository> repositories = [];
      for (var repo in data) {
        repositories.add(
          GithubRepository(
            name: repo['name'],
            description: repo['description'] ?? 'No description',
            url: repo['html_url'],
          ),
        );
      }
      return repositories;
    } else {
      throw Exception('Failed to fetch repositories');
    }
  }

  void _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw Exception('Failed to launch URL');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchRepositories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFFFFF),
              Colors.blue,
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 200,
                  width: 200,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage(
                            'https://avatars.githubusercontent.com/u/90213184?s=400&u=c4b595f047d5315ae5d056261179387e41e32fa0&v=4')),
                    color: Colors.blue,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text('Hey I am Aayush Paigwar',
                      style: TextStyle(
                        fontFamily: GoogleFonts.poppins().fontFamily,
                        fontSize: 25,
                        fontWeight: FontWeight.w400,
                      )),
                ),
                Text(
                  'I am a Flutter Developer',
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      fontFamily: GoogleFonts.poppins().fontFamily),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 100,
                ),
                const SizedBox(
                  height: 5,
                ),

                const NeoPop(),

                const SizedBox(
                  height: 10,
                ),
                const Divider(
                  color: Colors.black12,
                  thickness: 1,
                  indent: 10,
                  endIndent: 10,
                ),

                Text(
                  'About me',
                  style: TextStyle(
                      fontSize: 30,
                      fontFamily: GoogleFonts.poppins().fontFamily),
                ),
                const SizedBox(
                  height: 15,
                ),
                //About me
                Container(
                  height: 370,
                  width: 350,
                  color: Colors.white10,
                  child: Text(
                      'I\'m a passionate tech professional with a strong knowledge in Flutter development and machine learning. Proficient in Git/GitHub and skilled in programming languages such as C, C++, Dart, Python, and R, with a solid understanding of OOPs concepts. I am eager to apply my skills and gain practical experience in a real-world setting. In addition to my technical expertise, I have a creative side, excelling in graphic design and social media. I enjoy bringing innovative ideas to life and enhancing user experiences. I am particularly interested in contributing to open source projects, as it allows me to collaborate with diverse teams and make a positive impact on the community.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: GoogleFonts.poppins().fontFamily)),
                ),
                const SizedBox(
                  height: 3,
                ),
                const Divider(
                  color: Colors.black12,
                  thickness: 1,
                  indent: 10,
                  endIndent: 10,
                ),

                //Tech Stacks
                Text(
                  'Tech Stack',
                  style: TextStyle(
                      fontSize: 30,
                      fontFamily: GoogleFonts.poppins().fontFamily),
                ),
                const SizedBox(
                  height: 15,
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 230.0),
                  child: Text(
                    'Languages:',
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: GoogleFonts.poppins().fontFamily),
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),

                const SizedBox(
                  height: 120,
                  width: 370,
                  child: TechStack(),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 120.0),
                  child: Text(
                    'Libraries & Framework:',
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: GoogleFonts.poppins().fontFamily),
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),
                const Frameworks(),

                const SizedBox(
                  height: 10,
                ),
                const Divider(
                  color: Colors.black12,
                  thickness: 1,
                  indent: 10,
                  endIndent: 10,
                ),

                const Divider(
                  color: Colors.black12,
                  thickness: 1,
                  indent: 10,
                  endIndent: 10,
                ),

                Text(
                  'Projects',
                  style: TextStyle(
                      fontSize: 30,
                      fontFamily: GoogleFonts.poppins().fontFamily),
                ),

                //Github API
                SizedBox(
                  height: 250,
                  width: 400,
                  child: FutureBuilder<List<GithubRepository>>(
                    future: fetchRepositories(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return const Center(
                            child: Text('Error fetching repositories'));
                      } else {
                        return Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              GithubRepository repository =
                                  snapshot.data![index];
                              return Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.red,
                                          blurRadius: 5.0,
                                          offset: Offset(
                                            3,
                                            3,
                                          ),
                                        )
                                      ],
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    margin: const EdgeInsets.all(10),
                                    padding: const EdgeInsets.all(10),
                                    height: 150,
                                    width: 200,
                                    child: GestureDetector(
                                      onTap: () => _launchURL(repository.url),
                                      child: ListTile(
                                        title: Text(repository.name),
                                        subtitle: Text(
                                          repository.description,
                                          maxLines: 5,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        );
                      }
                    },
                  ),
                ),

                const Divider(
                  color: Colors.black12,
                  thickness: 1,
                  indent: 10,
                  endIndent: 10,
                ),
                //  ElevatedButton(onPressed: (){}, child: const Text('Instagr')),

                //Contact
                Text(
                  'Get in touch!',
                  style: TextStyle(
                      fontSize: 30,
                      fontFamily: GoogleFonts.poppins().fontFamily),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(35.0, 35, 35, 0),
                  child: TextField(
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: GoogleFonts.poppins().fontFamily),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        gapPadding: 10,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      hintText: 'Name',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(35.0, 35, 35, 0),
                  child: TextField(
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: GoogleFonts.poppins().fontFamily),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        gapPadding: 10,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      hintText: 'Email',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(35.0, 35, 35, 0),
                  child: TextField(
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: GoogleFonts.poppins().fontFamily),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        gapPadding: 10,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      hintText: 'Phone No.',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(35.0, 35, 35, 0),
                  child: TextField(
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: GoogleFonts.poppins().fontFamily),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        gapPadding: 10,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      hintText: 'Message',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Libraries {
  final String libName;
  final String libLogo;

  Libraries({required this.libName, required this.libLogo});
}

class Technologies {
  final String techName;
  final String techLogo;

  Technologies({required this.techName, required this.techLogo});
}

class GithubRepository {
  final String name;
  final String description;
  final String url;

  GithubRepository({
    required this.name,
    required this.description,
    required this.url,
  });
}

class TechStack extends StatelessWidget {
  const TechStack({super.key});

  @override
  Widget build(BuildContext context) {
    List<Technologies> techList = [
      Technologies(
        techName: 'Dart',
        techLogo: "assets/dart.png",
      ),
      Technologies(
        techName: 'Python',
        techLogo: "assets/python.png",
      ),
      Technologies(
        techName: 'C++',
        techLogo: "assets/cpp.png",
      ),
      Technologies(
        techName: 'C',
        techLogo: "assets/c.png",
      ),
      Technologies(
        techName: 'R',
        techLogo: "assets/r.png",
      ),
    ];

    return ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: techList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.red,
                    blurRadius: 5.0,
                    offset: Offset(
                      3,
                      3,
                    ),
                  )
                ],
              ),
              height: 100,
              width: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 50,
                      child: Image(
                        image: AssetImage(
                          techList[index].techLogo,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    techList[index].techName,
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class Frameworks extends StatelessWidget {
  const Frameworks({super.key});

  @override
  Widget build(BuildContext context) {
    List<Libraries> libList = [
      Libraries(
        libName: 'Flutter',
        libLogo: "assets/flutter.png",
      ),
      Libraries(
        libName: 'Numpy',
        libLogo: "assets/numpy.png",
      ),
      Libraries(
        libName: 'Pandas',
        libLogo: "assets/pandas.png",
      ),
    ];
    return SizedBox(
      height: 120,
      width: 370,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: libList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.red,
                      blurRadius: 5.0,
                      offset: Offset(
                        3,
                        3,
                      ),
                    )
                  ],
                ),
                height: 200,
                width: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 40,
                        child: Image(
                          image: AssetImage(
                            libList[index].libLogo,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      libList[index].libName,
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
