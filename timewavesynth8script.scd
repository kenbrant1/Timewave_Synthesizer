/*Order of execution to run script and record(goes from bottom to top):
1. Hit "Ctrl/Cmd - Enter" anywhere inside the "LOAD SYNTH FUNCTIONS" parenthesis on line 42,
2. Click on the same line as "START RECORDING" on line 39 and hit "Ctrl/Cmd - Enter",
3. Hit "Ctrl/Cmd - Enter" anywhere inside the "TASK" parenthesis on line 10...
The record file location will be found in the post window...
Leave out #2 to run the script without recording...
Important Note: You must load the Timewave Synthesizer program and press the "synth0" button at least once before this script can run.
Press "Ctrl/Cmd - Period" to stop synth/free the sever. */

((//3 - TASK
	t = Task({/*trace*/ ~st = 0; ~trace = {("event-"++(~st = ~st + 1).asString).postln;}; 8.do(x = 0; {("vol"++(x=x+1)).asSymbol.envirPut(/*volume*/ 0.005)});
		1.do({

			//duration of each chord
			a = 32;

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
			100.do({8.do(x = 0; {("vol"++(x=x+1)).asSymbol.envirPut(("vol"++x).asSymbol.envirGet - 0.00005)}); ~synthflow.value; 0.1.wait;});

			//stop everything
			~synthfree.value; 2.wait; s.stopRecording;
			8.do(x = 0; {("vol"++(x=x+1)).asSymbol.envirPut(0.005)});

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
			(1.do({var vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8,s1,s2,s3,s4,s5,s6,f1,f2,f3,f4,f5,f6,f7,f8;
				#vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8 = [~vol1,~vol2,~vol3,~vol4,~vol5,~vol6,~vol7,~vol8];
				#f1,f2,f3,f4,f5,f6,f7,f8 = [ 0,0,0,0,0,0,0,0 ];
				~l1a1.set(\dur, f1,     \vol, vol1);  ~l1b1.set(\dur, f1,  \vol, vol1);
				~l1c1.set(\dur, f1/~icd3,       \vol, vol1);  ~l1d1.set(\dur, f1/~icd3,  \vol, vol1);
				~l1e1.set(\dur, f1/~icd6,       \vol, vol1);  ~l1f1.set(\dur, f1/~icd6,  \vol, vol1);
				~l2a1.set(\dur, f2,     \vol, vol2);          ~l2b1.set(\dur, f2,  \vol, vol2);
				~l2c1.set(\dur, f2/~icd3,       \vol, vol2);  ~l2d1.set(\dur, f2/~icd3,  \vol, vol2);
				~l2e1.set(\dur, f2/~icd6,       \vol, vol2);  ~l2f1.set(\dur, f2/~icd6,  \vol, vol2);
				~l3a1.set(\dur, f3,     \vol, vol3);          ~l3b1.set(\dur, f3,  \vol, vol3);
				~l3c1.set(\dur, f3/~icd3,       \vol, vol3);  ~l3d1.set(\dur, f3/~icd3,  \vol, vol3);
				~l3e1.set(\dur, f3/~icd6,       \vol, vol3);  ~l3f1.set(\dur, f3/~icd6,  \vol, vol3);
				~l4a1.set(\dur, f4,    \vol, vol4);           ~l4b1.set(\dur, f4,  \vol, vol4);
				~l4c1.set(\dur, f4/~icd3,       \vol, vol4);  ~l4d1.set(\dur, f4/~icd3,  \vol, vol4);
				~l4e1.set(\dur, f4/~icd6,       \vol, vol4);  ~l4f1.set(\dur, f4/~icd6,  \vol, vol4);
				~l5a1.set(\dur, f5,    \vol, vol5);           ~l5b1.set(\dur, f5,  \vol, vol5);
				~l5c1.set(\dur, f5/~icd3,       \vol, vol5);  ~l5d1.set(\dur, f5/~icd3,  \vol, vol5);
				~l5e1.set(\dur, f5/~icd6,       \vol, vol5);  ~l5f1.set(\dur, f5/~icd6,  \vol, vol5);
				~l6a1.set(\dur, f6,    \vol, vol6);           ~l6b1.set(\dur, f6,  \vol, vol6);
				~l6c1.set(\dur, f6/~icd3,       \vol, vol6);  ~l6d1.set(\dur, f6/~icd3,  \vol, vol6);
				~l6e1.set(\dur, f6/~icd6,       \vol, vol6);  ~l6f1.set(\dur, f6/~icd6,  \vol, vol6);
				~l7a1.set(\dur, f7,    \vol, vol7);           ~l7b1.set(\dur, f7,  \vol, vol7);
				~l7c1.set(\dur, f7/~icd3,       \vol, vol7);  ~l7d1.set(\dur, f7/~icd3,  \vol, vol7);
				~l7e1.set(\dur, f7/~icd6,       \vol, vol7);  ~l7f1.set(\dur, f7/~icd6,  \vol, vol7);
				~l8a1.set(\dur, f8,    \vol, vol8);           ~l8b1.set(\dur, f8,  \vol, vol8);
				~l8c1.set(\dur, f8/~icd3,       \vol, vol8);  ~l8d1.set(\dur, f8/~icd3,  \vol, vol8);
				~l8e1.set(\dur, f8/~icd6,       \vol, vol8);  ~l8f1.set(\dur, f8/~icd6,  \vol, vol8);
			}););
		});

		(
			1.do({var vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8,vol9,vol10,vol11,vol12,s1,s2,s3,s4,s5,s6;
				#vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8 = [~vol1,~vol2,~vol3,~vol4,~vol5,~vol6,~vol7,~vol8];
				#s1,s2,s3,s4,s5,s6 = [\gsineicfld6, \gsineicrld6, \gsineicfld2, \gsineicrld2, \gsineicfld1, \gsineicrld1];
				~l1a = Synth(s1, [\dur, ~f1,    \vol, vol1]).register;    ~l1b = Synth(s2, [\dur, ~f1,    \vol, vol1]);
				~l1c = Synth(s3, [\dur, ~f1/~icd3,  \vol, vol1]);   ~l1d = Synth(s4, [\dur, ~f1/~icd3,  \vol, vol1]);
				~l1e = Synth(s5, [\dur, ~f1/~icd6,  \vol, vol1]);   ~l1f = Synth(s6, [\dur, ~f1/~icd6,  \vol, vol1]);
				~l2a = Synth(s1, [\dur, ~f2,    \vol, vol2]);        ~l2b = Synth(s2, [\dur, ~f2,    \vol, vol2]);
				~l2c = Synth(s3, [\dur, ~f2/~icd3,  \vol, vol2]);   ~l2d = Synth(s4, [\dur, ~f2/~icd3,  \vol, vol2]);
				~l2e = Synth(s5, [\dur, ~f2/~icd6,  \vol, vol2]);   ~l2f = Synth(s6, [\dur, ~f2/~icd6,  \vol, vol2]);
				~l3a = Synth(s1, [\dur, ~f3,    \vol, vol3]);        ~l3b = Synth(s2, [\dur, ~f3,   \vol, vol3]);
				~l3c = Synth(s3, [\dur, ~f3/~icd3,  \vol, vol3]);   ~l3d = Synth(s4, [\dur, ~f3/~icd3, \vol, vol3]);
				~l3e = Synth(s5, [\dur, ~f3/~icd6,  \vol, vol3]);   ~l3f = Synth(s6, [\dur, ~f3/~icd6, \vol, vol3]);
				~l4a = Synth(s1, [\dur, ~f4,    \vol, vol4]);       ~l4b = Synth(s2, [\dur, ~f4,   \vol, vol4]);
				~l4c = Synth(s3, [\dur, ~f4/~icd3,  \vol, vol4]);  ~l4d = Synth(s4, [\dur, ~f4/~icd3, \vol, vol4]);
				~l4e = Synth(s5, [\dur, ~f4/~icd6,  \vol, vol4]);   ~l4f = Synth(s6, [\dur, ~f4/~icd6, \vol, vol4]);
				~l5a = Synth(s1, [\dur, ~f5,    \vol, vol5]);       ~l5b = Synth(s2, [\dur, ~f5,   \vol, vol5]);
				~l5c = Synth(s3, [\dur, ~f5/~icd3,  \vol, vol5]);   ~l5d = Synth(s4, [\dur, ~f5/~icd3, \vol, vol5]);
				~l5e = Synth(s5, [\dur, ~f5/~icd6,  \vol, vol5]);   ~l5f = Synth(s6, [\dur, ~f5/~icd6, \vol, vol5]);
				~l6a = Synth(s1, [\dur, ~f6,    \vol, vol6]);       ~l6b = Synth(s2, [\dur, ~f6,   \vol, vol6]);
				~l6c = Synth(s3, [\dur, ~f6/~icd3,  \vol, vol6]);   ~l6d = Synth(s4, [\dur, ~f6/~icd3, \vol, vol6]);
				~l6e = Synth(s5, [\dur, ~f6/~icd6,  \vol, vol6]);   ~l6f = Synth(s6, [\dur, ~f6/~icd6, \vol, vol6]);
				~l7a = Synth(s1, [\dur, ~f7,    \vol, vol7]);       ~l7b = Synth(s2, [\dur, ~f7,   \vol, vol7]);
				~l7c = Synth(s3, [\dur, ~f7/~icd3,  \vol, vol7]);   ~l7d = Synth(s4, [\dur, ~f7/~icd3, \vol, vol7]);
				~l7e = Synth(s5, [\dur, ~f7/~icd6,  \vol, vol7]);   ~l7f = Synth(s6, [\dur, ~f7/~icd6, \vol, vol7]);
				~l8a = Synth(s1, [\dur, ~f8,    \vol, vol8]);  ~l8b = Synth(s2, [\dur, ~f8,   \vol, vol8]);
				~l8c = Synth(s3, [\dur, ~f8/~icd3,  \vol, vol8]);   ~l8d = Synth(s4, [\dur, ~f8/~icd3, \vol, vol8]);
				~l8e = Synth(s5, [\dur, ~f8/~icd6,  \vol, vol8]);   ~l8f = Synth(s6, [\dur, ~f8/~icd6, \vol, vol8]);

			});
		);
		if(~l1a1.isRunning == true, {
			AppClock.sched(0.161803398875,{
				([~l1a1,~l1b1,~l1c1,~l1d1,~l1e1,~l1f1,~l2a1,~l2b1,~l2c1,~l2d1,~l2e1,~l2f1,~l3a1,~l3b1,~l3c1,~l3d1,~l3e1,~l3f1,~l4a1,~l4b1,~l4c1,~l4d1,~l4e1,~l4f1,~l5a1,~l5b1,~l5c1,~l5d1,~l5e1,~l5f1,~l6a1,~l6b1,~l6c1,~l6d1,~l6e1,~l6f1,~l7a1,~l7b1,~l7c1,~l7d1,~l7e1,~l7f1,~l8a1,~l8b1,~l8c1,~l8d1,~l8e1,~l8f1 ].do(_.free)); ~slideroutine.stop;
			});
		});
	}
	{~l1a.isRunning == true}{
		(1.do({var vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8,s1,s2,s3,s4,s5,s6,f1,f2,f3,f4,f5,f6,f7,f8;
			#vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8 = [~vol1,~vol2,~vol3,~vol4,~vol5,~vol6,~vol7,~vol8];
			#f1,f2,f3,f4,f5,f6,f7,f8 = [ 0,0,0,0,0,0,0,0 ];
			~l1a.set(\dur, f1,     \vol, vol1);  ~l1b.set(\dur, f1,  \vol, vol1);
			~l1c.set(\dur, f1/~icd3,       \vol, vol1);  ~l1d.set(\dur, f1/~icd3,  \vol, vol1);
			~l1e.set(\dur, f1/~icd6,       \vol, vol1);  ~l1f.set(\dur, f1/~icd6,  \vol, vol1);
			~l2a.set(\dur, f2,     \vol, vol2);          ~l2b.set(\dur, f2,  \vol, vol2);
			~l2c.set(\dur, f2/~icd3,       \vol, vol2);  ~l2d.set(\dur, f2/~icd3,  \vol, vol2);
			~l2e.set(\dur, f2/~icd6,       \vol, vol2);  ~l2f.set(\dur, f2/~icd6,  \vol, vol2);
			~l3a.set(\dur, f3,     \vol, vol3);          ~l3b.set(\dur, f3,  \vol, vol3);
			~l3c.set(\dur, f3/~icd3,       \vol, vol3);  ~l3d.set(\dur, f3/~icd3,  \vol, vol3);
			~l3e.set(\dur, f3/~icd6,       \vol, vol3);  ~l3f.set(\dur, f3/~icd6,  \vol, vol3);
			~l4a.set(\dur, f4,    \vol, vol4);           ~l4b.set(\dur, f4,  \vol, vol4);
			~l4c.set(\dur, f4/~icd3,       \vol, vol4);  ~l4d.set(\dur, f4/~icd3,  \vol, vol4);
			~l4e.set(\dur, f4/~icd6,       \vol, vol4);  ~l4f.set(\dur, f4/~icd6,  \vol, vol4);
			~l5a.set(\dur, f5,    \vol, vol5);           ~l5b.set(\dur, f5,  \vol, vol5);
			~l5c.set(\dur, f5/~icd3,       \vol, vol5);  ~l5d.set(\dur, f5/~icd3,  \vol, vol5);
			~l5e.set(\dur, f5/~icd6,       \vol, vol5);  ~l5f.set(\dur, f5/~icd6,  \vol, vol5);
			~l6a.set(\dur, f6,    \vol, vol6);           ~l6b.set(\dur, f6,  \vol, vol6);
			~l6c.set(\dur, f6/~icd3,       \vol, vol6);  ~l6d.set(\dur, f6/~icd3,  \vol, vol6);
			~l6e.set(\dur, f6/~icd6,       \vol, vol6);  ~l6f.set(\dur, f6/~icd6,  \vol, vol6);
			~l7a.set(\dur, f7,    \vol, vol7);           ~l7b.set(\dur, f7,  \vol, vol7);
			~l7c.set(\dur, f7/~icd3,       \vol, vol7);  ~l7d.set(\dur, f7/~icd3,  \vol, vol7);
			~l7e.set(\dur, f7/~icd6,       \vol, vol7);  ~l7f.set(\dur, f7/~icd6,  \vol, vol7);
			~l8a.set(\dur, f8,    \vol, vol8);           ~l8b.set(\dur, f8,  \vol, vol8);
			~l8c.set(\dur, f8/~icd3,       \vol, vol8);  ~l8d.set(\dur, f8/~icd3,  \vol, vol8);
			~l8e.set(\dur, f8/~icd6,       \vol, vol8);  ~l8f.set(\dur, f8/~icd6,  \vol, vol8);
		}););

		(
			1.do({var vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8,vol9,vol10,vol11,vol12,s1,s2,s3,s4,s5,s6;
				#vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8 = [~vol1,~vol2,~vol3,~vol4,~vol5,~vol6,~vol7,~vol8];
				#s1,s2,s3,s4,s5,s6 = [\gsineicfld6, \gsineicrld6, \gsineicfld2, \gsineicrld2, \gsineicfld1, \gsineicrld1];
				~l1a1 = Synth(s1, [\dur, ~f1,    \vol, vol1]).register;    ~l1b1 = Synth(s2, [\dur, ~f1,    \vol, vol1]);
				~l1c1 = Synth(s3, [\dur, ~f1/~icd3,  \vol, vol1]);   ~l1d1 = Synth(s4, [\dur, ~f1/~icd3,  \vol, vol1]);
				~l1e1 = Synth(s5, [\dur, ~f1/~icd6,  \vol, vol1]);   ~l1f1 = Synth(s6, [\dur, ~f1/~icd6,  \vol, vol1]);
				~l2a1 = Synth(s1, [\dur, ~f2,    \vol, vol2]);        ~l2b1 = Synth(s2, [\dur, ~f2,    \vol, vol2]);
				~l2c1 = Synth(s3, [\dur, ~f2/~icd3,  \vol, vol2]);   ~l2d1 = Synth(s4, [\dur, ~f2/~icd3,  \vol, vol2]);
				~l2e1 = Synth(s5, [\dur, ~f2/~icd6,  \vol, vol2]);   ~l2f1 = Synth(s6, [\dur, ~f2/~icd6,  \vol, vol2]);
				~l3a1 = Synth(s1, [\dur, ~f3,    \vol, vol3]);        ~l3b1 = Synth(s2, [\dur, ~f3,   \vol, vol3]);
				~l3c1 = Synth(s3, [\dur, ~f3/~icd3,  \vol, vol3]);   ~l3d1 = Synth(s4, [\dur, ~f3/~icd3, \vol, vol3]);
				~l3e1 = Synth(s5, [\dur, ~f3/~icd6,  \vol, vol3]);   ~l3f1 = Synth(s6, [\dur, ~f3/~icd6, \vol, vol3]);
				~l4a1 = Synth(s1, [\dur, ~f4,    \vol, vol4]);       ~l4b1 = Synth(s2, [\dur, ~f4,   \vol, vol4]);
				~l4c1 = Synth(s3, [\dur, ~f4/~icd3,  \vol, vol4]);  ~l4d1 = Synth(s4, [\dur, ~f4/~icd3, \vol, vol4]);
				~l4e1 = Synth(s5, [\dur, ~f4/~icd6,  \vol, vol4]);   ~l4f1 = Synth(s6, [\dur, ~f4/~icd6, \vol, vol4]);
				~l5a1 = Synth(s1, [\dur, ~f5,    \vol, vol5]);       ~l5b1 = Synth(s2, [\dur, ~f5,   \vol, vol5]);
				~l5c1 = Synth(s3, [\dur, ~f5/~icd3,  \vol, vol5]);   ~l5d1 = Synth(s4, [\dur, ~f5/~icd3, \vol, vol5]);
				~l5e1 = Synth(s5, [\dur, ~f5/~icd6,  \vol, vol5]);   ~l5f1 = Synth(s6, [\dur, ~f5/~icd6, \vol, vol5]);
				~l6a1 = Synth(s1, [\dur, ~f6,    \vol, vol6]);       ~l6b1 = Synth(s2, [\dur, ~f6,   \vol, vol6]);
				~l6c1 = Synth(s3, [\dur, ~f6/~icd3,  \vol, vol6]);   ~l6d1 = Synth(s4, [\dur, ~f6/~icd3, \vol, vol6]);
				~l6e1 = Synth(s5, [\dur, ~f6/~icd6,  \vol, vol6]);   ~l6f1 = Synth(s6, [\dur, ~f6/~icd6, \vol, vol6]);
				~l7a1 = Synth(s1, [\dur, ~f7,    \vol, vol7]);       ~l7b1 = Synth(s2, [\dur, ~f7,   \vol, vol7]);
				~l7c1 = Synth(s3, [\dur, ~f7/~icd3,  \vol, vol7]);   ~l7d1 = Synth(s4, [\dur, ~f7/~icd3, \vol, vol7]);
				~l7e1 = Synth(s5, [\dur, ~f7/~icd6,  \vol, vol7]);   ~l7f1 = Synth(s6, [\dur, ~f7/~icd6, \vol, vol7]);
				~l8a1 = Synth(s1, [\dur, ~f8,    \vol, vol8]);  ~l8b1 = Synth(s2, [\dur, ~f8,   \vol, vol8]);
				~l8c1 = Synth(s3, [\dur, ~f8/~icd3,  \vol, vol8]);   ~l8d1 = Synth(s4, [\dur, ~f8/~icd3, \vol, vol8]);
				~l8e1 = Synth(s5, [\dur, ~f8/~icd6,  \vol, vol8]);   ~l8f1 = Synth(s6, [\dur, ~f8/~icd6, \vol, vol8]);

			});
		);
		AppClock.sched(0.161803398875,{
			([~l1a,~l1b,~l1c,~l1d,~l1e,~l1f,~l2a,~l2b,~l2c,~l2d,~l2e,~l2f,~l3a,~l3b,~l3c,~l3d,~l3e,~l3f,~l4a,~l4b,~l4c,~l4d,~l4e,~l4f,~l5a,~l5b,~l5c,~l5d,~l5e,~l5f,~l6a,~l6b,~l6c,~l6d,~l6e,~l6f,~l7a,~l7b,~l7c,~l7d,~l7e,~l7f,~l8a,~l8b,~l8c,~l8d,~l8e,~l8f].do(_.free)); ~slideroutine.stop;
		});
	};
};

~synthflow = {
	case
	{~l1a1.isRunning == true}{
		(1.do({var vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8,s1,s2,s3,s4,s5,s6;
			#vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8 = [~vol1,~vol2,~vol3,~vol4,~vol5,~vol6,~vol7,~vol8];
			~l1a1.set(\dur, ~f1,     \vol, vol1);  ~l1b1.set(\dur, ~f1,  \vol, vol1);
			~l1c1.set(\dur, ~f1/~icd3,       \vol, vol1);  ~l1d1.set(\dur, ~f1/~icd3,  \vol, vol1);
			~l1e1.set(\dur, ~f1/~icd6,       \vol, vol1);  ~l1f1.set(\dur, ~f1/~icd6,  \vol, vol1);
			~l2a1.set(\dur, ~f2,     \vol, vol2);          ~l2b1.set(\dur, ~f2,  \vol, vol2);
			~l2c1.set(\dur, ~f2/~icd3,       \vol, vol2);  ~l2d1.set(\dur, ~f2/~icd3,  \vol, vol2);
			~l2e1.set(\dur, ~f2/~icd6,       \vol, vol2);  ~l2f1.set(\dur, ~f2/~icd6,  \vol, vol2);
			~l3a1.set(\dur, ~f3,     \vol, vol3);          ~l3b1.set(\dur, ~f3,  \vol, vol3);
			~l3c1.set(\dur, ~f3/~icd3,       \vol, vol3);  ~l3d1.set(\dur, ~f3/~icd3,  \vol, vol3);
			~l3e1.set(\dur, ~f3/~icd6,       \vol, vol3);  ~l3f1.set(\dur, ~f3/~icd6,  \vol, vol3);
			~l4a1.set(\dur, ~f4,    \vol, vol4);           ~l4b1.set(\dur, ~f4,  \vol, vol4);
			~l4c1.set(\dur, ~f4/~icd3,       \vol, vol4);  ~l4d1.set(\dur, ~f4/~icd3,  \vol, vol4);
			~l4e1.set(\dur, ~f4/~icd6,       \vol, vol4);  ~l4f1.set(\dur, ~f4/~icd6,  \vol, vol4);
			~l5a1.set(\dur, ~f5,    \vol, vol5);           ~l5b1.set(\dur, ~f5,  \vol, vol5);
			~l5c1.set(\dur, ~f5/~icd3,       \vol, vol5);  ~l5d1.set(\dur, ~f5/~icd3,  \vol, vol5);
			~l5e1.set(\dur, ~f5/~icd6,       \vol, vol5);  ~l5f1.set(\dur, ~f5/~icd6,  \vol, vol5);
			~l6a1.set(\dur, ~f6,    \vol, vol6);           ~l6b1.set(\dur, ~f6,  \vol, vol6);
			~l6c1.set(\dur, ~f6/~icd3,       \vol, vol6);  ~l6d1.set(\dur, ~f6/~icd3,  \vol, vol6);
			~l6e1.set(\dur, ~f6/~icd6,       \vol, vol6);  ~l6f1.set(\dur, ~f6/~icd6,  \vol, vol6);
			~l7a1.set(\dur, ~f7,    \vol, vol7);           ~l7b1.set(\dur, ~f7,  \vol, vol7);
			~l7c1.set(\dur, ~f7/~icd3,       \vol, vol7);  ~l7d1.set(\dur, ~f7/~icd3,  \vol, vol7);
			~l7e1.set(\dur, ~f7/~icd6,       \vol, vol7);  ~l7f1.set(\dur, ~f7/~icd6,  \vol, vol7);
			~l8a1.set(\dur, ~f8,    \vol, vol8);           ~l8b1.set(\dur, ~f8,  \vol, vol8);
			~l8c1.set(\dur, ~f8/~icd3,       \vol, vol8);  ~l8d1.set(\dur, ~f8/~icd3,  \vol, vol8);
			~l8e1.set(\dur, ~f8/~icd6,       \vol, vol8);  ~l8f1.set(\dur, ~f8/~icd6,  \vol, vol8);
		}););
	}
	{~l1a.isRunning == true} {
		(1.do({var vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8,s1,s2,s3,s4,s5,s6;
			#vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8 = [~vol1,~vol2,~vol3,~vol4,~vol5,~vol6,~vol7,~vol8];
			~l1a.set(\dur, ~f1,     \vol, vol1);  ~l1b.set(\dur, ~f1,  \vol, vol1);
			~l1c.set(\dur, ~f1/~icd3,       \vol, vol1);  ~l1d.set(\dur, ~f1/~icd3,  \vol, vol1);
			~l1e.set(\dur, ~f1/~icd6,       \vol, vol1);  ~l1f.set(\dur, ~f1/~icd6,  \vol, vol1);
			~l2a.set(\dur, ~f2,     \vol, vol2);          ~l2b.set(\dur, ~f2,  \vol, vol2);
			~l2c.set(\dur, ~f2/~icd3,       \vol, vol2);  ~l2d.set(\dur, ~f2/~icd3,  \vol, vol2);
			~l2e.set(\dur, ~f2/~icd6,       \vol, vol2);  ~l2f.set(\dur, ~f2/~icd6,  \vol, vol2);
			~l3a.set(\dur, ~f3,     \vol, vol3);          ~l3b.set(\dur, ~f3,  \vol, vol3);
			~l3c.set(\dur, ~f3/~icd3,       \vol, vol3);  ~l3d.set(\dur, ~f3/~icd3,  \vol, vol3);
			~l3e.set(\dur, ~f3/~icd6,       \vol, vol3);  ~l3f.set(\dur, ~f3/~icd6,  \vol, vol3);
			~l4a.set(\dur, ~f4,    \vol, vol4);           ~l4b.set(\dur, ~f4,  \vol, vol4);
			~l4c.set(\dur, ~f4/~icd3,       \vol, vol4);  ~l4d.set(\dur, ~f4/~icd3,  \vol, vol4);
			~l4e.set(\dur, ~f4/~icd6,       \vol, vol4);  ~l4f.set(\dur, ~f4/~icd6,  \vol, vol4);
			~l5a.set(\dur, ~f5,    \vol, vol5);           ~l5b.set(\dur, ~f5,  \vol, vol5);
			~l5c.set(\dur, ~f5/~icd3,       \vol, vol5);  ~l5d.set(\dur, ~f5/~icd3,  \vol, vol5);
			~l5e.set(\dur, ~f5/~icd6,       \vol, vol5);  ~l5f.set(\dur, ~f5/~icd6,  \vol, vol5);
			~l6a.set(\dur, ~f6,    \vol, vol6);           ~l6b.set(\dur, ~f6,  \vol, vol6);
			~l6c.set(\dur, ~f6/~icd3,       \vol, vol6);  ~l6d.set(\dur, ~f6/~icd3,  \vol, vol6);
			~l6e.set(\dur, ~f6/~icd6,       \vol, vol6);  ~l6f.set(\dur, ~f6/~icd6,  \vol, vol6);
			~l7a.set(\dur, ~f7,    \vol, vol7);           ~l7b.set(\dur, ~f7,  \vol, vol7);
			~l7c.set(\dur, ~f7/~icd3,       \vol, vol7);  ~l7d.set(\dur, ~f7/~icd3,  \vol, vol7);
			~l7e.set(\dur, ~f7/~icd6,       \vol, vol7);  ~l7f.set(\dur, ~f7/~icd6,  \vol, vol7);
			~l8a.set(\dur, ~f8,    \vol, vol8);           ~l8b.set(\dur, ~f8,  \vol, vol8);
			~l8c.set(\dur, ~f8/~icd3,       \vol, vol8);  ~l8d.set(\dur, ~f8/~icd3,  \vol, vol8);
			~l8e.set(\dur, ~f8/~icd6,       \vol, vol8);  ~l8f.set(\dur, ~f8/~icd6,  \vol, vol8);

		}););
	};
};

~synthslide = {case{~l1a1.isRunning == true}{(
	~slideroutine = Routine({
		1.do({var vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8,s1,s2,s3,s4,s5,s6;
			#vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8= [~vol1,~vol2,~vol3,~vol4,~vol5,~vol6,~vol7,~vol8];
			#g,h,i,j,k,l,m,n = (([ s,t,u,v,w,x,y,z ]-[ ~f1,~f2,~f3,~f4,~f5,~f6,~f7,~f8 ])*(-1)/~slidedo);
			~slidedo.do({([ s=s+g,t=t+h,u=u+i,v=v+j,w=w+k,x=x+l,y=y+m,z=z+n ];
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
				~l4a1.set(\dur, v, \vol, vol4);
				~l4b1.set(\dur, v, \vol, vol4);
				~l4c1.set(\dur, v/~icd3, \vol, vol4);
				~l4d1.set(\dur, v/~icd3, \vol, vol4);
				~l4e1.set(\dur, v/~icd6, \vol, vol4);
				~l4f1.set(\dur, v/~icd6, \vol, vol4);
				~l5a1.set(\dur, w, \vol, vol5);
				~l5b1.set(\dur, w, \vol, vol5);
				~l5c1.set(\dur, w/~icd3, \vol, vol5);
				~l5d1.set(\dur, w/~icd3, \vol, vol5);
				~l5e1.set(\dur, w/~icd6, \vol, vol5);
				~l5f1.set(\dur, w/~icd6, \vol, vol5);
				~l6a1.set(\dur, x, \vol, vol6);
				~l6b1.set(\dur, x, \vol, vol6);
				~l6c1.set(\dur, x/~icd3, \vol, vol6);
				~l6d1.set(\dur, x/~icd3, \vol, vol6);
				~l6e1.set(\dur, x/~icd6, \vol, vol6);
				~l6f1.set(\dur, x/~icd6, \vol, vol6);
				~l7a1.set(\dur, y, \vol, vol7);
				~l7b1.set(\dur, y, \vol, vol7);
				~l7c1.set(\dur, y/~icd3, \vol, vol7);
				~l7d1.set(\dur, y/~icd3, \vol, vol7);
				~l7e1.set(\dur, y/~icd6, \vol, vol7);
				~l7f1.set(\dur, y/~icd6, \vol, vol7);
				~l8a1.set(\dur, z, \vol, vol8);
				~l8b1.set(\dur, z, \vol, vol8);
				~l8c1.set(\dur, z/~icd3, \vol, vol8);
				~l8d1.set(\dur, z/~icd3, \vol, vol8);
				~l8e1.set(\dur, z/~icd6, \vol, vol8);
				~l8f1.set(\dur, z/~icd6, \vol, vol8);
				);
				(~slidetime/~slidedo).wait;
	});});}).play;);}{~l1a.isRunning == true} {(
		~slideroutine = Routine({1.do({var vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8,s1,s2,s3,s4,s5,s6;
			#vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8= [~vol1,~vol2,~vol3,~vol4,~vol5,~vol6,~vol7,~vol8];
			#g,h,i,j,k,l,m,n = (([ s,t,u,v,w,x,y,z ]-[ ~f1,~f2,~f3,~f4,~f5,~f6,~f7,~f8 ])*(-1)/~slidedo);
			~slidedo.do({([ s=s+g,t=t+h,u=u+i,v=v+j,w=w+k,x=x+l,y=y+m,z=z+n ];
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
				~l4a.set(\dur, v, \vol, vol4);
				~l4b.set(\dur, v, \vol, vol4);
				~l4c.set(\dur, v/~icd3, \vol, vol4);
				~l4d.set(\dur, v/~icd3, \vol, vol4);
				~l4e.set(\dur, v/~icd6, \vol, vol4);
				~l4f.set(\dur, v/~icd6, \vol, vol4);
				~l5a.set(\dur, w, \vol, vol5);
				~l5b.set(\dur, w, \vol, vol5);
				~l5c.set(\dur, w/~icd3, \vol, vol5);
				~l5d.set(\dur, w/~icd3, \vol, vol5);
				~l5e.set(\dur, w/~icd6, \vol, vol5);
				~l5f.set(\dur, w/~icd6, \vol, vol5);
				~l6a.set(\dur, x, \vol, vol6);
				~l6b.set(\dur, x, \vol, vol6);
				~l6c.set(\dur, x/~icd3, \vol, vol6);
				~l6d.set(\dur, x/~icd3, \vol, vol6);
				~l6e.set(\dur, x/~icd6, \vol, vol6);
				~l6f.set(\dur, x/~icd6, \vol, vol6);
				~l7a.set(\dur, y, \vol, vol7);
				~l7b.set(\dur, y, \vol, vol7);
				~l7c.set(\dur, y/~icd3, \vol, vol7);
				~l7d.set(\dur, y/~icd3, \vol, vol7);
				~l7e.set(\dur, y/~icd6, \vol, vol7);
				~l7f.set(\dur, y/~icd6, \vol, vol7);
				~l8a.set(\dur, z, \vol, vol8);
				~l8b.set(\dur, z, \vol, vol8);
				~l8c.set(\dur, z/~icd3, \vol, vol8);
				~l8d.set(\dur, z/~icd3, \vol, vol8);
				~l8e.set(\dur, z/~icd6, \vol, vol8);
				~l8f.set(\dur, z/~icd6, \vol, vol8);
				);
				(~slidetime/~slidedo).wait;});});
}).play;);};};


~synthpause = {(
	case
	{~l1a1.isRunning == true}{
		(1.do({var vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8,s1,s2,s3,s4,s5,s6,f1,f2,f3,f4,f5,f6,f7,f8;
			#vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8 = [~vol1,~vol2,~vol3,~vol4,~vol5,~vol6,~vol7,~vol8];
			#f1,f2,f3,f4,f5,f6,f7,f8 = [ 0,0,0,0,0,0,0,0 ];
			~l1a1.set(\dur, f1,     \vol, vol1);          ~l1b1.set(\dur, f1,  \vol, vol1);
			~l1c1.set(\dur, f1/~icd3,       \vol, vol1);  ~l1d1.set(\dur, f1/~icd3,  \vol, vol1);
			~l1e1.set(\dur, f1/~icd6,       \vol, vol1);  ~l1f1.set(\dur, f1/~icd6,  \vol, vol1);
			~l2a1.set(\dur, f2,     \vol, vol2);          ~l2b1.set(\dur, f2,  \vol, vol2);
			~l2c1.set(\dur, f2/~icd3,       \vol, vol2);  ~l2d1.set(\dur, f2/~icd3,  \vol, vol2);
			~l2e1.set(\dur, f2/~icd6,       \vol, vol2);  ~l2f1.set(\dur, f2/~icd6,  \vol, vol2);
			~l3a1.set(\dur, f3,     \vol, vol3);          ~l3b1.set(\dur, f3,  \vol, vol3);
			~l3c1.set(\dur, f3/~icd3,       \vol, vol3);  ~l3d1.set(\dur, f3/~icd3,  \vol, vol3);
			~l3e1.set(\dur, f3/~icd6,       \vol, vol3);  ~l3f1.set(\dur, f3/~icd6,  \vol, vol3);
			~l4a1.set(\dur, f4,    \vol, vol4);           ~l4b1.set(\dur, f4,  \vol, vol4);
			~l4c1.set(\dur, f4/~icd3,       \vol, vol4);  ~l4d1.set(\dur, f4/~icd3,  \vol, vol4);
			~l4e1.set(\dur, f4/~icd6,       \vol, vol4);  ~l4f1.set(\dur, f4/~icd6,  \vol, vol4);
			~l5a1.set(\dur, f5,    \vol, vol5);           ~l5b1.set(\dur, f5,  \vol, vol5);
			~l5c1.set(\dur, f5/~icd3,       \vol, vol5);  ~l5d1.set(\dur, f5/~icd3,  \vol, vol5);
			~l5e1.set(\dur, f5/~icd6,       \vol, vol5);  ~l5f1.set(\dur, f5/~icd6,  \vol, vol5);
			~l6a1.set(\dur, f6,    \vol, vol6);           ~l6b1.set(\dur, f6,  \vol, vol6);
			~l6c1.set(\dur, f6/~icd3,       \vol, vol6);  ~l6d1.set(\dur, f6/~icd3,  \vol, vol6);
			~l6e1.set(\dur, f6/~icd6,       \vol, vol6);  ~l6f1.set(\dur, f6/~icd6,  \vol, vol6);
			~l7a1.set(\dur, f7,    \vol, vol7);           ~l7b1.set(\dur, f7,  \vol, vol7);
			~l7c1.set(\dur, f7/~icd3,       \vol, vol7);  ~l7d1.set(\dur, f7/~icd3,  \vol, vol7);
			~l7e1.set(\dur, f7/~icd6,       \vol, vol7);  ~l7f1.set(\dur, f7/~icd6,  \vol, vol7);
			~l8a1.set(\dur, f8,    \vol, vol8);           ~l8b1.set(\dur, f8,  \vol, vol8);
			~l8c1.set(\dur, f8/~icd3,       \vol, vol8);  ~l8d1.set(\dur, f8/~icd3,  \vol, vol8);
			~l8e1.set(\dur, f8/~icd6,       \vol, vol8);  ~l8f1.set(\dur, f8/~icd6,  \vol, vol8);
		}););
	}
	{~l1a.isRunning == true} {
		(1.do({var vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8,s1,s2,s3,s4,s5,s6,f1,f2,f3,f4,f5,f6,f7,f8;
			#vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8 = [~vol1,~vol2,~vol3,~vol4,~vol5,~vol6,~vol7,~vol8];
			#f1,f2,f3,f4,f5,f6,f7,f8 = [ 0,0,0,0,0,0,0,0 ];
			~l1a.set(\dur, f1,     \vol, vol1);  ~l1b.set(\dur, f1,  \vol, vol1);
			~l1c.set(\dur, f1/~icd3,       \vol, vol1);  ~l1d.set(\dur, f1/~icd3,  \vol, vol1);
			~l1e.set(\dur, f1/~icd6,       \vol, vol1);  ~l1f.set(\dur, f1/~icd6,  \vol, vol1);
			~l2a.set(\dur, f2,     \vol, vol2);          ~l2b.set(\dur, f2,  \vol, vol2);
			~l2c.set(\dur, f2/~icd3,       \vol, vol2);  ~l2d.set(\dur, f2/~icd3,  \vol, vol2);
			~l2e.set(\dur, f2/~icd6,       \vol, vol2);  ~l2f.set(\dur, f2/~icd6,  \vol, vol2);
			~l3a.set(\dur, f3,     \vol, vol3);          ~l3b.set(\dur, f3,  \vol, vol3);
			~l3c.set(\dur, f3/~icd3,       \vol, vol3);  ~l3d.set(\dur, f3/~icd3,  \vol, vol3);
			~l3e.set(\dur, f3/~icd6,       \vol, vol3);  ~l3f.set(\dur, f3/~icd6,  \vol, vol3);
			~l4a.set(\dur, f4,    \vol, vol4);           ~l4b.set(\dur, f4,  \vol, vol4);
			~l4c.set(\dur, f4/~icd3,       \vol, vol4);  ~l4d.set(\dur, f4/~icd3,  \vol, vol4);
			~l4e.set(\dur, f4/~icd6,       \vol, vol4);  ~l4f.set(\dur, f4/~icd6,  \vol, vol4);
			~l5a.set(\dur, f5,    \vol, vol5);           ~l5b.set(\dur, f5,  \vol, vol5);
			~l5c.set(\dur, f5/~icd3,       \vol, vol5);  ~l5d.set(\dur, f5/~icd3,  \vol, vol5);
			~l5e.set(\dur, f5/~icd6,       \vol, vol5);  ~l5f.set(\dur, f5/~icd6,  \vol, vol5);
			~l6a.set(\dur, f6,    \vol, vol6);           ~l6b.set(\dur, f6,  \vol, vol6);
			~l6c.set(\dur, f6/~icd3,       \vol, vol6);  ~l6d.set(\dur, f6/~icd3,  \vol, vol6);
			~l6e.set(\dur, f6/~icd6,       \vol, vol6);  ~l6f.set(\dur, f6/~icd6,  \vol, vol6);
			~l7a.set(\dur, f7,    \vol, vol7);           ~l7b.set(\dur, f7,  \vol, vol7);
			~l7c.set(\dur, f7/~icd3,       \vol, vol7);  ~l7d.set(\dur, f7/~icd3,  \vol, vol7);
			~l7e.set(\dur, f7/~icd6,       \vol, vol7);  ~l7f.set(\dur, f7/~icd6,  \vol, vol7);
			~l8a.set(\dur, f8,    \vol, vol8);           ~l8b.set(\dur, f8,  \vol, vol8);
			~l8c.set(\dur, f8/~icd3,       \vol, vol8);  ~l8d.set(\dur, f8/~icd3,  \vol, vol8);
			~l8e.set(\dur, f8/~icd6,       \vol, vol8);  ~l8f.set(\dur, f8/~icd6,  \vol, vol8);

		}););
	};
	);
};

~synthfree = {
	(
		case
		{~l1a1.isRunning == true}{
			(1.do({var vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8,s1,s2,s3,s4,s5,s6,f1,f2,f3,f4,f5,f6,f7,f8;
				#vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8 = [~vol1,~vol2,~vol3,~vol4,~vol5,~vol6,~vol7,~vol8];
				#f1,f2,f3,f4,f5,f6,f7,f8 = [ 0,0,0,0,0,0,0,0 ];
				~l1a1.set(\dur, f1,     \vol, vol1);  ~l1b1.set(\dur, f1,  \vol, vol1);
				~l1c1.set(\dur, f1/~icd3,       \vol, vol1);  ~l1d1.set(\dur, f1/~icd3,  \vol, vol1);
				~l1e1.set(\dur, f1/~icd6,       \vol, vol1);  ~l1f1.set(\dur, f1/~icd6,  \vol, vol1);
				~l2a1.set(\dur, f2,     \vol, vol2);          ~l2b1.set(\dur, f2,  \vol, vol2);
				~l2c1.set(\dur, f2/~icd3,       \vol, vol2);  ~l2d1.set(\dur, f2/~icd3,  \vol, vol2);
				~l2e1.set(\dur, f2/~icd6,       \vol, vol2);  ~l2f1.set(\dur, f2/~icd6,  \vol, vol2);
				~l3a1.set(\dur, f3,     \vol, vol3);          ~l3b1.set(\dur, f3,  \vol, vol3);
				~l3c1.set(\dur, f3/~icd3,       \vol, vol3);  ~l3d1.set(\dur, f3/~icd3,  \vol, vol3);
				~l3e1.set(\dur, f3/~icd6,       \vol, vol3);  ~l3f1.set(\dur, f3/~icd6,  \vol, vol3);
				~l4a1.set(\dur, f4,    \vol, vol4);           ~l4b1.set(\dur, f4,  \vol, vol4);
				~l4c1.set(\dur, f4/~icd3,       \vol, vol4);  ~l4d1.set(\dur, f4/~icd3,  \vol, vol4);
				~l4e1.set(\dur, f4/~icd6,       \vol, vol4);  ~l4f1.set(\dur, f4/~icd6,  \vol, vol4);
				~l5a1.set(\dur, f5,    \vol, vol5);           ~l5b1.set(\dur, f5,  \vol, vol5);
				~l5c1.set(\dur, f5/~icd3,       \vol, vol5);  ~l5d1.set(\dur, f5/~icd3,  \vol, vol5);
				~l5e1.set(\dur, f5/~icd6,       \vol, vol5);  ~l5f1.set(\dur, f5/~icd6,  \vol, vol5);
				~l6a1.set(\dur, f6,    \vol, vol6);           ~l6b1.set(\dur, f6,  \vol, vol6);
				~l6c1.set(\dur, f6/~icd3,       \vol, vol6);  ~l6d1.set(\dur, f6/~icd3,  \vol, vol6);
				~l6e1.set(\dur, f6/~icd6,       \vol, vol6);  ~l6f1.set(\dur, f6/~icd6,  \vol, vol6);
				~l7a1.set(\dur, f7,    \vol, vol7);           ~l7b1.set(\dur, f7,  \vol, vol7);
				~l7c1.set(\dur, f7/~icd3,       \vol, vol7);  ~l7d1.set(\dur, f7/~icd3,  \vol, vol7);
				~l7e1.set(\dur, f7/~icd6,       \vol, vol7);  ~l7f1.set(\dur, f7/~icd6,  \vol, vol7);
				~l8a1.set(\dur, f8,    \vol, vol8);           ~l8b1.set(\dur, f8,  \vol, vol8);
				~l8c1.set(\dur, f8/~icd3,       \vol, vol8);  ~l8d1.set(\dur, f8/~icd3,  \vol, vol8);
				~l8e1.set(\dur, f8/~icd6,       \vol, vol8);  ~l8f1.set(\dur, f8/~icd6,  \vol, vol8);
			}););
			AppClock.sched(0.161803398875,{
				([~l1a1,~l1b1,~l1c1,~l1d1,~l1e1,~l1f1,~l2a1,~l2b1,~l2c1,~l2d1,~l2e1,~l2f1,~l3a1,~l3b1,~l3c1,~l3d1,~l3e1,~l3f1,~l4a1,~l4b1,~l4c1,~l4d1,~l4e1,~l4f1,~l5a1,~l5b1,~l5c1,~l5d1,~l5e1,~l5f1,~l6a1,~l6b1,~l6c1,~l6d1,~l6e1,~l6f1,~l7a1,~l7b1,~l7c1,~l7d1,~l7e1,~l7f1,~l8a1,~l8b1,~l8c1,~l8d1,~l8e1,~l8f1 ].do(_.free)); ~slideroutine.stop;
			});
		}
		{~l1a.isRunning == true}{
			(1.do({var vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8,s1,s2,s3,s4,s5,s6,f1,f2,f3,f4,f5,f6,f7,f8;
				#vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8 = [~vol1,~vol2,~vol3,~vol4,~vol5,~vol6,~vol7,~vol8];
				#f1,f2,f3,f4,f5,f6,f7,f8 = [ 0,0,0,0,0,0,0,0 ];
				~l1a.set(\dur, f1,     \vol, vol1);  ~l1b.set(\dur, f1,  \vol, vol1);
				~l1c.set(\dur, f1/~icd3,       \vol, vol1);  ~l1d.set(\dur, f1/~icd3,  \vol, vol1);
				~l1e.set(\dur, f1/~icd6,       \vol, vol1);  ~l1f.set(\dur, f1/~icd6,  \vol, vol1);
				~l2a.set(\dur, f2,     \vol, vol2);          ~l2b.set(\dur, f2,  \vol, vol2);
				~l2c.set(\dur, f2/~icd3,       \vol, vol2);  ~l2d.set(\dur, f2/~icd3,  \vol, vol2);
				~l2e.set(\dur, f2/~icd6,       \vol, vol2);  ~l2f.set(\dur, f2/~icd6,  \vol, vol2);
				~l3a.set(\dur, f3,     \vol, vol3);          ~l3b.set(\dur, f3,  \vol, vol3);
				~l3c.set(\dur, f3/~icd3,       \vol, vol3);  ~l3d.set(\dur, f3/~icd3,  \vol, vol3);
				~l3e.set(\dur, f3/~icd6,       \vol, vol3);  ~l3f.set(\dur, f3/~icd6,  \vol, vol3);
				~l4a.set(\dur, f4,    \vol, vol4);           ~l4b.set(\dur, f4,  \vol, vol4);
				~l4c.set(\dur, f4/~icd3,       \vol, vol4);  ~l4d.set(\dur, f4/~icd3,  \vol, vol4);
				~l4e.set(\dur, f4/~icd6,       \vol, vol4);  ~l4f.set(\dur, f4/~icd6,  \vol, vol4);
				~l5a.set(\dur, f5,    \vol, vol5);           ~l5b.set(\dur, f5,  \vol, vol5);
				~l5c.set(\dur, f5/~icd3,       \vol, vol5);  ~l5d.set(\dur, f5/~icd3,  \vol, vol5);
				~l5e.set(\dur, f5/~icd6,       \vol, vol5);  ~l5f.set(\dur, f5/~icd6,  \vol, vol5);
				~l6a.set(\dur, f6,    \vol, vol6);           ~l6b.set(\dur, f6,  \vol, vol6);
				~l6c.set(\dur, f6/~icd3,       \vol, vol6);  ~l6d.set(\dur, f6/~icd3,  \vol, vol6);
				~l6e.set(\dur, f6/~icd6,       \vol, vol6);  ~l6f.set(\dur, f6/~icd6,  \vol, vol6);
				~l7a.set(\dur, f7,    \vol, vol7);           ~l7b.set(\dur, f7,  \vol, vol7);
				~l7c.set(\dur, f7/~icd3,       \vol, vol7);  ~l7d.set(\dur, f7/~icd3,  \vol, vol7);
				~l7e.set(\dur, f7/~icd6,       \vol, vol7);  ~l7f.set(\dur, f7/~icd6,  \vol, vol7);
				~l8a.set(\dur, f8,    \vol, vol8);           ~l8b.set(\dur, f8,  \vol, vol8);
				~l8c.set(\dur, f8/~icd3,       \vol, vol8);  ~l8d.set(\dur, f8/~icd3,  \vol, vol8);
				~l8e.set(\dur, f8/~icd6,       \vol, vol8);  ~l8f.set(\dur, f8/~icd6,  \vol, vol8);
			}););
			AppClock.sched(0.161803398875,{
				([~l1a,~l1b,~l1c,~l1d,~l1e,~l1f,~l2a,~l2b,~l2c,~l2d,~l2e,~l2f,~l3a,~l3b,~l3c,~l3d,~l3e,~l3f,~l4a,~l4b,~l4c,~l4d,~l4e,~l4f,~l5a,~l5b,~l5c,~l5d,~l5e,~l5f,~l6a,~l6b,~l6c,~l6d,~l6e,~l6f,~l7a,~l7b,~l7c,~l7d,~l7e,~l7f,~l8a,~l8b,~l8c,~l8d,~l8e,~l8f].do(_.free)); ~slideroutine.stop;
			});
		};
	);
};
);

//Developed by Ken Brant (ken_brant@ymail.com)