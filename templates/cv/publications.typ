// Publications
= Publications

#text(fill: rice-blue, weight: "bold")[#super(typographic: false)[†] denotes Rice advisee publication].
#link("https://scholar.google.com/citations?user=(((data.person.googlescholar)))")[Google Scholar #icon-scholar]((* if data.person.scholar_metrics *)) #emph[citations]: (((data.person.scholar_metrics.citations))), #emph[h-index]: (((data.person.scholar_metrics.h_index))), #emph[i10-index]: (((data.person.scholar_metrics.i10_index))).((* endif *))

((* macro authors(paper) *))((* for a in paper.authors *))((* if a.role == "self" *))#strong[(((a.name | escape_typst)))]((* elif a.role == "advisee" *))#advisee[(((a.name | escape_typst)))]((* else *))(((a.name | escape_typst)))((* endif *))((* if not loop.last *))((* if loop.length == 2 *)) and ((* elif loop.revindex == 2 *)), and ((* else *)), ((* endif *))((* endif *))((* endfor *))((* endmacro *))
((* macro link_out(paper) *))((* if paper.doi *)) DOI: #mono(link("https://doi.org/(((paper.doi)))")[(((paper.doi | escape_typst)))])((* elif paper.url *)) URL: #mono(link("(((paper.url)))")[(((paper.url | escape_typst)))])((* endif *))((* endmacro *))

== In Prep. / Under Review

((* for p in data.papers.preprints *))
#entry[\[(((p.number)))\] (((authors(p)))): #emph[(((p.title | escape_typst)))].((* if p.venue *)) (((p.venue | escape_typst))).((* endif *))(((link_out(p))))][---]
((* endfor *))

== Journal Articles

((* for p in data.papers.articles *))
#entry[\[(((p.number)))\] (((authors(p)))): "(((p.title | escape_typst)))". #emph[(((p.venue | escape_typst)))].(((link_out(p))))][(((p.year)))]
((* endfor *))

== Peer-Reviewed Conference Papers

((* for p in data.papers.conference *))
#entry[\[(((p.number)))\] (((authors(p)))): "(((p.title | escape_typst)))". #emph[(((p.venue | escape_typst)))].(((link_out(p))))][(((p.year)))]
((* endfor *))
