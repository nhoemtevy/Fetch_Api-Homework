import 'package:http/http.dart' as http;
import 'dart:convert';

const String baseUrl = 'https://jsonplaceholder.typicode.com/posts';

final client = http.Client(); // Initialize an HTTP client

// Fetch Posts using http.Client
Future<void> fetchPosts() async {
  try {
    final request = http.Request('GET', Uri.parse(baseUrl));
    final response = await client.send(request);  // Send the request

    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();  // Convert the stream to a string
      print('GET Request successfully:');
      print(responseBody);
    } else {
      print('GET Request failed status: ${response.statusCode}');
    }
  } catch (e) {
    print('GET Request failed: $e');
  }
}

// Create Post using http.Client
Future<void> createPost() async {
  try {
    final request = http.Request('POST', Uri.parse(baseUrl))
      ..headers['Content-Type'] = 'application/json; charset=UTF-8'
      ..body = jsonEncode(<String, dynamic>{
        'title': 'New Post',
        'body': 'This is the content of the new post',
        'userId': 1,
      });

    final response = await client.send(request);  // Send the request
    final responseBody = await response.stream.bytesToString();  // Convert the stream to a string

    if (response.statusCode == 201) {
      print('POST Request successfully:');
      print(responseBody);
    } else {
      print('POST Request failed status: ${response.statusCode}');
    }
  } catch (e) {
    print('POST Request failed: $e');
  }
}

// Update Post using http.Client
Future<void> updatePost(int id) async {
  try {
    final request = http.Request('PUT', Uri.parse('$baseUrl/$id'))
      ..headers['Content-Type'] = 'application/json; charset=UTF-8'
      ..body = jsonEncode(<String, dynamic>{
        'id': id,
        'title': 'Updated Title',
        'body': 'Updated body of the post',
        'userId': 1,
      });

    final response = await client.send(request);
    final responseBody = await response.stream.bytesToString();  // Convert the stream to a string

    if (response.statusCode == 200) {
      print('PUT Request successful:');
      print(responseBody);
    } else {
      print('PUT Request failed with status: ${response.statusCode}');
    }
  } catch (e) {
    print('PUT Request failed: $e');
  }
}

// Delete Post using http.Client
Future<void> deletePost(int id) async {
  try {
    final request = http.Request('DELETE', Uri.parse('$baseUrl/$id'));
    final response = await client.send(request);

    if (response.statusCode == 200) {
      print('DELETE Request: Post with id $id successfully deleted.');
    } else {
      print('DELETE Request failed with status: ${response.statusCode}');
    }
  } catch (e) {
    print('DELETE Request failed: $e');
  }
}

void main() async {
  await fetchPosts();    
  await createPost();    
  await updatePost(1);   
  await deletePost(1);   
}
