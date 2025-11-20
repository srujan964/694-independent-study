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
	-
- ### Arithmetic Coding
	- Let the source alphabet be $$A_X = \{a_1, ..., a_I\}$$, and let the Ith symbol $$a_I$$ have the special meaning "end of transmission". The source sequence may look like $$x_1 x_2 .... x_n ...$$, and may not necessarily be i.i.d symbols. 
	  
	  We also assume a prior probability distribution of the source sequence has been calculated/provided, $$P(x_n = a_i | x_1, ..., x_{n-1})$$. The receiver also has an identical probability distribution.
	  
	  A binary transmission defines an interval within the real line from 0 to 1. Now, we can divide the real line [0, 1) into $$I$$ intervals for lengths equal to the probabilities $$P(x_1 = a_i)$$. 
	  
	  We may then take each interval $$a_i$$ and subdivide it into intervals denoted $$a_i a_1, a_i a_2..., a_i a_I$$, such that the lengths of $$a_i a_j$$ is proportional to $$P(x_2= a_j | x_1 = a_i)$$
	  
	  Iterating this process, the interval [0, 1) can be divided into a sequence of intervals corresponding to all possible length strings $$x_1 x_2 ... x_N$$ such that the length of an interval is equal to the probability of the string from the given distribution.
	- ```
	  u := 0.0
	  v := 0.0
	  p := v - u
	  for n = 1 to N {
	  	v := u + p * R_n(x_n | x_1, ... x_n)
	      y := u + p * Q_n(x_n | x_1, ... x_n)
	      p := v - u
	  }
	  ```
	- The cumulative probabilities $$Q_n$$ and $$R_n$$ are given by:
		- $$Q_n(a_i | x_1, ... ,x_{n-1}) = \sum_{i^` = 1}^{i - 1} P(x_n = a_{i^`} | x_1, ..., x_{n-1})$$
		- $$R_n(a_i | x_1, ..., x_{n-1}) = \sum_{i^` = 1}^{i} P(x_n = a_{i^`} | x_1, ..., x_{n-1})$$