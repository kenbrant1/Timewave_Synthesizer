/*Order of execution to run script and record:
1. Hit "Ctrl/Cmd - Enter" anywhere inside the "LOAD SYNTH FUNCTIONS" parenthesis on line 53,
2. Click on the same line as "START RECORDING" on line 50 and hit "Ctrl/Cmd - Enter",
3. Hit "Ctrl/Cmd - Enter" anywhere inside the "TASK" parenthesis on line 12...
The record file location will be found in the post window...
Leave out #2 to run the script without recording...
Important Note: You must load the appropriate Timewave Synthesizer program and run the synth by pressing the
"synth0" button at least once before this script can run.
Press "Ctrl/Cmd - Period" to stop synth/free the sever.

You can compose a piece, and find guides for doing so, inside the "//3 - TASK" function. */

((//3 - TASK
	t = Task({/*trace*/ ~st = 0; ~trace = {("event-"++(~st = ~st + 1).asString).postln;}; ~number_of_synths.do(x = 0; {("vol"++(x=x+1)).asSymbol.envirPut(/*volume*/ ~vol)});
		1.do({

			//duration of each chord
			a = 8;

			//copy and paste "saved" chords from the "copy" button inside the synthesizer program here:
			//choose to change each duration individually by changing the "a" variable in the code below this line, as well as "synthopen/synthflow/synthslide"
			~number_of_synths.do(x = 0; {("f"++(x=x+1)).asSymbol.envirPut([ 525.7244292648, 646.87931910571, 882.91913643716, 1181.3955692862, 706.55967076687, 711.25161146077, 977.22674582697, 662.50413564615, 0, 0, 0, 0 ].at(x-1))}); ~synthopen.value; ~trace.value; (a).wait;
			~number_of_synths.do(x = 0; {("f"++(x=x+1)).asSymbol.envirPut([ 654.05453931384, 879.03193048766, 941.25430167146, 1100.8670554563, 1316.2675385788, 1316.2675385788, 1316.2675385788, 658.1337692894, 0, 0, 0, 0 ].at(x-1))}); ~synthflow.value; ~trace.value; (a).wait;
			~number_of_synths.do(x = 0; {("f"++(x=x+1)).asSymbol.envirPut([ 654.05453931384, 879.03193048766, 941.25430167146, 1100.8670554563, 1316.2675385788, 1051.0271787501, 1051.0271787501, 525.51358937505, 0, 0, 0, 0 ].at(x-1))}); ~synthflow.value; ~trace.value; (a).wait;
			~number_of_synths.do(x = 0; {("f"++(x=x+1)).asSymbol.envirPut([ 654.05453931384, 879.03193048766, 941.25430167146, 1100.8670554563, 1316.2675385788, 937.1102649523, 937.1102649523, 937.1102649523, 0, 0, 0, 0 ].at(x-1))}); ~synthflow.value; ~trace.value; (a).wait;
			~number_of_synths.do(x = 0; {("f"++(x=x+1)).asSymbol.envirPut([ 654.05453931384, 879.03193048766, 941.25430167146, 1100.8670554563, 1316.2675385788, 824.55305817848, 824.55305817848, 822.73593638317, 0, 0, 0, 0 ].at(x-1))}); ~synthflow.value; ~trace.value; (a).wait;
			~number_of_synths.do(x = 0; {("f"++(x=x+1)).asSymbol.envirPut([ 654.05453931384, 879.03193048766, 941.25430167146, 1100.8670554563, 1316.2675385788, 824.55305817848, 1037.2062139187, 1037.2062139187, 0, 0, 0, 0 ].at(x-1))}); ~synthflow.value; ~trace.value; (a).wait;
			~number_of_synths.do(x = 0; {("f"++(x=x+1)).asSymbol.envirPut([ 654.05453931384, 879.03193048766, 941.25430167146, 1100.8670554563, 1316.2675385788, 554.31101031015, 554.31101031015, 554.31101031015, 0, 0, 0, 0 ].at(x-1))}); ~synthflow.value; ~trace.value; (a).wait;
			~number_of_synths.do(x = 0; {("f"++(x=x+1)).asSymbol.envirPut([ 654.05453931384, 879.03193048766, 941.25430167146, 521.10543213641, 521.10543213641, 521.10543213641, 521.10543213641, 521.10543213641, 0, 0, 0, 0 ].at(x-1))}); ~synthflow.value; ~trace.value; (a).wait;
			~number_of_synths.do(x = 0; {("f"++(x=x+1)).asSymbol.envirPut([ 525.7244292648, 646.87931910571, 882.91913643716, 1181.3955692862, 706.55967076687, 711.25161146077, 977.22674582697, 662.50413564615, 0, 0, 0, 0 ].at(x-1))}); ~synthopen.value; ~trace.value; (a).wait;
			~number_of_synths.do(x = 0; {("f"++(x=x+1)).asSymbol.envirPut([ 654.05453931384, 879.03193048766, 941.25430167146, 1100.8670554563, 1316.2675385788, 1316.2675385788, 1316.2675385788, 658.1337692894, 0, 0, 0, 0 ].at(x-1))}); ~synthflow.value; ~trace.value; (a).wait;
			~number_of_synths.do(x = 0; {("f"++(x=x+1)).asSymbol.envirPut([ 654.05453931384, 879.03193048766, 941.25430167146, 1100.8670554563, 1316.2675385788, 1051.0271787501, 1051.0271787501, 525.51358937505, 0, 0, 0, 0 ].at(x-1))}); ~synthflow.value; ~trace.value; (a).wait;
			~number_of_synths.do(x = 0; {("f"++(x=x+1)).asSymbol.envirPut([ 654.05453931384, 879.03193048766, 941.25430167146, 1100.8670554563, 1316.2675385788, 937.1102649523, 937.1102649523, 937.1102649523, 0, 0, 0, 0 ].at(x-1))}); ~synthflow.value; ~trace.value; (a).wait;
			~number_of_synths.do(x = 0; {("f"++(x=x+1)).asSymbol.envirPut([ 654.05453931384, 879.03193048766, 941.25430167146, 1100.8670554563, 1316.2675385788, 824.55305817848, 824.55305817848, 822.73593638317, 0, 0, 0, 0 ].at(x-1))}); ~synthflow.value; ~trace.value; (a).wait;
			~number_of_synths.do(x = 0; {("f"++(x=x+1)).asSymbol.envirPut([ 654.05453931384, 879.03193048766, 941.25430167146, 1100.8670554563, 1316.2675385788, 824.55305817848, 1037.2062139187, 1037.2062139187, 0, 0, 0, 0 ].at(x-1))}); ~synthflow.value; ~trace.value; (a).wait;
			~number_of_synths.do(x = 0; {("f"++(x=x+1)).asSymbol.envirPut([ 654.05453931384, 879.03193048766, 941.25430167146, 1100.8670554563, 1316.2675385788, 554.31101031015, 554.31101031015, 554.31101031015, 0, 0, 0, 0 ].at(x-1))}); ~synthflow.value; ~trace.value; (a).wait;
			~number_of_synths.do(x = 0; {("f"++(x=x+1)).asSymbol.envirPut([ 654.05453931384, 879.03193048766, 941.25430167146, 521.10543213641, 521.10543213641, 521.10543213641, 521.10543213641, 521.10543213641, 0, 0, 0, 0 ].at(x-1))}); ~synthflow.value; ~trace.value; (a).wait;

			//fade out function
			100.do({~number_of_synths.do(x = 0; {("vol"++(x=x+1)).asSymbol.envirPut(("vol"++x).asSymbol.envirGet - (~vol/100))}); ~synthflow.value; 0.1.wait;});

			//stop everything
			~synthfree.value; 2.wait; s.stopRecording;
			~number_of_synths.do(x = 0; {("vol"++(x=x+1)).asSymbol.envirPut(~vol)});

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
			(1.do({
				s.makeBundle(0, {
					(~number_of_synths).do(x = 0; {
						("l"++(x=x+1)++"a1").asSymbol.envirGet.do(_.set(\dur, 0));
						("l"++(x)++"b1").asSymbol.envirGet.do(_.set(\dur, 0));
						("l"++(x)++"c1").asSymbol.envirGet.do(_.set(\dur, 0));
						("l"++(x)++"d1").asSymbol.envirGet.do(_.set(\dur, 0));
						("l"++(x)++"e1").asSymbol.envirGet.do(_.set(\dur, 0));
						("l"++(x)++"f1").asSymbol.envirGet.do(_.set(\dur, 0));
					});
				});
			}););
		});

		(
			1.do({
				6.do(x = 0; {("s"++(x=x+1)).asSymbol.envirPut([\gsineicfld6, \gsineicrld6, \gsineicfld2, \gsineicrld2, \gsineicfld1, \gsineicrld1].at(x-1))});
				case
				{~sendreplysynthdef_on == 0}{~number_of_synths.do(x = 0; {("s5_"++(x=x+1)).asSymbol.envirPut(\gsineicfld1)});}
				{~sendreplysynthdef_on == 1}{~number_of_synths.do(x = 0; {("s5_"++(x=x+1)).asSymbol.envirPut(\gsineicfld1_f++(x))});};
				s.makeBundle(0, {
					(~number_of_synths).do(x = 0; {
						("l"++(x=x+1)++"a").asSymbol.envirPut(Synth(~s1,                        [\dur, ("f"++(x)).asSymbol.envirGet,       \lpfl, ~lpfl, \lpf_rq, ~lpf_rq, \vol, ("vol"++(x)).asSymbol.envirGet]).register;);
						("l"++(x)++"b").asSymbol.envirPut(Synth(~s2,                            [\dur, ("f"++(x)).asSymbol.envirGet,       \lpfl, ~lpfl, \lpf_rq, ~lpf_rq, \vol, ("vol"++(x)).asSymbol.envirGet]););
						("l"++(x)++"c").asSymbol.envirPut(Synth(~s3,                            [\dur, ("f"++(x)).asSymbol.envirGet/~icd3, \lpfl, ~lpfl, \lpf_rq, ~lpf_rq, \vol, ("vol"++(x)).asSymbol.envirGet]););
						("l"++(x)++"d").asSymbol.envirPut(Synth(~s4,                            [\dur, ("f"++(x)).asSymbol.envirGet/~icd3, \lpfl, ~lpfl, \lpf_rq, ~lpf_rq, \vol, ("vol"++(x)).asSymbol.envirGet]););
						("l"++(x)++"e").asSymbol.envirPut(Synth(("s5_"++(x)).asSymbol.envirGet, [\dur, ("f"++(x)).asSymbol.envirGet/~icd6, \lpfl, ~lpfl, \lpf_rq, ~lpf_rq, \vol, ("vol"++(x)).asSymbol.envirGet]););
						("l"++(x)++"f").asSymbol.envirPut(Synth(~s6,                            [\dur, ("f"++(x)).asSymbol.envirGet/~icd6, \lpfl, ~lpfl, \lpf_rq, ~lpf_rq, \vol, ("vol"++(x)).asSymbol.envirGet]););
					});
				});
			});
		);

		if(~l1a1.isRunning == true, {
			AppClock.sched(0.161803398875, {
				(x = 0; ((Array.fill(~number_of_synths, {[
					("l"++(x=x+1)++"a1").asSymbol.envirGet.do(_.free);
					("l"++(x)++"b1").asSymbol.envirGet.do(_.free);
					("l"++(x)++"c1").asSymbol.envirGet.do(_.free);
					("l"++(x)++"d1").asSymbol.envirGet.do(_.free);
					("l"++(x)++"e1").asSymbol.envirGet.do(_.free);
					("l"++(x)++"f1").asSymbol.envirGet.do(_.free);
				]}).flatten).do(_.free))); ~slideroutine.stop;
			});
		});
	}
	{~l1a.isRunning == true}{
		(1.do({
			s.makeBundle(0, {
				(~number_of_synths).do(x = 0; {
					("l"++(x=x+1)++"a").asSymbol.envirGet.do(_.set(\dur, 0));
					("l"++(x)++"b").asSymbol.envirGet.do(_.set(\dur, 0));
					("l"++(x)++"c").asSymbol.envirGet.do(_.set(\dur, 0));
					("l"++(x)++"d").asSymbol.envirGet.do(_.set(\dur, 0));
					("l"++(x)++"e").asSymbol.envirGet.do(_.set(\dur, 0));
					("l"++(x)++"f").asSymbol.envirGet.do(_.set(\dur, 0));
				});
			});
		}););

		(
			1.do({
				6.do(x = 0; {("s"++(x=x+1)).asSymbol.envirPut([\gsineicfld6, \gsineicrld6, \gsineicfld2, \gsineicrld2, \gsineicfld1, \gsineicrld1].at(x-1))});
				case
				{~sendreplysynthdef_on == 0}{~number_of_synths.do(x = 0; {("s5_"++(x=x+1)).asSymbol.envirPut(\gsineicfld1)});}
				{~sendreplysynthdef_on == 1}{~number_of_synths.do(x = 0; {("s5_"++(x=x+1)).asSymbol.envirPut(\gsineicfld1_f++(x))});};
				s.makeBundle(0, {
					(~number_of_synths).do(x = 0; {
						("l"++(x=x+1)++"a1").asSymbol.envirPut(Synth(~s1,                        [\dur, ("f"++(x)).asSymbol.envirGet,       \lpfl, ~lpfl, \lpf_rq, ~lpf_rq, \vol, ("vol"++(x)).asSymbol.envirGet]).register;);
						("l"++(x)++"b1").asSymbol.envirPut(Synth(~s2,                            [\dur, ("f"++(x)).asSymbol.envirGet,       \lpfl, ~lpfl, \lpf_rq, ~lpf_rq, \vol, ("vol"++(x)).asSymbol.envirGet]););
						("l"++(x)++"c1").asSymbol.envirPut(Synth(~s3,                            [\dur, ("f"++(x)).asSymbol.envirGet/~icd3, \lpfl, ~lpfl, \lpf_rq, ~lpf_rq, \vol, ("vol"++(x)).asSymbol.envirGet]););
						("l"++(x)++"d1").asSymbol.envirPut(Synth(~s4,                            [\dur, ("f"++(x)).asSymbol.envirGet/~icd3, \lpfl, ~lpfl, \lpf_rq, ~lpf_rq, \vol, ("vol"++(x)).asSymbol.envirGet]););
						("l"++(x)++"e1").asSymbol.envirPut(Synth(("s5_"++(x)).asSymbol.envirGet, [\dur, ("f"++(x)).asSymbol.envirGet/~icd6, \lpfl, ~lpfl, \lpf_rq, ~lpf_rq, \vol, ("vol"++(x)).asSymbol.envirGet]););
						("l"++(x)++"f1").asSymbol.envirPut(Synth(~s6,                            [\dur, ("f"++(x)).asSymbol.envirGet/~icd6, \lpfl, ~lpfl, \lpf_rq, ~lpf_rq, \vol, ("vol"++(x)).asSymbol.envirGet]););
					});
				});
			});
		);
		AppClock.sched(0.161803398875, {
			(x = 0; ((Array.fill(~number_of_synths, {[
				("l"++(x=x+1)++"a").asSymbol.envirGet.do(_.free);
				("l"++(x)++"b").asSymbol.envirGet.do(_.free);
				("l"++(x)++"c").asSymbol.envirGet.do(_.free);
				("l"++(x)++"d").asSymbol.envirGet.do(_.free);
				("l"++(x)++"e").asSymbol.envirGet.do(_.free);
				("l"++(x)++"f").asSymbol.envirGet.do(_.free);
			]}).flatten).do(_.free))); ~slideroutine.stop;
		});
	};
};

~synthflow = {
	case
	{~l1a1.isRunning == true}{
		(1.do({
			s.makeBundle(0, {
				(~number_of_synths).do(x = 0; {
					("l"++(x=x+1)++"a1").asSymbol.envirGet.do(_.set(\dur, ("f"++(x)).asSymbol.envirGet,       \lpfl, ~lpfl, \lpf_rq, ~lpf_rq, \vol, ("vol"++(x)).asSymbol.envirGet));
					("l"++(x)++"b1").asSymbol.envirGet.do(_.set(\dur,     ("f"++(x)).asSymbol.envirGet,       \lpfl, ~lpfl, \lpf_rq, ~lpf_rq, \vol, ("vol"++(x)).asSymbol.envirGet));
					("l"++(x)++"c1").asSymbol.envirGet.do(_.set(\dur,     ("f"++(x)).asSymbol.envirGet/~icd3, \lpfl, ~lpfl, \lpf_rq, ~lpf_rq, \vol, ("vol"++(x)).asSymbol.envirGet));
					("l"++(x)++"d1").asSymbol.envirGet.do(_.set(\dur,     ("f"++(x)).asSymbol.envirGet/~icd3, \lpfl, ~lpfl, \lpf_rq, ~lpf_rq, \vol, ("vol"++(x)).asSymbol.envirGet));
					("l"++(x)++"e1").asSymbol.envirGet.do(_.set(\dur,     ("f"++(x)).asSymbol.envirGet/~icd6, \lpfl, ~lpfl, \lpf_rq, ~lpf_rq, \vol, ("vol"++(x)).asSymbol.envirGet));
					("l"++(x)++"f1").asSymbol.envirGet.do(_.set(\dur,     ("f"++(x)).asSymbol.envirGet/~icd6, \lpfl, ~lpfl, \lpf_rq, ~lpf_rq, \vol, ("vol"++(x)).asSymbol.envirGet));
				});
			});
		}););
	}
	{~l1a.isRunning == true} {
		(1.do({
			s.makeBundle(0, {
				(~number_of_synths).do(x = 0; {
					("l"++(x=x+1)++"a").asSymbol.envirGet.do(_.set(\dur, ("f"++(x)).asSymbol.envirGet,       \lpfl, ~lpfl, \lpf_rq, ~lpf_rq, \vol, ("vol"++(x)).asSymbol.envirGet));
					("l"++(x)++"b").asSymbol.envirGet.do(_.set(\dur,     ("f"++(x)).asSymbol.envirGet,       \lpfl, ~lpfl, \lpf_rq, ~lpf_rq, \vol, ("vol"++(x)).asSymbol.envirGet));
					("l"++(x)++"c").asSymbol.envirGet.do(_.set(\dur,     ("f"++(x)).asSymbol.envirGet/~icd3, \lpfl, ~lpfl, \lpf_rq, ~lpf_rq, \vol, ("vol"++(x)).asSymbol.envirGet));
					("l"++(x)++"d").asSymbol.envirGet.do(_.set(\dur,     ("f"++(x)).asSymbol.envirGet/~icd3, \lpfl, ~lpfl, \lpf_rq, ~lpf_rq, \vol, ("vol"++(x)).asSymbol.envirGet));
					("l"++(x)++"e").asSymbol.envirGet.do(_.set(\dur,     ("f"++(x)).asSymbol.envirGet/~icd6, \lpfl, ~lpfl, \lpf_rq, ~lpf_rq, \vol, ("vol"++(x)).asSymbol.envirGet));
					("l"++(x)++"f").asSymbol.envirGet.do(_.set(\dur,     ("f"++(x)).asSymbol.envirGet/~icd6, \lpfl, ~lpfl, \lpf_rq, ~lpf_rq, \vol, ("vol"++(x)).asSymbol.envirGet));
				});
			});
		}););
	};
};

~synthslide = {
	case
	{~l1a1.isRunning == true}{(
		~slideroutine = Routine({1.do({
			~slidedo.do({~slidecount=~slidecount-1;
				(
					~number_of_synths.do(x = 0; {("f"++(x=x+1)).asSymbol.envirPut(("f"++(x)).asSymbol.envirGet + ("sf"++(x)).asSymbol.envirGet)});
					s.makeBundle(0, {
						(~number_of_synths).do(x = 0; {
							("l"++(x=x+1)++"a1").asSymbol.envirGet.do(_.set(\dur, ("f"++(x)).asSymbol.envirGet,       \lpfl, ~lpfl, \lpf_rq, ~lpf_rq, \vol, ("vol"++(x)).asSymbol.envirGet));
							("l"++(x)++"b1").asSymbol.envirGet.do(_.set(\dur,     ("f"++(x)).asSymbol.envirGet,       \lpfl, ~lpfl, \lpf_rq, ~lpf_rq, \vol, ("vol"++(x)).asSymbol.envirGet));
							("l"++(x)++"c1").asSymbol.envirGet.do(_.set(\dur,     ("f"++(x)).asSymbol.envirGet/~icd3, \lpfl, ~lpfl, \lpf_rq, ~lpf_rq, \vol, ("vol"++(x)).asSymbol.envirGet));
							("l"++(x)++"d1").asSymbol.envirGet.do(_.set(\dur,     ("f"++(x)).asSymbol.envirGet/~icd3, \lpfl, ~lpfl, \lpf_rq, ~lpf_rq, \vol, ("vol"++(x)).asSymbol.envirGet));
							("l"++(x)++"e1").asSymbol.envirGet.do(_.set(\dur,     ("f"++(x)).asSymbol.envirGet/~icd6, \lpfl, ~lpfl, \lpf_rq, ~lpf_rq, \vol, ("vol"++(x)).asSymbol.envirGet));
							("l"++(x)++"f1").asSymbol.envirGet.do(_.set(\dur,     ("f"++(x)).asSymbol.envirGet/~icd6, \lpfl, ~lpfl, \lpf_rq, ~lpf_rq, \vol, ("vol"++(x)).asSymbol.envirGet));
						});
					});
				);

				(~slidetime/~slidedo).wait;});
	});}).play;);}
	{~l1a.isRunning == true} {(
		~slideroutine = Routine({1.do({
			~slidedo.do({~slidecount=~slidecount-1;
				(
					~number_of_synths.do(x = 0; {("f"++(x=x+1)).asSymbol.envirPut(("f"++(x)).asSymbol.envirGet + ("sf"++(x)).asSymbol.envirGet)});
					s.makeBundle(0, {
						(~number_of_synths).do(x = 0; {
							("l"++(x=x+1)++"a").asSymbol.envirGet.do(_.set(\dur, ("f"++(x)).asSymbol.envirGet,       \lpfl, ~lpfl, \lpf_rq, ~lpf_rq, \vol, ("vol"++(x)).asSymbol.envirGet));
							("l"++(x)++"b").asSymbol.envirGet.do(_.set(\dur,     ("f"++(x)).asSymbol.envirGet,       \lpfl, ~lpfl, \lpf_rq, ~lpf_rq, \vol, ("vol"++(x)).asSymbol.envirGet));
							("l"++(x)++"c").asSymbol.envirGet.do(_.set(\dur,     ("f"++(x)).asSymbol.envirGet/~icd3, \lpfl, ~lpfl, \lpf_rq, ~lpf_rq, \vol, ("vol"++(x)).asSymbol.envirGet));
							("l"++(x)++"d").asSymbol.envirGet.do(_.set(\dur,     ("f"++(x)).asSymbol.envirGet/~icd3, \lpfl, ~lpfl, \lpf_rq, ~lpf_rq, \vol, ("vol"++(x)).asSymbol.envirGet));
							("l"++(x)++"e").asSymbol.envirGet.do(_.set(\dur,     ("f"++(x)).asSymbol.envirGet/~icd6, \lpfl, ~lpfl, \lpf_rq, ~lpf_rq, \vol, ("vol"++(x)).asSymbol.envirGet));
							("l"++(x)++"f").asSymbol.envirGet.do(_.set(\dur,     ("f"++(x)).asSymbol.envirGet/~icd6, \lpfl, ~lpfl, \lpf_rq, ~lpf_rq, \vol, ("vol"++(x)).asSymbol.envirGet));
						});
					});

				);

				(~slidetime/~slidedo).wait;});
	});}).play;);};
};


~synthpause = {(
	case
	{~l1a1.isRunning == true}{
		(1.do({
			s.makeBundle(0, {
				(~number_of_synths).do(x = 0; {
					("l"++(x=x+1)++"a1").asSymbol.envirGet.do(_.set(\dur, 0));
					("l"++(x)++"b1").asSymbol.envirGet.do(_.set(\dur, 0));
					("l"++(x)++"c1").asSymbol.envirGet.do(_.set(\dur, 0));
					("l"++(x)++"d1").asSymbol.envirGet.do(_.set(\dur, 0));
					("l"++(x)++"e1").asSymbol.envirGet.do(_.set(\dur, 0));
					("l"++(x)++"f1").asSymbol.envirGet.do(_.set(\dur, 0));
				});
			});
		}););
	}
	{~l1a.isRunning == true} {
		(1.do({
			s.makeBundle(0, {
				(~number_of_synths).do(x = 0; {
					("l"++(x=x+1)++"a").asSymbol.envirGet.do(_.set(\dur, 0));
					("l"++(x)++"b").asSymbol.envirGet.do(_.set(\dur, 0));
					("l"++(x)++"c").asSymbol.envirGet.do(_.set(\dur, 0));
					("l"++(x)++"d").asSymbol.envirGet.do(_.set(\dur, 0));
					("l"++(x)++"e").asSymbol.envirGet.do(_.set(\dur, 0));
					("l"++(x)++"f").asSymbol.envirGet.do(_.set(\dur, 0));
				});
			});
		}););
	};
);
};

~synthfree = {
	(
		case
		{~l1a1.isRunning == true}{
			(1.do({
				(~number_of_synths).do(x = 0; {
					("l"++(x=x+1)++"a1").asSymbol.envirGet.do(_.set(\dur, 0));
					("l"++(x)++"b1").asSymbol.envirGet.do(_.set(\dur, 0));
					("l"++(x)++"c1").asSymbol.envirGet.do(_.set(\dur, 0));
					("l"++(x)++"d1").asSymbol.envirGet.do(_.set(\dur, 0));
					("l"++(x)++"e1").asSymbol.envirGet.do(_.set(\dur, 0));
					("l"++(x)++"f1").asSymbol.envirGet.do(_.set(\dur, 0));
				});
			}););
			AppClock.sched(0.161803398875, {
				(x = 0; ((Array.fill(~number_of_synths, {[
					("l"++(x=x+1)++"a1").asSymbol.envirGet.do(_.free);
					("l"++(x)++"b1").asSymbol.envirGet.do(_.free);
					("l"++(x)++"c1").asSymbol.envirGet.do(_.free);
					("l"++(x)++"d1").asSymbol.envirGet.do(_.free);
					("l"++(x)++"e1").asSymbol.envirGet.do(_.free);
					("l"++(x)++"f1").asSymbol.envirGet.do(_.free);
				]}).flatten).do(_.free))); ~slideroutine.stop;
			});
		}
		{~l1a.isRunning == true}{
			(1.do({
				(~number_of_synths).do(x = 0; {
					("l"++(x=x+1)++"a").asSymbol.envirGet.do(_.set(\dur, 0));
					("l"++(x)++"b").asSymbol.envirGet.do(_.set(\dur, 0));
					("l"++(x)++"c").asSymbol.envirGet.do(_.set(\dur, 0));
					("l"++(x)++"d").asSymbol.envirGet.do(_.set(\dur, 0));
					("l"++(x)++"e").asSymbol.envirGet.do(_.set(\dur, 0));
					("l"++(x)++"f").asSymbol.envirGet.do(_.set(\dur, 0));
				});
			}););
			AppClock.sched(0.161803398875, {
				(x = 0; ((Array.fill(~number_of_synths, {[
					("l"++(x=x+1)++"a").asSymbol.envirGet.do(_.free);
					("l"++(x)++"b").asSymbol.envirGet.do(_.free);
					("l"++(x)++"c").asSymbol.envirGet.do(_.free);
					("l"++(x)++"d").asSymbol.envirGet.do(_.free);
					("l"++(x)++"e").asSymbol.envirGet.do(_.free);
					("l"++(x)++"f").asSymbol.envirGet.do(_.free);
				]}).flatten).do(_.free))); ~slideroutine.stop;
			});
		};
	);
};
);

/* e-mail: ken_brant@ymail.com */