// Appointments
= Appointments

((* set ns = namespace(prev_org='') *))
((* for pos in data.appointments | sort(attribute="sort_order") *))
((* if pos.organization != ns.prev_org *))
#institution[(((pos.organization | escape_typst)))]
((* set ns.prev_org = pos.organization *))
((* endif *))
#entry(indent: 2em, hang: 0pt)[#emph[(((pos.role | escape_typst)))]((* if pos.dept *)), (((pos.dept | escape_typst)))((* endif *))][((* if pos.end *))((* if pos.start == pos.end *))((( pos.start )))((* else *))((( pos.start )))--((( pos.end )))((* endif *))((* else *))((( pos.start )))---((* endif *))]
((* endfor *))
