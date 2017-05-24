/*Order of execution to run script and record(goes from bottom to top):
1. Hit "Ctrl/Cmd - Enter" anywhere inside the "LOAD SYNTH FUNCTIONS" parenthesis,
2. Click on the same line as "START RECORDING;" (above the "LOAD SYNTH FUNCTIONS" parenthesis) and hit "Ctrl/Cmd - Enter",
3. Hit "Ctrl/Cmd - Enter" anywhere inside the "TASK" parenthesis above the "START RECORDING;" line...
The record file location will be found in the post window...
Leave out #2 to run the script without recording...
Important Note: You must load the Timewave Synthesizer program and press the "synth0" button at least once before this script can run.
Press "Ctrl/Cmd - Period" to stop synth/free the sever. */

((//3 - TASK
	t = Task({~st = 0; ~trace = {("event-"++(~st = ~st + 1).asString).postln;};
		~vol = 0.005;~vol1 = ~vol;~vol2 = ~vol;~vol3 = ~vol;~vol4 = ~vol;~vol5 = ~vol;~vol6 = ~vol;~vol7 = ~vol;~vol8 = ~vol;~vol9 = ~vol;~vol10 = ~vol;~vol11 = ~vol;~vol12 = ~vol;
		1.do({

			//duration of each chord
			a = 32;

			//copy and paste "saved" chords from the "copy" button inside the synthesizer program here:
			//choose to change each duration individually by changing the "a" variable in the code below this line, as well as "synthopen/synthflow"
			[~f1=519.95703782873,~f2=616.23193196285,~f3=667.17109017758,~f4=692.66874234338,~f5=526.88556162392,~f6=516.52701736121,~f7=508.61137210833,~f8=506.37212156992]; ~synthopen.value; ~trace.value; (a).wait;
			[~f1=572.96170615003,~f2=572.96170615003,~f3=570.43914200903,~f4=570.43914200903,~f5=570.43914200903,~f6=516.52701736121,~f7=508.61137210833,~f8=506.37212156992]; ~synthflow.value; ~trace.value; (a).wait;
			[~f1=572.96170615003,~f2=572.96170615003,~f3=709.68417951408,~f4=709.68417951408,~f5=661.30934745052,~f6=590.93477690798,~f7=575.49542543341,~f8=551.87055912019]; ~synthflow.value; ~trace.value; (a).wait;
			[~f1=680.55068318264,~f2=680.55068318264,~f3=680.55068318264,~f4=680.55068318264,~f5=680.55068318264,~f6=590.93477690798,~f7=575.49542543341,~f8=551.87055912019]; ~synthflow.value; ~trace.value; (a).wait;
			[~f1=680.55068318264,~f2=824.55305817848,~f3=770.04531637521,~f4=741.69937490481,~f5=715.97470919404,~f6=590.93477690798,~f7=575.49542543341,~f8=551.87055912019]; ~synthflow.value; ~trace.value; (a).wait;
			[~f1=284.07777031607,~f2=285.96420129413,~f3=300.84921067741,~f4=341.16370743965,~f5=374.28694757008,~f6=478.14339589558,~f7=536.26742041046,~f8=579.31702821866]; ~synthflow.value; ~trace.value; (a).wait;
			[~f1=284.07777031607,~f2=444.56939292983,~f3=444.56939292983,~f4=444.56939292983,~f5=444.56939292983,~f6=478.14339589558,~f7=536.26742041046,~f8=579.31702821866]; ~synthflow.value; ~trace.value; (a).wait;
			[~f1=284.07777031607,~f2=392.035694412,~f3=392.035694412,~f4=392.9015574105,~f5=392.9015574105,~f6=478.14339589558,~f7=536.26742041046,~f8=579.31702821866]; ~synthflow.value; ~trace.value; (a).wait;

			//fade out function
			b=0.00005;100.do({~vol1=~vol1-b;~vol2=~vol2-b;~vol3=~vol3-b;~vol4=~vol4-b;~vol5=~vol5-b;~vol6=~vol6-b;~vol7=~vol7-b;~vol8=~vol8-b;~synthflow.value;0.1.wait;});

			//stop everything
			~synthfree.value; 2.wait; s.stopRecording;
			~vol = 0.005;~vol1 = ~vol;~vol2 = ~vol;~vol3 = ~vol;~vol4 = ~vol;~vol5 = ~vol;~vol6 = ~vol;~vol7 = ~vol;~vol8 = ~vol;~vol9 = ~vol;~vol10 = ~vol;~vol11 = ~vol;~vol12 = ~vol;

});}););
t.play;
);

s.record; //2 - START RECORDING
s.stopRecording; // STOP RECORDING

(//1 - LOAD SYNTH FUNCTIONS
~synthopen = {
		case
		{((~l1a.isRunning == false) and: (~l1a1.isRunning == false)) or: ~l1a1.isRunning == true}{
			(1.do({var vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8,s1,s2,s3,s4,s5,s6,f1,f2,f3,f4,f5,f6,f7,f8,tune=0;
				#vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8 = [~vol1,~vol2,~vol3,~vol4,~vol5,~vol6,~vol7,~vol8];
				#f1,f2,f3,f4,f5,f6,f7,f8 = [ 0,0,0,0,0,0,0,0 ];
				~l1a1.set(\dur, f1,     \vol, vol1, \tune, tune);  ~l1b1.set(\dur, f1,  \vol, vol1, \tune, tune);
				~l1c1.set(\dur, f1/~icd3,       \vol, vol1, \tune, tune);  ~l1d1.set(\dur, f1/~icd3,  \vol, vol1, \tune, tune);
				~l1e1.set(\dur, f1/~icd6,       \vol, vol1, \tune, tune);  ~l1f1.set(\dur, f1/~icd6,  \vol, vol1, \tune, tune);
				~l2a1.set(\dur, f2,     \vol, vol2, \tune, tune);          ~l2b1.set(\dur, f2,  \vol, vol2, \tune, tune);
				~l2c1.set(\dur, f2/~icd3,       \vol, vol2, \tune, tune);  ~l2d1.set(\dur, f2/~icd3,  \vol, vol2, \tune, tune);
				~l2e1.set(\dur, f2/~icd6,       \vol, vol2, \tune, tune);  ~l2f1.set(\dur, f2/~icd6,  \vol, vol2, \tune, tune);
				~l3a1.set(\dur, f3,     \vol, vol3, \tune, tune);          ~l3b1.set(\dur, f3,  \vol, vol3, \tune, tune);
				~l3c1.set(\dur, f3/~icd3,       \vol, vol3, \tune, tune);  ~l3d1.set(\dur, f3/~icd3,  \vol, vol3, \tune, tune);
				~l3e1.set(\dur, f3/~icd6,       \vol, vol3, \tune, tune);  ~l3f1.set(\dur, f3/~icd6,  \vol, vol3, \tune, tune);
				~l4a1.set(\dur, f4,    \vol, vol4, \tune, tune);           ~l4b1.set(\dur, f4,  \vol, vol4, \tune, tune);
				~l4c1.set(\dur, f4/~icd3,       \vol, vol4, \tune, tune);  ~l4d1.set(\dur, f4/~icd3,  \vol, vol4, \tune, tune);
				~l4e1.set(\dur, f4/~icd6,       \vol, vol4, \tune, tune);  ~l4f1.set(\dur, f4/~icd6,  \vol, vol4, \tune, tune);
				~l5a1.set(\dur, f5,    \vol, vol5, \tune, tune);           ~l5b1.set(\dur, f5,  \vol, vol5, \tune, tune);
				~l5c1.set(\dur, f5/~icd3,       \vol, vol5, \tune, tune);  ~l5d1.set(\dur, f5/~icd3,  \vol, vol5, \tune, tune);
				~l5e1.set(\dur, f5/~icd6,       \vol, vol5, \tune, tune);  ~l5f1.set(\dur, f5/~icd6,  \vol, vol5, \tune, tune);
				~l6a1.set(\dur, f6,    \vol, vol6, \tune, tune);           ~l6b1.set(\dur, f6,  \vol, vol6, \tune, tune);
				~l6c1.set(\dur, f6/~icd3,       \vol, vol6, \tune, tune);  ~l6d1.set(\dur, f6/~icd3,  \vol, vol6, \tune, tune);
				~l6e1.set(\dur, f6/~icd6,       \vol, vol6, \tune, tune);  ~l6f1.set(\dur, f6/~icd6,  \vol, vol6, \tune, tune);
				~l7a1.set(\dur, f7,    \vol, vol7, \tune, tune);           ~l7b1.set(\dur, f7,  \vol, vol7, \tune, tune);
				~l7c1.set(\dur, f7/~icd3,       \vol, vol7, \tune, tune);  ~l7d1.set(\dur, f7/~icd3,  \vol, vol7, \tune, tune);
				~l7e1.set(\dur, f7/~icd6,       \vol, vol7, \tune, tune);  ~l7f1.set(\dur, f7/~icd6,  \vol, vol7, \tune, tune);
				~l8a1.set(\dur, f8,    \vol, vol8, \tune, tune);           ~l8b1.set(\dur, f8,  \vol, vol8, \tune, tune);
				~l8c1.set(\dur, f8/~icd3,       \vol, vol8, \tune, tune);  ~l8d1.set(\dur, f8/~icd3,  \vol, vol8, \tune, tune);
				~l8e1.set(\dur, f8/~icd6,       \vol, vol8, \tune, tune);  ~l8f1.set(\dur, f8/~icd6,  \vol, vol8, \tune, tune);
			}););

			(
				1.do({var vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8,vol9,vol10,vol11,vol12,s1,s2,s3,s4,s5,s6,f1,f2,f3,f4,f5,f6,f7,f8,tune=0;
					#vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8 = [~vol1,~vol2,~vol3,~vol4,~vol5,~vol6,~vol7,~vol8];
					#s1,s2,s3,s4,s5,s6 = [\gsineicfld6, \gsineicrld6, \gsineicfld2, \gsineicrld2, \gsineicfld1, \gsineicrld1];
					~l1a = Synth(s1, [\dur, ~f1,    \vol, vol1, \tune, tune]).register;    ~l1b = Synth(s2, [\dur, ~f1,    \vol, vol1, \tune, tune]);
					~l1c = Synth(s3, [\dur, ~f1/~icd3,  \vol, vol1, \tune, tune]);   ~l1d = Synth(s4, [\dur, ~f1/~icd3,  \vol, vol1, \tune, tune]);
					~l1e = Synth(s5, [\dur, ~f1/~icd6,  \vol, vol1, \tune, tune]);   ~l1f = Synth(s6, [\dur, ~f1/~icd6,  \vol, vol1, \tune, tune]);
					~l2a = Synth(s1, [\dur, ~f2,    \vol, vol2, \tune, tune]);        ~l2b = Synth(s2, [\dur, ~f2,    \vol, vol2, \tune, tune]);
					~l2c = Synth(s3, [\dur, ~f2/~icd3,  \vol, vol2, \tune, tune]);   ~l2d = Synth(s4, [\dur, ~f2/~icd3,  \vol, vol2, \tune, tune]);
					~l2e = Synth(s5, [\dur, ~f2/~icd6,  \vol, vol2, \tune, tune]);   ~l2f = Synth(s6, [\dur, ~f2/~icd6,  \vol, vol2, \tune, tune]);
					~l3a = Synth(s1, [\dur, ~f3,    \vol, vol3, \tune, tune]);        ~l3b = Synth(s2, [\dur, ~f3,   \vol, vol3, \tune, tune]);
					~l3c = Synth(s3, [\dur, ~f3/~icd3,  \vol, vol3, \tune, tune]);   ~l3d = Synth(s4, [\dur, ~f3/~icd3, \vol, vol3, \tune, tune]);
					~l3e = Synth(s5, [\dur, ~f3/~icd6,  \vol, vol3, \tune, tune]);   ~l3f = Synth(s6, [\dur, ~f3/~icd6, \vol, vol3, \tune, tune]);
					~l4a = Synth(s1, [\dur, ~f4,    \vol, vol4, \tune, tune]);       ~l4b = Synth(s2, [\dur, ~f4,   \vol, vol4, \tune, tune]);
					~l4c = Synth(s3, [\dur, ~f4/~icd3,  \vol, vol4, \tune, tune]);  ~l4d = Synth(s4, [\dur, ~f4/~icd3, \vol, vol4, \tune, tune]);
					~l4e = Synth(s5, [\dur, ~f4/~icd6,  \vol, vol4, \tune, tune]);   ~l4f = Synth(s6, [\dur, ~f4/~icd6, \vol, vol4, \tune, tune]);
					~l5a = Synth(s1, [\dur, ~f5,    \vol, vol5, \tune, tune]);       ~l5b = Synth(s2, [\dur, ~f5,   \vol, vol5, \tune, tune]);
					~l5c = Synth(s3, [\dur, ~f5/~icd3,  \vol, vol5, \tune, tune]);   ~l5d = Synth(s4, [\dur, ~f5/~icd3, \vol, vol5, \tune, tune]);
					~l5e = Synth(s5, [\dur, ~f5/~icd6,  \vol, vol5, \tune, tune]);   ~l5f = Synth(s6, [\dur, ~f5/~icd6, \vol, vol5, \tune, tune]);
					~l6a = Synth(s1, [\dur, ~f6,    \vol, vol6, \tune, tune]);       ~l6b = Synth(s2, [\dur, ~f6,   \vol, vol6, \tune, tune]);
					~l6c = Synth(s3, [\dur, ~f6/~icd3,  \vol, vol6, \tune, tune]);   ~l6d = Synth(s4, [\dur, ~f6/~icd3, \vol, vol6, \tune, tune]);
					~l6e = Synth(s5, [\dur, ~f6/~icd6,  \vol, vol6, \tune, tune]);   ~l6f = Synth(s6, [\dur, ~f6/~icd6, \vol, vol6, \tune, tune]);
					~l7a = Synth(s1, [\dur, ~f7,    \vol, vol7, \tune, tune]);       ~l7b = Synth(s2, [\dur, ~f7,   \vol, vol7, \tune, tune]);
					~l7c = Synth(s3, [\dur, ~f7/~icd3,  \vol, vol7, \tune, tune]);   ~l7d = Synth(s4, [\dur, ~f7/~icd3, \vol, vol7, \tune, tune]);
					~l7e = Synth(s5, [\dur, ~f7/~icd6,  \vol, vol7, \tune, tune]);   ~l7f = Synth(s6, [\dur, ~f7/~icd6, \vol, vol7, \tune, tune]);
					~l8a = Synth(s1, [\dur, ~f8,    \vol, vol8, \tune, tune]);  ~l8b = Synth(s2, [\dur, ~f8,   \vol, vol8, \tune, tune]);
					~l8c = Synth(s3, [\dur, ~f8/~icd3,  \vol, vol8, \tune, tune]);   ~l8d = Synth(s4, [\dur, ~f8/~icd3, \vol, vol8, \tune, tune]);
					~l8e = Synth(s5, [\dur, ~f8/~icd6,  \vol, vol8, \tune, tune]);   ~l8f = Synth(s6, [\dur, ~f8/~icd6, \vol, vol8, \tune, tune]);

				});
			);
			AppClock.sched(0.161803398875,{
				([~l1a1,~l1b1,~l1c1,~l1d1,~l1e1,~l1f1,~l2a1,~l2b1,~l2c1,~l2d1,~l2e1,~l2f1,~l3a1,~l3b1,~l3c1,~l3d1,~l3e1,~l3f1,~l4a1,~l4b1,~l4c1,~l4d1,~l4e1,~l4f1,~l5a1,~l5b1,~l5c1,~l5d1,~l5e1,~l5f1,~l6a1,~l6b1,~l6c1,~l6d1,~l6e1,~l6f1,~l7a1,~l7b1,~l7c1,~l7d1,~l7e1,~l7f1,~l8a1,~l8b1,~l8c1,~l8d1,~l8e1,~l8f1 ].do(_.free)); ~slideroutine.stop;
			});
		}
		{~l1a.isRunning == true}{
			(1.do({var vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8,s1,s2,s3,s4,s5,s6,f1,f2,f3,f4,f5,f6,f7,f8,tune=0;
				#vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8 = [~vol1,~vol2,~vol3,~vol4,~vol5,~vol6,~vol7,~vol8];
				#f1,f2,f3,f4,f5,f6,f7,f8 = [ 0,0,0,0,0,0,0,0 ];
				~l1a.set(\dur, f1,     \vol, vol1, \tune, tune);  ~l1b.set(\dur, f1,  \vol, vol1, \tune, tune);
				~l1c.set(\dur, f1/~icd3,       \vol, vol1, \tune, tune);  ~l1d.set(\dur, f1/~icd3,  \vol, vol1, \tune, tune);
				~l1e.set(\dur, f1/~icd6,       \vol, vol1, \tune, tune);  ~l1f.set(\dur, f1/~icd6,  \vol, vol1, \tune, tune);
				~l2a.set(\dur, f2,     \vol, vol2, \tune, tune);          ~l2b.set(\dur, f2,  \vol, vol2, \tune, tune);
				~l2c.set(\dur, f2/~icd3,       \vol, vol2, \tune, tune);  ~l2d.set(\dur, f2/~icd3,  \vol, vol2, \tune, tune);
				~l2e.set(\dur, f2/~icd6,       \vol, vol2, \tune, tune);  ~l2f.set(\dur, f2/~icd6,  \vol, vol2, \tune, tune);
				~l3a.set(\dur, f3,     \vol, vol3, \tune, tune);          ~l3b.set(\dur, f3,  \vol, vol3, \tune, tune);
				~l3c.set(\dur, f3/~icd3,       \vol, vol3, \tune, tune);  ~l3d.set(\dur, f3/~icd3,  \vol, vol3, \tune, tune);
				~l3e.set(\dur, f3/~icd6,       \vol, vol3, \tune, tune);  ~l3f.set(\dur, f3/~icd6,  \vol, vol3, \tune, tune);
				~l4a.set(\dur, f4,    \vol, vol4, \tune, tune);           ~l4b.set(\dur, f4,  \vol, vol4, \tune, tune);
				~l4c.set(\dur, f4/~icd3,       \vol, vol4, \tune, tune);  ~l4d.set(\dur, f4/~icd3,  \vol, vol4, \tune, tune);
				~l4e.set(\dur, f4/~icd6,       \vol, vol4, \tune, tune);  ~l4f.set(\dur, f4/~icd6,  \vol, vol4, \tune, tune);
				~l5a.set(\dur, f5,    \vol, vol5, \tune, tune);           ~l5b.set(\dur, f5,  \vol, vol5, \tune, tune);
				~l5c.set(\dur, f5/~icd3,       \vol, vol5, \tune, tune);  ~l5d.set(\dur, f5/~icd3,  \vol, vol5, \tune, tune);
				~l5e.set(\dur, f5/~icd6,       \vol, vol5, \tune, tune);  ~l5f.set(\dur, f5/~icd6,  \vol, vol5, \tune, tune);
				~l6a.set(\dur, f6,    \vol, vol6, \tune, tune);           ~l6b.set(\dur, f6,  \vol, vol6, \tune, tune);
				~l6c.set(\dur, f6/~icd3,       \vol, vol6, \tune, tune);  ~l6d.set(\dur, f6/~icd3,  \vol, vol6, \tune, tune);
				~l6e.set(\dur, f6/~icd6,       \vol, vol6, \tune, tune);  ~l6f.set(\dur, f6/~icd6,  \vol, vol6, \tune, tune);
				~l7a.set(\dur, f7,    \vol, vol7, \tune, tune);           ~l7b.set(\dur, f7,  \vol, vol7, \tune, tune);
				~l7c.set(\dur, f7/~icd3,       \vol, vol7, \tune, tune);  ~l7d.set(\dur, f7/~icd3,  \vol, vol7, \tune, tune);
				~l7e.set(\dur, f7/~icd6,       \vol, vol7, \tune, tune);  ~l7f.set(\dur, f7/~icd6,  \vol, vol7, \tune, tune);
				~l8a.set(\dur, f8,    \vol, vol8, \tune, tune);           ~l8b.set(\dur, f8,  \vol, vol8, \tune, tune);
				~l8c.set(\dur, f8/~icd3,       \vol, vol8, \tune, tune);  ~l8d.set(\dur, f8/~icd3,  \vol, vol8, \tune, tune);
				~l8e.set(\dur, f8/~icd6,       \vol, vol8, \tune, tune);  ~l8f.set(\dur, f8/~icd6,  \vol, vol8, \tune, tune);
			}););

			(
				1.do({var vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8,vol9,vol10,vol11,vol12,s1,s2,s3,s4,s5,s6,f1,f2,f3,f4,f5,f6,f7,f8,tune=0;
					#vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8 = [~vol1,~vol2,~vol3,~vol4,~vol5,~vol6,~vol7,~vol8];
					#s1,s2,s3,s4,s5,s6 = [\gsineicfld6, \gsineicrld6, \gsineicfld2, \gsineicrld2, \gsineicfld1, \gsineicrld1];
					~l1a1 = Synth(s1, [\dur, ~f1,    \vol, vol1, \tune, tune]).register;    ~l1b1 = Synth(s2, [\dur, ~f1,    \vol, vol1, \tune, tune]);
					~l1c1 = Synth(s3, [\dur, ~f1/~icd3,  \vol, vol1, \tune, tune]);   ~l1d1 = Synth(s4, [\dur, ~f1/~icd3,  \vol, vol1, \tune, tune]);
					~l1e1 = Synth(s5, [\dur, ~f1/~icd6,  \vol, vol1, \tune, tune]);   ~l1f1 = Synth(s6, [\dur, ~f1/~icd6,  \vol, vol1, \tune, tune]);
					~l2a1 = Synth(s1, [\dur, ~f2,    \vol, vol2, \tune, tune]);        ~l2b1 = Synth(s2, [\dur, ~f2,    \vol, vol2, \tune, tune]);
					~l2c1 = Synth(s3, [\dur, ~f2/~icd3,  \vol, vol2, \tune, tune]);   ~l2d1 = Synth(s4, [\dur, ~f2/~icd3,  \vol, vol2, \tune, tune]);
					~l2e1 = Synth(s5, [\dur, ~f2/~icd6,  \vol, vol2, \tune, tune]);   ~l2f1 = Synth(s6, [\dur, ~f2/~icd6,  \vol, vol2, \tune, tune]);
					~l3a1 = Synth(s1, [\dur, ~f3,    \vol, vol3, \tune, tune]);        ~l3b1 = Synth(s2, [\dur, ~f3,   \vol, vol3, \tune, tune]);
					~l3c1 = Synth(s3, [\dur, ~f3/~icd3,  \vol, vol3, \tune, tune]);   ~l3d1 = Synth(s4, [\dur, ~f3/~icd3, \vol, vol3, \tune, tune]);
					~l3e1 = Synth(s5, [\dur, ~f3/~icd6,  \vol, vol3, \tune, tune]);   ~l3f1 = Synth(s6, [\dur, ~f3/~icd6, \vol, vol3, \tune, tune]);
					~l4a1 = Synth(s1, [\dur, ~f4,    \vol, vol4, \tune, tune]);       ~l4b1 = Synth(s2, [\dur, ~f4,   \vol, vol4, \tune, tune]);
					~l4c1 = Synth(s3, [\dur, ~f4/~icd3,  \vol, vol4, \tune, tune]);  ~l4d1 = Synth(s4, [\dur, ~f4/~icd3, \vol, vol4, \tune, tune]);
					~l4e1 = Synth(s5, [\dur, ~f4/~icd6,  \vol, vol4, \tune, tune]);   ~l4f1 = Synth(s6, [\dur, ~f4/~icd6, \vol, vol4, \tune, tune]);
					~l5a1 = Synth(s1, [\dur, ~f5,    \vol, vol5, \tune, tune]);       ~l5b1 = Synth(s2, [\dur, ~f5,   \vol, vol5, \tune, tune]);
					~l5c1 = Synth(s3, [\dur, ~f5/~icd3,  \vol, vol5, \tune, tune]);   ~l5d1 = Synth(s4, [\dur, ~f5/~icd3, \vol, vol5, \tune, tune]);
					~l5e1 = Synth(s5, [\dur, ~f5/~icd6,  \vol, vol5, \tune, tune]);   ~l5f1 = Synth(s6, [\dur, ~f5/~icd6, \vol, vol5, \tune, tune]);
					~l6a1 = Synth(s1, [\dur, ~f6,    \vol, vol6, \tune, tune]);       ~l6b1 = Synth(s2, [\dur, ~f6,   \vol, vol6, \tune, tune]);
					~l6c1 = Synth(s3, [\dur, ~f6/~icd3,  \vol, vol6, \tune, tune]);   ~l6d1 = Synth(s4, [\dur, ~f6/~icd3, \vol, vol6, \tune, tune]);
					~l6e1 = Synth(s5, [\dur, ~f6/~icd6,  \vol, vol6, \tune, tune]);   ~l6f1 = Synth(s6, [\dur, ~f6/~icd6, \vol, vol6, \tune, tune]);
					~l7a1 = Synth(s1, [\dur, ~f7,    \vol, vol7, \tune, tune]);       ~l7b1 = Synth(s2, [\dur, ~f7,   \vol, vol7, \tune, tune]);
					~l7c1 = Synth(s3, [\dur, ~f7/~icd3,  \vol, vol7, \tune, tune]);   ~l7d1 = Synth(s4, [\dur, ~f7/~icd3, \vol, vol7, \tune, tune]);
					~l7e1 = Synth(s5, [\dur, ~f7/~icd6,  \vol, vol7, \tune, tune]);   ~l7f1 = Synth(s6, [\dur, ~f7/~icd6, \vol, vol7, \tune, tune]);
					~l8a1 = Synth(s1, [\dur, ~f8,    \vol, vol8, \tune, tune]);  ~l8b1 = Synth(s2, [\dur, ~f8,   \vol, vol8, \tune, tune]);
					~l8c1 = Synth(s3, [\dur, ~f8/~icd3,  \vol, vol8, \tune, tune]);   ~l8d1 = Synth(s4, [\dur, ~f8/~icd3, \vol, vol8, \tune, tune]);
					~l8e1 = Synth(s5, [\dur, ~f8/~icd6,  \vol, vol8, \tune, tune]);   ~l8f1 = Synth(s6, [\dur, ~f8/~icd6, \vol, vol8, \tune, tune]);

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
			(1.do({var vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8,s1,s2,s3,s4,s5,s6,f1,f2,f3,f4,f5,f6,f7,f8,tune=0;
				#vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8 = [~vol1,~vol2,~vol3,~vol4,~vol5,~vol6,~vol7,~vol8];
				~l1a1.set(\dur, ~f1,     \vol, vol1, \tune, tune);  ~l1b1.set(\dur, ~f1,  \vol, vol1, \tune, tune);
				~l1c1.set(\dur, ~f1/~icd3,       \vol, vol1, \tune, tune);  ~l1d1.set(\dur, ~f1/~icd3,  \vol, vol1, \tune, tune);
				~l1e1.set(\dur, ~f1/~icd6,       \vol, vol1, \tune, tune);  ~l1f1.set(\dur, ~f1/~icd6,  \vol, vol1, \tune, tune);
				~l2a1.set(\dur, ~f2,     \vol, vol2, \tune, tune);          ~l2b1.set(\dur, ~f2,  \vol, vol2, \tune, tune);
				~l2c1.set(\dur, ~f2/~icd3,       \vol, vol2, \tune, tune);  ~l2d1.set(\dur, ~f2/~icd3,  \vol, vol2, \tune, tune);
				~l2e1.set(\dur, ~f2/~icd6,       \vol, vol2, \tune, tune);  ~l2f1.set(\dur, ~f2/~icd6,  \vol, vol2, \tune, tune);
				~l3a1.set(\dur, ~f3,     \vol, vol3, \tune, tune);          ~l3b1.set(\dur, ~f3,  \vol, vol3, \tune, tune);
				~l3c1.set(\dur, ~f3/~icd3,       \vol, vol3, \tune, tune);  ~l3d1.set(\dur, ~f3/~icd3,  \vol, vol3, \tune, tune);
				~l3e1.set(\dur, ~f3/~icd6,       \vol, vol3, \tune, tune);  ~l3f1.set(\dur, ~f3/~icd6,  \vol, vol3, \tune, tune);
				~l4a1.set(\dur, ~f4,    \vol, vol4, \tune, tune);           ~l4b1.set(\dur, ~f4,  \vol, vol4, \tune, tune);
				~l4c1.set(\dur, ~f4/~icd3,       \vol, vol4, \tune, tune);  ~l4d1.set(\dur, ~f4/~icd3,  \vol, vol4, \tune, tune);
				~l4e1.set(\dur, ~f4/~icd6,       \vol, vol4, \tune, tune);  ~l4f1.set(\dur, ~f4/~icd6,  \vol, vol4, \tune, tune);
				~l5a1.set(\dur, ~f5,    \vol, vol5, \tune, tune);           ~l5b1.set(\dur, ~f5,  \vol, vol5, \tune, tune);
				~l5c1.set(\dur, ~f5/~icd3,       \vol, vol5, \tune, tune);  ~l5d1.set(\dur, ~f5/~icd3,  \vol, vol5, \tune, tune);
				~l5e1.set(\dur, ~f5/~icd6,       \vol, vol5, \tune, tune);  ~l5f1.set(\dur, ~f5/~icd6,  \vol, vol5, \tune, tune);
				~l6a1.set(\dur, ~f6,    \vol, vol6, \tune, tune);           ~l6b1.set(\dur, ~f6,  \vol, vol6, \tune, tune);
				~l6c1.set(\dur, ~f6/~icd3,       \vol, vol6, \tune, tune);  ~l6d1.set(\dur, ~f6/~icd3,  \vol, vol6, \tune, tune);
				~l6e1.set(\dur, ~f6/~icd6,       \vol, vol6, \tune, tune);  ~l6f1.set(\dur, ~f6/~icd6,  \vol, vol6, \tune, tune);
				~l7a1.set(\dur, ~f7,    \vol, vol7, \tune, tune);           ~l7b1.set(\dur, ~f7,  \vol, vol7, \tune, tune);
				~l7c1.set(\dur, ~f7/~icd3,       \vol, vol7, \tune, tune);  ~l7d1.set(\dur, ~f7/~icd3,  \vol, vol7, \tune, tune);
				~l7e1.set(\dur, ~f7/~icd6,       \vol, vol7, \tune, tune);  ~l7f1.set(\dur, ~f7/~icd6,  \vol, vol7, \tune, tune);
				~l8a1.set(\dur, ~f8,    \vol, vol8, \tune, tune);           ~l8b1.set(\dur, ~f8,  \vol, vol8, \tune, tune);
				~l8c1.set(\dur, ~f8/~icd3,       \vol, vol8, \tune, tune);  ~l8d1.set(\dur, ~f8/~icd3,  \vol, vol8, \tune, tune);
				~l8e1.set(\dur, ~f8/~icd6,       \vol, vol8, \tune, tune);  ~l8f1.set(\dur, ~f8/~icd6,  \vol, vol8, \tune, tune);
			}););
		}
		{~l1a.isRunning == true} {
			(1.do({var vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8,s1,s2,s3,s4,s5,s6,f1,f2,f3,f4,f5,f6,f7,f8,tune=0;
				#vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8 = [~vol1,~vol2,~vol3,~vol4,~vol5,~vol6,~vol7,~vol8];
				~l1a.set(\dur, ~f1,     \vol, vol1, \tune, tune);  ~l1b.set(\dur, ~f1,  \vol, vol1, \tune, tune);
				~l1c.set(\dur, ~f1/~icd3,       \vol, vol1, \tune, tune);  ~l1d.set(\dur, ~f1/~icd3,  \vol, vol1, \tune, tune);
				~l1e.set(\dur, ~f1/~icd6,       \vol, vol1, \tune, tune);  ~l1f.set(\dur, ~f1/~icd6,  \vol, vol1, \tune, tune);
				~l2a.set(\dur, ~f2,     \vol, vol2, \tune, tune);          ~l2b.set(\dur, ~f2,  \vol, vol2, \tune, tune);
				~l2c.set(\dur, ~f2/~icd3,       \vol, vol2, \tune, tune);  ~l2d.set(\dur, ~f2/~icd3,  \vol, vol2, \tune, tune);
				~l2e.set(\dur, ~f2/~icd6,       \vol, vol2, \tune, tune);  ~l2f.set(\dur, ~f2/~icd6,  \vol, vol2, \tune, tune);
				~l3a.set(\dur, ~f3,     \vol, vol3, \tune, tune);          ~l3b.set(\dur, ~f3,  \vol, vol3, \tune, tune);
				~l3c.set(\dur, ~f3/~icd3,       \vol, vol3, \tune, tune);  ~l3d.set(\dur, ~f3/~icd3,  \vol, vol3, \tune, tune);
				~l3e.set(\dur, ~f3/~icd6,       \vol, vol3, \tune, tune);  ~l3f.set(\dur, ~f3/~icd6,  \vol, vol3, \tune, tune);
				~l4a.set(\dur, ~f4,    \vol, vol4, \tune, tune);           ~l4b.set(\dur, ~f4,  \vol, vol4, \tune, tune);
				~l4c.set(\dur, ~f4/~icd3,       \vol, vol4, \tune, tune);  ~l4d.set(\dur, ~f4/~icd3,  \vol, vol4, \tune, tune);
				~l4e.set(\dur, ~f4/~icd6,       \vol, vol4, \tune, tune);  ~l4f.set(\dur, ~f4/~icd6,  \vol, vol4, \tune, tune);
				~l5a.set(\dur, ~f5,    \vol, vol5, \tune, tune);           ~l5b.set(\dur, ~f5,  \vol, vol5, \tune, tune);
				~l5c.set(\dur, ~f5/~icd3,       \vol, vol5, \tune, tune);  ~l5d.set(\dur, ~f5/~icd3,  \vol, vol5, \tune, tune);
				~l5e.set(\dur, ~f5/~icd6,       \vol, vol5, \tune, tune);  ~l5f.set(\dur, ~f5/~icd6,  \vol, vol5, \tune, tune);
				~l6a.set(\dur, ~f6,    \vol, vol6, \tune, tune);           ~l6b.set(\dur, ~f6,  \vol, vol6, \tune, tune);
				~l6c.set(\dur, ~f6/~icd3,       \vol, vol6, \tune, tune);  ~l6d.set(\dur, ~f6/~icd3,  \vol, vol6, \tune, tune);
				~l6e.set(\dur, ~f6/~icd6,       \vol, vol6, \tune, tune);  ~l6f.set(\dur, ~f6/~icd6,  \vol, vol6, \tune, tune);
				~l7a.set(\dur, ~f7,    \vol, vol7, \tune, tune);           ~l7b.set(\dur, ~f7,  \vol, vol7, \tune, tune);
				~l7c.set(\dur, ~f7/~icd3,       \vol, vol7, \tune, tune);  ~l7d.set(\dur, ~f7/~icd3,  \vol, vol7, \tune, tune);
				~l7e.set(\dur, ~f7/~icd6,       \vol, vol7, \tune, tune);  ~l7f.set(\dur, ~f7/~icd6,  \vol, vol7, \tune, tune);
				~l8a.set(\dur, ~f8,    \vol, vol8, \tune, tune);           ~l8b.set(\dur, ~f8,  \vol, vol8, \tune, tune);
				~l8c.set(\dur, ~f8/~icd3,       \vol, vol8, \tune, tune);  ~l8d.set(\dur, ~f8/~icd3,  \vol, vol8, \tune, tune);
				~l8e.set(\dur, ~f8/~icd6,       \vol, vol8, \tune, tune);  ~l8f.set(\dur, ~f8/~icd6,  \vol, vol8, \tune, tune);

			}););
		};
	};

~synthslide = {case{~l1a1.isRunning == true}{(
	~slideroutine = Routine({
		1.do({var vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8,s1,s2,s3,s4,s5,s6,f1,f2,f3,f4,f5,f6,f7,f8,tune=0;
			#vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8= [~vol1,~vol2,~vol3,~vol4,~vol5,~vol6,~vol7,~vol8];
			#g,h,i,j,k,l,m,n = (([ s,t,u,v,w,x,y,z ]-[ ~f1,~f2,~f3,~f4,~f5,~f6,~f7,~f8 ])*(-1)/~slidedo);
			~slidedo.do({([ s=s+g,t=t+h,u=u+i,v=v+j,w=w+k,x=x+l,y=y+m,z=z+n ];
				~l1a1.set(\dur, s, \vol, vol1, \tune, tune);
				~l1b1.set(\dur, s, \vol, vol1, \tune, tune);
				~l1c1.set(\dur, s/~icd3, \vol, vol1, \tune, tune);
				~l1d1.set(\dur, s/~icd3, \vol, vol1, \tune, tune);
				~l1e1.set(\dur, s/~icd6, \vol, vol1, \tune, tune);
				~l1f1.set(\dur, s/~icd6, \vol, vol1, \tune, tune);
				~l2a1.set(\dur, t, \vol, vol2, \tune, tune);
				~l2b1.set(\dur, t, \vol, vol2, \tune, tune);
				~l2c1.set(\dur, t/~icd3, \vol, vol2, \tune, tune);
				~l2d1.set(\dur, t/~icd3, \vol, vol2, \tune, tune);
				~l2e1.set(\dur, t/~icd6, \vol, vol2, \tune, tune);
				~l2f1.set(\dur, t/~icd6, \vol, vol2, \tune, tune);
				~l3a1.set(\dur, u, \vol, vol3, \tune, tune);
				~l3b1.set(\dur, u, \vol, vol3, \tune, tune);
				~l3c1.set(\dur, u/~icd3, \vol, vol3, \tune, tune);
				~l3d1.set(\dur, u/~icd3, \vol, vol3, \tune, tune);
				~l3e1.set(\dur, u/~icd6, \vol, vol3, \tune, tune);
				~l3f1.set(\dur, u/~icd6, \vol, vol3, \tune, tune);
				~l4a1.set(\dur, v, \vol, vol4, \tune, tune);
				~l4b1.set(\dur, v, \vol, vol4, \tune, tune);
				~l4c1.set(\dur, v/~icd3, \vol, vol4, \tune, tune);
				~l4d1.set(\dur, v/~icd3, \vol, vol4, \tune, tune);
				~l4e1.set(\dur, v/~icd6, \vol, vol4, \tune, tune);
				~l4f1.set(\dur, v/~icd6, \vol, vol4, \tune, tune);
				~l5a1.set(\dur, w, \vol, vol5, \tune, tune);
				~l5b1.set(\dur, w, \vol, vol5, \tune, tune);
				~l5c1.set(\dur, w/~icd3, \vol, vol5, \tune, tune);
				~l5d1.set(\dur, w/~icd3, \vol, vol5, \tune, tune);
				~l5e1.set(\dur, w/~icd6, \vol, vol5, \tune, tune);
				~l5f1.set(\dur, w/~icd6, \vol, vol5, \tune, tune);
				~l6a1.set(\dur, x, \vol, vol6, \tune, tune);
				~l6b1.set(\dur, x, \vol, vol6, \tune, tune);
				~l6c1.set(\dur, x/~icd3, \vol, vol6, \tune, tune);
				~l6d1.set(\dur, x/~icd3, \vol, vol6, \tune, tune);
				~l6e1.set(\dur, x/~icd6, \vol, vol6, \tune, tune);
				~l6f1.set(\dur, x/~icd6, \vol, vol6, \tune, tune);
				~l7a1.set(\dur, y, \vol, vol7, \tune, tune);
				~l7b1.set(\dur, y, \vol, vol7, \tune, tune);
				~l7c1.set(\dur, y/~icd3, \vol, vol7, \tune, tune);
				~l7d1.set(\dur, y/~icd3, \vol, vol7, \tune, tune);
				~l7e1.set(\dur, y/~icd6, \vol, vol7, \tune, tune);
				~l7f1.set(\dur, y/~icd6, \vol, vol7, \tune, tune);
				~l8a1.set(\dur, z, \vol, vol8, \tune, tune);
				~l8b1.set(\dur, z, \vol, vol8, \tune, tune);
				~l8c1.set(\dur, z/~icd3, \vol, vol8, \tune, tune);
				~l8d1.set(\dur, z/~icd3, \vol, vol8, \tune, tune);
				~l8e1.set(\dur, z/~icd6, \vol, vol8, \tune, tune);
				~l8f1.set(\dur, z/~icd6, \vol, vol8, \tune, tune);
				);
				(~slidetime/~slidedo).wait;
	});});}).play;);}{~l1a.isRunning == true} {(
		~slideroutine = Routine({1.do({var vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8,s1,s2,s3,s4,s5,s6,f1,f2,f3,f4,f5,f6,f7,f8,tune=0;
			#vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8= [~vol1,~vol2,~vol3,~vol4,~vol5,~vol6,~vol7,~vol8];
			#g,h,i,j,k,l,m,n = (([ s,t,u,v,w,x,y,z ]-[ ~f1,~f2,~f3,~f4,~f5,~f6,~f7,~f8 ])*(-1)/~slidedo);
			~slidedo.do({([ s=s+g,t=t+h,u=u+i,v=v+j,w=w+k,x=x+l,y=y+m,z=z+n ];
				~l1a.set(\dur, s, \vol, vol1, \tune, tune);
				~l1b.set(\dur, s, \vol, vol1, \tune, tune);
				~l1c.set(\dur, s/~icd3, \vol, vol1, \tune, tune);
				~l1d.set(\dur, s/~icd3, \vol, vol1, \tune, tune);
				~l1e.set(\dur, s/~icd6, \vol, vol1, \tune, tune);
				~l1f.set(\dur, s/~icd6, \vol, vol1, \tune, tune);
				~l2a.set(\dur, t, \vol, vol2, \tune, tune);
				~l2b.set(\dur, t, \vol, vol2, \tune, tune);
				~l2c.set(\dur, t/~icd3, \vol, vol2, \tune, tune);
				~l2d.set(\dur, t/~icd3, \vol, vol2, \tune, tune);
				~l2e.set(\dur, t/~icd6, \vol, vol2, \tune, tune);
				~l2f.set(\dur, t/~icd6, \vol, vol2, \tune, tune);
				~l3a.set(\dur, u, \vol, vol3, \tune, tune);
				~l3b.set(\dur, u, \vol, vol3, \tune, tune);
				~l3c.set(\dur, u/~icd3, \vol, vol3, \tune, tune);
				~l3d.set(\dur, u/~icd3, \vol, vol3, \tune, tune);
				~l3e.set(\dur, u/~icd6, \vol, vol3, \tune, tune);
				~l3f.set(\dur, u/~icd6, \vol, vol3, \tune, tune);
				~l4a.set(\dur, v, \vol, vol4, \tune, tune);
				~l4b.set(\dur, v, \vol, vol4, \tune, tune);
				~l4c.set(\dur, v/~icd3, \vol, vol4, \tune, tune);
				~l4d.set(\dur, v/~icd3, \vol, vol4, \tune, tune);
				~l4e.set(\dur, v/~icd6, \vol, vol4, \tune, tune);
				~l4f.set(\dur, v/~icd6, \vol, vol4, \tune, tune);
				~l5a.set(\dur, w, \vol, vol5, \tune, tune);
				~l5b.set(\dur, w, \vol, vol5, \tune, tune);
				~l5c.set(\dur, w/~icd3, \vol, vol5, \tune, tune);
				~l5d.set(\dur, w/~icd3, \vol, vol5, \tune, tune);
				~l5e.set(\dur, w/~icd6, \vol, vol5, \tune, tune);
				~l5f.set(\dur, w/~icd6, \vol, vol5, \tune, tune);
				~l6a.set(\dur, x, \vol, vol6, \tune, tune);
				~l6b.set(\dur, x, \vol, vol6, \tune, tune);
				~l6c.set(\dur, x/~icd3, \vol, vol6, \tune, tune);
				~l6d.set(\dur, x/~icd3, \vol, vol6, \tune, tune);
				~l6e.set(\dur, x/~icd6, \vol, vol6, \tune, tune);
				~l6f.set(\dur, x/~icd6, \vol, vol6, \tune, tune);
				~l7a.set(\dur, y, \vol, vol7, \tune, tune);
				~l7b.set(\dur, y, \vol, vol7, \tune, tune);
				~l7c.set(\dur, y/~icd3, \vol, vol7, \tune, tune);
				~l7d.set(\dur, y/~icd3, \vol, vol7, \tune, tune);
				~l7e.set(\dur, y/~icd6, \vol, vol7, \tune, tune);
				~l7f.set(\dur, y/~icd6, \vol, vol7, \tune, tune);
				~l8a.set(\dur, z, \vol, vol8, \tune, tune);
				~l8b.set(\dur, z, \vol, vol8, \tune, tune);
				~l8c.set(\dur, z/~icd3, \vol, vol8, \tune, tune);
				~l8d.set(\dur, z/~icd3, \vol, vol8, \tune, tune);
				~l8e.set(\dur, z/~icd6, \vol, vol8, \tune, tune);
				~l8f.set(\dur, z/~icd6, \vol, vol8, \tune, tune);
				);
				(~slidetime/~slidedo).wait;});});
}).play;);};};


~synthpause = {(
		case
		{~l1a1.isRunning == true}{
			(1.do({var vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8,s1,s2,s3,s4,s5,s6,f1,f2,f3,f4,f5,f6,f7,f8,tune=0;
				#vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8 = [~vol1,~vol2,~vol3,~vol4,~vol5,~vol6,~vol7,~vol8];
				#f1,f2,f3,f4,f5,f6,f7,f8 = [ 0,0,0,0,0,0,0,0 ];
				~l1a1.set(\dur, f1,     \vol, vol1, \tune, tune);          ~l1b1.set(\dur, f1,  \vol, vol1, \tune, tune);
				~l1c1.set(\dur, f1/~icd3,       \vol, vol1, \tune, tune);  ~l1d1.set(\dur, f1/~icd3,  \vol, vol1, \tune, tune);
				~l1e1.set(\dur, f1/~icd6,       \vol, vol1, \tune, tune);  ~l1f1.set(\dur, f1/~icd6,  \vol, vol1, \tune, tune);
				~l2a1.set(\dur, f2,     \vol, vol2, \tune, tune);          ~l2b1.set(\dur, f2,  \vol, vol2, \tune, tune);
				~l2c1.set(\dur, f2/~icd3,       \vol, vol2, \tune, tune);  ~l2d1.set(\dur, f2/~icd3,  \vol, vol2, \tune, tune);
				~l2e1.set(\dur, f2/~icd6,       \vol, vol2, \tune, tune);  ~l2f1.set(\dur, f2/~icd6,  \vol, vol2, \tune, tune);
				~l3a1.set(\dur, f3,     \vol, vol3, \tune, tune);          ~l3b1.set(\dur, f3,  \vol, vol3, \tune, tune);
				~l3c1.set(\dur, f3/~icd3,       \vol, vol3, \tune, tune);  ~l3d1.set(\dur, f3/~icd3,  \vol, vol3, \tune, tune);
				~l3e1.set(\dur, f3/~icd6,       \vol, vol3, \tune, tune);  ~l3f1.set(\dur, f3/~icd6,  \vol, vol3, \tune, tune);
				~l4a1.set(\dur, f4,    \vol, vol4, \tune, tune);           ~l4b1.set(\dur, f4,  \vol, vol4, \tune, tune);
				~l4c1.set(\dur, f4/~icd3,       \vol, vol4, \tune, tune);  ~l4d1.set(\dur, f4/~icd3,  \vol, vol4, \tune, tune);
				~l4e1.set(\dur, f4/~icd6,       \vol, vol4, \tune, tune);  ~l4f1.set(\dur, f4/~icd6,  \vol, vol4, \tune, tune);
				~l5a1.set(\dur, f5,    \vol, vol5, \tune, tune);           ~l5b1.set(\dur, f5,  \vol, vol5, \tune, tune);
				~l5c1.set(\dur, f5/~icd3,       \vol, vol5, \tune, tune);  ~l5d1.set(\dur, f5/~icd3,  \vol, vol5, \tune, tune);
				~l5e1.set(\dur, f5/~icd6,       \vol, vol5, \tune, tune);  ~l5f1.set(\dur, f5/~icd6,  \vol, vol5, \tune, tune);
				~l6a1.set(\dur, f6,    \vol, vol6, \tune, tune);           ~l6b1.set(\dur, f6,  \vol, vol6, \tune, tune);
				~l6c1.set(\dur, f6/~icd3,       \vol, vol6, \tune, tune);  ~l6d1.set(\dur, f6/~icd3,  \vol, vol6, \tune, tune);
				~l6e1.set(\dur, f6/~icd6,       \vol, vol6, \tune, tune);  ~l6f1.set(\dur, f6/~icd6,  \vol, vol6, \tune, tune);
				~l7a1.set(\dur, f7,    \vol, vol7, \tune, tune);           ~l7b1.set(\dur, f7,  \vol, vol7, \tune, tune);
				~l7c1.set(\dur, f7/~icd3,       \vol, vol7, \tune, tune);  ~l7d1.set(\dur, f7/~icd3,  \vol, vol7, \tune, tune);
				~l7e1.set(\dur, f7/~icd6,       \vol, vol7, \tune, tune);  ~l7f1.set(\dur, f7/~icd6,  \vol, vol7, \tune, tune);
				~l8a1.set(\dur, f8,    \vol, vol8, \tune, tune);           ~l8b1.set(\dur, f8,  \vol, vol8, \tune, tune);
				~l8c1.set(\dur, f8/~icd3,       \vol, vol8, \tune, tune);  ~l8d1.set(\dur, f8/~icd3,  \vol, vol8, \tune, tune);
				~l8e1.set(\dur, f8/~icd6,       \vol, vol8, \tune, tune);  ~l8f1.set(\dur, f8/~icd6,  \vol, vol8, \tune, tune);
			}););
		}
		{~l1a.isRunning == true} {
			(1.do({var vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8,s1,s2,s3,s4,s5,s6,f1,f2,f3,f4,f5,f6,f7,f8,tune=0;
				#vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8 = [~vol1,~vol2,~vol3,~vol4,~vol5,~vol6,~vol7,~vol8];
				#f1,f2,f3,f4,f5,f6,f7,f8 = [ 0,0,0,0,0,0,0,0 ];
				~l1a.set(\dur, f1,     \vol, vol1, \tune, tune);  ~l1b.set(\dur, f1,  \vol, vol1, \tune, tune);
				~l1c.set(\dur, f1/~icd3,       \vol, vol1, \tune, tune);  ~l1d.set(\dur, f1/~icd3,  \vol, vol1, \tune, tune);
				~l1e.set(\dur, f1/~icd6,       \vol, vol1, \tune, tune);  ~l1f.set(\dur, f1/~icd6,  \vol, vol1, \tune, tune);
				~l2a.set(\dur, f2,     \vol, vol2, \tune, tune);          ~l2b.set(\dur, f2,  \vol, vol2, \tune, tune);
				~l2c.set(\dur, f2/~icd3,       \vol, vol2, \tune, tune);  ~l2d.set(\dur, f2/~icd3,  \vol, vol2, \tune, tune);
				~l2e.set(\dur, f2/~icd6,       \vol, vol2, \tune, tune);  ~l2f.set(\dur, f2/~icd6,  \vol, vol2, \tune, tune);
				~l3a.set(\dur, f3,     \vol, vol3, \tune, tune);          ~l3b.set(\dur, f3,  \vol, vol3, \tune, tune);
				~l3c.set(\dur, f3/~icd3,       \vol, vol3, \tune, tune);  ~l3d.set(\dur, f3/~icd3,  \vol, vol3, \tune, tune);
				~l3e.set(\dur, f3/~icd6,       \vol, vol3, \tune, tune);  ~l3f.set(\dur, f3/~icd6,  \vol, vol3, \tune, tune);
				~l4a.set(\dur, f4,    \vol, vol4, \tune, tune);           ~l4b.set(\dur, f4,  \vol, vol4, \tune, tune);
				~l4c.set(\dur, f4/~icd3,       \vol, vol4, \tune, tune);  ~l4d.set(\dur, f4/~icd3,  \vol, vol4, \tune, tune);
				~l4e.set(\dur, f4/~icd6,       \vol, vol4, \tune, tune);  ~l4f.set(\dur, f4/~icd6,  \vol, vol4, \tune, tune);
				~l5a.set(\dur, f5,    \vol, vol5, \tune, tune);           ~l5b.set(\dur, f5,  \vol, vol5, \tune, tune);
				~l5c.set(\dur, f5/~icd3,       \vol, vol5, \tune, tune);  ~l5d.set(\dur, f5/~icd3,  \vol, vol5, \tune, tune);
				~l5e.set(\dur, f5/~icd6,       \vol, vol5, \tune, tune);  ~l5f.set(\dur, f5/~icd6,  \vol, vol5, \tune, tune);
				~l6a.set(\dur, f6,    \vol, vol6, \tune, tune);           ~l6b.set(\dur, f6,  \vol, vol6, \tune, tune);
				~l6c.set(\dur, f6/~icd3,       \vol, vol6, \tune, tune);  ~l6d.set(\dur, f6/~icd3,  \vol, vol6, \tune, tune);
				~l6e.set(\dur, f6/~icd6,       \vol, vol6, \tune, tune);  ~l6f.set(\dur, f6/~icd6,  \vol, vol6, \tune, tune);
				~l7a.set(\dur, f7,    \vol, vol7, \tune, tune);           ~l7b.set(\dur, f7,  \vol, vol7, \tune, tune);
				~l7c.set(\dur, f7/~icd3,       \vol, vol7, \tune, tune);  ~l7d.set(\dur, f7/~icd3,  \vol, vol7, \tune, tune);
				~l7e.set(\dur, f7/~icd6,       \vol, vol7, \tune, tune);  ~l7f.set(\dur, f7/~icd6,  \vol, vol7, \tune, tune);
				~l8a.set(\dur, f8,    \vol, vol8, \tune, tune);           ~l8b.set(\dur, f8,  \vol, vol8, \tune, tune);
				~l8c.set(\dur, f8/~icd3,       \vol, vol8, \tune, tune);  ~l8d.set(\dur, f8/~icd3,  \vol, vol8, \tune, tune);
				~l8e.set(\dur, f8/~icd6,       \vol, vol8, \tune, tune);  ~l8f.set(\dur, f8/~icd6,  \vol, vol8, \tune, tune);

			}););
		};
		);
	};

~synthfree = {
		(
			case
			{((~l1a.isRunning == false) and: (~l1a1.isRunning == false)) or: ~l1a1.isRunning == true}{
				(1.do({var vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8,s1,s2,s3,s4,s5,s6,f1,f2,f3,f4,f5,f6,f7,f8,tune=0;
				#vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8 = [~vol1,~vol2,~vol3,~vol4,~vol5,~vol6,~vol7,~vol8];
				#f1,f2,f3,f4,f5,f6,f7,f8 = [ 0,0,0,0,0,0,0,0 ];
					~l1a1.set(\dur, f1,     \vol, vol1, \tune, tune);  ~l1b1.set(\dur, f1,  \vol, vol1, \tune, tune);
					~l1c1.set(\dur, f1/~icd3,       \vol, vol1, \tune, tune);  ~l1d1.set(\dur, f1/~icd3,  \vol, vol1, \tune, tune);
					~l1e1.set(\dur, f1/~icd6,       \vol, vol1, \tune, tune);  ~l1f1.set(\dur, f1/~icd6,  \vol, vol1, \tune, tune);
					~l2a1.set(\dur, f2,     \vol, vol2, \tune, tune);          ~l2b1.set(\dur, f2,  \vol, vol2, \tune, tune);
					~l2c1.set(\dur, f2/~icd3,       \vol, vol2, \tune, tune);  ~l2d1.set(\dur, f2/~icd3,  \vol, vol2, \tune, tune);
					~l2e1.set(\dur, f2/~icd6,       \vol, vol2, \tune, tune);  ~l2f1.set(\dur, f2/~icd6,  \vol, vol2, \tune, tune);
					~l3a1.set(\dur, f3,     \vol, vol3, \tune, tune);          ~l3b1.set(\dur, f3,  \vol, vol3, \tune, tune);
					~l3c1.set(\dur, f3/~icd3,       \vol, vol3, \tune, tune);  ~l3d1.set(\dur, f3/~icd3,  \vol, vol3, \tune, tune);
					~l3e1.set(\dur, f3/~icd6,       \vol, vol3, \tune, tune);  ~l3f1.set(\dur, f3/~icd6,  \vol, vol3, \tune, tune);
					~l4a1.set(\dur, f4,    \vol, vol4, \tune, tune);           ~l4b1.set(\dur, f4,  \vol, vol4, \tune, tune);
					~l4c1.set(\dur, f4/~icd3,       \vol, vol4, \tune, tune);  ~l4d1.set(\dur, f4/~icd3,  \vol, vol4, \tune, tune);
					~l4e1.set(\dur, f4/~icd6,       \vol, vol4, \tune, tune);  ~l4f1.set(\dur, f4/~icd6,  \vol, vol4, \tune, tune);
					~l5a1.set(\dur, f5,    \vol, vol5, \tune, tune);           ~l5b1.set(\dur, f5,  \vol, vol5, \tune, tune);
					~l5c1.set(\dur, f5/~icd3,       \vol, vol5, \tune, tune);  ~l5d1.set(\dur, f5/~icd3,  \vol, vol5, \tune, tune);
					~l5e1.set(\dur, f5/~icd6,       \vol, vol5, \tune, tune);  ~l5f1.set(\dur, f5/~icd6,  \vol, vol5, \tune, tune);
					~l6a1.set(\dur, f6,    \vol, vol6, \tune, tune);           ~l6b1.set(\dur, f6,  \vol, vol6, \tune, tune);
					~l6c1.set(\dur, f6/~icd3,       \vol, vol6, \tune, tune);  ~l6d1.set(\dur, f6/~icd3,  \vol, vol6, \tune, tune);
					~l6e1.set(\dur, f6/~icd6,       \vol, vol6, \tune, tune);  ~l6f1.set(\dur, f6/~icd6,  \vol, vol6, \tune, tune);
					~l7a1.set(\dur, f7,    \vol, vol7, \tune, tune);           ~l7b1.set(\dur, f7,  \vol, vol7, \tune, tune);
					~l7c1.set(\dur, f7/~icd3,       \vol, vol7, \tune, tune);  ~l7d1.set(\dur, f7/~icd3,  \vol, vol7, \tune, tune);
					~l7e1.set(\dur, f7/~icd6,       \vol, vol7, \tune, tune);  ~l7f1.set(\dur, f7/~icd6,  \vol, vol7, \tune, tune);
					~l8a1.set(\dur, f8,    \vol, vol8, \tune, tune);           ~l8b1.set(\dur, f8,  \vol, vol8, \tune, tune);
					~l8c1.set(\dur, f8/~icd3,       \vol, vol8, \tune, tune);  ~l8d1.set(\dur, f8/~icd3,  \vol, vol8, \tune, tune);
					~l8e1.set(\dur, f8/~icd6,       \vol, vol8, \tune, tune);  ~l8f1.set(\dur, f8/~icd6,  \vol, vol8, \tune, tune);
				}););
				AppClock.sched(0.161803398875,{
					([~l1a1,~l1b1,~l1c1,~l1d1,~l1e1,~l1f1,~l2a1,~l2b1,~l2c1,~l2d1,~l2e1,~l2f1,~l3a1,~l3b1,~l3c1,~l3d1,~l3e1,~l3f1,~l4a1,~l4b1,~l4c1,~l4d1,~l4e1,~l4f1,~l5a1,~l5b1,~l5c1,~l5d1,~l5e1,~l5f1,~l6a1,~l6b1,~l6c1,~l6d1,~l6e1,~l6f1,~l7a1,~l7b1,~l7c1,~l7d1,~l7e1,~l7f1,~l8a1,~l8b1,~l8c1,~l8d1,~l8e1,~l8f1 ].do(_.free)); ~slideroutine.stop;
				});
			}
			{~l1a.isRunning == true}{
				(1.do({var vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8,s1,s2,s3,s4,s5,s6,f1,f2,f3,f4,f5,f6,f7,f8,tune=0;
				#vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8 = [~vol1,~vol2,~vol3,~vol4,~vol5,~vol6,~vol7,~vol8];
				#f1,f2,f3,f4,f5,f6,f7,f8 = [ 0,0,0,0,0,0,0,0 ];
					~l1a.set(\dur, f1,     \vol, vol1, \tune, tune);  ~l1b.set(\dur, f1,  \vol, vol1, \tune, tune);
					~l1c.set(\dur, f1/~icd3,       \vol, vol1, \tune, tune);  ~l1d.set(\dur, f1/~icd3,  \vol, vol1, \tune, tune);
					~l1e.set(\dur, f1/~icd6,       \vol, vol1, \tune, tune);  ~l1f.set(\dur, f1/~icd6,  \vol, vol1, \tune, tune);
					~l2a.set(\dur, f2,     \vol, vol2, \tune, tune);          ~l2b.set(\dur, f2,  \vol, vol2, \tune, tune);
					~l2c.set(\dur, f2/~icd3,       \vol, vol2, \tune, tune);  ~l2d.set(\dur, f2/~icd3,  \vol, vol2, \tune, tune);
					~l2e.set(\dur, f2/~icd6,       \vol, vol2, \tune, tune);  ~l2f.set(\dur, f2/~icd6,  \vol, vol2, \tune, tune);
					~l3a.set(\dur, f3,     \vol, vol3, \tune, tune);          ~l3b.set(\dur, f3,  \vol, vol3, \tune, tune);
					~l3c.set(\dur, f3/~icd3,       \vol, vol3, \tune, tune);  ~l3d.set(\dur, f3/~icd3,  \vol, vol3, \tune, tune);
					~l3e.set(\dur, f3/~icd6,       \vol, vol3, \tune, tune);  ~l3f.set(\dur, f3/~icd6,  \vol, vol3, \tune, tune);
					~l4a.set(\dur, f4,    \vol, vol4, \tune, tune);           ~l4b.set(\dur, f4,  \vol, vol4, \tune, tune);
					~l4c.set(\dur, f4/~icd3,       \vol, vol4, \tune, tune);  ~l4d.set(\dur, f4/~icd3,  \vol, vol4, \tune, tune);
					~l4e.set(\dur, f4/~icd6,       \vol, vol4, \tune, tune);  ~l4f.set(\dur, f4/~icd6,  \vol, vol4, \tune, tune);
					~l5a.set(\dur, f5,    \vol, vol5, \tune, tune);           ~l5b.set(\dur, f5,  \vol, vol5, \tune, tune);
					~l5c.set(\dur, f5/~icd3,       \vol, vol5, \tune, tune);  ~l5d.set(\dur, f5/~icd3,  \vol, vol5, \tune, tune);
					~l5e.set(\dur, f5/~icd6,       \vol, vol5, \tune, tune);  ~l5f.set(\dur, f5/~icd6,  \vol, vol5, \tune, tune);
					~l6a.set(\dur, f6,    \vol, vol6, \tune, tune);           ~l6b.set(\dur, f6,  \vol, vol6, \tune, tune);
					~l6c.set(\dur, f6/~icd3,       \vol, vol6, \tune, tune);  ~l6d.set(\dur, f6/~icd3,  \vol, vol6, \tune, tune);
					~l6e.set(\dur, f6/~icd6,       \vol, vol6, \tune, tune);  ~l6f.set(\dur, f6/~icd6,  \vol, vol6, \tune, tune);
					~l7a.set(\dur, f7,    \vol, vol7, \tune, tune);           ~l7b.set(\dur, f7,  \vol, vol7, \tune, tune);
					~l7c.set(\dur, f7/~icd3,       \vol, vol7, \tune, tune);  ~l7d.set(\dur, f7/~icd3,  \vol, vol7, \tune, tune);
					~l7e.set(\dur, f7/~icd6,       \vol, vol7, \tune, tune);  ~l7f.set(\dur, f7/~icd6,  \vol, vol7, \tune, tune);
					~l8a.set(\dur, f8,    \vol, vol8, \tune, tune);           ~l8b.set(\dur, f8,  \vol, vol8, \tune, tune);
					~l8c.set(\dur, f8/~icd3,       \vol, vol8, \tune, tune);  ~l8d.set(\dur, f8/~icd3,  \vol, vol8, \tune, tune);
					~l8e.set(\dur, f8/~icd6,       \vol, vol8, \tune, tune);  ~l8f.set(\dur, f8/~icd6,  \vol, vol8, \tune, tune);
				}););
				AppClock.sched(0.161803398875,{
					([~l1a,~l1b,~l1c,~l1d,~l1e,~l1f,~l2a,~l2b,~l2c,~l2d,~l2e,~l2f,~l3a,~l3b,~l3c,~l3d,~l3e,~l3f,~l4a,~l4b,~l4c,~l4d,~l4e,~l4f,~l5a,~l5b,~l5c,~l5d,~l5e,~l5f,~l6a,~l6b,~l6c,~l6d,~l6e,~l6f,~l7a,~l7b,~l7c,~l7d,~l7e,~l7f,~l8a,~l8b,~l8c,~l8d,~l8e,~l8f].do(_.free)); ~slideroutine.stop;
				});
			};
		);
	};
);