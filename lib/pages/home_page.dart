// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/coin_model.dart';
import 'package:http/http.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _postJson = [];
  final url =
      'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false';

  void getData() async {
    try {
      Response response = await get(Uri.parse(url));
      final jsonData = jsonDecode(response.body) as List;
      final coins = jsonData.map((json) => Coin.fromJson(json)).toList();
      setState(() {
        _postJson = coins;
        // print(jsonData);
      });
    } catch (e) {
      print("No DATA Find");
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1b232a),
      appBar: myAppbar(),
      body: currencyList(),
    );
  }

  ListView currencyList() {
    return ListView.separated(
      itemCount: _postJson.length,
      separatorBuilder: (BuildContext context, int index) => const SizedBox(
        width: 0,
      ),
      itemBuilder: (BuildContext context, index) {
        final coin = _postJson[index] as Coin;
        return Padding(
          padding: const EdgeInsets.fromLTRB(10,15,10,0),
          child: Container(
            height: 80,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(25)),
                color: Color(0xff161c22)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    Image.network(
                      coin.image,
                      height: 40,
                      width: 40,
                    ),
                    const SizedBox(
                      width: 10,
                    ),

                    //  name and symble
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          coin.name,
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w700),
                        ),
                        Text(
                          coin.symbol,
                          style: const TextStyle(color: Color(0xff777777)),
                        ),
                      ],
                    )
                  ],
                ),
                 Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("\$ ${coin.pricechange24h}",style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w700),),
                      Text("\$ ${coin.currentPrice}",style: const TextStyle(color: Color(0xff777777))),
                    ],
                    
                  ),
                ),
              ],
            ),
            
          ),
        );
      },
    );
  }

  AppBar myAppbar() {
    return AppBar(
        leading: const Icon(
          Icons.menu,
          color: Color(0xff5ed5a8),
        ),
        title: const Text(
          'Crypto Currency ',
          style:
              TextStyle(color: Color(0xff5ed5a8), fontWeight: FontWeight.w700),
        ),
        actions: const [
          Icon(
            Icons.favorite,
            color: Color(0xff5ed5a8),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(
              Icons.search,
              color: Color(0xff5ed5a8),
            ),
          ),
          Icon(
            Icons.more_vert,
            color: Color(0xff5ed5a8),
          ),
        ],
        backgroundColor: Color(0xff161c22));
  }
}
