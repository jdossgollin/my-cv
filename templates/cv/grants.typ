// Grants and Contracts
= Sponsored Research

#block(below: 1em, emph[Amounts reflect Rice portion for collaborative grants and subawards; total amount for direct awards.])

((* for i in data.grants_contracts.proposals | selectattr("status", "in", ["active", "complete"]) | sort(attribute="end", reverse=True) | sort(attribute="start", reverse=True) *))
((* set collab_str = i.collaborators | format_collaborators(i.my_role) *))
#entry[(((i.my_role | escape_typst))), (((i.sponsor | escape_typst)))((* if i.program *)) -- ((( i.program | escape_typst)))((* endif *)). #emph[(((i.title | escape_typst)))]((* if collab_str *)) ((( collab_str | escape_typst)))((* endif *)).((* if i.number and i.number != "null" *)) No.~(((i.number | escape_typst))).((* endif *))((* if i.in_kind *)) in-kind((* elif i.total_award *))((* if i.subaward_from *)) (Full grant \$((( "{:,}".format(i.total_project | int) ))). Subaward \$((( "{:,}".format(i.total_award | int) ))))((* else *)) (\$((( "{:,}".format(i.total_award | int) ))))((* endif *))((* endif *))][(((i.start)))--(((i.end)))]
((* endfor *))
