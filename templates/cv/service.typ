// Service
= Service Activities

== Departmental Service
((* for service in data.department_service | sort(attribute="start_year", reverse=True) *))
#entry[#strong[(((service.role | escape_typst)))]((* if service.program *)), (((service.program | escape_typst)))((* endif *))((* if service.description *)) (((service.description | escape_typst)))((* endif *)).][((* if service.end_year *))((* if service.start_year == service.end_year *))(((service.start_year)))((* else *))(((service.start_year)))--(((service.end_year)))((* endif *))((* else *))(((service.start_year)))---((* endif *))]
((* endfor *))

== University Service
((* for service in data.university_service | sort(attribute="start_year", reverse=True) *))
#entry[#strong[(((service.role | escape_typst)))]((* if service.program *)), (((service.program | escape_typst)))((* endif *)). (((service.organization | escape_typst)))((* if service.description *)). (((service.description | escape_typst)))((* endif *)).][((* if service.end_year *))((* if service.start_year == service.end_year *))(((service.start_year)))((* else *))(((service.start_year)))--(((service.end_year)))((* endif *))((* else *))(((service.start_year)))---((* endif *))]
((* endfor *))

== Professional Service
((* for service in data.professional_service | sort(attribute="start_year", reverse=True) *))
#entry[#strong[(((service.role | escape_typst)))]((* if service.program *)), (((service.program | escape_typst)))((* endif *)). (((service.organization | escape_typst)))((* if service.description *)). (((service.description | escape_typst)))((* endif *)).][((* if service.end_year *))((* if service.start_year == service.end_year *))(((service.start_year)))((* else *))(((service.start_year)))--(((service.end_year)))((* endif *))((* else *))(((service.start_year)))---((* endif *))]
((* endfor *))

== Peer Review
#entry[#strong[Journals:] ((* for i in data.review_activities | selectattr("type", "equalto", "journal") | sort(attribute="name") *))(((i.name | escape_typst)))((* if not loop.last *)); ((* endif *))((* endfor *)).][]
#entry[#strong[Funding Agencies:] ((* for i in data.review_activities | selectattr("type", "equalto", "funding") | sort(attribute="name") *))(((i.name | escape_typst)))((* if not loop.last *)); ((* endif *))((* endfor *)).][]
#entry[#strong[Other:] ((* for i in data.review_activities | selectattr("type", "equalto", "external") | sort(attribute="name") *))(((i.name | escape_typst)))((* if not loop.last *)); ((* endif *))((* endfor *)).][]

== Sessions Convened
((* for i in data.sessions_organized | sort(attribute="date", reverse=True) *))
#entry[#strong[(((i.role)))]. #emph[(((i.session | escape_typst)))]. #strong[(((i.event | escape_typst)))], (((i.location))).][(((i.date | extract_year)))]
((* endfor *))

== Media Highlights

((* for i in data.media_coverage | sort(attribute="date", reverse=True) *))
#entry["(((i.title | escape_typst)))". #strong[(((i.publication | escape_typst)))]((* if i.author *)) --- (((i.author | escape_typst)))((* endif *))((* if i.format *)) \[#emph[((( i.format | lower )))]\]((* endif *)).][(((i.date | extract_year)))]
((* endfor *))
