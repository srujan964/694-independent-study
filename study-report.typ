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

= Variable Length Codes

Variable length symbol codes are those that are mapped to one symbol at a time,
unlike $N$-length strings. These are always lossless but also means that sometimes,
the encode to slightly longer strings than the source. The key is to optimally
assign shorter codes to more probable strings and longer ones to the more probable
ones.

A binary symbol code @DavidMacKayInfoTheory[p. 92] for $X$ maps for all elements
of $A_X$ to codes in the range ${0, 1}^+$. The codeword for any given symbol $x$
is given by $c(x)$ and $l(x)$ denotes the length of the corresponding codeword.
The extended code, given by $C^+$, is a mapping from $A^+$ to ${0, 1}^+$, obtained
by concatenation and without punctation, of the corresponding codewords:
$ c^+ (x_1 x_2 ... x_N) = c(x_1) c(x_2) ... c(x_N) $

Such a code is uniquely decodeable, if under the extended code $C(X)^+$, no two
distinct strings in $A+$ have the same codeword. Furthermore, a *prefix code* is one
if no codeword is a prefix of another codeword. Prefix codes are ideal because they
remove the ambiguity during decoding; how would a decoder decide which source string
a code should be mapped to as it reads the codeword one symbol at a time?

The expected length of a symbol code for an ensemble $X$ is given by @DavidMacKayInfoTheory[p. 93],
$ L(C, X) = sum(x in X) P(x) l(x) $

== Huffman Codes

The goal is to minimize the expected length $L(C, X)$ of a symbol code. As it turns out,
this is lower bounded by the entropy $H(X)$, i.e, we can't hope to compress a
symbol code to lower than its entropy.

Huffman coding aims to produce such an optimal prefix code, and it does so by a
greedy approach and by building the binary tree in reverse, with the leaf elements first. @DavidMacKayInfoTheory[p. 99]

1. Take the two least probably elements from the alphabet. These two will be given
the longest codewords, of equal length and they will only differ in the last digit.
2. Combine them into a single symbol and repeat.

#pagebreak()

#figure(
  image("assets/huffman-1.png", height: 40%),
  caption: "A huffman tree representation of Bookkeeper",
)

#figure(
  table(
    columns: (auto, auto, auto, auto, auto),
    stroke: (x: none, y: none),
    align: horizon,
    table.hline(),
    table.header($a_i$, $p_i$, $h(p_i)$, $l_i$, $c(a_i)$),
    table.hline(),
    [B], [0.1], [3.32], [3], [001],
    [o], [0.2], [2.32], [2], [10],
    [k], [0.2], [2.32], [2], [11],
    [e], [0.3], [1.73], [2], [01],
    [p], [0.1], [3.32], [4], [0000],
    [r], [0.1], [3.32], [4], [0001],
    table.hline(),
  ),
  caption: [Code created by the Huffman algorithm],
)

There are some caveats with Huffman codes. Firstly, it requires two passes through
the source string: the first to calculate frequencies of each source symbol, and
the second to build the Huffman tree and arrive at the codewords. Secondly, depending
on the context, it can end up using more bits than is efficient for each symbol.
Symbol frequencies can vary and Huffman coding does not handle a shifting distribution well.

#pagebreak()

== Dynamic Huffman Codes


#pagebreak()


#bibliography("references.yml")
