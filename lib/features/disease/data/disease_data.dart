import '../domain/entities/disease_entity.dart';

final List<DiseaseEntity> skinDiseases = [
  const DiseaseEntity(
    id: "1",
    name: "Acne (Acne Vulgaris)",
    scientificName: "Acne Vulgaris",
    severity: "Mild–Moderate",
    isContagious: false,
    isChronic: false,
    overview:
        "Acne is a common inflammatory skin condition that occurs when hair follicles become clogged with oil (sebum) and dead skin cells. It predominantly affects areas with a high density of sebaceous glands, such as the face, chest, and back. Acne can range from mild comedonal acne to severe nodulocystic acne that causes permanent scarring.",
    treatment:
        "Mild acne responds well to over-the-counter topical agents such as salicylic acid and benzoyl peroxide. Moderate acne may require topical or oral antibiotics (doxycycline, clindamycin) combined with topical retinoids. Severe or refractory cases are treated with isotretinoin (oral retinoid), which offers long-term remission. Hormonal therapy (oral contraceptives, spironolactone) is effective in females with hormonally driven acne.",
    mainImage:
        "https://images.unsplash.com/photo-1616391182219-e080b4d1043a?w=400&h=400&fit=crop",
    scannedImage:
        "https://images.unsplash.com/photo-1579154204601-01588f351e67?w=400&h=400&fit=crop",
    symptoms: [
      "Whiteheads (closed comedones)",
      "Blackheads (open comedones)",
      "Small red tender bumps (papules)",
      "Pus-filled lesions (pustules)",
      "Large solid painful lumps (nodules)",
      "Cystic lesions causing scarring",
      "Oily skin texture",
      "Post-inflammatory hyperpigmentation",
    ],
    riskFactors: [
      "Hormonal fluctuations (puberty, menstruation, pregnancy)",
      "Family history of acne",
      "Certain medications (corticosteroids, lithium)",
      "High-glycemic diet and dairy consumption",
      "Psychological stress",
      "Cosmetics that block pores (comedogenic products)",
      "Excessive sweating",
    ],
    affectedAreas: ["Face", "Back", "Chest", "Shoulders", "Neck"],
    medications: [
      MedicationEntity(
        id: "m1",
        name: "Salicylic Acid Cleanser",
        description:
            "Beta-hydroxy acid that exfoliates inside pores and reduces inflammation.",
        image:
            "https://images.unsplash.com/photo-1556228578-0d85b1a4d571?w=300&h=300&fit=crop",
      ),
      MedicationEntity(
        id: "m2",
        name: "Benzoyl Peroxide Gel",
        description: "Kills acne-causing bacteria and helps clear pores.",
        image:
            "https://images.unsplash.com/photo-1620916566398-39f1143ab7be?w=300&h=300&fit=crop",
      ),
      MedicationEntity(
        id: "m3",
        name: "Tretinoin Cream (0.025–0.1%)",
        description:
            "Topical retinoid that accelerates cell turnover and prevents clogged pores.",
        image:
            "https://images.unsplash.com/photo-1608571423902-eed4a5ad8108?w=300&h=300&fit=crop",
      ),
      MedicationEntity(
        id: "m4",
        name: "Doxycycline (Oral Antibiotic)",
        description: "Reduces acne-related inflammation and bacterial load.",
        image:
            "https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?w=300&h=300&fit=crop",
      ),
      MedicationEntity(
        id: "m5",
        name: "Clindamycin Gel (Topical)",
        description: "Topical antibiotic effective against P. acnes bacteria.",
        image:
            "https://images.unsplash.com/photo-1556228578-0d85b1a4d571?w=300&h=300&fit=crop",
      ),
      MedicationEntity(
        id: "m6",
        name: "Adapalene Gel",
        description:
            "Third-generation topical retinoid available over the counter.",
        image:
            "https://images.unsplash.com/photo-1620916566398-39f1143ab7be?w=300&h=300&fit=crop",
      ),
    ],
  ),

  const DiseaseEntity(
    id: "2",
    name: "Eczema",
    scientificName: "Atopic Dermatitis",
    severity: "Mild–Severe",
    isContagious: false,
    isChronic: true,
    overview:
        "Eczema (atopic dermatitis) is a chronic, relapsing inflammatory skin disorder characterized by intense pruritus (itching) and a disrupted skin barrier. It is strongly associated with other atopic diseases including asthma and allergic rhinitis. The condition results from a combination of genetic susceptibility, immune dysregulation, and environmental triggers.",
    treatment:
        "Daily moisturizing with emollients is the cornerstone of management. Acute flares are treated with topical corticosteroids (mild to potent depending on body site). Topical calcineurin inhibitors (tacrolimus, pimecrolimus) are steroid-sparing alternatives. Severe refractory eczema may require systemic agents such as dupilumab (biologic), cyclosporine, or methotrexate. Antihistamines may reduce itch-related sleep disruption.",
    mainImage:
        "https://images.unsplash.com/photo-1555252333-9f8e92e65df9?w=400&h=400&fit=crop",
    scannedImage:
        "https://images.unsplash.com/photo-1631815588090-d4bfec5b1ccb?w=400&h=400&fit=crop",
    symptoms: [
      "Intense pruritus (often worse at night)",
      "Dry, sensitive skin",
      "Red or brownish-gray inflamed patches",
      "Small raised bumps that may weep fluid",
      "Thickened, cracked, or scaly skin (lichenification)",
      "Raw, swollen skin from scratching",
      "Skin discoloration after healing",
    ],
    riskFactors: [
      "Personal or family history of atopic disease",
      "Genetic filaggrin (FLG) gene mutations",
      "Urban living and air pollution",
      "Early exposure to antibiotics",
      "Low humidity and cold climates",
      "Exposure to allergens (dust mites, pet dander)",
      "Harsh detergents and soaps",
    ],
    affectedAreas: [
      "Elbow creases",
      "Knee creases",
      "Neck",
      "Face",
      "Wrists",
      "Hands",
      "Ankles",
    ],
    medications: [
      MedicationEntity(
        id: "m7",
        name: "Hydrocortisone Cream (1%)",
        description:
            "Mild topical corticosteroid for face and sensitive areas.",
        image:
            "https://images.unsplash.com/photo-1608571423902-eed4a5ad8108?w=300&h=300&fit=crop",
      ),
      MedicationEntity(
        id: "m8",
        name: "Betamethasone Valerate Cream",
        description:
            "Potent topical steroid for resistant flares on body skin.",
        image:
            "https://images.unsplash.com/photo-1556228578-0d85b1a4d571?w=300&h=300&fit=crop",
      ),
      MedicationEntity(
        id: "m9",
        name: "Tacrolimus Ointment (0.03% / 0.1%)",
        description:
            "Topical calcineurin inhibitor; steroid-free, safe for face and long-term use.",
        image:
            "https://images.unsplash.com/photo-1620916566398-39f1143ab7be?w=300&h=300&fit=crop",
      ),
      MedicationEntity(
        id: "m10",
        name: "Dupilumab Injection (Dupixent)",
        description:
            "Biologic that blocks IL-4 and IL-13 signaling; for moderate-to-severe cases.",
        image:
            "https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?w=300&h=300&fit=crop",
      ),
      MedicationEntity(
        id: "m11",
        name: "Emollient / Hydrating Ointment",
        description:
            "Daily moisturizer to restore and maintain the skin barrier.",
        image:
            "https://images.unsplash.com/photo-1556228578-0d85b1a4d571?w=300&h=300&fit=crop",
      ),
      MedicationEntity(
        id: "m12",
        name: "Cetirizine (Oral Antihistamine)",
        description: "Reduces itch-related sleep disturbance.",
        image:
            "https://images.unsplash.com/photo-1608571423902-eed4a5ad8108?w=300&h=300&fit=crop",
      ),
    ],
  ),

  const DiseaseEntity(
    id: "3",
    name: "Melanoma",
    scientificName: "Malignant Melanoma",
    severity: "Severe (Potentially Life-Threatening)",
    isContagious: false,
    isChronic: false,
    overview:
        "Melanoma is the most dangerous form of skin cancer, arising from the malignant transformation of melanocytes. While less common than basal cell or squamous cell carcinoma, it accounts for the majority of skin cancer deaths due to its high metastatic potential. Early detection using the ABCDE criteria (Asymmetry, Border, Color, Diameter, Evolution) is critical for favorable outcomes.",
    treatment:
        "Localized melanoma is treated with wide local excision with sentinel lymph node biopsy. Advanced or metastatic melanoma is managed with immune checkpoint inhibitors (pembrolizumab, nivolumab, ipilimumab) and BRAF/MEK-targeted therapy (vemurafenib + cobimetinib, dabrafenib + trametinib) for tumors harboring BRAF V600E mutations. Radiation therapy and chemotherapy are adjuncts in select cases. Lifelong sun protection and surveillance are mandatory.",
    mainImage:
        "https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?w=400&h=400&fit=crop",
    scannedImage:
        "https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?w=400&h=400&fit=crop",
    symptoms: [
      "Asymmetric mole or lesion",
      "Irregular, notched, or blurred border",
      "Multiple colors within one lesion (tan, brown, black, red, white, blue)",
      "Diameter larger than 6mm",
      "Evolving size, shape, or color over weeks",
      "Bleeding or ulceration of a mole",
      "Satellite lesions around a primary mole",
    ],
    riskFactors: [
      "Cumulative UV radiation exposure",
      "History of blistering sunburns",
      "Fair skin, light hair, and light eyes",
      "Multiple (>50) or atypical (dysplastic) nevi",
      "Personal or family history of melanoma",
      "Immunosuppression (organ transplant, HIV)",
      "BRAF or CDKN2A gene mutations",
      "Tanning bed use",
    ],
    affectedAreas: [
      "Back",
      "Legs",
      "Arms",
      "Face",
      "Neck",
      "Scalp",
      "Under nails (subungual)",
      "Mucous membranes (rare)",
    ],
    medications: [
      MedicationEntity(
        id: "m13",
        name: "Pembrolizumab (Keytruda)",
        description:
            "Anti-PD-1 immune checkpoint inhibitor; first-line for advanced melanoma.",
        image:
            "https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?w=300&h=300&fit=crop",
      ),
      MedicationEntity(
        id: "m14",
        name: "Nivolumab (Opdivo)",
        description:
            "Anti-PD-1 monoclonal antibody used in adjuvant and metastatic settings.",
        image:
            "https://images.unsplash.com/photo-1620916566398-39f1143ab7be?w=300&h=300&fit=crop",
      ),
      MedicationEntity(
        id: "m15",
        name: "Vemurafenib (Zelboraf)",
        description:
            "BRAF inhibitor for BRAF V600E mutation-positive melanoma.",
        image:
            "https://images.unsplash.com/photo-1608571423902-eed4a5ad8108?w=300&h=300&fit=crop",
      ),
      MedicationEntity(
        id: "m16",
        name: "Dabrafenib + Trametinib",
        description:
            "Combined BRAF/MEK inhibitor regimen for advanced BRAF-mutant melanoma.",
        image:
            "https://images.unsplash.com/photo-1556228578-0d85b1a4d571?w=300&h=300&fit=crop",
      ),
      MedicationEntity(
        id: "m17",
        name: "Ipilimumab (Yervoy)",
        description:
            "Anti-CTLA-4 antibody; often combined with nivolumab for metastatic disease.",
        image:
            "https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?w=300&h=300&fit=crop",
      ),
      MedicationEntity(
        id: "m18",
        name: "Broad Spectrum SPF 50+ Sunscreen",
        description:
            "Essential for prevention and post-treatment skin protection.",
        image:
            "https://images.unsplash.com/photo-1620916566398-39f1143ab7be?w=300&h=300&fit=crop",
      ),
    ],
  ),

  const DiseaseEntity(
    id: "4",
    name: "Psoriasis",
    scientificName: "Psoriasis Vulgaris",
    severity: "Moderate–Severe",
    isContagious: false,
    isChronic: true,
    overview:
        "Psoriasis is a chronic immune-mediated inflammatory skin disease characterized by rapid turnover of skin cells (every 3–5 days instead of the usual 28–30 days), resulting in thick, silvery-scaled plaques on red inflamed skin. It can also involve joints (psoriatic arthritis), nails, and carry significant psychosocial burden. Triggers include stress, infections, and certain medications.",
    treatment:
        "Mild psoriasis is managed with topical corticosteroids, vitamin D analogues (calcipotriol), coal tar preparations, and salicylic acid. Moderate-to-severe disease benefits from narrowband UVB phototherapy. Systemic therapies include methotrexate, acitretin, and cyclosporine. Biologic agents targeting TNF-α (adalimumab, etanercept), IL-17 (secukinumab, ixekizumab), and IL-23 (guselkumab, risankizumab) represent the standard of care for severe plaque psoriasis.",
    mainImage:
        "https://images.unsplash.com/photo-1559757175-5700dde675bc?w=400&h=400&fit=crop",
    scannedImage:
        "https://images.unsplash.com/photo-1576091160550-2173dba999ef?w=400&h=400&fit=crop",
    symptoms: [
      "Red, raised plaques covered with silvery-white scales",
      "Dry or cracked skin that may bleed",
      "Intense itching, burning, or soreness",
      "Thickened, pitted, or ridged nails",
      "Swollen and stiff joints (psoriatic arthritis)",
      "Köbner phenomenon (lesions at sites of trauma)",
      "Auspitz sign (pinpoint bleeding when scales removed)",
    ],
    riskFactors: [
      "Family history of psoriasis",
      "Psychological stress (triggers flares)",
      "Streptococcal throat infection",
      "Smoking and alcohol use",
      "Obesity",
      "HIV infection",
      "Certain medications (lithium, beta-blockers, antimalarials)",
    ],
    affectedAreas: [
      "Scalp",
      "Elbows",
      "Knees",
      "Lower back",
      "Nails",
      "Palms and soles",
      "Genitalia (inverse psoriasis)",
    ],
    medications: [
      MedicationEntity(
        id: "m19",
        name: "Coal Tar Ointment",
        description:
            "Reduces scaling, itching, and inflammation; suitable for scalp and body.",
        image:
            "https://images.unsplash.com/photo-1608571423902-eed4a5ad8108?w=300&h=300&fit=crop",
      ),
      MedicationEntity(
        id: "m20",
        name: "Calcipotriol Cream (Vitamin D analogue)",
        description:
            "Slows skin cell production; used alone or combined with steroids.",
        image:
            "https://images.unsplash.com/photo-1556228578-0d85b1a4d571?w=300&h=300&fit=crop",
      ),
      MedicationEntity(
        id: "m21",
        name: "Betamethasone Dipropionate",
        description: "Potent topical corticosteroid for plaque psoriasis.",
        image:
            "https://images.unsplash.com/photo-1620916566398-39f1143ab7be?w=300&h=300&fit=crop",
      ),
      MedicationEntity(
        id: "m22",
        name: "Methotrexate (Oral / Injectable)",
        description: "Immunosuppressant that slows rapid skin cell production.",
        image:
            "https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?w=300&h=300&fit=crop",
      ),
      MedicationEntity(
        id: "m23",
        name: "Adalimumab (Humira)",
        description:
            "Anti-TNF-α biologic; first-line biologic for moderate-to-severe psoriasis.",
        image:
            "https://images.unsplash.com/photo-1608571423902-eed4a5ad8108?w=300&h=300&fit=crop",
      ),
      MedicationEntity(
        id: "m24",
        name: "Secukinumab (Cosentyx)",
        description: "IL-17A inhibitor biologic offering rapid skin clearance.",
        image:
            "https://images.unsplash.com/photo-1556228578-0d85b1a4d571?w=300&h=300&fit=crop",
      ),
    ],
  ),

  const DiseaseEntity(
    id: "5",
    name: "Rosacea",
    scientificName: "Acne Rosacea",
    severity: "Mild–Moderate",
    isContagious: false,
    isChronic: true,
    overview:
        "Rosacea is a chronic inflammatory vascular skin disorder primarily affecting the central face. It is characterized by recurrent episodes of flushing, persistent erythema (redness), telangiectasias (dilated blood vessels), and in some subtypes, papulopustular lesions resembling acne. Advanced untreated cases may cause rhinophyma (thickening of nose skin) and ocular involvement.",
    treatment:
        "Trigger avoidance (sun, alcohol, spicy foods, hot beverages) is fundamental. Topical therapies include metronidazole, azelaic acid, and ivermectin (for the papulopustular subtype). Brimonidine and oxymetazoline are α-adrenergic agonists used to reduce persistent redness. Oral doxycycline (sub-antimicrobial 40mg formulation) addresses inflammation. Vascular laser and intense pulsed light (IPL) therapy treat telangiectasias and flushing effectively.",
    mainImage:
        "https://images.unsplash.com/photo-1570554886111-e80fcca6a029?w=400&h=400&fit=crop",
    scannedImage:
        "https://images.unsplash.com/photo-1559757148-5c350d0d3c56?w=400&h=400&fit=crop",
    symptoms: [
      "Facial flushing (transient redness episodes)",
      "Persistent central facial erythema",
      "Visible blood vessels (telangiectasias)",
      "Acne-like papules and pustules",
      "Burning or stinging sensation",
      "Ocular irritation and redness (ocular rosacea)",
      "Skin thickening especially on nose (rhinophyma)",
    ],
    riskFactors: [
      "Fair skin, blue eyes, and Celtic ancestry",
      "Age 30–60 years",
      "Female sex (although rhinophyma more common in males)",
      "Family history of rosacea",
      "UV radiation exposure",
      "Demodex folliculorum mite overgrowth",
      "H. pylori infection (associated in some cases)",
    ],
    affectedAreas: [
      "Central cheeks",
      "Nose",
      "Forehead",
      "Chin",
      "Eyes (ocular rosacea)",
    ],
    medications: [
      MedicationEntity(
        id: "m25",
        name: "Azelaic Acid Gel / Foam (15%)",
        description:
            "Reduces papules, pustules, and redness with anti-inflammatory action.",
        image:
            "https://images.unsplash.com/photo-1556228578-0d85b1a4d571?w=300&h=300&fit=crop",
      ),
      MedicationEntity(
        id: "m26",
        name: "Metronidazole Cream / Gel (0.75–1%)",
        description: "First-line topical for papulopustular rosacea.",
        image:
            "https://images.unsplash.com/photo-1620916566398-39f1143ab7be?w=300&h=300&fit=crop",
      ),
      MedicationEntity(
        id: "m27",
        name: "Ivermectin Cream (Soolantra 1%)",
        description:
            "Targets Demodex mites; effective for inflammatory rosacea.",
        image:
            "https://images.unsplash.com/photo-1608571423902-eed4a5ad8108?w=300&h=300&fit=crop",
      ),
      MedicationEntity(
        id: "m28",
        name: "Brimonidine Gel (Mirvaso 0.33%)",
        description:
            "Alpha-adrenergic agonist that constricts blood vessels to reduce redness.",
        image:
            "https://images.unsplash.com/photo-1556228578-0d85b1a4d571?w=300&h=300&fit=crop",
      ),
      MedicationEntity(
        id: "m29",
        name: "Doxycycline 40mg Modified-Release",
        description:
            "Sub-antimicrobial dose used for its anti-inflammatory effect.",
        image:
            "https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?w=300&h=300&fit=crop",
      ),
      MedicationEntity(
        id: "m30",
        name: "Oxymetazoline Cream (Rhofade 1%)",
        description:
            "Vasoconstrictor approved specifically for persistent facial erythema.",
        image:
            "https://images.unsplash.com/photo-1620916566398-39f1143ab7be?w=300&h=300&fit=crop",
      ),
    ],
  ),

  const DiseaseEntity(
    id: "6",
    name: "Vitiligo",
    scientificName: "Leukoderma",
    severity: "Mild–Moderate",
    isContagious: false,
    isChronic: true,
    overview:
        "Vitiligo is an acquired autoimmune disorder in which melanocytes are selectively destroyed, resulting in depigmented macules and patches on the skin, mucous membranes, and hair. It affects approximately 1–2% of the global population irrespective of ethnicity. Although not physically harmful, it carries substantial psychosocial impact, particularly in individuals with darker skin tones.",
    treatment:
        "Topical therapies include potent corticosteroids and tacrolimus ointment for limited disease. Narrowband UVB (NB-UVB) phototherapy is the gold standard for widespread vitiligo, with 70–80% repigmentation achievable. The JAK inhibitor ruxolitinib (Opzelura) cream is a breakthrough approved therapy. For stable, limited disease, surgical options such as split-thickness skin grafting or suction blister epidermal grafting can be effective. Cosmetic camouflage improves quality of life.",
    mainImage:
        "https://images.unsplash.com/photo-1616391182219-e080b4d1043a?w=400&h=400&fit=crop",
    scannedImage:
        "https://images.unsplash.com/photo-1576091160399-112ba8d25d1d?w=400&h=400&fit=crop",
    symptoms: [
      "Depigmented (chalky-white) macules or patches",
      "Premature whitening of hair (leukotrichia)",
      "Loss of color inside mouth or nose",
      "Increased sun sensitivity in depigmented areas",
      "Koebner phenomenon (new patches at trauma sites)",
      "Halo nevi (white ring around a mole)",
    ],
    riskFactors: [
      "Autoimmune disorders (thyroid disease, type 1 diabetes)",
      "Family history of vitiligo",
      "Genetic variants in PTPN22 and NLRP1 genes",
      "Physical or psychological stress",
      "Chemical exposure (phenolic compounds)",
      "Inflammatory skin conditions",
    ],
    affectedAreas: [
      "Hands and wrists",
      "Face (perioral, periorbital)",
      "Neck",
      "Genitalia",
      "Skin folds (axillae, groin)",
      "Around body orifices",
    ],
    medications: [
      MedicationEntity(
        id: "m31",
        name: "Tacrolimus Ointment (0.1%)",
        description:
            "Topical immunomodulator; safe for face and long-term use.",
        image:
            "https://images.unsplash.com/photo-1620916566398-39f1143ab7be?w=300&h=300&fit=crop",
      ),
      MedicationEntity(
        id: "m32",
        name: "Mometasone Furoate Cream (0.1%)",
        description:
            "Potent topical corticosteroid to stimulate repigmentation.",
        image:
            "https://images.unsplash.com/photo-1608571423902-eed4a5ad8108?w=300&h=300&fit=crop",
      ),
      MedicationEntity(
        id: "m33",
        name: "Ruxolitinib Cream (Opzelura 1.5%)",
        description:
            "First FDA-approved topical JAK inhibitor for non-segmental vitiligo.",
        image:
            "https://images.unsplash.com/photo-1556228578-0d85b1a4d571?w=300&h=300&fit=crop",
      ),
      MedicationEntity(
        id: "m34",
        name: "Narrowband UVB Phototherapy",
        description:
            "Gold standard non-pharmacological treatment to induce repigmentation.",
        image:
            "https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?w=300&h=300&fit=crop",
      ),
      MedicationEntity(
        id: "m35",
        name: "Afamelanotide Implant",
        description:
            "Alpha-MSH analogue used in combination with NB-UVB for enhanced repigmentation.",
        image:
            "https://images.unsplash.com/photo-1620916566398-39f1143ab7be?w=300&h=300&fit=crop",
      ),
      MedicationEntity(
        id: "m36",
        name: "Dermablend / Covermark Camouflage",
        description:
            "Medical-grade cosmetic cover-up for psychosocial quality of life.",
        image:
            "https://images.unsplash.com/photo-1556228578-0d85b1a4d571?w=300&h=300&fit=crop",
      ),
    ],
  ),

  const DiseaseEntity(
    id: "7",
    name: "Warts",
    scientificName: "Verruca Vulgaris",
    severity: "Mild",
    isContagious: true,
    isChronic: false,
    overview:
        "Warts are benign epidermal proliferations caused by infection with human papillomavirus (HPV), most commonly HPV types 1, 2, 4, and 27. They are spread by direct skin contact or contact with contaminated surfaces. Common warts (verruca vulgaris) are rough, hyperkeratotic papules, while plantar warts on the soles may cause significant pain. Most spontaneously resolve in 2 years in immunocompetent individuals.",
    treatment:
        "First-line treatment is topical salicylic acid (daily application after paring). Cryotherapy with liquid nitrogen is the most commonly used clinician-administered treatment. Other options include cantharidin, intralesional bleomycin, immunotherapy (imiquimod, diphencyprone), laser ablation, and surgical curettage. HPV vaccines offer prevention against genital wart strains.",
    mainImage:
        "https://images.unsplash.com/photo-1555252333-9f8e92e65df9?w=400&h=400&fit=crop",
    scannedImage:
        "https://images.unsplash.com/photo-1559757175-0eb30cd8c063?w=400&h=400&fit=crop",
    symptoms: [
      "Rough, grainy, flesh-colored skin growths",
      "Black pinpoint dots (thrombosed capillaries)",
      "Tenderness or pain when pressure applied (plantar)",
      "Cluster or mosaic formation",
      "Flat or slightly raised surface",
      "Loss of normal skin lines over the lesion",
    ],
    riskFactors: [
      "Direct contact with HPV-infected skin or surfaces",
      "Weakened immune system",
      "Broken or damaged skin (entry point for HPV)",
      "Public showers, pools, and locker rooms",
      "Childhood and adolescence",
      "Nail biting or cuticle picking",
    ],
    affectedAreas: [
      "Fingers and hands",
      "Feet (plantar surface)",
      "Knees and elbows",
      "Face",
      "Around nails (periungual)",
    ],
    medications: [
      MedicationEntity(
        id: "m37",
        name: "Salicylic Acid 15–40% Solution",
        description:
            "Keratolytic agent; daily application after soaking and paring.",
        image:
            "https://images.unsplash.com/photo-1608571423902-eed4a5ad8108?w=300&h=300&fit=crop",
      ),
      MedicationEntity(
        id: "m38",
        name: "Liquid Nitrogen Cryotherapy",
        description: "Destroys wart tissue through rapid freeze-thaw cycles.",
        image:
            "https://images.unsplash.com/photo-1556228578-0d85b1a4d571?w=300&h=300&fit=crop",
      ),
      MedicationEntity(
        id: "m39",
        name: "Cantharidin (Blistering Agent)",
        description:
            "Applied in clinic; causes a blister under the wart to lift it off.",
        image:
            "https://images.unsplash.com/photo-1620916566398-39f1143ab7be?w=300&h=300&fit=crop",
      ),
      MedicationEntity(
        id: "m40",
        name: "Imiquimod Cream (Aldara 5%)",
        description:
            "Topical immune response modifier; stimulates local immune clearance.",
        image:
            "https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?w=300&h=300&fit=crop",
      ),
      MedicationEntity(
        id: "m41",
        name: "Intralesional Bleomycin",
        description:
            "Anti-neoplastic antibiotic injected directly into resistant warts.",
        image:
            "https://images.unsplash.com/photo-1608571423902-eed4a5ad8108?w=300&h=300&fit=crop",
      ),
      MedicationEntity(
        id: "m42",
        name: "Podophyllin Resin (25%)",
        description:
            "Antimitotic plant extract applied to genital warts in clinic.",
        image:
            "https://images.unsplash.com/photo-1556228578-0d85b1a4d571?w=300&h=300&fit=crop",
      ),
    ],
  ),

  const DiseaseEntity(
    id: "8",
    name: "Xanthelasma",
    scientificName: "Xanthelasma Palpebrarum",
    severity: "Mild (Cosmetic / Cardiovascular Marker)",
    isContagious: false,
    isChronic: false,
    overview:
        "Xanthelasma palpebrarum is characterized by soft, sharply demarcated yellowish plaques of lipid deposits (cholesterol esters) that accumulate in the dermis of the periorbital skin. While benign and painless, it serves as an important clinical marker for dyslipidemia and cardiovascular disease risk, as approximately 50% of affected individuals have abnormal lipid profiles.",
    treatment:
        "Underlying dyslipidemia should be identified and treated with lipid-lowering agents (statins, fibrates). For the lesions themselves, treatment is primarily for cosmetic reasons and includes chemical peels with trichloroacetic acid (TCA), CO2 laser ablation, radiofrequency ablation, and surgical excision. Recurrence is common regardless of treatment modality.",
    mainImage:
        "https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?w=400&h=400&fit=crop",
    scannedImage:
        "https://images.unsplash.com/photo-1579154204601-01588f351e67?w=400&h=400&fit=crop",
    symptoms: [
      "Soft, flat, yellowish plaques on eyelids",
      "Waxy, lipid-rich deposits",
      "Bilateral and symmetrical distribution",
      "No pain, itching, or functional impairment",
      "Slow progressive enlargement",
    ],
    riskFactors: [
      "Familial hypercholesterolemia",
      "Elevated LDL cholesterol",
      "Low HDL cholesterol",
      "Type 2 diabetes mellitus",
      "Obesity and metabolic syndrome",
      "Liver disease (biliary cirrhosis)",
      "Hypothyroidism",
    ],
    affectedAreas: [
      "Upper inner eyelids",
      "Lower eyelids",
      "Inner canthal area (medial canthus)",
    ],
    medications: [
      MedicationEntity(
        id: "m43",
        name: "Atorvastatin (Statin Therapy)",
        description:
            "Lowers LDL cholesterol; treats underlying dyslipidemia to slow progression.",
        image:
            "https://images.unsplash.com/photo-1620916566398-39f1143ab7be?w=300&h=300&fit=crop",
      ),
      MedicationEntity(
        id: "m44",
        name: "Fenofibrate",
        description:
            "Fibrate lipid-lowering agent particularly effective at raising HDL.",
        image:
            "https://images.unsplash.com/photo-1608571423902-eed4a5ad8108?w=300&h=300&fit=crop",
      ),
      MedicationEntity(
        id: "m45",
        name: "TCA Chemical Peel (30–50%)",
        description:
            "Destroys xanthelasma tissue through controlled chemical burn.",
        image:
            "https://images.unsplash.com/photo-1556228578-0d85b1a4d571?w=300&h=300&fit=crop",
      ),
      MedicationEntity(
        id: "m46",
        name: "CO2 Laser Ablation",
        description: "Precise laser vaporization with minimal scarring.",
        image:
            "https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?w=300&h=300&fit=crop",
      ),
      MedicationEntity(
        id: "m47",
        name: "Surgical Excision",
        description: "Direct removal; reserved for larger plaques.",
        image:
            "https://images.unsplash.com/photo-1620916566398-39f1143ab7be?w=300&h=300&fit=crop",
      ),
    ],
  ),

  const DiseaseEntity(
    id: "9",
    name: "Ringworm",
    scientificName: "Tinea Corporis",
    severity: "Mild",
    isContagious: true,
    isChronic: false,
    overview:
        "Ringworm (tinea corporis) is a superficial fungal infection of the non-hairy skin caused by dermatophyte fungi, most commonly Trichophyton rubrum, Trichophyton tonsurans, and Microsporum canis. Despite its name, no worm is involved. It presents as an expanding circular, red, scaly ring with central clearing. It is highly contagious through direct and indirect contact.",
    treatment:
        "Topical antifungals (clotrimazole, terbinafine, miconazole, ketoconazole) applied twice daily for 2–4 weeks are effective for limited disease. Oral antifungals (terbinafine, fluconazole, itraconazole, griseofulvin) are required for extensive, recurrent, or tinea capitis (scalp) infections. Concurrent treatment of infected household contacts and pets reduces reinfection.",
    mainImage:
        "https://images.unsplash.com/photo-1559757175-5700dde675bc?w=400&h=400&fit=crop",
    scannedImage:
        "https://images.unsplash.com/photo-1631815588090-d4bfec5b1ccb?w=400&h=400&fit=crop",
    symptoms: [
      "Circular or ring-shaped red rash",
      "Scaly, raised, red border with central clearing",
      "Pruritus (itching) and burning",
      "Outward expansion of the ring over time",
      "Overlapping rings in severe cases",
      "Hair loss if scalp affected (tinea capitis)",
    ],
    riskFactors: [
      "Direct contact with infected person, animal, or soil",
      "Warm and humid environments",
      "Communal facilities (gyms, pools, dormitories)",
      "Excessive sweating (hyperhidrosis)",
      "Immunosuppression or diabetes",
      "Tight clothing and synthetic fabrics",
      "Children and athletes (high-contact sports)",
    ],
    affectedAreas: [
      "Arms and trunk",
      "Legs",
      "Face",
      "Scalp (tinea capitis)",
      "Groin (tinea cruris)",
      "Feet (tinea pedis — athlete's foot)",
      "Nails (tinea unguium — onychomycosis)",
    ],
    medications: [
      MedicationEntity(
        id: "m48",
        name: "Clotrimazole Cream (1%)",
        description:
            "Broad-spectrum imidazole antifungal; first-line topical for tinea corporis.",
        image:
            "https://images.unsplash.com/photo-1556228578-0d85b1a4d571?w=300&h=300&fit=crop",
      ),
      MedicationEntity(
        id: "m49",
        name: "Terbinafine Cream (1%)",
        description: "Allylamine antifungal with high cure rates in 1–2 weeks.",
        image:
            "https://images.unsplash.com/photo-1620916566398-39f1143ab7be?w=300&h=300&fit=crop",
      ),
      MedicationEntity(
        id: "m50",
        name: "Miconazole Antifungal Powder",
        description:
            "Useful for moist or occluded skin folds; reduces friction and moisture.",
        image:
            "https://images.unsplash.com/photo-1608571423902-eed4a5ad8108?w=300&h=300&fit=crop",
      ),
      MedicationEntity(
        id: "m51",
        name: "Oral Terbinafine",
        description:
            "Systemic antifungal for extensive, resistant, or scalp ringworm.",
        image:
            "https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?w=300&h=300&fit=crop",
      ),
      MedicationEntity(
        id: "m52",
        name: "Oral Fluconazole",
        description:
            "Triazole antifungal effective for widespread dermatophyte infections.",
        image:
            "https://images.unsplash.com/photo-1556228578-0d85b1a4d571?w=300&h=300&fit=crop",
      ),
      MedicationEntity(
        id: "m53",
        name: "Ketoconazole Shampoo (2%)",
        description:
            "Used for tinea capitis and tinea versicolor of the scalp.",
        image:
            "https://images.unsplash.com/photo-1620916566398-39f1143ab7be?w=300&h=300&fit=crop",
      ),
    ],
  ),

  const DiseaseEntity(
    id: "10",
    name: "Hives (Urticaria)",
    scientificName: "Urticaria",
    severity: "Mild–Severe",
    isContagious: false,
    isChronic: false,
    overview:
        "Urticaria (hives) is a common skin condition caused by mast cell degranulation and histamine release, resulting in transient, pruritic wheals (raised areas of edema) with surrounding erythema. Individual wheals typically resolve within 24 hours. Acute urticaria (<6 weeks) is often triggered by allergies or infection. Chronic urticaria (>6 weeks) is frequently autoimmune in origin. Angioedema (deeper swelling involving lips, throat, or eyelids) can accompany urticaria and become life-threatening if the airway is involved.",
    treatment:
        "Second-generation, non-sedating oral antihistamines (cetirizine, fexofenadine, loratadine) are first-line for both acute and chronic urticaria. Updosing up to 4x the standard dose is recommended before escalating. Refractory chronic urticaria is treated with omalizumab (anti-IgE biologic). Acute severe episodes with angioedema require intramuscular epinephrine and systemic corticosteroids. Trigger identification and avoidance is an important component of management.",
    mainImage:
        "https://images.unsplash.com/photo-1570554886111-e80fcca6a029?w=400&h=400&fit=crop",
    scannedImage:
        "https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?w=400&h=400&fit=crop",
    symptoms: [
      "Red, raised, itchy wheals of varying size and shape",
      "Blanching on pressure",
      "Individual lesions resolve within 24 hours",
      "Burning or stinging sensation",
      "Deep swelling of face, lips, hands, or throat (angioedema)",
      "Dermographism (urticaria from skin scratching)",
    ],
    riskFactors: [
      "Allergic reactions (foods: nuts, shellfish, eggs)",
      "Medications (NSAIDs, penicillin, ACE inhibitors)",
      "Viral or bacterial infections",
      "Physical triggers (cold, heat, pressure, exercise)",
      "Psychological stress",
      "Autoimmune thyroid disease",
      "Insect stings",
    ],
    affectedAreas: [
      "Trunk",
      "Arms and legs",
      "Face",
      "Throat and tongue (angioedema)",
      "Hands and feet",
    ],
    medications: [
      MedicationEntity(
        id: "m54",
        name: "Cetirizine (Zyrtec) 10mg",
        description:
            "Second-generation antihistamine; first-line for urticaria with 24hr effect.",
        image:
            "https://images.unsplash.com/photo-1620916566398-39f1143ab7be?w=300&h=300&fit=crop",
      ),
      MedicationEntity(
        id: "m55",
        name: "Fexofenadine (Allegra) 180mg",
        description: "Non-sedating antihistamine; ideal for daytime use.",
        image:
            "https://images.unsplash.com/photo-1608571423902-eed4a5ad8108?w=300&h=300&fit=crop",
      ),
      MedicationEntity(
        id: "m56",
        name: "Loratadine (Claritin) 10mg",
        description: "Long-acting antihistamine with minimal sedation.",
        image:
            "https://images.unsplash.com/photo-1556228578-0d85b1a4d571?w=300&h=300&fit=crop",
      ),
      MedicationEntity(
        id: "m57",
        name: "Omalizumab (Xolair) Injection",
        description:
            "Anti-IgE biologic for chronic spontaneous urticaria refractory to antihistamines.",
        image:
            "https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?w=300&h=300&fit=crop",
      ),
      MedicationEntity(
        id: "m58",
        name: "Prednisolone (Short Course)",
        description:
            "Oral corticosteroid for severe acute episodes; not for long-term use.",
        image:
            "https://images.unsplash.com/photo-1620916566398-39f1143ab7be?w=300&h=300&fit=crop",
      ),
      MedicationEntity(
        id: "m59",
        name: "Epinephrine Auto-Injector (EpiPen)",
        description:
            "Emergency treatment for anaphylaxis with throat angioedema.",
        image:
            "https://images.unsplash.com/photo-1608571423902-eed4a5ad8108?w=300&h=300&fit=crop",
      ),
    ],
  ),
];
