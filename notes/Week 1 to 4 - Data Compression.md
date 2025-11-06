- # Some basics
	- ## Entropy
		- The Shannon information content of an outcome $$x$$ is defined to be
		  $$h(x) = log_2(1/p(x))$$
		  
		  measured in bits.
		- The entropy of an ensemble $$X$$ is defined to be the average Shannon information content of an outcome.
		  
		  $$H(X) = \sum_{x \in A_x} P(x) log_2(1/P(x))$$
		- Sometimes, $$H(X)$$ is also written as $$H(p)$$ where $$p$$ is the vector $$(p_1, p_2, ...p_I)$$.
	- ## Variable Length Codes
		- A binary symbol code maps for all the elements of X to codes in the range $$\{0,1\}^+$$
		- The extended code $$C^+$$ is a mapping from $$A^+$$ to $$\{0, 1\}^+$$ obtained by concatenation, without punctuation, of the corresponding codewords:
			- $$
			  c^+(x_1x_2...x_N) = c(x_1)c(x_2)...c(x_N)
			  $$
		- A code $$C(X)$$ is **uniquely decodable** if, under the extended code $$C(X)^+$$, no two distinct strings have the same encoding.
		- Such a code, say C, has a few basic requirements:
			- any encoded string must have a unique encoding
			- the symbol code must be easy to decode
			- the code should achieve as much compression as possible
		- Such a code is a prefix code if no codeword is a prefix of another codeword.
		- Expected Length $$L(C, X)$$ of a symbol code $$C$$ for $$X$$ is given by:
			- $$L(C, X) = \sum_{x \in X} P(x)l(x)$$
			  where the length of each codeword is given by $$l(x)$$
	- ## Prefix Codes
		- A code in which no codeword is a prefix of another codeword (disambiguity).
		- Kraft's inequality:
			- For any uniquely decodeable code $$C(X)$$ over the binary alphabet $$\{0, 1\}^+$$, the codeword length must satisfy:
			  
			  $$\sum_{i = 1}^{I} 2^{-l_i} \le 1,$$
			  
			  where $$I = |A_X|$$
			- If a uniquely decodeable code satisfies the Kraft inequality with equality, it is called a ***complete*** code.
- # Huffman coding
	- Q: how to find an optimal prefix code, i.e, one that minimizes the expected code length $$L(C, X)$$ ?
	- Huffman coding algorithm:
		- **Take the two least probable symbols in the alphabet. These two symbols will be given the longest codewords, which will have equal length and differ in only the last digit.**
		  logseq.order-list-type:: number
		- **Combine these two symbols into a single symbol, and repeat.**
		  logseq.order-list-type:: number
	- ### Caveats
		- Is it very practical? Not for a couple of reasons:
			- It requires knowing the frequencies of each symbol in the given source beforehand. Compressing a source would then require two passes, one to calculate frequencies, and the second to actually build the Huffman tree and arrive at the codewords.
			- Depending on the context, it can end up using more bits than is efficient for each symbol. Certain strings are more probably in the English source but the Huffman code would still result with atleast one bit per symbol, while a more efficient encoding technique would be able to encode the entire string in fewer bits.
	- ## Arithmetic Coding
		- Using an interval $$[0,1)$$, an arithmetic coding encoder divides this interval into sub-intervals, for each symbol that it reads from the string to be encoded, proportional to the probability of that symbol occurring next in the string. Any fractional value in the final interval can be chosen to represent the encoded message.
		- Unlike Huffman codes which map each symbol to a codeword, arithmetic codes encode the entire string as a binary fraction.
		- The binary fraction is a pointer to a sub-interval that results from narrowing the range $$[0,1)$$ by using the probabilities of each possible symbol in the string.
- # Lempel-Ziv
	- The basic principle behind Lempel-Ziv is to replace a substring occurring in the given string to encode by a pointer to an earlier occurrence of that substring.
	- This requires the encoder to first parse the string into unique substrings that is the shortest and not seen earlier.
	- Each new substring it finds is only 1 extra bit, so it can be encoded by a reference (a pointer to the index) of the prefix substring followed by the extra bit at the end.
	- ### Caveats
		- However, this method can end up transmitting more bits than is necessary. We know that each pointer reference can be followed by only two possible values (a 0 and a 1). Once we have one occurrence of a pointer reference with a new bit, we know for sure what the next occurrence of that pointer reference will be followed by.
		- Additionally, once both possible variations have occurred, the pointer reference itself will never be used again, so this particular codeword can be dropped from the dictionary entirely.