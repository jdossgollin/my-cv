// Training and Experience
= Training and Experience

((* for i in data.training_experience | sort(attribute="end", reverse=True) *))
#entry[#strong[(((i.title | escape_typst)))] --- #emph[(((i.org | escape_typst)))].][((* if i.end == i.start *))(((i.end)))((* else *))(((i.start)))--(((i.end)))((* endif *))]
((* endfor *))
