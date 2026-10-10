// Teaching
= Teaching and Advising

== Courses Taught

((* for univ, course_list in data.teaching | groupby("university") *))
((* for course in course_list | sort(attribute="course") | sort(attribute="semester") | sort(attribute="year", reverse=True) *))
#entry[(((univ | trim_university | escape_typst))) (((course.course))): #emph[(((course.title | escape_typst)))].][(((course.semester))) (((course.year)))]
((* endfor *))
((* endfor *))

// Advising
== Current Graduate Students

((* for advisee in data.advising | rejectattr("degree_year") | rejectattr("degree", "equalto", "B.S.") | rejectattr("status", "equalto", "former") | sort(attribute="lastname") *))
#entry[(((advisee.firstname))) (((advisee.lastname))): #strong[(((advisee.degree)))] in (((advisee.field))), (((advisee.university))).((* if advisee.thesis_title *)) Thesis: #emph[((( advisee.thesis_title )))].((* endif *)) #strong[((* if advisee.role == "primary" *))Primary Advisor((* else *))Committee Member((* endif *))].][((* if advisee.join_year *))(((advisee.join_year)))---((* endif *))]
((* endfor *))

== Past Graduate Students

#group-label[Primary Advisor]

((* for advisee in data.advising | selectattr("degree_year") | rejectattr("degree", "equalto", "B.S.") | selectattr("role", "equalto", "primary") | sort(attribute="lastname") | sort(attribute="degree_year", reverse=True) *))
#entry[(((advisee.firstname))) (((advisee.lastname))): #strong[(((advisee.degree)))] in (((advisee.field))), (((advisee.university))).((* if advisee.thesis_title *)) Thesis: #emph[((( advisee.thesis_title )))].((* endif *))][(((advisee.degree_year)))]
((* endfor *))

#group-label[Committee Member]

((* for advisee in data.advising | selectattr("degree_year") | rejectattr("degree", "equalto", "B.S.") | selectattr("role", "equalto", "committee") | sort(attribute="lastname") | sort(attribute="degree_year", reverse=True) *))
#entry[(((advisee.firstname))) (((advisee.lastname))): #strong[(((advisee.degree)))] in (((advisee.field))), (((advisee.university))).((* if advisee.thesis_title *)) Thesis: #emph[((( advisee.thesis_title )))].((* endif *))][(((advisee.degree_year)))]
((* endfor *))

== Undergraduate Researchers

#block(below: 1em, emph[Year indicates graduation year.])

((* for advisee in data.advising | selectattr("degree", "equalto", "B.S.") | sort(attribute="degree_year", reverse=True) *))
#entry[(((advisee.firstname))) (((advisee.lastname))): #emph[(((advisee.degree))) in (((advisee.field)))], (((advisee.university))).][(((advisee.degree_year)))]
((* endfor *))

== Teams Advised

((* for team in data.teams_advised | sort(attribute="year", reverse=True) *))
#entry[#strong[(((team.project_title)))]: (((team.program))).][(((team.period)))]
((* endfor *))
