local MOD = DugisGuideViewer
local _
local MapOverlays = MOD:RegisterModule("MapOverlays")
MapOverlays.essential = true
local harvestingDataMode = false

local HBDMigrate = LibStub("HereBeDragons-Migrate-Dugis")

function MapOverlays:Initialize()
	local defaults = {
		global = {
	overlayData = {
	[119] = {
    {
        ["offsetX"]=272,
        ["textureHeight"] = 276,
        ["textureWidth"] = 186,
        ["offsetY"] = 237,
        ["fileDataIDs"] = { 270870,270743 } 
    },
    {
        ["offsetX"]=662,
        ["textureHeight"] = 209,
        ["textureWidth"] = 203,
        ["offsetY"] = 11,
        ["fileDataIDs"] = { 270848 } 
    },
    {
        ["offsetX"]=325,
        ["textureHeight"] = 214,
        ["textureWidth"] = 244,
        ["offsetY"] = 140,
        ["fileDataIDs"] = { 270785 } 
    },
    {
        ["offsetX"]=397,
        ["textureHeight"] = 319,
        ["textureWidth"] = 244,
        ["offsetY"] = 66,
        ["fileDataIDs"] = { 270900,270819 } 
    },
    {
        ["offsetX"]=457,
        ["textureHeight"] = 302,
        ["textureWidth"] = 259,
        ["offsetY"] = 264,
        ["fileDataIDs"] = { 270903,270781,270794,270855 } 
    },
    {
        ["offsetX"]=329,
        ["textureHeight"] = 278,
        ["textureWidth"] = 260,
        ["offsetY"] = 237,
        ["fileDataIDs"] = { 270851,270871,270795,270769 } 
    },
    {
        ["offsetX"]=153,
        ["textureHeight"] = 378,
        ["textureWidth"] = 267,
        ["offsetY"] = 238,
        ["fileDataIDs"] = { 270822,270894,270835,270784 } 
    },
    {
        ["offsetX"]=707,
        ["textureHeight"] = 279,
        ["textureWidth"] = 289,
        ["offsetY"] = 181,
        ["fileDataIDs"] = { 270765,270824,270887,270801 } 
    },
    {
        ["offsetX"]=712,
        ["textureHeight"] = 292,
        ["textureWidth"] = 290,
        ["offsetY"] = 15,
        ["fileDataIDs"] = { 270826,270865,270759,270763 } 
    },
    {
        ["offsetX"]=480,
        ["textureHeight"] = 342,
        ["textureWidth"] = 375,
        ["offsetY"] = 0,
        ["fileDataIDs"] = { 270869,270890,270764,270762 } 
    },
    {
        ["offsetX"]=293,
        ["textureHeight"] = 258,
        ["textureWidth"] = 382,
        ["offsetY"] = 383,
        ["fileDataIDs"] = { 270761,270879,270880,270787 } 
    },
    {
        ["offsetX"]=509,
        ["textureHeight"] = 316,
        ["textureWidth"] = 385,
        ["offsetY"] = 214,
        ["fileDataIDs"] = { 270898,270840,270899,270812 } 
    },
    {
        ["offsetX"]=314,
        ["textureHeight"] = 203,
        ["textureWidth"] = 396,
        ["offsetY"] = 0,
        ["fileDataIDs"] = { 270806,270810 } 
    },
    {
        ["offsetX"]=50,
        ["textureHeight"] = 381,
        ["textureWidth"] = 460,
        ["offsetY"] = 0,
        ["fileDataIDs"] = { 270821,270758,270797,270775 } 
    }
},
[120] = {
    {
        ["offsetX"]=374,
        ["textureHeight"] = 211,
        ["textureWidth"] = 188,
        ["offsetY"] = 208,
        ["fileDataIDs"] = { 271192 } 
    },
    {
        ["offsetX"]=543,
        ["textureHeight"] = 218,
        ["textureWidth"] = 196,
        ["offsetY"] = 362,
        ["fileDataIDs"] = { 271358 } 
    },
    {
        ["offsetX"]=403,
        ["textureHeight"] = 219,
        ["textureWidth"] = 213,
        ["offsetY"] = 0,
        ["fileDataIDs"] = { 271232 } 
    },
    {
        ["offsetX"]=614,
        ["textureHeight"] = 261,
        ["textureWidth"] = 214,
        ["offsetY"] = 358,
        ["fileDataIDs"] = { 271313,271133 } 
    },
    {
        ["offsetX"]=661,
        ["textureHeight"] = 212,
        ["textureWidth"] = 226,
        ["offsetY"] = 264,
        ["fileDataIDs"] = { 271378 } 
    },
    {
        ["offsetX"]=487,
        ["textureHeight"] = 259,
        ["textureWidth"] = 229,
        ["offsetY"] = 0,
        ["fileDataIDs"] = { 271146,271257 } 
    },
    {
        ["offsetX"]=42,
        ["textureHeight"] = 299,
        ["textureWidth"] = 229,
        ["offsetY"] = 187,
        ["fileDataIDs"] = { 271267,271201 } 
    },
    {
        ["offsetX"]=134,
        ["textureHeight"] = 337,
        ["textureWidth"] = 235,
        ["offsetY"] = 165,
        ["fileDataIDs"] = { 271254,271233 } 
    },
    {
        ["offsetX"]=569,
        ["textureHeight"] = 354,
        ["textureWidth"] = 235,
        ["offsetY"] = 7,
        ["fileDataIDs"] = { 271149,271222 } 
    },
    {
        ["offsetX"]=258,
        ["textureHeight"] = 218,
        ["textureWidth"] = 236,
        ["offsetY"] = 203,
        ["fileDataIDs"] = { 271170 } 
    },
    {
        ["offsetX"]=433,
        ["textureHeight"] = 225,
        ["textureWidth"] = 258,
        ["offsetY"] = 118,
        ["fileDataIDs"] = { 271239,271157 } 
    },
    {
        ["offsetX"]=703,
        ["textureHeight"] = 278,
        ["textureWidth"] = 299,
        ["offsetY"] = 7,
        ["fileDataIDs"] = { 271351,271270,271175,271330 } 
    },
    {
        ["offsetX"]=698,
        ["textureHeight"] = 286,
        ["textureWidth"] = 301,
        ["offsetY"] = 332,
        ["fileDataIDs"] = { 271280,271346,271164,271387 } 
    },
    {
        ["offsetX"]=256,
        ["textureHeight"] = 203,
        ["textureWidth"] = 304,
        ["offsetY"] = 104,
        ["fileDataIDs"] = { 271352,271244 } 
    },
    {
        ["offsetX"]=210,
        ["textureHeight"] = 242,
        ["textureWidth"] = 306,
        ["offsetY"] = 0,
        ["fileDataIDs"] = { 271187,271231 } 
    },
    {
        ["offsetX"]=691,
        ["textureHeight"] = 272,
        ["textureWidth"] = 311,
        ["offsetY"] = 160,
        ["fileDataIDs"] = { 271333,271199,271364,271162 } 
    },
    {
        ["offsetX"]=453,
        ["textureHeight"] = 353,
        ["textureWidth"] = 317,
        ["offsetY"] = 219,
        ["fileDataIDs"] = { 271205,271248,271252,271236 } 
    },
    {
        ["offsetX"]=217,
        ["textureHeight"] = 300,
        ["textureWidth"] = 356,
        ["offsetY"] = 313,
        ["fileDataIDs"] = { 271322,271298,271290,271337 } 
    }
},
[121] = {
    {
        ["offsetX"]=232,
        ["textureHeight"] = 235,
        ["textureWidth"] = 249,
        ["offsetY"] = 129,
        ["fileDataIDs"] = { 271764 } 
    },
    {
        ["offsetX"]=18,
        ["textureHeight"] = 207,
        ["textureWidth"] = 274,
        ["offsetY"] = 461,
        ["fileDataIDs"] = { 271794,271778 } 
    },
    {
        ["offsetX"]=217,
        ["textureHeight"] = 290,
        ["textureWidth"] = 278,
        ["offsetY"] = 244,
        ["fileDataIDs"] = { 271801,271773,271779,271806 } 
    },
    {
        ["offsetX"]=176,
        ["textureHeight"] = 247,
        ["textureWidth"] = 283,
        ["offsetY"] = 421,
        ["fileDataIDs"] = { 271789,271812 } 
    },
    {
        ["offsetX"]=358,
        ["textureHeight"] = 227,
        ["textureWidth"] = 294,
        ["offsetY"] = 187,
        ["fileDataIDs"] = { 271785,271817 } 
    },
    {
        ["offsetX"]=548,
        ["textureHeight"] = 265,
        ["textureWidth"] = 324,
        ["offsetY"] = 137,
        ["fileDataIDs"] = { 271790,271765,271766,271767 } 
    },
    {
        ["offsetX"]=331,
        ["textureHeight"] = 260,
        ["textureWidth"] = 328,
        ["offsetY"] = 32,
        ["fileDataIDs"] = { 271809,271771,271772,271776 } 
    },
    {
        ["offsetX"]=509,
        ["textureHeight"] = 246,
        ["textureWidth"] = 329,
        ["offsetY"] = 0,
        ["fileDataIDs"] = { 271769,271770 } 
    },
    {
        ["offsetX"]=17,
        ["textureHeight"] = 294,
        ["textureWidth"] = 332,
        ["offsetY"] = 307,
        ["fileDataIDs"] = { 271768,271783,271795,271810 } 
    },
    {
        ["offsetX"]=607,
        ["textureHeight"] = 284,
        ["textureWidth"] = 351,
        ["offsetY"] = 41,
        ["fileDataIDs"] = { 271791,271807,271774,271796 } 
    },
    {
        ["offsetX"]=7,
        ["textureHeight"] = 224,
        ["textureWidth"] = 356,
        ["offsetY"] = 207,
        ["fileDataIDs"] = { 271781,271784 } 
    },
    {
        ["offsetX"]=0,
        ["textureHeight"] = 285,
        ["textureWidth"] = 382,
        ["offsetY"] = 46,
        ["fileDataIDs"] = { 271792,271775,271813,271797 } 
    },
    {
        ["offsetX"]=547,
        ["textureHeight"] = 400,
        ["textureWidth"] = 455,
        ["offsetY"] = 257,
        ["fileDataIDs"] = { 271798,271780,271814,271799 } 
    },
    {
        ["offsetX"]=312,
        ["textureHeight"] = 362,
        ["textureWidth"] = 475,
        ["offsetY"] = 294,
        ["fileDataIDs"] = { 271803,271788,271816,271805 } 
    }
},
[122] = {
    {
        ["offsetX"]=576,
        ["textureHeight"] = 173,
        ["textureWidth"] = 174,
        ["offsetY"] = 170,
        ["fileDataIDs"] = { 271946 } 
    },
    {
        ["offsetX"]=342,
        ["textureHeight"] = 191,
        ["textureWidth"] = 177,
        ["offsetY"] = 351,
        ["fileDataIDs"] = { 271992 } 
    },
    {
        ["offsetX"]=595,
        ["textureHeight"] = 208,
        ["textureWidth"] = 178,
        ["offsetY"] = 240,
        ["fileDataIDs"] = { 271945 } 
    },
    {
        ["offsetX"]=490,
        ["textureHeight"] = 178,
        ["textureWidth"] = 181,
        ["offsetY"] = 161,
        ["fileDataIDs"] = { 271993 } 
    },
    {
        ["offsetX"]=397,
        ["textureHeight"] = 263,
        ["textureWidth"] = 187,
        ["offsetY"] = 208,
        ["fileDataIDs"] = { 271980,271994 } 
    },
    {
        ["offsetX"]=668,
        ["textureHeight"] = 201,
        ["textureWidth"] = 193,
        ["offsetY"] = 223,
        ["fileDataIDs"] = { 271950 } 
    },
    {
        ["offsetX"]=283,
        ["textureHeight"] = 256,
        ["textureWidth"] = 213,
        ["offsetY"] = 203,
        ["fileDataIDs"] = { 271976 } 
    },
    {
        ["offsetX"]=222,
        ["textureHeight"] = 168,
        ["textureWidth"] = 222,
        ["offsetY"] = 100,
        ["fileDataIDs"] = { 271959 } 
    },
    {
        ["offsetX"]=354,
        ["textureHeight"] = 209,
        ["textureWidth"] = 223,
        ["offsetY"] = 0,
        ["fileDataIDs"] = { 271957 } 
    },
    {
        ["offsetX"]=664,
        ["textureHeight"] = 338,
        ["textureWidth"] = 223,
        ["offsetY"] = 25,
        ["fileDataIDs"] = { 271956,271974 } 
    },
    {
        ["offsetX"]=585,
        ["textureHeight"] = 216,
        ["textureWidth"] = 232,
        ["offsetY"] = 336,
        ["fileDataIDs"] = { 271941 } 
    },
    {
        ["offsetX"]=343,
        ["textureHeight"] = 232,
        ["textureWidth"] = 238,
        ["offsetY"] = 108,
        ["fileDataIDs"] = { 271984 } 
    },
    {
        ["offsetX"]=225,
        ["textureHeight"] = 189,
        ["textureWidth"] = 242,
        ["offsetY"] = 0,
        ["fileDataIDs"] = { 271954 } 
    },
    {
        ["offsetX"]=621,
        ["textureHeight"] = 305,
        ["textureWidth"] = 244,
        ["offsetY"] = 327,
        ["fileDataIDs"] = { 271969,271989 } 
    },
    {
        ["offsetX"]=477,
        ["textureHeight"] = 382,
        ["textureWidth"] = 248,
        ["offsetY"] = 216,
        ["fileDataIDs"] = { 271985,271968 } 
    },
    {
        ["offsetX"]=490,
        ["textureHeight"] = 192,
        ["textureWidth"] = 251,
        ["offsetY"] = 0,
        ["fileDataIDs"] = { 271970 } 
    },
    {
        ["offsetX"]=99,
        ["textureHeight"] = 265,
        ["textureWidth"] = 263,
        ["offsetY"] = 37,
        ["fileDataIDs"] = { 271940,271975,271953,271991 } 
    },
    {
        ["offsetX"]=420,
        ["textureHeight"] = 210,
        ["textureWidth"] = 266,
        ["offsetY"] = 57,
        ["fileDataIDs"] = { 271952,271967 } 
    },
    {
        ["offsetX"]=415,
        ["textureHeight"] = 308,
        ["textureWidth"] = 284,
        ["offsetY"] = 360,
        ["fileDataIDs"] = { 271997,271998,271963,271964 } 
    },
    {
        ["offsetX"]=572,
        ["textureHeight"] = 306,
        ["textureWidth"] = 298,
        ["offsetY"] = 0,
        ["fileDataIDs"] = { 271977,271978,271979,271958 } 
    },
    {
        ["offsetX"]=99,
        ["textureHeight"] = 265,
        ["textureWidth"] = 333,
        ["offsetY"] = 278,
        ["fileDataIDs"] = { 271962,271987,271983,271988 } 
    },
    {
        ["offsetX"]=90,
        ["textureHeight"] = 220,
        ["textureWidth"] = 347,
        ["offsetY"] = 180,
        ["fileDataIDs"] = { 271986,271960 } 
    },
    {
        ["offsetX"]=168,
        ["textureHeight"] = 258,
        ["textureWidth"] = 350,
        ["offsetY"] = 410,
        ["fileDataIDs"] = { 271965,271966,271972,271973 } 
    }
},
[123] = {
    {
        ["offsetX"]=0,
        ["textureHeight"] = 268,
        ["textureWidth"] = 204,
        ["offsetY"] = 167,
        ["fileDataIDs"] = { 254677,254678 } 
    },
    {
        ["offsetX"]=218,
        ["textureHeight"] = 283,
        ["textureWidth"] = 219,
        ["offsetY"] = 291,
        ["fileDataIDs"] = { 254688,254689 } 
    },
    {
        ["offsetX"]=444,
        ["textureHeight"] = 207,
        ["textureWidth"] = 223,
        ["offsetY"] = 276,
        ["fileDataIDs"] = { 254695 } 
    },
    {
        ["offsetX"]=321,
        ["textureHeight"] = 399,
        ["textureWidth"] = 223,
        ["offsetY"] = 15,
        ["fileDataIDs"] = { 254690,254691 } 
    },
    {
        ["offsetX"]=327,
        ["textureHeight"] = 210,
        ["textureWidth"] = 227,
        ["offsetY"] = 305,
        ["fileDataIDs"] = { 254687 } 
    },
    {
        ["offsetX"]=217,
        ["textureHeight"] = 240,
        ["textureWidth"] = 238,
        ["offsetY"] = 50,
        ["fileDataIDs"] = { 254692 } 
    },
    {
        ["offsetX"]=690,
        ["textureHeight"] = 239,
        ["textureWidth"] = 245,
        ["offsetY"] = 267,
        ["fileDataIDs"] = { 254679 } 
    },
    {
        ["offsetX"]=538,
        ["textureHeight"] = 243,
        ["textureWidth"] = 248,
        ["offsetY"] = 181,
        ["fileDataIDs"] = { 254684 } 
    },
    {
        ["offsetX"]=715,
        ["textureHeight"] = 217,
        ["textureWidth"] = 269,
        ["offsetY"] = 390,
        ["fileDataIDs"] = { 254693,254694 } 
    },
    {
        ["offsetX"]=558,
        ["textureHeight"] = 231,
        ["textureWidth"] = 283,
        ["offsetY"] = 329,
        ["fileDataIDs"] = { 254685,254686 } 
    },
    {
        ["offsetX"]=626,
        ["textureHeight"] = 343,
        ["textureWidth"] = 300,
        ["offsetY"] = 31,
        ["fileDataIDs"] = { 254680,254681,254682,254683 } 
    },
    {
        ["offsetX"]=392,
        ["textureHeight"] = 202,
        ["textureWidth"] = 308,
        ["offsetY"] = 466,
        ["fileDataIDs"] = { 254659,254660 } 
    },
    {
        ["offsetX"]=342,
        ["textureHeight"] = 212,
        ["textureWidth"] = 308,
        ["offsetY"] = 392,
        ["fileDataIDs"] = { 254657,254658 } 
    },
    {
        ["offsetX"]=616,
        ["textureHeight"] = 224,
        ["textureWidth"] = 314,
        ["offsetY"] = 30,
        ["fileDataIDs"] = { 294026,294027 } 
    },
    {
        ["offsetX"]=355,
        ["textureHeight"] = 375,
        ["textureWidth"] = 373,
        ["offsetY"] = 37,
        ["fileDataIDs"] = { 254653,254654,254655,254656 } 
    },
    {
        ["offsetX"]=22,
        ["textureHeight"] = 474,
        ["textureWidth"] = 393,
        ["offsetY"] = 122,
        ["fileDataIDs"] = { 254673,254674,254675,254676 } 
    }
},
[124] = {
    {
        ["offsetX"]=427,
        ["textureHeight"] = 235,
        ["textureWidth"] = 207,
        ["offsetY"] = 244,
        ["fileDataIDs"] = { 272524 } 
    },
    {
        ["offsetX"]=705,
        ["textureHeight"] = 286,
        ["textureWidth"] = 233,
        ["offsetY"] = 236,
        ["fileDataIDs"] = { 272529,272506 } 
    },
    {
        ["offsetX"]=265,
        ["textureHeight"] = 313,
        ["textureWidth"] = 239,
        ["offsetY"] = 355,
        ["fileDataIDs"] = { 272530,272516 } 
    },
    {
        ["offsetX"]=172,
        ["textureHeight"] = 248,
        ["textureWidth"] = 249,
        ["offsetY"] = 135,
        ["fileDataIDs"] = { 272507 } 
    },
    {
        ["offsetX"]=138,
        ["textureHeight"] = 288,
        ["textureWidth"] = 268,
        ["offsetY"] = 58,
        ["fileDataIDs"] = { 272517,272534,272496,272502 } 
    },
    {
        ["offsetX"]=396,
        ["textureHeight"] = 229,
        ["textureWidth"] = 293,
        ["offsetY"] = 51,
        ["fileDataIDs"] = { 272500,272501 } 
    },
    {
        ["offsetX"]=308,
        ["textureHeight"] = 327,
        ["textureWidth"] = 294,
        ["offsetY"] = 34,
        ["fileDataIDs"] = { 272523,272487,272539,272532 } 
    },
    {
        ["offsetX"]=501,
        ["textureHeight"] = 369,
        ["textureWidth"] = 312,
        ["offsetY"] = 134,
        ["fileDataIDs"] = { 272494,272495,272504,272533 } 
    },
    {
        ["offsetX"]=596,
        ["textureHeight"] = 265,
        ["textureWidth"] = 322,
        ["offsetY"] = 92,
        ["fileDataIDs"] = { 272521,272515,272522,272499 } 
    },
    {
        ["offsetX"]=76,
        ["textureHeight"] = 293,
        ["textureWidth"] = 329,
        ["offsetY"] = 375,
        ["fileDataIDs"] = { 272509,272491,272520,272484 } 
    },
    {
        ["offsetX"]=82,
        ["textureHeight"] = 316,
        ["textureWidth"] = 455,
        ["offsetY"] = 186,
        ["fileDataIDs"] = { 272535,272518,272490,272519 } 
    },
    {
        ["offsetX"]=359,
        ["textureHeight"] = 329,
        ["textureWidth"] = 468,
        ["offsetY"] = 339,
        ["fileDataIDs"] = { 272498,272531,272510,272541 } 
    }
},
[125] = {
    {
        ["offsetX"]=239,
        ["textureHeight"] = 164,
        ["textureWidth"] = 169,
        ["offsetY"] = 301,
        ["fileDataIDs"] = { 272922 } 
    },
    {
        ["offsetX"]=214,
        ["textureHeight"] = 239,
        ["textureWidth"] = 180,
        ["offsetY"] = 144,
        ["fileDataIDs"] = { 272933 } 
    },
    {
        ["offsetX"]=570,
        ["textureHeight"] = 270,
        ["textureWidth"] = 182,
        ["offsetY"] = 113,
        ["fileDataIDs"] = { 272927,272910 } 
    },
    {
        ["offsetX"]=395,
        ["textureHeight"] = 191,
        ["textureWidth"] = 184,
        ["offsetY"] = 470,
        ["fileDataIDs"] = { 272909 } 
    },
    {
        ["offsetX"]=162,
        ["textureHeight"] = 232,
        ["textureWidth"] = 205,
        ["offsetY"] = 143,
        ["fileDataIDs"] = { 272920 } 
    },
    {
        ["offsetX"]=316,
        ["textureHeight"] = 179,
        ["textureWidth"] = 210,
        ["offsetY"] = 296,
        ["fileDataIDs"] = { 272945 } 
    },
    {
        ["offsetX"]=108,
        ["textureHeight"] = 200,
        ["textureWidth"] = 221,
        ["offsetY"] = 206,
        ["fileDataIDs"] = { 272906 } 
    },
    {
        ["offsetX"]=98,
        ["textureHeight"] = 158,
        ["textureWidth"] = 228,
        ["offsetY"] = 318,
        ["fileDataIDs"] = { 272924 } 
    },
    {
        ["offsetX"]=134,
        ["textureHeight"] = 220,
        ["textureWidth"] = 244,
        ["offsetY"] = 429,
        ["fileDataIDs"] = { 272919 } 
    },
    {
        ["offsetX"]=242,
        ["textureHeight"] = 200,
        ["textureWidth"] = 251,
        ["offsetY"] = 468,
        ["fileDataIDs"] = { 272921 } 
    },
    {
        ["offsetX"]=339,
        ["textureHeight"] = 298,
        ["textureWidth"] = 305,
        ["offsetY"] = 370,
        ["fileDataIDs"] = { 272904,272925,272926,272952 } 
    },
    {
        ["offsetX"]=627,
        ["textureHeight"] = 484,
        ["textureWidth"] = 306,
        ["offsetY"] = 179,
        ["fileDataIDs"] = { 272934,272923,272908,272930 } 
    },
    {
        ["offsetX"]=481,
        ["textureHeight"] = 383,
        ["textureWidth"] = 309,
        ["offsetY"] = 285,
        ["fileDataIDs"] = { 272939,272953,272905,272935 } 
    },
    {
        ["offsetX"]=109,
        ["textureHeight"] = 195,
        ["textureWidth"] = 322,
        ["offsetY"] = 375,
        ["fileDataIDs"] = { 272948,272950 } 
    },
    {
        ["offsetX"]=292,
        ["textureHeight"] = 341,
        ["textureWidth"] = 363,
        ["offsetY"] = 122,
        ["fileDataIDs"] = { 272912,272913,272914,272946 } 
    },
    {
        ["offsetX"]=218,
        ["textureHeight"] = 265,
        ["textureWidth"] = 369,
        ["offsetY"] = 0,
        ["fileDataIDs"] = { 272943,272944,272931,272917 } 
    }
},
[126] = {
    {
        ["offsetX"]=174,
        ["textureHeight"] = 291,
        ["textureWidth"] = 218,
        ["offsetY"] = 191,
        ["fileDataIDs"] = { 273324,273292 } 
    },
    {
        ["offsetX"]=288,
        ["textureHeight"] = 248,
        ["textureWidth"] = 237,
        ["offsetY"] = 168,
        ["fileDataIDs"] = { 273329 } 
    },
    {
        ["offsetX"]=431,
        ["textureHeight"] = 304,
        ["textureWidth"] = 247,
        ["offsetY"] = 127,
        ["fileDataIDs"] = { 273322,273320 } 
    },
    {
        ["offsetX"]=479,
        ["textureHeight"] = 258,
        ["textureWidth"] = 249,
        ["offsetY"] = 241,
        ["fileDataIDs"] = { 273304,273305 } 
    },
    {
        ["offsetX"]=607,
        ["textureHeight"] = 288,
        ["textureWidth"] = 261,
        ["offsetY"] = 251,
        ["fileDataIDs"] = { 273309,273286,273310,273328 } 
    },
    {
        ["offsetX"]=533,
        ["textureHeight"] = 257,
        ["textureWidth"] = 265,
        ["offsetY"] = 345,
        ["fileDataIDs"] = { 273296,273300,273285,273287 } 
    },
    {
        ["offsetX"]=289,
        ["textureHeight"] = 254,
        ["textureWidth"] = 266,
        ["offsetY"] = 287,
        ["fileDataIDs"] = { 273330,273291 } 
    },
    {
        ["offsetX"]=0,
        ["textureHeight"] = 268,
        ["textureWidth"] = 272,
        ["offsetY"] = 247,
        ["fileDataIDs"] = { 273318,273298,273336,273303 } 
    },
    {
        ["offsetX"]=326,
        ["textureHeight"] = 265,
        ["textureWidth"] = 286,
        ["offsetY"] = 358,
        ["fileDataIDs"] = { 273311,273297,273331,273317 } 
    },
    {
        ["offsetX"]=380,
        ["textureHeight"] = 231,
        ["textureWidth"] = 302,
        ["offsetY"] = 437,
        ["fileDataIDs"] = { 273323,273289 } 
    },
    {
        ["offsetX"]=7,
        ["textureHeight"] = 256,
        ["textureWidth"] = 307,
        ["offsetY"] = 412,
        ["fileDataIDs"] = { 273326,273333 } 
    },
    {
        ["offsetX"]=575,
        ["textureHeight"] = 317,
        ["textureWidth"] = 311,
        ["offsetY"] = 88,
        ["fileDataIDs"] = { 273325,273307,273308,273319 } 
    },
    {
        ["offsetX"]=181,
        ["textureHeight"] = 305,
        ["textureWidth"] = 321,
        ["offsetY"] = 363,
        ["fileDataIDs"] = { 273312,273332,273282,273302 } 
    },
    {
        ["offsetX"]=629,
        ["textureHeight"] = 297,
        ["textureWidth"] = 336,
        ["offsetY"] = 0,
        ["fileDataIDs"] = { 273295,273301,273321,273288 } 
    }
},
[132] = {
    {
        ["offsetX"]=0,
        ["textureHeight"] = 260,
        ["textureWidth"] = 252,
        ["offsetY"] = 91,
        ["fileDataIDs"] = { 270966,271005 } 
    },
    {
        ["offsetX"]=0,
        ["textureHeight"] = 303,
        ["textureWidth"] = 264,
        ["offsetY"] = 176,
        ["fileDataIDs"] = { 270987,270962,270973,270997 } 
    },
    {
        ["offsetX"]=0,
        ["textureHeight"] = 222,
        ["textureWidth"] = 288,
        ["offsetY"] = 0,
        ["fileDataIDs"] = { 253268,271000 } 
    },
    {
        ["offsetX"]=0,
        ["textureHeight"] = 424,
        ["textureWidth"] = 416,
        ["offsetY"] = 244,
        ["fileDataIDs"] = { 270970,270961,270971,270996 } 
    },
    {
        ["offsetX"]=536,
        ["textureHeight"] = 369,
        ["textureWidth"] = 446,
        ["offsetY"] = 40,
        ["fileDataIDs"] = { 253267,270960,270995,270989 } 
    },
    {
        ["offsetX"]=500,
        ["textureHeight"] = 477,
        ["textureWidth"] = 502,
        ["offsetY"] = 105,
        ["fileDataIDs"] = { 253269,270985,253270,270986 } 
    },
    {
        ["offsetX"]=129,
        ["textureHeight"] = 668,
        ["textureWidth"] = 544,
        ["offsetY"] = 0,
        ["fileDataIDs"] = { 253264,271003,270968,270965,253265,253266,271002,271004,270984 } 
    },
    {
        ["offsetX"]=444,
        ["textureHeight"] = 285,
        ["textureWidth"] = 558,
        ["offsetY"] = 383,
        ["fileDataIDs"] = { 253271,253272,270974,270975,271001,270980 } 
    }
},
[1194] = {
    {
        ["offsetX"]=464,
        ["textureHeight"] = 110,
        ["textureWidth"] = 128,
        ["offsetY"] = 33,
        ["fileDataIDs"] = { 271427 } 
    },
    {
        ["offsetX"]=413,
        ["textureHeight"] = 120,
        ["textureWidth"] = 160,
        ["offsetY"] = 476,
        ["fileDataIDs"] = { 2212659 } 
    },
    {
        ["offsetX"]=474,
        ["textureHeight"] = 190,
        ["textureWidth"] = 160,
        ["offsetY"] = 384,
        ["fileDataIDs"] = { 271426 } 
    },
    {
        ["offsetX"]=462,
        ["textureHeight"] = 180,
        ["textureWidth"] = 190,
        ["offsetY"] = 286,
        ["fileDataIDs"] = { 271440 } 
    },
    {
        ["offsetX"]=327,
        ["textureHeight"] = 200,
        ["textureWidth"] = 190,
        ["offsetY"] = 60,
        ["fileDataIDs"] = { 271439 } 
    },
    {
        ["offsetX"]=549,
        ["textureHeight"] = 240,
        ["textureWidth"] = 200,
        ["offsetY"] = 427,
        ["fileDataIDs"] = { 271437 } 
    },
    {
        ["offsetX"]=427,
        ["textureHeight"] = 160,
        ["textureWidth"] = 210,
        ["offsetY"] = 78,
        ["fileDataIDs"] = { 271428 } 
    },
    {
        ["offsetX"]=355,
        ["textureHeight"] = 215,
        ["textureWidth"] = 215,
        ["offsetY"] = 320,
        ["fileDataIDs"] = { 271443 } 
    },
    {
        ["offsetX"]=432,
        ["textureHeight"] = 230,
        ["textureWidth"] = 220,
        ["offsetY"] = 170,
        ["fileDataIDs"] = { 271421 } 
    },
    {
        ["offsetX"]=301,
        ["textureHeight"] = 230,
        ["textureWidth"] = 230,
        ["offsetY"] = 189,
        ["fileDataIDs"] = { 271422 } 
    },
    {
        ["offsetX"]=244,
        ["textureHeight"] = 160,
        ["textureWidth"] = 445,
        ["offsetY"] = 0,
        ["fileDataIDs"] = { 271435,271442 } 
    }
},
[1200] = {
    {
        ["offsetX"]=473,
        ["textureHeight"] = 120,
        ["textureWidth"] = 128,
        ["offsetY"] = 260,
        ["fileDataIDs"] = { 272185 } 
    },
    {
        ["offsetX"]=379,
        ["textureHeight"] = 155,
        ["textureWidth"] = 128,
        ["offsetY"] = 242,
        ["fileDataIDs"] = { 272178 } 
    },
    {
        ["offsetX"]=303,
        ["textureHeight"] = 205,
        ["textureWidth"] = 128,
        ["offsetY"] = 307,
        ["fileDataIDs"] = { 272176 } 
    },
    {
        ["offsetX"]=458,
        ["textureHeight"] = 128,
        ["textureWidth"] = 170,
        ["offsetY"] = 369,
        ["fileDataIDs"] = { 272180 } 
    },
    {
        ["offsetX"]=291,
        ["textureHeight"] = 128,
        ["textureWidth"] = 185,
        ["offsetY"] = 0,
        ["fileDataIDs"] = { 272172 } 
    },
    {
        ["offsetX"]=395,
        ["textureHeight"] = 128,
        ["textureWidth"] = 205,
        ["offsetY"] = 0,
        ["fileDataIDs"] = { 272179 } 
    },
    {
        ["offsetX"]=502,
        ["textureHeight"] = 230,
        ["textureWidth"] = 205,
        ["offsetY"] = 16,
        ["fileDataIDs"] = { 272169 } 
    },
    {
        ["offsetX"]=255,
        ["textureHeight"] = 180,
        ["textureWidth"] = 210,
        ["offsetY"] = 214,
        ["fileDataIDs"] = { 272181 } 
    },
    {
        ["offsetX"]=428,
        ["textureHeight"] = 240,
        ["textureWidth"] = 215,
        ["offsetY"] = 80,
        ["fileDataIDs"] = { 272177 } 
    },
    {
        ["offsetX"]=532,
        ["textureHeight"] = 235,
        ["textureWidth"] = 225,
        ["offsetY"] = 238,
        ["fileDataIDs"] = { 272186 } 
    },
    {
        ["offsetX"]=523,
        ["textureHeight"] = 190,
        ["textureWidth"] = 256,
        ["offsetY"] = 356,
        ["fileDataIDs"] = { 272170 } 
    },
    {
        ["offsetX"]=367,
        ["textureHeight"] = 200,
        ["textureWidth"] = 256,
        ["offsetY"] = 303,
        ["fileDataIDs"] = { 272173 } 
    },
    {
        ["offsetX"]=249,
        ["textureHeight"] = 240,
        ["textureWidth"] = 280,
        ["offsetY"] = 59,
        ["fileDataIDs"] = { 272187,272171 } 
    },
    {
        ["offsetX"]=270,
        ["textureHeight"] = 243,
        ["textureWidth"] = 470,
        ["offsetY"] = 425,
        ["fileDataIDs"] = { 272168,272165 } 
    }
},
[1202] = {
    {
        ["offsetX"]=581,
        ["textureHeight"] = 100,
        ["textureWidth"] = 95,
        ["offsetY"] = 247,
        ["fileDataIDs"] = { 270573 } 
    },
    {
        ["offsetX"]=564,
        ["textureHeight"] = 165,
        ["textureWidth"] = 100,
        ["offsetY"] = 52,
        ["fileDataIDs"] = { 270569 } 
    },
    {
        ["offsetX"]=507,
        ["textureHeight"] = 110,
        ["textureWidth"] = 115,
        ["offsetY"] = 294,
        ["fileDataIDs"] = { 852702 } 
    },
    {
        ["offsetX"]=555,
        ["textureHeight"] = 110,
        ["textureWidth"] = 120,
        ["offsetY"] = 0,
        ["fileDataIDs"] = { 270553 } 
    },
    {
        ["offsetX"]=384,
        ["textureHeight"] = 125,
        ["textureWidth"] = 120,
        ["offsetY"] = 115,
        ["fileDataIDs"] = { 270560 } 
    },
    {
        ["offsetX"]=492,
        ["textureHeight"] = 115,
        ["textureWidth"] = 125,
        ["offsetY"] = 63,
        ["fileDataIDs"] = { 270584 } 
    },
    {
        ["offsetX"]=556,
        ["textureHeight"] = 125,
        ["textureWidth"] = 125,
        ["offsetY"] = 189,
        ["fileDataIDs"] = { 270585 } 
    },
    {
        ["offsetX"]=442,
        ["textureHeight"] = 165,
        ["textureWidth"] = 125,
        ["offsetY"] = 298,
        ["fileDataIDs"] = { 852696 } 
    },
    {
        ["offsetX"]=412,
        ["textureHeight"] = 100,
        ["textureWidth"] = 128,
        ["offsetY"] = 0,
        ["fileDataIDs"] = { 852705 } 
    },
    {
        ["offsetX"]=419,
        ["textureHeight"] = 105,
        ["textureWidth"] = 128,
        ["offsetY"] = 63,
        ["fileDataIDs"] = { 270554 } 
    },
    {
        ["offsetX"]=306,
        ["textureHeight"] = 128,
        ["textureWidth"] = 128,
        ["offsetY"] = 130,
        ["fileDataIDs"] = { 852699 } 
    },
    {
        ["offsetX"]=341,
        ["textureHeight"] = 128,
        ["textureWidth"] = 128,
        ["offsetY"] = 537,
        ["fileDataIDs"] = { 852704 } 
    },
    {
        ["offsetX"]=431,
        ["textureHeight"] = 128,
        ["textureWidth"] = 128,
        ["offsetY"] = 479,
        ["fileDataIDs"] = { 852694 } 
    },
    {
        ["offsetX"]=498,
        ["textureHeight"] = 128,
        ["textureWidth"] = 140,
        ["offsetY"] = 119,
        ["fileDataIDs"] = { 270574 } 
    },
    {
        ["offsetX"]=365,
        ["textureHeight"] = 125,
        ["textureWidth"] = 145,
        ["offsetY"] = 350,
        ["fileDataIDs"] = { 852697 } 
    },
    {
        ["offsetX"]=527,
        ["textureHeight"] = 120,
        ["textureWidth"] = 150,
        ["offsetY"] = 307,
        ["fileDataIDs"] = { 852701 } 
    },
    {
        ["offsetX"]=407,
        ["textureHeight"] = 115,
        ["textureWidth"] = 155,
        ["offsetY"] = 553,
        ["fileDataIDs"] = { 852703 } 
    },
    {
        ["offsetX"]=335,
        ["textureHeight"] = 128,
        ["textureWidth"] = 155,
        ["offsetY"] = 462,
        ["fileDataIDs"] = { 852695 } 
    },
    {
        ["offsetX"]=481,
        ["textureHeight"] = 128,
        ["textureWidth"] = 155,
        ["offsetY"] = 211,
        ["fileDataIDs"] = { 270565 } 
    },
    {
        ["offsetX"]=431,
        ["textureHeight"] = 155,
        ["textureWidth"] = 155,
        ["offsetY"] = 118,
        ["fileDataIDs"] = { 270559 } 
    },
    {
        ["offsetX"]=456,
        ["textureHeight"] = 120,
        ["textureWidth"] = 170,
        ["offsetY"] = 0,
        ["fileDataIDs"] = { 270564 } 
    },
    {
        ["offsetX"]=365,
        ["textureHeight"] = 185,
        ["textureWidth"] = 175,
        ["offsetY"] = 177,
        ["fileDataIDs"] = { 852700 } 
    },
    {
        ["offsetX"]=317,
        ["textureHeight"] = 145,
        ["textureWidth"] = 200,
        ["offsetY"] = 29,
        ["fileDataIDs"] = { 270572 } 
    },
    {
        ["offsetX"]=340,
        ["textureHeight"] = 185,
        ["textureWidth"] = 200,
        ["offsetY"] = 234,
        ["fileDataIDs"] = { 852693 } 
    },
    {
        ["offsetX"]=355,
        ["textureHeight"] = 150,
        ["textureWidth"] = 210,
        ["offsetY"] = 402,
        ["fileDataIDs"] = { 852698 } 
    }
},
[1205] = {
    {
        ["offsetX"]=225,
        ["textureHeight"] = 175,
        ["textureWidth"] = 160,
        ["offsetY"] = 478,
        ["fileDataIDs"] = { 768731 } 
    },
    {
        ["offsetX"]=314,
        ["textureHeight"] = 197,
        ["textureWidth"] = 165,
        ["offsetY"] = 471,
        ["fileDataIDs"] = { 768752 } 
    },
    {
        ["offsetX"]=317,
        ["textureHeight"] = 170,
        ["textureWidth"] = 190,
        ["offsetY"] = 372,
        ["fileDataIDs"] = { 768732 } 
    },
    {
        ["offsetX"]=399,
        ["textureHeight"] = 288,
        ["textureWidth"] = 195,
        ["offsetY"] = 380,
        ["fileDataIDs"] = { 768721,768722 } 
    },
    {
        ["offsetX"]=406,
        ["textureHeight"] = 200,
        ["textureWidth"] = 200,
        ["offsetY"] = 279,
        ["fileDataIDs"] = { 768730 } 
    },
    {
        ["offsetX"]=196,
        ["textureHeight"] = 280,
        ["textureWidth"] = 220,
        ["offsetY"] = 131,
        ["fileDataIDs"] = { 768738,769205 } 
    },
    {
        ["offsetX"]=462,
        ["textureHeight"] = 200,
        ["textureWidth"] = 235,
        ["offsetY"] = 77,
        ["fileDataIDs"] = { 768753 } 
    },
    {
        ["offsetX"]=270,
        ["textureHeight"] = 255,
        ["textureWidth"] = 255,
        ["offsetY"] = 197,
        ["fileDataIDs"] = { 768739 } 
    },
    {
        ["offsetX"]=462,
        ["textureHeight"] = 320,
        ["textureWidth"] = 255,
        ["offsetY"] = 307,
        ["fileDataIDs"] = { 768744,768745 } 
    },
    {
        ["offsetX"]=334,
        ["textureHeight"] = 240,
        ["textureWidth"] = 280,
        ["offsetY"] = 162,
        ["fileDataIDs"] = { 768723,769200 } 
    },
    {
        ["offsetX"]=276,
        ["textureHeight"] = 230,
        ["textureWidth"] = 285,
        ["offsetY"] = 0,
        ["fileDataIDs"] = { 768728,768729 } 
    },
    {
        ["offsetX"]=26,
        ["textureHeight"] = 300,
        ["textureWidth"] = 300,
        ["offsetY"] = 262,
        ["fileDataIDs"] = { 769201,769202,769203,769204 } 
    },
    {
        ["offsetX"]=44,
        ["textureHeight"] = 265,
        ["textureWidth"] = 330,
        ["offsetY"] = 403,
        ["fileDataIDs"] = { 768734,768735,768736,768737 } 
    },
    {
        ["offsetX"]=626,
        ["textureHeight"] = 370,
        ["textureWidth"] = 350,
        ["offsetY"] = 253,
        ["fileDataIDs"] = { 768717,768718,768719,768720 } 
    },
    {
        ["offsetX"]=549,
        ["textureHeight"] = 300,
        ["textureWidth"] = 370,
        ["offsetY"] = 105,
        ["fileDataIDs"] = { 768748,768749,768750,768751 } 
    }
},
[1206] = {
    {
        ["offsetX"]=558,
        ["textureHeight"] = 230,
        ["textureWidth"] = 160,
        ["offsetY"] = 112,
        ["fileDataIDs"] = { 270360 } 
    },
    {
        ["offsetX"]=419,
        ["textureHeight"] = 155,
        ["textureWidth"] = 170,
        ["offsetY"] = 293,
        ["fileDataIDs"] = { 2212546 } 
    },
    {
        ["offsetX"]=370,
        ["textureHeight"] = 225,
        ["textureWidth"] = 175,
        ["offsetY"] = 186,
        ["fileDataIDs"] = { 270352 } 
    },
    {
        ["offsetX"]=472,
        ["textureHeight"] = 210,
        ["textureWidth"] = 180,
        ["offsetY"] = 165,
        ["fileDataIDs"] = { 270350 } 
    },
    {
        ["offsetX"]=138,
        ["textureHeight"] = 210,
        ["textureWidth"] = 190,
        ["offsetY"] = 54,
        ["fileDataIDs"] = { 270347 } 
    },
    {
        ["offsetX"]=87,
        ["textureHeight"] = 240,
        ["textureWidth"] = 190,
        ["offsetY"] = 138,
        ["fileDataIDs"] = { 2212539 } 
    },
    {
        ["offsetX"]=355,
        ["textureHeight"] = 220,
        ["textureWidth"] = 200,
        ["offsetY"] = 412,
        ["fileDataIDs"] = { 270348 } 
    },
    {
        ["offsetX"]=655,
        ["textureHeight"] = 250,
        ["textureWidth"] = 205,
        ["offsetY"] = 120,
        ["fileDataIDs"] = { 270336 } 
    },
    {
        ["offsetX"]=286,
        ["textureHeight"] = 185,
        ["textureWidth"] = 210,
        ["offsetY"] = 310,
        ["fileDataIDs"] = { 270346 } 
    },
    {
        ["offsetX"]=559,
        ["textureHeight"] = 210,
        ["textureWidth"] = 215,
        ["offsetY"] = 333,
        ["fileDataIDs"] = { 270353 } 
    },
    {
        ["offsetX"]=432,
        ["textureHeight"] = 235,
        ["textureWidth"] = 215,
        ["offsetY"] = 362,
        ["fileDataIDs"] = { 270342 } 
    },
    {
        ["offsetX"]=531,
        ["textureHeight"] = 195,
        ["textureWidth"] = 230,
        ["offsetY"] = 276,
        ["fileDataIDs"] = { 270343 } 
    },
    {
        ["offsetX"]=192,
        ["textureHeight"] = 240,
        ["textureWidth"] = 230,
        ["offsetY"] = 90,
        ["fileDataIDs"] = { 270351 } 
    },
    {
        ["offsetX"]=108,
        ["textureHeight"] = 230,
        ["textureWidth"] = 240,
        ["offsetY"] = 287,
        ["fileDataIDs"] = { 270358 } 
    },
    {
        ["offsetX"]=232,
        ["textureHeight"] = 245,
        ["textureWidth"] = 245,
        ["offsetY"] = 145,
        ["fileDataIDs"] = { 270349 } 
    },
    {
        ["offsetX"]=171,
        ["textureHeight"] = 215,
        ["textureWidth"] = 256,
        ["offsetY"] = 424,
        ["fileDataIDs"] = { 270361 } 
    }
},
[1207] = {
    {
        ["offsetX"]=325,
        ["textureHeight"] = 200,
        ["textureWidth"] = 195,
        ["offsetY"] = 148,
        ["fileDataIDs"] = { 270543 } 
    },
    {
        ["offsetX"]=445,
        ["textureHeight"] = 195,
        ["textureWidth"] = 200,
        ["offsetY"] = 120,
        ["fileDataIDs"] = { 270532 } 
    },
    {
        ["offsetX"]=551,
        ["textureHeight"] = 220,
        ["textureWidth"] = 220,
        ["offsetY"] = 48,
        ["fileDataIDs"] = { 270530 } 
    },
    {
        ["offsetX"]=349,
        ["textureHeight"] = 230,
        ["textureWidth"] = 230,
        ["offsetY"] = 256,
        ["fileDataIDs"] = { 2212608 } 
    },
    {
        ["offsetX"]=389,
        ["textureHeight"] = 205,
        ["textureWidth"] = 245,
        ["offsetY"] = 7,
        ["fileDataIDs"] = { 2212606 } 
    },
    {
        ["offsetX"]=498,
        ["textureHeight"] = 205,
        ["textureWidth"] = 245,
        ["offsetY"] = 209,
        ["fileDataIDs"] = { 2212592 } 
    },
    {
        ["offsetX"]=501,
        ["textureHeight"] = 280,
        ["textureWidth"] = 255,
        ["offsetY"] = 341,
        ["fileDataIDs"] = { 270540,270527 } 
    },
    {
        ["offsetX"]=0,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 148,
        ["fileDataIDs"] = { 2212593 } 
    },
    {
        ["offsetX"]=12,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 428,
        ["fileDataIDs"] = { 270520 } 
    },
    {
        ["offsetX"]=17,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 310,
        ["fileDataIDs"] = { 270529 } 
    },
    {
        ["offsetX"]=148,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 384,
        ["fileDataIDs"] = { 2212599 } 
    },
    {
        ["offsetX"]=345,
        ["textureHeight"] = 270,
        ["textureWidth"] = 265,
        ["offsetY"] = 389,
        ["fileDataIDs"] = { 270522,270550,270528,270536 } 
    },
    {
        ["offsetX"]=159,
        ["textureHeight"] = 275,
        ["textureWidth"] = 270,
        ["offsetY"] = 199,
        ["fileDataIDs"] = { 270525,270521,2212603,2212605 } 
    },
    {
        ["offsetX"]=611,
        ["textureHeight"] = 455,
        ["textureWidth"] = 370,
        ["offsetY"] = 110,
        ["fileDataIDs"] = { 270534,270551,270546,270535 } 
    }
},
[1209] = {
    {
        ["offsetX"]=405,
        ["textureHeight"] = 145,
        ["textureWidth"] = 170,
        ["offsetY"] = 123,
        ["fileDataIDs"] = { 391431 } 
    },
    {
        ["offsetX"]=472,
        ["textureHeight"] = 200,
        ["textureWidth"] = 170,
        ["offsetY"] = 9,
        ["fileDataIDs"] = { 391433 } 
    },
    {
        ["offsetX"]=310,
        ["textureHeight"] = 155,
        ["textureWidth"] = 185,
        ["offsetY"] = 133,
        ["fileDataIDs"] = { 391425 } 
    },
    {
        ["offsetX"]=559,
        ["textureHeight"] = 190,
        ["textureWidth"] = 185,
        ["offsetY"] = 30,
        ["fileDataIDs"] = { 391432 } 
    },
    {
        ["offsetX"]=361,
        ["textureHeight"] = 180,
        ["textureWidth"] = 195,
        ["offsetY"] = 15,
        ["fileDataIDs"] = { 391435 } 
    },
    {
        ["offsetX"]=501,
        ["textureHeight"] = 170,
        ["textureWidth"] = 225,
        ["offsetY"] = 140,
        ["fileDataIDs"] = { 391430 } 
    },
    {
        ["offsetX"]=361,
        ["textureHeight"] = 195,
        ["textureWidth"] = 245,
        ["offsetY"] = 195,
        ["fileDataIDs"] = { 391434 } 
    },
    {
        ["offsetX"]=453,
        ["textureHeight"] = 220,
        ["textureWidth"] = 265,
        ["offsetY"] = 259,
        ["fileDataIDs"] = { 391437,391436 } 
    },
    {
        ["offsetX"]=212,
        ["textureHeight"] = 450,
        ["textureWidth"] = 384,
        ["offsetY"] = 178,
        ["fileDataIDs"] = { 391429,391428,391427,391426 } 
    }
},
[1210] = {
    {
        ["offsetX"]=537,
        ["textureHeight"] = 256,
        ["textureWidth"] = 128,
        ["offsetY"] = 299,
        ["fileDataIDs"] = { 273015 } 
    },
    {
        ["offsetX"]=474,
        ["textureHeight"] = 128,
        ["textureWidth"] = 150,
        ["offsetY"] = 327,
        ["fileDataIDs"] = { 273016 } 
    },
    {
        ["offsetX"]=694,
        ["textureHeight"] = 128,
        ["textureWidth"] = 173,
        ["offsetY"] = 289,
        ["fileDataIDs"] = { 273000 } 
    },
    {
        ["offsetX"]=497,
        ["textureHeight"] = 220,
        ["textureWidth"] = 174,
        ["offsetY"] = 145,
        ["fileDataIDs"] = { 273020 } 
    },
    {
        ["offsetX"]=689,
        ["textureHeight"] = 247,
        ["textureWidth"] = 175,
        ["offsetY"] = 104,
        ["fileDataIDs"] = { 272996 } 
    },
    {
        ["offsetX"]=395,
        ["textureHeight"] = 128,
        ["textureWidth"] = 186,
        ["offsetY"] = 277,
        ["fileDataIDs"] = { 2213434 } 
    },
    {
        ["offsetX"]=587,
        ["textureHeight"] = 288,
        ["textureWidth"] = 201,
        ["offsetY"] = 139,
        ["fileDataIDs"] = { 273009,273002 } 
    },
    {
        ["offsetX"]=746,
        ["textureHeight"] = 189,
        ["textureWidth"] = 211,
        ["offsetY"] = 125,
        ["fileDataIDs"] = { 2213425 } 
    },
    {
        ["offsetX"]=630,
        ["textureHeight"] = 179,
        ["textureWidth"] = 216,
        ["offsetY"] = 326,
        ["fileDataIDs"] = { 273006 } 
    },
    {
        ["offsetX"]=698,
        ["textureHeight"] = 205,
        ["textureWidth"] = 230,
        ["offsetY"] = 362,
        ["fileDataIDs"] = { 2213418 } 
    },
    {
        ["offsetX"]=757,
        ["textureHeight"] = 214,
        ["textureWidth"] = 237,
        ["offsetY"] = 205,
        ["fileDataIDs"] = { 272999 } 
    },
    {
        ["offsetX"]=363,
        ["textureHeight"] = 199,
        ["textureWidth"] = 243,
        ["offsetY"] = 349,
        ["fileDataIDs"] = { 273003 } 
    },
    {
        ["offsetX"]=227,
        ["textureHeight"] = 205,
        ["textureWidth"] = 245,
        ["offsetY"] = 328,
        ["fileDataIDs"] = { 273001 } 
    },
    {
        ["offsetX"]=239,
        ["textureHeight"] = 156,
        ["textureWidth"] = 256,
        ["offsetY"] = 250,
        ["fileDataIDs"] = { 273017 } 
    },
    {
        ["offsetX"]=335,
        ["textureHeight"] = 210,
        ["textureWidth"] = 256,
        ["offsetY"] = 139,
        ["fileDataIDs"] = { 273019 } 
    },
    {
        ["offsetX"]=463,
        ["textureHeight"] = 235,
        ["textureWidth"] = 315,
        ["offsetY"] = 361,
        ["fileDataIDs"] = { 2213428,2213430 } 
    }
},
[1211] = {
    {
        ["offsetX"]=391,
        ["textureHeight"] = 125,
        ["textureWidth"] = 140,
        ["offsetY"] = 446,
        ["fileDataIDs"] = { 2213067 } 
    },
    {
        ["offsetX"]=470,
        ["textureHeight"] = 170,
        ["textureWidth"] = 160,
        ["offsetY"] = 261,
        ["fileDataIDs"] = { 272598 } 
    },
    {
        ["offsetX"]=382,
        ["textureHeight"] = 185,
        ["textureWidth"] = 165,
        ["offsetY"] = 252,
        ["fileDataIDs"] = { 272616 } 
    },
    {
        ["offsetX"]=402,
        ["textureHeight"] = 165,
        ["textureWidth"] = 175,
        ["offsetY"] = 65,
        ["fileDataIDs"] = { 2213080 } 
    },
    {
        ["offsetX"]=323,
        ["textureHeight"] = 128,
        ["textureWidth"] = 180,
        ["offsetY"] = 128,
        ["fileDataIDs"] = { 2213065 } 
    },
    {
        ["offsetX"]=457,
        ["textureHeight"] = 185,
        ["textureWidth"] = 180,
        ["offsetY"] = 144,
        ["fileDataIDs"] = { 2213082 } 
    },
    {
        ["offsetX"]=286,
        ["textureHeight"] = 165,
        ["textureWidth"] = 185,
        ["offsetY"] = 37,
        ["fileDataIDs"] = { 272610 } 
    },
    {
        ["offsetX"]=352,
        ["textureHeight"] = 160,
        ["textureWidth"] = 210,
        ["offsetY"] = 168,
        ["fileDataIDs"] = { 272620 } 
    },
    {
        ["offsetX"]=379,
        ["textureHeight"] = 215,
        ["textureWidth"] = 210,
        ["offsetY"] = 447,
        ["fileDataIDs"] = { 272609 } 
    },
    {
        ["offsetX"]=364,
        ["textureHeight"] = 160,
        ["textureWidth"] = 220,
        ["offsetY"] = 359,
        ["fileDataIDs"] = { 272613 } 
    },
    {
        ["offsetX"]=491,
        ["textureHeight"] = 180,
        ["textureWidth"] = 240,
        ["offsetY"] = 417,
        ["fileDataIDs"] = { 272599 } 
    },
    {
        ["offsetX"]=494,
        ["textureHeight"] = 240,
        ["textureWidth"] = 240,
        ["offsetY"] = 262,
        ["fileDataIDs"] = { 272614 } 
    },
    {
        ["offsetX"]=593,
        ["textureHeight"] = 215,
        ["textureWidth"] = 250,
        ["offsetY"] = 74,
        ["fileDataIDs"] = { 272600 } 
    },
    {
        ["offsetX"]=465,
        ["textureHeight"] = 160,
        ["textureWidth"] = 256,
        ["offsetY"] = 0,
        ["fileDataIDs"] = { 2213063 } 
    },
    {
        ["offsetX"]=459,
        ["textureHeight"] = 220,
        ["textureWidth"] = 256,
        ["offsetY"] = 13,
        ["fileDataIDs"] = { 2213084 } 
    }
},
[1212] = {
    {
        ["offsetX"]=300,
        ["textureHeight"] = 125,
        ["textureWidth"] = 160,
        ["offsetY"] = 311,
        ["fileDataIDs"] = { 273113 } 
    },
    {
        ["offsetX"]=566,
        ["textureHeight"] = 200,
        ["textureWidth"] = 160,
        ["offsetY"] = 198,
        ["fileDataIDs"] = { 273121 } 
    },
    {
        ["offsetX"]=600,
        ["textureHeight"] = 165,
        ["textureWidth"] = 170,
        ["offsetY"] = 412,
        ["fileDataIDs"] = { 273107 } 
    },
    {
        ["offsetX"]=451,
        ["textureHeight"] = 190,
        ["textureWidth"] = 170,
        ["offsetY"] = 323,
        ["fileDataIDs"] = { 273102 } 
    },
    {
        ["offsetX"]=520,
        ["textureHeight"] = 205,
        ["textureWidth"] = 180,
        ["offsetY"] = 250,
        ["fileDataIDs"] = { 273094 } 
    },
    {
        ["offsetX"]=590,
        ["textureHeight"] = 340,
        ["textureWidth"] = 205,
        ["offsetY"] = 86,
        ["fileDataIDs"] = { 273122,273103 } 
    },
    {
        ["offsetX"]=381,
        ["textureHeight"] = 150,
        ["textureWidth"] = 220,
        ["offsetY"] = 265,
        ["fileDataIDs"] = { 2212523 } 
    },
    {
        ["offsetX"]=382,
        ["textureHeight"] = 180,
        ["textureWidth"] = 220,
        ["offsetY"] = 164,
        ["fileDataIDs"] = { 273114 } 
    },
    {
        ["offsetX"]=137,
        ["textureHeight"] = 185,
        ["textureWidth"] = 225,
        ["offsetY"] = 293,
        ["fileDataIDs"] = { 273120 } 
    },
    {
        ["offsetX"]=260,
        ["textureHeight"] = 230,
        ["textureWidth"] = 285,
        ["offsetY"] = 355,
        ["fileDataIDs"] = { 2212522,2212521 } 
    },
    {
        ["offsetX"]=355,
        ["textureHeight"] = 206,
        ["textureWidth"] = 300,
        ["offsetY"] = 462,
        ["fileDataIDs"] = { 273108,273101 } 
    },
    {
        ["offsetX"]=307,
        ["textureHeight"] = 288,
        ["textureWidth"] = 340,
        ["offsetY"] = 16,
        ["fileDataIDs"] = { 273095,273111,273100,273090 } 
    },
    {
        ["offsetX"]=504,
        ["textureHeight"] = 270,
        ["textureWidth"] = 370,
        ["offsetY"] = 343,
        ["fileDataIDs"] = { 273119,273092,273112,273093 } 
    }
},
[1213] = {
    {
        ["offsetX"]=279,
        ["textureHeight"] = 179,
        ["textureWidth"] = 256,
        ["offsetY"] = 467,
        ["fileDataIDs"] = { 271514 } 
    },
    {
        ["offsetX"]=142,
        ["textureHeight"] = 191,
        ["textureWidth"] = 256,
        ["offsetY"] = 455,
        ["fileDataIDs"] = { 271512 } 
    },
    {
        ["offsetX"]=687,
        ["textureHeight"] = 197,
        ["textureWidth"] = 256,
        ["offsetY"] = 449,
        ["fileDataIDs"] = { 271553 } 
    },
    {
        ["offsetX"]=474,
        ["textureHeight"] = 205,
        ["textureWidth"] = 256,
        ["offsetY"] = 412,
        ["fileDataIDs"] = { 271532 } 
    },
    {
        ["offsetX"]=164,
        ["textureHeight"] = 243,
        ["textureWidth"] = 256,
        ["offsetY"] = 0,
        ["fileDataIDs"] = { 271529 } 
    },
    {
        ["offsetX"]=49,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 76,
        ["fileDataIDs"] = { 271522 } 
    },
    {
        ["offsetX"]=126,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 338,
        ["fileDataIDs"] = { 271551 } 
    },
    {
        ["offsetX"]=241,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 239,
        ["fileDataIDs"] = { 271536 } 
    },
    {
        ["offsetX"]=261,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 379,
        ["fileDataIDs"] = { 271548 } 
    },
    {
        ["offsetX"]=379,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 323,
        ["fileDataIDs"] = { 271543 } 
    },
    {
        ["offsetX"]=392,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 14,
        ["fileDataIDs"] = { 271535 } 
    },
    {
        ["offsetX"]=412,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 177,
        ["fileDataIDs"] = { 271523 } 
    },
    {
        ["offsetX"]=427,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 87,
        ["fileDataIDs"] = { 271521 } 
    },
    {
        ["offsetX"]=471,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 345,
        ["fileDataIDs"] = { 271544 } 
    },
    {
        ["offsetX"]=562,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 219,
        ["fileDataIDs"] = { 271542 } 
    },
    {
        ["offsetX"]=584,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 8,
        ["fileDataIDs"] = { 271554 } 
    },
    {
        ["offsetX"]=590,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 106,
        ["fileDataIDs"] = { 271520 } 
    },
    {
        ["offsetX"]=656,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 277,
        ["fileDataIDs"] = { 271533 } 
    },
    {
        ["offsetX"]=692,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 144,
        ["fileDataIDs"] = { 271537 } 
    },
    {
        ["offsetX"]=590,
        ["textureHeight"] = 288,
        ["textureWidth"] = 256,
        ["offsetY"] = 269,
        ["fileDataIDs"] = { 2212700,4357862 } 
    },
    {
        ["offsetX"]=0,
        ["textureHeight"] = 384,
        ["textureWidth"] = 256,
        ["offsetY"] = 209,
        ["fileDataIDs"] = { 2212705,2212706 } 
    },
    {
        ["offsetX"]=718,
        ["textureHeight"] = 450,
        ["textureWidth"] = 284,
        ["offsetY"] = 218,
        ["fileDataIDs"] = { 4357864,4357866,4357868,4357870 } 
    },
    {
        ["offsetX"]=139,
        ["textureHeight"] = 288,
        ["textureWidth"] = 384,
        ["offsetY"] = 61,
        ["fileDataIDs"] = { 271518,271527,2212703,2212704 } 
    }
},
[1214] = {
    {
        ["offsetX"]=109,
        ["textureHeight"] = 100,
        ["textureWidth"] = 125,
        ["offsetY"] = 482,
        ["fileDataIDs"] = { 271904 } 
    },
    {
        ["offsetX"]=175,
        ["textureHeight"] = 200,
        ["textureWidth"] = 165,
        ["offsetY"] = 275,
        ["fileDataIDs"] = { 2212736 } 
    },
    {
        ["offsetX"]=414,
        ["textureHeight"] = 155,
        ["textureWidth"] = 205,
        ["offsetY"] = 154,
        ["fileDataIDs"] = { 271897 } 
    },
    {
        ["offsetX"]=541,
        ["textureHeight"] = 240,
        ["textureWidth"] = 215,
        ["offsetY"] = 236,
        ["fileDataIDs"] = { 2212742 } 
    },
    {
        ["offsetX"]=509,
        ["textureHeight"] = 310,
        ["textureWidth"] = 220,
        ["offsetY"] = 0,
        ["fileDataIDs"] = { 271894,2212744 } 
    },
    {
        ["offsetX"]=524,
        ["textureHeight"] = 320,
        ["textureWidth"] = 230,
        ["offsetY"] = 339,
        ["fileDataIDs"] = { 2212737,2212738 } 
    },
    {
        ["offsetX"]=418,
        ["textureHeight"] = 270,
        ["textureWidth"] = 235,
        ["offsetY"] = 201,
        ["fileDataIDs"] = { 271905,2212743 } 
    },
    {
        ["offsetX"]=637,
        ["textureHeight"] = 275,
        ["textureWidth"] = 240,
        ["offsetY"] = 294,
        ["fileDataIDs"] = { 271885,271877 } 
    },
    {
        ["offsetX"]=208,
        ["textureHeight"] = 155,
        ["textureWidth"] = 285,
        ["offsetY"] = 368,
        ["fileDataIDs"] = { 2212746,2212747 } 
    },
    {
        ["offsetX"]=2,
        ["textureHeight"] = 225,
        ["textureWidth"] = 288,
        ["offsetY"] = 192,
        ["fileDataIDs"] = { 271876,271881 } 
    },
    {
        ["offsetX"]=198,
        ["textureHeight"] = 275,
        ["textureWidth"] = 305,
        ["offsetY"] = 155,
        ["fileDataIDs"] = { 271883,271892,2212739,2212740 } 
    },
    {
        ["offsetX"]=605,
        ["textureHeight"] = 365,
        ["textureWidth"] = 384,
        ["offsetY"] = 75,
        ["fileDataIDs"] = { 271872,271898,271882,271891 } 
    }
},
[1215] = {
    {
        ["offsetX"]=158,
        ["textureHeight"] = 220,
        ["textureWidth"] = 145,
        ["offsetY"] = 149,
        ["fileDataIDs"] = { 271927 } 
    },
    {
        ["offsetX"]=512,
        ["textureHeight"] = 145,
        ["textureWidth"] = 160,
        ["offsetY"] = 232,
        ["fileDataIDs"] = { 271933 } 
    },
    {
        ["offsetX"]=319,
        ["textureHeight"] = 170,
        ["textureWidth"] = 170,
        ["offsetY"] = 302,
        ["fileDataIDs"] = { 271934 } 
    },
    {
        ["offsetX"]=693,
        ["textureHeight"] = 310,
        ["textureWidth"] = 170,
        ["offsetY"] = 303,
        ["fileDataIDs"] = { 271938,271916 } 
    },
    {
        ["offsetX"]=408,
        ["textureHeight"] = 170,
        ["textureWidth"] = 180,
        ["offsetY"] = 260,
        ["fileDataIDs"] = { 271929 } 
    },
    {
        ["offsetX"]=237,
        ["textureHeight"] = 195,
        ["textureWidth"] = 185,
        ["offsetY"] = 185,
        ["fileDataIDs"] = { 271928 } 
    },
    {
        ["offsetX"]=240,
        ["textureHeight"] = 185,
        ["textureWidth"] = 195,
        ["offsetY"] = 387,
        ["fileDataIDs"] = { 271937 } 
    },
    {
        ["offsetX"]=373,
        ["textureHeight"] = 165,
        ["textureWidth"] = 200,
        ["offsetY"] = 365,
        ["fileDataIDs"] = { 271922 } 
    },
    {
        ["offsetX"]=374,
        ["textureHeight"] = 195,
        ["textureWidth"] = 205,
        ["offsetY"] = 164,
        ["fileDataIDs"] = { 271910 } 
    },
    {
        ["offsetX"]=171,
        ["textureHeight"] = 200,
        ["textureWidth"] = 225,
        ["offsetY"] = 306,
        ["fileDataIDs"] = { 770218 } 
    },
    {
        ["offsetX"]=505,
        ["textureHeight"] = 285,
        ["textureWidth"] = 235,
        ["offsetY"] = 333,
        ["fileDataIDs"] = { 271912,271920 } 
    },
    {
        ["offsetX"]=13,
        ["textureHeight"] = 205,
        ["textureWidth"] = 255,
        ["offsetY"] = 245,
        ["fileDataIDs"] = { 271917 } 
    },
    {
        ["offsetX"]=509,
        ["textureHeight"] = 275,
        ["textureWidth"] = 275,
        ["offsetY"] = 19,
        ["fileDataIDs"] = { 271908,271935,271936,271909 } 
    },
    {
        ["offsetX"]=571,
        ["textureHeight"] = 205,
        ["textureWidth"] = 280,
        ["offsetY"] = 239,
        ["fileDataIDs"] = { 271915,271921 } 
    }
},
[1216] = {
    {
        ["offsetX"]=252,
        ["textureHeight"] = 115,
        ["textureWidth"] = 115,
        ["offsetY"] = 249,
        ["fileDataIDs"] = { 2212640 } 
    },
    {
        ["offsetX"]=217,
        ["textureHeight"] = 125,
        ["textureWidth"] = 125,
        ["offsetY"] = 287,
        ["fileDataIDs"] = { 271398 } 
    },
    {
        ["offsetX"]=792,
        ["textureHeight"] = 120,
        ["textureWidth"] = 128,
        ["offsetY"] = 279,
        ["fileDataIDs"] = { 2212654 } 
    },
    {
        ["offsetX"]=573,
        ["textureHeight"] = 128,
        ["textureWidth"] = 128,
        ["offsetY"] = 280,
        ["fileDataIDs"] = { 271389 } 
    },
    {
        ["offsetX"]=502,
        ["textureHeight"] = 165,
        ["textureWidth"] = 128,
        ["offsetY"] = 221,
        ["fileDataIDs"] = { 2212651 } 
    },
    {
        ["offsetX"]=759,
        ["textureHeight"] = 165,
        ["textureWidth"] = 128,
        ["offsetY"] = 173,
        ["fileDataIDs"] = { 2212653 } 
    },
    {
        ["offsetX"]=281,
        ["textureHeight"] = 180,
        ["textureWidth"] = 128,
        ["offsetY"] = 167,
        ["fileDataIDs"] = { 271392 } 
    },
    {
        ["offsetX"]=347,
        ["textureHeight"] = 190,
        ["textureWidth"] = 128,
        ["offsetY"] = 163,
        ["fileDataIDs"] = { 271418 } 
    },
    {
        ["offsetX"]=295,
        ["textureHeight"] = 128,
        ["textureWidth"] = 150,
        ["offsetY"] = 385,
        ["fileDataIDs"] = { 271406 } 
    },
    {
        ["offsetX"]=522,
        ["textureHeight"] = 128,
        ["textureWidth"] = 155,
        ["offsetY"] = 322,
        ["fileDataIDs"] = { 271401 } 
    },
    {
        ["offsetX"]=694,
        ["textureHeight"] = 170,
        ["textureWidth"] = 155,
        ["offsetY"] = 273,
        ["fileDataIDs"] = { 271409 } 
    },
    {
        ["offsetX"]=608,
        ["textureHeight"] = 165,
        ["textureWidth"] = 165,
        ["offsetY"] = 291,
        ["fileDataIDs"] = { 271408 } 
    },
    {
        ["offsetX"]=274,
        ["textureHeight"] = 128,
        ["textureWidth"] = 180,
        ["offsetY"] = 296,
        ["fileDataIDs"] = { 2212641 } 
    },
    {
        ["offsetX"]=166,
        ["textureHeight"] = 165,
        ["textureWidth"] = 180,
        ["offsetY"] = 184,
        ["fileDataIDs"] = { 2212644 } 
    },
    {
        ["offsetX"]=314,
        ["textureHeight"] = 185,
        ["textureWidth"] = 200,
        ["offsetY"] = 311,
        ["fileDataIDs"] = { 271400 } 
    },
    {
        ["offsetX"]=386,
        ["textureHeight"] = 200,
        ["textureWidth"] = 200,
        ["offsetY"] = 294,
        ["fileDataIDs"] = { 271417 } 
    },
    {
        ["offsetX"]=155,
        ["textureHeight"] = 185,
        ["textureWidth"] = 240,
        ["offsetY"] = 403,
        ["fileDataIDs"] = { 2212639 } 
    },
    {
        ["offsetX"]=397,
        ["textureHeight"] = 200,
        ["textureWidth"] = 315,
        ["offsetY"] = 163,
        ["fileDataIDs"] = { 271410,271396 } 
    }
},
[1220] = {
    {
        ["offsetX"]=77,
        ["textureHeight"] = 235,
        ["textureWidth"] = 275,
        ["offsetY"] = 366,
        ["fileDataIDs"] = { 254503,254504 } 
    },
    {
        ["offsetX"]=494,
        ["textureHeight"] = 220,
        ["textureWidth"] = 305,
        ["offsetY"] = 300,
        ["fileDataIDs"] = { 2201968,2201949 } 
    },
    {
        ["offsetX"]=545,
        ["textureHeight"] = 230,
        ["textureWidth"] = 305,
        ["offsetY"] = 407,
        ["fileDataIDs"] = { 254527,254528 } 
    },
    {
        ["offsetX"]=247,
        ["textureHeight"] = 280,
        ["textureWidth"] = 360,
        ["offsetY"] = 388,
        ["fileDataIDs"] = { 2201972,2201970,2201969,2201971 } 
    },
    {
        ["offsetX"]=85,
        ["textureHeight"] = 430,
        ["textureWidth"] = 405,
        ["offsetY"] = 30,
        ["fileDataIDs"] = { 254509,254510,254511,254512 } 
    },
    {
        ["offsetX"]=250,
        ["textureHeight"] = 325,
        ["textureWidth"] = 425,
        ["offsetY"] = 170,
        ["fileDataIDs"] = { 254529,254530,254531,254532 } 
    },
    {
        ["offsetX"]=422,
        ["textureHeight"] = 365,
        ["textureWidth"] = 460,
        ["offsetY"] = 8,
        ["fileDataIDs"] = { 254505,254506,254507,254508 } 
    }
},
[1224] = {
    {
        ["offsetX"]=707,
        ["textureHeight"] = 225,
        ["textureWidth"] = 220,
        ["offsetY"] = 168,
        ["fileDataIDs"] = { 270927 } 
    },
    {
        ["offsetX"]=36,
        ["textureHeight"] = 220,
        ["textureWidth"] = 225,
        ["offsetY"] = 109,
        ["fileDataIDs"] = { 270938 } 
    },
    {
        ["offsetX"]=334,
        ["textureHeight"] = 265,
        ["textureWidth"] = 245,
        ["offsetY"] = 114,
        ["fileDataIDs"] = { 270912,270909 } 
    },
    {
        ["offsetX"]=173,
        ["textureHeight"] = 280,
        ["textureWidth"] = 256,
        ["offsetY"] = 101,
        ["fileDataIDs"] = { 270919,270911 } 
    },
    {
        ["offsetX"]=513,
        ["textureHeight"] = 285,
        ["textureWidth"] = 270,
        ["offsetY"] = 99,
        ["fileDataIDs"] = { 270922,270934,270923,270937 } 
    },
    {
        ["offsetX"]=589,
        ["textureHeight"] = 310,
        ["textureWidth"] = 270,
        ["offsetY"] = 279,
        ["fileDataIDs"] = { 270920,270914,270908,270929 } 
    },
    {
        ["offsetX"]=722,
        ["textureHeight"] = 355,
        ["textureWidth"] = 280,
        ["offsetY"] = 46,
        ["fileDataIDs"] = { 270944,270910,270935,270945 } 
    },
    {
        ["offsetX"]=708,
        ["textureHeight"] = 270,
        ["textureWidth"] = 294,
        ["offsetY"] = 311,
        ["fileDataIDs"] = { 270906,270918,270936,270942 } 
    },
    {
        ["offsetX"]=377,
        ["textureHeight"] = 270,
        ["textureWidth"] = 320,
        ["offsetY"] = 285,
        ["fileDataIDs"] = { 270933,270943,270921,270928 } 
    },
    {
        ["offsetX"]=56,
        ["textureHeight"] = 315,
        ["textureWidth"] = 415,
        ["offsetY"] = 258,
        ["fileDataIDs"] = { 270941,270925,270926,270917 } 
    }
},
[1228] = {
    {
        ["offsetX"]=422,
        ["textureHeight"] = 220,
        ["textureWidth"] = 225,
        ["offsetY"] = 332,
        ["fileDataIDs"] = { 271560 } 
    },
    {
        ["offsetX"]=250,
        ["textureHeight"] = 220,
        ["textureWidth"] = 240,
        ["offsetY"] = 270,
        ["fileDataIDs"] = { 271567 } 
    },
    {
        ["offsetX"]=551,
        ["textureHeight"] = 250,
        ["textureWidth"] = 255,
        ["offsetY"] = 292,
        ["fileDataIDs"] = { 271573 } 
    },
    {
        ["offsetX"]=704,
        ["textureHeight"] = 210,
        ["textureWidth"] = 256,
        ["offsetY"] = 330,
        ["fileDataIDs"] = { 271578 } 
    },
    {
        ["offsetX"]=425,
        ["textureHeight"] = 237,
        ["textureWidth"] = 256,
        ["offsetY"] = 431,
        ["fileDataIDs"] = { 271582 } 
    },
    {
        ["offsetX"]=238,
        ["textureHeight"] = 240,
        ["textureWidth"] = 256,
        ["offsetY"] = 428,
        ["fileDataIDs"] = { 271576 } 
    },
    {
        ["offsetX"]=577,
        ["textureHeight"] = 249,
        ["textureWidth"] = 256,
        ["offsetY"] = 419,
        ["fileDataIDs"] = { 271559 } 
    },
    {
        ["offsetX"]=381,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 147,
        ["fileDataIDs"] = { 271572 } 
    },
    {
        ["offsetX"]=124,
        ["textureHeight"] = 341,
        ["textureWidth"] = 256,
        ["offsetY"] = 327,
        ["fileDataIDs"] = { 2212708,2212709 } 
    },
    {
        ["offsetX"]=696,
        ["textureHeight"] = 233,
        ["textureWidth"] = 306,
        ["offsetY"] = 435,
        ["fileDataIDs"] = { 271557,271583 } 
    },
    {
        ["offsetX"]=587,
        ["textureHeight"] = 256,
        ["textureWidth"] = 310,
        ["offsetY"] = 190,
        ["fileDataIDs"] = { 271584,271565 } 
    },
    {
        ["offsetX"]=0,
        ["textureHeight"] = 405,
        ["textureWidth"] = 485,
        ["offsetY"] = 0,
        ["fileDataIDs"] = { 2212713,2212714,2212715,2212716 } 
    }
},
[1233] = {
    {
        ["offsetX"]=426,
        ["textureHeight"] = 270,
        ["textureWidth"] = 270,
        ["offsetY"] = 299,
        ["fileDataIDs"] = { 271092,271085,271086,271089 } 
    },
    {
        ["offsetX"]=269,
        ["textureHeight"] = 245,
        ["textureWidth"] = 300,
        ["offsetY"] = 337,
        ["fileDataIDs"] = { 271095,271079 } 
    },
    {
        ["offsetX"]=249,
        ["textureHeight"] = 365,
        ["textureWidth"] = 380,
        ["offsetY"] = 76,
        ["fileDataIDs"] = { 271075,271076,271080,271081 } 
    }
},
[1235] = {
    {
        ["offsetX"]=19,
        ["textureHeight"] = 330,
        ["textureWidth"] = 160,
        ["offsetY"] = 132,
        ["fileDataIDs"] = { 271453,271454 } 
    },
    {
        ["offsetX"]=102,
        ["textureHeight"] = 145,
        ["textureWidth"] = 195,
        ["offsetY"] = 302,
        ["fileDataIDs"] = { 2212669 } 
    },
    {
        ["offsetX"]=653,
        ["textureHeight"] = 175,
        ["textureWidth"] = 200,
        ["offsetY"] = 120,
        ["fileDataIDs"] = { 271466 } 
    },
    {
        ["offsetX"]=690,
        ["textureHeight"] = 220,
        ["textureWidth"] = 220,
        ["offsetY"] = 353,
        ["fileDataIDs"] = { 2212676 } 
    },
    {
        ["offsetX"]=504,
        ["textureHeight"] = 340,
        ["textureWidth"] = 220,
        ["offsetY"] = 117,
        ["fileDataIDs"] = { 271470,271477 } 
    },
    {
        ["offsetX"]=390,
        ["textureHeight"] = 250,
        ["textureWidth"] = 235,
        ["offsetY"] = 382,
        ["fileDataIDs"] = { 271449 } 
    },
    {
        ["offsetX"]=539,
        ["textureHeight"] = 230,
        ["textureWidth"] = 250,
        ["offsetY"] = 369,
        ["fileDataIDs"] = { 271455 } 
    },
    {
        ["offsetX"]=243,
        ["textureHeight"] = 285,
        ["textureWidth"] = 255,
        ["offsetY"] = 348,
        ["fileDataIDs"] = { 271448,271456 } 
    },
    {
        ["offsetX"]=55,
        ["textureHeight"] = 250,
        ["textureWidth"] = 275,
        ["offsetY"] = 342,
        ["fileDataIDs"] = { 271444,271483 } 
    },
    {
        ["offsetX"]=631,
        ["textureHeight"] = 280,
        ["textureWidth"] = 315,
        ["offsetY"] = 162,
        ["fileDataIDs"] = { 271471,271461,271450,271451 } 
    },
    {
        ["offsetX"]=85,
        ["textureHeight"] = 300,
        ["textureWidth"] = 350,
        ["offsetY"] = 149,
        ["fileDataIDs"] = { 271473,271463,271467,271464 } 
    },
    {
        ["offsetX"]=298,
        ["textureHeight"] = 420,
        ["textureWidth"] = 360,
        ["offsetY"] = 79,
        ["fileDataIDs"] = { 2212678,2212679,2212680,2212681 } 
    },
    {
        ["offsetX"]=89,
        ["textureHeight"] = 210,
        ["textureWidth"] = 910,
        ["offsetY"] = 31,
        ["fileDataIDs"] = { 271481,271460,271474,271468 } 
    }
},
[1236] = {
    {
        ["offsetX"]=109,
        ["textureHeight"] = 250,
        ["textureWidth"] = 195,
        ["offsetY"] = 370,
        ["fileDataIDs"] = { 252899 } 
    },
    {
        ["offsetX"]=125,
        ["textureHeight"] = 300,
        ["textureWidth"] = 230,
        ["offsetY"] = 12,
        ["fileDataIDs"] = { 252882,252883 } 
    },
    {
        ["offsetX"]=229,
        ["textureHeight"] = 270,
        ["textureWidth"] = 235,
        ["offsetY"] = 11,
        ["fileDataIDs"] = { 252884,2212852 } 
    },
    {
        ["offsetX"]=215,
        ["textureHeight"] = 285,
        ["textureWidth"] = 255,
        ["offsetY"] = 348,
        ["fileDataIDs"] = { 252886,252887 } 
    },
    {
        ["offsetX"]=217,
        ["textureHeight"] = 230,
        ["textureWidth"] = 256,
        ["offsetY"] = 203,
        ["fileDataIDs"] = { 252898 } 
    },
    {
        ["offsetX"]=339,
        ["textureHeight"] = 175,
        ["textureWidth"] = 290,
        ["offsetY"] = 11,
        ["fileDataIDs"] = { 2212855,2212856 } 
    },
    {
        ["offsetX"]=309,
        ["textureHeight"] = 358,
        ["textureWidth"] = 295,
        ["offsetY"] = 310,
        ["fileDataIDs"] = { 252862,252863,2212828,2212829 } 
    },
    {
        ["offsetX"]=542,
        ["textureHeight"] = 235,
        ["textureWidth"] = 315,
        ["offsetY"] = 48,
        ["fileDataIDs"] = { 252880,252881 } 
    },
    {
        ["offsetX"]=352,
        ["textureHeight"] = 410,
        ["textureWidth"] = 320,
        ["offsetY"] = 87,
        ["fileDataIDs"] = { 252894,252895,252896,252897 } 
    },
    {
        ["offsetX"]=482,
        ["textureHeight"] = 256,
        ["textureWidth"] = 345,
        ["offsetY"] = 321,
        ["fileDataIDs"] = { 252866,252867 } 
    },
    {
        ["offsetX"]=546,
        ["textureHeight"] = 295,
        ["textureWidth"] = 370,
        ["offsetY"] = 199,
        ["fileDataIDs"] = { 252890,252891,252892,252893 } 
    }
},
[1237] = {
    {
        ["offsetX"]=399,
        ["textureHeight"] = 270,
        ["textureWidth"] = 235,
        ["offsetY"] = 129,
        ["fileDataIDs"] = { 272334,2212936 } 
    },
    {
        ["offsetX"]=654,
        ["textureHeight"] = 250,
        ["textureWidth"] = 250,
        ["offsetY"] = 161,
        ["fileDataIDs"] = { 272372 } 
    },
    {
        ["offsetX"]=500,
        ["textureHeight"] = 300,
        ["textureWidth"] = 255,
        ["offsetY"] = 215,
        ["fileDataIDs"] = { 2212977,2212978 } 
    },
    {
        ["offsetX"]=277,
        ["textureHeight"] = 256,
        ["textureWidth"] = 275,
        ["offsetY"] = 0,
        ["fileDataIDs"] = { 272357,272342 } 
    },
    {
        ["offsetX"]=595,
        ["textureHeight"] = 210,
        ["textureWidth"] = 320,
        ["offsetY"] = 320,
        ["fileDataIDs"] = { 272347,272371 } 
    },
    {
        ["offsetX"]=83,
        ["textureHeight"] = 195,
        ["textureWidth"] = 340,
        ["offsetY"] = 197,
        ["fileDataIDs"] = { 272351,272340 } 
    },
    {
        ["offsetX"]=121,
        ["textureHeight"] = 245,
        ["textureWidth"] = 365,
        ["offsetY"] = 72,
        ["fileDataIDs"] = { 272362,272356 } 
    },
    {
        ["offsetX"]=0,
        ["textureHeight"] = 350,
        ["textureWidth"] = 365,
        ["offsetY"] = 284,
        ["fileDataIDs"] = { 272364,272348,272358,272359 } 
    },
    {
        ["offsetX"]=187,
        ["textureHeight"] = 290,
        ["textureWidth"] = 430,
        ["offsetY"] = 333,
        ["fileDataIDs"] = { 272344,272354,272350,272339 } 
    },
    {
        ["offsetX"]=484,
        ["textureHeight"] = 255,
        ["textureWidth"] = 465,
        ["offsetY"] = 361,
        ["fileDataIDs"] = { 272369,272363 } 
    },
    {
        ["offsetX"]=133,
        ["textureHeight"] = 275,
        ["textureWidth"] = 535,
        ["offsetY"] = 240,
        ["fileDataIDs"] = { 272335,272343,2212940,2212942,2212943,2212945 } 
    }
},
[1238] = {
    {
        ["offsetX"]=241,
        ["textureHeight"] = 80,
        ["textureWidth"] = 90,
        ["offsetY"] = 92,
        ["fileDataIDs"] = { 2213143 } 
    },
    {
        ["offsetX"]=211,
        ["textureHeight"] = 115,
        ["textureWidth"] = 90,
        ["offsetY"] = 359,
        ["fileDataIDs"] = { 2213164 } 
    },
    {
        ["offsetX"]=299,
        ["textureHeight"] = 95,
        ["textureWidth"] = 95,
        ["offsetY"] = 88,
        ["fileDataIDs"] = { 2213154 } 
    },
    {
        ["offsetX"]=350,
        ["textureHeight"] = 95,
        ["textureWidth"] = 95,
        ["offsetY"] = 335,
        ["fileDataIDs"] = { 2213170 } 
    },
    {
        ["offsetX"]=311,
        ["textureHeight"] = 110,
        ["textureWidth"] = 105,
        ["offsetY"] = 131,
        ["fileDataIDs"] = { 2213161 } 
    },
    {
        ["offsetX"]=387,
        ["textureHeight"] = 125,
        ["textureWidth"] = 105,
        ["offsetY"] = 64,
        ["fileDataIDs"] = { 2213191 } 
    },
    {
        ["offsetX"]=260,
        ["textureHeight"] = 105,
        ["textureWidth"] = 110,
        ["offsetY"] = 132,
        ["fileDataIDs"] = { 2213150 } 
    },
    {
        ["offsetX"]=306,
        ["textureHeight"] = 110,
        ["textureWidth"] = 110,
        ["offsetY"] = 301,
        ["fileDataIDs"] = { 2213171 } 
    },
    {
        ["offsetX"]=371,
        ["textureHeight"] = 140,
        ["textureWidth"] = 110,
        ["offsetY"] = 129,
        ["fileDataIDs"] = { 2213145 } 
    },
    {
        ["offsetX"]=156,
        ["textureHeight"] = 115,
        ["textureWidth"] = 115,
        ["offsetY"] = 42,
        ["fileDataIDs"] = { 2213197 } 
    },
    {
        ["offsetX"]=345,
        ["textureHeight"] = 120,
        ["textureWidth"] = 120,
        ["offsetY"] = 276,
        ["fileDataIDs"] = { 2213148 } 
    },
    {
        ["offsetX"]=314,
        ["textureHeight"] = 120,
        ["textureWidth"] = 125,
        ["offsetY"] = 493,
        ["fileDataIDs"] = { 2213152 } 
    },
    {
        ["offsetX"]=280,
        ["textureHeight"] = 125,
        ["textureWidth"] = 125,
        ["offsetY"] = 368,
        ["fileDataIDs"] = { 2213159 } 
    },
    {
        ["offsetX"]=196,
        ["textureHeight"] = 140,
        ["textureWidth"] = 125,
        ["offsetY"] = 3,
        ["fileDataIDs"] = { 2213173 } 
    },
    {
        ["offsetX"]=331,
        ["textureHeight"] = 125,
        ["textureWidth"] = 128,
        ["offsetY"] = 59,
        ["fileDataIDs"] = { 2213158 } 
    },
    {
        ["offsetX"]=364,
        ["textureHeight"] = 125,
        ["textureWidth"] = 128,
        ["offsetY"] = 231,
        ["fileDataIDs"] = { 2213194 } 
    },
    {
        ["offsetX"]=432,
        ["textureHeight"] = 175,
        ["textureWidth"] = 128,
        ["offsetY"] = 94,
        ["fileDataIDs"] = { 2213162 } 
    },
    {
        ["offsetX"]=269,
        ["textureHeight"] = 110,
        ["textureWidth"] = 140,
        ["offsetY"] = 26,
        ["fileDataIDs"] = { 2213165 } 
    },
    {
        ["offsetX"]=203,
        ["textureHeight"] = 128,
        ["textureWidth"] = 145,
        ["offsetY"] = 433,
        ["fileDataIDs"] = { 2213147 } 
    },
    {
        ["offsetX"]=388,
        ["textureHeight"] = 150,
        ["textureWidth"] = 155,
        ["offsetY"] = 0,
        ["fileDataIDs"] = { 2213156 } 
    },
    {
        ["offsetX"]=194,
        ["textureHeight"] = 175,
        ["textureWidth"] = 165,
        ["offsetY"] = 284,
        ["fileDataIDs"] = { 2213146 } 
    },
    {
        ["offsetX"]=229,
        ["textureHeight"] = 190,
        ["textureWidth"] = 165,
        ["offsetY"] = 422,
        ["fileDataIDs"] = { 2213192 } 
    },
    {
        ["offsetX"]=284,
        ["textureHeight"] = 90,
        ["textureWidth"] = 170,
        ["offsetY"] = 0,
        ["fileDataIDs"] = { 2213168 } 
    },
    {
        ["offsetX"]=394,
        ["textureHeight"] = 125,
        ["textureWidth"] = 170,
        ["offsetY"] = 212,
        ["fileDataIDs"] = { 2213174 } 
    },
    {
        ["offsetX"]=152,
        ["textureHeight"] = 175,
        ["textureWidth"] = 190,
        ["offsetY"] = 90,
        ["fileDataIDs"] = { 2213188 } 
    },
    {
        ["offsetX"]=235,
        ["textureHeight"] = 185,
        ["textureWidth"] = 200,
        ["offsetY"] = 189,
        ["fileDataIDs"] = { 2213187 } 
    },
    {
        ["offsetX"]=483,
        ["textureHeight"] = 220,
        ["textureWidth"] = 245,
        ["offsetY"] = 8,
        ["fileDataIDs"] = { 2213196 } 
    }
},
[1239] = {
    {
        ["offsetX"]=724,
        ["textureHeight"] = 365,
        ["textureWidth"] = 215,
        ["offsetY"] = 120,
        ["fileDataIDs"] = { 272739,272746 } 
    },
    {
        ["offsetX"]=171,
        ["textureHeight"] = 205,
        ["textureWidth"] = 235,
        ["offsetY"] = 145,
        ["fileDataIDs"] = { 272736 } 
    },
    {
        ["offsetX"]=0,
        ["textureHeight"] = 245,
        ["textureWidth"] = 240,
        ["offsetY"] = 262,
        ["fileDataIDs"] = { 2213206 } 
    },
    {
        ["offsetX"]=0,
        ["textureHeight"] = 305,
        ["textureWidth"] = 245,
        ["offsetY"] = 140,
        ["fileDataIDs"] = { 272759,272750 } 
    },
    {
        ["offsetX"]=746,
        ["textureHeight"] = 668,
        ["textureWidth"] = 256,
        ["offsetY"] = 0,
        ["fileDataIDs"] = { 272756,272737,272769 } 
    },
    {
        ["offsetX"]=129,
        ["textureHeight"] = 240,
        ["textureWidth"] = 275,
        ["offsetY"] = 236,
        ["fileDataIDs"] = { 272747,272763 } 
    },
    {
        ["offsetX"]=565,
        ["textureHeight"] = 275,
        ["textureWidth"] = 300,
        ["offsetY"] = 218,
        ["fileDataIDs"] = { 272772,272760,2213215,2213216 } 
    },
    {
        ["offsetX"]=286,
        ["textureHeight"] = 235,
        ["textureWidth"] = 315,
        ["offsetY"] = 110,
        ["fileDataIDs"] = { 272768,272770 } 
    },
    {
        ["offsetX"]=552,
        ["textureHeight"] = 250,
        ["textureWidth"] = 345,
        ["offsetY"] = 378,
        ["fileDataIDs"] = { 272740,272773 } 
    },
    {
        ["offsetX"]=279,
        ["textureHeight"] = 315,
        ["textureWidth"] = 360,
        ["offsetY"] = 237,
        ["fileDataIDs"] = { 272742,272751,272752,272764 } 
    },
    {
        ["offsetX"]=492,
        ["textureHeight"] = 305,
        ["textureWidth"] = 365,
        ["offsetY"] = 0,
        ["fileDataIDs"] = { 2213200,2213202,2213203,2213204 } 
    }
},
[1240] = {
    {
        ["offsetX"]=488,
        ["textureHeight"] = 200,
        ["textureWidth"] = 165,
        ["offsetY"] = 0,
        ["fileDataIDs"] = { 273143 } 
    },
    {
        ["offsetX"]=442,
        ["textureHeight"] = 240,
        ["textureWidth"] = 195,
        ["offsetY"] = 241,
        ["fileDataIDs"] = { 273137 } 
    },
    {
        ["offsetX"]=208,
        ["textureHeight"] = 185,
        ["textureWidth"] = 200,
        ["offsetY"] = 375,
        ["fileDataIDs"] = { 273142 } 
    },
    {
        ["offsetX"]=524,
        ["textureHeight"] = 240,
        ["textureWidth"] = 200,
        ["offsetY"] = 252,
        ["fileDataIDs"] = { 273125 } 
    },
    {
        ["offsetX"]=387,
        ["textureHeight"] = 215,
        ["textureWidth"] = 210,
        ["offsetY"] = 11,
        ["fileDataIDs"] = { 273145 } 
    },
    {
        ["offsetX"]=307,
        ["textureHeight"] = 215,
        ["textureWidth"] = 215,
        ["offsetY"] = 29,
        ["fileDataIDs"] = { 2212528 } 
    },
    {
        ["offsetX"]=317,
        ["textureHeight"] = 200,
        ["textureWidth"] = 220,
        ["offsetY"] = 331,
        ["fileDataIDs"] = { 273130 } 
    },
    {
        ["offsetX"]=328,
        ["textureHeight"] = 205,
        ["textureWidth"] = 225,
        ["offsetY"] = 148,
        ["fileDataIDs"] = { 273126 } 
    },
    {
        ["offsetX"]=459,
        ["textureHeight"] = 210,
        ["textureWidth"] = 225,
        ["offsetY"] = 105,
        ["fileDataIDs"] = { 273146 } 
    },
    {
        ["offsetX"]=220,
        ["textureHeight"] = 256,
        ["textureWidth"] = 225,
        ["offsetY"] = 102,
        ["fileDataIDs"] = { 273149 } 
    },
    {
        ["offsetX"]=339,
        ["textureHeight"] = 175,
        ["textureWidth"] = 256,
        ["offsetY"] = 418,
        ["fileDataIDs"] = { 273124 } 
    },
    {
        ["offsetX"]=205,
        ["textureHeight"] = 190,
        ["textureWidth"] = 280,
        ["offsetY"] = 467,
        ["fileDataIDs"] = { 273141,2212527 } 
    },
    {
        ["offsetX"]=523,
        ["textureHeight"] = 235,
        ["textureWidth"] = 288,
        ["offsetY"] = 377,
        ["fileDataIDs"] = { 273131,273134 } 
    },
    {
        ["offsetX"]=204,
        ["textureHeight"] = 210,
        ["textureWidth"] = 305,
        ["offsetY"] = 260,
        ["fileDataIDs"] = { 273129,273133 } 
    }
},
[1243] = {
    {
        ["offsetX"]=13,
        ["textureHeight"] = 128,
        ["textureWidth"] = 175,
        ["offsetY"] = 314,
        ["fileDataIDs"] = { 273156 } 
    },
    {
        ["offsetX"]=456,
        ["textureHeight"] = 240,
        ["textureWidth"] = 185,
        ["offsetY"] = 125,
        ["fileDataIDs"] = { 2212531 } 
    },
    {
        ["offsetX"]=628,
        ["textureHeight"] = 160,
        ["textureWidth"] = 190,
        ["offsetY"] = 176,
        ["fileDataIDs"] = { 273181 } 
    },
    {
        ["offsetX"]=247,
        ["textureHeight"] = 185,
        ["textureWidth"] = 195,
        ["offsetY"] = 205,
        ["fileDataIDs"] = { 273155 } 
    },
    {
        ["offsetX"]=349,
        ["textureHeight"] = 185,
        ["textureWidth"] = 200,
        ["offsetY"] = 115,
        ["fileDataIDs"] = { 273173 } 
    },
    {
        ["offsetX"]=237,
        ["textureHeight"] = 240,
        ["textureWidth"] = 200,
        ["offsetY"] = 41,
        ["fileDataIDs"] = { 2212533 } 
    },
    {
        ["offsetX"]=401,
        ["textureHeight"] = 180,
        ["textureWidth"] = 205,
        ["offsetY"] = 21,
        ["fileDataIDs"] = { 273164 } 
    },
    {
        ["offsetX"]=527,
        ["textureHeight"] = 245,
        ["textureWidth"] = 205,
        ["offsetY"] = 264,
        ["fileDataIDs"] = { 273177 } 
    },
    {
        ["offsetX"]=347,
        ["textureHeight"] = 185,
        ["textureWidth"] = 225,
        ["offsetY"] = 218,
        ["fileDataIDs"] = { 273159 } 
    },
    {
        ["offsetX"]=89,
        ["textureHeight"] = 190,
        ["textureWidth"] = 225,
        ["offsetY"] = 142,
        ["fileDataIDs"] = { 273171 } 
    },
    {
        ["offsetX"]=470,
        ["textureHeight"] = 190,
        ["textureWidth"] = 230,
        ["offsetY"] = 371,
        ["fileDataIDs"] = { 273174 } 
    },
    {
        ["offsetX"]=77,
        ["textureHeight"] = 175,
        ["textureWidth"] = 240,
        ["offsetY"] = 245,
        ["fileDataIDs"] = { 273163 } 
    },
    {
        ["offsetX"]=507,
        ["textureHeight"] = 250,
        ["textureWidth"] = 256,
        ["offsetY"] = 115,
        ["fileDataIDs"] = { 2212535 } 
    },
    {
        ["offsetX"]=92,
        ["textureHeight"] = 240,
        ["textureWidth"] = 300,
        ["offsetY"] = 82,
        ["fileDataIDs"] = { 273178,273167 } 
    },
    {
        ["offsetX"]=611,
        ["textureHeight"] = 360,
        ["textureWidth"] = 350,
        ["offsetY"] = 230,
        ["fileDataIDs"] = { 2213613,2213614,2212532,2212534 } 
    }
},
[1244] = {
    {
        ["offsetX"]=494,
        ["textureHeight"] = 100,
        ["textureWidth"] = 128,
        ["offsetY"] = 548,
        ["fileDataIDs"] = { 2213328 } 
    },
    {
        ["offsetX"]=335,
        ["textureHeight"] = 190,
        ["textureWidth"] = 128,
        ["offsetY"] = 313,
        ["fileDataIDs"] = { 272807 } 
    },
    {
        ["offsetX"]=382,
        ["textureHeight"] = 210,
        ["textureWidth"] = 160,
        ["offsetY"] = 281,
        ["fileDataIDs"] = { 272826 } 
    },
    {
        ["offsetX"]=272,
        ["textureHeight"] = 240,
        ["textureWidth"] = 170,
        ["offsetY"] = 127,
        ["fileDataIDs"] = { 272830 } 
    },
    {
        ["offsetX"]=377,
        ["textureHeight"] = 256,
        ["textureWidth"] = 180,
        ["offsetY"] = 93,
        ["fileDataIDs"] = { 272822 } 
    },
    {
        ["offsetX"]=368,
        ["textureHeight"] = 128,
        ["textureWidth"] = 185,
        ["offsetY"] = 443,
        ["fileDataIDs"] = { 272814 } 
    },
    {
        ["offsetX"]=462,
        ["textureHeight"] = 128,
        ["textureWidth"] = 190,
        ["offsetY"] = 323,
        ["fileDataIDs"] = { 2213323 } 
    },
    {
        ["offsetX"]=561,
        ["textureHeight"] = 200,
        ["textureWidth"] = 200,
        ["offsetY"] = 292,
        ["fileDataIDs"] = { 272815 } 
    },
    {
        ["offsetX"]=491,
        ["textureHeight"] = 225,
        ["textureWidth"] = 225,
        ["offsetY"] = 153,
        ["fileDataIDs"] = { 272811 } 
    },
    {
        ["offsetX"]=436,
        ["textureHeight"] = 185,
        ["textureWidth"] = 256,
        ["offsetY"] = 380,
        ["fileDataIDs"] = { 272810 } 
    },
    {
        ["offsetX"]=101,
        ["textureHeight"] = 256,
        ["textureWidth"] = 315,
        ["offsetY"] = 247,
        ["fileDataIDs"] = { 272806,272812 } 
    }
},
[1247] = {
    {
        ["offsetX"]=318,
        ["textureHeight"] = 215,
        ["textureWidth"] = 150,
        ["offsetY"] = 162,
        ["fileDataIDs"] = { 769206 } 
    },
    {
        ["offsetX"]=468,
        ["textureHeight"] = 195,
        ["textureWidth"] = 170,
        ["offsetY"] = 85,
        ["fileDataIDs"] = { 769211 } 
    },
    {
        ["offsetX"]=329,
        ["textureHeight"] = 158,
        ["textureWidth"] = 175,
        ["offsetY"] = 510,
        ["fileDataIDs"] = { 271044 } 
    },
    {
        ["offsetX"]=229,
        ["textureHeight"] = 183,
        ["textureWidth"] = 175,
        ["offsetY"] = 485,
        ["fileDataIDs"] = { 769210 } 
    },
    {
        ["offsetX"]=365,
        ["textureHeight"] = 195,
        ["textureWidth"] = 180,
        ["offsetY"] = 181,
        ["fileDataIDs"] = { 769207 } 
    },
    {
        ["offsetX"]=324,
        ["textureHeight"] = 205,
        ["textureWidth"] = 190,
        ["offsetY"] = 306,
        ["fileDataIDs"] = { 271045 } 
    },
    {
        ["offsetX"]=510,
        ["textureHeight"] = 215,
        ["textureWidth"] = 195,
        ["offsetY"] = 0,
        ["fileDataIDs"] = { 271043 } 
    },
    {
        ["offsetX"]=305,
        ["textureHeight"] = 170,
        ["textureWidth"] = 200,
        ["offsetY"] = 412,
        ["fileDataIDs"] = { 769209 } 
    },
    {
        ["offsetX"]=375,
        ["textureHeight"] = 190,
        ["textureWidth"] = 230,
        ["offsetY"] = 94,
        ["fileDataIDs"] = { 769208 } 
    }
},
[1248] = {
    {
        ["offsetX"]=131,
        ["textureHeight"] = 195,
        ["textureWidth"] = 128,
        ["offsetY"] = 137,
        ["fileDataIDs"] = { 270380 } 
    },
    {
        ["offsetX"]=856,
        ["textureHeight"] = 200,
        ["textureWidth"] = 146,
        ["offsetY"] = 151,
        ["fileDataIDs"] = { 270387 } 
    },
    {
        ["offsetX"]=260,
        ["textureHeight"] = 150,
        ["textureWidth"] = 155,
        ["offsetY"] = 373,
        ["fileDataIDs"] = { 270398 } 
    },
    {
        ["offsetX"]=189,
        ["textureHeight"] = 175,
        ["textureWidth"] = 165,
        ["offsetY"] = 324,
        ["fileDataIDs"] = { 2212540 } 
    },
    {
        ["offsetX"]=520,
        ["textureHeight"] = 245,
        ["textureWidth"] = 180,
        ["offsetY"] = 238,
        ["fileDataIDs"] = { 270402 } 
    },
    {
        ["offsetX"]=796,
        ["textureHeight"] = 160,
        ["textureWidth"] = 200,
        ["offsetY"] = 311,
        ["fileDataIDs"] = { 270390 } 
    },
    {
        ["offsetX"]=392,
        ["textureHeight"] = 205,
        ["textureWidth"] = 200,
        ["offsetY"] = 218,
        ["fileDataIDs"] = { 2212541 } 
    },
    {
        ["offsetX"]=272,
        ["textureHeight"] = 185,
        ["textureWidth"] = 205,
        ["offsetY"] = 251,
        ["fileDataIDs"] = { 270386 } 
    },
    {
        ["offsetX"]=463,
        ["textureHeight"] = 185,
        ["textureWidth"] = 210,
        ["offsetY"] = 141,
        ["fileDataIDs"] = { 270400 } 
    },
    {
        ["offsetX"]=205,
        ["textureHeight"] = 305,
        ["textureWidth"] = 215,
        ["offsetY"] = 38,
        ["fileDataIDs"] = { 2212542,2212543 } 
    },
    {
        ["offsetX"]=104,
        ["textureHeight"] = 195,
        ["textureWidth"] = 220,
        ["offsetY"] = 259,
        ["fileDataIDs"] = { 2212548 } 
    },
    {
        ["offsetX"]=597,
        ["textureHeight"] = 255,
        ["textureWidth"] = 225,
        ["offsetY"] = 258,
        ["fileDataIDs"] = { 270401 } 
    },
    {
        ["offsetX"]=547,
        ["textureHeight"] = 205,
        ["textureWidth"] = 235,
        ["offsetY"] = 426,
        ["fileDataIDs"] = { 270375 } 
    },
    {
        ["offsetX"]=19,
        ["textureHeight"] = 245,
        ["textureWidth"] = 245,
        ["offsetY"] = 28,
        ["fileDataIDs"] = { 270376 } 
    },
    {
        ["offsetX"]=713,
        ["textureHeight"] = 255,
        ["textureWidth"] = 245,
        ["offsetY"] = 344,
        ["fileDataIDs"] = { 270405 } 
    },
    {
        ["offsetX"]=203,
        ["textureHeight"] = 195,
        ["textureWidth"] = 255,
        ["offsetY"] = 158,
        ["fileDataIDs"] = { 270389 } 
    },
    {
        ["offsetX"]=356,
        ["textureHeight"] = 240,
        ["textureWidth"] = 275,
        ["offsetY"] = 347,
        ["fileDataIDs"] = { 2212544,2212545 } 
    },
    {
        ["offsetX"]=694,
        ["textureHeight"] = 185,
        ["textureWidth"] = 285,
        ["offsetY"] = 225,
        ["fileDataIDs"] = { 270388,2212547 } 
    }
},
[1249] = {
    {
        ["offsetX"]=31,
        ["textureHeight"] = 190,
        ["textureWidth"] = 190,
        ["offsetY"] = 155,
        ["fileDataIDs"] = { 272968 } 
    },
    {
        ["offsetX"]=259,
        ["textureHeight"] = 195,
        ["textureWidth"] = 205,
        ["offsetY"] = 131,
        ["fileDataIDs"] = { 272962 } 
    },
    {
        ["offsetX"]=205,
        ["textureHeight"] = 180,
        ["textureWidth"] = 210,
        ["offsetY"] = 70,
        ["fileDataIDs"] = { 272963 } 
    },
    {
        ["offsetX"]=357,
        ["textureHeight"] = 190,
        ["textureWidth"] = 210,
        ["offsetY"] = 264,
        ["fileDataIDs"] = { 272954 } 
    },
    {
        ["offsetX"]=391,
        ["textureHeight"] = 195,
        ["textureWidth"] = 210,
        ["offsetY"] = 192,
        ["fileDataIDs"] = { 2213363 } 
    },
    {
        ["offsetX"]=492,
        ["textureHeight"] = 220,
        ["textureWidth"] = 240,
        ["offsetY"] = 250,
        ["fileDataIDs"] = { 2213395 } 
    },
    {
        ["offsetX"]=179,
        ["textureHeight"] = 240,
        ["textureWidth"] = 250,
        ["offsetY"] = 200,
        ["fileDataIDs"] = { 2213369 } 
    },
    {
        ["offsetX"]=0,
        ["textureHeight"] = 310,
        ["textureWidth"] = 305,
        ["offsetY"] = 0,
        ["fileDataIDs"] = { 2213348,2213349,2213351,2213352 } 
    },
    {
        ["offsetX"]=610,
        ["textureHeight"] = 365,
        ["textureWidth"] = 320,
        ["offsetY"] = 300,
        ["fileDataIDs"] = { 2213371,2213372,2213374,2213375 } 
    }
},
[1250] = {
    {
        ["offsetX"]=663,
        ["textureHeight"] = 86,
        ["textureWidth"] = 125,
        ["offsetY"] = 582,
        ["fileDataIDs"] = { 272650 } 
    },
    {
        ["offsetX"]=475,
        ["textureHeight"] = 125,
        ["textureWidth"] = 125,
        ["offsetY"] = 433,
        ["fileDataIDs"] = { 2213093 } 
    },
    {
        ["offsetX"]=572,
        ["textureHeight"] = 107,
        ["textureWidth"] = 145,
        ["offsetY"] = 561,
        ["fileDataIDs"] = { 272628 } 
    },
    {
        ["offsetX"]=389,
        ["textureHeight"] = 150,
        ["textureWidth"] = 150,
        ["offsetY"] = 320,
        ["fileDataIDs"] = { 272646 } 
    },
    {
        ["offsetX"]=718,
        ["textureHeight"] = 97,
        ["textureWidth"] = 190,
        ["offsetY"] = 571,
        ["fileDataIDs"] = { 2213087 } 
    },
    {
        ["offsetX"]=390,
        ["textureHeight"] = 215,
        ["textureWidth"] = 200,
        ["offsetY"] = 145,
        ["fileDataIDs"] = { 272624 } 
    },
    {
        ["offsetX"]=668,
        ["textureHeight"] = 120,
        ["textureWidth"] = 225,
        ["offsetY"] = 515,
        ["fileDataIDs"] = { 2213088 } 
    },
    {
        ["offsetX"]=210,
        ["textureHeight"] = 355,
        ["textureWidth"] = 230,
        ["offsetY"] = 234,
        ["fileDataIDs"] = { 272633,272647 } 
    },
    {
        ["offsetX"]=247,
        ["textureHeight"] = 205,
        ["textureWidth"] = 270,
        ["offsetY"] = 0,
        ["fileDataIDs"] = { 272632,272641 } 
    },
    {
        ["offsetX"]=457,
        ["textureHeight"] = 355,
        ["textureWidth"] = 288,
        ["offsetY"] = 282,
        ["fileDataIDs"] = { 272648,272634,272635,272623 } 
    },
    {
        ["offsetX"]=553,
        ["textureHeight"] = 275,
        ["textureWidth"] = 320,
        ["offsetY"] = 197,
        ["fileDataIDs"] = { 272630,272649,272642,272636 } 
    }
},
[1251] = {
    {
        ["offsetX"]=241,
        ["textureHeight"] = 100,
        ["textureWidth"] = 100,
        ["offsetY"] = 6,
        ["fileDataIDs"] = { 2212638 } 
    },
    {
        ["offsetX"]=555,
        ["textureHeight"] = 160,
        ["textureWidth"] = 170,
        ["offsetY"] = 181,
        ["fileDataIDs"] = { 2212635 } 
    },
    {
        ["offsetX"]=447,
        ["textureHeight"] = 220,
        ["textureWidth"] = 190,
        ["offsetY"] = 102,
        ["fileDataIDs"] = { 271111 } 
    },
    {
        ["offsetX"]=293,
        ["textureHeight"] = 242,
        ["textureWidth"] = 195,
        ["offsetY"] = 426,
        ["fileDataIDs"] = { 271122 } 
    },
    {
        ["offsetX"]=554,
        ["textureHeight"] = 250,
        ["textureWidth"] = 200,
        ["offsetY"] = 0,
        ["fileDataIDs"] = { 271114 } 
    },
    {
        ["offsetX"]=431,
        ["textureHeight"] = 145,
        ["textureWidth"] = 205,
        ["offsetY"] = 0,
        ["fileDataIDs"] = { 271126 } 
    },
    {
        ["offsetX"]=690,
        ["textureHeight"] = 195,
        ["textureWidth"] = 205,
        ["offsetY"] = 444,
        ["fileDataIDs"] = { 271105 } 
    },
    {
        ["offsetX"]=311,
        ["textureHeight"] = 250,
        ["textureWidth"] = 205,
        ["offsetY"] = 61,
        ["fileDataIDs"] = { 2212632 } 
    },
    {
        ["offsetX"]=590,
        ["textureHeight"] = 285,
        ["textureWidth"] = 205,
        ["offsetY"] = 365,
        ["fileDataIDs"] = { 2212636,2212637 } 
    },
    {
        ["offsetX"]=607,
        ["textureHeight"] = 220,
        ["textureWidth"] = 220,
        ["offsetY"] = 215,
        ["fileDataIDs"] = { 2212634 } 
    },
    {
        ["offsetX"]=167,
        ["textureHeight"] = 230,
        ["textureWidth"] = 230,
        ["offsetY"] = 389,
        ["fileDataIDs"] = { 271125 } 
    },
    {
        ["offsetX"]=212,
        ["textureHeight"] = 285,
        ["textureWidth"] = 245,
        ["offsetY"] = 215,
        ["fileDataIDs"] = { 271106,271129 } 
    },
    {
        ["offsetX"]=387,
        ["textureHeight"] = 250,
        ["textureWidth"] = 275,
        ["offsetY"] = 244,
        ["fileDataIDs"] = { 271127,2212633 } 
    },
    {
        ["offsetX"]=625,
        ["textureHeight"] = 245,
        ["textureWidth"] = 285,
        ["offsetY"] = 33,
        ["fileDataIDs"] = { 271104,271124 } 
    },
    {
        ["offsetX"]=399,
        ["textureHeight"] = 280,
        ["textureWidth"] = 285,
        ["offsetY"] = 380,
        ["fileDataIDs"] = { 271108,271112,271113,271109 } 
    }
},
[1252] = {
    {
        ["offsetX"]=493,
        ["textureHeight"] = 110,
        ["textureWidth"] = 110,
        ["offsetY"] = 70,
        ["fileDataIDs"] = { 2212732 } 
    },
    {
        ["offsetX"]=478,
        ["textureHeight"] = 170,
        ["textureWidth"] = 110,
        ["offsetY"] = 386,
        ["fileDataIDs"] = { 2212728 } 
    },
    {
        ["offsetX"]=486,
        ["textureHeight"] = 115,
        ["textureWidth"] = 115,
        ["offsetY"] = 329,
        ["fileDataIDs"] = { 2212726 } 
    },
    {
        ["offsetX"]=623,
        ["textureHeight"] = 195,
        ["textureWidth"] = 120,
        ["offsetY"] = 167,
        ["fileDataIDs"] = { 2212729 } 
    },
    {
        ["offsetX"]=690,
        ["textureHeight"] = 165,
        ["textureWidth"] = 140,
        ["offsetY"] = 141,
        ["fileDataIDs"] = { 271696 } 
    },
    {
        ["offsetX"]=404,
        ["textureHeight"] = 320,
        ["textureWidth"] = 145,
        ["offsetY"] = 256,
        ["fileDataIDs"] = { 271700,271682 } 
    },
    {
        ["offsetX"]=454,
        ["textureHeight"] = 125,
        ["textureWidth"] = 150,
        ["offsetY"] = 0,
        ["fileDataIDs"] = { 2212721 } 
    },
    {
        ["offsetX"]=689,
        ["textureHeight"] = 160,
        ["textureWidth"] = 155,
        ["offsetY"] = 233,
        ["fileDataIDs"] = { 271675 } 
    },
    {
        ["offsetX"]=208,
        ["textureHeight"] = 180,
        ["textureWidth"] = 180,
        ["offsetY"] = 234,
        ["fileDataIDs"] = { 2212734 } 
    },
    {
        ["offsetX"]=305,
        ["textureHeight"] = 155,
        ["textureWidth"] = 190,
        ["offsetY"] = 0,
        ["fileDataIDs"] = { 2212733 } 
    },
    {
        ["offsetX"]=540,
        ["textureHeight"] = 250,
        ["textureWidth"] = 190,
        ["offsetY"] = 320,
        ["fileDataIDs"] = { 271699 } 
    },
    {
        ["offsetX"]=192,
        ["textureHeight"] = 293,
        ["textureWidth"] = 215,
        ["offsetY"] = 375,
        ["fileDataIDs"] = { 2212730,2212731 } 
    },
    {
        ["offsetX"]=751,
        ["textureHeight"] = 180,
        ["textureWidth"] = 225,
        ["offsetY"] = 198,
        ["fileDataIDs"] = { 271680 } 
    },
    {
        ["offsetX"]=454,
        ["textureHeight"] = 195,
        ["textureWidth"] = 230,
        ["offsetY"] = 201,
        ["fileDataIDs"] = { 271687 } 
    },
    {
        ["offsetX"]=618,
        ["textureHeight"] = 220,
        ["textureWidth"] = 240,
        ["offsetY"] = 298,
        ["fileDataIDs"] = { 2212735 } 
    },
    {
        ["offsetX"]=319,
        ["textureHeight"] = 245,
        ["textureWidth"] = 285,
        ["offsetY"] = 75,
        ["fileDataIDs"] = { 271705,271686 } 
    }
},
[1253] = {
    {
        ["offsetX"]=660,
        ["textureHeight"] = 195,
        ["textureWidth"] = 200,
        ["offsetY"] = 21,
        ["fileDataIDs"] = { 271494 } 
    },
    {
        ["offsetX"]=534,
        ["textureHeight"] = 205,
        ["textureWidth"] = 230,
        ["offsetY"] = 224,
        ["fileDataIDs"] = { 271500 } 
    },
    {
        ["offsetX"]=422,
        ["textureHeight"] = 315,
        ["textureWidth"] = 250,
        ["offsetY"] = 0,
        ["fileDataIDs"] = { 271507,271504 } 
    },
    {
        ["offsetX"]=257,
        ["textureHeight"] = 250,
        ["textureWidth"] = 255,
        ["offsetY"] = 313,
        ["fileDataIDs"] = { 2212689 } 
    },
    {
        ["offsetX"]=230,
        ["textureHeight"] = 270,
        ["textureWidth"] = 280,
        ["offsetY"] = 0,
        ["fileDataIDs"] = { 2212685,2212686,2212687,2212688 } 
    },
    {
        ["offsetX"]=367,
        ["textureHeight"] = 240,
        ["textureWidth"] = 285,
        ["offsetY"] = 381,
        ["fileDataIDs"] = { 271503,271509 } 
    },
    {
        ["offsetX"]=239,
        ["textureHeight"] = 255,
        ["textureWidth"] = 400,
        ["offsetY"] = 189,
        ["fileDataIDs"] = { 2212683,2212684 } 
    }
},
[1254] = {
    {
        ["offsetX"]=611,
        ["textureHeight"] = 140,
        ["textureWidth"] = 110,
        ["offsetY"] = 147,
        ["fileDataIDs"] = { 2213315 } 
    },
    {
        ["offsetX"]=473,
        ["textureHeight"] = 180,
        ["textureWidth"] = 110,
        ["offsetY"] = 234,
        ["fileDataIDs"] = { 272800 } 
    },
    {
        ["offsetX"]=533,
        ["textureHeight"] = 135,
        ["textureWidth"] = 120,
        ["offsetY"] = 104,
        ["fileDataIDs"] = { 2213275 } 
    },
    {
        ["offsetX"]=291,
        ["textureHeight"] = 160,
        ["textureWidth"] = 150,
        ["offsetY"] = 434,
        ["fileDataIDs"] = { 2213311 } 
    },
    {
        ["offsetX"]=561,
        ["textureHeight"] = 150,
        ["textureWidth"] = 155,
        ["offsetY"] = 256,
        ["fileDataIDs"] = { 272789 } 
    },
    {
        ["offsetX"]=592,
        ["textureHeight"] = 150,
        ["textureWidth"] = 155,
        ["offsetY"] = 75,
        ["fileDataIDs"] = { 2213281 } 
    },
    {
        ["offsetX"]=395,
        ["textureHeight"] = 150,
        ["textureWidth"] = 160,
        ["offsetY"] = 346,
        ["fileDataIDs"] = { 272798 } 
    },
    {
        ["offsetX"]=629,
        ["textureHeight"] = 190,
        ["textureWidth"] = 160,
        ["offsetY"] = 220,
        ["fileDataIDs"] = { 2213273 } 
    },
    {
        ["offsetX"]=509,
        ["textureHeight"] = 180,
        ["textureWidth"] = 165,
        ["offsetY"] = 168,
        ["fileDataIDs"] = { 2213313 } 
    },
    {
        ["offsetX"]=421,
        ["textureHeight"] = 165,
        ["textureWidth"] = 175,
        ["offsetY"] = 91,
        ["fileDataIDs"] = { 272774 } 
    },
    {
        ["offsetX"]=252,
        ["textureHeight"] = 200,
        ["textureWidth"] = 180,
        ["offsetY"] = 199,
        ["fileDataIDs"] = { 272792 } 
    },
    {
        ["offsetX"]=203,
        ["textureHeight"] = 250,
        ["textureWidth"] = 185,
        ["offsetY"] = 286,
        ["fileDataIDs"] = { 272781 } 
    },
    {
        ["offsetX"]=299,
        ["textureHeight"] = 175,
        ["textureWidth"] = 195,
        ["offsetY"] = 100,
        ["fileDataIDs"] = { 272776 } 
    },
    {
        ["offsetX"]=323,
        ["textureHeight"] = 210,
        ["textureWidth"] = 195,
        ["offsetY"] = 359,
        ["fileDataIDs"] = { 272784 } 
    },
    {
        ["offsetX"]=325,
        ["textureHeight"] = 145,
        ["textureWidth"] = 205,
        ["offsetY"] = 289,
        ["fileDataIDs"] = { 272782 } 
    },
    {
        ["offsetX"]=445,
        ["textureHeight"] = 157,
        ["textureWidth"] = 205,
        ["offsetY"] = 511,
        ["fileDataIDs"] = { 272801 } 
    },
    {
        ["offsetX"]=254,
        ["textureHeight"] = 175,
        ["textureWidth"] = 210,
        ["offsetY"] = 0,
        ["fileDataIDs"] = { 272788 } 
    },
    {
        ["offsetX"]=499,
        ["textureHeight"] = 175,
        ["textureWidth"] = 215,
        ["offsetY"] = 293,
        ["fileDataIDs"] = { 272795 } 
    },
    {
        ["offsetX"]=363,
        ["textureHeight"] = 180,
        ["textureWidth"] = 215,
        ["offsetY"] = 194,
        ["fileDataIDs"] = { 272799 } 
    },
    {
        ["offsetX"]=449,
        ["textureHeight"] = 210,
        ["textureWidth"] = 220,
        ["offsetY"] = 372,
        ["fileDataIDs"] = { 272805 } 
    }
},
[1259] = {
    {
        ["offsetX"]=818,
        ["textureHeight"] = 155,
        ["textureWidth"] = 120,
        ["offsetY"] = 107,
        ["fileDataIDs"] = { 270434 } 
    },
    {
        ["offsetX"]=422,
        ["textureHeight"] = 215,
        ["textureWidth"] = 145,
        ["offsetY"] = 95,
        ["fileDataIDs"] = { 2212573 } 
    },
    {
        ["offsetX"]=404,
        ["textureHeight"] = 210,
        ["textureWidth"] = 160,
        ["offsetY"] = 194,
        ["fileDataIDs"] = { 270412 } 
    },
    {
        ["offsetX"]=681,
        ["textureHeight"] = 200,
        ["textureWidth"] = 190,
        ["offsetY"] = 153,
        ["fileDataIDs"] = { 2212567 } 
    },
    {
        ["offsetX"]=77,
        ["textureHeight"] = 150,
        ["textureWidth"] = 200,
        ["offsetY"] = 331,
        ["fileDataIDs"] = { 2212555 } 
    },
    {
        ["offsetX"]=84,
        ["textureHeight"] = 175,
        ["textureWidth"] = 215,
        ["offsetY"] = 229,
        ["fileDataIDs"] = { 2212574 } 
    },
    {
        ["offsetX"]=191,
        ["textureHeight"] = 255,
        ["textureWidth"] = 220,
        ["offsetY"] = 369,
        ["fileDataIDs"] = { 2212554 } 
    },
    {
        ["offsetX"]=35,
        ["textureHeight"] = 180,
        ["textureWidth"] = 225,
        ["offsetY"] = 422,
        ["fileDataIDs"] = { 2212564 } 
    },
    {
        ["offsetX"]=478,
        ["textureHeight"] = 140,
        ["textureWidth"] = 235,
        ["offsetY"] = 44,
        ["fileDataIDs"] = { 2212560 } 
    },
    {
        ["offsetX"]=250,
        ["textureHeight"] = 270,
        ["textureWidth"] = 235,
        ["offsetY"] = 106,
        ["fileDataIDs"] = { 2212571,2212572 } 
    },
    {
        ["offsetX"]=552,
        ["textureHeight"] = 125,
        ["textureWidth"] = 240,
        ["offsetY"] = 499,
        ["fileDataIDs"] = { 270410 } 
    },
    {
        ["offsetX"]=499,
        ["textureHeight"] = 155,
        ["textureWidth"] = 240,
        ["offsetY"] = 119,
        ["fileDataIDs"] = { 2212568 } 
    },
    {
        ["offsetX"]=644,
        ["textureHeight"] = 185,
        ["textureWidth"] = 245,
        ["offsetY"] = 40,
        ["fileDataIDs"] = { 270432 } 
    },
    {
        ["offsetX"]=238,
        ["textureHeight"] = 280,
        ["textureWidth"] = 265,
        ["offsetY"] = 221,
        ["fileDataIDs"] = { 270414,2212561,2212562,2212563 } 
    },
    {
        ["offsetX"]=479,
        ["textureHeight"] = 300,
        ["textureWidth"] = 270,
        ["offsetY"] = 201,
        ["fileDataIDs"] = { 2212550,2212551,2212552,2212553 } 
    },
    {
        ["offsetX"]=296,
        ["textureHeight"] = 200,
        ["textureWidth"] = 315,
        ["offsetY"] = 429,
        ["fileDataIDs"] = { 270409,2212559 } 
    },
    {
        ["offsetX"]=389,
        ["textureHeight"] = 220,
        ["textureWidth"] = 370,
        ["offsetY"] = 353,
        ["fileDataIDs"] = { 2212565,2212566 } 
    },
    {
        ["offsetX"]=396,
        ["textureHeight"] = 128,
        ["textureWidth"] = 395,
        ["offsetY"] = 540,
        ["fileDataIDs"] = { 2212569,2212570 } 
    },
    {
        ["offsetX"]=366,
        ["textureHeight"] = 170,
        ["textureWidth"] = 570,
        ["offsetY"] = 0,
        ["fileDataIDs"] = { 2212556,2212557,2212558 } 
    }
},
[1260] = {
    {
        ["offsetX"]=496,
        ["textureHeight"] = 159,
        ["textureWidth"] = 145,
        ["offsetY"] = 509,
        ["fileDataIDs"] = { 271657 } 
    },
    {
        ["offsetX"]=548,
        ["textureHeight"] = 145,
        ["textureWidth"] = 160,
        ["offsetY"] = 90,
        ["fileDataIDs"] = { 271653 } 
    },
    {
        ["offsetX"]=332,
        ["textureHeight"] = 155,
        ["textureWidth"] = 165,
        ["offsetY"] = 465,
        ["fileDataIDs"] = { 271663 } 
    },
    {
        ["offsetX"]=408,
        ["textureHeight"] = 135,
        ["textureWidth"] = 175,
        ["offsetY"] = 533,
        ["fileDataIDs"] = { 271658 } 
    },
    {
        ["offsetX"]=405,
        ["textureHeight"] = 160,
        ["textureWidth"] = 185,
        ["offsetY"] = 429,
        ["fileDataIDs"] = { 271659 } 
    },
    {
        ["offsetX"]=330,
        ["textureHeight"] = 170,
        ["textureWidth"] = 195,
        ["offsetY"] = 29,
        ["fileDataIDs"] = { 271652 } 
    },
    {
        ["offsetX"]=420,
        ["textureHeight"] = 215,
        ["textureWidth"] = 215,
        ["offsetY"] = 54,
        ["fileDataIDs"] = { 271673 } 
    },
    {
        ["offsetX"]=292,
        ["textureHeight"] = 145,
        ["textureWidth"] = 235,
        ["offsetY"] = 263,
        ["fileDataIDs"] = { 271666 } 
    },
    {
        ["offsetX"]=297,
        ["textureHeight"] = 155,
        ["textureWidth"] = 235,
        ["offsetY"] = 381,
        ["fileDataIDs"] = { 271664 } 
    },
    {
        ["offsetX"]=307,
        ["textureHeight"] = 200,
        ["textureWidth"] = 235,
        ["offsetY"] = 123,
        ["fileDataIDs"] = { 271665 } 
    },
    {
        ["offsetX"]=483,
        ["textureHeight"] = 145,
        ["textureWidth"] = 240,
        ["offsetY"] = 0,
        ["fileDataIDs"] = { 271660 } 
    },
    {
        ["offsetX"]=271,
        ["textureHeight"] = 128,
        ["textureWidth"] = 245,
        ["offsetY"] = 331,
        ["fileDataIDs"] = { 271669 } 
    }
},
[1261] = {
    {
        ["offsetX"]=582,
        ["textureHeight"] = 285,
        ["textureWidth"] = 285,
        ["offsetY"] = 67,
        ["fileDataIDs"] = { 273051,2213483,2213484,2213486 } 
    },
    {
        ["offsetX"]=367,
        ["textureHeight"] = 270,
        ["textureWidth"] = 295,
        ["offsetY"] = 178,
        ["fileDataIDs"] = { 273042,273065,273050,273036 } 
    },
    {
        ["offsetX"]=560,
        ["textureHeight"] = 355,
        ["textureWidth"] = 310,
        ["offsetY"] = 240,
        ["fileDataIDs"] = { 273072,273039,273037,273063 } 
    },
    {
        ["offsetX"]=121,
        ["textureHeight"] = 345,
        ["textureWidth"] = 315,
        ["offsetY"] = 151,
        ["fileDataIDs"] = { 273043,273075,273069,273061 } 
    },
    {
        ["offsetX"]=158,
        ["textureHeight"] = 285,
        ["textureWidth"] = 345,
        ["offsetY"] = 368,
        ["fileDataIDs"] = { 273046,273053,273071,273047 } 
    },
    {
        ["offsetX"]=367,
        ["textureHeight"] = 285,
        ["textureWidth"] = 345,
        ["offsetY"] = 380,
        ["fileDataIDs"] = { 273059,273066,273073,273054 } 
    },
    {
        ["offsetX"]=160,
        ["textureHeight"] = 265,
        ["textureWidth"] = 570,
        ["offsetY"] = 6,
        ["fileDataIDs"] = { 273052,273062,273057,273058,2213490,2213491 } 
    }
},
[1263] = {
    {
        ["offsetX"]=244,
        ["textureHeight"] = 510,
        ["textureWidth"] = 555,
        ["offsetY"] = 89,
        ["fileDataIDs"] = { 252844,252845,252846,252847,2212870,2212872 } 
    }
},
[1264] = {
    {
        ["offsetX"]=116,
        ["textureHeight"] = 256,
        ["textureWidth"] = 288,
        ["offsetY"] = 413,
        ["fileDataIDs"] = { 272564,272553 } 
    },
    {
        ["offsetX"]=344,
        ["textureHeight"] = 256,
        ["textureWidth"] = 320,
        ["offsetY"] = 197,
        ["fileDataIDs"] = { 272573,272545 } 
    },
    {
        ["offsetX"]=104,
        ["textureHeight"] = 289,
        ["textureWidth"] = 320,
        ["offsetY"] = 24,
        ["fileDataIDs"] = { 272581,272562,2213052,2213053 } 
    },
    {
        ["offsetX"]=500,
        ["textureHeight"] = 384,
        ["textureWidth"] = 384,
        ["offsetY"] = 65,
        ["fileDataIDs"] = { 272580,272544,2213048,2213049 } 
    },
    {
        ["offsetX"]=97,
        ["textureHeight"] = 512,
        ["textureWidth"] = 384,
        ["offsetY"] = 144,
        ["fileDataIDs"] = { 272559,272543,272574,272575 } 
    },
    {
        ["offsetX"]=265,
        ["textureHeight"] = 320,
        ["textureWidth"] = 512,
        ["offsetY"] = 12,
        ["fileDataIDs"] = { 272565,272566,272577,272546 } 
    },
    {
        ["offsetX"]=245,
        ["textureHeight"] = 384,
        ["textureWidth"] = 512,
        ["offsetY"] = 285,
        ["fileDataIDs"] = { 272567,272547,272555,272548 } 
    }
},
[1266] = {
    {
        ["offsetX"]=611,
        ["textureHeight"] = 165,
        ["textureWidth"] = 125,
        ["offsetY"] = 242,
        ["fileDataIDs"] = { 273206 } 
    },
    {
        ["offsetX"]=617,
        ["textureHeight"] = 125,
        ["textureWidth"] = 145,
        ["offsetY"] = 158,
        ["fileDataIDs"] = { 273200 } 
    },
    {
        ["offsetX"]=593,
        ["textureHeight"] = 140,
        ["textureWidth"] = 165,
        ["offsetY"] = 340,
        ["fileDataIDs"] = { 273199 } 
    },
    {
        ["offsetX"]=509,
        ["textureHeight"] = 200,
        ["textureWidth"] = 165,
        ["offsetY"] = 107,
        ["fileDataIDs"] = { 273191 } 
    },
    {
        ["offsetX"]=555,
        ["textureHeight"] = 185,
        ["textureWidth"] = 175,
        ["offsetY"] = 27,
        ["fileDataIDs"] = { 273203 } 
    },
    {
        ["offsetX"]=392,
        ["textureHeight"] = 160,
        ["textureWidth"] = 185,
        ["offsetY"] = 137,
        ["fileDataIDs"] = { 273207 } 
    },
    {
        ["offsetX"]=493,
        ["textureHeight"] = 180,
        ["textureWidth"] = 185,
        ["offsetY"] = 258,
        ["fileDataIDs"] = { 273185 } 
    },
    {
        ["offsetX"]=523,
        ["textureHeight"] = 160,
        ["textureWidth"] = 200,
        ["offsetY"] = 376,
        ["fileDataIDs"] = { 273198 } 
    },
    {
        ["offsetX"]=401,
        ["textureHeight"] = 185,
        ["textureWidth"] = 215,
        ["offsetY"] = 198,
        ["fileDataIDs"] = { 273192 } 
    },
    {
        ["offsetX"]=229,
        ["textureHeight"] = 120,
        ["textureWidth"] = 230,
        ["offsetY"] = 243,
        ["fileDataIDs"] = { 273187 } 
    },
    {
        ["offsetX"]=222,
        ["textureHeight"] = 140,
        ["textureWidth"] = 240,
        ["offsetY"] = 172,
        ["fileDataIDs"] = { 273202 } 
    },
    {
        ["offsetX"]=368,
        ["textureHeight"] = 180,
        ["textureWidth"] = 250,
        ["offsetY"] = 7,
        ["fileDataIDs"] = { 273184 } 
    },
    {
        ["offsetX"]=447,
        ["textureHeight"] = 205,
        ["textureWidth"] = 255,
        ["offsetY"] = 441,
        ["fileDataIDs"] = { 2213650 } 
    }
},
[1628] = {
    {
        ["offsetX"]=554,
        ["textureHeight"] = 193,
        ["textureWidth"] = 128,
        ["offsetY"] = 475,
        ["fileDataIDs"] = { 271603 } 
    },
    {
        ["offsetX"]=584,
        ["textureHeight"] = 197,
        ["textureWidth"] = 128,
        ["offsetY"] = 471,
        ["fileDataIDs"] = { 271598 } 
    },
    {
        ["offsetX"]=511,
        ["textureHeight"] = 248,
        ["textureWidth"] = 128,
        ["offsetY"] = 420,
        ["fileDataIDs"] = { 271592 } 
    },
    {
        ["offsetX"]=183,
        ["textureHeight"] = 253,
        ["textureWidth"] = 128,
        ["offsetY"] = 415,
        ["fileDataIDs"] = { 271625 } 
    },
    {
        ["offsetX"]=292,
        ["textureHeight"] = 256,
        ["textureWidth"] = 128,
        ["offsetY"] = 319,
        ["fileDataIDs"] = { 271633 } 
    },
    {
        ["offsetX"]=580,
        ["textureHeight"] = 256,
        ["textureWidth"] = 128,
        ["offsetY"] = 399,
        ["fileDataIDs"] = { 271630 } 
    },
    {
        ["offsetX"]=231,
        ["textureHeight"] = 128,
        ["textureWidth"] = 256,
        ["offsetY"] = 404,
        ["fileDataIDs"] = { 271627 } 
    },
    {
        ["offsetX"]=243,
        ["textureHeight"] = 128,
        ["textureWidth"] = 256,
        ["offsetY"] = 469,
        ["fileDataIDs"] = { 271635 } 
    },
    {
        ["offsetX"]=255,
        ["textureHeight"] = 128,
        ["textureWidth"] = 256,
        ["offsetY"] = 507,
        ["fileDataIDs"] = { 271596 } 
    },
    {
        ["offsetX"]=524,
        ["textureHeight"] = 128,
        ["textureWidth"] = 256,
        ["offsetY"] = 359,
        ["fileDataIDs"] = { 271591 } 
    },
    {
        ["offsetX"]=539,
        ["textureHeight"] = 128,
        ["textureWidth"] = 256,
        ["offsetY"] = 305,
        ["fileDataIDs"] = { 271628 } 
    },
    {
        ["offsetX"]=378,
        ["textureHeight"] = 172,
        ["textureWidth"] = 256,
        ["offsetY"] = 496,
        ["fileDataIDs"] = { 271614 } 
    },
    {
        ["offsetX"]=464,
        ["textureHeight"] = 174,
        ["textureWidth"] = 256,
        ["offsetY"] = 494,
        ["fileDataIDs"] = { 271615 } 
    },
    {
        ["offsetX"]=215,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 298,
        ["fileDataIDs"] = { 271601 } 
    },
    {
        ["offsetX"]=307,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 136,
        ["fileDataIDs"] = { 271608 } 
    },
    {
        ["offsetX"]=324,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 384,
        ["fileDataIDs"] = { 271599 } 
    },
    {
        ["offsetX"]=361,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 298,
        ["fileDataIDs"] = { 271637 } 
    },
    {
        ["offsetX"]=386,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 386,
        ["fileDataIDs"] = { 271612 } 
    },
    {
        ["offsetX"]=460,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 373,
        ["fileDataIDs"] = { 271588 } 
    },
    {
        ["offsetX"]=474,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 314,
        ["fileDataIDs"] = { 271610 } 
    },
    {
        ["offsetX"]=605,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 253,
        ["fileDataIDs"] = { 271604 } 
    },
    {
        ["offsetX"]=669,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 228,
        ["fileDataIDs"] = { 271586 } 
    },
    {
        ["offsetX"]=648,
        ["textureHeight"] = 353,
        ["textureWidth"] = 256,
        ["offsetY"] = 315,
        ["fileDataIDs"] = { 271587,271590 } 
    },
    {
        ["offsetX"]=195,
        ["textureHeight"] = 512,
        ["textureWidth"] = 512,
        ["offsetY"] = 5,
        ["fileDataIDs"] = { 271619,271602,271589,271638 } 
    },
    {
        ["offsetX"]=440,
        ["textureHeight"] = 512,
        ["textureWidth"] = 512,
        ["offsetY"] = 87,
        ["fileDataIDs"] = { 271632,271600,271617,271618 } 
    }
},
[1629] = {
    {
        ["offsetX"]=40,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 287,
        ["fileDataIDs"] = { 271752 } 
    },
    {
        ["offsetX"]=184,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 238,
        ["fileDataIDs"] = { 271744 } 
    },
    {
        ["offsetX"]=210,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 126,
        ["fileDataIDs"] = { 271716 } 
    },
    {
        ["offsetX"]=585,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 0,
        ["fileDataIDs"] = { 271761 } 
    },
    {
        ["offsetX"]=364,
        ["textureHeight"] = 262,
        ["textureWidth"] = 256,
        ["offsetY"] = 406,
        ["fileDataIDs"] = { 271711,271717 } 
    },
    {
        ["offsetX"]=340,
        ["textureHeight"] = 449,
        ["textureWidth"] = 256,
        ["offsetY"] = 219,
        ["fileDataIDs"] = { 271740,271730 } 
    },
    {
        ["offsetX"]=60,
        ["textureHeight"] = 512,
        ["textureWidth"] = 256,
        ["offsetY"] = 117,
        ["fileDataIDs"] = { 271754,271733 } 
    },
    {
        ["offsetX"]=365,
        ["textureHeight"] = 512,
        ["textureWidth"] = 256,
        ["offsetY"] = 2,
        ["fileDataIDs"] = { 271762,271751 } 
    },
    {
        ["offsetX"]=448,
        ["textureHeight"] = 512,
        ["textureWidth"] = 256,
        ["offsetY"] = 150,
        ["fileDataIDs"] = { 271741,271723 } 
    },
    {
        ["offsetX"]=598,
        ["textureHeight"] = 436,
        ["textureWidth"] = 404,
        ["offsetY"] = 232,
        ["fileDataIDs"] = { 271742,271728,271758,271706 } 
    },
    {
        ["offsetX"]=575,
        ["textureHeight"] = 256,
        ["textureWidth"] = 427,
        ["offsetY"] = 0,
        ["fileDataIDs"] = { 271735,271736 } 
    },
    {
        ["offsetX"]=573,
        ["textureHeight"] = 256,
        ["textureWidth"] = 429,
        ["offsetY"] = 136,
        ["fileDataIDs"] = { 271715,271745 } 
    },
    {
        ["offsetX"]=326,
        ["textureHeight"] = 256,
        ["textureWidth"] = 512,
        ["offsetY"] = 0,
        ["fileDataIDs"] = { 271729,271707 } 
    },
    {
        ["offsetX"]=460,
        ["textureHeight"] = 256,
        ["textureWidth"] = 512,
        ["offsetY"] = 0,
        ["fileDataIDs"] = { 271731,271719 } 
    },
    {
        ["offsetX"]=95,
        ["textureHeight"] = 293,
        ["textureWidth"] = 512,
        ["offsetY"] = 375,
        ["fileDataIDs"] = { 271721,271725,271714,271737 } 
    },
    {
        ["offsetX"]=466,
        ["textureHeight"] = 431,
        ["textureWidth"] = 512,
        ["offsetY"] = 237,
        ["fileDataIDs"] = { 271712,271757,271713,271734 } 
    },
    {
        ["offsetX"]=44,
        ["textureHeight"] = 512,
        ["textureWidth"] = 512,
        ["offsetY"] = 0,
        ["fileDataIDs"] = { 271726,271756,271727,271710 } 
    }
},
[1631] = {
    {
        ["offsetX"]=462,
        ["textureHeight"] = 256,
        ["textureWidth"] = 128,
        ["offsetY"] = 349,
        ["fileDataIDs"] = { 270497 } 
    },
    {
        ["offsetX"]=356,
        ["textureHeight"] = 128,
        ["textureWidth"] = 256,
        ["offsetY"] = 0,
        ["fileDataIDs"] = { 270493 } 
    },
    {
        ["offsetX"]=23,
        ["textureHeight"] = 222,
        ["textureWidth"] = 256,
        ["offsetY"] = 446,
        ["fileDataIDs"] = { 270498 } 
    },
    {
        ["offsetX"]=220,
        ["textureHeight"] = 247,
        ["textureWidth"] = 256,
        ["offsetY"] = 421,
        ["fileDataIDs"] = { 270482 } 
    },
    {
        ["offsetX"]=174,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 363,
        ["fileDataIDs"] = { 270492 } 
    },
    {
        ["offsetX"]=176,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 303,
        ["fileDataIDs"] = { 270463 } 
    },
    {
        ["offsetX"]=281,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 305,
        ["fileDataIDs"] = { 270509 } 
    },
    {
        ["offsetX"]=291,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 3,
        ["fileDataIDs"] = { 270510 } 
    },
    {
        ["offsetX"]=352,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 378,
        ["fileDataIDs"] = { 270481 } 
    },
    {
        ["offsetX"]=365,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 49,
        ["fileDataIDs"] = { 270488 } 
    },
    {
        ["offsetX"]=383,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 249,
        ["fileDataIDs"] = { 270513 } 
    },
    {
        ["offsetX"]=449,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 183,
        ["fileDataIDs"] = { 270508 } 
    },
    {
        ["offsetX"]=488,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 24,
        ["fileDataIDs"] = { 270474 } 
    },
    {
        ["offsetX"]=507,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 350,
        ["fileDataIDs"] = { 270512 } 
    },
    {
        ["offsetX"]=515,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 279,
        ["fileDataIDs"] = { 270476 } 
    },
    {
        ["offsetX"]=527,
        ["textureHeight"] = 512,
        ["textureWidth"] = 475,
        ["offsetY"] = 104,
        ["fileDataIDs"] = { 270511,270483,270489,270484 } 
    },
    {
        ["offsetX"]=74,
        ["textureHeight"] = 512,
        ["textureWidth"] = 512,
        ["offsetY"] = 85,
        ["fileDataIDs"] = { 270475,270515,270495,270505 } 
    }
},
[1633] = {
    {
        ["offsetX"]=34,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 142,
        ["fileDataIDs"] = { 271836 } 
    },
    {
        ["offsetX"]=182,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 412,
        ["fileDataIDs"] = { 271830 } 
    },
    {
        ["offsetX"]=206,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 110,
        ["fileDataIDs"] = { 271835 } 
    },
    {
        ["offsetX"]=467,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 154,
        ["fileDataIDs"] = { 271852 } 
    },
    {
        ["offsetX"]=469,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 298,
        ["fileDataIDs"] = { 271848 } 
    },
    {
        ["offsetX"]=705,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 368,
        ["fileDataIDs"] = { 271843 } 
    },
    {
        ["offsetX"]=308,
        ["textureHeight"] = 260,
        ["textureWidth"] = 256,
        ["offsetY"] = 408,
        ["fileDataIDs"] = { 271838,271861 } 
    },
    {
        ["offsetX"]=25,
        ["textureHeight"] = 378,
        ["textureWidth"] = 256,
        ["offsetY"] = 290,
        ["fileDataIDs"] = { 271850,271864 } 
    },
    {
        ["offsetX"]=338,
        ["textureHeight"] = 458,
        ["textureWidth"] = 256,
        ["offsetY"] = 210,
        ["fileDataIDs"] = { 271855,271833 } 
    },
    {
        ["offsetX"]=326,
        ["textureHeight"] = 512,
        ["textureWidth"] = 256,
        ["offsetY"] = 45,
        ["fileDataIDs"] = { 271840,271849 } 
    },
    {
        ["offsetX"]=579,
        ["textureHeight"] = 512,
        ["textureWidth"] = 256,
        ["offsetY"] = 128,
        ["fileDataIDs"] = { 271866,271821 } 
    },
    {
        ["offsetX"]=737,
        ["textureHeight"] = 512,
        ["textureWidth"] = 256,
        ["offsetY"] = 156,
        ["fileDataIDs"] = { 271854,271825 } 
    },
    {
        ["offsetX"]=580,
        ["textureHeight"] = 238,
        ["textureWidth"] = 422,
        ["offsetY"] = 430,
        ["fileDataIDs"] = { 271826,271822 } 
    },
    {
        ["offsetX"]=261,
        ["textureHeight"] = 255,
        ["textureWidth"] = 512,
        ["offsetY"] = 413,
        ["fileDataIDs"] = { 271856,271820 } 
    },
    {
        ["offsetX"]=477,
        ["textureHeight"] = 256,
        ["textureWidth"] = 512,
        ["offsetY"] = 6,
        ["fileDataIDs"] = { 271867,271842 } 
    },
    {
        ["offsetX"]=183,
        ["textureHeight"] = 342,
        ["textureWidth"] = 512,
        ["offsetY"] = 326,
        ["fileDataIDs"] = { 271862,271844,271823,271831 } 
    },
    {
        ["offsetX"]=38,
        ["textureHeight"] = 512,
        ["textureWidth"] = 512,
        ["offsetY"] = 152,
        ["fileDataIDs"] = { 271851,271841,271865,271853 } 
    },
    {
        ["offsetX"]=478,
        ["textureHeight"] = 512,
        ["textureWidth"] = 512,
        ["offsetY"] = 25,
        ["fileDataIDs"] = { 271863,271857,271845,271839 } 
    }
},
[1635] = {
    {
        ["offsetX"]=124,
        ["textureHeight"] = 128,
        ["textureWidth"] = 256,
        ["offsetY"] = 0,
        ["fileDataIDs"] = { 273241 } 
    },
    {
        ["offsetX"]=720,
        ["textureHeight"] = 207,
        ["textureWidth"] = 256,
        ["offsetY"] = 461,
        ["fileDataIDs"] = { 273266 } 
    },
    {
        ["offsetX"]=31,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 339,
        ["fileDataIDs"] = { 273262 } 
    },
    {
        ["offsetX"]=81,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 152,
        ["fileDataIDs"] = { 273222 } 
    },
    {
        ["offsetX"]=88,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 50,
        ["fileDataIDs"] = { 273235 } 
    },
    {
        ["offsetX"]=175,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 232,
        ["fileDataIDs"] = { 273267 } 
    },
    {
        ["offsetX"]=342,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 249,
        ["fileDataIDs"] = { 273233 } 
    },
    {
        ["offsetX"]=512,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 303,
        ["fileDataIDs"] = { 273271 } 
    },
    {
        ["offsetX"]=596,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 412,
        ["fileDataIDs"] = { 273280 } 
    },
    {
        ["offsetX"]=141,
        ["textureHeight"] = 343,
        ["textureWidth"] = 256,
        ["offsetY"] = 325,
        ["fileDataIDs"] = { 273224,273225 } 
    },
    {
        ["offsetX"]=219,
        ["textureHeight"] = 512,
        ["textureWidth"] = 256,
        ["offsetY"] = 51,
        ["fileDataIDs"] = { 273268,273226 } 
    },
    {
        ["offsetX"]=329,
        ["textureHeight"] = 512,
        ["textureWidth"] = 256,
        ["offsetY"] = 25,
        ["fileDataIDs"] = { 273223,273272 } 
    },
    {
        ["offsetX"]=462,
        ["textureHeight"] = 512,
        ["textureWidth"] = 256,
        ["offsetY"] = 90,
        ["fileDataIDs"] = { 273253,273242 } 
    },
    {
        ["offsetX"]=569,
        ["textureHeight"] = 512,
        ["textureWidth"] = 256,
        ["offsetY"] = 112,
        ["fileDataIDs"] = { 273249,273238 } 
    },
    {
        ["offsetX"]=716,
        ["textureHeight"] = 512,
        ["textureWidth"] = 286,
        ["offsetY"] = 128,
        ["fileDataIDs"] = { 273243,273273,273250,273251 } 
    },
    {
        ["offsetX"]=694,
        ["textureHeight"] = 256,
        ["textureWidth"] = 308,
        ["offsetY"] = 321,
        ["fileDataIDs"] = { 273276,273246 } 
    },
    {
        ["offsetX"]=20,
        ["textureHeight"] = 256,
        ["textureWidth"] = 512,
        ["offsetY"] = 202,
        ["fileDataIDs"] = { 273248,273279 } 
    },
    {
        ["offsetX"]=314,
        ["textureHeight"] = 336,
        ["textureWidth"] = 512,
        ["offsetY"] = 332,
        ["fileDataIDs"] = { 273221,273269,273236,273277 } 
    }
},
[1637] = {
    {
        ["offsetX"]=143,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 256,
        ["fileDataIDs"] = { 272431 } 
    },
    {
        ["offsetX"]=520,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 93,
        ["fileDataIDs"] = { 272421 } 
    },
    {
        ["offsetX"]=554,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 308,
        ["fileDataIDs"] = { 272461 } 
    },
    {
        ["offsetX"]=290,
        ["textureHeight"] = 512,
        ["textureWidth"] = 256,
        ["offsetY"] = 129,
        ["fileDataIDs"] = { 272451,272471 } 
    },
    {
        ["offsetX"]=606,
        ["textureHeight"] = 512,
        ["textureWidth"] = 396,
        ["offsetY"] = 126,
        ["fileDataIDs"] = { 272429,272470,272446,272450 } 
    },
    {
        ["offsetX"]=510,
        ["textureHeight"] = 223,
        ["textureWidth"] = 492,
        ["offsetY"] = 445,
        ["fileDataIDs"] = { 272442,272443 } 
    },
    {
        ["offsetX"]=343,
        ["textureHeight"] = 358,
        ["textureWidth"] = 512,
        ["offsetY"] = 310,
        ["fileDataIDs"] = { 272454,272426,272439,272455 } 
    },
    {
        ["offsetX"]=469,
        ["textureHeight"] = 410,
        ["textureWidth"] = 512,
        ["offsetY"] = 258,
        ["fileDataIDs"] = { 272448,272449,272469,272452 } 
    },
    {
        ["offsetX"]=168,
        ["textureHeight"] = 439,
        ["textureWidth"] = 512,
        ["offsetY"] = 229,
        ["fileDataIDs"] = { 272430,272460,272434,272435 } 
    },
    {
        ["offsetX"]=104,
        ["textureHeight"] = 512,
        ["textureWidth"] = 512,
        ["offsetY"] = 155,
        ["fileDataIDs"] = { 272436,272440,272441,272427 } 
    },
    {
        ["offsetX"]=116,
        ["textureHeight"] = 512,
        ["textureWidth"] = 512,
        ["offsetY"] = 35,
        ["fileDataIDs"] = { 272428,272424,272433,272445 } 
    },
    {
        ["offsetX"]=348,
        ["textureHeight"] = 512,
        ["textureWidth"] = 512,
        ["offsetY"] = 8,
        ["fileDataIDs"] = { 272467,272465,272422,272453 } 
    },
    {
        ["offsetX"]=394,
        ["textureHeight"] = 512,
        ["textureWidth"] = 512,
        ["offsetY"] = 90,
        ["fileDataIDs"] = { 272459,272438,272463,272447 } 
    }
},
[1638] = {
    {
        ["offsetX"]=563,
        ["textureHeight"] = 128,
        ["textureWidth"] = 256,
        ["offsetY"] = 151,
        ["fileDataIDs"] = { 270643 } 
    },
    {
        ["offsetX"]=271,
        ["textureHeight"] = 240,
        ["textureWidth"] = 256,
        ["offsetY"] = 428,
        ["fileDataIDs"] = { 270622 } 
    },
    {
        ["offsetX"]=446,
        ["textureHeight"] = 254,
        ["textureWidth"] = 256,
        ["offsetY"] = 414,
        ["fileDataIDs"] = { 270642 } 
    },
    {
        ["offsetX"]=254,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 176,
        ["fileDataIDs"] = { 270663 } 
    },
    {
        ["offsetX"]=286,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 28,
        ["fileDataIDs"] = { 270625 } 
    },
    {
        ["offsetX"]=412,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 95,
        ["fileDataIDs"] = { 270631 } 
    },
    {
        ["offsetX"]=422,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 0,
        ["fileDataIDs"] = { 270665 } 
    },
    {
        ["offsetX"]=439,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 210,
        ["fileDataIDs"] = { 270649 } 
    },
    {
        ["offsetX"]=527,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 81,
        ["fileDataIDs"] = { 270611 } 
    },
    {
        ["offsetX"]=585,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 0,
        ["fileDataIDs"] = { 270651 } 
    },
    {
        ["offsetX"]=623,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 147,
        ["fileDataIDs"] = { 270666 } 
    },
    {
        ["offsetX"]=629,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 406,
        ["fileDataIDs"] = { 270667 } 
    },
    {
        ["offsetX"]=658,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 297,
        ["fileDataIDs"] = { 270655 } 
    },
    {
        ["offsetX"]=673,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 71,
        ["fileDataIDs"] = { 270626 } 
    },
    {
        ["offsetX"]=733,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 109,
        ["fileDataIDs"] = { 270609 } 
    },
    {
        ["offsetX"]=342,
        ["textureHeight"] = 297,
        ["textureWidth"] = 256,
        ["offsetY"] = 371,
        ["fileDataIDs"] = { 270669,270657 } 
    },
    {
        ["offsetX"]=289,
        ["textureHeight"] = 318,
        ["textureWidth"] = 256,
        ["offsetY"] = 350,
        ["fileDataIDs"] = { 270638,270630 } 
    },
    {
        ["offsetX"]=533,
        ["textureHeight"] = 336,
        ["textureWidth"] = 256,
        ["offsetY"] = 332,
        ["fileDataIDs"] = { 270612,270658 } 
    },
    {
        ["offsetX"]=405,
        ["textureHeight"] = 396,
        ["textureWidth"] = 256,
        ["offsetY"] = 272,
        ["fileDataIDs"] = { 270664,270659 } 
    },
    {
        ["offsetX"]=554,
        ["textureHeight"] = 410,
        ["textureWidth"] = 256,
        ["offsetY"] = 258,
        ["fileDataIDs"] = { 270629,270606 } 
    },
    {
        ["offsetX"]=512,
        ["textureHeight"] = 419,
        ["textureWidth"] = 256,
        ["offsetY"] = 249,
        ["fileDataIDs"] = { 270644,270610 } 
    },
    {
        ["offsetX"]=166,
        ["textureHeight"] = 462,
        ["textureWidth"] = 256,
        ["offsetY"] = 206,
        ["fileDataIDs"] = { 270652,270653 } 
    },
    {
        ["offsetX"]=314,
        ["textureHeight"] = 507,
        ["textureWidth"] = 256,
        ["offsetY"] = 161,
        ["fileDataIDs"] = { 270619,270620 } 
    },
    {
        ["offsetX"]=479,
        ["textureHeight"] = 512,
        ["textureWidth"] = 256,
        ["offsetY"] = 98,
        ["fileDataIDs"] = { 270616,270617 } 
    },
    {
        ["offsetX"]=586,
        ["textureHeight"] = 256,
        ["textureWidth"] = 416,
        ["offsetY"] = 147,
        ["fileDataIDs"] = { 270628,270605 } 
    },
    {
        ["offsetX"]=144,
        ["textureHeight"] = 252,
        ["textureWidth"] = 512,
        ["offsetY"] = 416,
        ["fileDataIDs"] = { 270662,270632 } 
    },
    {
        ["offsetX"]=214,
        ["textureHeight"] = 256,
        ["textureWidth"] = 512,
        ["offsetY"] = 55,
        ["fileDataIDs"] = { 270621,270633 } 
    }
},
[1639] = {
    {
        ["offsetX"]=180,
        ["textureHeight"] = 128,
        ["textureWidth"] = 128,
        ["offsetY"] = 216,
        ["fileDataIDs"] = { 270671 } 
    },
    {
        ["offsetX"]=763,
        ["textureHeight"] = 256,
        ["textureWidth"] = 239,
        ["offsetY"] = 256,
        ["fileDataIDs"] = { 270710 } 
    },
    {
        ["offsetX"]=309,
        ["textureHeight"] = 185,
        ["textureWidth"] = 256,
        ["offsetY"] = 483,
        ["fileDataIDs"] = { 270718 } 
    },
    {
        ["offsetX"]=503,
        ["textureHeight"] = 198,
        ["textureWidth"] = 256,
        ["offsetY"] = 470,
        ["fileDataIDs"] = { 270687 } 
    },
    {
        ["offsetX"]=205,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 39,
        ["fileDataIDs"] = { 270701 } 
    },
    {
        ["offsetX"]=221,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 136,
        ["fileDataIDs"] = { 270676 } 
    },
    {
        ["offsetX"]=232,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 242,
        ["fileDataIDs"] = { 270703 } 
    },
    {
        ["offsetX"]=250,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 404,
        ["fileDataIDs"] = { 270739 } 
    },
    {
        ["offsetX"]=293,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 285,
        ["fileDataIDs"] = { 270728 } 
    },
    {
        ["offsetX"]=297,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 136,
        ["fileDataIDs"] = { 270733 } 
    },
    {
        ["offsetX"]=302,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 27,
        ["fileDataIDs"] = { 270727 } 
    },
    {
        ["offsetX"]=367,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 209,
        ["fileDataIDs"] = { 270679 } 
    },
    {
        ["offsetX"]=414,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 406,
        ["fileDataIDs"] = { 270700 } 
    },
    {
        ["offsetX"]=437,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 258,
        ["fileDataIDs"] = { 270698 } 
    },
    {
        ["offsetX"]=451,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 29,
        ["fileDataIDs"] = { 270734 } 
    },
    {
        ["offsetX"]=481,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 117,
        ["fileDataIDs"] = { 270720 } 
    },
    {
        ["offsetX"]=546,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 410,
        ["fileDataIDs"] = { 270699 } 
    },
    {
        ["offsetX"]=555,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 87,
        ["fileDataIDs"] = { 270741 } 
    },
    {
        ["offsetX"]=556,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 216,
        ["fileDataIDs"] = { 270740 } 
    },
    {
        ["offsetX"]=598,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 338,
        ["fileDataIDs"] = { 270677 } 
    },
    {
        ["offsetX"]=613,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 82,
        ["fileDataIDs"] = { 270709 } 
    },
    {
        ["offsetX"]=637,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 0,
        ["fileDataIDs"] = { 270714 } 
    },
    {
        ["offsetX"]=657,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 78,
        ["fileDataIDs"] = { 270712 } 
    },
    {
        ["offsetX"]=729,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 54,
        ["fileDataIDs"] = { 270682 } 
    },
    {
        ["offsetX"]=44,
        ["textureHeight"] = 512,
        ["textureWidth"] = 256,
        ["offsetY"] = 62,
        ["fileDataIDs"] = { 270690,270729 } 
    },
    {
        ["offsetX"]=517,
        ["textureHeight"] = 141,
        ["textureWidth"] = 485,
        ["offsetY"] = 527,
        ["fileDataIDs"] = { 270711,270723 } 
    },
    {
        ["offsetX"]=177,
        ["textureHeight"] = 242,
        ["textureWidth"] = 512,
        ["offsetY"] = 426,
        ["fileDataIDs"] = { 270674,270731 } 
    },
    {
        ["offsetX"]=43,
        ["textureHeight"] = 430,
        ["textureWidth"] = 512,
        ["offsetY"] = 238,
        ["fileDataIDs"] = { 270692,270673,270702,270672 } 
    }
},
[1640] = {
    {
        ["offsetX"]=558,
        ["textureHeight"] = 241,
        ["textureWidth"] = 256,
        ["offsetY"] = 427,
        ["fileDataIDs"] = { 272204 } 
    },
    {
        ["offsetX"]=157,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 32,
        ["fileDataIDs"] = { 272235 } 
    },
    {
        ["offsetX"]=162,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 154,
        ["fileDataIDs"] = { 272198 } 
    },
    {
        ["offsetX"]=219,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 199,
        ["fileDataIDs"] = { 272231 } 
    },
    {
        ["offsetX"]=277,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 54,
        ["fileDataIDs"] = { 272242 } 
    },
    {
        ["offsetX"]=335,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 193,
        ["fileDataIDs"] = { 272213 } 
    },
    {
        ["offsetX"]=351,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 52,
        ["fileDataIDs"] = { 272237 } 
    },
    {
        ["offsetX"]=387,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 390,
        ["fileDataIDs"] = { 272220 } 
    },
    {
        ["offsetX"]=391,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 258,
        ["fileDataIDs"] = { 272230 } 
    },
    {
        ["offsetX"]=431,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 143,
        ["fileDataIDs"] = { 272188 } 
    },
    {
        ["offsetX"]=504,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 53,
        ["fileDataIDs"] = { 272208 } 
    },
    {
        ["offsetX"]=532,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 363,
        ["fileDataIDs"] = { 272236 } 
    },
    {
        ["offsetX"]=533,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 267,
        ["fileDataIDs"] = { 272206 } 
    },
    {
        ["offsetX"]=598,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 79,
        ["fileDataIDs"] = { 272232 } 
    },
    {
        ["offsetX"]=666,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 233,
        ["fileDataIDs"] = { 272244 } 
    },
    {
        ["offsetX"]=660,
        ["textureHeight"] = 334,
        ["textureWidth"] = 256,
        ["offsetY"] = 334,
        ["fileDataIDs"] = { 272196,272197 } 
    },
    {
        ["offsetX"]=10,
        ["textureHeight"] = 512,
        ["textureWidth"] = 256,
        ["offsetY"] = 107,
        ["fileDataIDs"] = { 272199,272200 } 
    },
    {
        ["offsetX"]=168,
        ["textureHeight"] = 334,
        ["textureWidth"] = 512,
        ["offsetY"] = 334,
        ["fileDataIDs"] = { 272205,272229,272190,272238 } 
    },
    {
        ["offsetX"]=36,
        ["textureHeight"] = 420,
        ["textureWidth"] = 512,
        ["offsetY"] = 248,
        ["fileDataIDs"] = { 272224,272233,272191,272212 } 
    }
},
[1641] = {
    {
        ["offsetX"]=316,
        ["textureHeight"] = 256,
        ["textureWidth"] = 128,
        ["offsetY"] = 268,
        ["fileDataIDs"] = { 272840 } 
    },
    {
        ["offsetX"]=321,
        ["textureHeight"] = 208,
        ["textureWidth"] = 256,
        ["offsetY"] = 460,
        ["fileDataIDs"] = { 272889 } 
    },
    {
        ["offsetX"]=247,
        ["textureHeight"] = 234,
        ["textureWidth"] = 256,
        ["offsetY"] = 434,
        ["fileDataIDs"] = { 272843 } 
    },
    {
        ["offsetX"]=116,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 4,
        ["fileDataIDs"] = { 272878 } 
    },
    {
        ["offsetX"]=222,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 362,
        ["fileDataIDs"] = { 272846 } 
    },
    {
        ["offsetX"]=245,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 289,
        ["fileDataIDs"] = { 272881 } 
    },
    {
        ["offsetX"]=310,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 345,
        ["fileDataIDs"] = { 272887 } 
    },
    {
        ["offsetX"]=314,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 0,
        ["fileDataIDs"] = { 272837 } 
    },
    {
        ["offsetX"]=377,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 272,
        ["fileDataIDs"] = { 272836 } 
    },
    {
        ["offsetX"]=397,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 165,
        ["fileDataIDs"] = { 272839 } 
    },
    {
        ["offsetX"]=417,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 327,
        ["fileDataIDs"] = { 272873 } 
    },
    {
        ["offsetX"]=478,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 19,
        ["fileDataIDs"] = { 272880 } 
    },
    {
        ["offsetX"]=480,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 277,
        ["fileDataIDs"] = { 272866 } 
    },
    {
        ["offsetX"]=505,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 154,
        ["fileDataIDs"] = { 272886 } 
    },
    {
        ["offsetX"]=521,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 275,
        ["fileDataIDs"] = { 272835 } 
    },
    {
        ["offsetX"]=103,
        ["textureHeight"] = 367,
        ["textureWidth"] = 256,
        ["offsetY"] = 301,
        ["fileDataIDs"] = { 272844,272847 } 
    },
    {
        ["offsetX"]=455,
        ["textureHeight"] = 512,
        ["textureWidth"] = 256,
        ["offsetY"] = 34,
        ["fileDataIDs"] = { 272879,272834 } 
    },
    {
        ["offsetX"]=617,
        ["textureHeight"] = 512,
        ["textureWidth"] = 385,
        ["offsetY"] = 149,
        ["fileDataIDs"] = { 272860,272855,272850,272856 } 
    },
    {
        ["offsetX"]=143,
        ["textureHeight"] = 256,
        ["textureWidth"] = 512,
        ["offsetY"] = 171,
        ["fileDataIDs"] = { 272851,272867 } 
    },
    {
        ["offsetX"]=449,
        ["textureHeight"] = 320,
        ["textureWidth"] = 512,
        ["offsetY"] = 348,
        ["fileDataIDs"] = { 272876,272888,272857,272877 } 
    },
    {
        ["offsetX"]=104,
        ["textureHeight"] = 512,
        ["textureWidth"] = 512,
        ["offsetY"] = 4,
        ["fileDataIDs"] = { 272861,272831,272883,272838 } 
    }
},
[1642] = {
    {
        ["offsetX"]=241,
        ["textureHeight"] = 128,
        ["textureWidth"] = 256,
        ["offsetY"] = 388,
        ["fileDataIDs"] = { 272255 } 
    },
    {
        ["offsetX"]=490,
        ["textureHeight"] = 145,
        ["textureWidth"] = 256,
        ["offsetY"] = 523,
        ["fileDataIDs"] = { 272274 } 
    },
    {
        ["offsetX"]=357,
        ["textureHeight"] = 179,
        ["textureWidth"] = 256,
        ["offsetY"] = 489,
        ["fileDataIDs"] = { 272288 } 
    },
    {
        ["offsetX"]=239,
        ["textureHeight"] = 213,
        ["textureWidth"] = 256,
        ["offsetY"] = 455,
        ["fileDataIDs"] = { 272292 } 
    },
    {
        ["offsetX"]=454,
        ["textureHeight"] = 217,
        ["textureWidth"] = 256,
        ["offsetY"] = 451,
        ["fileDataIDs"] = { 272253 } 
    },
    {
        ["offsetX"]=132,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 294,
        ["fileDataIDs"] = { 272262 } 
    },
    {
        ["offsetX"]=171,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 155,
        ["fileDataIDs"] = { 272247 } 
    },
    {
        ["offsetX"]=229,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 38,
        ["fileDataIDs"] = { 272263 } 
    },
    {
        ["offsetX"]=237,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 22,
        ["fileDataIDs"] = { 272273 } 
    },
    {
        ["offsetX"]=253,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 301,
        ["fileDataIDs"] = { 272283 } 
    },
    {
        ["offsetX"]=298,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 134,
        ["fileDataIDs"] = { 272285 } 
    },
    {
        ["offsetX"]=328,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 397,
        ["fileDataIDs"] = { 272280 } 
    },
    {
        ["offsetX"]=356,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 261,
        ["fileDataIDs"] = { 272249 } 
    },
    {
        ["offsetX"]=396,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 10,
        ["fileDataIDs"] = { 272269 } 
    },
    {
        ["offsetX"]=411,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 20,
        ["fileDataIDs"] = { 272248 } 
    },
    {
        ["offsetX"]=465,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 336,
        ["fileDataIDs"] = { 272260 } 
    },
    {
        ["offsetX"]=481,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 208,
        ["fileDataIDs"] = { 272264 } 
    },
    {
        ["offsetX"]=513,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 138,
        ["fileDataIDs"] = { 272282 } 
    },
    {
        ["offsetX"]=644,
        ["textureHeight"] = 256,
        ["textureWidth"] = 256,
        ["offsetY"] = 173,
        ["fileDataIDs"] = { 272287 } 
    },
    {
        ["offsetX"]=147,
        ["textureHeight"] = 387,
        ["textureWidth"] = 256,
        ["offsetY"] = 281,
        ["fileDataIDs"] = { 272279,272265 } 
    },
    {
        ["offsetX"]=593,
        ["textureHeight"] = 384,
        ["textureWidth"] = 409,
        ["offsetY"] = 284,
        ["fileDataIDs"] = { 272267,272254,272268,272284 } 
    },
    {
        ["offsetX"]=354,
        ["textureHeight"] = 256,
        ["textureWidth"] = 512,
        ["offsetY"] = 49,
        ["fileDataIDs"] = { 272296,272294 } 
    }
},
[1646] = {
    {
        ["offsetX"]=252,
        ["textureHeight"] = 416,
        ["textureWidth"] = 512,
        ["offsetY"] = 252,
        ["fileDataIDs"] = { 272721,272732,272715,272722 } 
    },
    {
        ["offsetX"]=251,
        ["textureHeight"] = 512,
        ["textureWidth"] = 512,
        ["offsetY"] = 4,
        ["fileDataIDs"] = { 272716,272728,272723,272733 } 
    }
}
}
}
}


    local function ShouldShowOriginalTexture(mapId)
        if (mapId == 81 or mapId == 18 or mapId == 14)
		and UnitLevel("player") >= 110 then
            return true
        end
    end
    
	local function FindTilesFrame()
		local allMapFrames = {WorldMapFrame.ScrollContainer.Child:GetChildren()}
		for i = 1, #allMapFrames do
			local frame = allMapFrames[i]
			if frame.detailTilePool then
				return frame 
			end
		end
	end
	local db
	
    C_MapExplorationInfo.GetExploredMapTextures_org = C_MapExplorationInfo.GetExploredMapTextures
	
	C_MapExplorationInfo.GetExploredMapTextures = function(mapId)
        if not mapId then
            return {}
        end

        if not MOD:UserSetting(DGV_REMOVEMAPFOG) then 
            return C_MapExplorationInfo.GetExploredMapTextures_org(mapId)
        end
		
		local artID = C_Map.GetMapArtID(mapId)

		local result = {}
		
		if db and db.global.overlayData then
			if db.global.overlayData[artID] then
				local internalOverlayData = db.global.overlayData[artID]
				for i=1, #internalOverlayData do
					if not result[i] then
						result[i] = internalOverlayData[i]
									
						result[i]["hitRect"] = {
							["top"] = 0,
							["right"] = 0,
							["left"] = 0,
							["bottom"] = 0,
						}
						result[i]["isShownByMouseOver"] = false
					end
				end
			end
		end
		
		return result
	end
	
	--[[Returns:
		{
			mapDirectory = "",
			texData = {
				[mapName1] = 09812341,
				[mapName2] = 98745632
			}
		}
	]]
	
	function MapOverlays.HarvestCurrentMapOverlayInfo()
		if not harvestingDataMode then return end

		local exploredMaps = C_MapExplorationInfo.GetExploredMapTextures_org(WorldMapFrame:GetMapID())
		
		if exploredMaps then
			if not DataExport then
				DataExport = {}
			end
			
			--Currently displayed map
			local currentMapId = WorldMapFrame:GetMapID()
			
			if not DataExport[currentMapId] then
				DataExport[currentMapId] = {}
			end
		
			if exploredMaps then
				for i=1, #exploredMaps do
					local exploredMap = LuaUtils:clone(exploredMaps[i])
					exploredMap.hitRect = nil
					exploredMap.isShownByMouseOver = nil
					DataExport[currentMapId][i] = exploredMap
				end
			end
		end
	end
	
    local function IsExploredId(mapID_, textureId)
        local exploredMapTextures_org = C_MapExplorationInfo.GetExploredMapTextures_org(mapID_);

        for i, info in pairs(exploredMapTextures_org or {}) do
            for j, val in pairs(info.fileDataIDs or {}) do 
                if val == textureId then
                    return true
                end
            end
        end
    end

    MOD.IsExploredId = IsExploredId

    local function FindFogPool()
        for pin in WorldMapFrame:EnumeratePinsByTemplate("MapExplorationPinTemplate") do
            return pin.overlayTexturePool
        end
    end

    MOD.UpdateOverlaysColors = function()
        local overlayTexturePool = FindFogPool()
       
        for textureK, textureV in overlayTexturePool:EnumerateActive() do
            local textId = textureK:GetTexture()

            if  IsExploredId(WorldMapFrame:GetMapID(), textId) then
                textureK:SetVertexColor(.8, .8, .8)
            else
                textureK:SetVertexColor(0.5, 0.5, 0.5)
            end
        end
    end

	local overlayTextures  = {}
	overlayTexturesGPS  = {}    
    local bigOverlays = {}


	-- Code courtesy ckknight
	function MOD:GetCurrentCursorPosition(frame)
	local x, y = GetCursorPosition()
	local left, top = frame:GetLeft(), frame:GetTop()
	local width = frame:GetWidth()
	local height = frame:GetHeight()
	local scale = frame:GetEffectiveScale()
	local cx = (x/scale - left) / width
	local cy = (top - y/scale) / height

		if cx < 0 or cx > 1 or cy < 0 or cy > 1 then
			return nil, nil
	end
	return cx, cy
	end

	local formatCoords = "%.2f, %.2f"


	local UpdateWorldMapFrame = MOD.NoOp
	function MOD:InitializeMapOverlays()
		db = LibStub("AceDB-3.0"):New("MapOverlaysDugis", defaults)
		
		-- todo: find replacement
		--hooksecurefunc("WorldMapFrame_Update", UpdateWorldMapFrame);
		hooksecurefunc(WorldMapFrame, "OnMapChanged", UpdateWorldMapFrame);
		
	end

	function MOD:MapHasOverlays()
		local overlayMap = db.global.overlayData[WorldMapFrame:GetMapID()]
		return overlayMap and next(overlayMap)
	end

	function MapOverlays:Load()
		UpdateWorldMapFrame = function()
			if not MOD.CoordsFrame then
				MOD.CoordsFrame = CreateFrame("Frame", nil, WorldMapFrame)
				MOD.CoordsFrame.Player = MOD.CoordsFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
				MOD.CoordsFrame.Cursor = MOD.CoordsFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
				MOD.CoordsFrame:SetScript("OnUpdate", function()
					if MOD:UserSetting(DGV_DISPLAYMAPCOORDINATES)
						and not DugisGuideViewer.mapsterloaded
						and not DugisGuideViewer.tomtomloaded
					then
						local _, _, x, y  = DugisGuideViewer:GetUnitPosition("player", true, nil, true)
						if not x or not y then
							MOD.CoordsFrame.Player:SetText("|cffffd200Player:|r ---")
						else
							MOD.CoordsFrame.Player:SetFormattedText("|cffffd200Player:|r %s", formatCoords:format(x*100, y*100))
						end

						if WorldMapFrame.ScrollContainer.Child:GetLeft() then --prevents error on early load
							local cX, cY = MOD:GetCurrentCursorPosition(WorldMapFrame.ScrollContainer.Child)
							if not cX or not cY then
								MOD.CoordsFrame.Cursor:SetText("|cffffd200Cursor:|r ---")
							else
								MOD.CoordsFrame.Cursor:SetFormattedText("|cffffd200Cursor:|r %s", formatCoords:format(cX*100, cY*100))
							end
						end
                        MOD.CoordsFrame:Show()
					else
						MOD.CoordsFrame:Hide()
					end

					if DugisGuideViewer.tomtomloaded
						or MOD:UserSetting(DGV_DISPLAYMAPCOORDINATES)
					then
					
					end
				end)
				MOD.CoordsFrame:Show()
			end

			MOD.CoordsFrame.Player:ClearAllPoints()
			MOD.CoordsFrame.Cursor:ClearAllPoints()
			
			MOD.CoordsFrame.Player:SetPoint("TOPLEFT", WorldMapFrame, "BOTTOM", -120, 20)
			MOD.CoordsFrame.Cursor:SetPoint("TOPLEFT", WorldMapFrame, "BOTTOM", 20, 20)
		
		end
		MOD:InitializeMapOverlays()
        
        UpdateWorldMapFrame()
	end

	function MapOverlays:Unload()
		UpdateWorldMapFrame = MOD.NoOp
		if MOD.CoordsFrame then MOD.CoordsFrame:Hide() end
	end
end
