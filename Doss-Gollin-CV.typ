// Official Rice colors
#let rice-blue = rgb("#00205B") // use for text etc
#let rice-gray = rgb("#7C7E7F") // use for Section

#let mono(body) = text(font: "Inconsolata", body)
#let fa-solid(glyph) = text(font: "Font Awesome 7 Free Solid", glyph)
#let fa-brands(glyph) = text(font: "Font Awesome 7 Brands", glyph)
#let icon-envelope = fa-solid("\u{f0e0}")
#let icon-globe = fa-solid("\u{f0ac}")
#let icon-github = fa-brands("\u{f09b}")
#let icon-scholar = fa-brands("\u{e63b}")

// Header and footer (skip first page)
#let running(body) = context if here().page() > 1 { text(size: 8pt, fill: rice-gray, body) }
#set page(
  paper: "us-letter",
  margin: 0.75in,
  // Match fancyhdr: header rule 25pt above the text block, footer rule 20pt below it
  header-ascent: 25pt,
  footer-descent: 20pt,
  header: running[
    James Doss-Gollin #h(1fr) updated #datetime.today().display("[month repr:long] [day padding:none], [year]")
    #v(-0.2em)
    #line(length: 100%, stroke: 0.5pt + rice-gray)
  ],
  footer: running[
    #line(length: 100%, stroke: 0.5pt + rice-gray)
    #align(center, context counter(page).display("1 / 1", both: true))
  ],
)

#set text(font: "Lato", size: 10pt, lang: "en", region: "us")
#set par(justify: true, leading: 0.5em, spacing: 0.5em)
#show link: set text(fill: rice-blue)

// Section styling
#show heading.where(level: 1): it => block(above: 1.25em, below: 0.4em, sticky: true)[
  #text(size: 12pt, weight: "bold", upper(it.body))
  #v(-0.8em)
  #line(length: 100%, stroke: 0.4pt)
]
#show heading.where(level: 2): it => block(above: 1.25em, below: 0.5em, sticky: true,
  text(size: 10pt, weight: "bold", fill: rice-blue, upper(it.body)))

// One row: main content on the left with a hanging indent, date right-aligned.
// `indent` insets the whole row, for roles and degrees nested under an institution.
// par(hanging-indent:) does not reach a grid cell's paragraph, so the hang is built from padding.
#let entry(body, date, indent: 0pt, hang: 2em) = block(above: 0.5em, below: 0.5em, inset: (left: indent),
  grid(
    columns: (85%, 1fr),
    align: (left, right),
    pad(left: hang, h(-hang) + body), date,
  ))

// Group label within a subsection (e.g. advising roles)
#let group-label(name) = block(above: 1.1em, below: 0.7em, sticky: true, strong(name))

// Institution name above nested entries
#let institution(name) = block(above: 0.5em, below: 0.5em, sticky: true, strong(name))

// Highlighted author: bold for James; blue, bold, with a dagger for advisees
#let advisee(name) = text(fill: rice-blue, weight: "bold", name + super(typographic: false)[†])

//---------------------------------------------------------------------

// Name and contact block
#text(fill: rice-gray, grid(
  columns: (1fr, auto),
  row-gutter: 0.35em,
  align: (left, right),
  [Rice University], [#mono(link("mailto:jdossgollin@rice.edu")[jdossgollin\@rice.edu])#h(0.45em)#icon-envelope],
  [Department of Civil and Environmental Engineering], [#mono(link("https://dossgollin-lab.github.io")[https:\/\/dossgollin-lab.github.io])#h(0.45em)#icon-globe],
  [6100 Main Street, Ryon Lab 204-MS 318], [#mono(link("https://github.com/jdossgollin")[jdossgollin])#h(0.45em)#icon-github],
  [Houston, TX, 77005], [#mono(link("https://scholar.google.com/citations?user=6ifLBBsAAAAJ")[James Doss-Gollin])#h(0.45em)#icon-scholar],
))

#v(0.8em)

// Name
#text(size: 14.4pt, weight: "bold", fill: rice-blue)[James Doss-Gollin]

#v(0.6em)

// Include CV sections
// NOTE: Section order is defined here, not in _config.yml. The `sections:`
// list in _config.yml maps titles to YAML files but does not control order.
// Appointments
= Appointments




#institution[Rice University]


#entry(indent: 2em, hang: 0pt)[#emph[Assistant Professor], Department of Civil & Environmental Engineering][2021---]


#entry(indent: 2em, hang: 0pt)[#emph[Affiliated Faculty], Severe Storm Prediction, Education, and Evacuation from Disasters (SSPEED) Center][2021---]


#entry(indent: 2em, hang: 0pt)[#emph[Affiliated Faculty], Ken Kennedy Institute][2023---]


#institution[The Pennsylvania State University]


#entry(indent: 2em, hang: 0pt)[#emph[Postdoctoral Scholar], Earth & Environmental Systems Institute][2020]

// Education
= Education


#institution[Columbia University]

#entry(indent: 2em, hang: 0pt)[#emph[Ph.D. in Earth & Environmental Engineering]][2020]

#entry(indent: 2em, hang: 0pt)[#emph[M.S. in Earth & Environmental Engineering]][2016]


#institution[Yale University]

#entry(indent: 2em, hang: 0pt)[#emph[B.S. in Mechanical Engineering]][2015]


// Awards
= Awards and Honors


#entry[#strong[NSF CAREER Award], National Science Foundation][2026]

#entry[#strong[Outstanding Reviewer Award], Earth's Future][2023]

#entry[#strong[Nickolas and Liliana Themelis Fellowship], Fu Foundation School of Engineering and Applied Science, Columbia University][2018]

#entry[#strong[Graduate Research Fellowship, Climate and Large-Scale Atmospheric Dynamics], National Science Foundation][2017]

#entry[#strong[Presidential Distinguished Fellowship], Fu Foundation School of Engineering and Applied Science, Columbia University][2015]

#entry[#strong[Distinction in Major], Department of Mechanical Engineering and Materials Science, Yale University][2015]

#entry[#strong[Legacy Award], New Haven Promise][2015]

#entry[#strong[Larry Coben '79 Fellowship], Yale University][2014]

#entry[#strong[Vance-Carter Travel Award], Yale University][2013]

#entry[#strong[Thomas C. Barry Travel Award], Yale University][2012]


== Advisee Awards


#entry[#strong[Dongwook Kim]: Karen and John Huff Graduate Fellowship in Civil and Environmental Engineering.][2025]

#entry[#strong[Yuchen Lu]: H.W. Reeves Endowed Scholarship.][2022]

// Publications
= Publications

#text(fill: rice-blue, weight: "bold")[#super(typographic: false)[†] denotes Rice advisee publication].
#link("https://scholar.google.com/citations?user=6ifLBBsAAAAJ")[Google Scholar #icon-scholar] #emph[citations]: 862, #emph[h-index]: 14, #emph[i10-index]: 17.




== In Prep. / Under Review


#entry[\[1\] Pollack, A., Benedict, J., Deb, M., #strong[Doss-Gollin, J.], Judi, D., Lehman, W., Lutz, N., Reesman, C., Sarazen, E., Son, Y., Srikrishnan, V., Sun, N., and Keller, K.: #emph[Unrefined National Building Inventories Can Mislead Risk Assessments and Decisions]. DOI: #mono(link("https://doi.org/10.2139/ssrn.5575271")[10.2139\/ssrn.5575271])][---]


== Journal Articles


#entry[\[28\] Baer, J. A., Sebastian, A., Grimley, L. E., #strong[Doss-Gollin, J.], Wright, D. B., Hussain, M. A., and Webber, M. K.: "Neglecting Spatiotemporal Rainfall Variability Misrepresents Flood Hazard and Risk". #emph[npj Natural Hazards]. DOI: #mono(link("https://doi.org/10.1038/s44304-026-00208-5")[10.1038\/s44304-026-00208-5])][2026]

#entry[\[27\] Hancock, C. L., Dee, S. G., Haider, M. R., #strong[Doss-Gollin, J.], Lehner, F., Murphy, K., and Muñoz, S. E.: "Twenty-First-Century Hydrological Trends in the Mississippi River Basin Intensify the East–West Moisture Gradient". #emph[Journal of Climate]. DOI: #mono(link("https://doi.org/10.1175/jcli-d-25-0340.1")[10.1175\/jcli-d-25-0340.1])][2026]

#entry[\[26\] Murphy, K., Dee, S., Hancock, C., Pitchon, E., #strong[Doss-Gollin, J.], Wallace, E., and Muñoz, S.: "The Changing Relationship between the Bermuda High, Great Plains Low-Level Jet, and Mississippi River Basin Hydroclimate from the Last Millennium to 2100". #emph[Journal of Geophysical Research: Atmospheres]. DOI: #mono(link("https://doi.org/10.1029/2025JD044340")[10.1029\/2025JD044340])][2026]

#entry[\[25\] O’Donnell, M., Dee, S., #strong[Doss-Gollin, J.], and Muñoz, S. E.: "Hydrologic Whiplash in the Mississippi River Basin: Mechanisms and Projections". #emph[Geophysical Research Letters]. DOI: #mono(link("https://doi.org/10.1029/2026GL122807")[10.1029\/2026GL122807])][2026]

#entry[\[24\] Pollack, A. B., Auermuller, L., Burleyson, C. D., Campbell, J., Condon, M., Cooper, C., Coronese, M., Dangendorf, S., #strong[Doss-Gollin, J.], Hegde, P., Helgeson, C., Kopp, R. E., Kwakkel, J., Lesk, C., Mankin, J., Nicholas, R. E., Rice, J., Roth, S., Srikrishnan, V., Scheeler, M., Tuana, N., Vernon, C., Zhao, M., and Keller, K.: "Unlocking the Benefits of Transparent and Reusable Science for Climate Risk Management". #emph[Proceedings of the National Academy of Sciences]. DOI: #mono(link("https://doi.org/10.1073/pnas.2422157123")[10.1073\/pnas.2422157123])][2026]

#entry[\[23\] Haider, M. R., Dee, S., #strong[Doss-Gollin, J.], Dunne, K., and Muñoz, S.: "Impact of 21st Century Climate Change on Mississippi River Basin Discharge in CESM2 Large Ensemble Projections". #emph[Global and Planetary Change]. DOI: #mono(link("https://doi.org/10.1016/j.gloplacha.2025.104742")[10.1016\/j.gloplacha.2025.104742])][2025]

#entry[\[22\] Liu, C., Kowal, D. R., #strong[Doss-Gollin, J.], and Vannucci, M.: "Bayesian Functional Graphical Models with Change-Point Detection". #emph[Computational Statistics and Data Analysis]. DOI: #mono(link("https://doi.org/10.1016/j.csda.2024.108122")[10.1016\/j.csda.2024.108122])][2025]

#entry[\[21\] Liu, Y., #strong[Doss-Gollin, J.], Dai, Q., Veeraraghavan, A., and Balakrishnan, G.: "Downscaling Extreme Precipitation with Wasserstein Regularized Diffusion". #emph[IEEE Transactions on Geoscience and Remote Sensing]. DOI: #mono(link("https://doi.org/10.1109/TGRS.2025.3611872")[10.1109\/TGRS.2025.3611872])][2025]

#entry[\[20\] #advisee[Lu, Y.], Seiyon Lee, B., and #strong[Doss-Gollin, J.]: "Bayesian Spatiotemporal Nonstationary Model Quantifies Robust Increases in Daily Extreme Rainfall across the Western Gulf Coast". #emph[Environmental Research: Climate]. DOI: #mono(link("https://doi.org/10.1088/2752-5295/adf56e")[10.1088\/2752-5295\/adf56e])][2025]

#entry[\[19\] O'Donnell, M., Murphy, K., #strong[Doss-Gollin, J.], Dee, S., and Munoz, S.: "Evaluation of Hydroclimatic Biases in the Community Earth System Model (CESM1) within the Mississippi River Basin". #emph[Hydrology and Earth System Sciences]. DOI: #mono(link("https://doi.org/10.5194/hess-29-4637-2025")[10.5194\/hess-29-4637-2025])][2025]

#entry[\[18\] Pollack, A., #strong[Doss-Gollin, J.], Srikrishnan, V., and Keller, K.: "UNSAFE: An UNcertain Structure and Fragility Ensemble Framework for Property-Level Flood Risk Estimation". #emph[Journal of Open Source Software]. DOI: #mono(link("https://doi.org/10.21105/joss.07527")[10.21105\/joss.07527])][2025]

#entry[\[17\] Kazadi, A., #strong[Doss-Gollin, J.], Sebastian, A., and Silva, A.: "FloodGNN-GRU: A Spatio-Temporal Graph Neural Network for Flood Prediction". #emph[Environmental Data Science]. DOI: #mono(link("https://doi.org/10.1017/eds.2024.19")[10.1017\/eds.2024.19])][2024]

#entry[\[16\] Murphy, K., Dee, S., #strong[Doss-Gollin, J.], Dunne, K. B. J., O’Donnell, M., and Muñoz, S.: "Competing Influences of Land Use and Greenhouse Gas Emissions on Mississippi River Basin Hydroclimate Simulated over the Last Millennium". #emph[Paleoceanography and Paleoclimatology]. DOI: #mono(link("https://doi.org/10.1029/2024PA004902")[10.1029\/2024PA004902])][2024]

#entry[\[15\] Singh, D., Bekris, Y. S., Rogers, C. D. W., #strong[Doss-Gollin, J.], Coffel, E. D., and Kalashnikov, D. A.: "Enhanced Solar and Wind Potential during Widespread Temperature Extremes across the U.S. Interconnected Energy Grids". #emph[Environmental Research Letters]. DOI: #mono(link("https://doi.org/10.1088/1748-9326/ad2e72")[10.1088\/1748-9326\/ad2e72])][2024]

#entry[\[14\] Amonkar, Y., #strong[Doss-Gollin, J.], Farnham, D. J., Modi, V., and Lall, U.: "Differential Effects of Climate Change on Average and Peak Demand for Heating and Cooling across the Contiguous USA". #emph[Communications Earth & Environment]. DOI: #mono(link("https://doi.org/10.1038/s43247-023-01048-1")[10.1038\/s43247-023-01048-1])][2023]

#entry[\[13\] Amonkar, Y., #strong[Doss-Gollin, J.], and Lall, U.: "Compound Climate Risk: Diagnosing Clustered Regional Flooding at Inter-Annual and Longer Time Scales". #emph[Hydrology]. DOI: #mono(link("https://doi.org/10.3390/hydrology10030067")[10.3390\/hydrology10030067])][2023]

#entry[\[12\] #strong[Doss-Gollin, J.], Amonkar, Y., #advisee[Schmeltzer, K.], and Cohan, D.: "Improving the Representation of Climate Risks in Long-Term Electricity Systems Planning: A Critical Review". #emph[Current Sustainable\/Renewable Energy Reports]. DOI: #mono(link("https://doi.org/10.1007/s40518-023-00224-3")[10.1007\/s40518-023-00224-3])][2023]

#entry[\[11\] #strong[Doss-Gollin, J.] and Keller, K.: "A Subjective Bayesian Framework for Synthesizing Deep Uncertainties in Climate Risk Management". #emph[Earth's Future]. DOI: #mono(link("https://doi.org/10.1029/2022EF003044")[10.1029\/2022EF003044])][2023]

#entry[\[10\] Garcia, M., Juan, A., #strong[Doss-Gollin, J.], and Bedient, P.: "Leveraging Mesh Modularization to Lower the Computational Cost of Localized Updates to Regional 2D Hydrodynamic Model Outputs". #emph[Engineering Applications of Computational Fluid Mechanics]. DOI: #mono(link("https://doi.org/10.1080/19942060.2023.2225584")[10.1080\/19942060.2023.2225584])][2023]

#entry[\[9\] Wutich, A., Thomson, P., Jepson, W., Stoler, J., Cooperman, A. D., #strong[Doss-Gollin, J.], Jantrania, A., Mayer, A., Nelson-Nuñez, J., Walker, W. S., and Westerhoff, P.: "MAD Water: Integrating Modular, Adaptive, and Decentralized Approaches for Water Security in the Climate Change Era". #emph[WIREs Water]. DOI: #mono(link("https://doi.org/10.1002/wat2.1680")[10.1002\/wat2.1680])][2023]

#entry[\[8\] Zhou, X., Duenas-Osorio, L., #strong[Doss-Gollin, J.], Liu, L., Stadler, L., and Li, Q.: "Mesoscale Modeling of Distributed Water Systems Enables Policy Search". #emph[Water Resources Research]. DOI: #mono(link("https://doi.org/10.1029/2022WR033758")[10.1029\/2022WR033758])][2023]

#entry[\[7\] #strong[Doss-Gollin, J.], Farnham, D. J., Lall, U., and Modi, V.: "How Unprecedented Was the February 2021 Texas Cold Snap?". #emph[Environmental Research Letters]. DOI: #mono(link("https://doi.org/10.1088/1748-9326/ac0278")[10.1088\/1748-9326\/ac0278])][2021]

#entry[\[6\] #strong[Doss-Gollin, J.], Farnham, D. J., Ho, M., and Lall, U.: "Adaptation over Fatalism: Leveraging High-Impact Climate Disasters to Boost Societal Resilience". #emph[Journal of Water Resources Planning and Management]. DOI: #mono(link("https://doi.org/10.1061/(asce)wr.1943-5452.0001190")[10.1061\/(asce)wr.1943-5452.0001190])][2020]

#entry[\[5\] #strong[Doss-Gollin, J.], Farnham, D. J., Steinschneider, S., and Lall, U.: "Robust Adaptation to Multiscale Climate Variability". #emph[Earth's Future]. DOI: #mono(link("https://doi.org/10.1029/2019ef001154")[10.1029\/2019ef001154])][2019]

#entry[\[4\] Rözer, V., Kreibich, H., Schröter, K., Müller, M., Sairam, N., #strong[Doss-Gollin, J.], Lall, U., and Merz, B.: "Probabilistic Models Significantly Reduce Uncertainty in Hurricane Harvey Pluvial Flood Loss Estimates". #emph[Earth's Future]. DOI: #mono(link("https://doi.org/10.1029/2018ef001074")[10.1029\/2018ef001074])][2019]

#entry[\[3\] #strong[Doss-Gollin, J.], Muñoz, Á. G., Mason, S. J., and Pastén, M.: "Heavy Rainfall in Paraguay during the 2015\/16 Austral Summer: Causes and Subseasonal-to-Seasonal Predictive Skill". #emph[Journal of Climate]. DOI: #mono(link("https://doi.org/10.1175/JCLI-D-17-0805.1")[10.1175\/JCLI-D-17-0805.1])][2018]

#entry[\[2\] Farnham, D. J., #strong[Doss-Gollin, J.], and Lall, U.: "Regional Extreme Precipitation Events: Robust Inference from Credibly Simulated GCM Variables". #emph[Water Resources Research]. DOI: #mono(link("https://doi.org/10.1002/2017WR021318")[10.1002\/2017WR021318])][2018]

#entry[\[1\] #strong[Doss-Gollin, J.], de Souza Filho, F. d. A., and da Silva, F. O. E.: "Analytic Modeling of Rainwater Harvesting in the Brazilian Semiarid Northeast". #emph[Journal of the American Water Resources Association]. DOI: #mono(link("https://doi.org/10.1111/1752-1688.12376")[10.1111\/1752-1688.12376])][2016]


== Peer-Reviewed Conference Papers


#entry[\[4\] Kazadi, A., #strong[Doss-Gollin, J.], and Silva, A.: "Pluvial Flood Emulation with Hydraulics-Informed Message Passing". #emph[Forty-First International Conference on Machine Learning]. URL: #mono(link("https://openreview.net/forum?id=kIHIA6Lr0B")[https:\/\/openreview.net\/forum?id=kIHIA6Lr0B])][2024]

#entry[\[3\] Kazadi, A. N., #strong[Doss-Gollin, J.], Sebastian, A., and Silva, A.: "Flood Prediction with Graph Neural Networks". #emph[Climate Change AI]. URL: #mono(link("https://www.climatechange.ai/papers/neurips2022/75")[https:\/\/www.climatechange.ai\/papers\/neurips2022\/75])][2022]

#entry[\[2\] Araújo Júnior, L. M., de Souza Filho, F. d. A., da Silva Silveira, C., Aragão Dias, T., and #strong[Doss-Gollin, J.]: "Análise Dos Eventos de Seca No Nordeste Setentrional Brasileiro Com Base No Índice de Precipitação Normalizada". #emph[XII Simpósio de Recursos Hídricos Do Nordeste]. DOI: #mono(link("https://doi.org/10.13140/rg.2.1.4610.7685")[10.13140\/rg.2.1.4610.7685])][2014]

#entry[\[1\] #strong[Doss-Gollin, J.], de Souza Filho, F. d. A., and da Silva, F. O. E.: "Considerações Sobre a Sustentabilidade Hídrica de Cisternas Para Captação de Chuva No Semiárido Brasileiro". #emph[XII Simpósio de Recursos Hídricos Do Nordeste]. DOI: #mono(link("https://doi.org/10.13140/rg.2.1.4086.4807")[10.13140\/rg.2.1.4086.4807])][2014]

// Grants and Contracts
= Sponsored Research

#block(below: 1em, emph[Amounts reflect Rice portion for collaborative grants and subawards; total amount for direct awards.])



#entry[PI, National Science Foundation -- Infrastructure Systems and People. #emph[CAREER: Drain or Retain? Strategic Assessment of Integrated Flood Infrastructure Portfolios with Physics-Informed ML]. No.~2543303. (\$599,581)][2026--2031]


#entry[PI, Ken Kennedy Institute at Rice University. #emph[AI for Catastrophe Modeling and Resilience] with Avantika Gori, Katherine Ensor, Jamie Padgett, Xinwu Qian, Arlei Lopes da Silva, and Noemi Vergopolan. (\$55,000)][2026--2027]


#entry[Co-PI, National Science Foundation -- Confronting Hazards, Impacts and Risks for a Resilient Planet (CHIRRP). #emph[RAISE: Flood Resilience in Rural Texas Communities] PI: Avantika Gori, with Andrew Juan and Keri Stephens. No.~2440167. (\$999,986)][2025--2028]


#entry[PI, Consortium for Enhancing Resilience and Catastrophe Modeling (CERCAT). #emph[A Nonstationary Joint Probability Method for Tropical Cyclone Hazard Assessment] with Avantika Gori. No.~P12. (\$75,000)][2025--2026]


#entry[PI, Ken Kennedy Institute at Rice University. #emph[Advancing AI for Climate Risk and Urban Resilience] with Sylvia Dee, Avantika Gori, Arlei Lopes da Silva, Jamie Padgett, and Noemi Vergopolan. (\$80,000)][2025--2026]


#entry[Co-PI, NVIDIA. #emph[Computing Infrastructure for AI-enhanced Climate Risk and Resilience at Rice] PI: Arlei Lopes da Silva, with Avantika Gori. in-kind][2025--2025]


#entry[PI, Ken Kennedy Institute at Rice University. #emph[Advancing AI for Climate Risk and Urban Resilience] with Sylvia Dee, Avantika Gori, Arlei Lopes da Silva, Jamie Padgett, and Noemi Vergopolan. (\$80,000)][2024--2025]


#entry[Co-PI, National Science Foundation -- Industry-University Cooperative Research Centers (IUCRC). #emph[IUCRC Planning Grant Rice University: Center for Climate, Equity and Resilience in Catmodeling (CERCat)] PI: Jamie Padgett, with Katherine Ensor, Avantika Gori, Leonardo Dueñas Osorio, Brian Davison, David Casagrande, Maryam Rahnemoonfar, Paolo Bocchini, and Yi-Chen Yang. No.~2413382. (\$20,000)][2024--2025]


#entry[Co-PI, Rice University Sustainability Institute. #emph[Workshop on Nature-Based Solutions for Resilient Coastal Cities] PI: Philip Bedient, with Avantika Gori. (\$7,500)][2024--2025]


#entry[PI, Texas Water Development Board. #emph[Developing Future Rainfall Frequency Grids for the State of Texas] with John Nielsen-Gammon. (Full grant \$192,828. Subaward \$77,750)][2022--2026]


#entry[Co-PI, National Science Foundation -- Climate and Large-Scale Dynamics (CLD). #emph[Collaborative Research: Evaluating the Past and Future of Mississippi River Hydroclimatology to Constrain Risk via Integrated Climate Modeling, Observations, and Reconstructions] PI: Sylvia Dee, with Samuel Muñoz. No.~2147781. (\$472,024)][2022--2025]


#entry[PI, National Science Foundation -- Strengthening America's Infrastructure (SAI). #emph[Collaborative Research: EAGER: Participatory Design for Water Quality Monitoring of Highly Decentralized Water Infrastructure Systems] with Alicia Cooperman, Alex Mayer, Shane Walker, and Manuela Muñoz Fuerte. No.~2120829. (\$85,046)][2022--2025]


#entry[Co-PI, 100,000 Strong in the Americas Innovation Fund. #emph[IFCE-Rice-SENAI Program on Artificial Intelligence for Urban Sustainability and Resilience to Natural Disasters in the Americas] PI: Arlei Lopes da Silva. (\$50,000)][2022--2023]


#entry[Co-PI, Energy Foundation. #emph[Synthesis of Texas Electricity Research from Rice University] PI: Daniel Cohan. (\$24,928)][2022--2023]


#entry[PI, Rice University -- Sustainable Futures Fund (SFF). #emph[Leveraging Earth System Observations at Multiple Scales to Improve Stormwater Management in Houston] with Sylvia Dee. (\$50,000)][2022--2023]

// Presentations
= Presentations

== Invited Talks


#entry["Statistical Modeling for Nonstationary Hydroclimate Hazards: Challenges and Opportunities". Statistics Colloquium, #strong[Rice University], Houston, TX.][2025]

#entry[Panelist. Exploring Water Resilience to Emerging Challenges, #strong[Society for Risk Analysis], Remote Presentation.][2025]

#entry["Advancing Urban Flood Risk Management through Physics-informed, Data-Driven Hazard Assessment". Earth, Marine, and Environmental Science Seminar, #strong[University of North Carolina], Chapel Hill, NC.][2024]

#entry["Quantifying and Characterizing Uncertain Climate Hazards to Enable Adaptive Resilience". Atmospheric Sciences Seminar, #strong[Texas A&M University], College Station, TX.][2022]

#entry["Revisiting Our Design Criteria: What Hazards Should We Design for in a Changing Climate?". Hydrologic Sciences and Water Resources Engineering Seminar, #strong[University of Colorado Boulder], Remote Presentation.][2022]

#entry["Adapting Engineering Design Criteria to a Changing Climate: Insights from House Elevation ". Technical Webinar, #strong[ASCE Central New Jersey Branch], Remote Presentation.][2022]

#entry[Panelist. Extreme Weather: How To Report on a World That's Warmer, Colder, Wetter, Drier and Weirder, #strong[31st Annual Conference of the Society of Environmental Journalists], Houston, TX.][2022]

#entry["Predictable and Preventable: Lessons in Climate Risk Management from the Texas Coast (and Beyond)". Climate Risk and Financial Institutions Seminar (Prof. Madison Condon), #strong[Boston University School of Law], Remote Presentation.][2022]

#entry["Extreme Impacts Don't Require Extreme Weather: Lessons from the February 2021 Texas Blackouts". Outreach Event: Science is for Everyone, #strong[American Meteorological Society], Remote Presentation.][2022]

#entry["Extreme Impacts Don't Require Extreme Weather: Lessons from the February 2021 Texas Blackouts". Compound Events Working Group, #strong[Risk KAN (Knowledge Action Networks)], Remote Presentation.][2021]

#entry[Panelist. Tail events: Prediction, Planning, and Performance, #strong[Harvard Electricity Policy Group], Remote Presentation.][2021]

#entry["Towards Adaptive Resilience: Managing Flood Risks in a Changing World". Technical Webinar, #strong[ASCE Central New Jersey Branch], Remote Presentation.][2021]

#entry["Prediction and Implications of Structured Climate Risk for Sequential Adaptation under Deep Uncertainty". Center for Climate Risk Management CLIMA Seminar, #strong[the Pennsylvania State University], State College, PA.][2020]

#entry["Prediction and Implications of Structured Climate Risk for Sequential Adaptation under Deep Uncertainty". Department of Civil and Environmental Engineering Seminar, #strong[Rice University], Houston, TX.][2020]

#entry["Prediction and Implications of Structured Climate Risk for Sequential Adaptation under Deep Uncertainty". Complex Systems Simulation and Optimization Group, #strong[National Renewable Energy Laboratory], Golden, CO.][2020]

#entry["Drivers of Extreme Rainfall: Atmospheric Circulation Patterns and Regional Intense Rainfall in the Ohio River". European Flood Awareness System Group, #strong[European Centre for Medium Range Weather Forecasting], Reading, England.][2016]

#entry["Understanding the Physical Drivers of Extreme Rainfall for Flood Prediction". Oxford Water Network, #strong[Oxford University], Oxford, England.][2016]


== First-Author Conference and Workshop Presentations







#entry["Industry-Academia Collaborations on Seasonal and Long-Term TC Hazard Assessment (CERCat)". #strong[Catastrophe Risk Management Conference (CATRISK26)], #emph[Reinsurance Association of America], Orlando, FL \[#emph[Panel]\].][2026]



#entry["H24A-07: TxRain: A Bayesian framework for integrating historical observations and model projections to develop nonstationary IDF curves". #strong[American Geophysical Union Fall Meeting 2025], New Orleans, LA \[#emph[Talk]\].][2025]





#entry["Robust Trends in Extreme Rainfall Probabilities in Texas". #strong[2025 Texas Climate Conference], #emph[Rice University and Texas A&M University], Houston, TX \[#emph[Talk]\].][2025]



#entry["Use-Inspired Tools for Climate Hazard Assessment". #strong[Nature-Based Solutions for a Resilient Gulf Coast Workshop], #emph[Rice University], Houston, TX \[#emph[Talk]\].][2025]



#entry["Advancing Urban Flood Hazard Characterization through Machine Learning: Challenges and Opportunities". #strong[American Geophysical Union Fall Meeting 2024], Washington, DC \[#emph[Talk]\].][2024]





#entry["Assessing and Managing Climate Risks to Electricity Systems in an Era of Climate Change and Energy Transition". #strong[American Geophysical Union Fall Meeting 2024], Washington, DC \[#emph[Talk]\].][2024]





#entry["Leveraging Machine Learning to Advance Urban Flood Hazard Assessment: Challenges and Opportunities". #strong[Data-driven and physics-based machine learning methods for forecasting and knowledge discovery of surface hydrology], #emph[Conference on Computational Methods in Water Resources], Tucson, AZ \[#emph[Talk]\].][2024]



#entry["Incorporating Temperature Projections into Energy Systems Planning". #strong[Extreme Heat Workshop], #emph[Columbia University], New York, NY \[#emph[Talk]\].][2024]







#entry["NH14B-07: Linking Robust Trends in Observations and Models to Develop Nonstationary Rainfall Frequency Grids for the State of Texas". #strong[American Geophysical Union Fall Meeting 2023], San Francisco, CA \[#emph[Talk]\].][2023]



#entry["A Bayesian Spatial Hierarchical Framework for Process-Informed Nonstationary Analysis of Precipitation Frequencies". #strong[13th International Workshop on Statistical Hydrology], #emph[International Association of Hydrological Sciences], Boston, MA \[#emph[Talk]\].][2023]





#entry["H35F-07: Near-term Predictability Lowers Long-Term Adaptation Costs". #strong[American Geophysical Union Fall Meeting 2022], Chicago, IL \[#emph[Talk]\].][2022]



#entry["Unprecedented Impacts Don't Require Unprecedented Weather". #strong[Post-Harvey Climate & Flood Impacts on the Built Environment], #emph[Severe Storm Prediction, Education, & Evacuation from Disasters Center], Houston, TX.][2022]



#entry["H25U-1265: Operationalizing Bayesian Model Checking for Robust Decision Making: Insights from House Elevation". #strong[American Geophysical Union Fall Meeting 2021], New Orleans, LA \[#emph[Poster]\].][2021]



#entry["A14H-03: How Unprecedented Was the February 2021 Texas Cold Snap?". #strong[American Geophysical Union Fall Meeting 2021], New Orleans, LA \[#emph[Talk]\].][2021]



#entry["Valuing Flexibility and Soft Instruments for Sequential Decision Problems". #strong[2020 Annual Meeting], #emph[Society for Decision Making under Deep Uncertainty],  \[#emph[Remote Presentation]\].][2020]



#entry["H11G-07: Towards Adaptive Resilience: Managing Uncertainties and Exploiting Predictability across Timescales". #strong[American Geophysical Union Fall Meeting 2019], San Francisco, CA \[#emph[Talk]\].][2019]



#entry["Adaptive Resilience through Real Options and Deep Reinforecement Learning". #strong[Doctoral Consortium on Computational Sustainability], #emph[Carnegie Mellon University], Pittsburgh,  PA \[#emph[Talk]\].][2019]



#entry["Evaluating Staged Investments in Critical Infrastructure for Climate Adaptation". #strong[2019 Interdisciplinary Ph.D. Workshop in Sustainable Development], #emph[Columbia University], New York, NY \[#emph[Talk]\].][2019]



#entry["H52F-05: Robust Adaptation to Cyclical Climate Risk". #strong[American Geophysical Union Fall Meeting 2018], Washington, DC \[#emph[Talk]\].][2018]



#entry["Robust Adaptation to Multi-Scale Climate Variability". #strong[The Nexus of Climate Data, Insurance, and Adaptive Capacity], Asheville, NC \[#emph[Poster]\].][2018]



#entry["A31H-0135: Causes and Model Skill of the Persistent Intense Rainfall and Flooding in Paraguay during the Austral Summer 2015-2016". #strong[American Geophysical Union Fall Meeting 2017], New Orleans, LA \[#emph[Talk]\].][2017]



#entry["H22B-02: Designing and Operating Infrastructure for Nonstationary Flood Risk Management". #strong[American Geophysical Union Fall Meeting 2017], New Orleans, LA \[#emph[Talk]\].][2017]



#entry["Extreme Rainfall in Paraguay during the 2015-16 Austral Summer: Causes and Predictive Skill". #strong[North East Graduate Student Water Symposium], #emph[University of Massachusetts Amherst], Amherst, MA \[#emph[Talk]\].][2017]



#entry["Regional Intense Precipitation: Inferences From GCM Atmospheric Circulation Fields". #strong[Modeling Research in the Cloud], #emph[National Center for Atmospheric Research], Boulder, CO \[#emph[Poster]\].][2017]



#entry["Statistical-Dynamical Analysis of Climate Projections for Flood Infrastructure Design". #strong[Interdisciplinary Ph.D. Workshop in Sustainable Development 2017], #emph[Columbia University], New York, NY \[#emph[Talk]\].][2017]



#entry["Causes and Model Skill of the Persistent Intense Rainfall and Flooding in Paraguay during the Austral Summer 2015-2016". #strong[Workshop on Subseasonal to Seasonal Predictability of Extreme Weather and Climate], #emph[Columbia University], New York, NY \[#emph[Poster]\].][2016]



== Advisee Conference and Workshop Presentations



#entry[#advisee[Dongwook Kim]: "Evaluating the Generalization of Sentinel-1 Flood Mapping across Diverse Environments". #strong[Fall Meeting], #emph[Consortium for Enhancing Resilience and Catastrophe Modeling (CERCat)], Bethlehem, PA \[#emph[Poster]\].][2026]



#entry[#advisee[Dongwook Kim]: "Comparative Analysis of Satellite-Based Flood Mapping: A Case Study of Hurricane Harvey". #strong[39th Annual International Conference on Coastal Engineering (ICCE)], #emph[Coasts, Oceans, Ports & Rivers Institute (COPRI) - ASCE], Galveston, TX \[#emph[Talk]\].][2026]







#entry[#advisee[Yuchen Lu]: "NH13D-0410: A Hierarchical Bayesian Spatial Framework to Assess Nonstationary Rainfall Intensity, Frequency, and Duration in Texas". #strong[American Geophysical Union Fall Meeting 2025], New Orleans, LA \[#emph[Poster]\].][2025]









#entry[#advisee[Yuchen Lu]: "TxRAIN-Observational: A Hierarchical Bayesian Spatial Framework to Assess Nonstationary Rainfall Intensity, Frequency, and Duration in Texas". #strong[American Geophysical Union Fall Meeting 2024], Washington, DC \[#emph[Talk]\].][2024]





#entry[#advisee[Yuchen Lu]: "Nonstationary Extreme Precipitation Probabilities in Texas". #strong[Fall Meeting], #emph[Consortium for Enhancing Resilience and Catastrophe Modeling (CERCat)], Bethlehem, PA \[#emph[Poster]\].][2024]







#entry[#advisee[Yuchen Lu]: "Spatially Varying and Duration Dependent Covariate Model: A Hierarchical Bayesian Framework for Multi-duration Extreme Precipitation Frequency Analysis in Texas". #strong[World Environmental & Water Resources Congress 2024], #emph[Environmental & Water Resources Institute (EWRI) - ASCE], Milwaukee, WI \[#emph[Talk]\].][2024]



#entry[#advisee[Yuchen Lu]: "H21T-1602: Spatially Varying Covariate Model: A Hierarchical Bayesian Framework for Precipitation Frequency Analysis in the Gulf Coast". #strong[American Geophysical Union Fall Meeting 2023], San Francisco, CA \[#emph[Talk]\].][2023]







#entry[#advisee[Yuchen Lu]: "H42E-1333: Nonstationary GEV with Hierarchical Spatial Pooling: A Spatiotemporal Bayesian Framework for Nonstationary Extreme Precipitation Frequency Analysis in the Gulf Coast". #strong[American Geophysical Union Fall Meeting 2022], Chicago, IL \[#emph[Talk]\].][2022]


































// Teaching
= Teaching and Advising

== Courses Taught



#entry[Rice CEVE 543: #emph[Statistical-Physical Methods for Hydroclimate Extremes and Catastrophes].][Fall 2026]

#entry[Rice CEVE 421/521: #emph[Climate Risk Management].][Spring 2026]

#entry[Rice CEVE 543: #emph[Statistical-Physical Methods for Hydroclimate Extremes and Catastrophes].][Fall 2025]

#entry[Rice CEVE 101: #emph[Fundamentals of Civil and Environmental Engineering].][Fall 2024]

#entry[Rice CEVE 421/521: #emph[Climate Risk Management].][Spring 2024]

#entry[Rice CEVE 543: #emph[Data Science Methods for Climate Hazard Assessment].][Fall 2023]

#entry[Rice CEVE 421/521: #emph[Climate Risk Management].][Spring 2023]

#entry[Rice CEVE 543: #emph[Environmental Data Science].][Spring 2022]

#entry[Rice CEVE 101: #emph[Fundamentals of Civil and Environmental Engineering].][Fall 2021]



// Advising
== Current Graduate Students


#entry[Erika Adjei: #strong[M.S.] in Earth, Environmental, and Planetary Sciences, Rice University. #strong[Committee Member].][]

#entry[Andres Calvo: #strong[Ph.D.] in Civil and Environmental Engineering, Rice University. #strong[Committee Member].][2024---]

#entry[Jingyi Chen: #strong[Ph.D.] in Civil and Environmental Engineering, Rice University. #strong[Primary Advisor].][2026---]

#entry[True Furrh: #strong[Ph.D.] in Civil and Environmental Engineering, Rice University. #strong[Committee Member].][2021---]

#entry[Dongwook Kim: #strong[Ph.D.] in Civil and Environmental Engineering, Rice University. #strong[Primary Advisor].][2024---]

#entry[Sidhika Tripathee: #strong[M.S.] in Earth, Environmental, and Planetary Sciences, Rice University. #strong[Committee Member].][]

#entry[Jiayue Yin: #strong[Ph.D.] in Earth, Environmental, and Planetary Sciences, Rice University. #strong[Committee Member].][2023---]


== Past Graduate Students

#group-label[Primary Advisor]


#entry[Yuchen Lu: #strong[Ph.D.] in Civil and Environmental Engineering, Rice University. Thesis: #emph[Probabilistic Analysis of Nonstationary Hydroclimate Extremes].][2026]

#entry[Katlyn Schmeltzer: #strong[MCEE] in Civil and Environmental Engineering, Rice University. Thesis: #emph[Pre-Trained Long Short-Term Memory Network Performance for Streamflow Prediction in the Brazos River Basin].][2025]


#group-label[Committee Member]


#entry[Kelsey Murphy: #strong[Ph.D.] in Earth, Environmental, and Planetary Sciences, Rice University. Thesis: #emph[Past, Present, and Future Changes in Mississippi River Basin Hydroclimate].][2026]

#entry[Valeriia Sobolevskaia: #strong[Ph.D.] in Earth, Environmental, and Planetary Sciences, Rice University. Thesis: #emph[The seismic signatures of the hydrological cycle as observed by distributed acoustic sensing].][2026]

#entry[Karan Jakhar: #strong[Ph.D.] in Mechanical Engineering, Rice University. Thesis: #emph[Equation Discovery and Deep Learning for Geophysical Turbulence].][2025]

#entry[Kyle Ostlind: #strong[M.S.] in Civil and Environmental Engineering, Rice University. Thesis: #emph[Evaluating Runoff Response to Nature-Based Solutions under Varying Development Scenarios in Upper Cypress Creek near Houston, Texas].][2025]

#entry[John A. Baer: #strong[M.S.] in Earth, Marine and Environmental Sciences, University of North Carolina at Chapel Hill. Thesis: #emph[Quantifying Precipitation-Induced Uncertainty in Flood Hazard Assessment in a Coastal Urban Area].][2024]

#entry[Kendall Capshaw: #strong[Ph.D.] in Civil and Environmental Engineering, Rice University. Thesis: #emph[Modeling Coastal Petrochemical Infrastructure Risk, Resilience, and Cascading Community Consequences].][2024]

#entry[Xinyue Luo: #strong[Ph.D.] in Earth, Environmental, and Planetary Sciences, Rice University. Thesis: #emph[Characterizing the El Niño-Southern Oscillation and Its North American Teleconnections over the Last Millennium].][2024]

#entry[Anibal Tafur Gutierrez: #strong[Ph.D.] in Civil and Environmental Engineering, Rice University. Thesis: #emph[Methods and Tools for Risk-Informed Resilience Enhancement of Coastal Intermodal Freight Networks].][2024]

#entry[Matthew Garcia: #strong[Ph.D.] in Civil and Environmental Engineering, Rice University. Thesis: #emph[Novel Urban Floodplain Modeling Methods for Applications in Coupling Surrogate Machine Learning Methods].][2023]

#entry[Mia Peeples: #strong[M.S.] in Civil and Environmental Engineering, Rice University. Thesis: #emph[Modeling Flood Reduction of Nature-Based Channel Modifications in Houston, TX].][2023]

#entry[Xiangnan Zhou: #strong[Ph.D.] in Civil and Environmental Engineering, Rice University. Thesis: #emph[Resilience Planning for Water Distribution Systems].][2023]

#entry[Raychel Bahnick: #strong[M.S.] in Civil and Environmental Engineering, Rice University. Thesis: #emph[Assessing Land Use Change and Subsidence Impact on Inland Flooding].][2022]

#entry[Alyssa Graham: #strong[M.S.] in Civil and Environmental Engineering, Rice University. Thesis: #emph[Water Supply Vulnerability Testing and Robust Planning Analysis with Exploratory Modeling under Deep Uncertainty].][2022]

#entry[Elizabeth Hoffmann: #strong[M.S.] in Civil and Environmental Engineering, Rice University. Thesis: #emph[Mapping Dynamic Watershed Response Under Increasing Development Using HEC-RAS 2D: A Case Study of the Big Creek Watershed in Fort Bend County].][2022]

#entry[Chunshan Liu: #strong[Ph.D.] in Statistics, Rice University. Thesis: #emph[Bayesian Graphical Models for Multivariate Time Series].][2022]

#entry[Xiaoyu (Toby) Li: #strong[M.S.] in Civil and Environmental Engineering, Rice University. Thesis: #emph[Evaluating the Effects of Project Brays Mitigation Using Unsteady HEC-RAS Hydraulic Modeling: Application to Meyerland in Houston, TX].][2021]


== Undergraduate Researchers

#block(below: 1em, emph[Year indicates graduation year.])


#entry[Zain Rahman: #emph[B.S. in Computer Science], Rice University.][2027]

#entry[Kyle Olcott: #emph[B.S. in Civil and Environmental Engineering], Rice University.][2025]

#entry[Sophia Prieto: #emph[B.S. in Statistics], Rice University.][2023]

#entry[John Cook: #emph[B.S. in Civil and Environmental Engineering], Rice University.][2022]


== Teams Advised


#entry[#strong[Optimal Policy for Decentralized Wastewater Systems (DWS) while Relaxing Certainty]: Rice Computational Mathematics and Operations Research (CMOR) Senior Project.][2024-2025]

#entry[#strong[Flood Sight | Advancing Real-Time Flood Predictions for Situational Awareness]: Rice Data to Knowledge (D2K) Lab.][Spring 2025]

#entry[#strong[Predicting Streamflow for Hill Country Gauges Using a Transformer-based Model]: Rice Data to Knowledge (D2K) Lab.][Fall 2025]

// Service
= Service Activities

== Departmental Service

#entry[#strong[Member], Graduate Studies Committee.][2024---]

#entry[#strong[Member], Diversity, Equity, and Inclusion Committee.][2024]

#entry[#strong[Member], Faculty Search Committee.][2022--2023]

#entry[#strong[Member], Seminar Committee.][2022--2023]


== University Service

#entry[#strong[Member], Research Council. Ken Kennedy Institute.][2024---]

#entry[#strong[Faculty Associate]. Duncan College.][2023---]

#entry[#strong[External Search Committee Member]. Department of Earth, Environmental, and Planetary Sciences.][2022--2023]


== Professional Service

#entry[#strong[Working Group Member], Digital Twins - Beyond Physical Systems. Digital Earths Lighthouse Activity.][2026--2030]

#entry[#strong[Committee Member], Water and Society Newsletter Committee. American Geophysical Union.][2024---]

#entry[#strong[Committee Member], Environmental and Water Resources Systems (EWRS) Committee. American Society of Civil Engineers (ASCE) Environmental & Water Resources Institute (EWRI).][2021---]


== Peer Review
#entry[#strong[Journals:] AGU Advances; Climate Risk Management; Climatic Change; Communications Earth and Environment; Earth's Future; Energy Technology; Engineering Applications of Computational Fluid Mechanics; Environmental Data Science; Environmental Research Letters; Environmental Research: Climate; Geophysical Research Letters; Hydrology and Earth System Sciences; IEEE Transactions on Geoscience and Remote Sensing; Joule; Journal of Applied Meteorology and Climatology; Journal of Catastrophe Risk and Resilience; Journal of Hydrology; Journal of Water Resources Planning and Management; Machine Learning: Earth; Natural Hazards and Earth System Sciences; npj Natural Hazards; Oxford Development Studies; Water Resources Research; Water Security; Weather, Climate, and Society.][]
#entry[#strong[Funding Agencies:] Department of Energy (BER); Dutch Research Council (NWO); National Science Foundation.][]
#entry[#strong[Other:] Electric Power Research Institute (EPRI); Texas Water Development Board (TWDB).][]

== Sessions Convened

#entry[#strong[Co-Convener]. #emph[NH43C - Advances in Urban Flood Risk Assessment and Adaptation IV Poster]. #strong[American Geophysical Union Fall Meeting], New Orleans, LA.][2025]

#entry[#strong[Co-Convener]. #emph[NH43D - Advances in Urban Flood Risk Assessment and Adaptation V Poster]. #strong[American Geophysical Union Fall Meeting], New Orleans, LA.][2025]

#entry[#strong[Co-Convener]. #emph[NH41E - Interdisciplinary Advances in Catastrophe Modeling and Disaster Resilience: Bridging Science, Policy, and Practice I Poster]. #strong[American Geophysical Union Fall Meeting], New Orleans, LA.][2025]

#entry[#strong[Co-Convener]. #emph[NH43B - Interdisciplinary Advances in Catastrophe Modeling and Disaster Resilience: Bridging Science, Policy, and Practice II Oral]. #strong[American Geophysical Union Fall Meeting], New Orleans, LA.][2025]

#entry[#strong[Co-Convener]. #emph[NH31A - Advances in Urban Flood Risk Assessment and Adaptation I Oral]. #strong[American Geophysical Union Fall Meeting], New Orleans, LA.][2025]

#entry[#strong[Co-Convener]. #emph[NH32A - Advances in Urban Flood Risk Assessment and Adaptation II Oral]. #strong[American Geophysical Union Fall Meeting], New Orleans, LA.][2025]

#entry[#strong[Co-Convener]. #emph[NH33A - Advances in Urban Flood Risk Assessment and Adaptation III Oral]. #strong[American Geophysical Union Fall Meeting], New Orleans, LA.][2025]

#entry[#strong[Co-Organizer]. #emph[Nature-Based Solutions for a Resilient Gulf Coast]. #strong[Rice University], Houston, TX.][2025]

#entry[#strong[Primary Convener]. #emph[H31G - Integrating Social, Scientific, and Engineering Approaches to Identify and Address Gaps in Water Infrastructure and Household Water Security I Oral]. #strong[American Geophysical Union Fall Meeting], San Francisco, CA.][2023]

#entry[#strong[Primary Convener]. #emph[H33P - Integrating Social, Scientific, and Engineering Approaches to Identify and Address Gaps in Water Infrastructure and Household Water Security II Poster]. #strong[American Geophysical Union Fall Meeting], San Francisco, CA.][2023]

#entry[#strong[Convener]. #emph[NH41C - Hybrid Modeling and Digital Twin Systems for Flood Hazard Prediction and Risk Assessment at Different Spatial Scales]. #strong[American Geophysical Union Fall Meeting], Washington, DC.][2023]

#entry[#strong[Chair]. #emph[H44G - Water and Society: Interdisciplinary Perspectives on Hydroclimatic Forecasting for Water Resources Decision Making I Oral]. #strong[American Geophysical Union Fall Meeting], New Orleans, LA.][2021]

#entry[#strong[Chair]. #emph[H45V - Water and Society: Interdisciplinary Perspectives on Hydroclimatic Forecasting for Water Resources Decision Making III Poster]. #strong[American Geophysical Union Fall Meeting], New Orleans, LA.][2021]

#entry[#strong[Chair]. #emph[H45V - Water and Society: Interdisciplinary Perspectives on Hydroclimatic Forecasting for Water Resources Decision Making Poster Summary Session]. #strong[American Geophysical Union Fall Meeting], New Orleans, LA.][2021]

#entry[#strong[Primary Convener]. #emph[NH53 -- Emerging Needs and Approaches for Climate Services: Understanding and Developing Innovative Approaches to User-Oriented Climate Services]. #strong[American Geophysical Union Fall Meeting], San Francisco, CA.][2019]

#entry[#strong[Student Organizer]. #emph[Earth and Environmental Engineering Student Research Symposium]. #strong[Columbia University], New York, NY.][2018]

#entry[#strong[Student Organizer]. #emph[Earth and Environmental Engineering Student Research Symposium]. #strong[Columbia University], New York, NY.][2017]


== Media Highlights


#entry["Houston después de Harvey: ¿Estamos preparados para otro huracán? | Bajo la Amenaza del Golfo \#1". #strong[Telemundo Houston] \[#emph[recorded video interview]\].][2026]

#entry["Nine years after Harvey: Is Houston safer from flooding?". #strong[KPRC 2 Houston] --- Taylor Bruck \[#emph[recorded video interview]\].][2026]

#entry["Exclusive: FEMA floodmaps underestimate flood risk by over 200K, new study shows". #strong[Houston Chronicle] --- Katherine Oung and Yilun Cheng \[#emph[print]\].][2026]

#entry["FEMA elabora nuevos mapas de riesgo de inundación ¿Afectará esto tu propiedad?". #strong[Telemundo Houston] \[#emph[recorded video interview]\].][2026]

#entry["The Climate-Disaster Scores That Could Make or Break Your Home Sale". #strong[The Wall Street Journal] --- Jean Eaglesham and Nicole Friedman \[#emph[print]\].][2026]

#entry["Historic Texas Flooding". #strong[KEYE-AUS (CBS)] \[#emph[recorded video interview]\].][2025]

#entry["Houston's Morning Show". #strong[Fox26 Houston] \[#emph[live video interview]\].][2025]

#entry["Breaking down the force of water in the Texas floods". #strong[AP News] --- Michael Phillis \[#emph[print]\].][2025]

#entry["Here are some things you can do to be better prepared for major flooding". #strong[Associated Press] --- Caleigh Wells \[#emph[print]\].][2025]

#entry["ABC13-Luke Jones speaks with James Doss-Gollin, an assistant professor of Civil and Environmental Engineering at Rice University, about the key differences between flooding in Houston and central Texas.". #strong[ABC13] --- Luke Jones \[#emph[recorded video interview]\].][2025]

#entry["After deadly flooding in Central Texas, state lawmakers look to prevent similar tragedies". #strong[KVUE] --- Daniel Perreault \[#emph[recorded video interview]\].][2025]

#entry["New Flood Warning System Greenlit Shortly Before Deadly Texas Disaster". #strong[The Wall Street Journal] --- Joseph De Avila \[#emph[print]\].][2025]

#entry["Questions arise on how emergency warning systems work after Central Texas flood". #strong[ABC13] --- Tom Abrahams \[#emph[print]\].][2025]

#entry["Bajo la Amenaza del Golfo (Under the Threat of the Gulf)". #strong[Telemundo Houston] \[#emph[recorded video interview]\].][2025]

#entry["Will Texas become too hot for humans?". #strong[BBC Future] --- Sarah Griffiths \[#emph[print]\].][2023]

#entry["Climate change has sent temperatures soaring in Texas". #strong[The Texas Tribune] --- Erin Douglas, Yuriko Schumacher and Alex Ford \[#emph[print]\].][2023]

#entry["Texas could have foreseen 2021 cold-wave disaster, new study concludes". #strong[Texas Climate News] --- Bob Henson \[#emph[print]\].][2022]

#entry["Opinion: The risks of climate change are great - so are the rewards of solving it". #strong[Houston Chronicle] --- Andrew Dessler, James Doss-Gollin, and Katherine Hayhoe \[#emph[print]\].][2021]

#entry["The False Comfort of Higher Seawalls". #strong[The New Republic] --- Paola Rosa-Aquino \[#emph[print]\].][2019]

#entry["New Study Shows Promise for Long-Term Weather Forecasts in South America". #strong[State of the Planet] --- Elisabeth Gawthrop \[#emph[print]\].][2018]

// Languages
= Language Skills


#entry[#strong[English]: Native][]

#entry[#strong[Spanish]: C1][]

#entry[#strong[Portuguese]: B2 | C1 Academic Reading/Writing][]

#entry[#strong[French]: A1 | B1 Reading][]

#entry[#strong[Italian]: A1 | B1 Reading][]

// Training and Experience
= Training and Experience


#entry[#strong[Strategic Program to Accelerate Researchers in Computing (SPARC) Participant] --- #emph[Natural Hazards Engineering Research Infrastructure (NHERI) DesignSafe-CI].][2025]

#entry[#strong[Panel Fellow] --- #emph[NSF CMMI's Game Changer Academies for Advancing Research Innovation].][2021]

#entry[#strong[Visiting Graduate Researcher] --- #emph[Lamontagne Research Group, Department of Civil and Environmental Engineering, Tufts University, Medford, MA].][2019--2020]

#entry[#strong[Summer School Participant] --- #emph[Fluid Dynamics of Sustainability and the Environment, Cambridge University, Cambridge, England].][2016]

#entry[#strong[Education Policy Intern] --- #emph[Elm City Communities \/ New Haven Housing Authority, New Haven, CT].][2015]

#entry[#strong[President (2014), Design Lead (2013), Member (2012, 2015)] --- #emph[Engineers Without Borders, Yale Student Chapter, New Haven, CT].][2012--2015]

#entry[#strong[Undergraduate Research Assistant] --- #emph[Lab of Jaehong Kim, Department of Chemical and Environmental Engineering, Yale University, New Haven, CT].][2014--2015]

#entry[#strong[Visiting Undergraduate Researcher] --- #emph[Water and Climate Risk Lab, Department of Hydraulic and Environmental Engineering, Universidade Federal do Ceará, Fortaleza, Brazil].][2014]

#entry[#strong[Mechanical Design Intern] --- #emph[Slingshot Team, DEKA Research & Development, Manchester, NH].][2013]

#entry[#strong[Undergraduate Research Assistant] --- #emph[Lab of Jan Schroers, Department of Mechanical Engineering and Materials Science, Yale University, New Haven, CT].][2012]

#entry[#strong[Ikatú Agua Intern] --- #emph[Fundación Paraguaya, Asunción, Paraguay].][2012]
