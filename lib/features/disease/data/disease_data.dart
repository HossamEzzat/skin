import '../domain/entities/disease_entity.dart';

final List<DiseaseEntity> skinDiseases = [
  const DiseaseEntity(
    id: "1",
    name: "Acne (Acne Vulgaris)",
    scientificName: "Acne Vulgaris",
    overview:
        "Acne is a common skin condition that happens when hair follicles under the skin become clogged. Sebum—oil that helps keep skin from drying out—and dead skin cells plug the pores, which leads to outbreaks of lesions, commonly called pimples or zits.",
    treatment:
        "Treatments include over-the-counter creams, salicylic acid, benzoyl peroxide, and prescription antibiotics or retinoids.",
    mainImage:
        "https://images.unsplash.com/photo-1616391182219-e080b4d1043a?w=400&h=400&fit=crop",
    scannedImage:
        "https://images.unsplash.com/photo-1579154204601-01588f351e67?w=400&h=400&fit=crop",
    medications: [
      MedicationEntity(
        id: "m1",
        name: "Salicylic Acid Cleanser",
        image:
            "https://images.unsplash.com/photo-1556228578-0d85b1a4d571?w=300&h=300&fit=crop",
      ),
      MedicationEntity(
        id: "m2",
        name: "Benzoyl Peroxide Gel",
        image:
            "https://images.unsplash.com/photo-1620916566398-39f1143ab7be?w=300&h=300&fit=crop",
      ),
    ],
  ),
  const DiseaseEntity(
    id: "2",
    name: "Eczema",
    scientificName: "Atopic Dermatitis",
    overview:
        "Eczema is a condition that causes the skin to become itchy, red, dry, and cracked. It is a chronic condition that tends to flare up periodically and can be accompanied by asthma or hay fever.",
    treatment:
        "Moisturizing daily, using topical corticosteroids, and avoiding triggers like harsh soaps or extreme temperatures.",
    mainImage:
        "https://images.unsplash.com/photo-1555252333-9f8e92e65df9?w=400&h=400&fit=crop",
    scannedImage:
        "https://images.unsplash.com/photo-1631815588090-d4bfec5b1ccb?w=400&h=400&fit=crop",
    medications: [
      MedicationEntity(
        id: "m3",
        name: "Hydrocortisone Cream",
        image:
            "https://images.unsplash.com/photo-1608571423902-eed4a5ad8108?w=300&h=300&fit=crop",
      ),
      MedicationEntity(
        id: "m4",
        name: "Hydrating Ointment",
        image:
            "https://images.unsplash.com/photo-1556228578-0d85b1a4d571?w=300&h=300&fit=crop",
      ),
    ],
  ),
  const DiseaseEntity(
    id: "3",
    name: "Melanoma",
    scientificName: "Malignant Melanoma",
    overview:
        "Melanoma is the most serious type of skin cancer. It develops in the cells (melanocytes) that produce melanin — the pigment that gives your skin its color.",
    treatment:
        "Treatment may involve surgery to remove the melanoma, immunotherapy, targeted therapy, radiation therapy, or chemotherapy.",
    mainImage:
        "https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?w=400&h=400&fit=crop",
    scannedImage:
        "https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?w=400&h=400&fit=crop",
    medications: [
      MedicationEntity(
        id: "m5",
        name: "Broad Spectrum SPF 50",
        image:
            "https://images.unsplash.com/photo-1620916566398-39f1143ab7be?w=300&h=300&fit=crop",
      ),
    ],
  ),
  const DiseaseEntity(
    id: "4",
    name: "Psoriasis",
    scientificName: "Psoriasis Vulgaris",
    overview:
        "Psoriasis is an immune-mediated disease that causes raised, red, scaly patches to appear on the skin. It typically affects the outside of the elbows, knees or scalp.",
    treatment:
        "Topical treatments (corticosteroids, vitamin D analogues), light therapy (phototherapy), and systemic medications for severe cases.",
    mainImage:
        "https://images.unsplash.com/photo-1559757175-5700dde675bc?w=400&h=400&fit=crop",
    scannedImage:
        "https://images.unsplash.com/photo-1576091160550-2173dba999ef?w=400&h=400&fit=crop",
    medications: [
      MedicationEntity(
        id: "m6",
        name: "Coal Tar Ointment",
        image:
            "https://images.unsplash.com/photo-1608571423902-eed4a5ad8108?w=300&h=300&fit=crop",
      ),
    ],
  ),
  const DiseaseEntity(
    id: "5",
    name: "Rosacea",
    scientificName: "Acne Rosacea",
    overview:
        "Rosacea is a common skin condition that causes blushing or flushing and visible blood vessels in your face. It may also produce small, pus-filled bumps.",
    treatment:
        "Topical drugs that reduce flushing, oral antibiotics for inflammation, and laser therapy.",
    mainImage:
        "https://images.unsplash.com/photo-1570554886111-e80fcca6a029?w=400&h=400&fit=crop",
    scannedImage:
        "https://images.unsplash.com/photo-1559757148-5c350d0d3c56?w=400&h=400&fit=crop",
    medications: [
      MedicationEntity(
        id: "m7",
        name: "Azelaic Acid Gel",
        image:
            "https://images.unsplash.com/photo-1556228578-0d85b1a4d571?w=300&h=300&fit=crop",
      ),
    ],
  ),
  const DiseaseEntity(
    id: "6",
    name: "Vitiligo",
    scientificName: "Leukoderma",
    overview:
        "Vitiligo is a disease that causes loss of skin color in patches. The discolored areas usually get bigger with time. It can affect the skin on any part of the body.",
    treatment:
        "There is no cure, but treatments like light therapy, corticosteroid creams, and depigmentation can help restore or even out skin tone.",
    mainImage:
        "https://images.unsplash.com/photo-1616391182219-e080b4d1043a?w=400&h=400&fit=crop",
    scannedImage:
        "https://images.unsplash.com/photo-1576091160399-112ba8d25d1d?w=400&h=400&fit=crop",
    medications: [
      MedicationEntity(
        id: "m8",
        name: "Tacrolimus Ointment",
        image:
            "https://images.unsplash.com/photo-1620916566398-39f1143ab7be?w=300&h=300&fit=crop",
      ),
    ],
  ),
  const DiseaseEntity(
    id: "7",
    name: "Warts",
    scientificName: "Verruca Vulgaris",
    overview:
        "Warts are small, rough, and hard growths that are similar in color to the rest of the skin. They are caused by infection with a type of human papillomavirus (HPV).",
    treatment:
        "Most resolve on their own, but can be treated with salicylic acid peeling medicine, cryotherapy (freezing), or laser treatment.",
    mainImage:
        "https://images.unsplash.com/photo-1555252333-9f8e92e65df9?w=400&h=400&fit=crop",
    scannedImage:
        "https://images.unsplash.com/photo-1559757175-0eb30cd8c063?w=400&h=400&fit=crop",
    medications: [
      MedicationEntity(
        id: "m9",
        name: "Salicylic Acid Liquid",
        image:
            "https://images.unsplash.com/photo-1608571423902-eed4a5ad8108?w=300&h=300&fit=crop",
      ),
    ],
  ),
  const DiseaseEntity(
    id: "8",
    name: "Xanthelasma",
    scientificName: "Xanthelasma Palpebrarum",
    overview:
        "Xanthelasma refers to sharply demarcated yellowish collections of cholesterol underneath the skin, usually on or around the eyelids.",
    treatment:
        "Lipid-lowering diet, medication, laser ablation, or surgical excision.",
    mainImage:
        "https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?w=400&h=400&fit=crop",
    scannedImage:
        "https://images.unsplash.com/photo-1579154204601-01588f351e67?w=400&h=400&fit=crop",
    medications: [],
  ),
  const DiseaseEntity(
    id: "9",
    name: "Ringworm",
    scientificName: "Tinea Corporis",
    overview:
        "Ringworm is a common fungal skin infection that causes a red, itchy, circular rash. It's highly contagious but completely curable.",
    treatment:
        "Over-the-counter antifungal creams, lotions, or powders. Oral medication may be needed for severe cases.",
    mainImage:
        "https://images.unsplash.com/photo-1559757175-5700dde675bc?w=400&h=400&fit=crop",
    scannedImage:
        "https://images.unsplash.com/photo-1631815588090-d4bfec5b1ccb?w=400&h=400&fit=crop",
    medications: [
      MedicationEntity(
        id: "m10",
        name: "Clotrimazole Cream",
        image:
            "https://images.unsplash.com/photo-1556228578-0d85b1a4d571?w=300&h=300&fit=crop",
      ),
    ],
  ),
  const DiseaseEntity(
    id: "10",
    name: "Hives",
    scientificName: "Urticaria",
    overview:
        "Hives are red, itchy welts that result from a skin reaction. The welts vary in size and appear and fade repeatedly as the reaction runs its course.",
    treatment:
        "Antihistamines are the primary treatment. In severe cases, corticosteroids or epinephrine may be used.",
    mainImage:
        "https://images.unsplash.com/photo-1570554886111-e80fcca6a029?w=400&h=400&fit=crop",
    scannedImage:
        "https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?w=400&h=400&fit=crop",
    medications: [
      MedicationEntity(
        id: "m11",
        name: "Oral Antihistamine",
        image:
            "https://images.unsplash.com/photo-1620916566398-39f1143ab7be?w=300&h=300&fit=crop",
      ),
    ],
  ),
];
