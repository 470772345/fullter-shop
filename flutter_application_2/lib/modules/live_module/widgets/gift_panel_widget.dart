import 'package:flutter/material.dart';
import '../models/gift_item.dart';

class GiftPanel extends StatefulWidget {
  final List<GiftItem> gifts;
  final void Function(GiftItem) onSend;

  const GiftPanel({Key? key, required this.gifts, required this.onSend}) : super(key: key);

  @override
  State<GiftPanel> createState() => _GiftPanelState();
}

class _GiftPanelState extends State<GiftPanel> with SingleTickerProviderStateMixin {
  int selectedIndex = 0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 1, vsync: this); // 只做推荐Tab，可扩展
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF181A23),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.only(top: 12, left: 12, right: 12, bottom: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 4,
            width: 40,
            margin: EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          TabBar(
            controller: _tabController,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white54,
            indicatorColor: Colors.pink,
            tabs: [Tab(text: '推荐')],
          ),
          SizedBox(
            height: 220,
            child: TabBarView(
              controller: _tabController,
              children: [
                GridView.builder(
                  padding: EdgeInsets.only(top: 12),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: widget.gifts.length,
                  itemBuilder: (context, i) {
                    final gift = widget.gifts[i];
                    final selected = i == selectedIndex;
                    return GestureDetector(
                      onTap: () => setState(() => selectedIndex = i),
                      child: Container(
                        decoration: BoxDecoration(
                          color: selected ? Colors.white10 : Colors.transparent,
                          borderRadius: BorderRadius.circular(16),
                          border: selected ? Border.all(color: Colors.pink, width: 2) : null,
                        ),
                        padding: EdgeInsets.all(6),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Stack(
                              children: [
                                Image.asset(gift.imageUrl, width: 48, height: 48),
                                if (gift.tag != null)
                                  Positioned(
                                    top: 0,
                                    left: 0,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: Colors.orange,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(gift.tag!, style: TextStyle(fontSize: 10, color: Colors.white)),
                                    ),
                                  ),
                              ],
                            ),
                            SizedBox(height: 6),
                            Text(gift.name, style: TextStyle(color: Colors.white, fontSize: 13)),
                            SizedBox(height: 2),
                            Text('${gift.price} 钻', style: TextStyle(color: Colors.amber, fontSize: 12)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    padding: EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () {
                    widget.onSend(widget.gifts[selectedIndex]);
                  },
                  child: Text('赠送', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}