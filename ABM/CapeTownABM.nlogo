
globals
[
  area                           ;area of the world
  unit-crop-profit               ;unit crop profit that farmers get in even scenario
  mean-yield-his                 ;mean yield of turtles for histogram plot
  mean-wealth-his                ;mean wealth of turtles for histogram plot
  transaction
]


turtles-own
[

]


patches-own
[
  behaviour    ;behaviour I am expressing
  agent-who    ;who of turtle I belong to
  patch-yield  ;as for turtle variable 'yield' - in some setup instances the agent gets their yield value from their homestead patch
  landtype ;The initial of Land, E/1 stands for Else, O/2 stand for Ocean, BR/3 stands for Berge River Reservoir, VR/4 stands for Voëlvlei
           ;Voëlvlei Reservoir, TR/5 stands for the Theewaterkloof Reservoir, SR/6 represents Steenbras Reservoir, C/7 Stands for Cape Town,
           ;SW/8 stands for Swartland, D/9 stands for Drakenstein, S/10 stands for Stellenbosch, B/11 stands for Breede Valley, L/12 stands for Langeberg,
           ;W/13 stands for Witzenberg
]


to setup

 ;; (for this model to work with NetLogo's new plotting features,
  ;; __clear-all-and-reset-ticks should be replaced with clear-all at
  ;; the beginning of your setup procedure and reset-ticks at the end
  ;; of the procedure.)
  __clear-all-and-reset-ticks
  clear-output

  file-open "spatial_data.txt"
  while [not file-at-end?]
  [
    let next-X file-read
    let next-Y file-read
    let next-type file-read
    ask patch next-X next-Y [set landtype next-type]
  ]
  file-close

  ask patches
    [
      ifelse  landtype = 1 ; out of scope Else
      [set pcolor black]
      [;do nothing
      ]

      ifelse  landtype = 2
      [set pcolor blue]
      [;do nothing
      ]

      ifelse  landtype = 3; reservoir
      [set pcolor 85; light blue
      ]
      [;do nothing
      ]

      ifelse  landtype = 4; reservoir
      [set pcolor 85; light blue
      ]
      [;do nothing
      ]

      ifelse  landtype = 5; reservoir
      [set pcolor 85; light blue
      ]
      [;do nothing
      ]

      ifelse  landtype = 6; reservoir
      [set pcolor 85; light blue
      ]
      [;do nothing
      ]

      ifelse  landtype = 7; Cape Town
      [set pcolor 66; light green
      ]
      [;do nothing
      ]

      ifelse  landtype = 8; Cape Town
      [set pcolor yellow; light green
      ]
      [;do nothing
      ]
  ]

  set mean-yield-his []
  set mean-wealth-his []


end

to setSwartland
  let i 9
  ask patch  6 9
  [set pcolor white]

  ask patch 0 20
  [set pcolor red]

  ask patch 0 1
  [set pcolor green]

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
14
18
80
51
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
