import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:food_app/services/modal.dart';
import 'package:http/http.dart';

class SearchPage extends StatefulWidget {
  final String query;
  SearchPage(this.query);
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool loading = true;
  TextEditingController search = TextEditingController();

  List<ReceipeModal> recipeList = <ReceipeModal>[];

  getrecipe(String query) async {
    var url = Uri.parse(
        "https://api.edamam.com/api/recipes/v2?type=public&q=$query&app_id=8825d859&app_key=36baa48af1a2eed0e8099220fd002940");
    var response = await get(url);
    Map data = jsonDecode(response.body);
    data["hits"].forEach((element) {
      ReceipeModal recipeModal = ReceipeModal();
      recipeModal = ReceipeModal.fromMap(element["recipe"]);
      recipeList.add(recipeModal);
      setState(() {
        loading = false;
      });
    });

    recipeList.forEach((recipe) {
      print(recipe.applabel);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getrecipe(widget.query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xff213A50),
                  Color(0xff071938),
                ],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                SafeArea(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    margin: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24)),
                    child: Row(
                      children: [
                        GestureDetector(
                          
                          onTap: () {
                            if ((search.text).replaceAll("", " ") == "") {
                              print("Blank Search");
                            } else {
                              print("clicked");
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          SearchPage(search.text)));
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.fromLTRB(3, 0, 7, 0),
                            child: Icon(
                              Icons.search,
                              color: Colors.black12,
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            controller: search,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Let's Cook Something",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: loading
                      ? Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: recipeList.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {},
                              child: Card(
                                margin: EdgeInsets.all(20),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        recipeList[index].appimgurl,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: 200,
                                      ),
                                    ),
                                    Positioned(
                                      left: 0,
                                      right: 0,
                                      bottom: 0,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        decoration: BoxDecoration(
                                          color: Colors.black26,
                                        ),
                                        child: Text(
                                          recipeList[index].applabel,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      right: 0,
                                      width: 80,
                                      height: 40,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.black26,
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(10),
                                              bottomLeft: Radius.circular(10),
                                            )),
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.local_fire_department,
                                                size: 15,
                                                color: Colors.white,
                                              ),
                                              Text(
                                                recipeList[index]
                                                    .appcalories
                                                    .toString()
                                                    .substring(0, 6),
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
