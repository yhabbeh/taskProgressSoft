
import 'dart:developer';

import 'package:e_commerce/lib/features/home/presentation/screens/widgets/post_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/post_cubit.dart';


class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<PostCubit, PostState>(
          listener: (context, state){},
          builder: (context, state) {
            if (state is PostLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PostLoaded) {
              return SizedBox(
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                          controller: controller,
                          decoration: InputDecoration(
                            fillColor: Theme.of(context).colorScheme.background,
                            errorStyle: const TextStyle(fontSize: 12) ,
                            hintStyle: const TextStyle(fontSize: 12),
                            labelStyle: const TextStyle(fontSize: 12),
                            filled: true,
                            isDense: true,
                            hintText: 'Search post titles ',
                            labelText: 'search',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15),borderSide:  BorderSide(color: Theme.of(context).colorScheme.onBackground,),),
                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15),borderSide: BorderSide(color: Theme.of(context).colorScheme.onBackground,),),
                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15),borderSide: BorderSide(color: Theme.of(context).colorScheme.onBackground,),),
                          ),
                          onChanged: (val){
                            context.read<PostCubit>().setFilteredPosts =   context.read<PostCubit>().getPosts.where((post) => post.title.toLowerCase().contains(val.toLowerCase())).toList();

                          },
                        ),
                      ),
                      ... context.read<PostCubit>().getFilteredPosts.map((e) =>
                          PostWidget(
                            title:  e.title ,
                            content:e.body ,
                          )
                      )
                    ],
                  ),
                ),
              );
            } else if (state is PostError) {
              return Center(child: Text(state.message));
            } else {
              return const Center(child: Text('Press the button to fetch posts'));
            }
          },
        ),
      ),
    );
  }
}