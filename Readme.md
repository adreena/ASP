A NOVEL TRANSITION BASED ENCODING SCHEME FOR ASP PLANNING
======


A NOVEL TRANSITION BASED ENCODING SCHEME FOR ASP PLANNING
===

Planning as satisfiability is one of the major paradigms for planning. The paper from [Huang et al., 2010] proposed a novel SAT encoding for planning problems based on the SAS+ formalism. This formalism represents a classical planning problem by a set of multi-valued state variables.

A planning task in the SAS+ formalism, referred to as a SAS+ planning problem, is defined as a tuple consisting of the state variables, a set of the actions that are possible on a domain, the initial state and the goal state.
This new encoding, named SASE, exploits the structural information in the SAS+ formalism, leading to more compact SAT instances, and less number of clauses. Also, the results presented by Huang et al. shows an increase of performance regarding time and memory.

In this project, we investigated an ASP encoding of planning using similar ideas as Huang et al. To achieve this, we supported our ideas and encoding in the set of eight clauses that are the basis for a planning task, consisting in the definition of an initial state, goal state, and composition of actions, among others. 
After applying these clauses to ASP encoding, we tried our approach in some problems/benchmarks of ASP planning problems to compare the results of both encoding schemes.

Therefore, our main goal was to apply the SASE encoding for solving ASP planning problems and compare the results.

In summary, the main metrics observed when comparing the SASE encoding in ASP planning problems were the size of the <strong>searchspace </strong> and the <strong> complexity </strong> of the problems (number of choice points) and, based on the experiments performed in this work, SASE seems to be a good approach for ASP planning.




Folders
--------
There are 3 folders in here, with the name of each problem we challenged in our project.
In each folder you can see :
	2 codes : 
		1- asp old_version for example block_asp.lp
		2- asp new version for example block_transition.lp
	Rresult.txt:
		in this file , we have provided you a simple analysis of the reuslt.
	PDDL folder:
		in this folder , the oroginal version of the code is provided which is in pddl format. 


