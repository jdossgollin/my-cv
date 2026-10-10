// Media Coverage
= Media Highlights

((* for i in data.media_coverage | sort(attribute="date", reverse=True) *))
#entry["(((i.title | escape_typst)))." #strong[(((i.publication | escape_typst)))]((* if i.author *)) --- (((i.author | escape_typst)))((* endif *))((* if i.format *)) \[#emph[((( i.format | lower )))]\]((* endif *)).][(((i.date | extract_year)))]
((* endfor *))
