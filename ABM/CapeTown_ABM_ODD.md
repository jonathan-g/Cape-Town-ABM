# Purpose

We build this ABM close to the reality of the stakeholders from the municipal, water, energy (hydropower), and food sector, so we have a test bed to simulate and compare the FEW system outcomes under various policy scenarios. We test two policy scenarios:

1.	Business-as-usual (baseline): no joint-management or minimal communication between the departments of Energy, Water, and Food (agriculture). The tariffs of water and threshold levels of dam storage for restrictions used in this scenario are from the city of Cape Town;

2.	Holistic-adaptive-management: allocate water resources across FEW sectors to satisfy the municipal demand, similarly for hydropower generation, and agricultural production. This scenario also Incorporate some basic climate adaption strategies and adjusting water demand using water price elasticity of demand theory to manage water shortage.

Specifically, we use the scenario 1 to calibrate and set up the baseline to match the actual patterns of the system outcomes (i.e., dam storage levels, water use) under the existing management policies. Whereas scenario 2, we propose a new holistic management strategy to optimize the outcomes of water, energy, and food sector.

We also want to compare the modeling results of different policy scenarios for a range of future climate scenarios.

# Entities, state variables, and scales

There are five types of agents represented in this model:

1.	Water Manager (Western Cape Department of Water Services)
Allocation for each of the water user agent, total dam storage of this month, total storage capacity

2.	Energy Manager
maximum Capacity, actual apacity of this month

3.	Farmers
water demand, rainfall, temperature, soil moisture deficit and available water content of the month, Irrigation Area

4.	Citizens
water demand, population, population growth rate

The scale for the model is the city of cape town and the wine grape crop fields in Cape Wineland. The model is simulating from 2009-1 to 2018-12 for the retrofit of historic run. The time step is monthly.

# Process Overview and scheduling

The model simulates a ten-year monthly run from January 2009 to December 2018 for each of the policy scenarios at the monthly scale. The general inputs of the model include initial dam storage, monthly water inflow, monthly water demand by sectors, and water price and its price elasticity of demand (CSAG2019;  Sahin  et  al.  2016;  DWS  2018).  At the beginning of each month or tick in the model, the water manager asks the demand of each stakeholder and the check the dam level before allocation, then depends on the scenarios, the allocation for each sector is calculated accordingly. At the end of each month or tick, the dam storage is updated based on the current allocation and the inflow.

In Scenario 1, we use the restrictions set up by the city of Cape Town from 2015 to 2018. There are various levels of restrictions imposed on the study region. However, the major water use reductions occur at level 2, level 3, and level 6b, where 20\% municipal demand reduction, 30\% municipal demand reduction, and a strict 450 MLD municipal use restriction with zero agricultural water allocation are triggered when the total dam storage level is lower than 50\%, 45\%, and 20\%, respectively.

The scenario 2 takes a simple adaptive approach on imposing water use restrictions, where for each month or tick, the water manager compares the current dam storage level with the pre-drought (2009 to 2015) monthly average of dam storage level of this month. If the current dam storage level is greater than 90\% of the average, the water manager will not impose any restrictions and all stakeholders acquired their demanded water since it is in the normal range of variation. When the current dam storage level is lower than the threshold, the reduction of this month is simply the ratio of (Vavg - Vcurrent)/ Vavg. In addition, we use water price elasticity of demand so we can adjust the water price to reduce the demand to the targeted level.
After the storage has been updated, the tick advances and the loop continues until the end of tick 120 or 2018-12.

# Design Concepts

## Emergence

Population is growing over time at an annual rate of 0.8%.

## Adaptation

In Scenario 2, the adpation is the simple reduction if the storage level is lower than the threshold.

## Objectives

The objective of the ABM is to optimizing the system outcomes for all the stakeholders in the model.

## Learning
No learning if we don’t include weather forecast?  Farmers will learn to save water by use weather information.


## Prediction
Currently there is no prediction, but it is within the scope of phase 2 of this project.


## Sensing
Water managers can sense the dam storage level. Farmers can sense the rain and the temperature, and therefore the soil moisture.

## Interaction
Interactions is between the managers and the stakeholders through the demand and allocation.


## Stochasticity

In the future of phase 2, the future weather conditions is going to be a stochastic model. Potential extreme weather events. The stakeholders, instead of the current homogeneous state, will be diversified stochastically.


## Collectives

Rain, Temperature, soil moisture deficit, water price, Energy generation, Water demand and allocation of each stakeholders.


## Observation

Soil Moisture, temperature, dam storage level, porecipitation, water price.


## Initialization

The water manager will start with the upper limit of 920000 ML, and the actual storage volume at the end of 2008.

# Input data

Historic weather and inflow information. Unrestricted water demand. The soil moisture deficit was and input calculated using the tool developed by Jacobi et. al. (2013).

# Submodels

## Urban Demand Submodel

Capetonians and their urban demand is represented by a single agent, CPers. For simplicity, we aggregated the residential, commercial, and other miscellaneous water demand all together and averaged to individual urban water demand. The Cpers has 3.875 million people at the beginning of 2009 with an annual growth rate of 0.8%. In the city of Cape Town, the unrestricted individual urban water demand is calculated based on the monthly average of the urban water usage between 2009 to 2015 (CASG 2019). In all policy scenarios, the real municipal water allocation of the month is calculated using equation:
$$\text{Urban Allocation} = \text{Population}_i \times \text{Urban Demand} \times (1 - \text{Reduction}),$$
where $\text{Population}_i$ is the population of the year of this month, $i$.

## Agriculture Submodel

In the agricultural sub-model, the irrigation demand is calculated using the soil moisture deficit (SMD), where SMD is calculated by a simple water balance approach. We adopted the Palmer Drought Index calculating tool developed by (Jacobi 2013), which the monthly potential evapotranspiration (PET) and soil moisture content (SMC) are calculated by Thronthwaite method and by the water balance, respectively. It is a useful tool that provides relatively accurate results which have been used in agricultural research to assess drought and soil moisture (Gunda 2016,Nawagamuwa 2018). We estimated the AWC for each of the wine regions from the AWC map of the region (Schulze and Horan 2007), and the SMD was calculated by this tool using the monthly rainfall and temperature data from the closest weather station.

In this study, we specifically focused on the irrigation of the vineyards. On average, the share of irrigation for non-wine crops is 57 % (Western Cape Government 2015). In the model, we fix the 57% of the total agricultural water usage for the non-wine crops, because those crops are mainly located outside of our study region. We only manage the water allocation of the wine grapes in this model. The irrigation of the wine grapes is calculated using equation:
$$\text{Demand}_{\text{wine}}(m) = SWD(m) \times \text{Area} \times KC(m) \times Ef_{\text{wine}},$$
where $SWD(m)$ is the soil moisture deficit in month $m$, Area is the irrigation area of each wine region, $KC(m)$ is the crop coefficient of wine grapes for month $m$, and $Ef_{\text{wine}}$ is the irrigation efficiency of the vineyard (WSU 2016). We calibrate the model parameters under scenario 1 to match the historical patterns. The calibrated model parameters are carried on and used in scenario 2 as well.

## Hydropower Submodel

In the Big Six dam system, only Steenbras upper Dam is a pump-storage hydropower dam. To maintain the maximum generation capacity, the Steenbras Upper Dam needs to keep at full level (DWS 2018). The Steenbras Upper and Lower Dams operate together, where the lower dam pumps the water to the upper dam during off-peak hours, and the upper dam releases water during the peak hours that provide up to 180 mega watts (MW) to offload the pressure from the electricity grid. The storage capacities of the Steenbras Upper and Lower dams are similar, and the combinded storage accounts for 10% of the total capacity. The water supply system in Western Province cannot release water when the dam storage level is below 10% of the total capacity. Thus, we assume that if the total dam storage level is above 20% of the total dam storage capacity, the Steenbras Upper Dam can remain at full storage, and so is the maximum generation capacity. When the total dam storage level is lower than 15% of the total dam storage capacity, the water withheld in the Steenbras Upper dam will be released for the municipal water use, and no hydropower can be generated. In between 15% and 20% of the total dam storage, we assume the hydropower generation capacity decreases linearly.
