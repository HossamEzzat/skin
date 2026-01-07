import '../domain/entities/disease_entity.dart';

final List<DiseaseEntity> skinDiseases = [
  const DiseaseEntity(
    id: "1",
    name: "Acne (Acne Vulgaris)",
    scientificName: "Acne Vulgaris",
    overview:
        "Acne is most common in teenagers and young adults. Symptoms range from uninflamed blackheads to pus-filled pimples or large, red and tender bumps. Treatments include over-the-counter creams and cleanser, as well as prescription antibiotics.",
    treatment:
        "Treatments include over-the-counter creams and cleanser, as well as prescription antibiotics.",
    mainImage:
        "https://images.unsplash.com/photo-1616391182219-e080b4d1043a?w=400&h=400&fit=crop",
    scannedImage:
        "https://images.unsplash.com/photo-1579154204601-01588f351e67?w=400&h=400&fit=crop",
    medications: [
      MedicationEntity(
        id: "m1",
        name: "Murad acne control body wash",
        image:
            "https://images.unsplash.com/photo-1556228578-0d85b1a4d571?w=300&h=300&fit=crop",
      ),
      MedicationEntity(
        id: "m2",
        name: "Acne proofing gel cleanser",
        image:
            "https://images.unsplash.com/photo-1620916566398-39f1143ab7be?w=300&h=300&fit=crop",
      ),
      MedicationEntity(
        id: "m3",
        name: "Acne cleanser",
        image:
            "https://images.unsplash.com/photo-1608571423902-eed4a5ad8108?w=300&h=300&fit=crop",
      ),
    ],
  ),
  const DiseaseEntity(
    id: "2",
    name: "Baby Acne",
    scientificName: "Erythema Toxicum Neonatorum",
    overview:
        "Babies can develop blemishes on their face that looks exactly like acne. It's usually temporary and clears up on its own.",
    treatment:
        "Most cases clear up without treatment. Keep the skin clean and dry.",
    mainImage:
        "https://images.unsplash.com/photo-1555252333-9f8e92e65df9?w=400&h=400&fit=crop",
    scannedImage:
        "https://images.unsplash.com/photo-1631815588090-d4bfec5b1ccb?w=400&h=400&fit=crop",
    medications: [],
  ),
  const DiseaseEntity(
    id: "3",
    name: "Acne Excoriée",
    scientificName: "Picker's Acne",
    overview:
        "Acne excoriée, also known as 'picker's acne,' results when acne lesions are picked at or squeezed, leading to scarring.",
    treatment:
        "Management often involves addressing both the acne and the picking behavior.",
    mainImage:
        "https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?w=400&h=400&fit=crop",
    scannedImage:
        "https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?w=400&h=400&fit=crop",
    medications: [],
  ),
  const DiseaseEntity(
    id: "4",
    name: "Acne Keloidalis Nuchae",
    scientificName: "Folliculitis Keloidalis",
    overview:
        "Acne keloidalis nuchae, also known as keloidal folliculitis or nuchal keloidal acne, is a chronic skin condition.",
    treatment: "Includes topical steroids, antibiotics, and laser therapy.",
    mainImage:
        "https://images.unsplash.com/photo-1559757175-5700dde675bc?w=400&h=400&fit=crop",
    scannedImage:
        "https://images.unsplash.com/photo-1576091160550-2173dba999ef?w=400&h=400&fit=crop",
    medications: [],
  ),
  const DiseaseEntity(
    id: "5",
    name: "Closed Comedones Acne",
    scientificName: "Whiteheads",
    overview:
        "Closed comedones, whiteheads are one of the most typical forms of acne. They occur when pores are clogged.",
    treatment: "Topical retinoids and salicylic acid are common treatments.",
    mainImage:
        "https://images.unsplash.com/photo-1616391182219-e080b4d1043a?w=400&h=400&fit=crop",
    scannedImage:
        "https://images.unsplash.com/photo-1559757148-5c350d0d3c56?w=400&h=400&fit=crop",
    medications: [],
  ),
  const DiseaseEntity(
    id: "6",
    name: "Open Comedones Acne",
    scientificName: "Blackheads",
    overview:
        "Blackheads get their name because they appear as dark spots in your pores. They are caused by oxidized oil.",
    treatment:
        "Regular cleansing and exfoliation help prevent and treat blackheads.",
    mainImage:
        "https://images.unsplash.com/photo-1570554886111-e80fcca6a029?w=400&h=400&fit=crop",
    scannedImage:
        "https://images.unsplash.com/photo-1576091160399-112ba8d25d1d?w=400&h=400&fit=crop",
    medications: [],
  ),
  const DiseaseEntity(
    id: "7",
    name: "Pustules Acne",
    scientificName: "Pustular Acne",
    overview:
        "Pustules are characteristically red, tender bumps with white or yellow centers. They contain pus.",
    treatment:
        "Often requires topical or oral antibiotics to reduce inflammation.",
    mainImage:
        "https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?w=400&h=400&fit=crop",
    scannedImage:
        "https://images.unsplash.com/photo-1559757175-0eb30cd8c063?w=400&h=400&fit=crop",
    medications: [],
  ),
];
