import 'package:flutter/material.dart';
import 'web_scraper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Cooking Recipe Helper')),
        body: HtmlExtractorScreen(),
      ),
    );
  }
}

class HtmlExtractorScreen extends StatefulWidget {
  @override
  _HtmlExtractorScreenState createState() => _HtmlExtractorScreenState();
}

class _HtmlExtractorScreenState extends State<HtmlExtractorScreen> {
  final _urlController = TextEditingController();
  String _ingredients = '';
  String _instructions = '';

  final webScraper = WebScraper();

  Future<void> _fetchAndProcessHtmlContent() async {
    final url = _urlController.text;
    final renderUrl = 'https://flask-backend-ckhp.onrender.com/extract-recipe'; // Use your Render URL

    try {
      // Fetch and process the HTML content
      final content = await webScraper.fetchHtmlContent(url);

      // Send the processed content to the Flask backend
      final response = await http.post(
        Uri.parse(renderUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'html': content}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _ingredients = data['ingredients'];
          _instructions = data['instructions'];
        });
      } else {
        setState(() {
          _ingredients = 'Failed to extract recipe data';
          _instructions = '';
        });
      }
    } catch (e) {
      setState(() {
        _ingredients = 'Error: $e';
        _instructions = '';
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _urlController,
            decoration: InputDecoration(labelText: 'Enter Recipe URL'),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: _fetchAndProcessHtmlContent,
            child: Text('Fetch and Extract Recipe'),
          ),
          SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Ingredients:', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(_ingredients),
                  SizedBox(height: 20),
                  Text('Instructions:', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(_instructions),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
