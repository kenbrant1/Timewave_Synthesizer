(
//To find out the ratio per step for note increments in the inlcine/decline of the King Wen sequence.
//For example, I want the note increment ratio for a KW sequence that has 64 steps(numsteps) and a starting(n1) and ending(n2)
//note ratio difference of 1.6180339887499.

a=1;
Routine({var n1 = 1, n2 = 1.6180339887499, numsteps = 64;
	 x=1000.do({n = n1; (numsteps.do({(n = n*a)}));
		if(n <= n2,
			{a=a+0.01},{x.stop});

	});
	 x=1000.do({n = n1;
		(numsteps.do({(n = n*a)}));
		if(n >= n2,
			{a=a-0.001},{x.stop});

	});
	 x=1000.do({n = n1;
		(numsteps.do({(n = n*a)}));
		if(n <= n2,
			{a=a+0.0001},{x.stop});

	});
	 x=1000.do({n = n1;
		(numsteps.do({(n = n*a)}));
		if(n >= n2,
			{a=a-0.000001},{x.stop});

	});
	 x=1000.do({n = n1;
		(numsteps.do({(n = n*a)}));
		if(n <= n2,
			{a=a+0.0000001},{x.stop});

	});
	 x=1000.do({n = n1;
		(numsteps.do({(n = n*a)}));
		if(n >= n2,
			{a=a-0.00000001},{x.stop});

	});
	 x=1000.do({n = n1;
		(numsteps.do({(n = n*a)}));
		if(n <= n2,
			{a=a+0.000000001},{x.stop});

	});
	 x=1000.do({n = n1;
		(numsteps.do({(n = n*a)}));
		if(n >= n2,
			{a=a-0.0000000001},{x.stop});

	});
	 x=1000.do({n = n1;
		(numsteps.do({(n = n*a)}));
		if(n <= n2,
			{a=a+0.00000000001},{x.stop});

	});
	 x=1000.do({n = n1;
		(numsteps.do({(n = n*a)}));
		if(n >= n2,
			{a=a-0.000000000001},{x.stop});

	});
	 x=1000.do({n = n1;
		(numsteps.do({(n = n*a)}));
		if(n <= n2,
			{a=a+0.0000000000001},{x.stop});

	});
	 x=1000.do({n = n1;
		(numsteps.do({(n = n*a)}));
		if(n >= n2,
			{a=a-0.00000000000001},{x.stop});

	});
	 x=1000.do({n = n1;
		(numsteps.do({(n = n*a)}));
		if(n <= n2,
			{a=a+0.000000000000001},{x.stop});

	});
	 x=1000.do({n = n1;
		(numsteps.do({(n = n*a)}));
		if(n >= n2,
			{a=a-0.0000000000000001},{x.stop});

	});
	 x=1000.do({n = n1;
		(numsteps.do({(n = n*a)}));
		if(n <= n2,
			{a=a+0.00000000000000001},{x.stop});

	});
	 x=1000.do({n = n1;
		(numsteps.do({(n = n*a)}));
		if(n >= n2,
			{a=a-0.000000000000000001},{x.stop});

	});
	x=1000.do({n = n1;
		(numsteps.do({(n = n*a)}));
		if(n >= n2,
			{a=a+0.0000000000000000001},{x.stop});

	});
	x=1000.do({n = n1;
		(numsteps.do({(n = n*a)}));
		if(n >= n2,
			{a=a-0.00000000000000000001},{x.stop});
	});
	a.postln;
}).play;
);
