import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../model/post_model.dart';

part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit() : super(PostInitial());


   List<Post> _posts =[];
   List<Post> _filteredPosts = [];

    List<Post> get getPosts =>_posts;
    List<Post> get getFilteredPosts => _filteredPosts;


   set setFilteredPosts(List<Post>  posts){
     _filteredPosts = posts;
     emit(PostLoaded(_filteredPosts));
   }



  Future<void> fetchPosts() async {
    emit(PostLoading());

    try {
      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        _posts =_filteredPosts= jsonResponse.map((post) => Post.fromJson(post)).toList();
        emit(PostLoaded(_posts));
      } else {
        emit(PostError('Failed to load posts'));
      }
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }


}