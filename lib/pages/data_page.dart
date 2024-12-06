import 'package:flutter/material.dart';
import 'package:service_reviews_flutter_final_exam/models/review_model.dart';
import 'package:service_reviews_flutter_final_exam/services/api_service.dart'; // Ensure you import ApiService
import 'package:service_reviews_flutter_final_exam/widgets/custom_card.dart'; // Assuming you have a CustomCard widget
import 'package:service_reviews_flutter_final_exam/widgets/custom_button.dart'; // Assuming you have a CustomButton widget

class DataPage extends StatefulWidget {
  @override
  _DataPageState createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  ApiService apiService = ApiService();
  List<ReviewModel> comments = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchComments();
  }

  // Fetch comments from API
  Future<void> fetchComments() async {
    comments = await apiService.fetchComments();
    setState(() {
      isLoading = false;
    });
  }

  // Method to handle adding a new comment
  void addNewComment() {
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController bodyController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Add New Comment',
            style: TextStyle(color: Colors.blueAccent),
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: bodyController,
                decoration: const InputDecoration(labelText: 'Comment'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                  fontWeight: FontWeight.bold, // Bold text
                  color: Colors.blueAccent,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  // Create a new comment object and add it to the list
                  comments.add(ReviewModel(
                    postId: comments.length +
                        1, // You can adjust the ID logic as needed
                    id: comments.length + 1,
                    name: nameController.text,
                    email: emailController.text,
                    body: bodyController.text,
                  ));
                });
                Navigator.pop(context);
              },
              child: const Text(
                'Add',
                style: TextStyle(
                  fontWeight: FontWeight.bold, // Bold text
                  color: Colors.blueAccent,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // Method to handle editing a comment
  void editComment(int index) {
    final comment = comments[index];
    TextEditingController nameController =
        TextEditingController(text: comment.name);
    TextEditingController bodyController =
        TextEditingController(text: comment.body);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Comment'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: bodyController,
                decoration: const InputDecoration(labelText: 'Comment'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  comments[index] = ReviewModel(
                    postId: comment.postId,
                    id: comment.id,
                    name: nameController.text,
                    email: comment.email,
                    body: bodyController.text,
                  );
                });
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  // Method to handle deleting a comment
  void deleteComment(int index) {
    setState(() {
      comments.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        'Comments',
        style: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Colors.blueAccent,
        ),
      )),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: comments.length,
              itemBuilder: (context, index) {
                final comment = comments[index];
                return CustomCard(
                  review: comment,
                  onEdit: () => editComment(index),
                  onDelete: () => deleteComment(index),
                );
              },
            ),
      floatingActionButton: CustomButton(
        text: 'Add New Comment',
        onPressed: addNewComment,
        textStyle: const TextStyle(
          fontSize: 18, // Set the font size you like
          fontWeight: FontWeight.bold, // Set to bold
          color: Colors.blueAccent, // Blue text color
        ),
        backgroundColor: Colors.white, // White background
      ),
    );
  }
}
