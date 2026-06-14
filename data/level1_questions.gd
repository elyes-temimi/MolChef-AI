extends Node

# ============================================================
# Level 1 - Molecular Kitchen
# Topic: Acids & Bases
# ============================================================

const DATA = {

###############################################################################
# BEAKER
###############################################################################

"beaker":[

{
"title":"Read the pH Meter",
"desc":"The pH meter displays **2.4**.\n\nWhat does this tell you?",
"options":[
{
"text":"The solution is strongly acidic",
"correct":true,
"learns":"Any pH below 7 is acidic. Values close to 0 are stronger acids."
},
{
"text":"The solution is neutral",
"correct":false,
"wrong_hint":"Neutral solutions have pH 7."
},
{
"text":"The solution is basic",
"correct":false,
"wrong_hint":"Bases have pH greater than 7."
},
{
"text":"The solution is pure water",
"correct":false,
"wrong_hint":"Pure water has a pH close to 7."
}
]
},

{
"title":"Universal Indicator",
"desc":"A universal indicator turns **red**.\n\nWhat is most likely true?",
"options":[
{
"text":"The liquid is acidic",
"correct":true,
"learns":"Red indicates a strong acid."
},
{
"text":"The liquid is alkaline",
"correct":false,
"wrong_hint":"Blue and purple usually indicate bases."
},
{
"text":"The liquid is neutral",
"correct":false,
"wrong_hint":"Green is usually neutral."
},
{
"text":"The indicator is broken",
"correct":false,
"wrong_hint":"The colour has meaning."
}
]
},

{
"title":"Hydrogen Ions",
"desc":"Acids contain a high concentration of...",
"options":[
{
"text":"Hydrogen ions (H⁺)",
"correct":true,
"learns":"Acids release hydrogen ions into solution."
},
{
"text":"Hydroxide ions",
"correct":false,
"wrong_hint":"Hydroxide ions belong to bases."
},
{
"text":"Electrons",
"correct":false,
"wrong_hint":"Electrons are not what defines acidity."
},
{
"text":"Neutrons",
"correct":false,
"wrong_hint":"Neutrons are inside atomic nuclei."
}
]
},

{
"title":"Weak Acid",
"desc":"Which of these is generally considered a weak acid?",
"options":[
{
"text":"Vinegar",
"correct":true,
"learns":"Vinegar contains acetic acid, a weak acid."
},
{
"text":"Bleach",
"correct":false,
"wrong_hint":"Bleach is basic."
},
{
"text":"Soap",
"correct":false,
"wrong_hint":"Soap solutions are alkaline."
},
{
"text":"Ammonia",
"correct":false,
"wrong_hint":"Ammonia is a weak base."
}
]
},

{
"title":"Strong Acid",
"desc":"Which laboratory acid is considered strong?",
"options":[
{
"text":"Hydrochloric Acid",
"correct":true,
"learns":"Hydrochloric acid dissociates almost completely in water."
},
{
"text":"Acetic Acid",
"correct":false,
"wrong_hint":"Acetic acid is weak."
},
{
"text":"Citric Acid",
"correct":false,
"wrong_hint":"Citric acid is weak."
},
{
"text":"Carbonic Acid",
"correct":false,
"wrong_hint":"Carbonic acid is weak."
}
]
}
], # <-- Corrected comma here

###############################################################################
# STOVE
###############################################################################

"stove":[

{
"title":"Neutralization",
"desc":"Your soup is too acidic.\nWhat ingredient should you add?",
"options":[
{
"text":"Baking soda",
"correct":true,
"learns":"A base neutralizes an acid."
},
{
"text":"Lemon juice",
"correct":false,
"wrong_hint":"Lemon juice is acidic."
},
{
"text":"Vinegar",
"correct":false,
"wrong_hint":"Vinegar is also acidic."
},
{
"text":"Citric acid",
"correct":false,
"wrong_hint":"Adding acid won't reduce acidity."
}
]
},

{
"title":"Base",
"desc":"Which ingredient behaves like a base?",
"options":[
{
"text":"Baking soda",
"correct":true,
"learns":"Baking soda has a pH above 7."
},
{
"text":"Orange juice",
"correct":false,
"wrong_hint":"Orange juice is acidic."
},
{
"text":"Vinegar",
"correct":false,
"wrong_hint":"Vinegar is acidic."
},
{
"text":"Lemon juice",
"correct":false,
"wrong_hint":"Lemon juice is acidic."
}
]
},

{
"title":"Reaction Products",
"desc":"Acid + Base produces...",
"options":[
{
"text":"Salt + Water",
"correct":true,
"learns":"This is the classic neutralization reaction."
},
{
"text":"Hydrogen Gas",
"correct":false,
"wrong_hint":"Not in a simple neutralization."
},
{
"text":"Oxygen",
"correct":false,
"wrong_hint":"Oxygen is not produced."
},
{
"text":"Carbon",
"correct":false,
"wrong_hint":"Carbon isn't a reaction product here."
}
]
},

{
"title":"Safe pH",
"desc":"A balanced soup should have a pH close to...",
"options":[
{
"text":"7",
"correct":true,
"learns":"Neutral pH is often desirable."
},
{
"text":"2",
"correct":false,
"wrong_hint":"That's strongly acidic."
},
{
"text":"12",
"correct":false,
"wrong_hint":"That's strongly basic."
},
{
"text":"0",
"correct":false,
"wrong_hint":"That's extremely acidic."
}
]
},

{
"title":"Indicator",
"desc":"After neutralization the indicator becomes green.\nWhat happened?",
"options":[
{
"text":"The solution became neutral",
"correct":true,
"learns":"Green commonly indicates pH 7."
},
{
"text":"The solution became acidic",
"correct":false,
"wrong_hint":"Acids are usually red/orange."
},
{
"text":"The solution became strongly basic",
"correct":false,
"wrong_hint":"Bases are blue or purple."
},
{
"text":"The indicator failed",
"correct":false,
"wrong_hint":"Green has meaning."
}
]
}
], # <-- Removed the premature closing "}" and added a comma here

###############################################################################
# SINK
###############################################################################

"sink":[

{
"title":"Dilution",
"desc":"A concentrated acid is mixed with a large amount of water.\n\nWhat happens?",
"options":[
{
"text":"The acidity decreases",
"correct":true,
"learns":"Adding water dilutes the acid, reducing its concentration."
},
{
"text":"The acid becomes a base",
"correct":false,
"wrong_hint":"Dilution does not change an acid into a base."
},
{
"text":"The pH becomes zero",
"correct":false,
"wrong_hint":"Dilution generally increases the pH."
},
{
"text":"Nothing changes",
"correct":false,
"wrong_hint":"Concentration changes during dilution."
}
]
},

{
"title":"Laboratory Safety",
"desc":"When preparing a dilute acid solution, what should you do?",
"options":[
{
"text":"Add acid to water",
"correct":true,
"learns":"Always add acid to water to reduce splashing and heat hazards."
},
{
"text":"Add water to acid",
"correct":false,
"wrong_hint":"This can cause dangerous splashing."
},
{
"text":"Mix both simultaneously",
"correct":false,
"wrong_hint":"Follow laboratory safety procedures."
},
{
"text":"Heat the acid first",
"correct":false,
"wrong_hint":"Heating increases the danger."
}
]
},

{
"title":"Tap Water",
"desc":"The pH of clean tap water is usually close to...",
"options":[
{
"text":"7",
"correct":true,
"learns":"Pure water is approximately neutral."
},
{
"text":"2",
"correct":false,
"wrong_hint":"That's strongly acidic."
},
{
"text":"12",
"correct":false,
"wrong_hint":"That's strongly basic."
},
{
"text":"1",
"correct":false,
"wrong_hint":"That's even more acidic."
}
]
},

{
"title":"Cleaning Chemicals",
"desc":"Many drain cleaners are...",
"options":[
{
"text":"Strong bases",
"correct":true,
"learns":"Many drain cleaners contain sodium hydroxide."
},
{
"text":"Strong acids",
"correct":false,
"wrong_hint":"Some cleaners are acidic, but drain cleaners are commonly basic."
},
{
"text":"Neutral salts",
"correct":false,
"wrong_hint":"They must react with grease."
},
{
"text":"Only water",
"correct":false,
"wrong_hint":"They contain active chemicals."
}
]
},

{
"title":"Hydroxide Ion",
"desc":"Bases contain a high concentration of...",
"options":[
{
"text":"OH⁻ ions",
"correct":true,
"learns":"Hydroxide ions make a solution basic."
},
{
"text":"H⁺ ions",
"correct":false,
"wrong_hint":"Hydrogen ions characterize acids."
},
{
"text":"Electrons",
"correct":false,
"wrong_hint":"Electrons do not define a base."
},
{
"text":"Neutrons",
"correct":false,
"wrong_hint":"Neutrons are inside nuclei."
}
]
}
], # <-- Added a comma here

###############################################################################
# SHELF
###############################################################################

"shelf":[

{
"title":"Household Acid",
"desc":"Which common kitchen ingredient contains acetic acid?",
"options":[
{
"text":"Vinegar",
"correct":true,
"learns":"Vinegar contains acetic acid."
},
{
"text":"Sugar",
"correct":false,
"wrong_hint":"Sugar is not an acid."
},
{
"text":"Salt",
"correct":false,
"wrong_hint":"Salt is not acidic."
},
{
"text":"Flour",
"correct":false,
"wrong_hint":"Flour is not acidic."
}
]
},

{
"title":"Citrus Fruits",
"desc":"Lemons taste sour because they contain...",
"options":[
{
"text":"Citric acid",
"correct":true,
"learns":"Citric acid gives citrus fruits their sour taste."
},
{
"text":"Hydrochloric acid",
"correct":false,
"wrong_hint":"That would be dangerous."
},
{
"text":"Sulfuric acid",
"correct":false,
"wrong_hint":"Not found in fruit."
},
{
"text":"Nitric acid",
"wrong_hint":"Not present in lemons."
}
]
},

{
"title":"Soap",
"desc":"Soap solutions are generally...",
"options":[
{
"text":"Basic",
"correct":true,
"learns":"Soap usually has a pH above 7."
},
{
"text":"Acidic",
"correct":false,
"wrong_hint":"Soap is not acidic."
},
{
"text":"Exactly neutral",
"correct":false,
"wrong_hint":"Soap is usually slightly alkaline."
},
{
"text":"Pure water",
"correct":false,
"wrong_hint":"Soap changes the pH."
}
]
},

{
"title":"Baking Soda",
"desc":"Baking soda has a pH of approximately...",
"options":[
{
"text":"8-9",
"correct":true,
"learns":"Baking soda is mildly basic."
},
{
"text":"2",
"correct":false,
"wrong_hint":"That's acidic."
},
{
"text":"4",
"correct":false,
"wrong_hint":"Still acidic."
},
{
"text":"1",
"correct":false,
"wrong_hint":"Far too acidic."
}
]
},

{
"title":"Neutral Food",
"desc":"Which of these is closest to neutral?",
"options":[
{
"text":"Water",
"correct":true,
"learns":"Pure water has a pH close to 7."
},
{
"text":"Lemon juice",
"correct":false,
"wrong_hint":"Lemon juice is acidic."
},
{
"text":"Vinegar",
"correct":false,
"wrong_hint":"Vinegar is acidic."
},
{
"text":"Cola",
"correct":false,
"wrong_hint":"Soft drinks are acidic."
}
]
}
], # <-- Added a comma here

###############################################################################
# FRIDGE
###############################################################################

"fridge":[

{
"title":"Milk",
"desc":"Fresh milk usually has a pH around...",
"options":[
{
"text":"6.5 - 6.8",
"correct":true,
"learns":"Milk is slightly acidic."
},
{
"text":"2",
"correct":false,
"wrong_hint":"That's far too acidic."
},
{
"text":"11",
"correct":false,
"wrong_hint":"Milk is not basic."
},
{
"text":"14",
"correct":false,
"wrong_hint":"Impossible for milk."
}
]
},

{
"title":"Spoiled Milk",
"desc":"Why does spoiled milk become more acidic?",
"options":[
{
"text":"Bacteria produce lactic acid",
"correct":true,
"learns":"Lactic acid bacteria lower the pH."
},
{
"text":"Water evaporates",
"correct":false,
"wrong_hint":"That isn't the main reason."
},
{
"text":"Oxygen disappears",
"correct":false,
"wrong_hint":"Not related."
},
{
"text":"The proteins vanish",
"correct":false,
"wrong_hint":"Proteins don't simply disappear."
}
]
},

{
"title":"Food Preservation",
"desc":"Pickled vegetables are preserved using...",
"options":[
{
"text":"Acidic solutions",
"correct":true,
"learns":"Acid slows bacterial growth."
},
{
"text":"Strong bases",
"correct":false,
"wrong_hint":"Food would be unsafe."
},
{
"text":"Pure oxygen",
"correct":false,
"wrong_hint":"Oxygen doesn't preserve food."
},
{
"text":"Electric current",
"correct":false,
"wrong_hint":"Not a preservation method."
}
]
},

{
"title":"Yogurt",
"desc":"Yogurt tastes sour because it contains...",
"options":[
{
"text":"Lactic acid",
"correct":true,
"learns":"Lactic acid forms during fermentation."
},
{
"text":"Sulfuric acid",
"correct":false,
"wrong_hint":"Definitely not."
},
{
"text":"Hydrochloric acid",
"correct":false,
"wrong_hint":"Not found in yogurt."
},
{
"text":"Nitric acid",
"correct":false,
"wrong_hint":"Incorrect."
}
]
},

{
"title":"Acidic Foods",
"desc":"Which food is the MOST acidic?",
"options":[
{
"text":"Lemon juice",
"correct":true,
"learns":"Lemon juice has a very low pH."
},
{
"text":"Milk",
"correct":false,
"wrong_hint":"Milk is only slightly acidic."
},
{
"text":"Water",
"correct":false,
"wrong_hint":"Water is neutral."
},
{
"text":"Bread",
"correct":false,
"wrong_hint":"Bread is not highly acidic."
}
]
}
]

} # <-- This final curly brace safely wraps up the entire DATA dictionary.
