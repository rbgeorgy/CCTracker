import 'dart:io';

import 'package:flutter/material.dart';
import 'package:meditation/CCData.dart';
import 'package:http/http.dart' as http;
import 'package:requests/requests.dart';
import 'dart:convert';

class CCList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CCListState();
  }
}

class CCListState extends State<CCList> {
  List<CCData> data = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CCTracker'),
      ),
      body: Container(
          child: ListView(
        children: _buildList(),
      )),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.refresh), onPressed: () => _loadCC()),
    );
  }

  _loadCC() async {
    var uri = Uri.http(
        'pro-api.coinmarketcap.com',
        '/v1/cryptocurrency/listings/latest',
        {'start': '1', 'limit': '10', 'convert': 'USD'});

    var responce = await http.get(uri, headers: {
      'Accepts': 'application/json',
      'X-CMC_PRO_API_KEY': 'eae24f6f-0d8e-4c1a-8e60-6dc836cc617e'
    });

    if (responce.statusCode == 200) {
      String s = responce.body;
      //print(s);
      var allData = (json.decode(s) as Map)['data'] as List<dynamic>;

      var ccDataList = List<CCData>();
      allData.forEach((dynamic value) {
        var record = CCData(
            name: value['name'],
            symbol: value['symbol'],
            rank: value['cmc_rank'],
            price: value['quote']['USD']['price']);
        ccDataList.add(record);
      });

      setState(() {
        data = ccDataList;
      });
    }
  }

  List<Widget> _buildList() {
    return data
        .map((CCData f) => ListTile(
              title: Text(f.name),
              subtitle: Text(f.symbol),
              leading: CircleAvatar(child: Text(f.rank.toString())),
              trailing: Text('\$${f.price.toString()}'),
            ))
        .toList();
  }
}
