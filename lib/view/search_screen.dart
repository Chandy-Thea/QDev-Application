// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:q_dev_app/view/search_result_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFF0F7FF),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            toolbarHeight: 62,
            automaticallyImplyLeading: false, 
            backgroundColor: Colors.blue,
            flexibleSpace: FlexibleSpaceBar(
              background: MySearchBar(title: 'Search'),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                  child: Text('Search history',style: GoogleFonts.ubuntu(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: Colors.black
                  ),),
                ),
                Divider(height: 0,thickness: 1.5,)
              ],
            )
          ),
          SliverList.builder(
            itemCount: 4,
            itemBuilder: (context, index){
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.alarm),
                            SizedBox(width: 10,),
                            Text('Mobile legend bang bang',style: GoogleFonts.ubuntu(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                              color: Colors.black
                            ),),
                          ],
                        ),
                        Icon(Icons.close)
                      ],
                    ),
                  ),
                  Divider(height: 0,thickness: 1.5,)
                ],
              );
            }
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                  child: Text('Suggested Searches',style: GoogleFonts.ubuntu(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: Colors.black
                  ),),
                ),
                Divider(height: 0,thickness: 1.5,)
              ],
            )
          ),
          SliverList.builder(
            itemCount: 5,
            itemBuilder: (context, index){
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                    child: Row(
                      children: [
                        Icon(Icons.search),
                        SizedBox(width: 10,),
                        Text('General Knowledge',style: GoogleFonts.ubuntu(
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                          color: Colors.black
                        ),),
                      ],
                    ),
                  ),
                  Divider(height: 0,thickness: 1.5,)
                ],
              );
            }
          ),
        ],
      ),
    );
  }
}

class MySearchBar extends StatefulWidget {
  final String title;
  const MySearchBar({super.key, required this.title});

  @override
  State<MySearchBar> createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  TextEditingController searchController = TextEditingController();
  FocusNode searchFocusNode = FocusNode();
  bool onSearch = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BackButton(color: Colors.white,),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1.5, color: Color(0xFFFFFFFF))
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: TextField(
                    focusNode: searchFocusNode,
                    autofocus: true,
                    controller: searchController,
                    onChanged: (value) {
                      // Handle flexible icon when user on search
                      if(value.isNotEmpty){
                        // Not update again and again when user already on search
                        if(!onSearch){
                          setState(() {
                            onSearch = true;
                            print(onSearch);
                          });
                        }
                      }else {
                        setState(() {
                          onSearch = false;
                        });
                        print(onSearch);
                      }
                    },
                    style: GoogleFonts.ubuntu(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      color: Colors.white
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: widget.title,
                      hintStyle: GoogleFonts.ubuntu(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: Colors.white
                      ),
                      icon: Icon(Icons.search, color: Colors.white, size: 20,)
                    ),
                  ),
                ),
              ),
            ),
            // Flexible search button
            onSearch ? SizedBox(width: 10,) : SizedBox(width: 6,),
            onSearch ? GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder:(context) => SearchResultScreen(),)),
              child: Text('Search', style: GoogleFonts.ubuntu(
                fontSize: 17,
                fontWeight: FontWeight.w400,
                color: Colors.white
              ),),
            ) : SizedBox()
          ],
        ),
      ),
    );
  }
}