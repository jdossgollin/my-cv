// Presentations
= Presentations

== Invited Talks

((* for i in data.invited_talks | sort(attribute="date", reverse=True) *))
#entry[((* if i.title == "Panelist" *))(((i.title | escape_typst)))((* else *))"(((i.title | escape_typst)))"((* endif *)). ((* if i.event *))(((i.event | escape_typst))), ((* endif *))#strong[(((i.org | escape_typst)))]((* if i.location *)), (((i.location))).((* else *)).((* endif *))][(((i.date | extract_year)))]
((* endfor *))

== First-Author Conference and Workshop Presentations

((* for i in data.workshop_presentations | sort(attribute="date", reverse=True) *))
((* if i.presenter == "James Doss-Gollin" *))
#entry["(((i.title | escape_typst)))". #strong[(((i.event | escape_typst)))]((* if i.org *)), #emph[(((i.org | escape_typst)))]((* endif *)), (((i.location)))((* if i.format *)) \[#emph[(((i.format)))]\]((* endif *)).][(((i.date | extract_year)))]
((* endif *))
((* endfor *))

== Advisee Conference and Workshop Presentations

((* for i in data.workshop_presentations | sort(attribute="date", reverse=True) *))
((* if i.presenter != "James Doss-Gollin" *))
#entry[#advisee[(((i.presenter | escape_typst)))]: "(((i.title | escape_typst)))". #strong[(((i.event | escape_typst)))]((* if i.org *)), #emph[(((i.org | escape_typst)))]((* endif *)), (((i.location)))((* if i.format *)) \[#emph[(((i.format)))]\]((* endif *)).][(((i.date | extract_year)))]
((* endif *))
((* endfor *))
