// Awards
= Awards and Honors

((* for award in data.awards | sort(attribute="year", reverse=True) *))
#entry[#strong[(((award.title | escape_typst)))], (((award.org | escape_typst)))][(((award.year)))]
((* endfor *))

== Advisee Awards

((* for award in data.advisee_awards | sort(attribute="year", reverse=True) *))
#entry[#strong[(((award.recipient | escape_typst)))]: (((award.award | escape_typst))).][(((award.year)))]
((* endfor *))
