//定义轮播图模型类
class BannerItem{
  String id;//轮播图id
  String imageUrl;//轮播图图片url
  //构造函数
  BannerItem({this.id = "",this.imageUrl = ""});
  //扩展工厂构造函数 从json字符串创建实例对象
  factory BannerItem.fromJson(Map<String, dynamic> json){
    return BannerItem(
      id: json["id"] ?? "",
      imageUrl: json["imgUrl"] ?? "",
    );
  }
}
			// "id": "1181622001",
			// "name": "气质女装",
			// "picture": "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meikou/c1/qznz.png",
			// "children": [
			// 	{
			// 		"id": "1191110001",
			// 		"name": "半裙",
			// 		"picture": "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meikou/c2/qznz_bq.png?quality=95&imageView",
			// 		"children": null,
			// 		"goods": null
			// 	},
			// 	{
			// 		"id": "1191110002",
			// 		"name": "衬衫",
			// 		"picture": "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meikou/c2/qznz_cs.png?quality=95&imageView",
			// 		"children": null,
			// 		"goods": null
			// 	},
			// 	{
			// 		"id": "1191110022",
			// 		"name": "T恤",
			// 		"picture": "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meikou/c2/qznz_tx.png?quality=95&imageView",
			// 		"children": null,
			// 		"goods": null
			// 	},
			// 	{
			// 		"id": "1191110023",
			// 		"name": "针织衫",
			// 		"picture": "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meikou/c2/qznz_zzs.png?quality=95&imageView",
			// 		"children": null,
			// 		"goods": null
			// 	},
			// 	{
			// 		"id": "1191110024",
			// 		"name": "夹克",
			// 		"picture": "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meikou/c2/qznz_jk.png?quality=95&imageView",
			// 		"children": null,
			// 		"goods": null
			// 	},
			// 	{
			// 		"id": "1191110025",
			// 		"name": "卫衣",
			// 		"picture": "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meikou/c2/qznz_wy.png?quality=95&imageView",
			// 		"children": null,
			// 		"goods": null
			// 	},
//根据上面的JSON定义分类列表模型类
class CategoryItem{
  String id;//分类id
  String name;//分类名称
  String picture;//分类图片url
  List<CategoryItem> children;//子分类列表
  //构造函数
  CategoryItem({this.id = "",this.name = "",this.picture = "",this.children = const []});
  //扩展工厂构造函数 从json字符串创建实例对象
  factory CategoryItem.fromJson(Map<String, dynamic> json){
    return CategoryItem(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      picture: json["picture"] ?? "",
      children: json["children"] != null
          ? (json["children"] as List).map((item) => CategoryItem.fromJson(item as Map<String, dynamic>)).toList()
          : [],
    );
  }
}

//定义商品项模型类
class GoodsItem{
  String id;
  String name;
  String desc;
  String price;
  String picture;
  int orderNum;
  
  GoodsItem({this.id = "",this.name = "",this.desc = "",this.price = "",this.picture = "",this.orderNum = 0});
  
  factory GoodsItem.fromJson(Map<String, dynamic> json){
    return GoodsItem(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      desc: json["desc"] ?? "",
      price: json["price"] ?? "",
      picture: json["picture"] ?? "",
      orderNum: json["orderNum"] ?? 0,
    );
  }
}

//定义商品列表模型类（包含分页信息）
class GoodsItems{
  int counts;
  int pageSize;
  int pages;
  int page;
  List<GoodsItem> items;
  
  GoodsItems({this.counts = 0,this.pageSize = 0,this.pages = 0,this.page = 0,this.items = const []});
  
  factory GoodsItems.fromJson(Map<String, dynamic> json){
    return GoodsItems(
      counts: json["counts"] ?? 0,
      pageSize: json["pageSize"] ?? 0,
      pages: json["pages"] ?? 0,
      page: json["page"] ?? 0,
      items: json["items"] != null
          ? (json["items"] as List).map((item) => GoodsItem.fromJson(item as Map<String, dynamic>)).toList()
          : [],
    );
  }
}

//定义子类型模型类（如抢先尝鲜、新品预告）
class SubTypeItem{
  String id;
  String title;
  GoodsItems goodsItems;
  
  SubTypeItem({this.id = "",this.title = "",required this.goodsItems});
  
  factory SubTypeItem.fromJson(Map<String, dynamic> json){
    return SubTypeItem(
      id: json["id"] ?? "",
      title: json["title"] ?? "",
      goodsItems: json["goodsItems"] != null
          ? GoodsItems.fromJson(json["goodsItems"] as Map<String, dynamic>)
          : GoodsItems(),
    );
  }
}

//定义特惠推荐模型类
class SpecialItem{
  String id;
  String title;
  List<SubTypeItem> subTypes;
  
  SpecialItem({this.id = "",this.title = "",this.subTypes = const []});
  
  factory SpecialItem.fromJson(Map<String, dynamic> json){
    return SpecialItem(
      id: json["id"] ?? "",
      title: json["title"] ?? "",
      subTypes: json["subTypes"] != null
          ? (json["subTypes"] as List).map((item) => SubTypeItem.fromJson(item as Map<String, dynamic>)).toList()
          : [],
    );
  }
}
