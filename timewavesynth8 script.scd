/*Order of execution to run script and record(goes from bottom to top):
1. Hit "Ctrl/Cmd - Enter" anywhere inside the "LOAD SYNTH FUNCTIONS" parenthesis,
2. Click on the same line as "START RECORDING;" (above the "LOAD SYNTH FUNCTIONS" parenthesis) and hit "Ctrl/Cmd - Enter",
3. Hit "Ctrl/Cmd - Enter" anywhere inside the "TASK" parenthesis above the "START RECORDING;" line...
The record file location will be found in the post window...
Leave out #2 to run the script without recording...
Important Note: You must load the Timewave Synthesizer program and press the "synth0" button at least once before this script can run.*/

((//3 - TASK
	t = Task({~st = 0; ~trace = {("event-"++(~st = ~st + 1).asString).postln;};
		~vol = 0.005;~vol1 = ~vol;~vol2 = ~vol;~vol3 = ~vol;~vol4 = ~vol;~vol5 = ~vol;~vol6 = ~vol;~vol7 = ~vol;~vol8 = ~vol;~vol9 = ~vol;~vol10 = ~vol;~vol11 = ~vol;~vol12 = ~vol;
		1.do({

			//duration of each chord
			x = 32;

			//copy and paste "saved" chords from the "copy" button inside the synthesizer program here:
			[~f1=519.95703782873,~f2=616.23193196285,~f3=667.17109017758,~f4=692.66874234338,~f5=526.88556162392,~f6=516.52701736121,~f7=508.61137210833,~f8=506.37212156992]; ~synthopen.value; ~trace.value; (x).wait;
			[~f1=572.96170615003,~f2=572.96170615003,~f3=570.43914200903,~f4=570.43914200903,~f5=570.43914200903,~f6=516.52701736121,~f7=508.61137210833,~f8=506.37212156992]; ~synthflow.value; ~trace.value; (x).wait;
			[~f1=572.96170615003,~f2=572.96170615003,~f3=709.68417951408,~f4=709.68417951408,~f5=661.30934745052,~f6=590.93477690798,~f7=575.49542543341,~f8=551.87055912019]; ~synthflow.value; ~trace.value; (x).wait;
			[~f1=680.55068318264,~f2=680.55068318264,~f3=680.55068318264,~f4=680.55068318264,~f5=680.55068318264,~f6=590.93477690798,~f7=575.49542543341,~f8=551.87055912019]; ~synthflow.value; ~trace.value; (x).wait;
			[~f1=680.55068318264,~f2=824.55305817848,~f3=770.04531637521,~f4=741.69937490481,~f5=715.97470919404,~f6=590.93477690798,~f7=575.49542543341,~f8=551.87055912019]; ~synthflow.value; ~trace.value; (x).wait;
			[~f1=284.07777031607,~f2=285.96420129413,~f3=300.84921067741,~f4=341.16370743965,~f5=374.28694757008,~f6=478.14339589558,~f7=536.26742041046,~f8=579.31702821866]; ~synthflow.value; ~trace.value; (x).wait;
			[~f1=284.07777031607,~f2=444.56939292983,~f3=444.56939292983,~f4=444.56939292983,~f5=444.56939292983,~f6=478.14339589558,~f7=536.26742041046,~f8=579.31702821866]; ~synthflow.value; ~trace.value; (x).wait;
			[~f1=284.07777031607,~f2=392.035694412,~f3=392.035694412,~f4=392.9015574105,~f5=392.9015574105,~f6=478.14339589558,~f7=536.26742041046,~f8=579.31702821866]; ~synthflow.value; ~trace.value; (x).wait;


			//fade out function
			x=0.00005;100.do({~vol1=~vol1-x;~vol2=~vol2-x;~vol3=~vol3-x;~vol4=~vol4-x;~vol5=~vol5-x;~vol6=~vol6-x;~vol7=~vol7-x;~vol8=~vol8-x;~synthflow.value;0.1.wait;});

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
					(1.do({var a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,fs,rs,vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8,vol9,vol10,vol11,vol12,s1,s2,s3,s4,s5,s6,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,f19,f20,f21,f22,f23,f24,fs1,fs2,fs3,fs4,fs5,fs6,fd1,fd2,fd3,fd4,fd5,fd6,tune=0;
						#vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8,vol9,vol10,vol11,vol12 = [~vol1,~vol2,~vol3,~vol4,~vol5,~vol6,~vol7,~vol8,~vol9,~vol10,~vol11,~vol12];
						#f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12 = [ 0,0,0,0,0,0,0,0,0,0,0,0 ];
						~l1a1.set(\dur, f1, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,    \vol, vol1, \tune, tune);  ~l1b1.set(\dur, f1, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol1, \tune, tune);
						~l1c1.set(\dur, f1/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol1, \tune, tune);  ~l1d1.set(\dur, f1/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol1, \tune, tune);
						~l1e1.set(\dur, f1/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol1, \tune, tune);  ~l1f1.set(\dur, f1/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol1, \tune, tune);
						~l2a1.set(\dur, f2, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,    \vol, vol2, \tune, tune);          ~l2b1.set(\dur, f2, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol2, \tune, tune);
						~l2c1.set(\dur, f2/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol2, \tune, tune);  ~l2d1.set(\dur, f2/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol2, \tune, tune);
						~l2e1.set(\dur, f2/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol2, \tune, tune);  ~l2f1.set(\dur, f2/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol2, \tune, tune);
						~l3a1.set(\dur, f3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,    \vol, vol3, \tune, tune);          ~l3b1.set(\dur, f3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol3, \tune, tune);
						~l3c1.set(\dur, f3/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol3, \tune, tune);  ~l3d1.set(\dur, f3/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol3, \tune, tune);
						~l3e1.set(\dur, f3/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol3, \tune, tune);  ~l3f1.set(\dur, f3/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol3, \tune, tune);
						~l4a1.set(\dur, f4, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol4, \tune, tune);           ~l4b1.set(\dur, f4, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol4, \tune, tune);
						~l4c1.set(\dur, f4/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol4, \tune, tune);  ~l4d1.set(\dur, f4/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol4, \tune, tune);
						~l4e1.set(\dur, f4/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol4, \tune, tune);  ~l4f1.set(\dur, f4/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol4, \tune, tune);
						~l5a1.set(\dur, f5, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol5, \tune, tune);           ~l5b1.set(\dur, f5, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol5, \tune, tune);
						~l5c1.set(\dur, f5/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol5, \tune, tune);  ~l5d1.set(\dur, f5/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol5, \tune, tune);
						~l5e1.set(\dur, f5/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol5, \tune, tune);  ~l5f1.set(\dur, f5/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol5, \tune, tune);
						~l6a1.set(\dur, f6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol6, \tune, tune);           ~l6b1.set(\dur, f6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol6, \tune, tune);
						~l6c1.set(\dur, f6/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol6, \tune, tune);  ~l6d1.set(\dur, f6/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol6, \tune, tune);
						~l6e1.set(\dur, f6/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol6, \tune, tune);  ~l6f1.set(\dur, f6/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol6, \tune, tune);
						~l7a1.set(\dur, f7, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol7, \tune, tune);           ~l7b1.set(\dur, f7, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol7, \tune, tune);
						~l7c1.set(\dur, f7/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol7, \tune, tune);  ~l7d1.set(\dur, f7/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol7, \tune, tune);
						~l7e1.set(\dur, f7/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol7, \tune, tune);  ~l7f1.set(\dur, f7/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol7, \tune, tune);
						~l8a1.set(\dur, f8, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol8, \tune, tune);           ~l8b1.set(\dur, f8, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol8, \tune, tune);
						~l8c1.set(\dur, f8/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol8, \tune, tune);  ~l8d1.set(\dur, f8/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol8, \tune, tune);
						~l8e1.set(\dur, f8/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol8, \tune, tune);  ~l8f1.set(\dur, f8/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol8, \tune, tune);
						/*~l9a1.set(\dur, f9, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol9,  \tune, tune);          ~l9b1.set(\dur, f9, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol9, \tune, tune);
						~l9c1.set(\dur, f9/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol9,  \tune, tune); ~l9d1.set(\dur, f9/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol9, \tune, tune);
						~l9e1.set(\dur, f9/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol9,  \tune, tune); ~l9f1.set(\dur, f9/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol9, \tune, tune);
						~l10a1.set(\dur, f10, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol10,  \tune, tune);         ~l10b1.set(\dur, f10, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol10, \tune, tune);
						~l10c1.set(\dur, f10/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,    \vol, vol10,  \tune, tune);~l10d1.set(\dur, f10/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol10, \tune, tune);
						~l10e1.set(\dur, f10/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,    \vol, vol10,  \tune, tune);~l10f1.set(\dur, f10/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol10, \tune, tune);
						~l11a1.set(\dur, f11, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol11,  \tune, tune);         ~l11b1.set(\dur, f11, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol11, \tune, tune);
						~l11c1.set(\dur, f11/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,    \vol, vol11,  \tune, tune);~l11d1.set(\dur, f11/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol11, \tune, tune);
						~l11e1.set(\dur, f11/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,    \vol, vol11,  \tune, tune);~l11f1.set(\dur, f11/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol11, \tune, tune);
						~l12a1.set(\dur, f12, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol12,  \tune, tune);         ~l12b1.set(\dur, f12, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol12, \tune, tune);
						~l12c1.set(\dur, f12/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,    \vol, vol12,  \tune, tune);~l12d1.set(\dur, f12/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol12, \tune, tune);
						~l12e1.set(\dur, f12/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,    \vol, vol12,  \tune, tune);~l12f1.set(\dur, f12/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol12, \tune, tune);
					*/	}););

					(~icl6=ParGroup.new;~icl61=ParGroup.new;~icl62=ParGroup.new;~icl63=ParGroup.new;
						1.do({var a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,fs,rs,vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8,vol9,vol10,vol11,vol12,s1,s2,s3,s4,s5,s6,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,f19,f20,f21,f22,f23,f24,fs1,fs2,fs3,fs4,fs5,fs6,fd1,fd2,fd3,fd4,fd5,fd6,tune=0;
							#vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8,vol9,vol10,vol11,vol12 = [~vol1,~vol2,~vol3,~vol4,~vol5,~vol6,~vol7,~vol8,~vol9,~vol10,~vol11,~vol12];
							#s1,s2,s3,s4,s5,s6 = [\gsineicfld6, \gsineicrld6, \gsineicfld2, \gsineicrld2, \gsineicfld1, \gsineicrld1];
							~l1a = Synth(s1, [\dur, ~f1, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol1, \tune, tune],~icl6).register;    ~l1b = Synth(s2, [\dur, ~f1, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol1, \tune, tune],~icl6);
							~l1c = Synth(s3, [\dur, ~f1/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol1, \tune, tune], ~icl6);   ~l1d = Synth(s4, [\dur, ~f1/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol1, \tune, tune],~icl6);
							~l1e = Synth(s5, [\dur, ~f1/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol1, \tune, tune], ~icl6);   ~l1f = Synth(s6, [\dur, ~f1/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol1, \tune, tune],~icl6);
							~l2a = Synth(s1, [\dur, ~f2, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol2, \tune, tune],~icl6);        ~l2b = Synth(s2, [\dur, ~f2, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol2, \tune, tune],~icl6);
							~l2c = Synth(s3, [\dur, ~f2/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol2, \tune, tune], ~icl6);   ~l2d = Synth(s4, [\dur, ~f2/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol2, \tune, tune],~icl6);
							~l2e = Synth(s5, [\dur, ~f2/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol2, \tune, tune], ~icl6);   ~l2f = Synth(s6, [\dur, ~f2/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol2, \tune, tune],~icl6);
							~l3a = Synth(s1, [\dur, ~f3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol3, \tune, tune],~icl6);        ~l3b = Synth(s2, [\dur, ~f3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,  \vol, vol3, \tune, tune],~icl6);
							~l3c = Synth(s3, [\dur, ~f3/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol3, \tune, tune], ~icl6);   ~l3d = Synth(s4, [\dur, ~f3/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,\vol, vol3, \tune, tune],~icl6);
							~l3e = Synth(s5, [\dur, ~f3/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol3, \tune, tune], ~icl6);   ~l3f = Synth(s6, [\dur, ~f3/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,\vol, vol3, \tune, tune],~icl6);
							~l4a = Synth(s1, [\dur, ~f4, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol4, \tune, tune],~icl61);       ~l4b = Synth(s2, [\dur, ~f4, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,  \vol, vol4, \tune, tune],~icl61);
							~l4c = Synth(s3, [\dur, ~f4/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol4, \tune, tune], ~icl61);  ~l4d = Synth(s4, [\dur, ~f4/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,\vol, vol4, \tune, tune],~icl61);
							~l4e = Synth(s5, [\dur, ~f4/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol4, \tune, tune],~icl61);   ~l4f = Synth(s6, [\dur, ~f4/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,\vol, vol4, \tune, tune],~icl61);
							~l5a = Synth(s1, [\dur, ~f5, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol5, \tune, tune],~icl61);       ~l5b = Synth(s2, [\dur, ~f5, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,  \vol, vol5, \tune, tune],~icl61);
							~l5c = Synth(s3, [\dur, ~f5/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol5, \tune, tune],~icl61);   ~l5d = Synth(s4, [\dur, ~f5/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,\vol, vol5, \tune, tune],~icl61);
							~l5e = Synth(s5, [\dur, ~f5/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol5, \tune, tune],~icl61);   ~l5f = Synth(s6, [\dur, ~f5/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,\vol, vol5, \tune, tune],~icl61);
							~l6a = Synth(s1, [\dur, ~f6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol6, \tune, tune],~icl61);       ~l6b = Synth(s2, [\dur, ~f6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,  \vol, vol6, \tune, tune],~icl61);
							~l6c = Synth(s3, [\dur, ~f6/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol6, \tune, tune],~icl61);   ~l6d = Synth(s4, [\dur, ~f6/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,\vol, vol6, \tune, tune],~icl61);
							~l6e = Synth(s5, [\dur, ~f6/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol6, \tune, tune],~icl61);   ~l6f = Synth(s6, [\dur, ~f6/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,\vol, vol6, \tune, tune],~icl61);
							~l7a = Synth(s1, [\dur, ~f7, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol7, \tune, tune],~icl62);       ~l7b = Synth(s2, [\dur, ~f7, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,  \vol, vol7, \tune, tune],~icl62);
							~l7c = Synth(s3, [\dur, ~f7/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol7, \tune, tune],~icl62);   ~l7d = Synth(s4, [\dur, ~f7/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,\vol, vol7, \tune, tune],~icl62);
							~l7e = Synth(s5, [\dur, ~f7/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol7, \tune, tune],~icl62);   ~l7f = Synth(s6, [\dur, ~f7/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,\vol, vol7, \tune, tune],~icl62);
							~l8a = Synth(s1, [\dur, ~f8, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol8, \tune, tune],~icl62);  ~l8b = Synth(s2, [\dur, ~f8, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,  \vol, vol8, \tune, tune],~icl62);
							~l8c = Synth(s3, [\dur, ~f8/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol8, \tune, tune],~icl62);   ~l8d = Synth(s4, [\dur, ~f8/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,\vol, vol8, \tune, tune],~icl62);
							~l8e = Synth(s5, [\dur, ~f8/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol8, \tune, tune],~icl62);   ~l8f = Synth(s6, [\dur, ~f8/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,\vol, vol8, \tune, tune],~icl62);
							/*~l9a = Synth(s1, [\dur, ~f9=f9, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol9, \tune, tune],~icl62);  ~l9b = Synth(s2, [\dur, ~f9, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,  \vol, vol9, \tune, tune],~icl62);
							~l9c = Synth(s1, [\dur, ~f9/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol9, \tune, tune],~icl62);   ~l9d = Synth(s2, [\dur, ~f9/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,\vol, vol9, \tune, tune],~icl62);
							~l9e = Synth(s1, [\dur, ~f9/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol9, \tune, tune],~icl62);   ~l9f = Synth(s2, [\dur, ~f9/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,\vol, vol9, \tune, tune],~icl62);
							~l10a = Synth(s1, [\dur,~f10= f10, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol10, \tune, tune],~icl63); ~l10b = Synth(s2, [\dur, ~f10, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,\vol, vol10, \tune, tune],~icl63);
							~l10c = Synth(s1, [\dur, ~f10/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol10, \tune, tune],~icl63);~l10d = Synth(s2, [\dur, ~f10/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol10, \tune, tune],~icl63);
							~l10e = Synth(s1, [\dur, ~f10/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol10, \tune, tune],~icl63);~l10f = Synth(s2, [\dur, ~f10/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol10, \tune, tune],~icl63);
							~l11a = Synth(s1, [\dur,~f11= f11, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,  \vol, vol11, \tune, tune],~icl63);~l11b = Synth(s2, [\dur, ~f11, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol11, \tune, tune],~icl63);
							~l11c = Synth(s1, [\dur, ~f11/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol11, \tune, tune],~icl63);~l11d = Synth(s2, [\dur, ~f11/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol11, \tune, tune],~icl63);
							~l11e = Synth(s1, [\dur, ~f11/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol11, \tune, tune],~icl63);~l11f = Synth(s2, [\dur, ~f11/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol11, \tune, tune],~icl63);
							~l12a = Synth(s1, [\dur,~f12= f12, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,  \vol, vol12, \tune, tune],~icl63);~l12b = Synth(s2, [\dur, ~f12, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol12, \tune, tune],~icl63);
							~l12c = Synth(s1, [\dur, ~f12/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol12, \tune, tune],~icl63);~l12d = Synth(s2, [\dur, ~f12/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol12, \tune, tune],~icl63);
							~l12e = Synth(s1, [\dur, ~f12/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol12, \tune, tune],~icl63);~l12f = Synth(s2, [\dur, ~f12/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol12, \tune, tune],~icl63);
							*/
						});
					);
					AppClock.sched(0.161803398875,{
						([~l1a1,~l1b1,~l1c1,~l1d1,~l1e1,~l1f1,~l2a1,~l2b1,~l2c1,~l2d1,~l2e1,~l2f1,~l3a1,~l3b1,~l3c1,~l3d1,~l3e1,~l3f1,~l4a1,~l4b1,~l4c1,~l4d1,~l4e1,~l4f1,~l5a1,~l5b1,~l5c1,~l5d1,~l5e1,~l5f1,~l6a1,~l6b1,~l6c1,~l6d1,~l6e1,~l6f1,~l7a1,~l7b1,~l7c1,~l7d1,~l7e1,~l7f1,~l8a1,~l8b1,~l8c1,~l8d1,~l8e1,~l8f1/*,~l9a1,~l9b1,~l9c1,~l9d1,~l9e1,~l9f1,~l10a1,~l10b1,~l10c1,~l10d1,~l10e1,~l10f1,~l11a1,~l11b1,~l11c1,~l11d1,~l11e1,~l11f1,~l12a1,~l12b1,~l12c1,~l12d1,~l12e1,~l12f*/ ].do(_.free)); ~slideroutine.stop;
					});
				}
				{~l1a.isRunning == true}{
					(1.do({var a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,fs,rs,vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8,vol9,vol10,vol11,vol12,s1,s2,s3,s4,s5,s6,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,f19,f20,f21,f22,f23,f24,fs1,fs2,fs3,fs4,fs5,fs6,fd1,fd2,fd3,fd4,fd5,fd6,tune=0;
						#vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8,vol9,vol10,vol11,vol12 = [~vol1,~vol2,~vol3,~vol4,~vol5,~vol6,~vol7,~vol8,~vol9,~vol10,~vol11,~vol12];
						#f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12 = [ 0,0,0,0,0,0,0,0,0,0,0,0 ];
						~l1a.set(\dur, f1, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,    \vol, vol1, \tune, tune);  ~l1b.set(\dur, f1, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol1, \tune, tune);
						~l1c.set(\dur, f1/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol1, \tune, tune);  ~l1d.set(\dur, f1/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol1, \tune, tune);
						~l1e.set(\dur, f1/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol1, \tune, tune);  ~l1f.set(\dur, f1/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol1, \tune, tune);
						~l2a.set(\dur, f2, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,    \vol, vol2, \tune, tune);          ~l2b.set(\dur, f2, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol2, \tune, tune);
						~l2c.set(\dur, f2/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol2, \tune, tune);  ~l2d.set(\dur, f2/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol2, \tune, tune);
						~l2e.set(\dur, f2/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol2, \tune, tune);  ~l2f.set(\dur, f2/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol2, \tune, tune);
						~l3a.set(\dur, f3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,    \vol, vol3, \tune, tune);          ~l3b.set(\dur, f3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol3, \tune, tune);
						~l3c.set(\dur, f3/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol3, \tune, tune);  ~l3d.set(\dur, f3/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol3, \tune, tune);
						~l3e.set(\dur, f3/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol3, \tune, tune);  ~l3f.set(\dur, f3/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol3, \tune, tune);
						~l4a.set(\dur, f4, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol4, \tune, tune);           ~l4b.set(\dur, f4, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol4, \tune, tune);
						~l4c.set(\dur, f4/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol4, \tune, tune);  ~l4d.set(\dur, f4/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol4, \tune, tune);
						~l4e.set(\dur, f4/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol4, \tune, tune);  ~l4f.set(\dur, f4/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol4, \tune, tune);
						~l5a.set(\dur, f5, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol5, \tune, tune);           ~l5b.set(\dur, f5, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol5, \tune, tune);
						~l5c.set(\dur, f5/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol5, \tune, tune);  ~l5d.set(\dur, f5/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol5, \tune, tune);
						~l5e.set(\dur, f5/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol5, \tune, tune);  ~l5f.set(\dur, f5/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol5, \tune, tune);
						~l6a.set(\dur, f6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol6, \tune, tune);           ~l6b.set(\dur, f6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol6, \tune, tune);
						~l6c.set(\dur, f6/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol6, \tune, tune);  ~l6d.set(\dur, f6/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol6, \tune, tune);
						~l6e.set(\dur, f6/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol6, \tune, tune);  ~l6f.set(\dur, f6/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol6, \tune, tune);
						~l7a.set(\dur, f7, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol7, \tune, tune);           ~l7b.set(\dur, f7, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol7, \tune, tune);
						~l7c.set(\dur, f7/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol7, \tune, tune);  ~l7d.set(\dur, f7/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol7, \tune, tune);
						~l7e.set(\dur, f7/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol7, \tune, tune);  ~l7f.set(\dur, f7/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol7, \tune, tune);
						~l8a.set(\dur, f8, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol8, \tune, tune);           ~l8b.set(\dur, f8, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol8, \tune, tune);
						~l8c.set(\dur, f8/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol8, \tune, tune);  ~l8d.set(\dur, f8/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol8, \tune, tune);
						~l8e.set(\dur, f8/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol8, \tune, tune);  ~l8f.set(\dur, f8/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol8, \tune, tune);
						/*~l9a.set(\dur, f9, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol9,  \tune, tune);          ~l9b.set(\dur, f9, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol9, \tune, tune);
						~l9c.set(\dur, f9/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol9,  \tune, tune); ~l9d.set(\dur, f9/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol9, \tune, tune);
						~l9e.set(\dur, f9/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol9,  \tune, tune); ~l9f.set(\dur, f9/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol9, \tune, tune);
						~l10a.set(\dur, f10, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol10,  \tune, tune);         ~l10b.set(\dur, f10, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol10, \tune, tune);
						~l10c.set(\dur, f10/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,    \vol, vol10,  \tune, tune);~l10d.set(\dur, f10/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol10, \tune, tune);
						~l10e.set(\dur, f10/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,    \vol, vol10,  \tune, tune);~l10f.set(\dur, f10/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol10, \tune, tune);
						~l11a.set(\dur, f11, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol11,  \tune, tune);         ~l11b.set(\dur, f11, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol11, \tune, tune);
						~l11c.set(\dur, f11/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,    \vol, vol11,  \tune, tune);~l11d.set(\dur, f11/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol11, \tune, tune);
						~l11e.set(\dur, f11/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,    \vol, vol11,  \tune, tune);~l11f.set(\dur, f11/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol11, \tune, tune);
						~l12a.set(\dur, f12, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol12,  \tune, tune);         ~l12b.set(\dur, f12, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol12, \tune, tune);
						~l12c.set(\dur, f12/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,    \vol, vol12,  \tune, tune);~l12d.set(\dur, f12/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol12, \tune, tune);
						~l12e.set(\dur, f12/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,    \vol, vol12,  \tune, tune);~l12f.set(\dur, f12/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol12, \tune, tune);
					*/	}););

					(~icl6=ParGroup.new;~icl61=ParGroup.new;~icl62=ParGroup.new;~icl63=ParGroup.new;
						1.do({var a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,fs,rs,vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8,vol9,vol10,vol11,vol12,s1,s2,s3,s4,s5,s6,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,f19,f20,f21,f22,f23,f24,fs1,fs2,fs3,fs4,fs5,fs6,fd1,fd2,fd3,fd4,fd5,fd6,tune=0;
							#vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8,vol9,vol10,vol11,vol12 = [~vol1,~vol2,~vol3,~vol4,~vol5,~vol6,~vol7,~vol8,~vol9,~vol10,~vol11,~vol12];
							#s1,s2,s3,s4,s5,s6 = [\gsineicfld6, \gsineicrld6, \gsineicfld2, \gsineicrld2, \gsineicfld1, \gsineicrld1];
							~l1a1 = Synth(s1, [\dur, ~f1, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol1, \tune, tune],~icl6).register;    ~l1b1 = Synth(s2, [\dur, ~f1, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol1, \tune, tune],~icl6);
							~l1c1 = Synth(s3, [\dur, ~f1/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol1, \tune, tune], ~icl6);   ~l1d1 = Synth(s4, [\dur, ~f1/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol1, \tune, tune],~icl6);
							~l1e1 = Synth(s5, [\dur, ~f1/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol1, \tune, tune], ~icl6);   ~l1f1 = Synth(s6, [\dur, ~f1/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol1, \tune, tune],~icl6);
							~l2a1 = Synth(s1, [\dur, ~f2, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol2, \tune, tune],~icl6);        ~l2b1 = Synth(s2, [\dur, ~f2, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol2, \tune, tune],~icl6);
							~l2c1 = Synth(s3, [\dur, ~f2/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol2, \tune, tune], ~icl6);   ~l2d1 = Synth(s4, [\dur, ~f2/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol2, \tune, tune],~icl6);
							~l2e1 = Synth(s5, [\dur, ~f2/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol2, \tune, tune], ~icl6);   ~l2f1 = Synth(s6, [\dur, ~f2/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol2, \tune, tune],~icl6);
							~l3a1 = Synth(s1, [\dur, ~f3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol3, \tune, tune],~icl6);        ~l3b1 = Synth(s2, [\dur, ~f3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,  \vol, vol3, \tune, tune],~icl6);
							~l3c1 = Synth(s3, [\dur, ~f3/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol3, \tune, tune], ~icl6);   ~l3d1 = Synth(s4, [\dur, ~f3/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,\vol, vol3, \tune, tune],~icl6);
							~l3e1 = Synth(s5, [\dur, ~f3/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol3, \tune, tune], ~icl6);   ~l3f1 = Synth(s6, [\dur, ~f3/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,\vol, vol3, \tune, tune],~icl6);
							~l4a1 = Synth(s1, [\dur, ~f4, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol4, \tune, tune],~icl61);       ~l4b1 = Synth(s2, [\dur, ~f4, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,  \vol, vol4, \tune, tune],~icl61);
							~l4c1 = Synth(s3, [\dur, ~f4/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol4, \tune, tune], ~icl61);  ~l4d1 = Synth(s4, [\dur, ~f4/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,\vol, vol4, \tune, tune],~icl61);
							~l4e1 = Synth(s5, [\dur, ~f4/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol4, \tune, tune],~icl61);   ~l4f1 = Synth(s6, [\dur, ~f4/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,\vol, vol4, \tune, tune],~icl61);
							~l5a1 = Synth(s1, [\dur, ~f5, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol5, \tune, tune],~icl61);       ~l5b1 = Synth(s2, [\dur, ~f5, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,  \vol, vol5, \tune, tune],~icl61);
							~l5c1 = Synth(s3, [\dur, ~f5/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol5, \tune, tune],~icl61);   ~l5d1 = Synth(s4, [\dur, ~f5/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,\vol, vol5, \tune, tune],~icl61);
							~l5e1 = Synth(s5, [\dur, ~f5/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol5, \tune, tune],~icl61);   ~l5f1 = Synth(s6, [\dur, ~f5/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,\vol, vol5, \tune, tune],~icl61);
							~l6a1 = Synth(s1, [\dur, ~f6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol6, \tune, tune],~icl61);       ~l6b1 = Synth(s2, [\dur, ~f6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,  \vol, vol6, \tune, tune],~icl61);
							~l6c1 = Synth(s3, [\dur, ~f6/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol6, \tune, tune],~icl61);   ~l6d1 = Synth(s4, [\dur, ~f6/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,\vol, vol6, \tune, tune],~icl61);
							~l6e1 = Synth(s5, [\dur, ~f6/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol6, \tune, tune],~icl61);   ~l6f1 = Synth(s6, [\dur, ~f6/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,\vol, vol6, \tune, tune],~icl61);
							~l7a1 = Synth(s1, [\dur, ~f7, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol7, \tune, tune],~icl62);       ~l7b1 = Synth(s2, [\dur, ~f7, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,  \vol, vol7, \tune, tune],~icl62);
							~l7c1 = Synth(s3, [\dur, ~f7/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol7, \tune, tune],~icl62);   ~l7d1 = Synth(s4, [\dur, ~f7/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,\vol, vol7, \tune, tune],~icl62);
							~l7e1 = Synth(s5, [\dur, ~f7/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol7, \tune, tune],~icl62);   ~l7f1 = Synth(s6, [\dur, ~f7/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,\vol, vol7, \tune, tune],~icl62);
							~l8a1 = Synth(s1, [\dur, ~f8, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol8, \tune, tune],~icl62);  ~l8b1 = Synth(s2, [\dur, ~f8, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,  \vol, vol8, \tune, tune],~icl62);
							~l8c1 = Synth(s3, [\dur, ~f8/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol8, \tune, tune],~icl62);   ~l8d1 = Synth(s4, [\dur, ~f8/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,\vol, vol8, \tune, tune],~icl62);
							~l8e1 = Synth(s5, [\dur, ~f8/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol8, \tune, tune],~icl62);   ~l8f1 = Synth(s6, [\dur, ~f8/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,\vol, vol8, \tune, tune],~icl62);
							/*~l9a1 = Synth(s1, [\dur, ~f9=f9, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol9, \tune, tune],~icl62);  ~l9b1 = Synth(s2, [\dur, ~f9, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,  \vol, vol9, \tune, tune],~icl62);
							~l9c1 = Synth(s1, [\dur, ~f9/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol9, \tune, tune],~icl62);   ~l9d1 = Synth(s2, [\dur, ~f9/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,\vol, vol9, \tune, tune],~icl62);
							~l9e1 = Synth(s1, [\dur, ~f9/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol9, \tune, tune],~icl62);   ~l9f1 = Synth(s2, [\dur, ~f9/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,\vol, vol9, \tune, tune],~icl62);
							~l10a1 = Synth(s1, [\dur,~f10= f10, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol10, \tune, tune],~icl63); ~l10b1 = Synth(s2, [\dur, ~f10, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,\vol, vol10, \tune, tune],~icl63);
							~l10c1 = Synth(s1, [\dur, ~f10/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol10, \tune, tune],~icl63);~l10d1 = Synth(s2, [\dur, ~f10/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol10, \tune, tune],~icl63);
							~l10e1 = Synth(s1, [\dur, ~f10/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol10, \tune, tune],~icl63);~l10f1 = Synth(s2, [\dur, ~f10/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol10, \tune, tune],~icl63);
							~l11a1 = Synth(s1, [\dur,~f11= f11, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,  \vol, vol11, \tune, tune],~icl63);~l11b1 = Synth(s2, [\dur, ~f11, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol11, \tune, tune],~icl63);
							~l11c1 = Synth(s1, [\dur, ~f11/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol11, \tune, tune],~icl63);~l11d1 = Synth(s2, [\dur, ~f11/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol11, \tune, tune],~icl63);
							~l11e1 = Synth(s1, [\dur, ~f11/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol11, \tune, tune],~icl63);~l11f1 = Synth(s2, [\dur, ~f11/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol11, \tune, tune],~icl63);
							~l12a1 = Synth(s1, [\dur,~f12= f12, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,  \vol, vol12, \tune, tune],~icl63);~l12b1 = Synth(s2, [\dur, ~f12, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol12, \tune, tune],~icl63);
							~l12c1 = Synth(s1, [\dur, ~f12/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol12, \tune, tune],~icl63);~l12d1 = Synth(s2, [\dur, ~f12/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol12, \tune, tune],~icl63);
							~l12e1 = Synth(s1, [\dur, ~f12/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol12, \tune, tune],~icl63);~l12f1 = Synth(s2, [\dur, ~f12/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol12, \tune, tune],~icl63);
							*/
						});
					);
					AppClock.sched(0.161803398875,{
						([~l1a,~l1b,~l1c,~l1d,~l1e,~l1f,~l2a,~l2b,~l2c,~l2d,~l2e,~l2f,~l3a,~l3b,~l3c,~l3d,~l3e,~l3f,~l4a,~l4b,~l4c,~l4d,~l4e,~l4f,~l5a,~l5b,~l5c,~l5d,~l5e,~l5f,~l6a,~l6b,~l6c,~l6d,~l6e,~l6f,~l7a,~l7b,~l7c,~l7d,~l7e,~l7f,~l8a,~l8b,~l8c,~l8d,~l8e,~l8f/*,~l9a,~l9b,~l9c,~l9d,~l9e,~l9f,~l10a,~l10b,~l10c,~l10d,~l10e,~l10f,~l11a,~l11b,~l11c,~l11d,~l11e,~l11f,~l12a,~l12b,~l12c,~l12d,~l12e,~l12f*/].do(_.free)); ~slideroutine.stop;
					});
				};


			};

			~synthflow = {
				case
				{~l1a1.isRunning == true}{
					(1.do({var a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,fs,rs,vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8,vol9,vol10,vol11,vol12,s1,s2,s3,s4,s5,s6,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,f19,f20,f21,f22,f23,f24,fs1,fs2,fs3,fs4,fs5,fs6,fd1,fd2,fd3,fd4,fd5,fd6,tune=0;
						#vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8,vol9,vol10,vol11,vol12 = [~vol1,~vol2,~vol3,~vol4,~vol5,~vol6,~vol7,~vol8,~vol9,~vol10,~vol11,~vol12];
						~l1a1.set(\dur, ~f1, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,    \vol, vol1, \tune, tune);  ~l1b1.set(\dur, ~f1, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol1, \tune, tune);
						~l1c1.set(\dur, ~f1/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol1, \tune, tune);  ~l1d1.set(\dur, ~f1/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol1, \tune, tune);
						~l1e1.set(\dur, ~f1/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol1, \tune, tune);  ~l1f1.set(\dur, ~f1/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol1, \tune, tune);
						~l2a1.set(\dur, ~f2, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,    \vol, vol2, \tune, tune);          ~l2b1.set(\dur, ~f2, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol2, \tune, tune);
						~l2c1.set(\dur, ~f2/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol2, \tune, tune);  ~l2d1.set(\dur, ~f2/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol2, \tune, tune);
						~l2e1.set(\dur, ~f2/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol2, \tune, tune);  ~l2f1.set(\dur, ~f2/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol2, \tune, tune);
						~l3a1.set(\dur, ~f3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,    \vol, vol3, \tune, tune);          ~l3b1.set(\dur, ~f3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol3, \tune, tune);
						~l3c1.set(\dur, ~f3/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol3, \tune, tune);  ~l3d1.set(\dur, ~f3/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol3, \tune, tune);
						~l3e1.set(\dur, ~f3/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol3, \tune, tune);  ~l3f1.set(\dur, ~f3/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol3, \tune, tune);
						~l4a1.set(\dur, ~f4, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol4, \tune, tune);           ~l4b1.set(\dur, ~f4, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol4, \tune, tune);
						~l4c1.set(\dur, ~f4/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol4, \tune, tune);  ~l4d1.set(\dur, ~f4/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol4, \tune, tune);
						~l4e1.set(\dur, ~f4/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol4, \tune, tune);  ~l4f1.set(\dur, ~f4/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol4, \tune, tune);
						~l5a1.set(\dur, ~f5, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol5, \tune, tune);           ~l5b1.set(\dur, ~f5, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol5, \tune, tune);
						~l5c1.set(\dur, ~f5/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol5, \tune, tune);  ~l5d1.set(\dur, ~f5/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol5, \tune, tune);
						~l5e1.set(\dur, ~f5/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol5, \tune, tune);  ~l5f1.set(\dur, ~f5/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol5, \tune, tune);
						~l6a1.set(\dur, ~f6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol6, \tune, tune);           ~l6b1.set(\dur, ~f6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol6, \tune, tune);
						~l6c1.set(\dur, ~f6/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol6, \tune, tune);  ~l6d1.set(\dur, ~f6/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol6, \tune, tune);
						~l6e1.set(\dur, ~f6/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol6, \tune, tune);  ~l6f1.set(\dur, ~f6/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol6, \tune, tune);
						~l7a1.set(\dur, ~f7, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol7, \tune, tune);           ~l7b1.set(\dur, ~f7, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol7, \tune, tune);
						~l7c1.set(\dur, ~f7/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol7, \tune, tune);  ~l7d1.set(\dur, ~f7/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol7, \tune, tune);
						~l7e1.set(\dur, ~f7/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol7, \tune, tune);  ~l7f1.set(\dur, ~f7/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol7, \tune, tune);
						~l8a1.set(\dur, ~f8, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol8, \tune, tune);           ~l8b1.set(\dur, ~f8, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol8, \tune, tune);
						~l8c1.set(\dur, ~f8/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol8, \tune, tune);  ~l8d1.set(\dur, ~f8/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol8, \tune, tune);
						~l8e1.set(\dur, ~f8/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol8, \tune, tune);  ~l8f1.set(\dur, ~f8/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol8, \tune, tune);
						/*~l9a1.set(\dur, ~f9, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol9,  \tune, tune);          ~l9b1.set(\dur, ~f9, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol9, \tune, tune);
						~l9c1.set(\dur, ~f9/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol9,  \tune, tune); ~l9d1.set(\dur, ~f9/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol9, \tune, tune);
						~l9e1.set(\dur, ~f9/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol9,  \tune, tune); ~l9f1.set(\dur, ~f9/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol9, \tune, tune);
						~l10a1.set(\dur, ~f10, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol10,  \tune, tune);         ~l10b1.set(\dur, ~f10, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol10, \tune, tune);
						~l10c1.set(\dur, ~f10/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,    \vol, vol10,  \tune, tune);~l10d1.set(\dur, ~f10/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol10, \tune, tune);
						~l10e1.set(\dur, ~f10/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,    \vol, vol10,  \tune, tune);~l10f1.set(\dur, ~f10/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol10, \tune, tune);
						~l11a1.set(\dur, ~f11, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol11,  \tune, tune);         ~l11b1.set(\dur, ~f11, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol11, \tune, tune);
						~l11c1.set(\dur, ~f11/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,    \vol, vol11,  \tune, tune);~l11d1.set(\dur, ~f11/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol11, \tune, tune);
						~l11e1.set(\dur, ~f11/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,    \vol, vol11,  \tune, tune);~l11f1.set(\dur, ~f11/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol11, \tune, tune);
						~l12a1.set(\dur, ~f12, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol12,  \tune, tune);         ~l12b1.set(\dur, ~f12, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol12, \tune, tune);
						~l12c1.set(\dur, ~f12/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,    \vol, vol12,  \tune, tune);~l12d1.set(\dur, ~f12/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol12, \tune, tune);
						~l12e1.set(\dur, ~f12/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,    \vol, vol12,  \tune, tune);~l12f1.set(\dur, ~f12/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol12, \tune, tune);
					*/	}););
				}
				{~l1a.isRunning == true} {
					(1.do({var a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,fs,rs,vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8,vol9,vol10,vol11,vol12,s1,s2,s3,s4,s5,s6,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,f19,f20,f21,f22,f23,f24,fs1,fs2,fs3,fs4,fs5,fs6,fd1,fd2,fd3,fd4,fd5,fd6,tune=0;
						#vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8,vol9,vol10,vol11,vol12 = [~vol1,~vol2,~vol3,~vol4,~vol5,~vol6,~vol7,~vol8,~vol9,~vol10,~vol11,~vol12];
						~l1a.set(\dur, ~f1, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,    \vol, vol1, \tune, tune);  ~l1b.set(\dur, ~f1, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol1, \tune, tune);
						~l1c.set(\dur, ~f1/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol1, \tune, tune);  ~l1d.set(\dur, ~f1/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol1, \tune, tune);
						~l1e.set(\dur, ~f1/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol1, \tune, tune);  ~l1f.set(\dur, ~f1/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol1, \tune, tune);
						~l2a.set(\dur, ~f2, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,    \vol, vol2, \tune, tune);          ~l2b.set(\dur, ~f2, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol2, \tune, tune);
						~l2c.set(\dur, ~f2/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol2, \tune, tune);  ~l2d.set(\dur, ~f2/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol2, \tune, tune);
						~l2e.set(\dur, ~f2/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol2, \tune, tune);  ~l2f.set(\dur, ~f2/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol2, \tune, tune);
						~l3a.set(\dur, ~f3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,    \vol, vol3, \tune, tune);          ~l3b.set(\dur, ~f3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol3, \tune, tune);
						~l3c.set(\dur, ~f3/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol3, \tune, tune);  ~l3d.set(\dur, ~f3/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol3, \tune, tune);
						~l3e.set(\dur, ~f3/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol3, \tune, tune);  ~l3f.set(\dur, ~f3/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol3, \tune, tune);
						~l4a.set(\dur, ~f4, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol4, \tune, tune);           ~l4b.set(\dur, ~f4, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol4, \tune, tune);
						~l4c.set(\dur, ~f4/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol4, \tune, tune);  ~l4d.set(\dur, ~f4/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol4, \tune, tune);
						~l4e.set(\dur, ~f4/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol4, \tune, tune);  ~l4f.set(\dur, ~f4/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol4, \tune, tune);
						~l5a.set(\dur, ~f5, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol5, \tune, tune);           ~l5b.set(\dur, ~f5, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol5, \tune, tune);
						~l5c.set(\dur, ~f5/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol5, \tune, tune);  ~l5d.set(\dur, ~f5/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol5, \tune, tune);
						~l5e.set(\dur, ~f5/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol5, \tune, tune);  ~l5f.set(\dur, ~f5/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol5, \tune, tune);
						~l6a.set(\dur, ~f6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol6, \tune, tune);           ~l6b.set(\dur, ~f6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol6, \tune, tune);
						~l6c.set(\dur, ~f6/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol6, \tune, tune);  ~l6d.set(\dur, ~f6/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol6, \tune, tune);
						~l6e.set(\dur, ~f6/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol6, \tune, tune);  ~l6f.set(\dur, ~f6/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol6, \tune, tune);
						~l7a.set(\dur, ~f7, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol7, \tune, tune);           ~l7b.set(\dur, ~f7, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol7, \tune, tune);
						~l7c.set(\dur, ~f7/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol7, \tune, tune);  ~l7d.set(\dur, ~f7/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol7, \tune, tune);
						~l7e.set(\dur, ~f7/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol7, \tune, tune);  ~l7f.set(\dur, ~f7/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol7, \tune, tune);
						~l8a.set(\dur, ~f8, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol8, \tune, tune);           ~l8b.set(\dur, ~f8, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol8, \tune, tune);
						~l8c.set(\dur, ~f8/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol8, \tune, tune);  ~l8d.set(\dur, ~f8/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol8, \tune, tune);
						~l8e.set(\dur, ~f8/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol8, \tune, tune);  ~l8f.set(\dur, ~f8/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol8, \tune, tune);
						/*~l9a.set(\dur, ~f9, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol9,  \tune, tune);          ~l9b.set(\dur, ~f9, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol9, \tune, tune);
						~l9c.set(\dur, ~f9/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol9,  \tune, tune); ~l9d.set(\dur, ~f9/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol9, \tune, tune);
						~l9e.set(\dur, ~f9/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol9,  \tune, tune); ~l9f.set(\dur, ~f9/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol9, \tune, tune);
						~l10a.set(\dur, ~f10, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol10,  \tune, tune);         ~l10b.set(\dur, ~f10, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol10, \tune, tune);
						~l10c.set(\dur, ~f10/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,    \vol, vol10,  \tune, tune);~l10d.set(\dur, ~f10/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol10, \tune, tune);
						~l10e.set(\dur, ~f10/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,    \vol, vol10,  \tune, tune);~l10f.set(\dur, ~f10/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol10, \tune, tune);
						~l11a.set(\dur, ~f11, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol11,  \tune, tune);         ~l11b.set(\dur, ~f11, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol11, \tune, tune);
						~l11c.set(\dur, ~f11/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,    \vol, vol11,  \tune, tune);~l11d.set(\dur, ~f11/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol11, \tune, tune);
						~l11e.set(\dur, ~f11/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,    \vol, vol11,  \tune, tune);~l11f.set(\dur, ~f11/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol11, \tune, tune);
						~l12a.set(\dur, ~f12, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol12,  \tune, tune);         ~l12b.set(\dur, ~f12, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol12, \tune, tune);
						~l12c.set(\dur, ~f12/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,    \vol, vol12,  \tune, tune);~l12d.set(\dur, ~f12/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol12, \tune, tune);
						~l12e.set(\dur, ~f12/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,    \vol, vol12,  \tune, tune);~l12f.set(\dur, ~f12/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol12, \tune, tune);
						*/
					}););
				};


			};

	~synthslide = {case{~l1a1.isRunning == true}{(
			~slideroutine = Routine({
				1.do({var a,b,c,d,e,f,fs,rs,vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8,vol9,vol10,vol11,vol12,s1,s2,s3,s4,s5,s6,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,f19,f20,f21,f22,f23,f24,fs1,fs2,fs3,fs4,fs5,fs6,fd1,fd2,fd3,fd4,fd5,fd6,tune=0;#vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8,vol9,vol10,vol11,vol12 = [~vol1,~vol2,~vol3,~vol4,~vol5,~vol6,~vol7,~vol8,~vol9,~vol10,~vol11,~vol12];
			#g,h,i,j,k,l,m,n = (([ s,t,u,v,w,x,y,z ]-[ ~f1,~f2,~f3,~f4,~f5,~f6,~f7,~f8 ])*(-1)/~slidedo);~slidedo.do({([ s=s+g,t=t+h,u=u+i,v=v+j,w=w+k,x=x+l,y=y+m,z=z+n ];
						~l1a1.set(\dur, s, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol1, \tune, tune);
						~l1b1.set(\dur, s, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol1, \tune, tune);
						~l1c1.set(\dur, s/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol1, \tune, tune);
						~l1d1.set(\dur, s/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol1, \tune, tune);
						~l1e1.set(\dur, s/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol1, \tune, tune);
						~l1f1.set(\dur, s/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol1, \tune, tune);
						~l2a1.set(\dur, t, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol2, \tune, tune);
						~l2b1.set(\dur, t, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol2, \tune, tune);
						~l2c1.set(\dur, t/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol2, \tune, tune);
						~l2d1.set(\dur, t/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol2, \tune, tune);
						~l2e1.set(\dur, t/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol2, \tune, tune);
						~l2f1.set(\dur, t/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol2, \tune, tune);
						~l3a1.set(\dur, u, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol3, \tune, tune);
						~l3b1.set(\dur, u, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol3, \tune, tune);
						~l3c1.set(\dur, u/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol3, \tune, tune);
						~l3d1.set(\dur, u/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol3, \tune, tune);
						~l3e1.set(\dur, u/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol3, \tune, tune);
						~l3f1.set(\dur, u/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol3, \tune, tune);
						~l4a1.set(\dur, v, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol4, \tune, tune);
						~l4b1.set(\dur, v, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol4, \tune, tune);
						~l4c1.set(\dur, v/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol4, \tune, tune);
						~l4d1.set(\dur, v/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol4, \tune, tune);
						~l4e1.set(\dur, v/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol4, \tune, tune);
						~l4f1.set(\dur, v/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol4, \tune, tune);
						~l5a1.set(\dur, w, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol5, \tune, tune);
						~l5b1.set(\dur, w, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol5, \tune, tune);
						~l5c1.set(\dur, w/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol5, \tune, tune);
						~l5d1.set(\dur, w/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol5, \tune, tune);
						~l5e1.set(\dur, w/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol5, \tune, tune);
						~l5f1.set(\dur, w/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol5, \tune, tune);
						~l6a1.set(\dur, x, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol6, \tune, tune);
						~l6b1.set(\dur, x, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol6, \tune, tune);
						~l6c1.set(\dur, x/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol6, \tune, tune);
						~l6d1.set(\dur, x/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol6, \tune, tune);
						~l6e1.set(\dur, x/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol6, \tune, tune);
						~l6f1.set(\dur, x/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol6, \tune, tune);
						~l7a1.set(\dur, y, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol7, \tune, tune);
						~l7b1.set(\dur, y, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol7, \tune, tune);
						~l7c1.set(\dur, y/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol7, \tune, tune);
						~l7d1.set(\dur, y/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol7, \tune, tune);
						~l7e1.set(\dur, y/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol7, \tune, tune);
						~l7f1.set(\dur, y/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol7, \tune, tune);
						~l8a1.set(\dur, z, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol8, \tune, tune);
						~l8b1.set(\dur, z, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol8, \tune, tune);
						~l8c1.set(\dur, z/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol8, \tune, tune);
						~l8d1.set(\dur, z/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol8, \tune, tune);
						~l8e1.set(\dur, z/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol8, \tune, tune);
						~l8f1.set(\dur, z/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol8, \tune, tune);/*~l9a1.set(\dur, ~f9, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol9, \tune, tune); ~l9b1.set(\dur, ~f9, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol9, \tune, tune);~l9c1.set(\dur, ~f9/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol9, \tune, tune); ~l9d1.set(\dur, ~f9/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol9, \tune, tune);~l9e1.set(\dur, ~f9/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol9, \tune, tune); ~l9f1.set(\dur, ~f9/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol9, \tune, tune);~l10a1.set(\dur, ~f10, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol10, \tune, tune); ~l10b1.set(\dur, ~f10, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol10, \tune, tune);~l10c1.set(\dur, ~f10/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol10, \tune, tune);~l10d1.set(\dur, ~f10/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol10, \tune, tune);~l10e1.set(\dur, ~f10/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol10, \tune, tune);~l10f1.set(\dur, ~f10/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol10, \tune, tune);~l11a1.set(\dur, ~f11, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol11, \tune, tune); ~l11b1.set(\dur, ~f11, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol11, \tune, tune);~l11c1.set(\dur, ~f11/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol11, \tune, tune);~l11d1.set(\dur, ~f11/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol11, \tune, tune);~l11e1.set(\dur, ~f11/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol11, \tune, tune);~l11f1.set(\dur, ~f11/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol11, \tune, tune);~l12a1.set(\dur, ~f12, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol12, \tune, tune); ~l12b1.set(\dur, ~f12, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol12, \tune, tune);~l12c1.set(\dur, ~f12/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol12, \tune, tune);~l12d1.set(\dur, ~f12/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol12, \tune, tune);~l12e1.set(\dur, ~f12/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol12, \tune, tune);~l12f1.set(\dur, ~f12/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol12, \tune, tune);*/
		);
						(~slidetime/~slidedo).wait;
		});});}).play;);}{~l1a.isRunning == true} {(
				~slideroutine = Routine({1.do({var a,b,c,d,e,f,fs,rs,vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8,vol9,vol10,vol11,vol12,s1,s2,s3,s4,s5,s6,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,f19,f20,f21,f22,f23,f24,fs1,fs2,fs3,fs4,fs5,fs6,fd1,fd2,fd3,fd4,fd5,fd6,tune=0;#vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8,vol9,vol10,vol11,vol12 = [~vol1,~vol2,~vol3,~vol4,~vol5,~vol6,~vol7,~vol8,~vol9,~vol10,~vol11,~vol12];
			#g,h,i,j,k,l,m,n = (([ s,t,u,v,w,x,y,z ]-[ ~f1,~f2,~f3,~f4,~f5,~f6,~f7,~f8 ])*(-1)/~slidedo);~slidedo.do({([ s=s+g,t=t+h,u=u+i,v=v+j,w=w+k,x=x+l,y=y+m,z=z+n ];
				~l1a.set(\dur, s, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol1, \tune, tune);
				~l1b.set(\dur, s, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol1, \tune, tune);
				~l1c.set(\dur, s/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol1, \tune, tune);
				~l1d.set(\dur, s/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol1, \tune, tune);
				~l1e.set(\dur, s/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol1, \tune, tune);
				~l1f.set(\dur, s/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol1, \tune, tune);
				~l2a.set(\dur, t, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol2, \tune, tune);
				~l2b.set(\dur, t, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol2, \tune, tune);
				~l2c.set(\dur, t/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol2, \tune, tune);
				~l2d.set(\dur, t/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol2, \tune, tune);
				~l2e.set(\dur, t/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol2, \tune, tune);
				~l2f.set(\dur, t/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol2, \tune, tune);
				~l3a.set(\dur, u, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol3, \tune, tune);
				~l3b.set(\dur, u, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol3, \tune, tune);
				~l3c.set(\dur, u/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol3, \tune, tune);
				~l3d.set(\dur, u/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol3, \tune, tune);
				~l3e.set(\dur, u/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol3, \tune, tune);
				~l3f.set(\dur, u/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol3, \tune, tune);
				~l4a.set(\dur, v, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol4, \tune, tune);
				~l4b.set(\dur, v, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol4, \tune, tune);
				~l4c.set(\dur, v/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol4, \tune, tune);
				~l4d.set(\dur, v/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol4, \tune, tune);
				~l4e.set(\dur, v/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol4, \tune, tune);
				~l4f.set(\dur, v/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol4, \tune, tune);
				~l5a.set(\dur, w, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol5, \tune, tune);
				~l5b.set(\dur, w, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol5, \tune, tune);
				~l5c.set(\dur, w/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol5, \tune, tune);
				~l5d.set(\dur, w/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol5, \tune, tune);
				~l5e.set(\dur, w/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol5, \tune, tune);
				~l5f.set(\dur, w/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol5, \tune, tune);
				~l6a.set(\dur, x, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol6, \tune, tune);
				~l6b.set(\dur, x, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol6, \tune, tune);
				~l6c.set(\dur, x/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol6, \tune, tune);
				~l6d.set(\dur, x/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol6, \tune, tune);
				~l6e.set(\dur, x/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol6, \tune, tune);
				~l6f.set(\dur, x/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol6, \tune, tune);
				~l7a.set(\dur, y, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol7, \tune, tune);
				~l7b.set(\dur, y, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol7, \tune, tune);
				~l7c.set(\dur, y/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol7, \tune, tune);
				~l7d.set(\dur, y/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol7, \tune, tune);
				~l7e.set(\dur, y/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol7, \tune, tune);
				~l7f.set(\dur, y/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol7, \tune, tune);
				~l8a.set(\dur, z, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol8, \tune, tune);
				~l8b.set(\dur, z, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol8, \tune, tune);
				~l8c.set(\dur, z/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol8, \tune, tune);
				~l8d.set(\dur, z/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol8, \tune, tune);
				~l8e.set(\dur, z/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol8, \tune, tune);
				~l8f.set(\dur, z/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol8, \tune, tune);
				/*~l9a.set(\dur, ~f9, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol9, \tune, tune); ~l9b.set(\dur, ~f9, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol9, \tune, tune);~l9c.set(\dur, ~f9/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol9, \tune, tune); ~l9d.set(\dur, ~f9/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol9, \tune, tune);~l9e.set(\dur, ~f9/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol9, \tune, tune); ~l9f.set(\dur, ~f9/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol9, \tune, tune);~l10a.set(\dur, ~f10, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol10, \tune, tune); ~l10b.set(\dur, ~f10, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol10, \tune, tune);~l10c.set(\dur, ~f10/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol10, \tune, tune);~l10d.set(\dur, ~f10/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol10, \tune, tune);~l10e.set(\dur, ~f10/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol10, \tune, tune);~l10f.set(\dur, ~f10/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol10, \tune, tune);~l11a.set(\dur, ~f11, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol11, \tune, tune); ~l11b.set(\dur, ~f11, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol11, \tune, tune);~l11c.set(\dur, ~f11/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol11, \tune, tune);~l11d.set(\dur, ~f11/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol11, \tune, tune);~l11e.set(\dur, ~f11/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol11, \tune, tune);~l11f.set(\dur, ~f11/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol11, \tune, tune);~l12a.set(\dur, ~f12, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol12, \tune, tune); ~l12b.set(\dur, ~f12, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol12, \tune, tune);~l12c.set(\dur, ~f12/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol12, \tune, tune);~l12d.set(\dur, ~f12/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol12, \tune, tune);~l12e.set(\dur, ~f12/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol12, \tune, tune);~l12f.set(\dur, ~f12/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol12, \tune, tune);*/
);
				(~slidetime/~slidedo).wait;});});
}).play;);};};


			~synthpause = {(
				case
				{~l1a1.isRunning == true}{
					(1.do({var a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,fs,rs,vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8,vol9,vol10,vol11,vol12,s1,s2,s3,s4,s5,s6,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,f19,f20,f21,f22,f23,f24,fs1,fs2,fs3,fs4,fs5,fs6,fd1,fd2,fd3,fd4,fd5,fd6,tune=0;
						#vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8,vol9,vol10,vol11,vol12 = [~vol1,~vol2,~vol3,~vol4,~vol5,~vol6,~vol7,~vol8,~vol9,~vol10,~vol11,~vol12];
						#f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12/*,f13,f14,f15,f16,f17,f18,f19,f20,f21,f22,f23,f24*/ = [0,0,0,0,0,0,0,0,0,0,0,0];
						~l1a1.set(\dur, f1, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,    \vol, vol1, \tune, tune);          ~l1b1.set(\dur, f1, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol1, \tune, tune);
						~l1c1.set(\dur, f1/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol1, \tune, tune);  ~l1d1.set(\dur, f1/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol1, \tune, tune);
						~l1e1.set(\dur, f1/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol1, \tune, tune);  ~l1f1.set(\dur, f1/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol1, \tune, tune);
						~l2a1.set(\dur, f2, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,    \vol, vol2, \tune, tune);          ~l2b1.set(\dur, f2, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol2, \tune, tune);
						~l2c1.set(\dur, f2/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol2, \tune, tune);  ~l2d1.set(\dur, f2/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol2, \tune, tune);
						~l2e1.set(\dur, f2/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol2, \tune, tune);  ~l2f1.set(\dur, f2/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol2, \tune, tune);
						~l3a1.set(\dur, f3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,    \vol, vol3, \tune, tune);          ~l3b1.set(\dur, f3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol3, \tune, tune);
						~l3c1.set(\dur, f3/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol3, \tune, tune);  ~l3d1.set(\dur, f3/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol3, \tune, tune);
						~l3e1.set(\dur, f3/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol3, \tune, tune);  ~l3f1.set(\dur, f3/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol3, \tune, tune);
						~l4a1.set(\dur, f4, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol4, \tune, tune);           ~l4b1.set(\dur, f4, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol4, \tune, tune);
						~l4c1.set(\dur, f4/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol4, \tune, tune);  ~l4d1.set(\dur, f4/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol4, \tune, tune);
						~l4e1.set(\dur, f4/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol4, \tune, tune);  ~l4f1.set(\dur, f4/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol4, \tune, tune);
						~l5a1.set(\dur, f5, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol5, \tune, tune);           ~l5b1.set(\dur, f5, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol5, \tune, tune);
						~l5c1.set(\dur, f5/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol5, \tune, tune);  ~l5d1.set(\dur, f5/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol5, \tune, tune);
						~l5e1.set(\dur, f5/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol5, \tune, tune);  ~l5f1.set(\dur, f5/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol5, \tune, tune);
						~l6a1.set(\dur, f6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol6, \tune, tune);           ~l6b1.set(\dur, f6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol6, \tune, tune);
						~l6c1.set(\dur, f6/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol6, \tune, tune);  ~l6d1.set(\dur, f6/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol6, \tune, tune);
						~l6e1.set(\dur, f6/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol6, \tune, tune);  ~l6f1.set(\dur, f6/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol6, \tune, tune);
						~l7a1.set(\dur, f7, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol7, \tune, tune);           ~l7b1.set(\dur, f7, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol7, \tune, tune);
						~l7c1.set(\dur, f7/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol7, \tune, tune);  ~l7d1.set(\dur, f7/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol7, \tune, tune);
						~l7e1.set(\dur, f7/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol7, \tune, tune);  ~l7f1.set(\dur, f7/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol7, \tune, tune);
						~l8a1.set(\dur, f8, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol8, \tune, tune);           ~l8b1.set(\dur, f8, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol8, \tune, tune);
						~l8c1.set(\dur, f8/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol8, \tune, tune);  ~l8d1.set(\dur, f8/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol8, \tune, tune);
						~l8e1.set(\dur, f8/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol8, \tune, tune);  ~l8f1.set(\dur, f8/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol8, \tune, tune);
						/*~l9a1.set(\dur, f9, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol9,  \tune, tune);          ~l9b1.set(\dur, f9, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol9, \tune, tune);
						~l9c1.set(\dur, f9/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol9,  \tune, tune); ~l9d1.set(\dur, f9/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol9, \tune, tune);
						~l9e1.set(\dur, f9/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol9,  \tune, tune); ~l9f1.set(\dur, f9/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol9, \tune, tune);
						~l10a1.set(\dur, f10, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol10,  \tune, tune);         ~l10b1.set(\dur, f10, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol10, \tune, tune);
						~l10c1.set(\dur, f10/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,    \vol, vol10,  \tune, tune);~l10d1.set(\dur, f10/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol10, \tune, tune);
						~l10e1.set(\dur, f10/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,    \vol, vol10,  \tune, tune);~l10f1.set(\dur, f10/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol10, \tune, tune);
						~l11a1.set(\dur, f11, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol11,  \tune, tune);         ~l11b1.set(\dur, f11, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol11, \tune, tune);
						~l11c1.set(\dur, f11/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,    \vol, vol11,  \tune, tune);~l11d1.set(\dur, f11/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol11, \tune, tune);
						~l11e1.set(\dur, f11/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,    \vol, vol11,  \tune, tune);~l11f1.set(\dur, f11/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol11, \tune, tune);
						~l12a1.set(\dur, f12, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol12,  \tune, tune);         ~l12b1.set(\dur, f12, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol12, \tune, tune);
						~l12c1.set(\dur, f12/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,    \vol, vol12,  \tune, tune);~l12d1.set(\dur, f12/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol12, \tune, tune);
						~l12e1.set(\dur, f12/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,    \vol, vol12,  \tune, tune);~l12f1.set(\dur, f12/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol12, \tune, tune);
					*/	}););
				}
				{~l1a.isRunning == true} {
					(1.do({var a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,fs,rs,vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8,vol9,vol10,vol11,vol12,s1,s2,s3,s4,s5,s6,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,f19,f20,f21,f22,f23,f24,fs1,fs2,fs3,fs4,fs5,fs6,fd1,fd2,fd3,fd4,fd5,fd6,tune=0;
						#vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8,vol9,vol10,vol11,vol12 = [~vol1,~vol2,~vol3,~vol4,~vol5,~vol6,~vol7,~vol8,~vol9,~vol10,~vol11,~vol12];
						#f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12/*,f13,f14,f15,f16,f17,f18,f19,f20,f21,f22,f23,f24*/ = [0,0,0,0,0,0,0,0,0,0,0,0];
						~l1a.set(\dur, f1, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,    \vol, vol1, \tune, tune);  ~l1b.set(\dur, f1, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol1, \tune, tune);
						~l1c.set(\dur, f1/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol1, \tune, tune);  ~l1d.set(\dur, f1/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol1, \tune, tune);
						~l1e.set(\dur, f1/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol1, \tune, tune);  ~l1f.set(\dur, f1/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol1, \tune, tune);
						~l2a.set(\dur, f2, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,    \vol, vol2, \tune, tune);          ~l2b.set(\dur, f2, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol2, \tune, tune);
						~l2c.set(\dur, f2/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol2, \tune, tune);  ~l2d.set(\dur, f2/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol2, \tune, tune);
						~l2e.set(\dur, f2/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol2, \tune, tune);  ~l2f.set(\dur, f2/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol2, \tune, tune);
						~l3a.set(\dur, f3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,    \vol, vol3, \tune, tune);          ~l3b.set(\dur, f3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol3, \tune, tune);
						~l3c.set(\dur, f3/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol3, \tune, tune);  ~l3d.set(\dur, f3/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol3, \tune, tune);
						~l3e.set(\dur, f3/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol3, \tune, tune);  ~l3f.set(\dur, f3/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol3, \tune, tune);
						~l4a.set(\dur, f4, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol4, \tune, tune);           ~l4b.set(\dur, f4, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol4, \tune, tune);
						~l4c.set(\dur, f4/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol4, \tune, tune);  ~l4d.set(\dur, f4/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol4, \tune, tune);
						~l4e.set(\dur, f4/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol4, \tune, tune);  ~l4f.set(\dur, f4/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol4, \tune, tune);
						~l5a.set(\dur, f5, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol5, \tune, tune);           ~l5b.set(\dur, f5, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol5, \tune, tune);
						~l5c.set(\dur, f5/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol5, \tune, tune);  ~l5d.set(\dur, f5/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol5, \tune, tune);
						~l5e.set(\dur, f5/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol5, \tune, tune);  ~l5f.set(\dur, f5/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol5, \tune, tune);
						~l6a.set(\dur, f6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol6, \tune, tune);           ~l6b.set(\dur, f6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol6, \tune, tune);
						~l6c.set(\dur, f6/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol6, \tune, tune);  ~l6d.set(\dur, f6/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol6, \tune, tune);
						~l6e.set(\dur, f6/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol6, \tune, tune);  ~l6f.set(\dur, f6/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol6, \tune, tune);
						~l7a.set(\dur, f7, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol7, \tune, tune);           ~l7b.set(\dur, f7, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol7, \tune, tune);
						~l7c.set(\dur, f7/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol7, \tune, tune);  ~l7d.set(\dur, f7/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol7, \tune, tune);
						~l7e.set(\dur, f7/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol7, \tune, tune);  ~l7f.set(\dur, f7/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol7, \tune, tune);
						~l8a.set(\dur, f8, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol8, \tune, tune);           ~l8b.set(\dur, f8, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol8, \tune, tune);
						~l8c.set(\dur, f8/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol8, \tune, tune);  ~l8d.set(\dur, f8/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol8, \tune, tune);
						~l8e.set(\dur, f8/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol8, \tune, tune);  ~l8f.set(\dur, f8/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol8, \tune, tune);
						/*~l9a.set(\dur, f9, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol9,  \tune, tune);          ~l9b.set(\dur, f9, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol9, \tune, tune);
						~l9c.set(\dur, f9/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol9,  \tune, tune); ~l9d.set(\dur, f9/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol9, \tune, tune);
						~l9e.set(\dur, f9/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol9,  \tune, tune); ~l9f.set(\dur, f9/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol9, \tune, tune);
						~l10a.set(\dur, f10, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol10,  \tune, tune);         ~l10b.set(\dur, f10, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol10, \tune, tune);
						~l10c.set(\dur, f10/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,    \vol, vol10,  \tune, tune);~l10d.set(\dur, f10/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol10, \tune, tune);
						~l10e.set(\dur, f10/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,    \vol, vol10,  \tune, tune);~l10f.set(\dur, f10/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol10, \tune, tune);
						~l11a.set(\dur, f11, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol11,  \tune, tune);         ~l11b.set(\dur, f11, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol11, \tune, tune);
						~l11c.set(\dur, f11/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,    \vol, vol11,  \tune, tune);~l11d.set(\dur, f11/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol11, \tune, tune);
						~l11e.set(\dur, f11/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,    \vol, vol11,  \tune, tune);~l11f.set(\dur, f11/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol11, \tune, tune);
						~l12a.set(\dur, f12, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol12,  \tune, tune);         ~l12b.set(\dur, f12, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol12, \tune, tune);
						~l12c.set(\dur, f12/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,    \vol, vol12,  \tune, tune);~l12d.set(\dur, f12/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol12, \tune, tune);
						~l12e.set(\dur, f12/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,    \vol, vol12,  \tune, tune);~l12f.set(\dur, f12/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol12, \tune, tune);
						*/
					}););
				};
				);
			};

			~synthfree = {
				(
					case
					{((~l1a.isRunning == false) and: (~l1a1.isRunning == false)) or: ~l1a1.isRunning == true}{
						(1.do({var a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,fs,rs,vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8,vol9,vol10,vol11,vol12,s1,s2,s3,s4,s5,s6,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,f19,f20,f21,f22,f23,f24,fs1,fs2,fs3,fs4,fs5,fs6,fd1,fd2,fd3,fd4,fd5,fd6,tune=0;
							#vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8,vol9,vol10,vol11,vol12 = [~vol1,~vol2,~vol3,~vol4,~vol5,~vol6,~vol7,~vol8,~vol9,~vol10,~vol11,~vol12];
							#f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12 = [ 0,0,0,0,0,0,0,0,0,0,0,0 ];
							~l1a1.set(\dur, f1, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,    \vol, vol1, \tune, tune);  ~l1b1.set(\dur, f1, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol1, \tune, tune);
							~l1c1.set(\dur, f1/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol1, \tune, tune);  ~l1d1.set(\dur, f1/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol1, \tune, tune);
							~l1e1.set(\dur, f1/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol1, \tune, tune);  ~l1f1.set(\dur, f1/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol1, \tune, tune);
							~l2a1.set(\dur, f2, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,    \vol, vol2, \tune, tune);          ~l2b1.set(\dur, f2, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol2, \tune, tune);
							~l2c1.set(\dur, f2/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol2, \tune, tune);  ~l2d1.set(\dur, f2/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol2, \tune, tune);
							~l2e1.set(\dur, f2/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol2, \tune, tune);  ~l2f1.set(\dur, f2/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol2, \tune, tune);
							~l3a1.set(\dur, f3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,    \vol, vol3, \tune, tune);          ~l3b1.set(\dur, f3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol3, \tune, tune);
							~l3c1.set(\dur, f3/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol3, \tune, tune);  ~l3d1.set(\dur, f3/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol3, \tune, tune);
							~l3e1.set(\dur, f3/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol3, \tune, tune);  ~l3f1.set(\dur, f3/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol3, \tune, tune);
							~l4a1.set(\dur, f4, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol4, \tune, tune);           ~l4b1.set(\dur, f4, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol4, \tune, tune);
							~l4c1.set(\dur, f4/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol4, \tune, tune);  ~l4d1.set(\dur, f4/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol4, \tune, tune);
							~l4e1.set(\dur, f4/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol4, \tune, tune);  ~l4f1.set(\dur, f4/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol4, \tune, tune);
							~l5a1.set(\dur, f5, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol5, \tune, tune);           ~l5b1.set(\dur, f5, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol5, \tune, tune);
							~l5c1.set(\dur, f5/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol5, \tune, tune);  ~l5d1.set(\dur, f5/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol5, \tune, tune);
							~l5e1.set(\dur, f5/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol5, \tune, tune);  ~l5f1.set(\dur, f5/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol5, \tune, tune);
							~l6a1.set(\dur, f6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol6, \tune, tune);           ~l6b1.set(\dur, f6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol6, \tune, tune);
							~l6c1.set(\dur, f6/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol6, \tune, tune);  ~l6d1.set(\dur, f6/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol6, \tune, tune);
							~l6e1.set(\dur, f6/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol6, \tune, tune);  ~l6f1.set(\dur, f6/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol6, \tune, tune);
							~l7a1.set(\dur, f7, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol7, \tune, tune);           ~l7b1.set(\dur, f7, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol7, \tune, tune);
							~l7c1.set(\dur, f7/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol7, \tune, tune);  ~l7d1.set(\dur, f7/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol7, \tune, tune);
							~l7e1.set(\dur, f7/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol7, \tune, tune);  ~l7f1.set(\dur, f7/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol7, \tune, tune);
							~l8a1.set(\dur, f8, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol8, \tune, tune);           ~l8b1.set(\dur, f8, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol8, \tune, tune);
							~l8c1.set(\dur, f8/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol8, \tune, tune);  ~l8d1.set(\dur, f8/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol8, \tune, tune);
							~l8e1.set(\dur, f8/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol8, \tune, tune);  ~l8f1.set(\dur, f8/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol8, \tune, tune);
							/*~l9a1.set(\dur, f9, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol9,  \tune, tune);          ~l9b1.set(\dur, f9, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol9, \tune, tune);
							~l9c1.set(\dur, f9/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol9,  \tune, tune); ~l9d1.set(\dur, f9/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol9, \tune, tune);
							~l9e1.set(\dur, f9/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol9,  \tune, tune); ~l9f1.set(\dur, f9/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol9, \tune, tune);
							~l10a1.set(\dur, f10, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol10,  \tune, tune);         ~l10b1.set(\dur, f10, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol10, \tune, tune);
							~l10c1.set(\dur, f10/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,    \vol, vol10,  \tune, tune);~l10d1.set(\dur, f10/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol10, \tune, tune);
							~l10e1.set(\dur, f10/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,    \vol, vol10,  \tune, tune);~l10f1.set(\dur, f10/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol10, \tune, tune);
							~l11a1.set(\dur, f11, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol11,  \tune, tune);         ~l11b1.set(\dur, f11, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol11, \tune, tune);
							~l11c1.set(\dur, f11/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,    \vol, vol11,  \tune, tune);~l11d1.set(\dur, f11/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol11, \tune, tune);
							~l11e1.set(\dur, f11/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,    \vol, vol11,  \tune, tune);~l11f1.set(\dur, f11/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol11, \tune, tune);
							~l12a1.set(\dur, f12, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol12,  \tune, tune);         ~l12b1.set(\dur, f12, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol12, \tune, tune);
							~l12c1.set(\dur, f12/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,    \vol, vol12,  \tune, tune);~l12d1.set(\dur, f12/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol12, \tune, tune);
							~l12e1.set(\dur, f12/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,    \vol, vol12,  \tune, tune);~l12f1.set(\dur, f12/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol12, \tune, tune);
						*/	}););
						AppClock.sched(0.161803398875,{
							([~l1a1,~l1b1,~l1c1,~l1d1,~l1e1,~l1f1,~l2a1,~l2b1,~l2c1,~l2d1,~l2e1,~l2f1,~l3a1,~l3b1,~l3c1,~l3d1,~l3e1,~l3f1,~l4a1,~l4b1,~l4c1,~l4d1,~l4e1,~l4f1,~l5a1,~l5b1,~l5c1,~l5d1,~l5e1,~l5f1,~l6a1,~l6b1,~l6c1,~l6d1,~l6e1,~l6f1,~l7a1,~l7b1,~l7c1,~l7d1,~l7e1,~l7f1,~l8a1,~l8b1,~l8c1,~l8d1,~l8e1,~l8f1/*,~l9a1,~l9b1,~l9c1,~l9d1,~l9e1,~l9f1,~l10a1,~l10b1,~l10c1,~l10d1,~l10e1,~l10f1,~l11a1,~l11b1,~l11c1,~l11d1,~l11e1,~l11f1,~l12a1,~l12b1,~l12c1,~l12d1,~l12e1,~l12f*/ ].do(_.free)); ~slideroutine.stop;
						});
					}
					{~l1a.isRunning == true}{
						(1.do({var a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,fs,rs,vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8,vol9,vol10,vol11,vol12,s1,s2,s3,s4,s5,s6,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,f19,f20,f21,f22,f23,f24,fs1,fs2,fs3,fs4,fs5,fs6,fd1,fd2,fd3,fd4,fd5,fd6,tune=0;
							#vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8,vol9,vol10,vol11,vol12 = [~vol1,~vol2,~vol3,~vol4,~vol5,~vol6,~vol7,~vol8,~vol9,~vol10,~vol11,~vol12];
							#f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12 = [ 0,0,0,0,0,0,0,0,0,0,0,0 ];
							~l1a.set(\dur, f1, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,    \vol, vol1, \tune, tune);  ~l1b.set(\dur, f1, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol1, \tune, tune);
							~l1c.set(\dur, f1/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol1, \tune, tune);  ~l1d.set(\dur, f1/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol1, \tune, tune);
							~l1e.set(\dur, f1/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol1, \tune, tune);  ~l1f.set(\dur, f1/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol1, \tune, tune);
							~l2a.set(\dur, f2, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,    \vol, vol2, \tune, tune);          ~l2b.set(\dur, f2, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol2, \tune, tune);
							~l2c.set(\dur, f2/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol2, \tune, tune);  ~l2d.set(\dur, f2/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol2, \tune, tune);
							~l2e.set(\dur, f2/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol2, \tune, tune);  ~l2f.set(\dur, f2/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol2, \tune, tune);
							~l3a.set(\dur, f3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,    \vol, vol3, \tune, tune);          ~l3b.set(\dur, f3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol3, \tune, tune);
							~l3c.set(\dur, f3/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol3, \tune, tune);  ~l3d.set(\dur, f3/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol3, \tune, tune);
							~l3e.set(\dur, f3/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol3, \tune, tune);  ~l3f.set(\dur, f3/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol3, \tune, tune);
							~l4a.set(\dur, f4, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol4, \tune, tune);           ~l4b.set(\dur, f4, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol4, \tune, tune);
							~l4c.set(\dur, f4/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol4, \tune, tune);  ~l4d.set(\dur, f4/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol4, \tune, tune);
							~l4e.set(\dur, f4/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol4, \tune, tune);  ~l4f.set(\dur, f4/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol4, \tune, tune);
							~l5a.set(\dur, f5, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol5, \tune, tune);           ~l5b.set(\dur, f5, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol5, \tune, tune);
							~l5c.set(\dur, f5/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol5, \tune, tune);  ~l5d.set(\dur, f5/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol5, \tune, tune);
							~l5e.set(\dur, f5/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol5, \tune, tune);  ~l5f.set(\dur, f5/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol5, \tune, tune);
							~l6a.set(\dur, f6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol6, \tune, tune);           ~l6b.set(\dur, f6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol6, \tune, tune);
							~l6c.set(\dur, f6/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol6, \tune, tune);  ~l6d.set(\dur, f6/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol6, \tune, tune);
							~l6e.set(\dur, f6/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol6, \tune, tune);  ~l6f.set(\dur, f6/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol6, \tune, tune);
							~l7a.set(\dur, f7, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol7, \tune, tune);           ~l7b.set(\dur, f7, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol7, \tune, tune);
							~l7c.set(\dur, f7/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol7, \tune, tune);  ~l7d.set(\dur, f7/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol7, \tune, tune);
							~l7e.set(\dur, f7/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol7, \tune, tune);  ~l7f.set(\dur, f7/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol7, \tune, tune);
							~l8a.set(\dur, f8, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol8, \tune, tune);           ~l8b.set(\dur, f8, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol8, \tune, tune);
							~l8c.set(\dur, f8/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol8, \tune, tune);  ~l8d.set(\dur, f8/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol8, \tune, tune);
							~l8e.set(\dur, f8/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol8, \tune, tune);  ~l8f.set(\dur, f8/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol8, \tune, tune);
							/*~l9a.set(\dur, f9, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol9,  \tune, tune);          ~l9b.set(\dur, f9, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol9, \tune, tune);
							~l9c.set(\dur, f9/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol9,  \tune, tune); ~l9d.set(\dur, f9/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol9, \tune, tune);
							~l9e.set(\dur, f9/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol9,  \tune, tune); ~l9f.set(\dur, f9/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol9, \tune, tune);
							~l10a.set(\dur, f10, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol10,  \tune, tune);         ~l10b.set(\dur, f10, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol10, \tune, tune);
							~l10c.set(\dur, f10/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,    \vol, vol10,  \tune, tune);~l10d.set(\dur, f10/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol10, \tune, tune);
							~l10e.set(\dur, f10/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,    \vol, vol10,  \tune, tune);~l10f.set(\dur, f10/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol10, \tune, tune);
							~l11a.set(\dur, f11, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol11,  \tune, tune);         ~l11b.set(\dur, f11, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol11, \tune, tune);
							~l11c.set(\dur, f11/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,    \vol, vol11,  \tune, tune);~l11d.set(\dur, f11/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol11, \tune, tune);
							~l11e.set(\dur, f11/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,    \vol, vol11,  \tune, tune);~l11f.set(\dur, f11/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol11, \tune, tune);
							~l12a.set(\dur, f12, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol12,  \tune, tune);         ~l12b.set(\dur, f12, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol12, \tune, tune);
							~l12c.set(\dur, f12/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,    \vol, vol12,  \tune, tune);~l12d.set(\dur, f12/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol12, \tune, tune);
							~l12e.set(\dur, f12/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,    \vol, vol12,  \tune, tune);~l12f.set(\dur, f12/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol12, \tune, tune);
						*/	}););
						AppClock.sched(0.161803398875,{
							([~l1a,~l1b,~l1c,~l1d,~l1e,~l1f,~l2a,~l2b,~l2c,~l2d,~l2e,~l2f,~l3a,~l3b,~l3c,~l3d,~l3e,~l3f,~l4a,~l4b,~l4c,~l4d,~l4e,~l4f,~l5a,~l5b,~l5c,~l5d,~l5e,~l5f,~l6a,~l6b,~l6c,~l6d,~l6e,~l6f,~l7a,~l7b,~l7c,~l7d,~l7e,~l7f,~l8a,~l8b,~l8c,~l8d,~l8e,~l8f/*,~l9a,~l9b,~l9c,~l9d,~l9e,~l9f,~l10a,~l10b,~l10c,~l10d,~l10e,~l10f,~l11a,~l11b,~l11c,~l11d,~l11e,~l11f,~l12a,~l12b,~l12c,~l12d,~l12e,~l12f*/].do(_.free)); ~slideroutine.stop;
						});
					};
				);
			};
);