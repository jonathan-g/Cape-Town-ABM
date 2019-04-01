globals
[
  area                           ;area of the world
  unit-crop-profit               ;unit crop profit that farmers get in even scenario
  mean-yield-his                 ;mean yield of turtles for histogram plot
  mean-wealth-his                ;mean wealth of turtles for histogram plot
  transaction
  Ewater                         ;Efficiency of Water Use
  max-elevation                  ;Max elevation of Steenbras Reservoir
  month                          ;month count within a year
  year
  total-irrigation-demand-this-month
  total-irrigation-demand-monthly
  total-municipal-demand-this-month
  total-allocation-this-month
  total-allocation-monthly
  ag-allocation-this-month
  ag-allocation-monthly
  mu-allocation-this-month
  mu-allocation-monthly
  generation-this-month
  generation-history
  municipal-water-use
  ag-water-use
  dam-inflow-monthly
  individual-demand
  days-in-month
  V-monthly
  V-Display
  mu-demand
  population
  growth-rate
  reduction-monthly
  reduction-this-month
  energy-output-this-month
  avg-V
  water-price-this-month
  water-price-history
]

breed [BRmanagers BRmanager]
breed [VRmanagers VRmanager]
breed [TRmanagers TRmanager]
breed [SRmanagers SRmanager]
breed [Weathermans Weatherman]
breed [CPers CPer]
breed [SWfarmers SWfarmer]
breed [Dfarmers Dfarmer]
breed [STfarmers STfarmer]
breed [BVfarmers BVfarmer]
breed [Lfarmers Lfarmer]
breed [Wfarmers Wfarmer]
breed [Watermanagers Watermanager]

; set weather station also as special breeds

turtles-own
[
  rainfall-monthly
  temp-monthly
  SW-monthly
  identity

]

Watermanagers-own
[
  volume-this-month
  upper-limit
;  ag-allocation
  city-allocation
  SR-allocation
]


SRmanagers-own
[
  generation-capacity
  actual-generation
]

CPers-own
[
  CP-water-demand
;  population
;  growth-rate
]


;Weathermans-own
;[
;  rainfall-monthly
;  temp-monthly
;  identity
;]

patches-own
[
  behaviour    ;behaviour I am expressing
  agent-who    ;who of turtle I belong to
  patch-yield  ;as for turtle variable 'yield' - in some setup instances the agent gets their yield value from their homestead patch
  landtype ;The initial of Land, E/1 stands for Else, O/2 stand for Ocean, BR/3 stands for Berge River Reservoir, VR/4 stands for Voëlvlei
           ;Voëlvlei Reservoir, TR/5 stands for the Theewaterkloof Reservoir, SR/6 represents Steenbras Reservoir, C/7 Stands for Cape Town,
           ;SW/8 stands for Swartland, D/9 stands for Drakenstein, S/10 stands for Stellenbosch, B/11 stands for Breede Valley, L/12 stands for Langeberg,
           ;W/13 stands for Witzenberg
  elevation
  change-volume
  capacity
  volume
  inflow
  historic-elevation  ;Storing historic evelation level at 10 day basis
  historic-volume
  Temp     ;Temperature daily temperature
  Rain     ;Rainfall daily rainfall
  ET       ;Evapotranspiration
  production;
  wine-irrigation-area
  AWC      ;Available water content
  SWD      ; soil water deficit
  irrigation-demand
]


to setup

  ca
  reset-ticks
  clear-output

  build-territory
  initialize-agents
  set month 1
  set year 2009
  set mean-yield-his []
  set mean-wealth-his []
  initialize-patch
  set total-irrigation-demand-monthly []
  set total-allocation-monthly []
  set ag-allocation-monthly []
  set mu-allocation-monthly []
  set generation-history []
  set V-monthly []
  set population 3.875
  set growth-rate 0.008
  set reduction-monthly []
  set water-price-history [ ]
  create-CPers 1 [
  ]
  create-Watermanagers 1 [
    set upper-limit 900000
    set volume-this-month 833388
  ]
  create-SRmanagers 1 [set generation-capacity 180]
  set dam-inflow-monthly [-3946  -4534 -15426  18535  30979 207643 118213  45156  30054  31341  16926  13210 -11892 -13524   8313
    39344  54305 109470  62115  51845  39288  30146  29651   1922 -11503  -3371  -9852  15244  29656 136839
    111435  76244  72084  24522   6834   5097  -9201 -13016 -11072  28943  28306  67024 173508 185630  94650
    31398  16158 -11437 -10866  -4691   -764  28554  32333 150717 144549 104123  31837  17705  43953  -6785
    25068  -4331  -8691  19009  45421 189041 101325  32223  13062   6382  -1243  -3809  -4902  12724 -16563
    -13051 -11433  56369 116734 115931  37017  38021 -16844 -12148   3047 -16435   8999  19227  20857  68766
    144368 105964  51648  41917 -10343 -12876   -562  -2569   -452   -589  -4942  51382  53879  77581  56702
    30685   1435   9823   7163  25645   3130  10079  64453 197680  91926 113151 105600   8604 -11230   1373]

  set municipal-water-use [31837 32620 34875 30150 26722 25140 25947 26722 26040 27652 31050 33945 35588 31640 34348 28830 27714
    24180 23901 24583 24570 28427 28650 34131 35650 32144 35309 30450 26164 25470 24304 24800 24210 27652
    29010 32302 33883 34104 34689 29730 27063 23790 23467 23653 23730 26629 28230 32612 35061 31444 32829
    28140 26567 24270 24490 23467 22350 25606 27600 30163 32891 32564 32984 28920 27218 22230 22630 23405
    24270 28427 30060 36208 37634 34636 37665 33690 30628 27330 27590 27869 27720 32209 32490 34100 34286
    30537 30535 26460 25761 23310 23467 25947 25680 28365 28170 28737 28489 24500 25358 23310 23219 20400
    20894 20553 19710 19933 19350 20460 19778 15988 17701 16650 17453 16680 16337 16740 15600 18104 17940
    18662]

  set ag-water-use [27590 26096 23901 12750  1488   690   713   713   690  3689  7290 20243 26722 25284 23126 12360  1426
    690   682   682   690  3565 10230 28334 37386 35364 32364 17280  2015   990   992   992   990  4991
    8280 22940 30256 29667 26226 13980  1612   780   775   775   780  4030  8970 24862 32829 31052 28427
    15180  1767   870   868   868   870  4371  8340 23157 30566 28896 26443 14130  1643   810   806   806
    810  4092 10290 28489 37603 35560 32550 17370  2015   990   992   992   990  5022 10770 29884 39432
    38628 34131 18240  2108  1050  1023  1023  1050  5270  9570 26505 34999 33096 30287 16170  1891   930
    930   930   930  4681  9600 26505 34100 30800     0     0     0     0     0     0     0     0 10830
    24211]

  set individual-demand [275 288 276 245 217 202 195 197 202 221 243 268 275 288 276 245 217 202 195 197 202 221 243 268 275 288 276 245 217 202 195 197 202 221 243
    268 275 288 276 245 217 202 195 197 202 221 243 268 275 288 276 245 217 202 195 197 202 221 243 268 275 288 276 245 217 202 195 197 202 221
    243 268 275 288 276 245 217 202 195 197 202 221 243 268 275 288 276 245 217 202 195 197 202 221 243 268 275 288 276 245 217 202 195 197 202
    221 243 268 275 288 276 245 217 202 195 197 202 221 243 268]

  set days-in-month [31 28 31 30 31 30 31 31 30 31 30 31 31 28 31 30 31 30 31 31 30 31 30 31 31 28 31 30 31 30 31 31 30 31 30 31 31 29 31 30 31 30 31 31 30 31 30 31 31 28 31 30 31 30 31 31 30 31 30 31 31 28 31 30 31 30 31 31 30 31 30 31 31 28 31 30 31 30 31 31 30 31 30 31 31 29 31 30 31 30 31 31 30 31 30 31 31 28 31 30 31 30 31 31 30 31 30 31 31 28 31 30 31 30 31 31 30 31 30 31]
  set avg-V [730842.3 661785.3 594616.5 575904.7 584171.5 702642.2 796237.2 853529.7 875358.8 867419.3 848132.5 789934.5]
;  load-rain-temp-history
end

to go
  ;;;;;;;;;;;;;;

  update-reservoir-elevation
  irrigate-land
;  calculate-municipal-demand
;  ask patches with [landtype = 3]
;  [show elevation]
  ifelse Scenario-1? ;if the switch is on, it goes to scenario 1. else it goes to scenario 2
  [scenario-one]
  [scenario-two]

  set month month + 1
  ifelse month > 12
  [set month 1
    set year year + 1
    let current-pop (population * (1 + growth-rate))
    set population current-pop
  ]
  []

  tick ;total month
  if ticks = 120   [stop]

end


to scenario-one
  let V [volume-this-month] of one-of Watermanagers

  if V > 921000
  [set V 921000]
  set V-Display V
  set V-monthly lput V V-monthly
  print V
  let ag-D last total-irrigation-demand-monthly + (share-other-crops-irrigation * (item ticks ag-water-use)) ;updated wine grapes irrigation demand + the rest of the water
  ;calculate municipal demand we use average monthly city demand predrought
  let ID item ticks individual-demand
  print ID
  print "individual-demand"
  let DAY item ticks days-in-month
  print DAY
  print "days in a month"
  let POP population
  print POP
  print "population in millions"
  set mu-demand (ID * DAY * POP)
  let mu-D mu-demand
  print mu-D
;  let mu-D (item ticks individual-demand) * (item ticks days-in-month) * [population] of one-of CPers
;  print mu-D
  ifelse ( V > (0.5 * [upper-limit] of one-of Watermanagers) ); no restriction
  [
    print "above 0.5, no restriction"
    set ag-allocation-this-month ag-D
    set mu-allocation-this-month mu-D
    set reduction-this-month 0
    set total-allocation-this-month ag-allocation-this-month + mu-allocation-this-month
    ask one-of SRmanagers
    [
      set actual-generation 180
      set energy-output-this-month actual-generation
    ]
  ];no restriction
  [
    ifelse ( V > (0.45 * [upper-limit] of one-of Watermanagers)  )
    [
      print "restriction 2, 0.5-0.45"
      let reduction 0.2
      set reduction-this-month reduction
      set ag-allocation-this-month ( 1 - reduction ) * ag-D
      set mu-allocation-this-month (1 - reduction) * mu-D
      set total-allocation-this-month ag-allocation-this-month + mu-allocation-this-month
      ask one-of SRmanagers
      [
        set actual-generation 180
        set energy-output-this-month actual-generation
      ]
    ]; between 45% to 50% level 2 restriction
    [;less than 45%
      ifelse ( V > (0.20 * [upper-limit] of one-of Watermanagers) )
      [
        print "restriction 3, in between 0.45-0.5"
        let reduction 0.3
        set reduction-this-month reduction
        set ag-allocation-this-month ( 1 - reduction ) * ag-D
        set mu-allocation-this-month (1 - reduction) * mu-D
        set total-allocation-this-month ag-allocation-this-month + mu-allocation-this-month
        ask one-of SRmanagers
        [
          set actual-generation 180
          set energy-output-this-month actual-generation
        ]
      ]; between 45% and 20% level 3 restriction
      [;less than 20%
        print "restriction 6, all municipal allocation"
        set mu-allocation-this-month 450 * item ticks days-in-month
        set ag-allocation-this-month 0
        set reduction-this-month 1
        ifelse ( V > 0.15 * [upper-limit] of one-of Watermanagers) ; for the hydropower dam, if between 20% and 15% of V, it will decrease the generation capacity
        [
          ask one-of SRmanagers
          [
            let ratio (V / [upper-limit] of one-of Watermanagers )
            set actual-generation (20 * ratio - 3) * generation-capacity
            set energy-output-this-month actual-generation
            ;need to save generation history
          ]
        ]
        [
          ask one-of SRmanagers
          [set actual-generation 0]
        ];below 15% failure
      ];level 6 restriction
    ]
  ]
  set total-allocation-monthly lput total-allocation-this-month total-allocation-monthly
  set ag-allocation-monthly lput ag-allocation-this-month ag-allocation-monthly
  set mu-allocation-monthly lput mu-allocation-this-month mu-allocation-monthly
  set generation-history lput ([actual-generation] of one-of SRmanagers) generation-history
  set reduction-monthly lput reduction-this-month reduction-monthly
  update-reservoir-elevation
;  last total-irrigation-demand-monthly


end

to scenario-two
  let V [volume-this-month] of one-of Watermanagers
  if V > 921000
  [set V 921000]
  set V-Display V
  set V-monthly lput V V-monthly
  print V
  let ag-D last total-irrigation-demand-monthly + (share-other-crops-irrigation * (item ticks ag-water-use)) ;updated wine grapes irrigation demand + the rest of the water
  ;calculate municipal demand we use average monthly city demand predrought
  let ID item ticks individual-demand
  print ID
  print "individual-demand"
  let DAY item ticks days-in-month
  print DAY
  print "days in a month"
  let POP population
    print POP
  print "population in millions"
  set mu-demand (ID * DAY * POP)
  let mu-D mu-demand
  print mu-D
  ifelse ticks < 12
  [
    print "Beginning year, no restriction"
    set ag-allocation-this-month ag-D
    set mu-allocation-this-month mu-D
    set total-allocation-this-month ag-allocation-this-month + mu-allocation-this-month
    set water-price-this-month water-price
      ask one-of SRmanagers
      [set actual-generation 180
    set energy-output-this-month actual-generation]
  ]; the beginning year, no data to compare
  [
    let InF-this-year item ticks dam-inflow-monthly
    let InF-last-year item (ticks - 12) dam-inflow-monthly
    let V-normal item (month - 1) avg-V
    set reduction-this-month 0
    set reduction-monthly lput reduction-this-month reduction-monthly
;    let RF-this-year  [item ticks rainfall-monthly] of Weatherman (item 0 [who] of Weathermans with [identity = "Worcester"]) + [item ticks rainfall-monthly] of Weatherman (item 0 [who] of Weathermans with [identity = "Porterville"]) + [item ticks rainfall-monthly] of Weatherman (item 0 [who] of Weathermans with [identity = "Paarl"]) + [item ticks rainfall-monthly] of Weatherman (item 0 [who] of Weathermans with [identity = "Strand"])
;    let RF-last-year  [item ticks rainfall-monthly] of Weatherman (item 0 [who] of Weathermans with [identity = "Worcester"]) + [item ticks rainfall-monthly] of Weatherman (item 0 [who] of Weathermans with [identity = "Porterville"]) + [item ticks rainfall-monthly] of Weatherman (item 0 [who] of Weathermans with [identity = "Paarl"]) + [item ticks rainfall-monthly] of Weatherman (item 0 [who] of Weathermans with [identity = "Strand"])
;
;    let RF-last-year [item (ticks - 12) rainfall-monthly] of Weatherman (item 0 [who] of Weathermans with [identity = "Worcester"])
;    ifelse InF-this-year > InF-last-year
;    ifelse RF-this-year > RF-last-year
    ifelse V > 0.9 * V-normal
    [
      print "enough water, no restriction"
      set ag-allocation-this-month ag-D
      set mu-allocation-this-month mu-D
      set total-allocation-this-month ag-allocation-this-month + mu-allocation-this-month
      set water-price-this-month water-price
      set reduction-this-month 0
      set reduction-monthly lput reduction-this-month reduction-monthly
      ask one-of SRmanagers
      [set actual-generation 180
      set energy-output-this-month actual-generation]
    ];no restriction
    [
      print "adaptive restriction"

      let reduction (1 - (abs (V / V-normal)))
      set reduction-this-month reduction
      ;      let reduction (1 - (abs (RF-this-year / (RF-last-year) ) ) )
      let new-price water-price - water-price * reduction / water-price-elasticity
      set water-price-this-month new-price
;      set water-price-history lput new-price water-price-history

      set reduction-monthly lput reduction reduction-monthly
      print reduction
      set ag-allocation-this-month ( 1 - reduction ) * ag-D
      set mu-allocation-this-month (1 - reduction) * mu-D
      set total-allocation-this-month ag-allocation-this-month + mu-allocation-this-month

      ifelse V > 0.2 * [upper-limit] of one-of Watermanagers
      [
        ask one-of SRmanagers
        [set actual-generation 180
        set energy-output-this-month actual-generation]
      ];no impact on hydro

      [
        ifelse ( V > 0.15 * [upper-limit] of one-of Watermanagers) ; for the hydropower dam, if between 20% and 15% of V, it will decrease the generation capacity
        [
          ask one-of SRmanagers
          [
            let ratio (V / [upper-limit] of one-of Watermanagers )
            set actual-generation (20 * ratio - 3) * generation-capacity
            set energy-output-this-month actual-generation
            ;need to save generation history
          ]
        ];partial generation

        [
          ask one-of SRmanagers
          [set actual-generation 0
          set energy-output-this-month actual-generation]
        ];below 15% failure

      ]; impact on hydro

    ]
  ]
  set total-allocation-monthly lput total-allocation-this-month total-allocation-monthly
  set ag-allocation-monthly lput ag-allocation-this-month ag-allocation-monthly
  set mu-allocation-monthly lput mu-allocation-this-month mu-allocation-monthly
  set generation-history lput ([actual-generation] of one-of SRmanagers) generation-history
  set water-price-history lput water-price-this-month water-price-history

  update-reservoir-elevation


end


to update-reservoir-elevation
  let inflow-this-month item ticks dam-inflow-monthly
  ask one-of Watermanagers [set volume-this-month (volume-this-month + inflow-this-month - total-allocation-this-month)]
;  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  ;regression apporach to calculate inflow. Not for now
;  let R 0
;  let T 0
;  let MW 0
;  Let AW 0
;  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  ask Weatherman (item 0 [who] of Weathermans with [identity = "Worcester"])
;  [
;    set R item ticks rainfall-monthly
;    set T item ticks temp-monthly
;    ask patches with [landtype = 5] ;for theewaterkloof
;    [
;      ifelse ticks < 36
;      [
;        set change-volume 0
;      ]
;      [set change-volume (17710 + 10900 * R - 2633 * T - 0.496 * MW - (2.31 * AW - 0.1668 * AW * R - 0.0337 * AW * T))
;        set inflow change-volume + 0.496 * MW + (2.31 * AW - 0.1668 * AW * R - 0.0337 * AW * T)
;        set volume volume + inflow
;;      set historic-volume lput volume historic-volume
;      ]
;    ]
;  ]
;  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  ask Weatherman (item 0 [who] of Weathermans with [identity = "Porterville"])
;  [
;    set R item ticks rainfall-monthly
;    set T item ticks temp-monthly
;    set MW item ticks municipal-water-use
;    set AW item ticks ag-water-use
;    ask patches with [landtype = 4] ;for Voalvlei
;    [
;      ifelse ticks < 36
;      [set change-volume 0]
;      [set change-volume (41760 + 6167 * R - 831 * T - 0.496 * MW - (2.31 * AW - 0.1668 * AW * R - 0.0337 * AW * T))
;        set inflow change-volume + 0.496 * MW + (2.31 * AW - 0.1668 * AW * R - 0.0337 * AW * T)
;        set volume volume + inflow
;;      set historic-volume lput volume historic-volume
;      ]
;      print change-volume
;    ]
;  ]
;    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  ask Weatherman (item 0 [who] of Weathermans with [identity = "Strand"])
;  [
;    set R item ticks rainfall-monthly
;    set T item ticks temp-monthly
;    ask patches with [landtype = 6] ;for Steenbras
;    [
;      ifelse ticks < 36
;      [set change-volume 0]
;      [set change-volume (17293.39  + 1600.49 * R - 321.06 * T )
;;        set historic-volume lput volume historic-volume
;      ]
;    ]
;  ]
;      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  ask Weatherman (item 0 [who] of Weathermans with [identity = "Paarl"])
;  [
;    set R item ticks rainfall-monthly
;    set T item ticks temp-monthly
;    ask patches with [landtype = 3] ;for Berge River
;    [
;      ifelse ticks < 36
;      [set change-volume 0]
;      [set change-volume (43480.6  + 1481.8 * R - -707.2 * T )
;;        set historic-volume lput volume historic-volume
;      ]
;    ]
;  ]

;  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


end

to recharge-reservoir
  ; each water manager first get the volume of the reservoir, the demand, and allocate the water accordingly.

end


to irrigate-land
;read rainfall and temperature data from a file, each station will have a reading of that day or period say mean is Temp-3
;  let i 7 ; start with cape town
;  let Temp-list [1 2 3 4 5 6] ; just for now
;  let Rain-list [1 2 3 4 5 6] ; just for now
;  let I-index         [1 2 3 4 5 6] ; Just for now (I need to be pre-calculated) for Thronthwaite method
;  let m         [1 2 3 4 5 6] ; just for now (m need to be pre-calculated) for Thronthwaite method
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  let Rain-list []
;  let Temp-list []
  let SW-this-month []
  set total-irrigation-demand-this-month 0
;  while [i != 14] ;so it loops through all areas
;  [
;    ask Weatherman (item 0 [who] of turtles with [identity = "Ct-AWS"])
;    [
;    let Rain-list []
;    let Temp-list []
;      set Rain-list rainfall-monthly
;
;    ]
;    ask patches with [landtype = i]
;    [
;;      set Temp item ( i - 7) Temp-list
;      set Rain item ( i - 7) Rain-list
;      print Rain
;      print "month"
;      print "tick"
;;      set ET 16 * (10 * Temp / (item ( i - 7) I-index)) ^ (item ( i - 7) m )
;;      let Water-Demand Ewater * (ET - Rain) * 100 ; say we have the grid of 100 km^2
;    ]
;    set i i + 1
;  ]

  ;The initial of Land, E/1 stands for Else, O/2 stand for Ocean, BR/3 stands for Berge River Reservoir, VR/4 stands for Voëlvlei
  ;Voëlvlei Reservoir, TR/5 stands for the Theewaterkloof Reservoir, SR/6 represents Steenbras Reservoir, C/7 Stands for Cape Town,
  ;SW/8 stands for Swartland, D/9 stands for Drakenstein, S/10 stands for Stellenbosch, B/11 stands for Breede Valley, L/12 stands for Langeberg,
  ;W/13 stands for Witzenberg
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ask Weatherman (item 0 [who] of Weathermans with [identity = "Worcester"])
  [
        set SW-this-month item ticks SW-monthly

  ]
  ask patches with [landtype = 11] ;for breede valley
  [

    set SWD AWC - SW-this-month
    if SWD < 0 [set SWD 0]
    ifelse member? month [6 7 8 9]
    [
;      print "not irrigate"
    set irrigation-demand 0
    ]
    [
;      print "irrigate"
      set irrigation-demand SWD * 0.0254 * wine-irrigation-area * 1000 / 1000000 ; ML
    ]
  ]
  set total-irrigation-demand-this-month [irrigation-demand] of one-of patches with [landtype = 11]
  ask patches with [landtype = 12] ; for langeberg
  [
    set SWD AWC - SW-this-month
    if SWD < 0 [set SWD 0]
    ifelse member? month [6 7 8 9]
    [
;      print "not irrigate"
      set irrigation-demand 0
    ]
    [
;      print "irrigate"
      set irrigation-demand SWD * 0.0254 * wine-irrigation-area * 1000 / 1000000 ; ML
    ]
  ]
  set total-irrigation-demand-this-month total-irrigation-demand-this-month + [irrigation-demand] of one-of patches with [landtype = 12]
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ask Weatherman (item 0 [who] of Weathermans with [identity = "Porterville"])
  [
      set SW-this-month item ticks SW-monthly

  ]
  ask patches with [landtype = 13] ; for Witzenberg
  [

    set SWD AWC - SW-this-month
    if SWD < 0 [set SWD 0]
    ifelse member? month [6 7 8 9]
    [
;      print "not irrigate"
      set irrigation-demand 0
    ]
    [
;      print "irrigate"
      set irrigation-demand SWD * 0.0254 * wine-irrigation-area * 1000 / 1000000 ; ML
    ]
  ]
  set total-irrigation-demand-this-month total-irrigation-demand-this-month + [irrigation-demand] of one-of patches with [landtype = 13]
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ask Weatherman (item 0 [who] of Weathermans with [identity = "Malmesbury"])
  [
      set SW-this-month item ticks SW-monthly

  ]
  ask patches with [landtype = 8] ; for Swartland
  [

    set SWD AWC - SW-this-month
    if SWD < 0 [set SWD 0]
    ifelse member? month [6 7 8 9]
    [
;      print "not irrigate"
      set irrigation-demand 0
    ]
    [
;      print "irrigate"
      set irrigation-demand SWD * 0.0254 * wine-irrigation-area * 1000 / 1000000 ; ML
    ]
  ]
  set total-irrigation-demand-this-month total-irrigation-demand-this-month + [irrigation-demand] of one-of patches with [landtype = 8]
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ask Weatherman (item 0 [who] of Weathermans with [identity = "Paarl"])
  [
      set SW-this-month item ticks SW-monthly

  ]
  ask patches with [landtype = 9] ; for Drakenstein
  [

    set SWD AWC - SW-this-month
    if SWD < 0 [set SWD 0]
    ifelse member? month [6 7 8 9]
    [
;      print "not irrigate"
      set irrigation-demand 0
    ]
    [
;      print "irrigate"
      set irrigation-demand SWD * 0.0254 * wine-irrigation-area * 1000 / 1000000 ; ML
    ]
  ]
  set total-irrigation-demand-this-month total-irrigation-demand-this-month + [irrigation-demand] of one-of patches with [landtype = 9]
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ask Weatherman (item 0 [who] of Weathermans with [identity = "Ct_AWS"])
  [
      set SW-this-month item ticks SW-monthly

  ]
  ask patches with [landtype = 7] ; for Cape-Town
  [
    set SWD AWC - SW-this-month
    if SWD < 0 [set SWD 0]
    ifelse member? month [6 7 8 9]
    [
;      print "not irrigate"
      set irrigation-demand 0
    ]
    [
;      print "irrigate"
      set irrigation-demand SWD * 0.0254 * wine-irrigation-area  * 1000 / 1000000 ; ML
    ]
  ]
  set total-irrigation-demand-this-month total-irrigation-demand-this-month + [irrigation-demand] of one-of patches with [landtype = 7]
    ask patches with [landtype = 10] ; for Stellenbosch
  [
    set SWD AWC - SW-this-month
    if SWD < 0 [set SWD 0]
    ifelse member? month [6 7 8 9]
    [
;      print "not irrigate"
      set irrigation-demand 0
    ]
    [
;      print "irrigate"
      set irrigation-demand SWD * 0.0254 * wine-irrigation-area * 1000 / 1000000 ; ML
;      print irrigation-demand
    ]
  ]
  set total-irrigation-demand-this-month total-irrigation-demand-this-month + [irrigation-demand] of one-of patches with [landtype = 10]
  set total-irrigation-demand-this-month total-irrigation-demand-this-month * Irrigation-Efficiency
  set total-irrigation-demand-monthly lput total-irrigation-demand-this-month total-irrigation-demand-monthly

end




to generate-power
  let power [elevation] of patches with [landtype = 6] / max-elevation * 180 ;unit in mega watts
end



to calculate-municipal-demand
  ;get water stress level
  ;determine ideal demand under different water stress level
  ;set price based on price elasticity (ideal demand)
  ;each agent calculate its water usage at each month
  set total-municipal-demand-this-month [CP-water-demand] of one-of CPers * [population] of one-of CPers

end



to allocate-water
  ;it need to be two scenarios, and based on priorities of each agent
end



to calculate-priority
  ;agriculture, compare production with previous production, and use percentage as rating
  ;energy, percentage of the max capacity
  ;water price compare to original price percentage (historical price with no stress adjust for inflation)
end

to load-rain-temp-history
  let station-name []
  set station-name ["Cape_Point" "Cape_Town" "Ct_AWS" "Excelsior_Ceres" "Malmesbury" "Molteno_Reservoir" "Paarl"
                    "Porterville" "Robbeneiland" "Slangkop" "Strand" "Worcester"]
  file-open "rainfall_history.txt"
;  file-open "palmer.txt"
  let j 0
  while [not file-at-end?]
  [
    let i 1
    let rain-history []
    let next-X file-read
    let next-Y file-read
 ; one approach to read file by lines
;    print item 1 file-read-characters
;    set rain-history lput file-read-line rain-history

;the other approach to read file one by one
    while [ i < 121 ]
    [
      let rain-i file-read
      set rain-history lput rain-i rain-history

      set i (i + 1)
;    print i
    ]
;    print rain-history
    create-Weathermans 1
    [
      set color black
      set shape "flag"
      set size 1
      set identity item j station-name
;      print identity
      setxy next-X next-Y
      set rainfall-monthly rain-history

    ]
    set j (j + 1)
  ]
  file-close

  file-open "temperature_history.txt"
  while [not file-at-end?]
  [
    let i 1
    let temp-history []
    let next-X file-read
    let next-Y file-read
 ; one approach to read file by lines
;    print item 1 file-read-characters
;    set rain-history lput file-read-line rain-history

;the other approach to read file one by one
    while [ i < 121]
    [
      let temp-i file-read
      set temp-history lput temp-i temp-history

      set i (i + 1)
;    print i
    ]
;    print rain-history
    ask Weathermans-on patch next-X next-Y
    [
      set temp-monthly temp-history
    ]
  ]

  file-close

  file-open "SW_history.txt"
  while [not file-at-end?]
  [
    let i 1
    let SW-history []
    let next-X file-read
    let next-Y file-read
 ; one approach to read file by lines
;    print item 1 file-read-characters
;    set rain-history lput file-read-line rain-history

;the other approach to read file one by one
    while [ i < 121]
    [
      let SW-i file-read
      set SW-history lput SW-i SW-history

      set i (i + 1)
;    print i
    ]
;    print rain-history
    ask Weathermans-on patch next-X next-Y
    [
      set SW-monthly SW-history
    ]
  ]

  file-close

end




to build-territory
  file-open "spatial_data.txt"
  while [not file-at-end?]
  [
    let next-X file-read
    let next-Y file-read
    let next-type file-read
    ask patch next-X next-Y [set landtype next-type]
  ]
  file-close

;BR/3 stands for Berge River Reservoir, VR/4 stands for Voëlvlei
;Voëlvlei Reservoir, TR/5 stands for the Theewaterkloof Reservoir, SR/6 represents Steenbras Reservoir
ask patches
      [
        ifelse  landtype = 1 ; out of scope Else
        [set pcolor 69 ;light green
        ]
        [;do nothing
        ]

        ifelse  landtype = 2 ; ocean
        [set pcolor 96 ; ocean blue
        ]
        [;do nothing
        ]

        ifelse  landtype = 3; reservoir Berge River
        [set pcolor 85; light blue
            set capacity 130010
            set volume 115930
        ]
        [;do nothing
        ]

        ifelse  landtype = 4; reservoir Voelvlei
        [set pcolor 85; light blue
            set capacity 164095
            set volume 124100
        ]
        [;do nothing
        ]

        ifelse  landtype = 5; reservoir theewaterkloof
        [set pcolor 85; light blue
            set capacity 480188
            set volume 357963
        ]
        [;do nothing
        ]

        ifelse  landtype = 6; reservoir Steenbras Reservoir
        [set pcolor 85; light blue
            set capacity 65284
            set volume 53169
        ]
        [;do nothing
        ]

        ifelse  landtype = 7; Cape Town
        [set pcolor 65; light green
            set wine-irrigation-area 5765 * 10000 ; m^2
            set AWC 2.36 ; inch
        ]
        [;do nothing
        ]

        ifelse  landtype = 8; Swartland
        [set pcolor 27; yellow
            set wine-irrigation-area 13560
            set AWC 2.76
        ]
        [;do nothing
        ]

        ifelse  landtype = 9; Drakenstein
        [set pcolor orange
            set wine-irrigation-area 15461
            set AWC 2.76
        ]
        [;do nothing
        ]

        ifelse  landtype = 10; Stellenbosch
        [set pcolor 26
            set wine-irrigation-area 16286
            set AWC 2.76
        ]
        [;do nothing
        ]

        ifelse  landtype = 11; Breede Valley
        [set pcolor 16
            set wine-irrigation-area 17199
            set AWC 2.76
        ]
        [;do nothing
        ]

        ifelse  landtype = 12; Langeberg
        [set pcolor 15
            set wine-irrigation-area 16662
            set AWC 2.76
        ]
        [;do nothing
        ]

        ifelse  landtype = 13; Witzenberg
        [set pcolor 14
            set wine-irrigation-area 5510
            set AWC 2.76
        ]
        [;do nothing
        ]

  ]
end

to initialize-patch
  ask patches
  [
    set elevation random-normal 80 10
    set historic-elevation []
  ]
end

to initialize-agents

  create-BRmanagers 1
  [
    set color yellow
    set size 1
    move-to one-of patches with [landtype = 3]
  ]

  create-VRmanagers 1
  [
    set color yellow
    set size 1
    move-to one-of patches with [landtype = 4]
  ]

    create-TRmanagers 1
  [
    set color yellow
    set size 1
    move-to one-of patches with [landtype = 5]
  ]

    create-SRmanagers 1
  [
    set color yellow
    set size 1
    move-to one-of patches with [landtype = 6]
  ]

  create-CPers 1
  [
    set color black
    move-to one-of patches with [landtype = 7]
  ]

  create-SWfarmers 1
  [
    set color black
    move-to one-of patches with [landtype = 8]
  ]

  create-Dfarmers 1
  [
    set color black
    move-to one-of patches with [landtype = 9]
  ]

  create-STfarmers 1
  [
    set color black
    move-to one-of patches with [landtype = 10]
  ]

  create-BVfarmers 1
  [
    set color black
    move-to one-of patches with [landtype = 11]
  ]

  create-Lfarmers 1
  [
    set color black
    move-to one-of patches with [landtype = 12]
  ]

  create-Wfarmers 1
  [
    set color black
    move-to one-of patches with [landtype = 13]
  ]


end

@#$#@#$#@
GRAPHICS-WINDOW
210
10
624
425
-1
-1
14.0
1
10
1
1
1
0
0
0
1
0
28
-28
0
0
0
1
ticks
30.0

BUTTON
12
10
78
43
NIL
setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
12
46
78
79
NIL
go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
12
82
78
116
NIL
stop
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

PLOT
66
536
266
686
DAM level
Month
Level
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 0 -16777216 true "" "plot V-Display"

PLOT
660
10
860
160
Power Generation
Month
KWh
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 0 -16777216 true "" "plot [actual-generation] of one-of SRmanagers"

PLOT
660
160
860
310
Ag water demand
Month
Production
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 0 -16777216 true "" "plot ag-allocation-this-month"

PLOT
861
160
1061
310
Municipal Water Demand
Usage
Demand
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 0 -16777216 true "" "plot mu-allocation-this-month"

PLOT
861
10
1061
160
Population
Month
Population
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 0 -16777216 true "" "plot population"

BUTTON
11
119
189
152
NIL
load-rain-temp-history
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

MONITOR
876
544
1019
589
Irrigation Demand (ML)
item (ticks - 1 ) total-irrigation-demand-monthly
17
1
11

INPUTBOX
3
200
152
260
water-price-elasticity
-0.3
1
0
Number

SWITCH
3
447
134
480
Scenario-1?
Scenario-1?
0
1
-1000

MONITOR
876
591
1019
636
Total Allocation (ML)
item (ticks - 1) total-allocation-monthly
17
1
11

MONITOR
876
638
1019
683
Ag Allocation (ML)
item (ticks - 1) ag-allocation-monthly
17
1
11

MONITOR
876
685
1019
730
Municipal Allocation (ML)
item (ticks - 1) mu-allocation-monthly
17
1
11

MONITOR
876
732
1019
777
Total Volume (ML)
item (ticks - 1 ) V-monthly
17
1
11

MONITOR
876
779
1019
824
NIL
mu-demand
17
1
11

INPUTBOX
3
261
152
321
share-other-crops-irrigation
0.57
1
0
Number

INPUTBOX
3
323
152
383
water-price
5.2
1
0
Number

MONITOR
876
826
1020
871
NIL
last water-price-history
17
1
11

INPUTBOX
3
385
152
445
Irrigation-Efficiency
1.5
1
0
Number

@#$#@#$#@
# Purpose
We want to test if the collaboration among agriculture, energy sector, and municipal sector will ease the water shortage and improve FEW system output in general. Specifically, we want to simulate the system outputs under two policy scenarios:

1.	Business as usual: no communication or minimal communication between Department of Energy, Water, and Food (agriculture).

2.	Collaborative work, allocate water resources across FEW sectors to maximize people’s demand, similarly for energy resources, and financial resources. Incorporating weather forecast and plan based on probability (reduce demand by sector, adjust tariff, financial sustainability, and infrastructure development such as allocating budget to expand capacity, etc. to meet demand or provide less restriction by optimize the existing management practices.)

Previous years, there was no communication between sectors, sector resources users demand goes up, climate change variations lead to supply shortage. What if there are communications and collaborations on allocating water and other resources across all end user sectors, since 2015, could the system performance (in terms of agriculture product, water demand be meet, energy production be stabilized) be better? Can CCT avoids sacrifice on any sectors?  

We also want to compare the modeling results of different policy scenarios for a range of future climate scenarios. 

# Entities, state variables, and scales

There are five types of agents represented in this model:

1.	Governor (overall policy maker)
Overall Financial Budget, Priorities, Approval Rate

2.	Water Manager (Western Cape Department of Water Services)
Allocation for each of the water user agent, collaboration, water budget, water tariff, restrictions. 

3.	Energy Manager
Water Demand, Allocation, Hydro Energy Generation, Hydropower System Capacity, Priority

4.	Farmers
Water Demand, Allocation, Crop Area, Crop production, Crop type, Rating, Priority

5.	Citizens
Water Demand, Allocation, Population, Rating, Priority

6.	Commercial Users
Water Demand, Rating

The scale for the model is the city of cape town and the wine grape crop fields in Cape Wineland. The model is simulating from 2014-1-1 to 2019-1-1 for the retrofit of historic run. The time step is daily, but the time step for each agent and its sub-model may vary. (Placeholder for the granulation for the spatial aspect.)

# Process Overview and scheduling

At the beginning of each year, the governor make the decisions of the priorities of allocating resources based on the rating from each sector. 

The priorities then assigned to the water manager. Water managers monitors the reservoir levels and weather information. 

The reservoirs are represented by the patches. Reservoir levels updated by the rainfall/runoff equations (Berglund, 2015). Each reservoir has specific precipitation data. 

Every other agent rather than water manager and the mayor will report their water demand to the water manager on a monthly basis. 

Water managers makes water use restrictions based on the dam storage level, demand, and the priority monthly. The water manager will distribute the water to the users based on their priority levels determined by the Governor. 

The energy manager, citizens, commercial users and farmers update their state variables in their sub-models. 

The process will repeat at the beginning of each year, where governor will update the priorities based on the updated ratings from the stakeholders. 

# Design Concepts

## Emergence

More population may emerge over time. More infrastructure may develop over time. Climate change and associated parameters change will be shown in the model.  

## Adaptation
The demand may vary based on the climate of that year, so is policy. The governor will adapt to the ratings of the stakeholders. The water manager will adapt to the priorities by the governor. The other water users will adapt to the restrictions, price tariffs, and allocations. 

## Objectives
Managers are trying to meet demand. Mayor wants high approval rate. Citizens and commercial users wants to enough supply and lower price tariff. The Energy managers wants to maximize the hydropower generation. The farmers want to meet their irrigation demand. 

## Learning
No learning if we don’t include weather forecast?  Farmers will learn to save water by use weather information.


## Prediction
Weather prediction for next year’s policy? The agents are trying to learn or predict the weather of next year (see Ethan Yang’s paper)


## Sensing
Water managers can sense the water level of the reservoir patches. Farmers can sense their water budget. Governor can sense the ratings from the stakeholders. 

## Interaction
Interactions between mayor and FEW managers, between mayors and all others by ratings and policy priority, between water managers and citizens and commercial users, and between water managers and EF sectors.


## Stochasticity
The future weather conditions is going to be a stochastic model. Potential extreme weather events. The water demand of wards are randomly assigned followed by a normal distribution. 


## Collectives
Ratings, Energy generation, Water delivered and water demand, Crop production and area.


## Observation
Crop area, Temperature, Dam level, Precipitation.


## Initialization
The governor will start with priority of 100% for each of the stakeholders, since (assume) 2014 is a wet year. The rating of each stakeholder will begin with 10/10. 

*  The water demand of household: (indoor demand goes up when outside temp goes up) 

*  The water demand of commercial users:

*  The water demand of energy manager:

*  The water demand of farmers:

# Input data

Historic weather information.

# Submodels

## Agriculture model 
Water budget balance model: (precompute the data based on historic data, move forward, the sub model can be looped in a daily basis) Netlogo: levelspace Cory Grady
  Water Demand=E_(water-use)*(ET-P)*A

Where Ewater is the water use efficiency, ET is the evapotranspiration of the specific crop, P is the precipitation depth, and A is the area of the crop field. 

## Water manager, Citizen, and commerce 
Price-elasticity model: how water managers set water tariff to balance demand. Later: Also build in vary in temperature. Salvo Nature communications. 
## Energy Manager 
Linear model: Power = actual water/water demand * capacity
 
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.0.2
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
<experiments>
  <experiment name="scenario 2 price elasticity" repetitions="1" runMetricsEveryStep="true">
    <setup>setup
load-rain-temp-history</setup>
    <go>go</go>
    <metric>reduction-this-month</metric>
    <metric>energy-output-this-month</metric>
    <metric>water-price-this-month</metric>
    <metric>ag-allocation-this-month</metric>
    <metric>mu-allocation-this-month</metric>
    <metric>total-allocation-this-month</metric>
    <metric>V-display</metric>
    <metric>population</metric>
    <enumeratedValueSet variable="water-price-elasticity">
      <value value="-0.1"/>
      <value value="-0.2"/>
      <value value="-0.3"/>
      <value value="-0.4"/>
      <value value="-0.51"/>
      <value value="-0.6"/>
      <value value="-0.7"/>
      <value value="-0.8"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="scenario 1 efficiency" repetitions="1" runMetricsEveryStep="true">
    <setup>setup
load-rain-temp-history</setup>
    <go>go</go>
    <metric>reduction-this-month</metric>
    <metric>energy-output-this-month</metric>
    <metric>water-price-this-month</metric>
    <metric>ag-allocation-this-month</metric>
    <metric>mu-allocation-this-month</metric>
    <metric>total-allocation-this-month</metric>
    <metric>V-display</metric>
    <metric>population</metric>
    <steppedValueSet variable="Irrigation-Efficiency" first="1" step="0.1" last="2"/>
    <enumeratedValueSet variable="Scenario-1?">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="water-price-elasticity">
      <value value="-0.3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="share-other-crops-irrigation">
      <value value="0.57"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="water-price">
      <value value="5.2"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="scenario 1 share" repetitions="1" runMetricsEveryStep="true">
    <setup>setup
load-rain-temp-history</setup>
    <go>go</go>
    <metric>reduction-this-month</metric>
    <metric>energy-output-this-month</metric>
    <metric>water-price-this-month</metric>
    <metric>ag-allocation-this-month</metric>
    <metric>mu-allocation-this-month</metric>
    <metric>total-allocation-this-month</metric>
    <metric>V-display</metric>
    <metric>population</metric>
    <enumeratedValueSet variable="Irrigation-Efficiency">
      <value value="1.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Scenario-1?">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="water-price-elasticity">
      <value value="-0.3"/>
    </enumeratedValueSet>
    <steppedValueSet variable="share-other-crops-irrigation" first="0.57" step="0.02" last="0.69"/>
    <enumeratedValueSet variable="water-price">
      <value value="5.2"/>
    </enumeratedValueSet>
  </experiment>
</experiments>
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
0
@#$#@#$#@
