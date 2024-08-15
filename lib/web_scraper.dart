import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class WebScraper {
  final yt = YoutubeExplode();

  Future<String> fetchHtmlContent(String url) async {
    if (isYouTubeUrl(url)) {
      return fetchYouTubeCaptions(url); // Fetch YouTube captions if URL is YouTube
    } else {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return extractTextFromHtml(response.body); // Extract text from HTML content
      } else {
        throw Exception('Failed to load webpage');
      }
    }
  }

  bool isYouTubeUrl(String url) {
    return url.contains('youtube.com') || url.contains('youtu.be');
  }

  Future<String> fetchYouTubeCaptions(String url) async {
    try {
      var videoId = VideoId.parseVideoId(url);
      var manifest = await yt.videos.closedCaptions.getManifest(videoId!);
      var track = manifest.tracks.first;
      var captions = await yt.videos.closedCaptions.get(track);
      var text = captions.captions.map((caption) => caption.text).join(' ');
      return text;
    } catch (e) {
      throw e;
    }
  }

  String extractTextFromHtml(String htmlContent) {
    // Parse HTML content
    final document = parser.parse(htmlContent);

    // Extract text from specific tags
    final paragraphs = document.getElementsByTagName('p');
    final listItems = document.getElementsByTagName('li');
    final headings = document.getElementsByTagName('h1');
    final headings2 = document.getElementsByTagName('h2');
    final headings3 = document.getElementsByTagName('h3');

    // Combine the text content from these tags
    final textContent = StringBuffer();
    for (var element in paragraphs) {
      textContent.writeln(element.text.trim());
    }
    for (var element in listItems) {
      textContent.writeln(element.text.trim());
    }
    for (var element in headings) {
      textContent.writeln(element.text.trim());
    }
    for (var element in headings2) {
      textContent.writeln(element.text.trim());
    }
    for (var element in headings3) {
      textContent.writeln(element.text.trim());
    }

    return textContent.toString().trim();
  }
}
