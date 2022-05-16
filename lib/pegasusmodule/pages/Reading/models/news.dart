class News{
  final String newsTitle;
  final String newsImage;
  final List newsContent;
  final String newsType;
  final String author;
  final String publishingCompany;

  const News({
    required this.newsTitle,
    required this.newsImage,
    required this.newsContent,
    required this.newsType,
    required this.author,
    required this.publishingCompany,
  });

  factory News.fromJson(Map<String,dynamic> json){ 
    return News(newsTitle: json['newsTitle'], newsImage: json['newsImage'],newsContent: json['newsContent'],newsType: json['newsType'],
                author: json['author'],publishingCompany: json['publishing_company']);
  }
}


// const List sample_data_news = [
//   {
//     "id": 1,
//     "newsTitle":"UK Competition Watchdog to Get Legal Powers to Fine Big Tech Firms",
//     "newsImage":"https://img.theepochtimes.com/assets/uploads/2022/02/28/logo-for-Google-LLC-700x420.jpg",
//     "newsContent":["Tech giants such as Google, Facebook, or Apple could face fines of up to 10 percent of their global turnover if they fail to comply with proposed pro-competition rules, the UK government said on Thursday.",
//                   "The Department for Digital, Culture, Media, and Sport (DCMS) confirmed that the Digital Markets Unit (DMU)—the UK’s dedicated competition watchdog for online platforms—will be given statutory powers to enforce the “fair-play” rules.",
//                   "But the department didn’t provide a timeline for the proposed legislation, saying it will be introduced “in due course.”",
//                   "According to the DCMS, “new tailored codes” will be introduced to regulate “the handful of firms dominating digital markets.”",
//                   "Digital Minister Chris Philp said the government wants to level the digital playing field.",
//                   "“Technology has revolutionised the way thousands of UK firms do business—helping them reach new customers and putting a range of instant online services at people’s fingertips. But the dominance of a few tech giants is crowding out competition and stifling innovation,” Philp said.",
//                   "“We want to level the playing field and we are arming this new tech regulator with a range of powers to generate lower prices, better choice, and more control for consumers while backing content creators, innovators, and publishers, including in our vital news industry.”",
//                   "The DCMS said the proposals aim to make it easier for people to switch between Apple iOS and Android phones or between social media accounts without losing their data and messages.",
//                   "With tech firms prohibited from limiting consumers to pre-installed software on their devices, people could also get more choice of which search engines and social media platforms they have access to, the department said."],
//     "newsType": 'NewsUk',
//     "author": "nguyen ngoc trai",
//     "publishing_company": "BBC",
//   } 
// ];
