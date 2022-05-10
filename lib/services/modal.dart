class ReceipeModal {
  late String applabel;
  late String appimgurl;
  late double appcalories;
  late String appurl;

  ReceipeModal(
      {this.applabel = "Label",
      this.appcalories = 0.00,
      this.appimgurl = "image",
      this.appurl = "url"});

  factory ReceipeModal.fromMap(Map receipe) {
    return ReceipeModal(
      applabel: receipe["label"],
      appcalories: receipe["calories"],
      appimgurl: receipe["image"],
      appurl: receipe["url"],
    );
  }

 
}
