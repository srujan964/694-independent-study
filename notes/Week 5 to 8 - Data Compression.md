- ### Typical Set
	- Consider an arbitrary ensemble $$X$$ with alphabet $$A_X$$. A long string of $$N$$ symbols will usually contain about $$p1N$$ occurrences of the first symbol, $$p2N$$ occurrences of the second symbol and so on. Hence the probability of this string is roughly,
	  
	  $$P(x)_typ = P(x1)P(x2)P(x3)...P(xN) \simeq p1^{(p1N)}p2^{(p2N)}p3^{(p3N)}...pI^{(pIN)}$$
	  
	  so that the information content of a typical string is
	  
	  $$log \frac{1}{P(x)} \simeq N \sum_{i} p_i log \frac{i}{p_i} $$
	  
	  So the random var. $$log 1 / P(x)$$, which is the information content of $$x$$, is very likely to tbe close in value to $$N H$$.
	- We define typical elements of $$A_X^N$$ to be those elements that have probability close to $$2^{-N H}$$.
- ### Shannon's source coding theorem
	- N i.i.d random variables, each with entropy $$H(X)$$ can be compressed into more than $$N H(X)$$ bits with negligible risk of information loss, as $$N \to \infty$$. Conversely, if they are compressed into fewer than $$N H(X)$$ bits, it is virtually certain that information will be lost.
	- In other words, lossless compression can compress a sequence $$X$$ of length $$N$$ to no less than $$N H(X)$$ bits.