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
	- Each pointer can be represented by $$\lceil log_2(r) \rceil$$ bits. Hence, we can represented the resulting binary code with $$ r*(log_2(r) + 1) $$ bits.
	- Considering a binary alphabet (symbols being 0 and 1), the maximum number of distinct phrases that a string of length n that can be parsed into, for a max length of at most k can be as follows:
	  
	  For k = 1, one of the possible parsing is $$0|1$$, with length $$n = 2$$
	  For k = 2, one is $$0|1|00|01|10|11$$ with length $$n = 10$$
	  For k = 3, one is $$0|1|00|01|10|11|000|001|010|011|100|101|110|111$$ with length $$n = 34$$
	  and so on.
	  
	  In general, the length of such a string is
	  $$n_k = \sum_{j=1}^{k} j2^j = (k-1)2^{k+1} + 2$$
	  
	  The number of phrases $$c$$ in such a distinct parsing of a sequence of length n is maximized when all the phrases are as short as possible.
	  If $$n = n_k$$, this occurs when all the phrases are of length $$\le k$$ and so
	  
	  $$c(n_k) \le \sum_{j=1}^{k} 2^j = 2^{k+1} - 2 \lt 2^{k+1} \le \frac{n_k}{k - 1}$$
	  
	  For an arbitrary length $$n$$, we can write $$n = n_k + \Delta$$. For the case where $$c(n)$$ is largest, the first $$n_k$$ bits can be parsed into $$c(n_k)$$ distinct phrases, containing all the phrases of length at most $$k$$, and the remaining $$\Delta$$ bits can be parsed into phrases of length $$k + 1$$.
	  So we have that for a general string of length n, the total number of phrases is at most
	  
	  $$c(n) \le \frac{n_k}{k - 1} + \frac{\Delta}{k + 1} \le \frac{n_k + \Delta}{k - 1} = \frac{n}{k - 1} \le \frac{n}{log c(n) - 3} $$
	  
	  A general bit string is compressed to around $$c(n)log c(n) + c(n)$$ bits, and substituting 
	  $$c(n) \le \frac{n}{log c(n)-3}$$ 
	  we get
	  $$c(n)log c(n) + c(n) \le n + 4c(n) = n + O(\frac{n}{log n})$$
	- So asymptotically, Lempel-Ziv doesn't compress a string of length $$n$$ to any less than $$n$$ bits, which is to be expected for a lossless algorithm. Compressing to less than $$n$$ bits would involve some lost information.
	- Let $$A$$ be the alphabet and $$p_a$$ be the probability of obtaining letter $$a \in A$$. We assume we have a random sequence of letters
	  $$x = X_1 X_2 X_3 ... X_n$$
	  where $$X_i$$ are independent letters from $$A$$ with $$Pr(X_j = a_i) = p_i$$ for all $$i, j$$
	  
	  Further, we assume $$p_i \le 1/2 $$ i.e that no letter has a large probability. For any particular sequence of letters, 
	  $$x = x_2 x_2 x_3 ... x_n$$
	  
	  we have, 
	  $$P(x) = \sum_{i=1}^{n} Px_i$$
	  
	  We note that $$-log_2 P(x)$$ is closely related to the entropy of the source i.e 
	  $$-log_2 P(x) \approx nH$$
	  
	  Now, we want to 
	  1) Bound $$P(x)$$ in terms of c(x); we want to show that messages that require many phrases (and hence are longer when encoded by LZ) occur with low probability
	  2) Relate $$P(x)$$ to the entropy
	- Suppose the string x is broken into distinct phrases 
	  $$x = y_1 y_2 ... y_{c(x)}$$
	  
	  where $$c(x)$$ is the number of phrases that x parses into.
	  
	  Rewriting $$P(X)$$,
	  
	  $$P(x) = \prod_{i=1}^{c(x)} P(y_i)$$
	  
	  Let us define $$C_j$$ for $$j \gt 0$$ to be the set of phrases
	  
	  $$\{y_i | 2^{-j-1} \lt P(y_i) \lt 2^{-j} \}$$
	  i.e, the set of phrases with probabilities between $$2^{-j-1}$$ and $$2^{-j}$$. These are distinct phrases since LZ always parses them into distinct phrases. They are also disjoint as the only case where they are not disjoint is when one case where they are not disjoint is when one phrase is a subphrase of another.
	  
	  This cannot happen for two phrases in $$C_j$$ as, if one phrase is a subphrase of another, the longer phrase will contain atleast one letter that the shorter one will not. Since the probability of each letter is at most 1/2, the two phrases differ in probability by atleast a factor of 2 and therefore cannot be in $$C_j$$.
	  
	  Therefore the phrases in $$C_j$$ are disjoint, and as a result the probabilities should sum up to at most one, i.e, 
	  $$\sum_{y_i \in C_j} P(y_i) \le 1$$
	  
	  Since each phrase in $$C_j$$ has probability atleast $$2^{-j-1}$$, and these probabilities sum up to at most 1, there can be no more than 2^{j+1} phrase in $$C_j$$.
	  
	  $$P(x) \le \prod_{j=0}^{\infty} (2^-j)^{|C_j|}$$
	  
	  Taking the log on both sides, we get
	  
	  $$-log_2 P(x) \ge \sum_{j=0}^{\infty} j*|C_j|$$
	  
	  The lower bound is given by
	  $$-log_2 P(x) \gt \sum_{j=0}^{k-1} j*2^{j+1} + k(c(x) - 2^{k+1} + 2)$$
	  $$= (k-2)2^{k+1} + 4 + k(c(x) - 2^{k+1} + 1 )$$
	  $$=(log c(x) + O(1)) 2^{k+1} + (log c(x) + O(1))(c(x) - 2^{k+1} + 2)$$
	  $$=(log c(x) + O(1))(c(x) + 1)$$
	  $$=c(x)log c(x) + O(c(x))$$
	  
	  So, 
	  $$-log_2 P(x) \ge L_\phi(x) + o(n)$$
	  
	  where $$L_\phi(x)$$ is the encoding length of $$x$$ using LZ.
	- From the above bound, and from $$nH \approx -log_2 P(x)$$, LZ compresses a sequence to $$nH + o(n)$$, asympotatically achieving the Shannon bound.
-
- References:
	- Elements of Information Theory - Thomas M. Cover, Joy A. Thomas, 1991
	- Information Theory, Inference, and Learning Algorithms - David J.C. MacKay