// Education
= Education

((* for univ, degree_list in data.education | groupby("university") *))
#institution[(((univ | escape_typst)))]
((* for deg in degree_list | sort(attribute="year", reverse=True) *))
#entry(indent: 2em, hang: 0pt)[#emph[(((deg.degree | escape_typst))) in ((( deg.subject | escape_typst )))]][((( deg.year )))]
((* endfor *))
((* endfor *))
