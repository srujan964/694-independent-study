- # Huffman Code
	- There are a few properties of an optimal Huffman code:
		- given two symbols a and b in the original source, if $$p(a) \gt p(b)$$, then $$l_a \le l_b$$.
		- the two least probably symbols have the same codelength (as they are siblings), and they only differ by 1 bit.
	- Assume that these two symbols a and b with the least probabilities, *do not* have equal codelengths in any optimal symbol code. Consider a rival code in which these symbols have unequal lengths $$l_a \lt l_b$$, one that we can assume to be a prefix code.
	- In this other code, there must be another symbol c, whose probability $$p_c \gt p_a$$ and length is greater than equal to that of b. This is because b occurs less frequently than a and hence must have another symbol who's codeword length is equal to or greater than its own, owing to the fact that the code must have two codewords at max length.
	- If we swap the codewords for a and c such that a is encoded with the longer codeword that was c's, and c which is more probable than a, is encoded with the shorter codeword, we get a code that has a smaller expected code length (since the symbol with the longer code occurs less frequently than that which has the shorter code)
	  
	  i.e the expected length reduces by $$(p_a - p_c)(l_c - l_a)$$. This makes the rival code unoptimal.
	- Hence, assigning equal length codes to the the least frequently occurring symbols leads to an optimal prefix code.
- # Lempel Ziv
	- Let the number of phrases stored in the dictionary during LZ encoding is of a sequence of length $$n$$ be $$r$$.
	- The encoded string consists of $$r$$ pairs of pointers to the an occurrence of a prefix of the current phrase, and a new bit that is the tail of the phase itself.
	- Each pointer can be represented by $$\lceil log_2(r) \rceil$$ bits. Hence, we can represented the resulting binary code with $$r*(log_2(r) + 1)$$ bits.