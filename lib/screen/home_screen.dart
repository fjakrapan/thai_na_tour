import 'dart:convert';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:thai_na_tour/config/app.dart';
import 'package:http/http.dart' as http;
import 'package:thai_na_tour/services/auth_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> banners = [];

  Future<void> fetchBanners() async {
    try {
      final response = await http.get(Uri.parse('$API_URL/api/banners'));
      final banners = jsonDecode(response.body);
      print(banners);
      setState(() {
        this.banners = banners;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    AuthService.checkLogin().then((loggedIn) {
      if (!loggedIn) {
        Navigator.of(context).pushReplacementNamed('/login');
      }
    });
    fetchBanners();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Column(
        children: [
          SizedBox(
              height: 250,
              child: Swiper(
                autoplay: true,
                itemCount: banners.length,
                itemBuilder: (context, index) {
                  return Image.network(
                    '$API_URL/${banners[index]['imageUrl']}',
                  );
                },
              ))
        ],
      ),
    );
  }
}
