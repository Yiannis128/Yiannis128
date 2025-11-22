---
title: "Formal Methods of Language Modelling"
date: 2024-10-25T13:55:24+01:00
math: true
draft: false
tags:
  - PhD
  - Notes
---

The following are notes that have been written for the paper:  	[arXiv:2311.04329](https://arxiv.org/abs/2311.04329). I will update the article with future notes. Please let me know if you find any mistakes, as there are probably many.

_Please cite if you plan on using this text, or the source material._

## Chapter 3.2

| **Symbol**       | **Page** | **Meaning**             |
|--------------|------|---------------------|
| $$p_\theta$$ | 61   | Current model |
| $$p_{\theta^\star}$$ | | Optimal model (can never be known) |
| $$\widetilde{p_{\theta^\star}}$$ | 62 | Optimal model approximation from corpus $\mathcal{D}$ |
| $$p_{\hat{\theta}}$$ | | Estimated (after minimizing loss) model |
| $$p_M$$      | | Model               |
| $$\mathcal{l}(\theta^\star,\theta)$$ | | Loss function (outputs similarity between two distributions, in this case it takes the parameters of the distribution). **Lower==Good** |
| $$H(\widetilde{p_{\theta^\star}}, p_\theta)$$ | 63 | Cross Entropy function (applied loss function) |
| $$\mathcal{Y}$$ | | Support of a distribution (all domain values that will yield a non-zero probability of a distribution) *Note (Edoardo): At (3.56), we sum over the elements of this function, however, this is not necessary, we could have summed over all the values of the distribution.* |
| $$\delta_{x'}$$ | | Kronecker Delta |
| $$L(\theta)$$ | 64 | Likelihood of the corpus $\mathcal{D}$ under the distribution $p_\theta$. In practice we work with the log likelihood $\mathcal{L}(\theta)$ because it is convex and more numerically stable. **Finding parameters that maximize the log-likelihood is equivalent to finding those that minimize the cross-entropy.** |
| $$\hat{\theta}_{\text{MLE}}$$ | | Maximum likeihood function (another measure of similarity to a dataset $\mathcal{D}$). **Bigger==good.** |
| $$\mathcal{\hat{y}}_{\lt t}$$ | 66 | Model prediction from previous timestep during training |
| $$\mathcal{D}_{\text{train}} \text{ and } \mathcal{D}_{\text{test}}$$ | 68 | The data $\mathcal{D}$ split into two sets, the training set, used during training of the model, and the test set, used during model evaluation |
| $$\mathcal{D}_{\text{val}}$$ |  | Subset of the test data set used during training to evaluate if the model has started to overfit, in which case early stopping will occur |
| $$\mathbf{\triangledown}_{\theta_\mathcal{s}}\mathcal{l}(\theta_\mathcal{S})$$ | 69 | The gradient of the objective with respect to the current model parameters |
| $$S\text{ or } T$$  | | Number of steps during gradient descent |
| $$\eta$$ | | Learning rate schedule (array) |
| $$\mathcal{l_2}$$ | 72 | L2 regularization |


| **Name** | **Page** |
| -------- | -------- |
| Mean-seaking | 65 |
| Exposure bias| 66 |
| Data leakage | 68 |
| Xavier Init | 71 |
| Grokking | |
| Label smoothing | 72 |


Read Coding theory to understand cross entropy and the measuring of difference between two distributions.

Model $p_{LM}$ can be expressed as $p_{\theta^\star}$ in parameterized form for certain unknown parameters $\theta^\star\in\Theta^\star$.

$$\xrightarrow[p_\theta \rightarrow p_{\hat{\theta}} \rightarrow p_{\theta^\star}]{\text{Towards Optimal Model}}$$ But we can _never_ reach $p_{\theta^\star}$.


## Chapter 4.1

### Finite-State Automata

| **Symbol**       | **Page** | **Meaning**             |
| --- |  ---| --- |
| $$\text{FSA or } \mathcal{A}$$ | 76 | Finite state automata |
| $$\Sigma$$ | | Alphabet |
| $$Q$$ | | Finite set of states |
| $$I$$ | | Set of initial states |
| $$F$$ | | Set of final or accepting states |
| $$\delta$$ | | Finite multiset, elements of this are the transitions |
| $$\mathcal{q}$$ | 77 | Represents a state in the FSA, the state does not represent the context, the context is represented by the transitions |
| $$\mathcal{a}$$ | | Individual transition from one state $q_1$ to $q_2$. The label of this transition corresponds to the input symbol at the current context |
| $$\epsilon$$ | | Empty transition, this allows the transition from one state to another without consuming a transition. |
| $$L(\mathcal{A})$$ | 78 | Definition of language that belongs to a FSA $\mathcal{A}$ |

### Weighted Finite-State Automata

An extension of FSA

| **Symbol**       | **Page** | **Meaning**             |
| --- |  ---| --- |
| $$\delta \subseteq Q \times(\Sigma \cup \{e\}) \times \mathbb{R} \times Q$$ | 79 | A finite multi-set of transitions |
| $$\lambda $$ | | Weight transition functions for WFSA: initial weight |
| $$ \rho $$ | | Weight transition functions for WFSA: final weight |
| $$I$$ | 80 | Initial states are states given non-zero initial weight |
| $$F$$ | 80 | Initial states are states given non-zero final weight |
| $$ \omega ( q \xrightarrow[]{a/w} q' ) $$ | | Weighted transition $w$ |
| $$T^{(a)}$$ | | Symbol specific transition matrix for $a$ labelled transitions |
| $$T$$ | | Full transition matrix which is the sum of all the alphabet symbols, $\Sigma$ |
| $$\pi$$ | 81 | Path is an element consisting of consequtive transitions $\delta^\star$ |
| $$p(\pi) \text{ and } \eta(\pi)$$ | | Origin and destination of a path |
| $$s(\pi)$$ | | Yield of the path, is the concatenation of the input symbols. Equivalent to $y$ |
| $$\Pi$$ | | The set of paths |
| $$\Pi(\mathcal{A})$$ | 82 | The set of paths in automaton $\mathcal{A}$ |
| $$\Pi(\mathcal{A}, \mathbf{y})$$ | | The set of paths in automaton $\mathcal{A}$ that will yield $\mathbf{y}$ |
| $$\Pi(\mathcal{A}, q, q')$$ | | The set of all paths of automaton $\mathcal{A}$ from state $q$ to state $q'$ |
| $$\mathbf{w}_I$$ | | Inner path weight |
| $$\mathbf{w}$$ | | Path weight |
| $$\mathcal{A}(y)$$ | | **Stringsum/stringweight/acceptance weight** of a string $y$ under WFSA $\mathcal{A}$ is the sum of the weights of a path that yield $y$ |
| $$L(\mathcal{A})$$ | 83 | The weighted language of $\mathcal{A}$ |
| $$L$$ | | Weighted regular language L is a weighted regular language if there exists a WFSA $\mathcal{A}$ such that $L=L(\mathcal{A})$ |
| $$Z(\mathcal{A},q) \text{ or } \beta(q)$$ | | **State Specific Allsum/Backwards Values** of the state $q$ |
| $$Z(\mathcal{A})$$ | | The **Allsum**  |
| $$\mathcal{p_A}(\mathbf(y)) \stackrel{def}{=} \mathcal{A}(\mathbf(y))$$ | 86 | The stringsum of a string $y$ in a probabilistic FSM is the probability of a string $y$ |
| $$p_\mathcal{A}(\mathbf{y}) \stackrel{def}{=} {\mathcal{A}(y) \over Z(\mathcal{A})}$$ | | String probability in a General Weighted FSA that is tight as it normalizes the probabilities. |
| $$p_{LM_\mathcal{A}}(y) \stackrel{def}{=} p_\mathcal{A}(y)$$ | 87 | Language model induced by $\mathcal{A}$ as the probability distribution over $\Sigma^*$ |
| $$T$$ | 88 | Transition matrix of automaton $\mathcal{A}$. Where $T_{ij}$ represents a transition weight between state $i$ and state $j$ |
| $$T^0 \text{ or } I$$ | | The identity matrix. Elements are all 0, except for the diagonal where $i = j$ in which case it is 1 |
| $$\mathcal{G}$$ | | Weighted directed graph |
| $$T^d$$ | | Allsum of all paths of length exactly $d$ |
| $$T^{\le d}$$ | | Allsum of all paths of length at most $d$ |
| $$T^*$$ | 88-89 | Pairwise pathsums over all possible paths. Including infinite paths. Similar to the matrix of the Geometric Sum. If there is an inverse of $I-T$, then $T^*=(I-T)^{-1}$ |
| $$\mathcal{A}_L$$ | 91 | Tight probabilistic FSA. Contains same transitions as $\mathcal{A}$ but re-weighted |
| $$\lambda_{\mathcal{A}_L}$$ | | Tight probabilistic FSA Lambda function |
| $$\rho_{\mathcal{A}_L}$$ | | Tight probabilistic FSA Rho function |
| $$\mathcal{w}_{\mathcal{A}_L}$$ | | Tight transitions for the probabilistic FSA |
| $$p_\mathcal{A}(\pi)$$ | 92 | Finally: Probability of a path |
| $$f^{\delta}_{\theta} \text{ } f^{\lambda}_{\theta} \text{ } f^{\rho}_{\theta}$$ | 92 | Score function for a parametarized model used during training, one function for transitions, initial and final weights respectively |
| $$\mathcal{A}_\theta$$ | | Parametarized automata |
| $$\delta_\theta \text{ } \lambda_\theta \text{ } \rho_\theta$$ | | Parameterized transition/starting/finish weights |
| $$\hat{p}^{\mathcal{A}_\theta}_{\text{GN}}$$ | 93 | Globally normalized energy function which makes the Parametric FSA globally normalized |
| $$\rho_s(M)$$ | 95 | Spectral radius of a matrix $M$ |
| $$T'$$ | | Transition sum matrix |
| $$\lvert\lvert A \rvert\rvert_\infty$$ | | Infinity matrix norm |
| $$\Lambda(.)$$ | | The set of eigen values of a matrix where "." is the row |
| $$y^{t-1}_{t-n+1}$$ | 97 | The context of $y_t$ |
| $$SL_n$$ | 101 | Strictly n-local language |
| $$SL$$ | | Strictly local language |

#### Transitions

* Transition weight: Written on the edge after the symbol $a \equiv y$ separated by a \\.
* Final weight: Written in the node, after the state number and \\.
* Initial weight: Written on the arrow that points to the starting state.

**Inner Path Weight**: Just the transitions from states

**Full Path Weight**: Initial weight of origin * Final weight of destination node * inner path weight

**Accessible States**: State $q$ can be accessed from an initial state $q_i | \lambda(q_i) \ne 0$

**Co-Accessible States**: State $q$ can access a state $q_\phi | \rho(q_\phi) \ne 0$

### Probabilistic Finite State Automata (PFSA) (pg. 84)

$$\sum_{q \in Q}{\lambda(q)} = 1$$

For all $q \in Q$ and all transitions it holds that:

$$\lambda(q) \ge 0$$

$$\rho(q) \ge 0$$

$$\mathcal{w} \ge 0$$

$$\sum_{q\xrightarrow{a/\mathcal{w}}{q'}}{\mathcal{w}+\rho(q) = 1}$$

## Chapter 4.2

| **Symbol**       | **Page** | **Meaning**             |
| --- |  ---| --- |
| $$\mathcal{G}\Sigma\mathcal{N}S\mathcal{P}$$ | 108 | Context-free grammar (CFG). Alphabet of terminating symbols. Non empty set of non-terminal symbols. Designated start non terminal symbol. Set of production rules. |
| $$p$$ | | A rule |
| $$Y$$ | | Production rule, it is the left hand element of the rule. The whole structure is: $p = (Y\rightarrow a$) |
| $$X\stackrel{*}{\Rightarrow}_\mathcal{G}A$$ | 110 | For context-free grammar $\mathcal{G}$, $A$ can be derived from $X$ |
| $$L(\mathcal{G})$$ | | The language generated by $\mathcal{G}$ |
| $$d$$ | 110 | Derivation tree |
| $$s(d)$$ | | String yielded by derivation tree |
| $$\mathcal{D_G}(y)$$ | 111 | The string derivation set |
| Unambiguous | | If the string associated with a grammar can only be associated with one derivation tree |
| $$\mathcal{D_G}$$ | 112 | Derivation set of a grammar (of the language essentially) |
| $$(X\rightarrow \mathscr{a}) \in d$$ | | Refers to a specific production rule in a tree |
| $$D(k)$$ | 113 | Dych-k languages where k is the well-nested brackets of k-types |
| $$\mathbf{w}(d)$$ | 117 | The weight of a single derivation tree |
| $$\mathcal{G}(y)$$ | 118 | The stringsum of a string $y$ |
| $$Z(\mathcal{G}. Y)$$ | | The allsum for a non-terminal Y in a grammar $\mathcal{G}$ |
| $$Z(\mathcal{G})$$ | | The allsum for a terminal $a \in \Sigma \cup \epsilon$ equals to 1 |
| $$Z(\mathcal{G})=Z(\mathcal{G}, S)$$ | | The allsum of a WCFG, this could be 1 if pruned, and probabilistic, and normalized (I think) |
| $$p_\mathcal{G}(y)$$ | 119 | The stringsum/probability of string $y$ in a PCFG |
| $$p_{LM_\mathcal{G}}=p_\mathcal{G}(y)$$ | 120 | The language model induced by WCFG as a probability distribution over $\Sigma^*$ |
| $$\mathcal{\gamma}_n$$ | | The level of a generation sequence in a CFG |
| $$g(s1, ..., s_N)$$ | 121 | Production generating function. Represents all the ways a non-terminal can be expanded, along with the probabilities and how often each non-terminal appears in the expansions |
| $$\mathcal{P}$$ | 126 | Push down automata |
| $$\Gamma$$ | | PDA finite set of stack symbols |
| $$\delta$$ | | PDA multiset transition function |
| $$\mathcal{q_i\gamma_i}$$ | | PDA initial configuration |
| $$\mathcal{q_\phi\gamma_\phi}$$ | | PDA final configuration |
| $$\mathcal{\tau}$$ | 127 | PDA scanning/non-scanning element. $\tau\in\delta$ |
| $$\pi$$ | | A sequence of transitions and configurations in a PDA symbolizing a generalized (from FSA) a path |
| $$\Pi(\mathcal{P}, y)$$ | | The set of runs that scan $y$ |
| $$\Pi(\mathcal{P})$$ | | The set of all accepting runs of $\mathcal{P}$ |
| $$L(\mathcal{P})$$ | | The set of all strings recognized by $\mathcal{P}$ is the language recognized by it. $\{y | \Pi(\mathcal{P}, y) \ne \emptyset\}$ |


## Chapter 5.1

| **Symbol**       | **Page** | **Meaning**             |
| --- |  ---| --- |
| $$h$$ | 140 | RNN hidden states |
| $$\mathcal{R}$$ | 142 | RNN. Real-valued uses $R^D$ while rational uses $Q^D$ |
| $$\Sigma$$ | | Alphabet of input symbols |
| $$D$$ | | The dimension of $\mathcal{R}$ |
| $$\text{f}$$ | | The dynamics map, a funciton defining the transitions between hidden states. Essentially this encodes the hidden states in a function, as opposed to a look-up table as we saw with FSA and context-free grammars |
| $$\text{h}_0$$ | | The initial state |
| $$\text{enc}_\mathcal{R}(y_{\le{t+1}})$$ | 143 | The encoding function that uses an RNN to recursively encode strings of arbitrary length, using its recurrent dynamics map |
| $$h_t$$ | 144 | The hidden state that desribes the state of $\mathcal{R}$ after reading $y_t$ |
| $$[[y]]$$ | 146 | One-hot encoded string $y$ |
| $$d_n(y)$$ | | Function for the one-hot encoded string. It assigns the nth canonical basis vector. Where n is a bijection function (an ordering of the alphabet assigning an index to each symbol in $\Sigma$ |
| $$s\|x\|$$ | 147 | |
| $$\mathbf{VU}b_h$$ | 150 | For Elman and Jordan networks: **U** Linearly transforms the previous hidden state (recurrence matrix). **V** Linearly transforms the representations of the input symbols (input matrix). **Output Matrix:** Linearly transforms the hidden states before computing the output values $r_t$. $b_h$ (hidden bias vector) |
| $$e'$$ | | Fixed embedding function |
| $$\text{g}$$ | 153 | An RNN gate vector, elements can only be 0 or 1 |

## Chapter 5.2

For HRNN to PFSA (From Lemma 5.2.1)

| **Symbol**       | **Page** | **Meaning** |
| --- | --- | --- |
| $$s$$ | 159 | Bidirectional mapping from hidden state to an index |

For PFSA to HRNN (From Lemma 5.2.2: Elman RNNs can encode PFSAs)

| **Symbol**       | **Page** | **Meaning** |
| --- | --- | --- |
| $$n(q, y)$$ | 161 | Maps state symbol pair to an integer |
| $$m(y)$$ | | Maps the symbol to an integer |
| $$\hat{m}(y)$$ | | Same as $m(y)$ but with EOS mapped as well |
| $$U$$ | 163 | The entries of each column $U_{:,n(q,y)}​$ are set up to indicate the states that are reachable from state $q$ after processing input $y$. An entry in $U_{:,n(q,y)}​$ in $\mathbf{U}$ is set to $1$ if there exists a transition in the automaton that moves from state $q$ to $q′$ upon reading input $y′$. |
| $$V$$ | | The input matrix $V$ lives in $\mathbb{B}^{\lvert Σ \rvert \lvert Q \rvert \times \lvert Σ \rvert}$ and encodes the information about which states can be reached by which symbols (from any state in $\mathcal{A}$) |
| Conjunction of $V$ and $U$ | | By combining the encoding of the current state from $U$ and the encoding of the input symbol from $V$, the system produces a single non-zero entry, representing the unique state reachable from $q_t$​ using symbol $y_{t+1}$ |

## Chapter 5.3

| **Symbol**       | **Page** | **Meaning** |
| --- | --- | --- |
| $$\mathcal{T}$$ | 210 | Transformer network $\Sigma$, $D$, and $enc_\mathcal{T}$ where $\Sigma$ is the input alphabet, $D$ is the dimension of $\mathcal{T}$, and $enc_\mathcal{T}$ is the encoding function |
| $$h_t$$ | | Hidden states of the transform, unlike RNNs it does not have a dependency on previous hidden states $enc_\mathcal{T}(y_{\le t})$ |
| $$a_t$$ | 211 | The attention mechanism value of hidden state $h_t$ |
| $$\text{Att}$$ | | The attention mechanism function |
| $$qKV$$ | | Query key and value of the attention mechanism. Each symbol has a query vector assigned to it. |
| $$\text{T}$$ | 214 | Transformer layer |
| $$\mathbf{XZ}$$ | | The input/output to the attention mechanism $a_t$ is an intermediate value generated in this process. $\mathbf{X}$ is the initial static embeddings of the sequence. However, after passing through the first transformer layer, becomes a layer's input. $\mathbf{Z}$ is the output of a single transformer layer. So the previous layer's $\mathbf{Z}$ output, will be the next layer's $\mathbf{X}$ input |
| $$O(a_t)$$ | | The output transformation from attention values to a transformer layer output value $\mathbf{z}_t$. In the text it is left generic as it can probably be customized. But it is usually a multi-layer perceptron (MLP) |
| Transformer Definition | 215 | |
| $$X^1$$ |  | Initial symbol representation |
| $$X^{\mathcal{l}+1}$$ | | Output of a transformer layer (same as X above) |
| $$T_\mathcal{l}$$ | | Represents the ℓℓ-th transformer layer, each with its own parameters. These layers are sequentially applied to the input. |
| $$F$$ | | A transformation function that extracts the contextual encoding of the last symbol in the sequence |
| $$e'$$ | | A symbol embedding function that provides the initial dense representations for symbols in $\Sigma$ |
| $$u_j$$ | 216 | Represents the unnormalized attention score for the interaction between the query vector $q_t$ (at the current position $t$) and the key vector $k_j$​ (corresponding to position $j$ in the input sequence) - $F(q_t,k_j)=q_t^{\top}K^\top$ (it can be computed as a single calculation also $u=q_t^{\top}K^\top$). They can then be normalized (e.g., via softmax) to produce attention weights |
| $$S$$ | 217 | Matrix of normalized attention weights |
| $$\mathbf{U}$$ | | Attention matrix: Just the queries multiplied by the keys |
| $$\mathbf{A}$$ | | An attention block. As defined first, it is unmasked which means that queries can look ahead to keys and values ahead, which is solved by masking |

### Attention layer transformation:

$$\mathbf{X} \xrightarrow[]{\text{Att()} + \text{x}} a \xrightarrow[]{O() + a} \mathbf{Z}$$

## Exercises (Page numbers)

1. Proof of allsum $T^d$: 88
2. Chapter 4.1: 136
