import 'package:flutter/material.dart';
import 'package:restaurant_application/models/menu_item.dart';
import 'package:restaurant_application/widgets/menu_item_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<MenuItem> cartItems = []; // Initialize an empty list for cart items
  double totalPrice = 0.0; // Initialize total price

  final List<MenuItem> menuItems = [
    // Refreshing beverages:
    MenuItem(
      name: 'Iced Tea',
      description:
          'Refreshing brewed tea, chilled and sweetened to perfection.',
      price: 2.99,
      imageUrl: 'assets/images/iced_tea.jpg', // Use "assets/images" for clarity
    ),
    MenuItem(
      name: 'Lemonade',
      description:
          'Tangy and zesty homemade lemonade with a hint of sweetness.',
      price: 3.25,
      imageUrl: 'assets/images/lemonade.jpg',
    ),

// Appetizers:
    MenuItem(
      name: 'Mozzarella Sticks',
      description:
          'Crispy, golden-fried mozzarella sticks served with marinara sauce.',
      price: 6.99,
      imageUrl: 'assets/images/mozzarella_sticks.jpg',
    ),
    MenuItem(
      name: 'Chicken Tenders',
      description: 'Juicy chicken tenders, hand-breaded and perfectly fried.',
      price: 7.49,
      imageUrl: 'assets/images/chicken_tenders.jpg',
    ),

// Salads:
    MenuItem(
      name: 'Caesar Salad',
      description:
          'Crisp romaine lettuce, Parmesan cheese, croutons, and creamy Caesar dressing.',
      price: 8.99,
      imageUrl: 'assets/images/caesar_salad.jpg',
    ),
    MenuItem(
      name: 'Greek Salad',
      description:
          'Fresh tomatoes, cucumbers, olives, feta cheese, and red onion with a tangy vinaigrette.',
      price: 9.49,
      imageUrl: 'assets/images/greek_salad.jpg',
    ),

// Main courses:
    MenuItem(
      name: 'Pasta Carbonara',
      description:
          'Creamy pasta with pancetta, eggs, Parmesan cheese, and black pepper.',
      price: 12.99,
      imageUrl: 'assets/images/pasta.jpeg',
    ),
    MenuItem(
      name: 'Grilled Salmon',
      description:
          'Fresh Atlantic salmon grilled to perfection, served with your choice of side.',
      price: 15.99,
      imageUrl: 'assets/images/grilled_salmon.jpg',
    ),

// Desserts:
    MenuItem(
      name: 'Chocolate Cake',
      description: 'Rich and decadent chocolate cake with chocolate frosting.',
      price: 5.99,
      imageUrl: 'assets/images/chocolate_cake.jpg',
    ),
    MenuItem(
      name: 'Cheesecake',
      description:
          'Creamy vanilla cheesecake with a buttery graham cracker crust.',
      price: 6.49,
      imageUrl: 'assets/images/cheese_cake.jpg',
    ),
  ];

  void removeFromCart(MenuItem item) {
    setState(() {
      cartItems.remove(item);
      totalPrice =
          cartItems.fold(0.0, (prevTotal, item) => prevTotal + item.price);
    });
  }

  void clearCart() {
    setState(() {
      cartItems.clear();
      totalPrice = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurant App'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text(
                      'Our Menu',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: menuItems.length,
                      itemBuilder: (context, index) {
                        final menuItem = menuItems[index];
                        return Column(
                          children: [
                            MenuItemCard(
                              menuItem: menuItem,
                              onTap: () {
                                setState(() {
                                  cartItems.add(menuItem);
                                  totalPrice += menuItem.price;
                                });
                              },
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () => removeFromCart(menuItem),
                                  child: const Text('Remove'),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          _buildCart(),
        ],
      ),
    );
  }

  Widget _buildCart() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Text(
            'Total: \$${totalPrice.toStringAsFixed(2)}',
            style: const TextStyle(fontSize: 20.0),
          ),
          if (cartItems.isNotEmpty)
            ...cartItems.map(
              (item) => ListTile(
                title: Text(item.name),
                trailing: TextButton(
                  onPressed: () => removeFromCart(item),
                  child: const Text('Remove'),
                ),
              ),
            ),
          TextButton(
            onPressed: clearCart,
            child: const Text('Clear Cart'),
          ),
        ],
      ),
    );
  }
}
