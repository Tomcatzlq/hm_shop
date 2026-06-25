//定义轮播图模型类
class BannerItem{
  String? id;//轮播图id，用于点击跳转,非空
  String? imageUrl;//轮播图图片url,非空
  //构造函数
  BannerItem({this.id,this.imageUrl});
  //扩展工厂构造函数 从json字符串创建实例对象
  factory BannerItem.fromJson(Map<String, dynamic> json){
    // print("服务器返回的完整数据: $json");
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
  String? id;//分类id，用于点击跳转,非空
  String? name;//分类名称,非空
  String? picture;//分类图片url,非空
  List<CategoryItem>? children;//子分类列表,可空
  //构造函数
  CategoryItem({this.id,this.name,this.picture,this.children});
  //扩展工厂构造函数 从json字符串创建实例对象
  factory CategoryItem.fromJson(Map<String, dynamic> json){
    return CategoryItem(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      picture: json["picture"] ?? "",
      children: json["children"] != null
          ? (json["children"] as List).map((item) => CategoryItem.fromJson(item as Map<String, dynamic>)).toList()
          : null,
    );
  }
}
