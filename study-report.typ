#let double-spacing = 1.5em;

#set document(
  title: "Independent Study Report
  Data Compression",
  author: "Srujan Gangoor",
  date: none,
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
  size: 10pt,
)

#set math.equation(numbering: "1")

#set bibliography(
  style: "ieee",
)

// Title page formatting

#set par(
  leading: double-spacing,
  spacing: double-spacing,
)

#for i in range(6) {
  [~] + parbreak()
}


#show title: set align(center)
#show title: set block(below: double-spacing)

#title[Data Compression]
#parbreak()

#align(center)[
  Srujan Gangoor

  Dept. of Computer Science, Rutgers University, Camden

  56:198:694 - Independent Study

  Dr. Sunil Shende

  December 19, 2025
]

#pagebreak()

#set par(
  first-line-indent: (
    amount: 0.5in,
    all: true,
  ),
  leading: double-spacing,
)

#show heading: set block(
  above: double-spacing,
  below: double-spacing,
)

#set heading(
  numbering: "1.a)",
)

= Introduction

My choice of this field for an independent study was, in part, inspired by a post
@discord on Discord's engineering blog, a platform that I use on a daily basis
for the past 5 years. Part of the reason why their savings on web traffic bandwidth
costs just from switching from zlib to zstd surprised me is that I knew little
about how data compression techniques worked, despite their ubiquitous use in
archiving, software delivery, version control systems, among many others.

Modern lossless compression algorithms such as zstd @zstd and lz4 @lz4 are flexible and offer
multiple tradeoffs between speed of compression/decompression and compression ratios.
They all have their roots in information theory.

= Information Content and Entropy

Compression problems are often thought of as guessing games @DavidMacKayInfoTheory[p. 70].
This analogy sees the compressor (or the decompressor) as a participant in a guessing game
asking binary yes/no questions to guess the next symbol in a source. This naturally
lends to the notion of encoding the answer as a bit that can take on the values 0 (for the
answer yes) or 1 (conversely, no).

In more general terms, this is defined as the Shannon information content of a random variable
$x$ taking on an outcome $a_i$. Using the definition of an ensemble $X$ as a triple $(x, A_X, P_X)$,
where the outcome $x$ is the value of a random variable that can take on a set of values
$A_X = (a_1, a_2, ... a_(n-1))$, each of them having a probability from $P_X = (p_1, p_2, ... p_(n-1))$,
the Shannon information content of an outcome is given by,
$ h(x = a_i) = log_2(1 / p_i) $

Additionally, the average Shannon information content of the entire ensemble is given
by the entropy of $X$,
$ H(X) = sum_(i) p_i log_2(1 / p_i) $

The information content of variables can help shed light on the entire source given
its probability distribution. Not every source has a uniform distribution --- the
English alphabet has an uneven distribution with 'e' being the most used letter
in texts and dictionaries. The information content for the random variable taking
on the letter 'e' would be quite low, as we cannot guess the next character with
a higher degree of certainty than if the word started with a rare letter such as 'z'.

Lossless compressors can only compress data so much without losing information.
This is because while such compressors can shorten some string of symbols, it *must*
also lengthen some others. An optimally designed compressor is one that reduces the
probability of a source string being lengthened after compression.

== Typicality

A typical string is defined as one with $N$ symbols, each with probability $p_i$.
It contains $p_i N$ occurrences of each symbol, given the probability of the typical string
as follows @DavidMacKayInfoTheory[pp. 79-80]:
$ P(x)_("typ") = P(x_1)P(x_2)...P(x_N) tilde.eq p_1^((p_1 N)) p_2^((p_2 N)) ... p_I^((p_I N)) $
which leads to the information content of a typical string:
$ log_2(1 / P(X)) tilde.eq N sum(i) p_i log_2(1 / p_i) = N H $

A typical set, defined using the above observation, is one which contains elements
whose probabilities are close to $2^(-N H)$. Additionally, the Asymptotic Equipartition
principle @DavidMacKayInfoTheory[p. 80] states that, for a sufficiently large
distribution of i.i.d random variables, the outcome is almost certain to be one
from the typical set.

This principle is similar to the weak law of large numbers which states that for
a sampling, the sample mean converges in probability to the expected value of the
distribution as the number of samples collected increases.

== Shannon's Source Coding Theorem

Shannon's source coding theorem states that for N i.i.d random variables with
entropy $H(X)$ can be compressed into more than $N H(X)$ bits with negligible
risk of information loss, as $N arrow 0$. In other words, it is virtually certain
that information will be lost if they are compressed to fewer that $N H$ bits @DavidMacKayInfoTheory[p. 80].

#pagebreak()

#bibliography("references.yml")
