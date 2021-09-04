import 'package:flutter/material.dart';
import 'package:flutter_social_ui/models/user_model.dart';
import 'package:flutter_social_ui/widgets/custom_drawer.dart';
import 'package:flutter_social_ui/widgets/posts_carousel.dart';
import 'package:flutter_social_ui/widgets/profile_clipper.dart';

class ProfileScreen extends StatefulWidget {
  final User user;

  const ProfileScreen({Key key, this.user}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  PageController _yourPostPageController;
  PageController _favoritesPostPageController;

  @override
  void initState() {
    super.initState();
    _yourPostPageController =
        PageController(initialPage: 0, viewportFraction: 0.8);
    _favoritesPostPageController =
        PageController(initialPage: 0, viewportFraction: 0.8);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                ClipPath(
                  clipper: ProfileClipper(),
                  child: Image(
                    image: AssetImage(widget.user.backgroundImageUrl),
                    height: 300.0,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                    top: 50.0,
                    left: 20.0,
                    child: IconButton(
                      icon: Icon(Icons.menu),
                      iconSize: 30.0,
                      color: Theme.of(context).primaryColor,
                      onPressed: () => _scaffoldKey.currentState.openDrawer(),
                    )),
                Positioned(
                    bottom: 10.0,
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black45,
                                offset: Offset(0, 2),
                                blurRadius: 6.0)
                          ]),
                      child: ClipOval(
                        child: Image(
                          height: 100.0,
                          width: 100.0,
                          image: AssetImage(widget.user.profileImageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ))
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                widget.user.name,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                    letterSpacing: 1.5),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      "Following",
                      style: TextStyle(color: Colors.black54, fontSize: 22.0),
                    ),
                    SizedBox(height: 2.0),
                    Text(
                      widget.user.following.toString(),
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "Followers",
                      style: TextStyle(color: Colors.black54, fontSize: 22.0),
                    ),
                    SizedBox(height: 2.0),
                    Text(
                      widget.user.followers.toString(),
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.w600),
                    ),
                  ],
                )
              ],
            ),
            PostsCarousel(
              pageController: _yourPostPageController,
              title: "Your Posts",
              posts: widget.user.posts,
            ),
            PostsCarousel(
              pageController: _favoritesPostPageController,
              title: "Favorites",
              posts: widget.user.favorites,
            )
          ],
        ),
      ),
    );
  }
}
