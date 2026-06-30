import 'package:flutter/material.dart';
import 'package:hm_shop/api/home.dart';
import 'package:hm_shop/viewmodels/home.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({super.key});

  @override
  _CategoryViewState createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  List<CategoryItem> _categoryList = [];
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _getCategoryList();
  }

  Future<void> _getCategoryList() async {
    _categoryList = await getCategoryListAPI();
    setState(() {});
  }

  // 顶部搜索栏
  Widget _buildSearchBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.white,
      child: GestureDetector(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("搜索功能暂未实现")),
          );
        },
        child: Container(
          height: 36,
          padding: EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Row(
            children: [
              Icon(Icons.search, color: Colors.grey, size: 20),
              SizedBox(width: 8),
              Text("搜索商品", style: TextStyle(color: Colors.grey, fontSize: 14)),
            ],
          ),
        ),
      ),
    );
  }

  // 左侧分类列表
  Widget _buildLeftCategory() {
    return Container(
      width: 100,
      color: Color(0xFFF5F5F5),
      child: ListView.builder(
        itemCount: _categoryList.length,
        itemBuilder: (context, index) {
          final isSelected = _selectedIndex == index;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = index;
              });
            },
            child: Container(
              height: 56,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected ? Colors.white : Colors.transparent,
                border: Border(
                  left: BorderSide(
                    color: isSelected ? Colors.red : Colors.transparent,
                    width: 3,
                  ),
                ),
              ),
              child: Text(
                _categoryList[index].name,
                style: TextStyle(
                  fontSize: 13,
                  color: isSelected ? Colors.red : Colors.black87,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // 右侧子分类内容
  Widget _buildRightContent() {
    if (_categoryList.isEmpty) {
      return Center(child: CircularProgressIndicator(color: Colors.red));
    }
    final selectedCategory = _categoryList[_selectedIndex];
    final children = selectedCategory.children;

    return Expanded(
      child: Container(
        color: Colors.white,
        child: CustomScrollView(
          slivers: [
            // 分类标题图片
            if (selectedCategory.picture.isNotEmpty)
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      selectedCategory.picture,
                      height: 100,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 100,
                          color: Color(0xFFF5F5F5),
                          alignment: Alignment.center,
                          child: Text(selectedCategory.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        );
                      },
                    ),
                  ),
                ),
              ),
            // 子分类网格
            if (children.isNotEmpty)
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final child = children[index];
                      return _buildSubCategoryItem(child);
                    },
                    childCount: children.length,
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.75,
                  ),
                ),
              )
            else
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(top: 60),
                  child: Center(
                    child: Text("暂无子分类", style: TextStyle(color: Colors.grey, fontSize: 14)),
                  ),
                ),
              ),
            // 底部留白
            SliverToBoxAdapter(child: SizedBox(height: 20)),
          ],
        ),
      ),
    );
  }

  // 子分类项
  Widget _buildSubCategoryItem(CategoryItem child) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("${child.name} 暂未开放")),
        );
      },
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                child.picture,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Color(0xFFF5F5F5),
                    alignment: Alignment.center,
                    child: Icon(Icons.category, color: Colors.grey, size: 30),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 6),
          Text(
            child.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 12, color: Colors.black87),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("分类", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        backgroundColor: Colors.white,
        elevation: 0.5,//阴影高度
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(52),//搜索栏高度为52px
          child: _buildSearchBar(),
        ),
      ),
      body: Row(
        children: [
          _buildLeftCategory(),
          _buildRightContent(),
        ],
      ),
    );
  }
}
