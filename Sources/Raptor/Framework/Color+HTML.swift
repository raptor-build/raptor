//
// Color+HTMLColor.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Represents the 148 standard named colors defined in CSS Color Module Level 4.
/// Each case maps directly to its HTML/CSS color keyword.
public extension Color {
    enum HTMLColor: String, Sendable, CaseIterable {
        /// The HTML color name "aliceblue" (#F0F8FF)
        case aliceBlue = "aliceblue"
        /// The HTML color name "antiquewhite" (#FAEBD7)
        case antiqueWhite = "antiquewhite"
        /// The HTML color name "aqua" (#00FFFF)
        case aqua = "aqua"
        /// The HTML color name "aquamarine" (#7FFFD4)
        case aquamarine = "aquamarine"
        /// The HTML color name "azure" (#F0FFFF)
        case azure = "azure"
        /// The HTML color name "beige" (#F5F5DC)
        case beige = "beige"
        /// The HTML color name "bisque" (#FFE4C4)
        case bisque = "bisque"
        /// The HTML color name "black" (#000000)
        case black = "black"
        /// The HTML color name "blanchedalmond" (#FFEBCD)
        case blanchedAlmond = "blanchedalmond"
        /// The HTML color name "blue" (#0000FF)
        case blue = "blue"
        /// The HTML color name "blueviolet" (#8A2BE2)
        case blueViolet = "blueviolet"
        /// The HTML color name "brown" (#A52A2A)
        case brown = "brown"
        /// The HTML color name "burlywood" (#DEB887)
        case burlyWood = "burlywood"
        /// The HTML color name "cadetblue" (#5F9EA0)
        case cadetBlue = "cadetblue"
        /// The HTML color name "chartreuse" (#7FFF00)
        case chartreuse = "chartreuse"
        /// The HTML color name "chocolate" (#D2691E)
        case chocolate = "chocolate"
        /// The HTML color name "coral" (#FF7F50)
        case coral = "coral"
        /// The HTML color name "cornflowerblue" (#6495ED)
        case cornflowerBlue = "cornflowerblue"
        /// The HTML color name "cornsilk" (#FFF8DC)
        case cornsilk = "cornsilk"
        /// The HTML color name "crimson" (#DC143C)
        case crimson = "crimson"
        /// The HTML color name "cyan" (#00FFFF)
        case cyan = "cyan"
        /// The HTML color name "darkblue" (#00008B)
        case darkBlue = "darkblue"
        /// The HTML color name "darkcyan" (#008B8B)
        case darkCyan = "darkcyan"
        /// The HTML color name "darkgoldenrod" (#B8860B)
        case darkGoldenrod = "darkgoldenrod"
        /// The HTML color name "darkgray" (#A9A9A9)
        case darkGray = "darkgray"
        /// The HTML color name "darkgreen" (#006400)
        case darkGreen = "darkgreen"
        /// The HTML color name "darkkhaki" (#BDB76B)
        case darkKhaki = "darkkhaki"
        /// The HTML color name "darkmagenta" (#8B008B)
        case darkMagenta = "darkmagenta"
        /// The HTML color name "darkolivegreen" (#556B2F)
        case darkOliveGreen = "darkolivegreen"
        /// The HTML color name "darkorange" (#FF8C00)
        case darkOrange = "darkorange"
        /// The HTML color name "darkorchid" (#9932CC)
        case darkOrchid = "darkorchid"
        /// The HTML color name "darkred" (#8B0000)
        case darkRed = "darkred"
        /// The HTML color name "darksalmon" (#E9967A)
        case darkSalmon = "darksalmon"
        /// The HTML color name "darkseagreen" (#8FBC8F)
        case darkSeaGreen = "darkseagreen"
        /// The HTML color name "darkslateblue" (#483D8B)
        case darkSlateBlue = "darkslateblue"
        /// The HTML color name "darkslategray" (#2F4F4F)
        case darkSlateGray = "darkslategray"
        /// The HTML color name "darkturquoise" (#00CED1)
        case darkTurquoise = "darkturquoise"
        /// The HTML color name "darkviolet" (#9400D3)
        case darkViolet = "darkviolet"
        /// The HTML color name "deeppink" (#FF1493)
        case deepPink = "deeppink"
        /// The HTML color name "deepskyblue" (#00BFFF)
        case deepSkyBlue = "deepskyblue"
        /// The HTML color name "dimgray" (#696969)
        case dimGray = "dimgray"
        /// The HTML color name "dodgerblue" (#1E90FF)
        case dodgerBlue = "dodgerblue"
        /// The HTML color name "firebrick" (#B22222)
        case firebrick = "firebrick"
        /// The HTML color name "floralwhite" (#FFFAF0)
        case floralWhite = "floralwhite"
        /// The HTML color name "forestgreen" (#228B22)
        case forestGreen = "forestgreen"
        /// The HTML color name "fuchsia" (#FF00FF)
        case fuchsia = "fuchsia"
        /// The HTML color name "gainsboro" (#DCDCDC)
        case gainsboro = "gainsboro"
        /// The HTML color name "ghostwhite" (#F8F8FF)
        case ghostWhite = "ghostwhite"
        /// The HTML color name "gold" (#FFD700)
        case gold = "gold"
        /// The HTML color name "goldenrod" (#DAA520)
        case goldenrod = "goldenrod"
        /// The HTML color name "gray" (#808080)
        case gray = "gray"
        /// The HTML color name "green" (#008000)
        case green = "green"
        /// The HTML color name "greenyellow" (#ADFF2F)
        case greenYellow = "greenyellow"
        /// The HTML color name "honeydew" (#F0FFF0)
        case honeydew = "honeydew"
        /// The HTML color name "hotpink" (#FF69B4)
        case hotPink = "hotpink"
        /// The HTML color name "indianred" (#CD5C5C)
        case indianRed = "indianred"
        /// The HTML color name "indigo" (#4B0082)
        case indigo = "indigo"
        /// The HTML color name "ivory" (#FFFFF0)
        case ivory = "ivory"
        /// The HTML color name "khaki" (#F0E68C)
        case khaki = "khaki"
        /// The HTML color name "lavender" (#E6E6FA)
        case lavender = "lavender"
        /// The HTML color name "lavenderblush" (#FFF0F5)
        case lavenderBlush = "lavenderblush"
        /// The HTML color name "lawngreen" (#7CFC00)
        case lawnGreen = "lawngreen"
        /// The HTML color name "lemonchiffon" (#FFFACD)
        case lemonChiffon = "lemonchiffon"
        /// The HTML color name "lightblue" (#ADD8E6)
        case lightBlue = "lightblue"
        /// The HTML color name "lightcoral" (#F08080)
        case lightCoral = "lightcoral"
        /// The HTML color name "lightcyan" (#E0FFFF)
        case lightCyan = "lightcyan"
        /// The HTML color name "lightgoldenrodyellow" (#FAFAD2)
        case lightGoldenrodYellow = "lightgoldenrodyellow"
        /// The HTML color name "lightgray" (#D3D3D3)
        case lightGray = "lightgray"
        /// The HTML color name "lightgreen" (#90EE90)
        case lightGreen = "lightgreen"
        /// The HTML color name "lightpink" (#FFB6C1)
        case lightPink = "lightpink"
        /// The HTML color name "lightsalmon" (#FFA07A)
        case lightSalmon = "lightsalmon"
        /// The HTML color name "lightseagreen" (#20B2AA)
        case lightSeaGreen = "lightseagreen"
        /// The HTML color name "lightskyblue" (#87CEFA)
        case lightSkyBlue = "lightskyblue"
        /// The HTML color name "lightslategray" (#778899)
        case lightSlateGray = "lightslategray"
        /// The HTML color name "lightsteelblue" (#B0C4DE)
        case lightSteelBlue = "lightsteelblue"
        /// The HTML color name "lightyellow" (#FFFFE0)
        case lightYellow = "lightyellow"
        /// The HTML color name "lime" (#00FF00)
        case lime = "lime"
        /// The HTML color name "limegreen" (#32CD32)
        case limeGreen = "limegreen"
        /// The HTML color name "linen" (#FAF0E6)
        case linen = "linen"
        /// The HTML color name "magenta" (#FF00FF)
        case magenta = "magenta"
        /// The HTML color name "maroon" (#800000)
        case maroon = "maroon"
        /// The HTML color name "mediumaquamarine" (#66CDAA)
        case mediumAquamarine = "mediumaquamarine"
        /// The HTML color name "mediumblue" (#0000CD)
        case mediumBlue = "mediumblue"
        /// The HTML color name "mediumorchid" (#BA55D3)
        case mediumOrchid = "mediumorchid"
        /// The HTML color name "mediumpurple" (#9370DB)
        case mediumPurple = "mediumpurple"
        /// The HTML color name "mediumseagreen" (#3CB371)
        case mediumSeaGreen = "mediumseagreen"
        /// The HTML color name "mediumslateblue" (#7B68EE)
        case mediumSlateBlue = "mediumslateblue"
        /// The HTML color name "mediumspringgreen" (#00FA9A)
        case mediumSpringGreen = "mediumspringgreen"
        /// The HTML color name "mediumturquoise" (#48D1CC)
        case mediumTurquoise = "mediumturquoise"
        /// The HTML color name "mediumvioletred" (#C71585)
        case mediumVioletRed = "mediumvioletred"
        /// The HTML color name "midnightblue" (#191970)
        case midnightBlue = "midnightblue"
        /// The HTML color name "mintcream" (#F5FFFA)
        case mintCream = "mintcream"
        /// The HTML color name "mistyrose" (#FFE4E1)
        case mistyRose = "mistyrose"
        /// The HTML color name "moccasin" (#FFE4B5)
        case moccasin = "moccasin"
        /// The HTML color name "navajowhite" (#FFDEAD)
        case navajoWhite = "navajowhite"
        /// The HTML color name "navy" (#000080)
        case navy = "navy"
        /// The HTML color name "oldlace" (#FDF5E6)
        case oldLace = "oldlace"
        /// The HTML color name "olive" (#808000)
        case olive = "olive"
        /// The HTML color name "olivedrab" (#6B8E23)
        case oliveDrab = "olivedrab"
        /// The HTML color name "orange" (#FFA500)
        case orange = "orange"
        /// The HTML color name "orangered" (#FF4500)
        case orangeRed = "orangered"
        /// The HTML color name "orchid" (#DA70D6)
        case orchid = "orchid"
        /// The HTML color name "palegoldenrod" (#EEE8AA)
        case paleGoldenRod = "palegoldenrod"
        /// The HTML color name "palegreen" (#98FB98)
        case paleGreen = "palegreen"
        /// The HTML color name "paleturquoise" (#AFEEEE)
        case paleTurquoise = "paleturquoise"
        /// The HTML color name "palevioletred" (#DB7093)
        case paleVioletRed = "palevioletred"
        /// The HTML color name "papayawhip" (#FFEFD5)
        case papayaWhip = "papayawhip"
        /// The HTML color name "peachpuff" (#FFDAB9)
        case peachPuff = "peachpuff"
        /// The HTML color name "peru" (#CD853F)
        case peru = "peru"
        /// The HTML color name "pink" (#FFC0CB)
        case pink = "pink"
        /// The HTML color name "plum" (#DDA0DD)
        case plum = "plum"
        /// The HTML color name "powderblue" (#B0E0E6)
        case powderBlue = "powderblue"
        /// The HTML color name "purple" (#800080)
        case purple = "purple"
        /// The HTML color name "rebeccapurple" (#663399)
        case rebeccaPurple = "rebeccapurple"
        /// The HTML color name "red" (#FF0000)
        case red = "red"
        /// The HTML color name "rosybrown" (#BC8F8F)
        case rosyBrown = "rosybrown"
        /// The HTML color name "royalblue" (#4169E1)
        case royalBlue = "royalblue"
        /// The HTML color name "saddlebrown" (#8B4513)
        case saddleBrown = "saddlebrown"
        /// The HTML color name "salmon" (#FA8072)
        case salmon = "salmon"
        /// The HTML color name "sandybrown" (#F4A460)
        case sandyBrown = "sandybrown"
        /// The HTML color name "seagreen" (#2E8B57)
        case seaGreen = "seagreen"
        /// The HTML color name "seashell" (#FFF5EE)
        case seashell = "seashell"
        /// The HTML color name "sienna" (#A0522D)
        case sienna = "sienna"
        /// The HTML color name "silver" (#C0C0C0)
        case silver = "silver"
        /// The HTML color name "skyblue" (#87CEEB)
        case skyBlue = "skyblue"
        /// The HTML color name "slateblue" (#6A5ACD)
        case slateBlue = "slateblue"
        /// The HTML color name "slategray" (#708090)
        case slateGray = "slategray"
        /// The HTML color name "snow" (#FFFAFA)
        case snow = "snow"
        /// The HTML color name "springgreen" (#00FF7F)
        case springGreen = "springgreen"
        /// The HTML color name "steelblue" (#4682B4)
        case steelBlue = "steelblue"
        /// The HTML color name "tan" (#D2B48C)
        case tan = "tan"
        /// The HTML color name "teal" (#008080)
        case teal = "teal"
        /// The HTML color name "thistle" (#D8BFD8)
        case thistle = "thistle"
        /// The HTML color name "tomato" (#FF6347)
        case tomato = "tomato"
        /// The HTML color name "turquoise" (#40E0D0)
        case turquoise = "turquoise"
        /// The HTML color name "violet" (#EE82EE)
        case violet = "violet"
        /// The HTML color name "wheat" (#F5DEB3)
        case wheat = "wheat"
        /// The HTML color name "white" (#FFFFFF)
        case white = "white"
        /// The HTML color name "whitesmoke" (#F5F5F5)
        case whiteSmoke = "whitesmoke"
        /// The HTML color name "yellow" (#FFFF00)
        case yellow = "yellow"
        /// The HTML color name "yellowgreen" (#9ACD32)
        case yellowGreen = "yellowgreen"
    }
}
