// 1. add Book data model 
class Book {
  final String title;
  final String imageUrl;
  final String description;
  final String publisher;
  final int weeksOnList;
  final String author;
  final String amazonUrl;

  Book({
    this.title, 
    this.imageUrl, 
    this.description, 
    this.publisher, 
    this.weeksOnList, 
    this.author, 
    this.amazonUrl
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['title'],
      imageUrl: json['book_image'],
      description: json['description'],
      publisher: json['publisher'], 
      weeksOnList: json['weeks_on_list'], 
      author: json['author'], 
      amazonUrl: json['amazon_product_url']
    );
  }
}