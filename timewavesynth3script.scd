/*Order of execution to run script and record:
1. Hit "Ctrl/Cmd - Enter" anywhere inside the "LOAD SYNTH FUNCTIONS" parenthesis on line 44,
2. Click on the same line as "START RECORDING" on line 41 and hit "Ctrl/Cmd - Enter",
3. Hit "Ctrl/Cmd - Enter" anywhere inside the "TASK" parenthesis on line 12...
The record file location will be found in the post window...
Leave out #2 to run the script without recording...
Important Note: You must load the appropriate Timewave Synthesizer program and run the synth by pressing the "synth0" button at least once before this script can run.
Press "Ctrl/Cmd - Period" to stop synth/free the sever.

You can compose a piece, and find guides for doing so, inside the "//3 - TASK" function. */

((//3 - TASK
	t = Task({/*trace*/ ~st = 0; ~trace = {("event-"++(~st = ~st + 1).asString).postln;}; 3.do(x = 0; {("vol"++(x=x+1)).asSymbol.envirPut(/*volume*/ 0.005)});
		1.do({

			//duration of each chord
			a = 38.832815729998;

			//copy and paste "saved" chords from the "copy" button inside the synthesizer program here:
			//choose to change each duration individually by changing the "a" variable in the code below this line, as well as "synthopen/synthflow"
			[~f1=525.7244292648,~f2=646.87931910571,~f3=882.91913643716,~f4=1181.3955692862,~f5=706.55967076687,~f6=711.25161146077,~f7=977.22674582697,~f8=1325.0082712923]; ~synthopen.value; ~trace.value; (a).wait;
			[~f1=654.05453931384,~f2=879.03193048766,~f3=941.25430167146,~f4=1100.8670554563,~f5=1316.2675385788,~f6=1316.2675385788,~f7=1316.2675385788,~f8=1316.2675385788]; ~synthflow.value; ~trace.value; (a).wait;
			[~f1=654.05453931384,~f2=879.03193048766,~f3=941.25430167146,~f4=1100.8670554563,~f5=1316.2675385788,~f6=1051.0271787501,~f7=1051.0271787501,~f8=1051.0271787501]; ~synthflow.value; ~trace.value; (a).wait;
			[~f1=654.05453931384,~f2=879.03193048766,~f3=941.25430167146,~f4=1100.8670554563,~f5=1316.2675385788,~f6=937.1102649523,~f7=937.1102649523,~f8=937.1102649523]; ~synthflow.value; ~trace.value; (a).wait;
			[~f1=654.05453931384,~f2=879.03193048766,~f3=941.25430167146,~f4=1100.8670554563,~f5=1316.2675385788,~f6=824.55305817848,~f7=824.55305817848,~f8=822.73593638317]; ~synthflow.value; ~trace.value; (a).wait;
			[~f1=654.05453931384,~f2=879.03193048766,~f3=941.25430167146,~f4=1100.8670554563,~f5=1316.2675385788,~f6=824.55305817848,~f7=1037.2062139187,~f8=1037.2062139187]; ~synthflow.value; ~trace.value; (a).wait;
			[~f1=654.05453931384,~f2=879.03193048766,~f3=941.25430167146,~f4=1100.8670554563,~f5=1316.2675385788,~f6=554.31101031015,~f7=554.31101031015,~f8=554.31101031015]; ~synthflow.value; ~trace.value; (a).wait;
			[~f1=654.05453931384,~f2=879.03193048766,~f3=941.25430167146,~f4=521.10543213641,~f5=521.10543213641,~f6=521.10543213641,~f7=521.10543213641,~f8=521.10543213641]; ~synthflow.value; ~trace.value; (a).wait;

			//fade out function
			100.do({3.do(x = 0; {("vol"++(x=x+1)).asSymbol.envirPut(("vol"++x).asSymbol.envirGet - 0.00005)}); ~synthflow.value; 0.1.wait;});

			//stop everything
			~synthfree.value; 2.wait; s.stopRecording;
			3.do(x = 0; {("vol"++(x=x+1)).asSymbol.envirPut(0.005)});

});}););
t.play;
);

s.record; //2 - START RECORDING
s.stopRecording; // STOP RECORDING

(//1 - LOAD SYNTH FUNCTIONS
~synthopen = {
	case
	{((~l1a.isRunning == false) and: (~l1a1.isRunning == false)) or: ~l1a1.isRunning == true}{
		if(~l1a1.isRunning == true, {
			(1.do({var vol1,vol2,vol3,s1,s2,s3,s4,s5,s6,f1,f2,f3;
				#vol1,vol2,vol3 = [~vol1,~vol2,~vol3];
				#f1,f2,f3 = [ 0,0,0 ];
				s.makeBundle(0, {
					~l1a1.set(\dur, f1,     \vol, vol1);  ~l1b1.set(\dur, f1,  \vol, vol1);
					~l1c1.set(\dur, f1/~icd3,       \vol, vol1);  ~l1d1.set(\dur, f1/~icd3,  \vol, vol1);
					~l1e1.set(\dur, f1/~icd6,       \vol, vol1);  ~l1f1.set(\dur, f1/~icd6,  \vol, vol1);
					~l2a1.set(\dur, f2,     \vol, vol2);          ~l2b1.set(\dur, f2,  \vol, vol2);
					~l2c1.set(\dur, f2/~icd3,       \vol, vol2);  ~l2d1.set(\dur, f2/~icd3,  \vol, vol2);
					~l2e1.set(\dur, f2/~icd6,       \vol, vol2);  ~l2f1.set(\dur, f2/~icd6,  \vol, vol2);
					~l3a1.set(\dur, f3,     \vol, vol3);          ~l3b1.set(\dur, f3,  \vol, vol3);
					~l3c1.set(\dur, f3/~icd3,       \vol, vol3);  ~l3d1.set(\dur, f3/~icd3,  \vol, vol3);
					~l3e1.set(\dur, f3/~icd6,       \vol, vol3);  ~l3f1.set(\dur, f3/~icd6,  \vol, vol3);
				});
			}););
		});

		(
			1.do({var vol1,vol2,vol3,s1,s2,s3,s4,s5,s6,s1_1,s1_2,s1_3;
				#vol1,vol2,vol3 = [~vol1,~vol2,~vol3];
				#s1,s2,s3,s4,s5,s6 = [\gsineicfld6, \gsineicrld6, \gsineicfld2, \gsineicrld2, \gsineicfld1, \gsineicrld1];
				case
				{~sendreplysynthdef_on == 0}{#s1_1,s1_2,s1_3 = \gsineicfld6!3;}
				{~sendreplysynthdef_on == 1}{#s1_1,s1_2,s1_3 =
					[\gsineicfld6_f1, \gsineicfld6_f2, \gsineicfld6_f3];};
				s.makeBundle(0, {
					~l1a = Synth(s1_1, [\dur, ~f1,    \vol, vol1]).register;    ~l1b = Synth(s2, [\dur, ~f1,    \vol, vol1]);
					~l1c = Synth(s3, [\dur, ~f1/~icd3,  \vol, vol1]);   ~l1d = Synth(s4, [\dur, ~f1/~icd3,  \vol, vol1]);
					~l1e = Synth(s5, [\dur, ~f1/~icd6,  \vol, vol1]);   ~l1f = Synth(s6, [\dur, ~f1/~icd6,  \vol, vol1]);
					~l2a = Synth(s1_2, [\dur, ~f2,    \vol, vol2]);        ~l2b = Synth(s2, [\dur, ~f2,    \vol, vol2]);
					~l2c = Synth(s3, [\dur, ~f2/~icd3,  \vol, vol2]);   ~l2d = Synth(s4, [\dur, ~f2/~icd3,  \vol, vol2]);
					~l2e = Synth(s5, [\dur, ~f2/~icd6,  \vol, vol2]);   ~l2f = Synth(s6, [\dur, ~f2/~icd6,  \vol, vol2]);
					~l3a = Synth(s1_3, [\dur, ~f3,    \vol, vol3]);        ~l3b = Synth(s2, [\dur, ~f3,   \vol, vol3]);
					~l3c = Synth(s3, [\dur, ~f3/~icd3,  \vol, vol3]);   ~l3d = Synth(s4, [\dur, ~f3/~icd3, \vol, vol3]);
					~l3e = Synth(s5, [\dur, ~f3/~icd6,  \vol, vol3]);   ~l3f = Synth(s6, [\dur, ~f3/~icd6, \vol, vol3]);
				});
			});
		);
		if(~l1a1.isRunning == true, {
			AppClock.sched(0.161803398875,{
				([~l1a1,~l1b1,~l1c1,~l1d1,~l1e1,~l1f1,~l2a1,~l2b1,~l2c1,~l2d1,~l2e1,~l2f1,~l3a1,~l3b1,~l3c1,~l3d1,~l3e1,~l3f1 ].do(_.free)); ~slideroutine.stop;
			});
		});
	}
	{~l1a.isRunning == true}{
		(1.do({var vol1,vol2,vol3,s1,s2,s3,s4,s5,s6,f1,f2,f3;
			#vol1,vol2,vol3 = [~vol1,~vol2,~vol3];
			#f1,f2,f3 = [ 0,0,0 ];
			s.makeBundle(0, {
				~l1a.set(\dur, f1,     \vol, vol1);  ~l1b.set(\dur, f1,  \vol, vol1);
				~l1c.set(\dur, f1/~icd3,       \vol, vol1);  ~l1d.set(\dur, f1/~icd3,  \vol, vol1);
				~l1e.set(\dur, f1/~icd6,       \vol, vol1);  ~l1f.set(\dur, f1/~icd6,  \vol, vol1);
				~l2a.set(\dur, f2,     \vol, vol2);          ~l2b.set(\dur, f2,  \vol, vol2);
				~l2c.set(\dur, f2/~icd3,       \vol, vol2);  ~l2d.set(\dur, f2/~icd3,  \vol, vol2);
				~l2e.set(\dur, f2/~icd6,       \vol, vol2);  ~l2f.set(\dur, f2/~icd6,  \vol, vol2);
				~l3a.set(\dur, f3,     \vol, vol3);          ~l3b.set(\dur, f3,  \vol, vol3);
				~l3c.set(\dur, f3/~icd3,       \vol, vol3);  ~l3d.set(\dur, f3/~icd3,  \vol, vol3);
				~l3e.set(\dur, f3/~icd6,       \vol, vol3);  ~l3f.set(\dur, f3/~icd6,  \vol, vol3);
			});
		}););

		(
			1.do({var vol1,vol2,vol3,s1,s2,s3,s4,s5,s6,s1_1,s1_2,s1_3;
				#vol1,vol2,vol3 = [~vol1,~vol2,~vol3];
				#s1,s2,s3,s4,s5,s6 = [\gsineicfld6, \gsineicrld6, \gsineicfld2, \gsineicrld2, \gsineicfld1, \gsineicrld1];
				case
				{~sendreplysynthdef_on == 0}{#s1_1,s1_2,s1_3 = \gsineicfld6!3;}
				{~sendreplysynthdef_on == 1}{#s1_1,s1_2,s1_3 =
					[\gsineicfld6_f1, \gsineicfld6_f2, \gsineicfld6_f3];};
				s.makeBundle(0, {
					~l1a1 = Synth(s1_1, [\dur, ~f1,    \vol, vol1]).register;    ~l1b1 = Synth(s2, [\dur, ~f1,    \vol, vol1]);
					~l1c1 = Synth(s3, [\dur, ~f1/~icd3,  \vol, vol1]);   ~l1d1 = Synth(s4, [\dur, ~f1/~icd3,  \vol, vol1]);
					~l1e1 = Synth(s5, [\dur, ~f1/~icd6,  \vol, vol1]);   ~l1f1 = Synth(s6, [\dur, ~f1/~icd6,  \vol, vol1]);
					~l2a1 = Synth(s1_2, [\dur, ~f2,    \vol, vol2]);        ~l2b1 = Synth(s2, [\dur, ~f2,    \vol, vol2]);
					~l2c1 = Synth(s3, [\dur, ~f2/~icd3,  \vol, vol2]);   ~l2d1 = Synth(s4, [\dur, ~f2/~icd3,  \vol, vol2]);
					~l2e1 = Synth(s5, [\dur, ~f2/~icd6,  \vol, vol2]);   ~l2f1 = Synth(s6, [\dur, ~f2/~icd6,  \vol, vol2]);
					~l3a1 = Synth(s1_3, [\dur, ~f3,    \vol, vol3]);        ~l3b1 = Synth(s2, [\dur, ~f3,   \vol, vol3]);
					~l3c1 = Synth(s3, [\dur, ~f3/~icd3,  \vol, vol3]);   ~l3d1 = Synth(s4, [\dur, ~f3/~icd3, \vol, vol3]);
					~l3e1 = Synth(s5, [\dur, ~f3/~icd6,  \vol, vol3]);   ~l3f1 = Synth(s6, [\dur, ~f3/~icd6, \vol, vol3]);
				});
			});
		);
		AppClock.sched(0.161803398875,{
			([~l1a,~l1b,~l1c,~l1d,~l1e,~l1f,~l2a,~l2b,~l2c,~l2d,~l2e,~l2f,~l3a,~l3b,~l3c,~l3d,~l3e,~l3f].do(_.free)); ~slideroutine.stop;
		});
	};
};

~synthflow = {
	case
	{~l1a1.isRunning == true}{
		(1.do({var vol1,vol2,vol3,s1,s2,s3,s4,s5,s6;
			#vol1,vol2,vol3 = [~vol1,~vol2,~vol3];
			s.makeBundle(0, {
				~l1a1.set(\dur, ~f1,     \vol, vol1);  ~l1b1.set(\dur, ~f1,  \vol, vol1);
				~l1c1.set(\dur, ~f1/~icd3,       \vol, vol1);  ~l1d1.set(\dur, ~f1/~icd3,  \vol, vol1);
				~l1e1.set(\dur, ~f1/~icd6,       \vol, vol1);  ~l1f1.set(\dur, ~f1/~icd6,  \vol, vol1);
				~l2a1.set(\dur, ~f2,     \vol, vol2);          ~l2b1.set(\dur, ~f2,  \vol, vol2);
				~l2c1.set(\dur, ~f2/~icd3,       \vol, vol2);  ~l2d1.set(\dur, ~f2/~icd3,  \vol, vol2);
				~l2e1.set(\dur, ~f2/~icd6,       \vol, vol2);  ~l2f1.set(\dur, ~f2/~icd6,  \vol, vol2);
				~l3a1.set(\dur, ~f3,     \vol, vol3);          ~l3b1.set(\dur, ~f3,  \vol, vol3);
				~l3c1.set(\dur, ~f3/~icd3,       \vol, vol3);  ~l3d1.set(\dur, ~f3/~icd3,  \vol, vol3);
				~l3e1.set(\dur, ~f3/~icd6,       \vol, vol3);  ~l3f1.set(\dur, ~f3/~icd6,  \vol, vol3);
			});
		}););
	}
	{~l1a.isRunning == true} {
		(1.do({var vol1,vol2,vol3,s1,s2,s3,s4,s5,s6;
			#vol1,vol2,vol3 = [~vol1,~vol2,~vol3];
			s.makeBundle(0, {
				~l1a.set(\dur, ~f1,     \vol, vol1);  ~l1b.set(\dur, ~f1,  \vol, vol1);
				~l1c.set(\dur, ~f1/~icd3,       \vol, vol1);  ~l1d.set(\dur, ~f1/~icd3,  \vol, vol1);
				~l1e.set(\dur, ~f1/~icd6,       \vol, vol1);  ~l1f.set(\dur, ~f1/~icd6,  \vol, vol1);
				~l2a.set(\dur, ~f2,     \vol, vol2);          ~l2b.set(\dur, ~f2,  \vol, vol2);
				~l2c.set(\dur, ~f2/~icd3,       \vol, vol2);  ~l2d.set(\dur, ~f2/~icd3,  \vol, vol2);
				~l2e.set(\dur, ~f2/~icd6,       \vol, vol2);  ~l2f.set(\dur, ~f2/~icd6,  \vol, vol2);
				~l3a.set(\dur, ~f3,     \vol, vol3);          ~l3b.set(\dur, ~f3,  \vol, vol3);
				~l3c.set(\dur, ~f3/~icd3,       \vol, vol3);  ~l3d.set(\dur, ~f3/~icd3,  \vol, vol3);
				~l3e.set(\dur, ~f3/~icd6,       \vol, vol3);  ~l3f.set(\dur, ~f3/~icd6,  \vol, vol3);
			});
		}););
	};
};

~synthslide = {case{~l1a1.isRunning == true}{(
	~slideroutine = Routine({
		1.do({var vol1,vol2,vol3,s1,s2,s3,s4,s5,s6;
			#vol1,vol2,vol3= [~vol1,~vol2,~vol3];
			#g,h,i = (([ s,t,u ]-[ ~f1,~f2,~f3 ])*(-1)/~slidedo);
			~slidedo.do({([ s=s+g,t=t+h,u=u+i ];
				s.makeBundle(0, {
					~l1a1.set(\dur, s, \vol, vol1);
					~l1b1.set(\dur, s, \vol, vol1);
					~l1c1.set(\dur, s/~icd3, \vol, vol1);
					~l1d1.set(\dur, s/~icd3, \vol, vol1);
					~l1e1.set(\dur, s/~icd6, \vol, vol1);
					~l1f1.set(\dur, s/~icd6, \vol, vol1);
					~l2a1.set(\dur, t, \vol, vol2);
					~l2b1.set(\dur, t, \vol, vol2);
					~l2c1.set(\dur, t/~icd3, \vol, vol2);
					~l2d1.set(\dur, t/~icd3, \vol, vol2);
					~l2e1.set(\dur, t/~icd6, \vol, vol2);
					~l2f1.set(\dur, t/~icd6, \vol, vol2);
					~l3a1.set(\dur, u, \vol, vol3);
					~l3b1.set(\dur, u, \vol, vol3);
					~l3c1.set(\dur, u/~icd3, \vol, vol3);
					~l3d1.set(\dur, u/~icd3, \vol, vol3);
					~l3e1.set(\dur, u/~icd6, \vol, vol3);
					~l3f1.set(\dur, u/~icd6, \vol, vol3);
				});
			);
			(~slidetime/~slidedo).wait;
});});}).play;);}{~l1a.isRunning == true} {(
	~slideroutine = Routine({1.do({var vol1,vol2,vol3,s1,s2,s3,s4,s5,s6;
		#vol1,vol2,vol3= [~vol1,~vol2,~vol3];
		#g,h,i = (([ s,t,u ]-[ ~f1,~f2,~f3 ])*(-1)/~slidedo);
		~slidedo.do({([ s=s+g,t=t+h,u=u+i ];
			s.makeBundle(0, {
				~l1a.set(\dur, s, \vol, vol1);
				~l1b.set(\dur, s, \vol, vol1);
				~l1c.set(\dur, s/~icd3, \vol, vol1);
				~l1d.set(\dur, s/~icd3, \vol, vol1);
				~l1e.set(\dur, s/~icd6, \vol, vol1);
				~l1f.set(\dur, s/~icd6, \vol, vol1);
				~l2a.set(\dur, t, \vol, vol2);
				~l2b.set(\dur, t, \vol, vol2);
				~l2c.set(\dur, t/~icd3, \vol, vol2);
				~l2d.set(\dur, t/~icd3, \vol, vol2);
				~l2e.set(\dur, t/~icd6, \vol, vol2);
				~l2f.set(\dur, t/~icd6, \vol, vol2);
				~l3a.set(\dur, u, \vol, vol3);
				~l3b.set(\dur, u, \vol, vol3);
				~l3c.set(\dur, u/~icd3, \vol, vol3);
				~l3d.set(\dur, u/~icd3, \vol, vol3);
				~l3e.set(\dur, u/~icd6, \vol, vol3);
				~l3f.set(\dur, u/~icd6, \vol, vol3);
			});
		);
		(~slidetime/~slidedo).wait;});});
}).play;);};};


~synthpause = {(
	case
	{~l1a1.isRunning == true}{
		(1.do({var vol1,vol2,vol3,s1,s2,s3,s4,s5,s6,f1,f2,f3;
			#vol1,vol2,vol3 = [~vol1,~vol2,~vol3];
			#f1,f2,f3 = [ 0,0,0 ];
			s.makeBundle(0, {
				~l1a1.set(\dur, f1,     \vol, vol1);          ~l1b1.set(\dur, f1,  \vol, vol1);
				~l1c1.set(\dur, f1/~icd3,       \vol, vol1);  ~l1d1.set(\dur, f1/~icd3,  \vol, vol1);
				~l1e1.set(\dur, f1/~icd6,       \vol, vol1);  ~l1f1.set(\dur, f1/~icd6,  \vol, vol1);
				~l2a1.set(\dur, f2,     \vol, vol2);          ~l2b1.set(\dur, f2,  \vol, vol2);
				~l2c1.set(\dur, f2/~icd3,       \vol, vol2);  ~l2d1.set(\dur, f2/~icd3,  \vol, vol2);
				~l2e1.set(\dur, f2/~icd6,       \vol, vol2);  ~l2f1.set(\dur, f2/~icd6,  \vol, vol2);
				~l3a1.set(\dur, f3,     \vol, vol3);          ~l3b1.set(\dur, f3,  \vol, vol3);
				~l3c1.set(\dur, f3/~icd3,       \vol, vol3);  ~l3d1.set(\dur, f3/~icd3,  \vol, vol3);
				~l3e1.set(\dur, f3/~icd6,       \vol, vol3);  ~l3f1.set(\dur, f3/~icd6,  \vol, vol3);
			});
		}););
	}
	{~l1a.isRunning == true} {
		(1.do({var vol1,vol2,vol3,s1,s2,s3,s4,s5,s6,f1,f2,f3;
			#vol1,vol2,vol3 = [~vol1,~vol2,~vol3];
			#f1,f2,f3 = [ 0,0,0 ];
			s.makeBundle(0, {
				~l1a.set(\dur, f1,     \vol, vol1);  ~l1b.set(\dur, f1,  \vol, vol1);
				~l1c.set(\dur, f1/~icd3,       \vol, vol1);  ~l1d.set(\dur, f1/~icd3,  \vol, vol1);
				~l1e.set(\dur, f1/~icd6,       \vol, vol1);  ~l1f.set(\dur, f1/~icd6,  \vol, vol1);
				~l2a.set(\dur, f2,     \vol, vol2);          ~l2b.set(\dur, f2,  \vol, vol2);
				~l2c.set(\dur, f2/~icd3,       \vol, vol2);  ~l2d.set(\dur, f2/~icd3,  \vol, vol2);
				~l2e.set(\dur, f2/~icd6,       \vol, vol2);  ~l2f.set(\dur, f2/~icd6,  \vol, vol2);
				~l3a.set(\dur, f3,     \vol, vol3);          ~l3b.set(\dur, f3,  \vol, vol3);
				~l3c.set(\dur, f3/~icd3,       \vol, vol3);  ~l3d.set(\dur, f3/~icd3,  \vol, vol3);
				~l3e.set(\dur, f3/~icd6,       \vol, vol3);  ~l3f.set(\dur, f3/~icd6,  \vol, vol3);
			});
		}););
	};
);
};

~synthfree = {
	(
		case
		{~l1a1.isRunning == true}{
			(1.do({var vol1,vol2,vol3,s1,s2,s3,s4,s5,s6,f1,f2,f3;
				#vol1,vol2,vol3 = [~vol1,~vol2,~vol3];
				#f1,f2,f3 = [ 0,0,0 ];
				s.makeBundle(0, {
					~l1a1.set(\dur, f1,     \vol, vol1);  ~l1b1.set(\dur, f1,  \vol, vol1);
					~l1c1.set(\dur, f1/~icd3,       \vol, vol1);  ~l1d1.set(\dur, f1/~icd3,  \vol, vol1);
					~l1e1.set(\dur, f1/~icd6,       \vol, vol1);  ~l1f1.set(\dur, f1/~icd6,  \vol, vol1);
					~l2a1.set(\dur, f2,     \vol, vol2);          ~l2b1.set(\dur, f2,  \vol, vol2);
					~l2c1.set(\dur, f2/~icd3,       \vol, vol2);  ~l2d1.set(\dur, f2/~icd3,  \vol, vol2);
					~l2e1.set(\dur, f2/~icd6,       \vol, vol2);  ~l2f1.set(\dur, f2/~icd6,  \vol, vol2);
					~l3a1.set(\dur, f3,     \vol, vol3);          ~l3b1.set(\dur, f3,  \vol, vol3);
					~l3c1.set(\dur, f3/~icd3,       \vol, vol3);  ~l3d1.set(\dur, f3/~icd3,  \vol, vol3);
					~l3e1.set(\dur, f3/~icd6,       \vol, vol3);  ~l3f1.set(\dur, f3/~icd6,  \vol, vol3);
				});
			}););
			AppClock.sched(0.161803398875,{
				([~l1a1,~l1b1,~l1c1,~l1d1,~l1e1,~l1f1,~l2a1,~l2b1,~l2c1,~l2d1,~l2e1,~l2f1,~l3a1,~l3b1,~l3c1,~l3d1,~l3e1,~l3f1 ].do(_.free)); ~slideroutine.stop;
			});
		}
		{~l1a.isRunning == true}{
			(1.do({var vol1,vol2,vol3,s1,s2,s3,s4,s5,s6,f1,f2,f3;
				#vol1,vol2,vol3 = [~vol1,~vol2,~vol3];
				#f1,f2,f3 = [ 0,0,0 ];
				s.makeBundle(0, {
					~l1a.set(\dur, f1,     \vol, vol1);  ~l1b.set(\dur, f1,  \vol, vol1);
					~l1c.set(\dur, f1/~icd3,       \vol, vol1);  ~l1d.set(\dur, f1/~icd3,  \vol, vol1);
					~l1e.set(\dur, f1/~icd6,       \vol, vol1);  ~l1f.set(\dur, f1/~icd6,  \vol, vol1);
					~l2a.set(\dur, f2,     \vol, vol2);          ~l2b.set(\dur, f2,  \vol, vol2);
					~l2c.set(\dur, f2/~icd3,       \vol, vol2);  ~l2d.set(\dur, f2/~icd3,  \vol, vol2);
					~l2e.set(\dur, f2/~icd6,       \vol, vol2);  ~l2f.set(\dur, f2/~icd6,  \vol, vol2);
					~l3a.set(\dur, f3,     \vol, vol3);          ~l3b.set(\dur, f3,  \vol, vol3);
					~l3c.set(\dur, f3/~icd3,       \vol, vol3);  ~l3d.set(\dur, f3/~icd3,  \vol, vol3);
					~l3e.set(\dur, f3/~icd6,       \vol, vol3);  ~l3f.set(\dur, f3/~icd6,  \vol, vol3);
				});
			}););
			AppClock.sched(0.161803398875,{
				([~l1a,~l1b,~l1c,~l1d,~l1e,~l1f,~l2a,~l2b,~l2c,~l2d,~l2e,~l2f,~l3a,~l3b,~l3c,~l3d,~l3e,~l3f].do(_.free)); ~slideroutine.stop;
			});
		};
	);
};
);

/* e-mail: ken_brant@ymail.com */