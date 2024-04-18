import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mini/bloc/services/api.dart';

class ViewStock extends StatefulWidget {
  const ViewStock({super.key});

  @override
  State<ViewStock> createState() => _ViewStockState();
}

class _ViewStockState extends State<ViewStock> {
  List<dynamic> chemicals = [];
  Comparator<dynamic> _comparator = (a, b) => a["chemicalname"].compareTo(b["chemicalname"]);

  @override
  void initState() {
    super.initState();
    _loadChemicals();
  }


 Future<void> _loadChemicals() async {
    try {
      final stockData = await getstock();
      setState(() {
        chemicals = stockData['chemicals'];
         chemicals.sort(_comparator);
      });
    } catch (e) {
      // Handle any errors that occurred during the API call
      print('Error fetching data: $e');
    }
  }

  void _sortChemicals(int index) {
    setState(() {
      switch (index) {
        case 0:
          _comparator = (a, b) => a["chemicalname"].compareTo(b["chemicalname"]);
          break;
        case 1:
          _comparator = (a, b) => a["addquantity"].compareTo(b["addquantity"]);
          break;
        case 2:
          _comparator = (a, b) => DateTime.parse(a["expirydate"]).compareTo(DateTime.parse(b["expirydate"]));
          break;
      }
      chemicals.sort(_comparator);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Stock',style: TextStyle(color: Colors.white),),
        backgroundColor: const Color.fromRGBO(11, 0, 35, 10),
        actions: [
          PopupMenuButton(iconColor: Colors.white,
            onSelected: _sortChemicals,
            itemBuilder: (context) => [
              const PopupMenuItem(value: 0, child: Text('Sort by Chemical Name')),
              const PopupMenuItem(value: 1, child: Text('Sort by Available Stock')),
              const PopupMenuItem(value: 2, child: Text('Sort by Expiry Date')),
            ],
          ),
        ],
      ),
      body: Container(
        color: const Color.fromRGBO(11, 0, 35, 10),
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.all(16.0),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final chemical = chemicals[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 16.0),
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: chemical["addquantity"] < 100
                            ? Color.fromARGB(255, 255, 0, 0)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            chemical["chemicalname"],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Text('Available Stock: ${chemical["addquantity"]}'),
                          const SizedBox(height: 8.0),
                          Text('Expiry Date: ${DateTime.parse(chemical["expirydate"]).toIso8601String().substring(0, 10)}'),
                        ],
                      ),
                    );
                  },
                  childCount: chemicals.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}