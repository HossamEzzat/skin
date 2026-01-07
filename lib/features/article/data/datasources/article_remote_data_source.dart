import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/article_model.dart';

abstract class ArticleRemoteDataSource {
  Future<List<ArticleModel>> getArticles();
}

class ArticleRemoteDataSourceImpl implements ArticleRemoteDataSource {
  final FirebaseFirestore firestore;

  ArticleRemoteDataSourceImpl({required this.firestore});

  static final List<ArticleModel> _mockArticles = [
    const ArticleModel(
      id: "art_1",
      title: "Melanoma Early Detection: The ABCDE Rule",
      description:
          "Learn how to spot potential skin cancer early by monitoring your moles using the clinically proven ABCDE rule.",
      content: """
# Understanding Melanoma
Melanoma is the most serious form of skin cancer. Early detection is critical for successful treatment.

## The ABCDE Rule
- **A is for Asymmetry**: One half of the mole does not match the other half.
- **B is for Border**: The edges are irregular, ragged, notched, or blurred.
- **C is for Color**: The color is not the same all over and may include shades of brown or black.
- **D is for Diameter**: The spot is larger than 6 millimeters across (about the size of a pencil eraser).
- **E is for Evolving**: The mole is changing in size, shape, or color.

If you notice any of these signs, use our AI Scanner and consult with a specialist immediately.
""",
      category: "Skin Cancer",
      authorName: "Clinical Team",
      image:
          "https://images.unsplash.com/photo-1579684385127-1ef15d508118?q=80&w=2080&auto=format&fit=crop",
      date: "Oct 12, 2023",
      duration: "4 min read",
      ingredients: [
        "Monthly Self-Exams",
        "Regular Screenings",
        "Sun Protection",
      ],
      likes: 1240,
    ),
    const ArticleModel(
      id: "art_2",
      title: "Burn Care: 1st vs 2nd Degree Guide",
      description:
          "Immediate actions and first aid tips for managing different degrees of burns at home and when to seek medical help.",
      content: """
# Immediate Burn First Aid
Knowing what to do in the first few minutes after a burn can significantly impact recovery.

## 1st Degree Burns
These affect only the outer layer of skin.
- **Symptoms**: Redness, minor swelling, pain.
- **Action**: Run cool (not cold) water over the area for 20 minutes. Apply aloe vera.

## 2nd Degree Burns
These involve both the outer and the second layer of skin.
- **Symptoms**: Blisters, deep redness, severe pain.
- **Action**: Do NOT pop blisters. Seek professional medical review. Use our Burn Scanner for initial guidance.
""",
      category: "Emergency Care",
      authorName: "Emergency Specialist",
      image:
          "https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?q=80&w=2060&auto=format&fit=crop",
      date: "Nov 05, 2023",
      duration: "5 min read",
      ingredients: ["Cool Water", "Sterile Bandage", "No Ice/Butter"],
      likes: 856,
    ),
    const ArticleModel(
      id: "art_3",
      title: "Daily SPF: The Ultimate Anti-Aging Secret",
      description:
          "Why sunscreen is your most powerful tool against premature aging, wrinkles, and skin damage.",
      content: """
# The Power of SPF
Sun damage is cumulative. 80% of visible skin aging is caused by UV exposure.

## Why SPF Every Day?
UV rays penetrate clouds and glass, meaning your skin is at risk even on rainy days or while indoors near windows.

## What to Look For:
- **Broad Spectrum**: Protects against both UVA (aging) and UVB (burning).
- **SPF 30 or higher**: Essential for adequate protection.
- **Reapplication**: Every 2 hours when outdoors.

Protecting your skin today saves your health tomorrow.
""",
      category: "Prevention",
      authorName: "Dermatology expert",
      image:
          "https://images.unsplash.com/photo-1556228578-0d85b1a4d571?q=80&w=1974&auto=format&fit=crop",
      date: "Dec 20, 2023",
      duration: "3 min read",
      ingredients: ["Mineral SPF", "Antioxidants", "Consistent Routine"],
      likes: 2100,
    ),
    const ArticleModel(
      id: "art_4",
      title: "Managing Psoriasis: Lifestyle and Tips",
      description:
          "Effective strategies to manage psoriasis flare-ups and improve skin comfort through diet and lifestyle changes.",
      content: """
# Living with Psoriasis
Psoriasis is more than just a skin condition; it's an immune system response.

## Key Management Tips:
- **Moisturize**: Keep skin hydrated to reduce itching and scaling.
- **Identify Triggers**: Stress, certain foods, and cold weather can trigger flares.
- **Healthy Diet**: Anti-inflammatory foods (fatty fish, leafy greens) can help manage symptoms from the inside out.

Consult with our specialists to create a personalized management plan.
""",
      category: "Skin Health",
      authorName: "Skin Specialist",
      image:
          "https://images.unsplash.com/photo-1512428559083-a401c107f7c4?q=80&w=2070&auto=format&fit=crop",
      date: "Jan 03, 2024",
      duration: "6 min read",
      ingredients: ["Moisturizers", "Stress Management", "Omega-3s"],
      likes: 932,
    ),
    const ArticleModel(
      id: "art_5",
      title: "Eczema and Diet: What to Eat",
      description:
          "Discover how your diet impacts eczema and which anti-inflammatory foods can help soothe your skin.",
      content: """
# Soothing Eczema from Within
While topical treatments are important, what you eat plays a significant role in skin inflammation.

## Anti-Inflammatory Foods:
- **Quercetin-rich foods**: Apples, blueberries, and spinach.
- **Probiotics**: Yogurt and fermented foods help balance gut health, which is linked to skin health.
- **Healthy Fats**: Walnuts and flaxseeds provide essential fatty acids.

Avoiding common triggers like dairy or gluten may also provide relief for some individuals.
""",
      category: "Nutrition",
      authorName: "Wellness Advisor",
      image:
          "https://images.unsplash.com/photo-1490818387583-1baba5e638af?q=80&w=2032&auto=format&fit=crop",
      date: "Jan 05, 2024",
      duration: "4 min read",
      ingredients: ["Gut-Skin Axis", "Probiotics", "Hydration"],
      likes: 1540,
    ),
  ];

  @override
  Future<List<ArticleModel>> getArticles() async {
    try {
      final snapshot = await firestore.collection('articles').get();
      final firestoreArticles = snapshot.docs
          .map((doc) => ArticleModel.fromFirestore(doc))
          .toList();

      // Combine and return
      return [..._mockArticles, ...firestoreArticles];
    } catch (e) {
      // Fallback to mock only if Firestore fails
      return _mockArticles;
    }
  }
}
