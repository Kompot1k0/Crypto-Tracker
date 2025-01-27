//
//  MarketDataModel.swift
//  SwiftfulCrypto
//
//  Created by Admin on 10.07.2024.
//

// JSON Data:
/*
 https://pro-api.coingecko.com/api/v3/global
 
 {
   "date": {
     "active_cryptocurrencies": 13690,
     "upcoming_icos": 0,
     "ongoing_icos": 49,
     "ended_icos": 3376,
     "markets": 1046,
     "total_market_cap": {
       "btc": 39003738.08471593,
       "eth": 803832137.2075309,
       "ltc": 26721173267.535767,
       "bch": 3981159931.513415,
       "bnb": 4670513150.58714,
       "eos": 2641998753398.4077,
       "xrp": 4567762968374.063,
       "xlm": 21049307801356.547,
       "link": 153517938957.19897,
       "dot": 315120726481.16595,
       "yfi": 324671967.6108449,
       "usd": 2721226850772.6313,
       "aed": 9993705609462.484,
       "ars": 2341775032921961.5,
       "aud": 4135040261091.559,
       "bdt": 298245137607204.1,
       "bhd": 1024582727718.6569,
       "bmd": 2721226850772.6313,
       "brl": 13785980136430.713,
       "cad": 3698283351542.5464,
       "chf": 2454228235855.375,
       "clp": 2557393918759367.5,
       "cny": 19681001075527.992,
       "czk": 63568675602103.72,
       "dkk": 18728571677757.562,
       "eur": 2508293570926.523,
       "gbp": 2153208842849.7563,
       "gel": 7292887960070.655,
       "hkd": 21307070180207.188,
       "huf": 979811947048335,
       "idr": 43234171898362830,
       "ils": 10201683535213.324,
       "inr": 226670207147326.38,
       "jpy": 412551596711385.75,
       "krw": 3677112086909555,
       "kwd": 836219405108.1758,
       "lkr": 812593109477405.5,
       "mmk": 5706555839881336,
       "mxn": 44773978111872.44,
       "myr": 12919024474043.053,
       "ngn": 3522998071018357,
       "nok": 29197131372679.86,
       "nzd": 4524820631515.687,
       "php": 153994230206450,
       "pkr": 755251422720380.5,
       "pln": 10747177948492.383,
       "rub": 251732363568358.97,
       "sar": 10207395390373.113,
       "sek": 29054498267296.645,
       "sgd": 3672056167154.7974,
       "thb": 99649147572586.36,
       "try": 87273829665781.25,
       "twd": 87422678053291.61,
       "uah": 105534042826571.94,
       "vef": 272476444567.86353,
       "vnd": 67937284004880150,
       "zar": 50878778428895.97,
       "xdr": 2052425485204.5413,
       "xag": 99002369095.9216,
       "xau": 1167950564.3516145,
       "bits": 39003738084715.93,
       "sats": 3900373808471593.5
     },
     "total_volume": {
       "btc": 993675.225562481,
       "eth": 20478757.151921887,
       "ltc": 680759567.6148158,
       "bch": 101425662.95452334,
       "bnb": 118987908.24412876,
       "eos": 67308643636.075134,
       "xrp": 116370202467.68745,
       "xlm": 536260797157.8833,
       "link": 3911085965.397742,
       "dot": 8028144848.205925,
       "yfi": 8271476.183867172,
       "usd": 69327091133.54892,
       "aed": 254603742187.9583,
       "ars": 59660021021604.7,
       "aud": 105345981331.98444,
       "bdt": 7598215425943.58,
       "bhd": 26102689718.14816,
       "bmd": 69327091133.54892,
       "brl": 351217283120.7607,
       "cad": 94218983205.04971,
       "chf": 62524924932.79855,
       "clp": 65153216175224.445,
       "cny": 501401253914.27954,
       "czk": 1619501647007.038,
       "dkk": 477136772017.5372,
       "eur": 63902315579.43983,
       "gbp": 54856031438.69647,
       "gel": 185796604237.91116,
       "hkd": 542827657221.1319,
       "huf": 24962090950805.31,
       "idr": 1101451492157040.8,
       "ils": 259902273109.11288,
       "inr": 5774743147085.059,
       "jpy": 10510333651301.709,
       "krw": 93679615385638.72,
       "kwd": 21303868469.883915,
       "lkr": 20701955274048.176,
       "mmk": 145382556642718.72,
       "mxn": 1140680226674.9573,
       "myr": 329130365156.52313,
       "ngn": 89753343519839.38,
       "nok": 743838091608.2996,
       "nzd": 115276185884.68079,
       "php": 3923220156574.6226,
       "pkr": 19241094948336.27,
       "pln": 273799512470.6537,
       "rub": 6413236921211.558,
       "sar": 260047790673.40265,
       "sek": 740204312126.5353,
       "sgd": 93550808700.7045,
       "thb": 2538702546310.5654,
       "try": 2223423872616.704,
       "twd": 2227215995174.6167,
       "uah": 2688628550997.977,
       "vef": 6941721635.202251,
       "vnd": 1730798106094996.5,
       "zar": 1296208622923.966,
       "xdr": 52288433291.474365,
       "xag": 2522224952.6170354,
       "xau": 29755187.514519222,
       "bits": 993675225562.481,
       "sats": 99367522556248.1
     },
     "market_cap_percentage": {
       "btc": 50.446526323358434,
       "eth": 14.922806691821144,
       "usdt": 3.9290064119981887,
       "bnb": 3.2939520356345176,
       "sol": 2.9507480132815944,
       "usdc": 1.2092204926353505,
       "xrp": 1.2052348104116084,
       "steth": 1.1830926679376446,
       "doge": 1.0577856035454278,
       "ada": 0.7659872946940993
     },
     "market_cap_change_percentage_24h_usd": 1.721795060602718,
     "updated_at": 1712512855
   }
 }
 */

import Foundation

struct GlobalData: Codable {
    let data: MarketDataModel?
}

struct MarketDataModel: Codable {
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double

    enum CodingKeys: String, CodingKey {
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
    }
    
    var marketCap: String {
        if let value = totalMarketCap.first(where: { $0.key == "usd"}) {
            return "$" + value.value.formattedWithAbbreviations()
        }
        return ""
    }
    
    var volume: String {
        if let value = totalVolume.first(where: { $0.key == "usd"}) {
            return "$" + value.value.formattedWithAbbreviations()
        }
        return ""
    }
    
    var btcDominance: String {
        if let value = marketCapPercentage.first(where: { $0.key == "btc" }) {
            return value.value.asPercentString()
        }
        return ""
    }
}
