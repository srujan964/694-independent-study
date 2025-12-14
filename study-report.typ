#let double-spacing = 1.5em;

#set document(
  title: "Independent Study Report
  Data Compression",
  author: "Srujan Gangoor",
  date: none
)

#set page(
  paper: "us-letter",
  numbering: "1",
  number-align: top + right,
  margin: 1in,
  header: auto,
)

#set text(
  font: "New Computer Modern",
  size: 10pt
)

#set par(
  leading: double-spacing,
  spacing: double-spacing
)

#set math.equation(numbering: "1")

#set bibliography(
  style: "apa"
)

#show title: set text(size: 14pt)
#show title: set align(center)
#show title: set block(below: 1.5em)

#align(alignment.horizon)[
  #title[Data Compression]
  #parbreak()

  #align(center)[
    Srujan Gangoor

    Dept. of Computer Science, Rutgers University - Camden

    198:694 Independent Study

    Dr. Sunil Shende

    December 19, 2025
  ]
]
