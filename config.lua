Config = {}

Config.base = "QBCORE" --- QBCORE, ESX


Config.PhotoWebhook = "https://discord.com/api/webhooks/1097672293221670942/nWxiIpquVFOlVRT-ItXbt-Kk75trcFiqu0_JWyk6wyEcGfqKNIhx8uJGnGmNyPs8_H-A"

Config.adminperm = {
 "discord:638799074967158784" -- "Jackal"


}



Config.steamapi = "04E4E9111F35B52D09E6677959DD5C4F"

Config.notifytype = "qbnotify"    --- esxnotify, costumnotify , qbnotify

Config.scriptdrawtext = true  --- if you need use custom drawtext ui set false this

Config.impoundoutvehstopcost = 500   ------ >  While the server (script) is shutting down, the remaining tools go to the impound section.It determines which money should go to the impound section of the vehicles remaining outside.

customdrawtext = function(types, text)    ------ > This is an alternative to activate and deactivate using a custom drawtext UI.
    if types == "on" then 
    elseif types == "off" then 
    end
end


Config.estateagent = {['state'] = true, ['createpay'] = 30, ['sellpay'] = 40, ['statejobs'] = {"police"} }   ---- 

Config.getautodata = true  --- get autodata from for esx : owned_vehicles , qb : player_vehicles



Config.typecoords = {                    -->>>>>>>>>>>>>>>>>>>>>>>>>>!! It's better not to touch it.
    ['lowgarage'] = {
        ['interiorcenter'] = vector3(173.169235, -1004.545044, -99.014648),
        ['inlocation'] = vector3(173.248566,-1007.85431,-100.099945),
        ['garagesettings'] = vector3(0.0, 0.0, 0.0),
        ['changecolor'] = false,
        ['changesettings'] = false,
        ['vehicleposition'] = {
            ["1"] = {['x'] = 175.120667, ['y'] = -1004.43134, ['z'] = -99.9999542, ['h'] = 175.9505},
            ["2"] = {['x'] = 171.809357, ['y'] = -1004.49774, ['z'] = -99.9999542, ['h'] = -180}

           
        }
    },
    ['midgarage'] = {
        ['interiorcenter'] = vector3(198.619781, -1000.615356, -99.014648),
        ['inlocation'] = vector3(198.039566, -1007.208801, -99.014648),
        ['garagesettings'] = vector3(0.0, 0.0, 0.0),
        ['changecolor'] = false,
        ['changesettings'] = false,
        ['vehicleposition'] = {
            ["1"] = {['x'] = 193.503296, ['y'] = -999.731873, ['z'] = -99.435913, ['h'] = 0.0},
            ["2"] = {['x'] = 196.879120, ['y'] = -999.956055, ['z'] = -99.435913, ['h'] = 0.0},
            ["3"] = {['x'] = 200.426376, ['y'] = -999.784607, ['z'] = -99.435913, ['h'] = 0.0},
            ["4"] = {['x'] = 203.749451, ['y'] = -999.956055, ['z'] = -99.435913, ['h'] = 0.0}

           
        }
    },
    ['highgarage'] = {
        ['interiorcenter'] = vector3(1001.683533, -3164.663818, -38.211377),
        ['inlocation'] = vector3(996.962646, -3164.439453, -38.911377), 
        ['garagesettings'] = vector3(0.0, 0.0, 0.0),
        ['changecolor'] = false,
        ['changesettings'] = false,
        ['vehicleposition'] = {
            ["1"] = {['x'] = 1003.42773, ['y'] = -3172.94, ['z'] = -39.9074478, ['h'] = 1.33051229},
            ["2"] = {['x'] = 999.791565, ['y'] = -3172.535, ['z'] = -39.9074478, ['h'] = -0.5993139},
            ["3"] = {['x'] = 1013.0188, ['y'] = -3157.34424, ['z'] = -39.9074669, ['h'] = -169.941879},
            ["4"] = {['x'] = 1005.103, ['y'] = -3159.35254, ['z'] = -39.90759, ['h'] = 88.07423},
            ["5"] = {['x'] = 1005.46173, ['y'] = -3162.035, ['z'] = -39.9078026, ['h'] = 97.89358},
            ["6"] = {['x'] = 1005.70758, ['y'] = -3156.16064, ['z'] = -39.90756, ['h'] = 74.14806}
 
           
        }
    },
    ['premiumgarage'] = {
        ['interiorcenter'] = vector3(520.00000000, -2625.00000000, -39.69168000),
        ['inlocation'] = vector3(520.021973, -2639.485596, -38.692261), 
        ['garagesettings'] = vector3(517.345032, -2605.701172, -38.692261),
        ['changecolor'] = true,
        ['changesettings'] = true,
        ['vehicleposition'] = {
            ["1"] = {['x'] = 514.0, ['y'] = -2612.69, ['z'] = -38.69, ['h'] = 273.83},
            ["2"] = {['x'] = 514.0, ['y'] = -2616.69, ['z'] = -38.69, ['h'] = 273.83},
            ["3"] = {['x'] = 514.0, ['y'] = -2620.69, ['z'] = -38.69, ['h'] = 273.83},
            ["4"] = {['x'] = 514.0, ['y'] = -2624.69, ['z'] = -38.69, ['h'] = 273.83},
            ["5"] = {['x'] = 514.0, ['y'] = -2628.69, ['z'] = -38.69, ['h'] = 273.83},
            ["6"] = {['x'] = 514.0, ['y'] = -2632.69, ['z'] = -38.69, ['h'] = 273.83},
            ["7"] = {['x'] = 525.46, ['y'] = -2612.53, ['z'] = -38.69, ['h'] = 92.52},
            ["8"] = {['x'] = 525.46, ['y'] = -2616.64, ['z'] = -38.69, ['h'] = 92.52},
            ["9"] = {['x'] = 525.46, ['y'] = -2624.64, ['z'] = -38.69, ['h'] = 92.52},
            ["10"] = {['x'] = 525.46, ['y'] = -2632.69, ['z'] = -38.69, ['h'] = 92.52}

 
           
        }
    }
}

Config.garagetype = {   ------------- >>> custom garage max vehicle limit   !! It's better not to touch it.
    ["lowgarage"] = 2,
    ["midgarage"] = 4,       
    ["highgarage"] = 6,
    ['premiumgarage'] = 10


}

Config.garagestars = {  ------------- >>> custom garage level stars   !! It's better not to touch it.
    ["lowgarage"] = 1,
    ["midgarage"] = 2,
    ["highgarage"] = 3,
    ['premiumgarage'] = 5
}



Config.allgarages = {
    ["centerpark"] = {   ----- uniqid
        ['label'] = "Center Park",
        ['coords'] = vector3(231.178024, -791.301086, 30.610962),
        ['markers'] = {['markertype'] = 36, ['markerlabel'] = "Center Park [E]" , ['markersize'] = {['x'] = 0.6, ['y'] = 0.6, ['z'] = 0.6}, ['markercolor'] = {['r'] = 247, ['g'] = 245, ['b'] = 255}},
        -- ['interiorsettings'] = {['isinterior'] = false , ['interiortype'] = "lowgarage" },
        ['blips'] = {['bliptype'] = 357, ['blipcolor'] = 3, ['blipscale'] = 0.7},
        ['maxvehicle'] = 25,                               -----------------------------------------------------  !attention if you change this you need to reset the allvehicles.json file.
        ['garagetype'] = {"vehicle", "motorcycle"},
        ['currentjob'] = {"all"}
    },
    ["centerpark2"] = {  ----- uniqid
        ['label'] = "Center Park 2",
        ['coords'] = vector3(121.397804, -1071.059326, 29.178711),
        ['markers'] = {['markertype'] = 36, ['markerlabel'] = "Center Park 2 [E]" , ['markersize'] = {['x'] = 0.6, ['y'] = 0.6, ['z'] = 0.6}, ['markercolor'] = {['r'] = 247, ['g'] = 245, ['b'] = 255}},
        -- ['interiorsettings'] = {['isinterior'] = false , ['interiortype'] = "lowgarage" },
        ['blips'] = {['bliptype'] = 357, ['blipcolor'] = 3, ['blipscale'] = 0.7},
        ['garagetype'] = {"vehicle", "motorcycle"},
        ['maxvehicle'] = 5,                                ----------------------------------------------------- !attention if you change this you need to reset the allvehicles.json file.
        ['currentjob'] = {"all"}
    },
    ["grovepark"] = {  ----- uniqid
        ['label'] = "Grove Park",
        ['coords'] = vector3(-59.287907, -1837.424194, 26.651245),
        ['markers'] = {['markertype'] = 36, ['markerlabel'] = "Grove Park [E]" , ['markersize'] = {['x'] = 0.6, ['y'] = 0.6, ['z'] = 0.6}, ['markercolor'] = {['r'] = 247, ['g'] = 245, ['b'] = 255}},
        -- ['interiorsettings'] = {['isinterior'] = false , ['interiortype'] = "lowgarage" },
        ['blips'] = {['bliptype'] = 357, ['blipcolor'] = 3, ['blipscale'] = 0.7},
        ['garagetype'] = {"vehicle", "motorcycle"},
        ['maxvehicle'] = 8,                                ----------------------------------------------------- !attention if you change this you need to reset the allvehicles.json file.
        ['currentjob'] = {"all"}
    },
    ["venisepark"] = {  ----- uniqid
        ['label'] = "Venise Park",
        ['coords'] = vector3(-1076.637329, -1251.309937, 5.420532),
        ['markers'] = {['markertype'] = 36, ['markerlabel'] = "Venise Park [E]" , ['markersize'] = {['x'] = 0.6, ['y'] = 0.6, ['z'] = 0.6}, ['markercolor'] = {['r'] = 247, ['g'] = 245, ['b'] = 255}},
        -- ['interiorsettings'] = {['isinterior'] = false , ['interiortype'] = "lowgarage" },
        ['blips'] = {['bliptype'] = 357, ['blipcolor'] = 3, ['blipscale'] = 0.7},
        ['garagetype'] = {"vehicle", "motorcycle"},
        ['maxvehicle'] = 8,                                ----------------------------------------------------- !attention if you change this you need to reset the allvehicles.json file.
        ['currentjob'] = {"all"}
    }
    

}


Config.impounds = {
    {
        ['label'] = "Impound", 
        ['coords'] = vector3(1048.13,3618.42,32.2), 
        ['markers'] = {
            ['markertype'] = 36, 
            ['markerlabel'] = "Impound Garage [E]" , 
            ['markersize'] = {['x'] = 0.6, ['y'] = 0.6, ['z'] = 0.6}, 
            ['markercolor'] = {['r'] = 255, ['g'] = 0, ['b'] = 0}
        },
        ['blips'] = {
            ['bliptype'] = 357,
            ['blipcolor'] = 1, 
            ['blipscale'] = 0.7
        }
    },
    {
        ['label'] = "Impound", 
        ['coords'] = vector3(-65.868134, -1165.160400, 25.960449), 
        ['markers'] = {
            ['markertype'] = 36, 
            ['markerlabel'] = "Impound Garage [E]" , 
            ['markersize'] = {['x'] = 0.6, ['y'] = 0.6, ['z'] = 0.6}, 
            ['markercolor'] = {['r'] = 255, ['g'] = 0, ['b'] = 0}
        },
        ['blips'] = {
            ['bliptype'] = 357,
            ['blipcolor'] = 1, 
            ['blipscale'] = 0.7
        }
    }

}


Config.jobbuy = {
    ['1'] = {
        ['job'] = "police",
        ['label'] = "Police Shop",
        ['shopcoords'] = vector3(457.621979, -1019.723083, 28.068921),
        ['camcoords'] = vector3(442.879120, -1021.054932, 28.572144),
        ['camvehiclerotation'] = 50.0,
        ['ranks'] = {
            ['recruit'] = {
                {['vehname'] = "police", ['vehlabel'] = "Police I", ['vehprice'] = 100, ['grade'] = "1"},
                {['vehname'] = "police2", ['vehlabel'] = "Police II", ['vehprice'] = 100 , ['grade'] = "2"},
                {['vehname'] = "adder", ['vehlabel'] = "Adder", ['vehprice'] = 100 , ['grade'] = "2"},
                {['vehname'] = "police3", ['vehlabel'] = "Police III", ['vehprice'] = 100, ['grade'] = "3"}


            },
            ['boss'] = {
                 {['vehname'] = "fbi", ['vehlabel'] = "Police I", ['vehprice'] = 100, ['grade'] = "3"}

            }
        },
        ['markers'] = {
            ['markertype'] = 21, 
            ['markerlabel'] = "Police Shop [E]" , 
            ['markersize'] = {['x'] = 0.5, ['y'] = 0.5, ['z'] = 0.5}, 
            ['markercolor'] = {['r'] = 255, ['g'] = 250, ['b'] = 0}
        },
        ['blips'] = {
            ['bliptype'] = 137,
            ['blipcolor'] = 2, 
            ['blipscale'] = 0.4,
            ['blipshow'] = true
        }
    },
    ['2'] = {
        ['job'] = "ambulance",
        ['label'] = "Ambulance",
        ['shopcoords'] = vector3(411.621979, -1019.723083, 28.068921),
        ['camcoords'] = vector3(442.879120, -1021.054932, 28.572144),
        ['camvehiclerotation'] = 50.0,
        ['ranks'] = {
            ['recruit'] = {
                {['vehname'] = "ambulance", ['vehlabel'] = "Ambulance I", ['vehprice'] = 100, ['grade'] = "3"},
                {['vehname'] = "police2", ['vehlabel'] = "Police II", ['vehprice'] = 100 , ['grade'] = "3"},
                {['vehname'] = "police3", ['vehlabel'] = "Police III", ['vehprice'] = 100, ['grade'] = "3"}


            },
            ['boss'] = {
                 {['vehname'] = "fbi", ['vehlabel'] = "Police I", ['vehprice'] = 100, ['grade'] = "3"}

            }
        },
        ['markers'] = {
            ['markertype'] = 21, 
            ['markerlabel'] = "Police Shop [E]" , 
            ['markersize'] = {['x'] = 0.5, ['y'] = 0.5, ['z'] = 0.5}, 
            ['markercolor'] = {['r'] = 255, ['g'] = 250, ['b'] = 0}
        },
        ['blips'] = {
            ['bliptype'] = 137,
            ['blipcolor'] = 2, 
            ['blipscale'] = 0.4,
            ['blipshow'] = true
        }
    }
}


Config.jobenter = {
    ['1'] = {
        ['job'] = "police",
        ['label'] = "Police Garage",
        ['entercoords'] = vector3(450.514282, -1010.479126, 28.369995),
        ['jobvehavatar'] = "https://media.istockphoto.com/id/1435905504/tr/vekt%C3%B6r/police-officer-avatar-icon-vector-illustration.jpg?s=170667a&w=0&k=20&c=GjWRvkDSz1bTKeVec_m1VfIWtn1BSFGMR3Aw0Rhx1Bo=",
        ['markers'] = {
            ['markertype'] = 21, 
            ['markerlabel'] = "Police Garage [E]" , 
            ['markersize'] = {['x'] = 0.5, ['y'] = 0.5, ['z'] = 0.5}, 
            ['markercolor'] = {['r'] = 255, ['g'] = 250, ['b'] = 0}
        },
        ['blips'] = {
            ['bliptype'] = 137,
            ['blipcolor'] = 3, 
            ['blipscale'] = 0.4,
            ['blipshow'] = true
        }
    }
}


Config.vehiclesell = {
    ['vehsell1'] = {
        ['label'] = "Sell Vehicle",
        ['text'] = "Sell Vehicle [E]",
        ['centerpoint'] = vector3(-47.182419, -1682.241699, 29.431519),
        ['centerdistance'] = 20,
        ['sellslotlimit'] = 11,
        ['blips'] = {
            ['bliptype'] = 227,
            ['blipcolor'] = 4, 
            ['blipscale'] = 0.7,
            ['blipshow'] = true
        },
        ['sellslot'] = {
            ["1"] = {["x"] = -50.171089172363, ["y"] = -1675.8868408203, ["z"] = 29.208623886108, ["h"] = 262.00964355469},
            ["2"] = {["x"] = -53.738887786865, ["y"] = -1678.6947021484, ["z"] = 29.035066604614, ["h"] = 262.17529296875},
            ["3"] = {["x"] = -56.15104675293, ["y"] = -1681.3382568359, ["z"] = 28.775428771973, ["h"] = 261.70642089844},
            ["4"] = {["x"] = -58.20711517334, ["y"] = -1683.7432861328, ["z"] = 29.069145202637, ["h"] = 256.02319335938},
            ["5"] = {["x"] = -60.539875030518, ["y"] = -1687.0262451172, ["z"] = 28.782316207886, ["h"] = 278.62295532227},
            ["6"] = {["x"] = -57.772407531738, ["y"] = -1689.8743896484, ["z"] = 28.78221321106, ["h"] = 313.96432495117},
            ["7"] = {["x"] = -55.157493591309, ["y"] = -1692.8951416016, ["z"] = 29.055320739746, ["h"] = 356.50018310547},
            ["8"] = {["x"] = -51.692226409912, ["y"] = -1694.16015625, ["z"] = 29.068706512451, ["h"] = 358.81967163086},
            ["9"] = {["x"] = -48.437274932861, ["y"] = -1692.2283935547, ["z"] = 29.018730163574, ["h"] = 359.84155273438},
            ["10"] = {["x"] = -45.033851623535, ["y"] = -1691.1813964844, ["z"] = 29.044681549072, ["h"] = 355.75744628906},
            ["11"] = {["x"] = -41.201889038086, ["y"] = -1689.6267089844, ["z"] = 28.552017211914, ["h"] = 355.77816772461}


        }
    } 
}


notifycustom = function (text, time)
    --  print('ss')
end


Config.vehicletypes = {
    ['0'] = {['type'] = 'vehicle', ['rank'] = "D"},
    ['1'] = {['type'] = 'vehicle', ['rank'] = "D+"},
    ['2'] = {['type'] = 'vehicle', ['rank'] = "C"},
    ['3'] = {['type'] = 'vehicle', ['rank'] = "C+"},
    ['4'] = {['type'] = 'vehicle', ['rank'] = "B"},
    ['5'] = {['type'] = 'vehicle', ['rank'] = "B+"},
    ['6'] = {['type'] = 'vehicle', ['rank'] = "A"},
    ['7'] = {['type'] = 'vehicle', ['rank'] = "S+"},
    ['8'] = {['type'] = 'motorcycle', ['rank'] = "M"},
    ['9'] = {['type'] = 'vehicle', ['rank'] = "N"},
    ['10'] = {['type'] = 'vehicle', ['rank'] = "N"},
    ['11'] = {['type'] = 'vehicle', ['rank'] = "N"},
    ['12'] = {['type'] = 'vehicle', ['rank'] = "N"},
    ['13'] = {['type'] = 'other', ['rank'] = "N"},
    ['14'] = {['type'] = 'boat', ['rank'] = "N"},
    ['15'] = {['type'] = 'helicopter', ['rank'] = "N"},
    ['16'] = {['type'] = 'plane', ['rank'] = "N"},
    ['17'] = {['type'] = 'service', ['rank'] = "N"},
    ['18'] = {['type'] = 'emergency', ['rank'] = "N"}


}



Config.Trim = function(value)
    if value then
        return (string.gsub(value, "^%s*(.-)%s*$", "%1"))
    else
        return nil
    end
end