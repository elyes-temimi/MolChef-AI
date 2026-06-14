extends Node

# ============================================================
# Level 2 - Organic Chemistry Laboratory
# Topic: Organic Chemistry
# ============================================================

const DATA = {

###############################################################################
# DISTILLATION SETUP
###############################################################################

"distillation":[

{
"title":"Boiling Point",
"desc":"What property allows distillation to separate two liquids?",
"options":[
{
"text":"Different boiling points",
"correct":true,
"learns":"Distillation separates liquids because they boil at different temperatures."
},
{
"text":"Different colors",
"correct":false,
"wrong_hint":"Color has nothing to do with distillation."
},
{
"text":"Different densities only",
"correct":false,
"wrong_hint":"Density alone is not enough."
},
{
"text":"Different pH values",
"correct":false,
"wrong_hint":"Distillation does not separate based on pH."
}
]
},

{
"title":"Heating the Flask",
"desc":"What happens first during distillation?",
"options":[
{
"text":"The liquid begins to evaporate",
"correct":true,
"learns":"Heating converts the liquid into vapor before condensation."
},
{
"text":"The liquid freezes",
"correct":false,
"wrong_hint":"Heating causes vaporization, not freezing."
},
{
"text":"The liquid becomes solid",
"correct":false,
"wrong_hint":"That happens during cooling."
},
{
"text":"The condenser heats the liquid",
"correct":false,
"wrong_hint":"The condenser cools vapor."
}
]
},

{
"title":"Purpose of the Condenser",
"desc":"Why is cold water circulated through the condenser?",
"options":[
{
"text":"To cool vapor back into liquid",
"correct":true,
"learns":"The condenser removes heat so the vapor condenses."
},
{
"text":"To increase boiling point",
"correct":false,
"wrong_hint":"Cooling doesn't increase boiling point."
},
{
"text":"To heat the vapor",
"correct":false,
"wrong_hint":"The condenser cools rather than heats."
},
{
"text":"To filter impurities",
"correct":false,
"wrong_hint":"Filtration is a different separation method."
}
]
},

{
"title":"Pure Water",
"desc":"Distillation is commonly used to produce...",
"options":[
{
"text":"Distilled water",
"correct":true,
"learns":"Distilled water is purified by evaporation and condensation."
},
{
"text":"Salt",
"correct":false,
"wrong_hint":"Salt remains behind."
},
{
"text":"Oxygen gas",
"correct":false,
"wrong_hint":"Distillation doesn't create oxygen."
},
{
"text":"Carbon dioxide",
"correct":false,
"wrong_hint":"No chemical reaction occurs."
}
]
},

{
"title":"Ethanol",
"desc":"Why can ethanol be separated from water by distillation?",
"options":[
{
"text":"Their boiling points are different",
"correct":true,
"learns":"Ethanol boils around 78°C while water boils at 100°C."
},
{
"text":"Ethanol is blue",
"correct":false,
"wrong_hint":"Color is unrelated."
},
{
"text":"Water freezes faster",
"correct":false,
"wrong_hint":"Freezing isn't involved."
},
{
"text":"Water is acidic",
"correct":false,
"wrong_hint":"Acidity isn't the reason."
}
]
},

{
"title":"Fractional Distillation",
"desc":"Fractional distillation is mainly used when liquids...",
"options":[
{
"text":"Have similar boiling points",
"correct":true,
"learns":"The fractionating column improves separation."
},
{
"text":"Have identical colors",
"correct":false,
"wrong_hint":"Color doesn't matter."
},
{
"text":"Cannot evaporate",
"correct":false,
"wrong_hint":"They must evaporate."
},
{
"text":"Are solids",
"correct":false,
"wrong_hint":"Distillation separates liquids."
}
]
},

{
"title":"Thermometer Position",
"desc":"Where should the thermometer bulb be placed?",
"options":[
{
"text":"At the entrance of the condenser",
"correct":true,
"learns":"It measures the temperature of the vapor entering the condenser."
},
{
"text":"Inside the cooling water",
"correct":false,
"wrong_hint":"That would measure water temperature."
},
{
"text":"At the bottom of the flask",
"correct":false,
"wrong_hint":"It should measure vapor temperature."
},
{
"text":"Outside the apparatus",
"correct":false,
"wrong_hint":"That wouldn't measure anything useful."
}
]
},

{
"title":"Cooling Water",
"desc":"Cooling water should enter the condenser...",
"options":[
{
"text":"From the bottom",
"correct":true,
"learns":"Entering from the bottom keeps the condenser completely filled."
},
{
"text":"From the top",
"correct":false,
"wrong_hint":"That traps air inside."
},
{
"text":"From either side",
"correct":false,
"wrong_hint":"Direction matters."
},
{
"text":"Only after boiling finishes",
"correct":false,
"wrong_hint":"Cooling must happen continuously."
}
]
},

{
"title":"Residue",
"desc":"After distillation, non-volatile substances...",
"options":[
{
"text":"Remain in the flask",
"correct":true,
"learns":"Only volatile compounds evaporate."
},
{
"text":"Collect inside the condenser",
"correct":false,
"wrong_hint":"Only vapor enters the condenser."
},
{
"text":"Turn into gas",
"correct":false,
"wrong_hint":"They don't evaporate easily."
},
{
"text":"Disappear completely",
"correct":false,
"wrong_hint":"Matter is conserved."
}
]
},

{
"title":"Laboratory Safety",
"desc":"What is the safest way to heat a flammable organic solvent?",
"options":[
{
"text":"Use a heating mantle or hot plate",
"correct":true,
"learns":"Open flames can ignite flammable vapors."
},
{
"text":"Use a Bunsen burner",
"correct":false,
"wrong_hint":"Open flames are dangerous with organic solvents."
},
{
"text":"Heat with a lighter",
"correct":false,
"wrong_hint":"Never use a lighter in the lab."
},
{
"text":"Heat directly over a candle",
"correct":false,
"wrong_hint":"Candles produce open flames."
}
]
}

],
###############################################################################
# FUME HOOD
###############################################################################

"hood":[

{
"title":"Purpose of a Fume Hood",
"desc":"Why should volatile chemicals be handled inside a fume hood?",
"options":[
{
"text":"To remove hazardous vapors from the breathing area",
"correct":true,
"learns":"A fume hood protects laboratory workers by exhausting harmful vapors."
},
{
"text":"To cool chemicals faster",
"correct":false,
"wrong_hint":"Cooling is not the main purpose of a fume hood."
},
{
"text":"To make reactions occur faster",
"correct":false,
"wrong_hint":"The hood provides ventilation, not faster reactions."
},
{
"text":"To measure pressure",
"correct":false,
"wrong_hint":"Pressure is measured using other equipment."
}
]
},

{
"title":"Sash Position",
"desc":"During an experiment, where should the hood sash be kept?",
"options":[
{
"text":"As low as practical",
"correct":true,
"learns":"Keeping the sash low improves protection while still allowing you to work."
},
{
"text":"Fully open",
"correct":false,
"wrong_hint":"A fully open sash reduces protection."
},
{
"text":"Removed completely",
"correct":false,
"wrong_hint":"The sash is an important safety barrier."
},
{
"text":"Closed after placing your head inside",
"correct":false,
"wrong_hint":"Never place your head inside the hood."
}
]
},

{
"title":"Flammable Solvents",
"desc":"Which solvent should always be handled carefully because it is highly flammable?",
"options":[
{
"text":"Ethanol",
"correct":true,
"learns":"Ethanol produces flammable vapors that can ignite easily."
},
{
"text":"Water",
"correct":false,
"wrong_hint":"Water is not flammable."
},
{
"text":"Sodium chloride solution",
"correct":false,
"wrong_hint":"Salt solutions are not flammable."
},
{
"text":"Sand",
"correct":false,
"wrong_hint":"Sand does not burn under normal laboratory conditions."
}
]
},

{
"title":"Personal Protection",
"desc":"Which item should always be worn while working in the laboratory?",
"options":[
{
"text":"Safety goggles",
"correct":true,
"learns":"Safety goggles protect your eyes from splashes and broken glass."
},
{
"text":"Sandals",
"correct":false,
"wrong_hint":"Open shoes are unsafe in laboratories."
},
{
"text":"Short sleeves only",
"correct":false,
"wrong_hint":"Protective clothing is preferred."
},
{
"text":"Headphones",
"correct":false,
"wrong_hint":"Headphones reduce awareness of hazards."
}
]
},

{
"title":"Chemical Spill",
"desc":"A toxic solvent spills inside the hood. What should you do first?",
"options":[
{
"text":"Inform the instructor and follow spill procedures",
"correct":true,
"learns":"Chemical spills must be handled using proper laboratory procedures."
},
{
"text":"Ignore it",
"correct":false,
"wrong_hint":"Never ignore chemical spills."
},
{
"text":"Touch it with your hands",
"correct":false,
"wrong_hint":"Avoid direct contact."
},
{
"text":"Blow on it",
"correct":false,
"wrong_hint":"This spreads hazardous vapors."
}
]
},

{
"title":"Air Flow",
"desc":"What creates the airflow inside a fume hood?",
"options":[
{
"text":"An exhaust ventilation system",
"correct":true,
"learns":"Fans continuously pull contaminated air away from the user."
},
{
"text":"Natural sunlight",
"correct":false,
"wrong_hint":"Sunlight has nothing to do with ventilation."
},
{
"text":"Magnetic fields",
"correct":false,
"wrong_hint":"Magnets do not move laboratory air."
},
{
"text":"The chemical reaction itself",
"correct":false,
"wrong_hint":"Ventilation is mechanical."
}
]
},

{
"title":"Storage",
"desc":"Should chemicals be permanently stored inside a fume hood?",
"options":[
{
"text":"No, storage blocks airflow",
"correct":true,
"learns":"Large objects reduce airflow efficiency inside the hood."
},
{
"text":"Yes, always",
"correct":false,
"wrong_hint":"Permanent storage reduces safety."
},
{
"text":"Only acids",
"correct":false,
"wrong_hint":"Storage depends on proper chemical cabinets."
},
{
"text":"Only water",
"correct":false,
"wrong_hint":"Water storage is unnecessary."
}
]
},

{
"title":"Working Position",
"desc":"Where should your experiment be placed inside the hood?",
"options":[
{
"text":"Several centimeters inside the hood",
"correct":true,
"learns":"Keeping equipment well inside the hood improves containment."
},
{
"text":"Right at the front edge",
"correct":false,
"wrong_hint":"Airflow is weaker near the front."
},
{
"text":"Outside the hood",
"correct":false,
"wrong_hint":"That defeats the purpose of the hood."
},
{
"text":"Balanced on the sash",
"correct":false,
"wrong_hint":"The sash is not a shelf."
}
]
},

{
"title":"Open Flame",
"desc":"Why should open flames be avoided near organic solvents?",
"options":[
{
"text":"Their vapors may ignite",
"correct":true,
"learns":"Many organic solvents produce highly flammable vapors."
},
{
"text":"They freeze the solvent",
"correct":false,
"wrong_hint":"Flames do not freeze liquids."
},
{
"text":"They lower pressure",
"correct":false,
"wrong_hint":"Pressure is not the concern."
},
{
"text":"They create oxygen",
"correct":false,
"wrong_hint":"Combustion consumes oxygen."
}
]
},

{
"title":"Emergency",
"desc":"If you smell a strong unknown chemical odor, what should you do?",
"options":[
{
"text":"Report it immediately",
"correct":true,
"learns":"Unknown chemical odors should always be reported."
},
{
"text":"Ignore it",
"correct":false,
"wrong_hint":"Unknown vapors may be dangerous."
},
{
"text":"Smell it closely",
"correct":false,
"wrong_hint":"Never intentionally inhale unknown chemicals."
},
{
"text":"Taste the chemical",
"correct":false,
"wrong_hint":"Never taste laboratory chemicals."
}
]
}

],
###############################################################################
# IR SPECTROMETER
###############################################################################

"spectrometer":[

{
"title":"Carbonyl Group",
"desc":"An IR spectrum shows a very strong absorption near **1700 cm⁻¹**.\nWhich functional group is most likely present?",
"options":[
{
"text":"Carbonyl (C=O)",
"correct":true,
"learns":"A strong peak around 1700 cm⁻¹ usually indicates a carbonyl group."
},
{
"text":"Hydroxyl (O–H)",
"correct":false,
"wrong_hint":"O–H appears as a broad peak around 3200–3600 cm⁻¹."
},
{
"text":"C–H",
"correct":false,
"wrong_hint":"C–H stretching occurs near 2850–3000 cm⁻¹."
},
{
"text":"Noble gas",
"correct":false,
"wrong_hint":"Noble gases do not produce IR absorption."
}
]
},

{
"title":"Alcohol Detection",
"desc":"A broad absorption appears between **3200–3600 cm⁻¹**.\nWhat functional group does this suggest?",
"options":[
{
"text":"Hydroxyl (O–H)",
"correct":true,
"learns":"Alcohols show a broad O–H stretching peak."
},
{
"text":"Carbonyl",
"correct":false,
"wrong_hint":"Carbonyl peaks appear near 1700 cm⁻¹."
},
{
"text":"Triple bond",
"correct":false,
"wrong_hint":"Triple bonds appear around 2100–2260 cm⁻¹."
},
{
"text":"Halogen",
"correct":false,
"wrong_hint":"Halogens don't produce this broad peak."
}
]
},

{
"title":"C–H Bond",
"desc":"Where is the C–H stretching region typically found?",
"options":[
{
"text":"2850–3000 cm⁻¹",
"correct":true,
"learns":"Most C–H stretching vibrations appear in this region."
},
{
"text":"1500 cm⁻¹",
"correct":false,
"wrong_hint":"Too low for C–H stretching."
},
{
"text":"1700 cm⁻¹",
"correct":false,
"wrong_hint":"That's usually the carbonyl region."
},
{
"text":"500 cm⁻¹",
"correct":false,
"wrong_hint":"Too low."
}
]
},

{
"title":"Fingerprint Region",
"desc":"Why is the fingerprint region useful?",
"options":[
{
"text":"Every molecule has a unique pattern",
"correct":true,
"learns":"The fingerprint region helps identify specific compounds."
},
{
"text":"It measures density",
"correct":false,
"wrong_hint":"Density isn't measured by IR."
},
{
"text":"It determines molecular weight",
"correct":false,
"wrong_hint":"Mass spectrometry measures molecular weight."
},
{
"text":"It shows boiling point",
"correct":false,
"wrong_hint":"IR spectroscopy does not measure boiling point."
}
]
},

{
"title":"Infrared Radiation",
"desc":"IR spectroscopy works because molecules...",
"options":[
{
"text":"Absorb infrared light and vibrate",
"correct":true,
"learns":"Chemical bonds vibrate at characteristic frequencies."
},
{
"text":"Emit X-rays",
"correct":false,
"wrong_hint":"IR uses infrared light, not X-rays."
},
{
"text":"Produce electricity",
"correct":false,
"wrong_hint":"Electricity isn't measured here."
},
{
"text":"Explode under light",
"correct":false,
"wrong_hint":"IR light is non-destructive."
}
]
},

{
"title":"Ketone Identification",
"desc":"Which functional group is present in acetone?",
"options":[
{
"text":"Ketone",
"correct":true,
"learns":"Acetone contains a carbonyl group between two carbon atoms."
},
{
"text":"Alcohol",
"correct":false,
"wrong_hint":"Acetone contains no hydroxyl group."
},
{
"text":"Carboxylic acid",
"correct":false,
"wrong_hint":"Acetone is not an acid."
},
{
"text":"Amine",
"correct":false,
"wrong_hint":"No nitrogen is present."
}
]
},

{
"title":"Alcohol Example",
"desc":"Which compound would show a broad O–H peak?",
"options":[
{
"text":"Ethanol",
"correct":true,
"learns":"Ethanol contains an alcohol group."
},
{
"text":"Methane",
"correct":false,
"wrong_hint":"Methane has only C–H bonds."
},
{
"text":"Carbon dioxide",
"correct":false,
"wrong_hint":"CO₂ contains no O–H bond."
},
{
"text":"Propane",
"correct":false,
"wrong_hint":"Propane contains only C–H bonds."
}
]
},

{
"title":"Carbonyl Peak",
"desc":"Which compound would show a strong C=O absorption?",
"options":[
{
"text":"Acetone",
"correct":true,
"learns":"Ketones contain carbonyl groups."
},
{
"text":"Methane",
"correct":false,
"wrong_hint":"Methane contains no oxygen."
},
{
"text":"Ethane",
"correct":false,
"wrong_hint":"Ethane has only C–C and C–H bonds."
},
{
"text":"Hydrogen",
"correct":false,
"wrong_hint":"Hydrogen molecules do not contain carbonyl groups."
}
]
},

{
"title":"IR Instrument",
"desc":"What does an IR spectrometer measure?",
"options":[
{
"text":"Absorption of infrared radiation",
"correct":true,
"learns":"IR spectra show which wavelengths are absorbed by molecular bonds."
},
{
"text":"Temperature only",
"correct":false,
"wrong_hint":"Temperature is measured with thermometers."
},
{
"text":"Pressure only",
"correct":false,
"wrong_hint":"Pressure gauges measure pressure."
},
{
"text":"Electric current",
"correct":false,
"wrong_hint":"That's unrelated to IR spectroscopy."
}
]
},

{
"title":"Unknown Compound",
"desc":"An unknown sample shows both a broad O–H peak and a C–H region.\nWhich family could it belong to?",
"options":[
{
"text":"Alcohol",
"correct":true,
"learns":"Alcohols contain both O–H and C–H bonds."
},
{
"text":"Noble gas",
"correct":false,
"wrong_hint":"Noble gases have no chemical bonds."
},
{
"text":"Pure oxygen",
"correct":false,
"wrong_hint":"O₂ contains no O–H bond."
},
{
"text":"Helium",
"correct":false,
"wrong_hint":"Helium is chemically inert."
}
]
}

],
###############################################################################
# REAGENT CABINET
###############################################################################

"cabinet":[

{
"title":"Alcohol Functional Group",
"desc":"Which functional group defines an alcohol?",
"options":[
{
"text":"Hydroxyl group (–OH)",
"correct":true,
"learns":"Alcohols are characterized by the hydroxyl (–OH) functional group."
},
{
"text":"Carbonyl group (C=O)",
"correct":false,
"wrong_hint":"Carbonyl groups belong to aldehydes and ketones."
},
{
"text":"Carboxyl group (–COOH)",
"correct":false,
"wrong_hint":"That's the functional group of carboxylic acids."
},
{
"text":"Amine group (–NH₂)",
"correct":false,
"wrong_hint":"That's found in amines."
}
]
},

{
"title":"Aldehyde",
"desc":"Which compound belongs to the aldehyde family?",
"options":[
{
"text":"Methanal (Formaldehyde)",
"correct":true,
"learns":"Methanal is the simplest aldehyde."
},
{
"text":"Ethanol",
"correct":false,
"wrong_hint":"Ethanol is an alcohol."
},
{
"text":"Propanone",
"correct":false,
"wrong_hint":"Propanone is a ketone."
},
{
"text":"Ethanoic acid",
"correct":false,
"wrong_hint":"That's a carboxylic acid."
}
]
},

{
"title":"Ketone",
"desc":"Which molecule is classified as a ketone?",
"options":[
{
"text":"Acetone (Propanone)",
"correct":true,
"learns":"Acetone is one of the most common ketones."
},
{
"text":"Methanol",
"correct":false,
"wrong_hint":"Methanol is an alcohol."
},
{
"text":"Methanal",
"correct":false,
"wrong_hint":"Methanal is an aldehyde."
},
{
"text":"Acetic acid",
"correct":false,
"wrong_hint":"Acetic acid is a carboxylic acid."
}
]
},

{
"title":"Carboxylic Acid",
"desc":"Which common kitchen ingredient contains ethanoic (acetic) acid?",
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
"wrong_hint":"Flour is not a carboxylic acid."
}
]
},

{
"title":"Ester",
"desc":"Many esters are known for having...",
"options":[
{
"text":"Pleasant fruity smells",
"correct":true,
"learns":"Many fruit aromas are caused by esters."
},
{
"text":"Strong metallic odors",
"correct":false,
"wrong_hint":"That's not typical of esters."
},
{
"text":"No smell at all",
"correct":false,
"wrong_hint":"Many esters are fragrant."
},
{
"text":"A bright blue color",
"correct":false,
"wrong_hint":"Color is unrelated."
}
]
},

{
"title":"Amine",
"desc":"What element must every amine contain?",
"options":[
{
"text":"Nitrogen",
"correct":true,
"learns":"Amines always contain nitrogen atoms."
},
{
"text":"Iron",
"correct":false,
"wrong_hint":"Iron is not required."
},
{
"text":"Chlorine",
"correct":false,
"wrong_hint":"Not all amines contain chlorine."
},
{
"text":"Sodium",
"correct":false,
"wrong_hint":"Sodium is unnecessary."
}
]
},

{
"title":"Hydrocarbon",
"desc":"Hydrocarbons contain only...",
"options":[
{
"text":"Carbon and hydrogen",
"correct":true,
"learns":"Hydrocarbons are compounds made exclusively of carbon and hydrogen."
},
{
"text":"Carbon and oxygen",
"correct":false,
"wrong_hint":"That describes many other organic compounds."
},
{
"text":"Hydrogen and nitrogen",
"correct":false,
"wrong_hint":"Nitrogen isn't required."
},
{
"text":"Carbon, oxygen and sulfur",
"correct":false,
"wrong_hint":"Hydrocarbons contain only C and H."
}
]
},

{
"title":"Oxidation",
"desc":"Primary alcohols are commonly oxidized into...",
"options":[
{
"text":"Aldehydes",
"correct":true,
"learns":"Primary alcohols first oxidize into aldehydes."
},
{
"text":"Hydrocarbons",
"correct":false,
"wrong_hint":"Oxidation does not create hydrocarbons."
},
{
"text":"Metals",
"correct":false,
"wrong_hint":"Metals aren't reaction products."
},
{
"text":"Hydrogen gas",
"correct":false,
"wrong_hint":"Not in this reaction."
}
]
},

{
"title":"Reduction",
"desc":"Reduction is generally associated with...",
"options":[
{
"text":"Gain of electrons",
"correct":true,
"learns":"Remember: OIL RIG — Reduction Is Gain of electrons."
},
{
"text":"Loss of electrons",
"correct":false,
"wrong_hint":"That's oxidation."
},
{
"text":"Boiling",
"correct":false,
"wrong_hint":"Boiling is a physical change."
},
{
"text":"Freezing",
"correct":false,
"wrong_hint":"Freezing is unrelated."
}
]
},

{
"title":"Organic Chemistry",
"desc":"Organic chemistry mainly studies compounds containing...",
"options":[
{
"text":"Carbon",
"correct":true,
"learns":"Organic chemistry focuses primarily on carbon compounds."
},
{
"text":"Gold",
"correct":false,
"wrong_hint":"Gold is not the basis of organic chemistry."
},
{
"text":"Helium",
"correct":false,
"wrong_hint":"Helium is an inert gas."
},
{
"text":"Sodium only",
"correct":false,
"wrong_hint":"Carbon is the defining element."
}
]
}

],
###############################################################################
# MOLECULAR ANALYZER
###############################################################################

"analyzer":[

{
"title":"Molecular Formula",
"desc":"What is the molecular formula of water?",
"options":[
{
"text":"H₂O",
"correct":true,
"learns":"Water contains two hydrogen atoms and one oxygen atom."
},
{
"text":"CO₂",
"correct":false,
"wrong_hint":"That's carbon dioxide."
},
{
"text":"NH₃",
"correct":false,
"wrong_hint":"That's ammonia."
},
{
"text":"CH₄",
"correct":false,
"wrong_hint":"That's methane."
}
]
},

{
"title":"Methane",
"desc":"How many hydrogen atoms are bonded to carbon in methane?",
"options":[
{
"text":"4",
"correct":true,
"learns":"Methane is CH₄."
},
{
"text":"2",
"correct":false,
"wrong_hint":"Too few."
},
{
"text":"6",
"correct":false,
"wrong_hint":"Too many."
},
{
"text":"8",
"correct":false,
"wrong_hint":"Impossible for methane."
}
]
},

{
"title":"Covalent Bond",
"desc":"A covalent bond is formed by...",
"options":[
{
"text":"Sharing electrons",
"correct":true,
"learns":"Covalent bonds form when atoms share electrons."
},
{
"text":"Transferring protons",
"correct":false,
"wrong_hint":"Protons remain inside the nucleus."
},
{
"text":"Sharing neutrons",
"correct":false,
"wrong_hint":"Neutrons are not shared."
},
{
"text":"Destroying electrons",
"correct":false,
"wrong_hint":"Electrons are conserved."
}
]
},

{
"title":"Isomers",
"desc":"What are isomers?",
"options":[
{
"text":"Compounds with the same formula but different structures",
"correct":true,
"learns":"Structural isomers have identical molecular formulas but different arrangements."
},
{
"text":"Compounds with different formulas",
"correct":false,
"wrong_hint":"Those are simply different compounds."
},
{
"text":"Identical molecules",
"correct":false,
"wrong_hint":"Isomers differ in structure."
},
{
"text":"Radioactive atoms",
"correct":false,
"wrong_hint":"Radioactivity is unrelated."
}
]
},

{
"title":"Benzene",
"desc":"Benzene is best described as...",
"options":[
{
"text":"An aromatic compound",
"correct":true,
"learns":"Benzene is the classic aromatic molecule."
},
{
"text":"An alcohol",
"correct":false,
"wrong_hint":"No hydroxyl group is present."
},
{
"text":"A ketone",
"correct":false,
"wrong_hint":"There is no carbonyl group."
},
{
"text":"A protein",
"correct":false,
"wrong_hint":"Proteins are much larger molecules."
}
]
},

{
"title":"Hybridization",
"desc":"The carbon atoms in methane are...",
"options":[
{
"text":"sp³ hybridized",
"correct":true,
"learns":"Methane has tetrahedral geometry with sp³ hybridization."
},
{
"text":"sp",
"correct":false,
"wrong_hint":"sp occurs in linear molecules."
},
{
"text":"sp²",
"correct":false,
"wrong_hint":"sp² is common in double bonds."
},
{
"text":"Unhybridized",
"correct":false,
"wrong_hint":"Carbon hybridizes in methane."
}
]
},

{
"title":"Polymer",
"desc":"A polymer is...",
"options":[
{
"text":"A large molecule made from repeating units",
"correct":true,
"learns":"Polymers consist of many repeating monomers."
},
{
"text":"A single atom",
"correct":false,
"wrong_hint":"Atoms are much smaller."
},
{
"text":"A metal",
"correct":false,
"wrong_hint":"Most polymers are organic compounds."
},
{
"text":"A noble gas",
"correct":false,
"wrong_hint":"Noble gases are elements."
}
]
},

{
"title":"Monomer",
"desc":"The small building block of a polymer is called a...",
"options":[
{
"text":"Monomer",
"correct":true,
"learns":"Monomers join together to form polymers."
},
{
"text":"Catalyst",
"correct":false,
"wrong_hint":"Catalysts speed reactions but aren't building blocks."
},
{
"text":"Electron",
"correct":false,
"wrong_hint":"Electrons are subatomic particles."
},
{
"text":"Solvent",
"correct":false,
"wrong_hint":"Solvents dissolve substances."
}
]
},

{
"title":"Double Bond",
"desc":"A carbon-carbon double bond contains...",
"options":[
{
"text":"One sigma bond and one pi bond",
"correct":true,
"learns":"Every double bond consists of one σ bond and one π bond."
},
{
"text":"Two sigma bonds",
"correct":false,
"wrong_hint":"Only one sigma bond exists."
},
{
"text":"Two pi bonds",
"correct":false,
"wrong_hint":"A double bond contains only one pi bond."
},
{
"text":"Three sigma bonds",
"correct":false,
"wrong_hint":"That's incorrect."
}
]
},

{
"title":"Organic Molecules",
"desc":"Which element is the backbone of nearly all organic molecules?",
"options":[
{
"text":"Carbon",
"correct":true,
"learns":"Carbon forms four covalent bonds, making complex molecules possible."
},
{
"text":"Helium",
"correct":false,
"wrong_hint":"Helium is chemically inert."
},
{
"text":"Gold",
"correct":false,
"wrong_hint":"Gold does not form the backbone of organic compounds."
},
{
"text":"Neon",
"correct":false,
"wrong_hint":"Neon is an inert gas."
}
]
}

]

}
