const List<String> cityList = [
  "A Coruña",
  "Aachen",
  "Aarhus",
  "Abbeville",
  "Aberdeen",
  "Abu Dhabi",
  "Acapulco",
  "Adelaide",
  "Adelboden",
  "Agadir",
  "Agde",
  "Agen",
  "Agios Nikolaos",
  "Agrigento",
  "Agropoli",
  "Aigues-Mortes",
  "Aix-en-Provence",
  "Aix-les-Bains",
  "Ajaccio",
  "Ajman",
  "Akron",
  "Al Ain",
  "Alanya",
  "Albacete",
  "Albany",
  "Albenga",
  "Albi",
  "Albufeira",
  "Albuquerque",
  "Alcudia",
  "Alessandria",
  "Ålesund",
  "Alexandria",
  "Algeciras",
  "Alghero",
  "Alicante",
  "Alkmaar",
  "Alpe d'Huez",
  "Alta Badia",
  "Altea",
  "Amalfi",
  "Amarillo",
  "Amersfoort",
  "Amiens",
  "Amsterdam",
  "Anaheim",
  "Anchorage",
  "Ancona",
  "Andalo",
  "Andermatt",
  "Andria",
  "Angers",
  "Ankara",
  "Ann Arbor",
  "Annapolis",
  "Annecy",
  "Antalya",
  "Antibes",
  "Antwerp",
  "Anzio",
  "Ao Nang",
  "Aosta",
  "Appleton",
  "Aracaju",
  "Arcachon",
  "Arenzano",
  "Arezzo",
  "Argostoli",
  "Arles",
  "Arlington, Virginia",
  "Arlington, Texas",
  "Armagh",
  "Arnhem",
  "Arosa",
  "Arras",
  "Arrecife",
  "Artà",
  "Ascoli Piceno",
  "Ashdod",
  "Ashkelon",
  "Aspen",
  "Asti",
  "Athens",
  "Athlone",
  "Atlanta",
  "Atlantic",
  "Auckland",
  "Augsburg",
  "Augusta,Georgia",
  "Augusta, Maine",
  "Aurora, Colorado",
  "Aurora, Illinois",
  "Austin",
  "Auxerre",
  "Aveiro",
  "Avellino",
  "Avignon",
  "Avoriaz",
  "Axamer Lizum",
  "Ayia Napa",
  "Bad Gastein",
  "Bad Hofgastein",
  "Baden",
  "Baiona",
  "Bakersfield",
  "Baltimore",
  "Bandar Seri Begawan",
  "Bandol",
  "Bangkok",
  "Bangor",
  "Bar",
  "Barcelona",
  "Bari",
  "Barletta",
  "Barstow",
  "Basel",
  "Bastia",
  "Bath",
  "Baton Rouge",
  "Batumi",
  "Bayonne",
  "Beaulieu-sur-Mer",
  "Beersheba",
  "Beijing",
  "Belfast",
  "Belfort",
  "Belgrade",
  "Belluno",
  "Belo Horizonte",
  "Bemidji",
  "Benalmadena",
  "Bendigo",
  "Benevento",
  "Benicàssim",
  "Benidorm",
  "Bergamo",
  "Bergen",
  "Bergerac",
  "Berkeley",
  "Berlin",
  "Bern",
  "Besançon",
  "Beverly Hills",
  "Biarritz",
  "Biel",
  "Bielefeld",
  "Biella",
  "Bilbao",
  "Billings",
  "Birmingham, UK",
  "Birmingham, U.S",
  "Bismarck",
  "Blanes",
  "Bled",
  "Blois",
  "Blumenau",
  "Boca Chica",
  "Boca Raton",
  "Bochum",
  "Bodrum",
  "Boise",
  "Bologna",
  "Bolzano",
  "Bonifacio",
  "Bonn",
  "Bordeaux",
  "Bordighera",
  "Bormio",
  "Boston",
  "Boulder",
  "Boulogne-sur-Mer",
  "Bourges",
  "Boynton Beach",
  "Bradenton",
  "Bradford",
  "Braga",
  "Brampton",
  "Brasilia",
  "Bratislava",
  "Braunschweig",
  "Breda",
  "Bregenz",
  "Brela",
  "Bremen",
  "Bremerhaven",
  "Brescia",
  "Brest",
  "Brighton",
  "Brindisi",
  "Brisbane",
  "Bristol",
  "Brixen",
  "Brixental",
  "Brno",
  "Brownsville",
  "Bruges",
  "Brussels",
  "Bucharest",
  "Budapest",
  "Budva",
  "Buenos Aires",
  "Buffalo",
  "Burgas",
  "Cabo San Lucas",
  "Cádiz",
  "Caen",
  "Cagliari",
  "Cagnes-sur-Mer",
  "Cairns",
  "Cala Bona",
  "Cala d'Or",
  "Cala Millor",
  "Cala Ratjada",
  "Calais",
  "Calella",
  "Calgary",
  "Caloundra",
  "Calp",
  "Caltanissetta",
  "Calvi",
  "Cambridge",
  "Cambrils",
  "Campinas",
  "Campobasso",
  "Can Picafort",
  "Canazei",
  "Canberra",
  "Cancun",
  "Cannes",
  "Canterbury",
  "Canyamel",
  "Capdepera",
  "Cape Canaveral",
  "Cape Coral",
  "Cape May",
  "Cape Town",
  "Carbonia",
  "Carcassonne",
  "Cardiff",
  "Carlisle",
  "Carlsbad",
  "Carpi",
  "Carpinteria",
  "Carrara",
  "Carson City",
  "Cartagena",
  "Casablanca",
  "Caserta",
  "Casper",
  "Cassis",
  "Castelrotto",
  "Catania",
  "Catanzaro",
  "Caxias do Sul",
  "Cervinia",
  "Cesena",
  "Český Krumlov",
  "Çeşme",
  "Chamonix",
  "Chandler",
  "Chania",
  "Charleroi",
  "Charleston, West Virginia",
  "Charleston, South Carolina",
  "Charlotte",
  "Charlottetown",
  "Chartres",
  "Chattanooga",
  "Chelmsford",
  "Chemnitz",
  "Cherbourg",
  "Chesapeake",
  "Chester",
  "Cheyenne",
  "Chiang Mai",
  "Chiang Rai",
  "Chiavari",
  "Chicago",
  "Chieti",
  "Chioggia",
  "Chios",
  "Chonburi",
  "Christchurch",
  "Chula Vista",
  "Chur",
  "Cincinnati",
  "Ciutadella de Menorca",
  "Civitavecchia",
  "Clearwater",
  "Clermont-Ferrand",
  "Cleveland",
  "Cocoa Beach",
  "Coconut Creek",
  "Coimbra",
  "Collioure",
  "Colmar",
  "Cologne",
  "Colorado Springs",
  "Columbia",
  "Columbus",
  "Como",
  "Concord",
  "Conil de la Frontera",
  "Copenhagen",
  "Coral Springs",
  "Córdoba, Argentina",
  "Córdoba, Spain",
  "Corfu",
  "Corinth",
  "Cork",
  "Corpus Christi",
  "Corralejo",
  "Cortina d'Ampezzo",
  "Cosenza",
  "Costa Adeje",
  "Courchevel",
  "Courmayeur",
  "Coventry",
  "Cozumel",
  "Crans-Montana",
  "Cremona",
  "Crotone",
  "Cuneo",
  "Da Nang",
  "Dallas",
  "Dana Point",
  "Darmstadt",
  "Darwin",
  "Daugavpils",
  "Davos",
  "Daytona Beach",
  "Deerfield Beach",
  "Del Mar",
  "Delft",
  "Delray Beach",
  "Denia",
  "Denver",
  "Derby",
  "Derry",
  "Des Moines",
  "Detroit",
  "Didim",
  "Dieppe",
  "Dijon",
  "Doha",
  "Dolomiti Superski",
  "Dorfgastein",
  "Dortmund",
  "Dover",
  "Dresden",
  "Dubai",
  "Dublin",
  "Dubrovnik",
  "Duisburg",
  "Duluth",
  "Dundalk",
  "Dundee",
  "Dunedin",
  "Dunkirk",
  "Durham",
  "Durham",
  "Düsseldorf",
  "Eau Claire",
  "Edinburgh",
  "Edmonton",
  "Eilat",
  "Eindhoven",
  "El Paso",
  "Elche",
  "Ellmau",
  "Elm",
  "Empuriabrava",
  "Encinitas",
  "Engelberg",
  "Enna",
  "Enschede",
  "Erfurt",
  "Erie",
  "Erlangen",
  "Esbjerg",
  "Espace Killy",
  "Essaouira",
  "Essen",
  "Estepona",
  "Eugene",
  "Exeter",
  "Faenza",
  "Falmouth",
  "Famagusta",
  "Fano",
  "Fargo",
  "Faro",
  "Fayetteville",
  "Fermo",
  "Fernandina Beach",
  "Ferrara",
  "Fethiye",
  "Fez",
  "Fieberbrunn",
  "Filzmoos",
  "Finale Ligure",
  "Fiumicino",
  "Flagstaff",
  "Flaine",
  "Florence",
  "Foggia",
  "Folgarida",
  "Fontana",
  "Forlì",
  "Fort Collins",
  "Fort Lauderdale",
  "Fort Myers",
  "Fort Wayne",
  "Fort Worth",
  "Forte dei Marmi",
  "Foz do Iguaçu",
  "Frankfort",
  "Frankfurt am Main",
  "Fredericton",
  "Freeport",
  "Freiburg",
  "Fremont",
  "Fresno",
  "Fribourg",
  "Frosinone",
  "Fuengirola",
  "Fujairah",
  "Fukuoka",
  "Funchal",
  "Gainesville",
  "Galtür",
  "Galway",
  "Garden Grove",
  "Garland",
  "Gatineau",
  "Gdansk",
  "Gdynia",
  "Geelong",
  "Gelsenkirchen",
  "Geneva",
  "Genoa",
  "George Town",
  "Ghent",
  "Gijón",
  "Gilbert",
  "Girona",
  "Glasgow",
  "Glendale, Arizona",
  "Glendale, California",
  "Gloucester",
  "Gold Coast",
  "Gorizia",
  "Dachstein-West",
  "Gothenburg",
  "Göttingen",
  "Granada",
  "Grand Prairie",
  "Grand Rapids",
  "Granville",
  "Grasse",
  "Graz",
  "Great Falls",
  "Green Bay",
  "Greensboro",
  "Grenoble",
  "Grindelwald",
  "Groningen",
  "Grossarl",
  "Grosseto",
  "Gstaad",
  "Guadalajara",
  "Guangzhou",
  "Guimarães",
  "Haarlem",
  "Haifa",
  "Halifax",
  "Halle",
  "Hamburg",
  "Hamilton, Canada",
  "Hamilton, New Zealand",
  "Hampton",
  "Hangzhou",
  "Hannover",
  "Hanoi",
  "Harrisburg",
  "Hartford",
  "Hasselt",
  "Hat Yai",
  "Havana",
  "Heidelberg",
  "Heilbronn",
  "Heiligenblut",
  "Helena",
  "Helsinki",
  "Henderson",
  "Heraklion",
  "Herceg Novi",
  "Hereford",
  "Hermosa Beach",
  "Hervey Bay",
  "Hialeah",
  "Hinterglemm",
  "Hinterstoder",
  "Hiroshima",
  "Hoi An",
  "Hobart",
  "Ho Chi Minh City",
  "Hollywood, Florida",
  "Hong Kong",
  "Honolulu",
  "Horsens",
  "Houston",
  "Hua Hin",
  "Hue",
  "Huntington Beach",
  "Huntsville",
  "Hvar",
  "Hyères",
  "Ibiza Town",
  "Imola",
  "Imperia",
  "Inca",
  "Indianapolis",
  "Ingolstadt",
  "Innsbruck",
  "Interlaken",
  "Inverness",
  "Ioannina",
  "Irvine",
  "Irving",
  "Ischgl",
  "Isernia",
  "Islamorada",
  "Istanbul",
  "İzmir",
  "Izola",
  "Jackson",
  "Jacksonville",
  "Jefferson City",
  "Jena",
  "Jerez de la Frontera",
  "Jersey City",
  "Jerusalem",
  "Johannesburg",
  "Joinville",
  "Juan-les-Pins",
  "Juiz de Fora",
  "Juneau",
  "Jungfrau",
  "Jupiter",
  "Jūrmala",
  "Kalamata",
  "Kanchanaburi",
  "Kansas City",
  "Kappl",
  "Kaprun",
  "Karlovy Vary",
  "Karlsruhe",
  "Kassel",
  "Kastoria",
  "Kaunas",
  "Kavala",
  "Kemer",
  "Key Largo",
  "Key West",
  "Khao Lak",
  "Kiel",
  "Kilkenny",
  "Kingston",
  "Kingston upon Hull",
  "Kissimmee",
  "Kitzbühel",
  "Klagenfurt",
  "Klaipėda",
  "Knoxville",
  "Kobe",
  "Koblenz",
  "Kolding",
  "Komotini",
  "Koper",
  "Kos",
  "Košice",
  "Kotor",
  "Krabi",
  "Krakow",
  "Krefeld",
  "Kuah",
  "Kuala Lumpur",
  "Kuşadası",
  "Kutná Hora",
  "Kyoto",
  "Kyrenia",
  "La Ciotat",
  "La Clusaz",
  "La Laguna",
  "La Maddalena",
  "La Manga",
  "La Plagne",
  "La Plata",
  "La Rochelle",
  "La Romana",
  "La Spezia",
  "La Thuile",
  "Laax",
  "Lagos",
  "Laguna Beach",
  "Lakeland",
  "Lamezia Terme",
  "Lancaster",
  "Lancaster, U.S.",
  "Lansing",
  "L'Aquila",
  "Laredo",
  "Largo",
  "Larnaca",
  "Las Palmas",
  "Las Vegas",
  "Latina",
  "Lausanne",
  "Laval",
  "Le Havre",
  "Le Lavandou",
  "Le Mans",
  "Lecce",
  "Lecco",
  "Lech",
  "Leeds",
  "Legnano",
  "Leicester",
  "Leiden",
  "Leipzig",
  "Leogang",
  "Les Arcs",
  "Les Deux Alpes",
  "Les Gets",
  "Les Houches",
  "Les Menuires",
  "Leuven",
  "Lexington",
  "Liberec",
  "Liège",
  "Lienz",
  "Liepāja",
  "Lille",
  "Limassol",
  "Limerick",
  "Limoges",
  "Lincoln",
  "Lincoln",
  "Lindos",
  "Linz",
  "Lisbon",
  "Lisburn",
  "Little Rock",
  "Liverpool",
  "Livigno",
  "Livorno",
  "Ljubljana",
  "Lloret de Mar",
  "Loano",
  "Locarno",
  "Lodi",
  "Lodz",
  "Logroño",
  "London, Canada",
  "London, UK",
  "Londrina",
  "Long Beach",
  "Los Angeles",
  "Los Cabos",
  "Los Cristianos",
  "Louisville",
  "Lourdes",
  "Loutraki",
  "Louvain-la-Neuve",
  "Lubbock",
  "Lübeck",
  "Lublin",
  "Lucca",
  "Lucerne",
  "Lugano",
  "Lund",
  "Lyon",
  "Maastricht",
  "Macerata",
  "Madison",
  "Madonna di Campiglio",
  "Madrid",
  "Magaluf",
  "Magdeburg",
  "Mahón",
  "Mainz",
  "Makarska",
  "Malaga",
  "Malia",
  "Malibu",
  "Malmö",
  "Manacor",
  "Manchester",
  "Manhattan Beach",
  "Mannheim",
  "Manosque",
  "Mantua",
  "Mar del Plata",
  "Marathon",
  "Marbella",
  "Maria Alm",
  "Maribor",
  "Markham",
  "Marmaris",
  "Maroochydore",
  "Marrakesh",
  "Marsala",
  "Marseille",
  "Maspalomas",
  "Massa",
  "Matera",
  "Mayrhofen",
  "Mazara del Vallo",
  "Mechelen",
  "Megève",
  "Melbourne, Australia",
  "Melbourne, U.S.",
  "Memphis",
  "Menton",
  "Merano",
  "Meribel",
  "Mérida",
  "Mesa",
  "Messina",
  "Mestre",
  "Metz",
  "Mexico City",
  "Miami",
  "Middelburg",
  "Midland",
  "Mijas",
  "Milan",
  "Millau",
  "Milwaukee",
  "Minneapolis",
  "Miramar",
  "Mississauga",
  "Moab",
  "Mobile",
  "Modena",
  "Modesto",
  "Modica",
  "Moena",
  "Mogi das Cruzes",
  "Mons",
  "Monte Rosa",
  "Montego Bay",
  "Montepulciano",
  "Monterey",
  "Montgomery",
  "Montpelier",
  "Montpellier",
  "Montreal",
  "Montreux",
  "Monza",
  "Moraira",
  "Moreno Valley",
  "Morzine",
  "Moscow",
  "Mountain View",
  "Mulhouse",
  "Munich",
  "Münster",
  "Murcia",
  "Murter",
  "Mykonos",
  "Mytilene",
  "Nafplio",
  "Nagoya",
  "Namur",
  "Nancy",
  "Nantes",
  "Napa",
  "Naples, Italy",
  "Naples, U.S.",
  "Narbonne",
  "Narva",
  "Nashville",
  "Nassau",
  "Naxos",
  "Nazareth",
  "Negril",
  "Nelson",
  "Nerja",
  "Netanya",
  "Nevers",
  "New Haven",
  "New Orleans",
  "New Smyrna Beach",
  "New York City",
  "Newark",
  "Newcastle, Australia",
  "Newcastle, UK",
  "Newport",
  "Newport Beach",
  "Newport News",
  "Nha Trang",
  "Niagara Falls",
  "Nice",
  "Nicosia",
  "Nijmegen",
  "Nimes",
  "Niort",
  "Noosa Heads",
  "Norfolk",
  "North Las Vegas",
  "North Port",
  "Norwich",
  "Nottingham",
  "Novara",
  "Novigrad",
  "Nuoro",
  "Nürnberg",
  "Nyon",
  "Oakland",
  "Oaxaca",
  "Obergurgl",
  "Oberhausen",
  "Ocala",
  "Oceanside",
  "Ocho Rios",
  "Odense",
  "Odessa",
  "Ogden",
  "Oia",
  "Oklahoma City",
  "Olbia",
  "Oldenburg",
  "Olomouc",
  "Olympia",
  "Omaha",
  "Opatija",
  "Oristano",
  "Orlando",
  "Orléans",
  "Ortisei",
  "Osaka",
  "Oslo",
  "Osnabrück",
  "Ostrava",
  "Ottawa",
  "Oulu",
  "Overland Park",
  "Oviedo",
  "Oxford",
  "Oxnard",
  "Paderborn",
  "Padova",
  "Palanga",
  "Palavas-les-Flots",
  "Palermo",
  "Palm Bay",
  "Palm Beach",
  "Palma de Mallorca",
  "Palma Nova",
  "Palmetto",
  "Palo Alto",
  "Pamplona",
  "Panama City, U.S",
  "Paphos",
  "Paradiski",
  "Paralia",
  "Parikia",
  "Paris",
  "Parma",
  "Pärnu",
  "Pasadena",
  "Passo del Tonale",
  "Passo Rolle",
  "Patras",
  "Pattaya",
  "Pau",
  "Pavia",
  "Peguera",
  "Pembroke Pines",
  "Pensacola",
  "Perast",
  "Perpignan",
  "Perros-Guirec",
  "Perth",
  "Perugia",
  "Pesaro",
  "Pescara",
  "Pescasseroli",
  "Petah Tikva",
  "Peterborough",
  "Petrovac",
  "Pforzheim",
  "Phang Nga",
  "Phetchabun",
  "Philadelphia",
  "Phoenix",
  "Phuket City",
  "Piacenza",
  "Pierre",
  "Piraeus",
  "Piran",
  "Pisa",
  "Pistoia",
  "Pittsburgh",
  "Plano",
  "Playa Blanca",
  "Playa de las Américas",
  "Playa del Carmen",
  "Plovdiv",
  "Plymouth",
  "Plzeň",
  "Podgorica",
  "Poitiers",
  "Pollença",
  "Pompano Beach",
  "Pontevedra",
  "Pordenone",
  "Poreč",
  "Port Charlotte",
  "Port St. Lucie",
  "Portimão",
  "Portland, Oregon",
  "Portland, Maine",
  "Porto",
  "Porto Cervo",
  "Porto Cristo",
  "Porto Torres",
  "Portocolom",
  "Portofino",
  "Portorož",
  "Porto-Vecchio",
  "Portsmouth, UK",
  "Portsmouth, U.S",
  "Positano",
  "Potenza",
  "Potsdam",
  "Poznan",
  "Pozzuoli",
  "Prague",
  "Praia da Rocha",
  "Prato",
  "Preston",
  "Pretoria",
  "Propriano",
  "Protaras",
  "Providence",
  "Provo",
  "Puerto de la Cruz",
  "Puerto Plata",
  "Puerto Rico de Gran Canaria",
  "Puerto Vallarta",
  "Pula",
  "Punta Cana",
  "Punta Gorda",
  "Pyeongchang",
  "Quarteira",
  "Quebec",
  "Quimper",
  "Rabat",
  "Ragusa",
  "Railay Beach",
  "Raleigh",
  "Rancho Cucamonga",
  "Randers",
  "Rapallo",
  "Rapid City",
  "Ras al-Khaimah",
  "Ravello",
  "Ravenna",
  "Rayong",
  "Redding",
  "Redondo Beach",
  "Regensburg",
  "Reggio Calabria",
  "Reggio Emilia",
  "Regina",
  "Rehovot",
  "Reims",
  "Rennes",
  "Reno",
  "Rethymno",
  "Reus",
  "Reutlingen",
  "Reykjavik",
  "Rhodes",
  "Richmond",
  "Rieti",
  "Riga",
  "Rijeka",
  "Rimini",
  "Rio de Janeiro",
  "Riomaggiore",
  "Rishon LeZion",
  "Riverside",
  "Riviera Maya",
  "Roanoke",
  "Rochester, Minnesota",
  "Rochester, New York",
  "Rodez",
  "Rome",
  "Rosario",
  "Roskilde",
  "Rostock",
  "Rotterdam",
  "Roubaix",
  "Rouen",
  "Rovigo",
  "Rovinj",
  "Sa Coma",
  "Saalbach",
  "Saarbrücken",
  "Saas-Fee",
  "Sacramento",
  "Saint Paul",
  "Saint Petersburg",
  "Saint-Brieuc",
  "Saint-Jean-Cap-Ferrat",
  "Saint-Malo",
  "Saint-Tropez",
  "Salamanca",
  "Salem, Oregon",
  "Salem, Massachusetts",
  "Salerno",
  "Salinas",
  "Salou",
  "Salt Lake City",
  "Salta",
  "Salvador",
  "Salzburg",
  "Samaná",
  "San Antonio",
  "San Bernardino",
  "San Clemente",
  "San Diego",
  "San Francisco",
  "San Jose",
  "San Juan",
  "San Mateo",
  "San Sebastián",
  "Sanford",
  "Sanremo",
  "Sant Antoni de Portmany",
  "Santa Ana",
  "Santa Barbara",
  "Santa Clara",
  "Santa Clarita",
  "Santa Cruz",
  "Santa Cruz de Tenerife",
  "Santa Eulària des Riu",
  "Santa Fe",
  "Santa Margherita Ligure",
  "Santa Monica",
  "Santa Pola",
  "Santa Ponsa",
  "Santa Rosa",
  "Santander",
  "Santiago",
  "Santiago de Compostela",
  "Santo Domingo",
  "Sao Paulo",
  "Sapporo",
  "Sarasota",
  "Saskatoon",
  "Sassari",
  "Saumur",
  "Savannah",
  "Savona",
  "Schaffhausen",
  "Schladming",
  "Scottsdale",
  "Seal Beach",
  "Seattle",
  "Sedona",
  "Seefeld",
  "Segovia",
  "Seoul",
  "Serre Chevalier",
  "Seville",
  "Shanghai",
  "Sharjah",
  "Sheffield",
  "Shenzhen",
  "Shreveport",
  "Šiauliai",
  "Šibenik",
  "Side",
  "Siegen",
  "Siena",
  "Singapore",
  "Sion",
  "Sioux Falls",
  "Sitges",
  "Skiathos",
  "Sofia",
  "Sölden",
  "Söll",
  "Soller",
  "Sondrio",
  "Sopot",
  "Sorocaba",
  "Sorrento",
  "Southampton",
  "Split",
  "Spokane",
  "Springfield, Illinois",
  "Springfield, Massachusetts",
  "Springfield, Missouri",
  "Springfield, Oregon",
  "St Albans",
  "St. Anton",
  "St. Augustine",
  "St. Gallen",
  "St. George",
  "St. John's",
  "St. Louis",
  "St. Moritz",
  "St. Petersburg, U.S.",
  "Stavanger",
  "Stockholm",
  "Stockton",
  "Stoke-on-Trent",
  "Strasbourg",
  "Stuttgart",
  "Sukhothai",
  "Sunderland",
  "Sunnyvale",
  "Sunshine Coast",
  "Superior",
  "Surrey",
  "Sveti Stefan",
  "Swansea",
  "Sydney",
  "Syracuse, Italy",
  "Syracuse, U.S.",
  "Szczecin",
  "",
  "Tacoma",
  "Tallahassee",
  "Tallinn",
  "Tampa",
  "Tampere",
  "Tamworth",
  "Tangier",
  "Taormina",
  "Taranto",
  "Tarifa",
  "Tarragona",
  "Tartu",
  "Tauplitz",
  "Tauranga",
  "Tavira",
  "Tbilisi",
  "Tel Aviv",
  "Temecula",
  "Tempe",
  "Teramo",
  "Terni",
  "The Hague",
  "Thessaloniki",
  "Tignes",
  "Tijuana",
  "Tilburg",
  "Tinos",
  "Tivat",
  "Tivoli",
  "Tokyo",
  "Toledo, Spain",
  "Toledo, U.S",
  "Toowoomba",
  "Topeka",
  "Toronto",
  "Torre del Greco",
  "Torre del Mar",
  "Torremolinos",
  "Torrevieja",
  "Toruń",
  "Tossa de Mar",
  "Toulon",
  "Toulouse",
  "Tours",
  "Townsville",
  "Trani",
  "Trapani",
  "Trento",
  "Trenton",
  "Treviso",
  "Trier",
  "Trieste",
  "Trogir",
  "Tromsø",
  "Trondheim",
  "Troy",
  "Troyes",
  "Tucson",
  "Tui",
  "Tulsa",
  "Tulum",
  "Turin",
  "Turku",
  "Twin Falls",
  "Udine",
  "Udon Thani",
  "Ulcinj",
  "Ulm",
  "Umag",
  "Uppsala",
  "Urbino",
  "Ushuaia",
  "Utrecht",
  "Val d’Isère",
  "Val di Fassa",
  "Val Gardena",
  "Val Thorens",
  "Valence",
  "Valencia",
  "Valladolid",
  "Valle Isarco",
  "Valletta",
  "Vancouver Canada",
  "Vancouver, U.S.",
  "Varazze",
  "Varese",
  "Varna",
  "Vaughan",
  "Vejle",
  "Venice, Italy",
  "Venice, U.S",
  "Ventimiglia",
  "Ventspils",
  "Ventura",
  "Verbania",
  "Verbier",
  "Vercelli",
  "Vero Beach",
  "Verona",
  "Versailles",
  "Vevey",
  "Viareggio",
  "Vibo Valentia",
  "Viborg",
  "Vicenza",
  "Vichy",
  "Victoria",
  "Vienna",
  "Vigo",
  "Vilamoura",
  "Villach",
  "Villefranche-sur-Mer",
  "Vilnius",
  "Virginia Beach",
  "Viterbo",
  "Vitoria-Gasteiz",
  "Volos",
  "Vrsar",
  "Wakefield",
  "Warsaw",
  "Warth",
  "Washington D.C.",
  "Waterford",
  "Wellington, New Zealand",
  "Wellington, U.S",
  "Wengen",
  "West Palm Beach",
  "Westendorf",
  "Westminster",
  "Weston",
  "Wichita",
  "Wiesbaden",
  "Wilmington",
  "Winchester",
  "Windsor",
  "Winnipeg",
  "Winston–Salem",
  "Winterthur",
  "Wolfsburg",
  "Wollongong",
  "Wolverhampton",
  "Worcester, UK",
  "Worcester, U.S",
  "Wroclaw",
  "Wuppertal",
  "Würzburg",
  "Yakima",
  "Yokohama",
  "Yonkers",
  "York",
  "Yuma",
  "Zadar",
  "Zagreb",
  "Zakopane",
  "Zaragoza",
  "Zell am See",
  "Zell am Ziller",
  "Zermatt",
  "Zug",
  "Zurich"
];