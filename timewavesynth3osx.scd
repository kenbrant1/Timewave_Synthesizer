(
//To run the synth, click anywhere within the parenthesis above and press "ctrl - enter" or "cmd - return".
//A guide to using the instrument is available by clicking on the "i" button in the bottom right corner of the GUI.
//Several lines down, where it says "//VARIABLES YOU MAY WISH TO CHANGE", are variables that you can change for various things,
//including key codes for keyboard functions.

//It is recommended to reboot the interpreter in the "Language" toolbar, or by hightlighting - (thisProcess.platform.recompile);
//and pressing "ctrl - enter" or "cmd - return", before each server boot. Rebooting the interpreter is not needed to
//evaluate the code below if the server is booted.

//You can program/make a song by using the "timewavesynth8script.scd" file

//This synth is compatible with the Korg NanoKontrol 2

s.options.memSize = 2097152/4;
MIDIIn.connectAll;

(
s.boot;
s.waitForBoot({
	var point, w, view, view2,
	vol = 0.02,mute1,mute2,mute3,mute4,mute5,mute6,mute7,mute8,muteall,unmuteall,
	g1,g2,g6,g8,g33,g48,g64,g72,g88,gm,ngm1,ngm2,ngm6,set1,set2,menu1,menu2,
	ts,sts,str,spaceb,b1,b2,b3,b4,button,button1,info,
	n1,n2,n3,n4,n5,n6,n7,n8,keycodeb,
	f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12;


	//VARIABLES YOU MAY WISH TO CHANGE


	//note A tuning frequency in hz

	~tuning_frequency = 432; //default 432 hz

	~freqmap = (i = ~tuning_frequency / (2 ** (69 / 12)); a = (-1); b = (-1); Array.fill(128, {i * (2 ** (((a=a+1) / 12).trunc)) * ( (2 ** (12.reciprocal)) ** ((b=b+1)  % 12));}));/*~freqmap = (i = 8.0271480262684/*-0.0000000000024*/; ~stepratio = 1.0594630943593; Array.fill(128, { i = i*~stepratio;}));*/


	//number of KW(King Wen) sequences in a timewave half-cycle (or amplitude x2)

	~synthdefnum = 12; //default 12


	//timewave starting base (lowest) frequency

	x = 432; y = 432; ~basefreqmap = Array.fill(32, {x=x/1.0835058821738}).reverse++[432]++Array.fill(25, {y=y*1.0835058821738}); //create basefreqmap array

	~base_frequency = ~basefreqmap.at(8); //default 8 (63.027950580203). replace "~basefreqmap.at(#)" for custom value.


	//starting synthdef setting

	if((~kws_setting == nil) or: (~ratio_setting == nil), {

		~kws_setting = 1; //default type of King Wen sequence interpretation

		~ratio_setting = "psine1"; //default ratio setting for synthdef
	});


	//low-pass filter settings

	if(~low_pass_filter_on == nil, {~low_pass_filter_on = 1}); //set starting low-pass filter on/off. 1 means on - switch to 0 for off.

	if(~low_pass_filter_set_value == nil, {~low_pass_filter_freq_limit = 1728; //frequency limit for low-pass filter in synthdefs. default is 1728.
	});


	//default sendreply toggle

	if(~sendreplysynthdef_on == nil, {~sendreplysynthdef_on = 0; //switch for mid-timewave sequence events. 0 is off, 1 is on. default is 0
	});
	if(~sendreplyfuncswitch == nil, {~sendreplyfuncswitch = 1; //1 is random western scale note change per timewave half-cycle, 2 is eastern scale. default is 1
	});


	//volume

	~vol = 0.005; //default 0.005
	12.do(x = 0; {("vol"++(x=x+1)).asSymbol.envirPut(~vol)});


	//Key codes for keyboard functions - either unicode or keycode. To find key codes, see below:

	~rightarrow_keycode = 65363; //next note change increase
	~leftarrow_keycode = 65361; //next note change decrease
	~uparrow_keycode = 65362; //change synth up
	~downarrow_keycode = 65364; //change synth down

	~rightarrow_keycode1 = 124; //next note change increase (old version - may not work)
	~leftarrow_keycode1 = 123; //next note change decrease (old version - may not work)
	~uparrow_keycode1 = 126; //change synth up (old version - may not work)
	~downarrow_keycode1 = 125; //change synth down (old version - may not work)

	~enter_unicode = 13; //
	~s_unicode = 115; //start synth
	~m_unicode = 109; //mute/unmute all synths
	~r_unicode = 114; //routine/loop function
	~u_unicode = 117; //
	~t_unicode = 116; //timer function
	~c_unicode = 99; //copy function
	~i_unicode = 105; //change synth up
	~k_unicode = 107; //change synth down
	~j_unicode = 106; //next note change decrease
	~l_unicode = 108; //next note change increase
	~spacebar_unicode = 32; //pause all synths
	~one_unicode = 49; //choose synth 1
	~two_unicode = 50; //choose synth 2
	~three_unicode = 51; //choose synth 3
	~four_unicode = 52; //choose synth 4
	~five_unicode = 53; //choose synth 5
	~six_unicode = 54; //choose synth 6
	~seven_unicode = 55; //choose synth 7
	~eight_unicode = 56; //choose synth 8
	~nine_unicode = 57; //choose synth 9
	~ten_unicode = 48; //choose synth 10
	~eleven_unicode = 45; //choose synth 11
	~twelve_unicode = 61; //choose synth 12
	~escape_unicode = 27; //escape function


	//To find key codes in post window... Hightlight the function and its parenthesis in red below,
	//and press "ctrl - enter" or "cmd - return" - then a small window called "test" will pop up...
	//Press the "type" button inside of the window, then press anywhere on the keyboard to find
	//the key codes in the right-hand side post window. Layout: [unicode, keycode, modifiers]. It is either a unicode
	//or a keycode. Do not delete the /* and */ characters, or else the
	//program will not run.

	/*

	(
	var win = Window(\test, Rect(10, 100, 100, 50)),
	btn = Button(win, Rect(5, 5, 90, 40)).states_([["type"]]);
	btn.keyDownAction =
	{ arg view, char, modifiers, unicode, keycode;
	["unicode:"+unicode, "keycode:"+keycode, "modifiers:"+modifiers].postln;
	};
	win.front;
	)

	*/


	//gui set frequency ranges - currently set at the lowest and highest notes on a 128 key range using 432 hz A tuning
	//you can change the tuning near top
	//to insert custom ranges, replace "~freqmap.at()" with a hz frequency

	~outmin1 = ~freqmap.at(0);       // 8.0271480262684 hz                       //base frequency of upper set
	~outmax1 = ~freqmap.at(127);     // 12315.783879572 hz                       //high frequency of upper set
	~outmin2 = ~freqmap.at(0)*8;     // (8.0271480262684)*8 hz                   //base frequency of lower set
	~outmax2 = ~freqmap.at(127)/8;   // (12315.783879572)/8 hz;                  //high frequency of lower set

	~outmina = ~outmin2;
	~outmaxa = ~outmax2;
	~outminb = ~outmin1;
	~outmaxb = ~outmax1;


	//increase or decrease magnitude of second and third harmonics for synthdefs and synth functions (not recommend changing if uncertain of effects)

	//synthdefs

	~first_harmonic = 1;  //1
	~second_harmonic = 2; //2
	~third_harmonic = 6;  //6

	//synth functions

	~icd3 = 3; //3
	~icd6 = 6; //6


	//ratio values

	~fth = 1.4142135623729; //default kws binary interval
	~bi = ~fth; //~bi = "binary interval" - intverval of key change to a hexagram line's opposite in King Wen sequence
	~stepratio = 1.0594630943593;
	~nval = 1.0355417528;
	~n9s = 1.86;
	~n9 = 1.080059789899;
	~n18 = 1.0392592260319;
	~n27 = 1.0260044847071;
	~n36 = 1.0194406437022;
	~n45 = 1.0155225125043;
	~n54 = 1.012918794725;
	~n63 = 1.0110630844869;
	~n72 = 1.0096735332285;
	~gm = 1.6180339887499; //phi (golden mean), scaled on 1 key change per King Wen sequence
	~gm2 = 1.2720196495141;
	~gm6 = 1.0835058821738;
	~ngm1 = 1.0549232131786; //phi (golden mean), scaled on 9 key changes per King Wen sequence
	~ngm2 = 1.0270945492887;
	~ngm6 = 1.0089511542031;
	~nngm1 = 1.0075472729363; //phi (golden mean), scaled on 64 key changes per King Wen sequence
	~nngm2 = 1.0037665430449;
	~nngm6 = 1.0012539413222;
	~h1 = 11.10101010101; //based on 19.47:360, scaled on 1 key change per King Wen sequence
	~h2 = 4.2999982083345;
	~h6 = 1.6261331058274;
	~nh1 = 1.3828361607663; //based on 19.47:360, scaled on 9 key changes per King Wen sequence
	~nh2 = 1.1759405430404;
	~nh6 = 1.0555086286213;
	~nnh1 = 1.0466365180627; //based on 19.47:360, scaled on 64 key changes per King Wen sequence
	~nnh2 = 1.0230525490231;
	~nnh6 = 1.0076258811195;


	//edit SAVED s1-s8 frequencies/chords. Replace any "[ ~f1,~f2,~f3 ]" with desired frequencies.
	//Example: [~f1=31.385685128991,~f2=86.222407114322,~f3=229.95963599755]
	//You can find frequencies in the "copy" section of GUI under "saved open/flow 1-8 frequencies:" or "saved slide 1-8 frequencies:".
	//Remove both the "/*" and "*/" around the code to make evaluable. Put them back to make it unevaluable.

	/*

	3.do(x = 0; {("fp"++(x=x+1)).asSymbol.envirPut([ ~f1,~f2,~f3 ].at(x-1))});
	3.do(x = 0; {("fp"++(x=x+1)++"b").asSymbol.envirPut([ ~f1,~f2,~f3 ].at(x-1))});
	3.do(x = 0; {("fp"++(x=x+1)++"c").asSymbol.envirPut([ ~f1,~f2,~f3 ].at(x-1))});
	3.do(x = 0; {("fp"++(x=x+1)++"d").asSymbol.envirPut([ ~f1,~f2,~f3 ].at(x-1))});
	3.do(x = 0; {("fp"++(x=x+1)++"e").asSymbol.envirPut([ ~f1,~f2,~f3 ].at(x-1))});
	3.do(x = 0; {("fp"++(x=x+1)++"f").asSymbol.envirPut([ ~f1,~f2,~f3 ].at(x-1))});
	3.do(x = 0; {("fp"++(x=x+1)++"g").asSymbol.envirPut([ ~f1,~f2,~f3 ].at(x-1))});
	3.do(x = 0; {("fp"++(x=x+1)++"h").asSymbol.envirPut([ ~f1,~f2,~f3 ].at(x-1))});

	*/


	//edit STARTING frequencies/chord (not saved s1-s8 frequencies/chords). Replace "[ ~f1,~f2,~f3 ]" with starting frequencies.
	//Example: [~f1=31.385685128991,~f2=86.222407114322,~f3=229.95963599755]
	//You can find frequencies in the "copy" section of GUI under "current chord/frequencies".
	//Remove both the "/*" and "*/" around the code to make evaluable. Put them back to make it unevaluable again.

	/*

	3.do(x = 0; {("f"++(x=x+1)).asSymbol.envirPut(

	[ ~f1,~f2,~f3 ]

	.at(x-1))});

	*/

	//^Imoprtant note: "edit STARTING frequencies/chord" must be placed after "edit SAVED frequencies/chords" in code in order for it to work correctly


	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


	//default starting notes

	if(([f1,f2,f3] == [nil,nil,nil]), {
		#f1,f2,f3 = [
			(~freqmap.at(127)/8).rand,
			(~freqmap.at(127)/8).rand,
			(~freqmap.at(127)/8).rand
		];
	});

	if(([ ~f1,~f2,~f3 ] == [nil,nil,nil]), {3.do(x = 0; {("f"++(x=x+1)).asSymbol.envirPut([f1,f2,f3].at(x-1))});});

	if([~fp1,~fp2,~fp3,~fp4,~fp5,~fp6,~fp7,~fp8,~fp9,~fp10,~fp11,~fp12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {12.do(x = 0; {("fp"++(x=x+1)).asSymbol.envirPut([ ~f1,~f2,~f3,~f4,~f5,~f6,~f7,~f8,~f9,~f10,~f11,~f12 ].at(x-1))});});
	if([~fp1b,~fp2b,~fp3b,~fp4b,~fp5b,~fp6b,~fp7b,~fp8b,~fp9b,~fp10b,~fp11b,~fp12b] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {12.do(x = 0; {("fp"++(x=x+1)++"b").asSymbol.envirPut([ ~f1,~f2,~f3,~f4,~f5,~f6,~f7,~f8,~f9,~f10,~f11,~f12 ].at(x-1))});});
	if([~fp1c,~fp2c,~fp3c,~fp4c,~fp5c,~fp6c,~fp7c,~fp8c,~fp9c,~fp10c,~fp11c,~fp12c] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {12.do(x = 0; {("fp"++(x=x+1)++"c").asSymbol.envirPut([ ~f1,~f2,~f3,~f4,~f5,~f6,~f7,~f8,~f9,~f10,~f11,~f12 ].at(x-1))});});
	if([~fp1d,~fp2d,~fp3d,~fp4d,~fp5d,~fp6d,~fp7d,~fp8d,~fp9d,~fp10d,~fp11d,~fp12d] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {12.do(x = 0; {("fp"++(x=x+1)++"d").asSymbol.envirPut([ ~f1,~f2,~f3,~f4,~f5,~f6,~f7,~f8,~f9,~f10,~f11,~f12 ].at(x-1))});});
	if([~fp1e,~fp2e,~fp3e,~fp4e,~fp5e,~fp6e,~fp7e,~fp8e,~fp9e,~fp10e,~fp11e,~fp12e] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {12.do(x = 0; {("fp"++(x=x+1)++"e").asSymbol.envirPut([ ~f1,~f2,~f3,~f4,~f5,~f6,~f7,~f8,~f9,~f10,~f11,~f12 ].at(x-1))});});
	if([~fp1f,~fp2f,~fp3f,~fp4f,~fp5f,~fp6f,~fp7f,~fp8f,~fp9f,~fp10f,~fp11f,~fp12f] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {12.do(x = 0; {("fp"++(x=x+1)++"f").asSymbol.envirPut([ ~f1,~f2,~f3,~f4,~f5,~f6,~f7,~f8,~f9,~f10,~f11,~f12 ].at(x-1))});});
	if([~fp1g,~fp2g,~fp3g,~fp4g,~fp5g,~fp6g,~fp7g,~fp8g,~fp9g,~fp10g,~fp11g,~fp12g] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {12.do(x = 0; {("fp"++(x=x+1)++"g").asSymbol.envirPut([ ~f1,~f2,~f3,~f4,~f5,~f6,~f7,~f8,~f9,~f10,~f11,~f12 ].at(x-1))});});
	if([~fp1h,~fp2h,~fp3h,~fp4h,~fp5h,~fp6h,~fp7h,~fp8h,~fp9h,~fp10h,~fp11h,~fp12h] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {12.do(x = 0; {("fp"++(x=x+1)++"h").asSymbol.envirPut([ ~f1,~f2,~f3,~f4,~f5,~f6,~f7,~f8,~f9,~f10,~f11,~f12 ].at(x-1))});});

	12.do(x = 0; {("u"++(x=x+1)).asSymbol.envirPut([~fp1,~fp2,~fp3,~fp4,~fp5,~fp6,~fp7,~fp8,~fp9,~fp10,~fp11,~fp12].at(x-1))});
	12.do(x = 0; {("u"++(x=x+1)++"b").asSymbol.envirPut([~fp1b,~fp2b,~fp3b,~fp4b,~fp5b,~fp6b,~fp7b,~fp8b,~fp9b,~fp10b,~fp11b,~fp12b].at(x-1))});
	12.do(x = 0; {("u"++(x=x+1)++"c").asSymbol.envirPut([~fp1c,~fp2c,~fp3c,~fp4c,~fp5c,~fp6c,~fp7c,~fp8c,~fp9c,~fp10c,~fp11c,~fp12c].at(x-1))});
	12.do(x = 0; {("u"++(x=x+1)++"d").asSymbol.envirPut([~fp1d,~fp2d,~fp3d,~fp4d,~fp5d,~fp6d,~fp7d,~fp8d,~fp9d,~fp10d,~fp11d,~fp12d].at(x-1))});
	12.do(x = 0; {("u"++(x=x+1)++"e").asSymbol.envirPut([~fp1e,~fp2e,~fp3e,~fp4e,~fp5e,~fp6e,~fp7e,~fp8e,~fp9e,~fp10e,~fp11e,~fp12e].at(x-1))});
	12.do(x = 0; {("u"++(x=x+1)++"f").asSymbol.envirPut([~fp1f,~fp2f,~fp3f,~fp4f,~fp5f,~fp6f,~fp7f,~fp8f,~fp9f,~fp10f,~fp11f,~fp12f].at(x-1))});
	12.do(x = 0; {("u"++(x=x+1)++"g").asSymbol.envirPut([~fp1g,~fp2g,~fp3g,~fp4g,~fp5g,~fp6g,~fp7g,~fp8g,~fp9g,~fp10g,~fp11g,~fp12g].at(x-1))});
	12.do(x = 0; {("u"++(x=x+1)++"h").asSymbol.envirPut([~fp1h,~fp2h,~fp3h,~fp4h,~fp5h,~fp6h,~fp7h,~fp8h,~fp9h,~fp10h,~fp11h,~fp12h].at(x-1))});

	if([~sg1a1,~sg1a2,~sg1a3,~sg1a4,~sg1a5,~sg1a6,~sg1a7,~sg1a8,~sg1a9,~sg1a10,~sg1a11,~sg1a12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg1a1=~f1,~sg1a2=~f2,~sg1a3=~f3,~sg1a4=~f4,~sg1a5=~f5,~sg1a6=~f6,~sg1a7=~f7,~sg1a8=~f8];});
	if([~sg1b1,~sg1b2,~sg1b3,~sg1b4,~sg1b5,~sg1b6,~sg1b7,~sg1b8,~sg1b9,~sg1b10,~sg1b11,~sg1b12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg1b1=~f1,~sg1b2=~f2,~sg1b3=~f3,~sg1b4=~f4,~sg1b5=~f5,~sg1b6=~f6,~sg1b7=~f7,~sg1b8=~f8];});
	if([~sg1c1,~sg1c2,~sg1c3,~sg1c4,~sg1c5,~sg1c6,~sg1c7,~sg1c8,~sg1c9,~sg1c10,~sg1c11,~sg1c12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg1c1=~f1,~sg1c2=~f2,~sg1c3=~f3,~sg1c4=~f4,~sg1c5=~f5,~sg1c6=~f6,~sg1c7=~f7,~sg1c8=~f8];});
	if([~sg1d1,~sg1d2,~sg1d3,~sg1d4,~sg1d5,~sg1d6,~sg1d7,~sg1d8,~sg1d9,~sg1d10,~sg1d11,~sg1d12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg1d1=~f1,~sg1d2=~f2,~sg1d3=~f3,~sg1d4=~f4,~sg1d5=~f5,~sg1d6=~f6,~sg1d7=~f7,~sg1d8=~f8];});
	if([~sg1e1,~sg1e2,~sg1e3,~sg1e4,~sg1e5,~sg1e6,~sg1e7,~sg1e8,~sg1e9,~sg1e10,~sg1e11,~sg1e12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg1e1=~f1,~sg1e2=~f2,~sg1e3=~f3,~sg1e4=~f4,~sg1e5=~f5,~sg1e6=~f6,~sg1e7=~f7,~sg1e8=~f8];});
	if([~sg1f1,~sg1f2,~sg1f3,~sg1f4,~sg1f5,~sg1f6,~sg1f7,~sg1f8,~sg1f9,~sg1f10,~sg1f11,~sg1f12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg1f1=~f1,~sg1f2=~f2,~sg1f3=~f3,~sg1f4=~f4,~sg1f5=~f5,~sg1f6=~f6,~sg1f7=~f7,~sg1f8=~f8];});
	if([~sg1g1,~sg1g2,~sg1g3,~sg1g4,~sg1g5,~sg1g6,~sg1g7,~sg1g8,~sg1g9,~sg1g10,~sg1g11,~sg1g12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg1g1=~f1,~sg1g2=~f2,~sg1g3=~f3,~sg1g4=~f4,~sg1g5=~f5,~sg1g6=~f6,~sg1g7=~f7,~sg1g8=~f8];});
	if([~sg1h1,~sg1h2,~sg1h3,~sg1h4,~sg1h5,~sg1h6,~sg1h7,~sg1h8,~sg1h9,~sg1h10,~sg1h11,~sg1h12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg1h1=~f1,~sg1h2=~f2,~sg1h3=~f3,~sg1h4=~f4,~sg1h5=~f5,~sg1h6=~f6,~sg1h7=~f7,~sg1h8=~f8];});
	if([~sg2a1,~sg2a2,~sg2a3,~sg2a4,~sg2a5,~sg2a6,~sg2a7,~sg2a8,~sg2a9,~sg2a10,~sg2a11,~sg2a12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg2a1=~f1,~sg2a2=~f2,~sg2a3=~f3,~sg2a4=~f4,~sg2a5=~f5,~sg2a6=~f6,~sg2a7=~f7,~sg2a8=~f8];});
	if([~sg2b1,~sg2b2,~sg2b3,~sg2b4,~sg2b5,~sg2b6,~sg2b7,~sg2b8,~sg2b9,~sg2b10,~sg2b11,~sg2b12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg2b1=~f1,~sg2b2=~f2,~sg2b3=~f3,~sg2b4=~f4,~sg2b5=~f5,~sg2b6=~f6,~sg2b7=~f7,~sg2b8=~f8];});
	if([~sg2c1,~sg2c2,~sg2c3,~sg2c4,~sg2c5,~sg2c6,~sg2c7,~sg2c8,~sg2c9,~sg2c10,~sg2c11,~sg2c12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg2c1=~f1,~sg2c2=~f2,~sg2c3=~f3,~sg2c4=~f4,~sg2c5=~f5,~sg2c6=~f6,~sg2c7=~f7,~sg2c8=~f8];});
	if([~sg2d1,~sg2d2,~sg2d3,~sg2d4,~sg2d5,~sg2d6,~sg2d7,~sg2d8,~sg2d9,~sg2d10,~sg2d11,~sg2d12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg2d1=~f1,~sg2d2=~f2,~sg2d3=~f3,~sg2d4=~f4,~sg2d5=~f5,~sg2d6=~f6,~sg2d7=~f7,~sg2d8=~f8];});
	if([~sg2e1,~sg2e2,~sg2e3,~sg2e4,~sg2e5,~sg2e6,~sg2e7,~sg2e8,~sg2e9,~sg2e10,~sg2e11,~sg2e12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg2e1=~f1,~sg2e2=~f2,~sg2e3=~f3,~sg2e4=~f4,~sg2e5=~f5,~sg2e6=~f6,~sg2e7=~f7,~sg2e8=~f8];});
	if([~sg2f1,~sg2f2,~sg2f3,~sg2f4,~sg2f5,~sg2f6,~sg2f7,~sg2f8,~sg2f9,~sg2f10,~sg2f11,~sg2f12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg2f1=~f1,~sg2f2=~f2,~sg2f3=~f3,~sg2f4=~f4,~sg2f5=~f5,~sg2f6=~f6,~sg2f7=~f7,~sg2f8=~f8];});
	if([~sg2g1,~sg2g2,~sg2g3,~sg2g4,~sg2g5,~sg2g6,~sg2g7,~sg2g8,~sg2g9,~sg2g10,~sg2g11,~sg2g12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg2g1=~f1,~sg2g2=~f2,~sg2g3=~f3,~sg2g4=~f4,~sg2g5=~f5,~sg2g6=~f6,~sg2g7=~f7,~sg2g8=~f8];});
	if([~sg2h1,~sg2h2,~sg2h3,~sg2h4,~sg2h5,~sg2h6,~sg2h7,~sg2h8,~sg2h9,~sg2h10,~sg2h11,~sg2h12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg2h1=~f1,~sg2h2=~f2,~sg2h3=~f3,~sg2h4=~f4,~sg2h5=~f5,~sg2h6=~f6,~sg2h7=~f7,~sg2h8=~f8];});
	if([~sg3a1,~sg3a2,~sg3a3,~sg3a4,~sg3a5,~sg3a6,~sg3a7,~sg3a8,~sg3a9,~sg3a10,~sg3a11,~sg3a12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg3a1=~f1,~sg3a2=~f2,~sg3a3=~f3,~sg3a4=~f4,~sg3a5=~f5,~sg3a6=~f6,~sg3a7=~f7,~sg3a8=~f8];});
	if([~sg3b1,~sg3b2,~sg3b3,~sg3b4,~sg3b5,~sg3b6,~sg3b7,~sg3b8,~sg3b9,~sg3b10,~sg3b11,~sg3b12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg3b1=~f1,~sg3b2=~f2,~sg3b3=~f3,~sg3b4=~f4,~sg3b5=~f5,~sg3b6=~f6,~sg3b7=~f7,~sg3b8=~f8];});
	if([~sg3c1,~sg3c2,~sg3c3,~sg3c4,~sg3c5,~sg3c6,~sg3c7,~sg3c8,~sg3c9,~sg3c10,~sg3c11,~sg3c12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg3c1=~f1,~sg3c2=~f2,~sg3c3=~f3,~sg3c4=~f4,~sg3c5=~f5,~sg3c6=~f6,~sg3c7=~f7,~sg3c8=~f8];});
	if([~sg3d1,~sg3d2,~sg3d3,~sg3d4,~sg3d5,~sg3d6,~sg3d7,~sg3d8,~sg3d9,~sg3d10,~sg3d11,~sg3d12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg3d1=~f1,~sg3d2=~f2,~sg3d3=~f3,~sg3d4=~f4,~sg3d5=~f5,~sg3d6=~f6,~sg3d7=~f7,~sg3d8=~f8];});
	if([~sg3e1,~sg3e2,~sg3e3,~sg3e4,~sg3e5,~sg3e6,~sg3e7,~sg3e8,~sg3e9,~sg3e10,~sg3e11,~sg3e12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg3e1=~f1,~sg3e2=~f2,~sg3e3=~f3,~sg3e4=~f4,~sg3e5=~f5,~sg3e6=~f6,~sg3e7=~f7,~sg3e8=~f8];});
	if([~sg3f1,~sg3f2,~sg3f3,~sg3f4,~sg3f5,~sg3f6,~sg3f7,~sg3f8,~sg3f9,~sg3f10,~sg3f11,~sg3f12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg3f1=~f1,~sg3f2=~f2,~sg3f3=~f3,~sg3f4=~f4,~sg3f5=~f5,~sg3f6=~f6,~sg3f7=~f7,~sg3f8=~f8];});
	if([~sg3g1,~sg3g2,~sg3g3,~sg3g4,~sg3g5,~sg3g6,~sg3g7,~sg3g8,~sg3g9,~sg3g10,~sg3g11,~sg3g12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg3g1=~f1,~sg3g2=~f2,~sg3g3=~f3,~sg3g4=~f4,~sg3g5=~f5,~sg3g6=~f6,~sg3g7=~f7,~sg3g8=~f8];});
	if([~sg3h1,~sg3h2,~sg3h3,~sg3h4,~sg3h5,~sg3h6,~sg3h7,~sg3h8,~sg3h9,~sg3h10,~sg3h11,~sg3h12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg3h1=~f1,~sg3h2=~f2,~sg3h3=~f3,~sg3h4=~f4,~sg3h5=~f5,~sg3h6=~f6,~sg3h7=~f7,~sg3h8=~f8];});
	if([~sg4a1,~sg4a2,~sg4a3,~sg4a4,~sg4a5,~sg4a6,~sg4a7,~sg4a8,~sg4a9,~sg4a10,~sg4a11,~sg4a12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg4a1=~f1,~sg4a2=~f2,~sg4a3=~f3,~sg4a4=~f4,~sg4a5=~f5,~sg4a6=~f6,~sg4a7=~f7,~sg4a8=~f8];});
	if([~sg4b1,~sg4b2,~sg4b3,~sg4b4,~sg4b5,~sg4b6,~sg4b7,~sg4b8,~sg4b9,~sg4b10,~sg4b11,~sg4b12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg4b1=~f1,~sg4b2=~f2,~sg4b3=~f3,~sg4b4=~f4,~sg4b5=~f5,~sg4b6=~f6,~sg4b7=~f7,~sg4b8=~f8];});
	if([~sg4c1,~sg4c2,~sg4c3,~sg4c4,~sg4c5,~sg4c6,~sg4c7,~sg4c8,~sg4c9,~sg4c10,~sg4c11,~sg4c12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg4c1=~f1,~sg4c2=~f2,~sg4c3=~f3,~sg4c4=~f4,~sg4c5=~f5,~sg4c6=~f6,~sg4c7=~f7,~sg4c8=~f8];});
	if([~sg4d1,~sg4d2,~sg4d3,~sg4d4,~sg4d5,~sg4d6,~sg4d7,~sg4d8,~sg4d9,~sg4d10,~sg4d11,~sg4d12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg4d1=~f1,~sg4d2=~f2,~sg4d3=~f3,~sg4d4=~f4,~sg4d5=~f5,~sg4d6=~f6,~sg4d7=~f7,~sg4d8=~f8];});
	if([~sg4e1,~sg4e2,~sg4e3,~sg4e4,~sg4e5,~sg4e6,~sg4e7,~sg4e8,~sg4e9,~sg4e10,~sg4e11,~sg4e12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg4e1=~f1,~sg4e2=~f2,~sg4e3=~f3,~sg4e4=~f4,~sg4e5=~f5,~sg4e6=~f6,~sg4e7=~f7,~sg4e8=~f8];});
	if([~sg4f1,~sg4f2,~sg4f3,~sg4f4,~sg4f5,~sg4f6,~sg4f7,~sg4f8,~sg4f9,~sg4f10,~sg4f11,~sg4f12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg4f1=~f1,~sg4f2=~f2,~sg4f3=~f3,~sg4f4=~f4,~sg4f5=~f5,~sg4f6=~f6,~sg4f7=~f7,~sg4f8=~f8];});
	if([~sg4g1,~sg4g2,~sg4g3,~sg4g4,~sg4g5,~sg4g6,~sg4g7,~sg4g8,~sg4g9,~sg4g10,~sg4g11,~sg4g12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg4g1=~f1,~sg4g2=~f2,~sg4g3=~f3,~sg4g4=~f4,~sg4g5=~f5,~sg4g6=~f6,~sg4g7=~f7,~sg4g8=~f8];});
	if([~sg4h1,~sg4h2,~sg4h3,~sg4h4,~sg4h5,~sg4h6,~sg4h7,~sg4h8,~sg4h9,~sg4h10,~sg4h11,~sg4h12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg4h1=~f1,~sg4h2=~f2,~sg4h3=~f3,~sg4h4=~f4,~sg4h5=~f5,~sg4h6=~f6,~sg4h7=~f7,~sg4h8=~f8];});
	if([~sg5a1,~sg5a2,~sg5a3,~sg5a4,~sg5a5,~sg5a6,~sg5a7,~sg5a8,~sg5a9,~sg5a10,~sg5a11,~sg5a12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg5a1=~f1,~sg5a2=~f2,~sg5a3=~f3,~sg5a4=~f4,~sg5a5=~f5,~sg5a6=~f6,~sg5a7=~f7,~sg5a8=~f8];});
	if([~sg5b1,~sg5b2,~sg5b3,~sg5b4,~sg5b5,~sg5b6,~sg5b7,~sg5b8,~sg5b9,~sg5b10,~sg5b11,~sg5b12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg5b1=~f1,~sg5b2=~f2,~sg5b3=~f3,~sg5b4=~f4,~sg5b5=~f5,~sg5b6=~f6,~sg5b7=~f7,~sg5b8=~f8];});
	if([~sg5c1,~sg5c2,~sg5c3,~sg5c4,~sg5c5,~sg5c6,~sg5c7,~sg5c8,~sg5c9,~sg5c10,~sg5c11,~sg5c12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg5c1=~f1,~sg5c2=~f2,~sg5c3=~f3,~sg5c4=~f4,~sg5c5=~f5,~sg5c6=~f6,~sg5c7=~f7,~sg5c8=~f8];});
	if([~sg5d1,~sg5d2,~sg5d3,~sg5d4,~sg5d5,~sg5d6,~sg5d7,~sg5d8,~sg5d9,~sg5d10,~sg5d11,~sg5d12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg5d1=~f1,~sg5d2=~f2,~sg5d3=~f3,~sg5d4=~f4,~sg5d5=~f5,~sg5d6=~f6,~sg5d7=~f7,~sg5d8=~f8];});
	if([~sg5e1,~sg5e2,~sg5e3,~sg5e4,~sg5e5,~sg5e6,~sg5e7,~sg5e8,~sg5e9,~sg5e10,~sg5e11,~sg5e12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg5e1=~f1,~sg5e2=~f2,~sg5e3=~f3,~sg5e4=~f4,~sg5e5=~f5,~sg5e6=~f6,~sg5e7=~f7,~sg5e8=~f8];});
	if([~sg5f1,~sg5f2,~sg5f3,~sg5f4,~sg5f5,~sg5f6,~sg5f7,~sg5f8,~sg5f9,~sg5f10,~sg5f11,~sg5f12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg5f1=~f1,~sg5f2=~f2,~sg5f3=~f3,~sg5f4=~f4,~sg5f5=~f5,~sg5f6=~f6,~sg5f7=~f7,~sg5f8=~f8];});
	if([~sg5g1,~sg5g2,~sg5g3,~sg5g4,~sg5g5,~sg5g6,~sg5g7,~sg5g8,~sg5g9,~sg5g10,~sg5g11,~sg5g12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg5g1=~f1,~sg5g2=~f2,~sg5g3=~f3,~sg5g4=~f4,~sg5g5=~f5,~sg5g6=~f6,~sg5g7=~f7,~sg5g8=~f8];});
	if([~sg5h1,~sg5h2,~sg5h3,~sg5h4,~sg5h5,~sg5h6,~sg5h7,~sg5h8,~sg5h9,~sg5h10,~sg5h11,~sg5h12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg5h1=~f1,~sg5h2=~f2,~sg5h3=~f3,~sg5h4=~f4,~sg5h5=~f5,~sg5h6=~f6,~sg5h7=~f7,~sg5h8=~f8];});
	if([~sg6a1,~sg6a2,~sg6a3,~sg6a4,~sg6a5,~sg6a6,~sg6a7,~sg6a8,~sg6a9,~sg6a10,~sg6a11,~sg6a12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg6a1=~f1,~sg6a2=~f2,~sg6a3=~f3,~sg6a4=~f4,~sg6a5=~f5,~sg6a6=~f6,~sg6a7=~f7,~sg6a8=~f8];});
	if([~sg6b1,~sg6b2,~sg6b3,~sg6b4,~sg6b5,~sg6b6,~sg6b7,~sg6b8,~sg6b9,~sg6b10,~sg6b11,~sg6b12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg6b1=~f1,~sg6b2=~f2,~sg6b3=~f3,~sg6b4=~f4,~sg6b5=~f5,~sg6b6=~f6,~sg6b7=~f7,~sg6b8=~f8];});
	if([~sg6c1,~sg6c2,~sg6c3,~sg6c4,~sg6c5,~sg6c6,~sg6c7,~sg6c8,~sg6c9,~sg6c10,~sg6c11,~sg6c12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg6c1=~f1,~sg6c2=~f2,~sg6c3=~f3,~sg6c4=~f4,~sg6c5=~f5,~sg6c6=~f6,~sg6c7=~f7,~sg6c8=~f8];});
	if([~sg6d1,~sg6d2,~sg6d3,~sg6d4,~sg6d5,~sg6d6,~sg6d7,~sg6d8,~sg6d9,~sg6d10,~sg6d11,~sg6d12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg6d1=~f1,~sg6d2=~f2,~sg6d3=~f3,~sg6d4=~f4,~sg6d5=~f5,~sg6d6=~f6,~sg6d7=~f7,~sg6d8=~f8];});
	if([~sg6e1,~sg6e2,~sg6e3,~sg6e4,~sg6e5,~sg6e6,~sg6e7,~sg6e8,~sg6e9,~sg6e10,~sg6e11,~sg6e12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg6e1=~f1,~sg6e2=~f2,~sg6e3=~f3,~sg6e4=~f4,~sg6e5=~f5,~sg6e6=~f6,~sg6e7=~f7,~sg6e8=~f8];});
	if([~sg6f1,~sg6f2,~sg6f3,~sg6f4,~sg6f5,~sg6f6,~sg6f7,~sg6f8,~sg6f9,~sg6f10,~sg6f11,~sg6f12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg6f1=~f1,~sg6f2=~f2,~sg6f3=~f3,~sg6f4=~f4,~sg6f5=~f5,~sg6f6=~f6,~sg6f7=~f7,~sg6f8=~f8];});
	if([~sg6g1,~sg6g2,~sg6g3,~sg6g4,~sg6g5,~sg6g6,~sg6g7,~sg6g8,~sg6g9,~sg6g10,~sg6g11,~sg6g12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg6g1=~f1,~sg6g2=~f2,~sg6g3=~f3,~sg6g4=~f4,~sg6g5=~f5,~sg6g6=~f6,~sg6g7=~f7,~sg6g8=~f8];});
	if([~sg6h1,~sg6h2,~sg6h3,~sg6h4,~sg6h5,~sg6h6,~sg6h7,~sg6h8,~sg6h9,~sg6h10,~sg6h11,~sg6h12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg6h1=~f1,~sg6h2=~f2,~sg6h3=~f3,~sg6h4=~f4,~sg6h5=~f5,~sg6h6=~f6,~sg6h7=~f7,~sg6h8=~f8];});
	if([~sg7a1,~sg7a2,~sg7a3,~sg7a4,~sg7a5,~sg7a6,~sg7a7,~sg7a8,~sg7a9,~sg7a10,~sg7a11,~sg7a12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg7a1=~f1,~sg7a2=~f2,~sg7a3=~f3,~sg7a4=~f4,~sg7a5=~f5,~sg7a6=~f6,~sg7a7=~f7,~sg7a8=~f8];});
	if([~sg7b1,~sg7b2,~sg7b3,~sg7b4,~sg7b5,~sg7b6,~sg7b7,~sg7b8,~sg7b9,~sg7b10,~sg7b11,~sg7b12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg7b1=~f1,~sg7b2=~f2,~sg7b3=~f3,~sg7b4=~f4,~sg7b5=~f5,~sg7b6=~f6,~sg7b7=~f7,~sg7b8=~f8];});
	if([~sg7c1,~sg7c2,~sg7c3,~sg7c4,~sg7c5,~sg7c6,~sg7c7,~sg7c8,~sg7c9,~sg7c10,~sg7c11,~sg7c12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg7c1=~f1,~sg7c2=~f2,~sg7c3=~f3,~sg7c4=~f4,~sg7c5=~f5,~sg7c6=~f6,~sg7c7=~f7,~sg7c8=~f8];});
	if([~sg7d1,~sg7d2,~sg7d3,~sg7d4,~sg7d5,~sg7d6,~sg7d7,~sg7d8,~sg7d9,~sg7d10,~sg7d11,~sg7d12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg7d1=~f1,~sg7d2=~f2,~sg7d3=~f3,~sg7d4=~f4,~sg7d5=~f5,~sg7d6=~f6,~sg7d7=~f7,~sg7d8=~f8];});
	if([~sg7e1,~sg7e2,~sg7e3,~sg7e4,~sg7e5,~sg7e6,~sg7e7,~sg7e8,~sg7e9,~sg7e10,~sg7e11,~sg7e12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg7e1=~f1,~sg7e2=~f2,~sg7e3=~f3,~sg7e4=~f4,~sg7e5=~f5,~sg7e6=~f6,~sg7e7=~f7,~sg7e8=~f8];});
	if([~sg7f1,~sg7f2,~sg7f3,~sg7f4,~sg7f5,~sg7f6,~sg7f7,~sg7f8,~sg7f9,~sg7f10,~sg7f11,~sg7f12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg7f1=~f1,~sg7f2=~f2,~sg7f3=~f3,~sg7f4=~f4,~sg7f5=~f5,~sg7f6=~f6,~sg7f7=~f7,~sg7f8=~f8];});
	if([~sg7g1,~sg7g2,~sg7g3,~sg7g4,~sg7g5,~sg7g6,~sg7g7,~sg7g8,~sg7g9,~sg7g10,~sg7g11,~sg7g12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg7g1=~f1,~sg7g2=~f2,~sg7g3=~f3,~sg7g4=~f4,~sg7g5=~f5,~sg7g6=~f6,~sg7g7=~f7,~sg7g8=~f8];});
	if([~sg7h1,~sg7h2,~sg7h3,~sg7h4,~sg7h5,~sg7h6,~sg7h7,~sg7h8,~sg7h9,~sg7h10,~sg7h11,~sg7h12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg7h1=~f1,~sg7h2=~f2,~sg7h3=~f3,~sg7h4=~f4,~sg7h5=~f5,~sg7h6=~f6,~sg7h7=~f7,~sg7h8=~f8];});
	if([~sg8a1,~sg8a2,~sg8a3,~sg8a4,~sg8a5,~sg8a6,~sg8a7,~sg8a8,~sg8a9,~sg8a10,~sg8a11,~sg8a12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg8a1=~f1,~sg8a2=~f2,~sg8a3=~f3,~sg8a4=~f4,~sg8a5=~f5,~sg8a6=~f6,~sg8a7=~f7,~sg8a8=~f8];});
	if([~sg8b1,~sg8b2,~sg8b3,~sg8b4,~sg8b5,~sg8b6,~sg8b7,~sg8b8,~sg8b9,~sg8b10,~sg8b11,~sg8b12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg8b1=~f1,~sg8b2=~f2,~sg8b3=~f3,~sg8b4=~f4,~sg8b5=~f5,~sg8b6=~f6,~sg8b7=~f7,~sg8b8=~f8];});
	if([~sg8c1,~sg8c2,~sg8c3,~sg8c4,~sg8c5,~sg8c6,~sg8c7,~sg8c8,~sg8c9,~sg8c10,~sg8c11,~sg8c12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg8c1=~f1,~sg8c2=~f2,~sg8c3=~f3,~sg8c4=~f4,~sg8c5=~f5,~sg8c6=~f6,~sg8c7=~f7,~sg8c8=~f8];});
	if([~sg8d1,~sg8d2,~sg8d3,~sg8d4,~sg8d5,~sg8d6,~sg8d7,~sg8d8,~sg8d9,~sg8d10,~sg8d11,~sg8d12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg8d1=~f1,~sg8d2=~f2,~sg8d3=~f3,~sg8d4=~f4,~sg8d5=~f5,~sg8d6=~f6,~sg8d7=~f7,~sg8d8=~f8];});
	if([~sg8e1,~sg8e2,~sg8e3,~sg8e4,~sg8e5,~sg8e6,~sg8e7,~sg8e8,~sg8e9,~sg8e10,~sg8e11,~sg8e12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg8e1=~f1,~sg8e2=~f2,~sg8e3=~f3,~sg8e4=~f4,~sg8e5=~f5,~sg8e6=~f6,~sg8e7=~f7,~sg8e8=~f8];});
	if([~sg8f1,~sg8f2,~sg8f3,~sg8f4,~sg8f5,~sg8f6,~sg8f7,~sg8f8,~sg8f9,~sg8f10,~sg8f11,~sg8f12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg8f1=~f1,~sg8f2=~f2,~sg8f3=~f3,~sg8f4=~f4,~sg8f5=~f5,~sg8f6=~f6,~sg8f7=~f7,~sg8f8=~f8];});
	if([~sg8g1,~sg8g2,~sg8g3,~sg8g4,~sg8g5,~sg8g6,~sg8g7,~sg8g8,~sg8g9,~sg8g10,~sg8g11,~sg8g12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg8g1=~f1,~sg8g2=~f2,~sg8g3=~f3,~sg8g4=~f4,~sg8g5=~f5,~sg8g6=~f6,~sg8g7=~f7,~sg8g8=~f8];});
	if([~sg8h1,~sg8h2,~sg8h3,~sg8h4,~sg8h5,~sg8h6,~sg8h7,~sg8h8,~sg8h9,~sg8h10,~sg8h11,~sg8h12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg8h1=~f1,~sg8h2=~f2,~sg8h3=~f3,~sg8h4=~f4,~sg8h5=~f5,~sg8h6=~f6,~sg8h7=~f7,~sg8h8=~f8];});


	//set n1-n9 ratio values

	case
	{~ratio_setting == "psine1";}{~n_value1 = ~gm;    ~n_value2 = ~gm2;   ~n_value6 = ~gm6;}
	{~ratio_setting == "psine2";}{~n_value1 = ~ngm1;  ~n_value2 = ~ngm2;  ~n_value6 = ~ngm6;}
	{~ratio_setting == "psine3";}{~n_value1 = ~nngm1; ~n_value2 = ~nngm2; ~n_value6 = ~nngm6;}
	{~ratio_setting == "hsine1";}{~n_value1 = ~h1;    ~n_value2 = ~h2;    ~n_value6 = ~h6;}
	{~ratio_setting == "hsine2";}{~n_value1 = ~nh1;   ~n_value2 = ~nh2;   ~n_value6 = ~nh6;}
	{~ratio_setting == "hsine3";}{~n_value1 = ~nnh1;  ~n_value2 = ~nnh2;  ~n_value6 = ~nnh6;};


	//King Wen sequence interpretation settings 1-3 for synthdefs

	~kws_setting_1_a = {[/*1*/	#a,b,c,d,e,f=[ ~a,~b,~c,~d,~e,~f  ],/*2*/	[ a = a/~bi, b = b/~bi, c = c/~bi, d = d/~bi, e = e/~bi, f = f/~bi ],/*3*/	[ a = a,         b = b*~bi,    c = c,         d = d,         e = e,         f = f*~bi  ],/*4*/	[ a = a*~bi,    b = b/~bi,    c = c,         d = d,         e = e*~bi,    f = f/~bi  ],/*5*/	[ a = a/~bi,    b = b*~bi,    c = c,         d = d*~bi,    e = e,         f = f*~bi ],/*6*/	[ a = a*~bi,    b = b,         c = c*~bi,    d = d/~bi,    e = e,         f = f/~bi  ],/*7*/	[ a = a/~bi,    b = b/~bi,    c = c/~bi,    d = d,         e = e,         f = f ],/*8*/	[ a = a,         b = b*~bi,    c = c,         d = d,         e = e/~bi,    f = f ],/*9*/	[ a = a*~bi,    b = b,         c = c,         d = d*~bi,    e = e*~bi,    f = f*~bi ],/*10*/	[ a = a,         b = b,         c = c*~bi,    d = d/~bi,    e = e,         f = f ],/*11*/	[ a = a/~bi,    b = b/~bi,    c = c/~bi,    d = d*~bi,    e = e,         f = f ],/*12*/	[ a = a*~bi, b = b*~bi, c = c*~bi, d = d/~bi, e = e/~bi, f = f/~bi ],/*13*/	[ a = a,         b = b,         c = c,         d = d*~bi,    e = e,         f = f*~bi ],/*14*/	[ a = a,         b = b/~bi,    c = c,         d = d,         e = e*~bi,    f = f],/*15*/	[ a = a/~bi,    b = b,         c = c/~bi,    d = d,         e = e/~bi,    f = f/~bi ],/*16*/	[ a = a,         b = b,         c = c*~bi,    d = d/~bi,    e = e,         f = f ],/*17*/	[ a = a,         b = b*~bi,    c = c,         d = d,         e = e,         f = f*~bi],/*18*/	[ a = a*~bi, b = b/~bi, c = c/~bi, d = d*~bi, e = e*~bi, f = f/~bi ],/*19*/	[ a = a/~bi,    b = b,         c = c,         d = d/~bi,    e = e,         f = f*~bi ],/*20*/	[ a = a*~bi,    b = b*~bi,    c = c,         d = d,         e = e/~bi,    f = f/~bi ],/*21*/	[ a = a,         b = b/~bi,    c = c*~bi,    d = d,         e = e,         f = f*~bi ],/*22*/	[ a = a,         b = b,         c = c/~bi,    d = d*~bi,    e = e,         f = f ],/*23*/	[ a = a,         b = b,         c = c,         d = d/~bi,    e = e,         f = f/~bi ],/*24*/	[ a = a/~bi,    b = b,         c = c,         d = d,         e = e,         f = f*~bi ],/*25*/	[ a = a*~bi,    b = b*~bi,    c = c*~bi,    d = d,         e = e,         f = f ],/*26*/	[ a = a,         b = b/~bi,    c = c/~bi,    d = d*~bi,    e = e*~bi,    f = f ],/*27*/	[ a = a,         b = b,         c = c,         d = d/~bi,    e = e/~bi,    f = f ],/*28*/	[ a = a/~bi, b = b*~bi, c = c*~bi, d = d*~bi, e = e*~bi, f = f/~bi ],/*29*/	[ a = a,         b = b,         c = c/~bi,    d = d/~bi,    e = e,         f = f ],/*30*/	[ a = a*~bi, b = b/~bi, c = c*~bi, d = d*~bi, e = e/~bi, f = f*~bi ],/*31*/	[ a = a/~bi,    b = b*~bi,    c = c,         d = d,         e = e,         f = f/~bi ],/*32*/	[ a = a,         b = b/~bi,    c = c,         d = d,         e = e*~bi,    f = f ],/*33*/	[ a = a*~bi,    b = b*~bi,    c = c,         d = d,         e = e/~bi,    f = f ],/*34*/	[ a = a/~bi,    b = b/~bi,    c = c,         d = d,         e = e*~bi,    f = f*~bi ],/*35*/	[ a = a*~bi,    b = b,         c = c,         d = d/~bi,    e = e/~bi,    f = f/~bi ],/*36*/	[ a = a/~bi,    b = b,         c = c/~bi,    d = d*~bi,    e = e,         f = f*~bi ],/*37*/	[ a = a*~bi,    b = b*~bi,    c = c,         d = d,         e = e,         f = f ],/*38*/	[ a = a,         b = b/~bi,    c = c*~bi,    d = d/~bi,    e = e*~bi,    f = f ],/*39*/	[ a = a/~bi, b = b*~bi, c = c/~bi, d = d*~bi, e = e/~bi, f = f/~bi ],/*40*/	[ a = a,         b = b/~bi,    c = c*~bi,    d = d/~bi,    e = e*~bi,    f = f ],/*41*/	[ a = a*~bi,    b = b,         c = c/~bi,    d = d,         e = e,         f = f*~bi ],/*42*/	[ a = a,         b = b*~bi,    c = c,         d = d,         e = e/~bi,    f = f ],/*43*/	[ a = a/~bi,    b = b,         c = c*~bi,    d = d*~bi,    e = e*~bi,    f = f ],/*44*/	[ a = a*~bi,    b = b,         c = c,         d = d,         e = e,         f = f/~bi ],/*45*/	[ a = a/~bi,    b = b,         c = c,         d = d/~bi,    e = e/~bi,    f = f ],/*46*/	[ a = a,         b = b/~bi,    c = c/~bi,    d = d*~bi,    e = e*~bi,    f = f ],/*47*/	[ a = a,         b = b*~bi,    c = c*~bi,    d = d/~bi,    e = e,         f = f ],/*48*/	[ a = a,         b = b,         c = c/~bi,    d = d*~bi,    e = e,         f = f ],/*49*/	[ a = a,         b = b,         c = c*~bi,    d = d,         e = e/~bi,    f = f*~bi ],/*50*/	[ a = a*~bi,    b = b/~bi,    c = c,         d = d,         e = e*~bi,    f = f/~bi ],/*51*/	[ a = a/~bi,    b = b,         c = c,         d = d/~bi,    e = e/~bi,    f = f*~bi ],/*52*/	[ a = a*~bi,    b = b,         c = c/~bi,    d = d*~bi,    e = e,         f = f/~bi ],/*53*/	[ a = a,         b = b*~bi,    c = c,         d = d,         e = e,         f = f ],/*54*/	[ a = a/~bi, b = b/~bi, c = c*~bi, d = d/~bi, e = e*~bi, f = f*~bi ],/*55*/	[ a = a,         b = b,         c = c,         d = d*~bi,    e = e/~bi,    f = f ],/*56*/	[ a = a*~bi,    b = b,         c = c,         d = d,         e = e,         f = f/~bi ],/*57*/	[ a = a,         b = b*~bi,    c = c/~bi,    d = d,         e = e*~bi,    f = f ],/*58*/	[ a = a/~bi,    b = b,         c = c*~bi,    d = d/~bi,    e = e,         f = f*~bi ],/*59*/	[ a = a*~bi,    b = b,         c = c/~bi,    d = d,         e = e,         f = f/~bi ],/*60*/	[ a = a/~bi,    b = b,         c = c,         d = d,         e = e,         f = f*~bi ],/*61*/	[ a = a*~bi,    b = b,         c = c,         d = d,         e = e,         f = f ],/*62*/	[ a = a/~bi, b = b/~bi, c = c*~bi, d = d*~bi, e = e/~bi, f = f/~bi ],/*63*/	[ a = a,         b = b*~bi,    c = c/~bi,    d = d,         e = e,         f = f*~bi ],/*64*/	[ a = a*~bi, b = b/~bi, c = c*~bi, d = d/~bi, e = e*~bi, f = f/~bi ]]};
	~kws_setting_1_b = {[/*1*/	[ a = a*~n1,         b = b*~n1*~bi,    c = c*~n1,         d = d*~n1*~bi,    e = e*~n1,         f = f*~n1*~bi ],/*2*/	[ a = a/~bi, b = b/~bi, c = c/~bi, d = d/~bi, e = e/~bi, f = f/~bi ],/*3*/	[ a = a,         b = b*~bi,    c = c,         d = d,         e = e,         f = f*~bi  ],/*4*/	[ a = a*~bi,    b = b/~bi,    c = c,         d = d,         e = e*~bi,    f = f/~bi  ],/*5*/	[ a = a/~bi,    b = b*~bi,    c = c,         d = d*~bi,    e = e,         f = f*~bi ],/*6*/	[ a = a*~bi,    b = b,         c = c*~bi,    d = d/~bi,    e = e,         f = f/~bi  ],/*7*/	[ a = a/~bi,    b = b/~bi,    c = c/~bi,    d = d,         e = e,         f = f ],/*8*/	[ a = a,         b = b*~bi,    c = c,         d = d,         e = e/~bi,    f = f ],/*9*/	[ a = a*~bi,    b = b,         c = c,         d = d*~bi,    e = e*~bi,    f = f*~bi ],/*10*/	[ a = a,         b = b,         c = c*~bi,    d = d/~bi,    e = e,         f = f ],/*11*/	[ a = a/~bi,    b = b/~bi,    c = c/~bi,    d = d*~bi,    e = e,         f = f ],/*12*/	[ a = a*~bi, b = b*~bi, c = c*~bi, d = d/~bi, e = e/~bi, f = f/~bi ],/*13*/	[ a = a,         b = b,         c = c,         d = d*~bi,    e = e,         f = f*~bi ],/*14*/	[ a = a,         b = b/~bi,    c = c,         d = d,         e = e*~bi,    f = f],/*15*/	[ a = a/~bi,    b = b,         c = c/~bi,    d = d,         e = e/~bi,    f = f/~bi ],/*16*/	[ a = a,         b = b,         c = c*~bi,    d = d/~bi,    e = e,         f = f ],/*17*/	[ a = a,         b = b*~bi,    c = c,         d = d,         e = e,         f = f*~bi],/*18*/	[ a = a*~bi, b = b/~bi, c = c/~bi, d = d*~bi, e = e*~bi, f = f/~bi ],/*19*/	[ a = a/~bi,    b = b,         c = c,         d = d/~bi,    e = e,         f = f*~bi ],/*20*/	[ a = a*~bi,    b = b*~bi,    c = c,         d = d,         e = e/~bi,    f = f/~bi ],/*21*/	[ a = a,         b = b/~bi,    c = c*~bi,    d = d,         e = e,         f = f*~bi ],/*22*/	[ a = a,         b = b,         c = c/~bi,    d = d*~bi,    e = e,         f = f ],/*23*/	[ a = a,         b = b,         c = c,         d = d/~bi,    e = e,         f = f/~bi ],/*24*/	[ a = a/~bi,    b = b,         c = c,         d = d,         e = e,         f = f*~bi ],/*25*/	[ a = a*~bi,    b = b*~bi,    c = c*~bi,    d = d,         e = e,         f = f ],/*26*/	[ a = a,         b = b/~bi,    c = c/~bi,    d = d*~bi,    e = e*~bi,    f = f ],/*27*/	[ a = a,         b = b,         c = c,         d = d/~bi,    e = e/~bi,    f = f ],/*28*/	[ a = a/~bi, b = b*~bi, c = c*~bi, d = d*~bi, e = e*~bi, f = f/~bi ],/*29*/	[ a = a,         b = b,         c = c/~bi,    d = d/~bi,    e = e,         f = f ],/*30*/	[ a = a*~bi, b = b/~bi, c = c*~bi, d = d*~bi, e = e/~bi, f = f*~bi ],/*31*/	[ a = a/~bi,    b = b*~bi,    c = c,         d = d,         e = e,         f = f/~bi ],/*32*/	[ a = a,         b = b/~bi,    c = c,         d = d,         e = e*~bi,    f = f ],/*33*/	[ a = a*~bi,    b = b*~bi,    c = c,         d = d,         e = e/~bi,    f = f ],/*34*/	[ a = a/~bi,    b = b/~bi,    c = c,         d = d,         e = e*~bi,    f = f*~bi ],/*35*/	[ a = a*~bi,    b = b,         c = c,         d = d/~bi,    e = e/~bi,    f = f/~bi ],/*36*/	[ a = a/~bi,    b = b,         c = c/~bi,    d = d*~bi,    e = e,         f = f*~bi ],/*37*/	[ a = a*~bi,    b = b*~bi,    c = c,         d = d,         e = e,         f = f ],/*38*/	[ a = a,         b = b/~bi,    c = c*~bi,    d = d/~bi,    e = e*~bi,    f = f ],/*39*/	[ a = a/~bi, b = b*~bi, c = c/~bi, d = d*~bi, e = e/~bi, f = f/~bi ],/*40*/	[ a = a,         b = b/~bi,    c = c*~bi,    d = d/~bi,    e = e*~bi,    f = f ],/*41*/	[ a = a*~bi,    b = b,         c = c/~bi,    d = d,         e = e,         f = f*~bi ],/*42*/	[ a = a,         b = b*~bi,    c = c,         d = d,         e = e/~bi,    f = f ],/*43*/	[ a = a/~bi,    b = b,         c = c*~bi,    d = d*~bi,    e = e*~bi,    f = f ],/*44*/	[ a = a*~bi,    b = b,         c = c,         d = d,         e = e,         f = f/~bi ],/*45*/	[ a = a/~bi,    b = b,         c = c,         d = d/~bi,    e = e/~bi,    f = f ],/*46*/	[ a = a,         b = b/~bi,    c = c/~bi,    d = d*~bi,    e = e*~bi,    f = f ],/*47*/	[ a = a,         b = b*~bi,    c = c*~bi,    d = d/~bi,    e = e,         f = f ],/*48*/	[ a = a,         b = b,         c = c/~bi,    d = d*~bi,    e = e,         f = f ],/*49*/	[ a = a,         b = b,         c = c*~bi,    d = d,         e = e/~bi,    f = f*~bi ],/*50*/	[ a = a*~bi,    b = b/~bi,    c = c,         d = d,         e = e*~bi,    f = f/~bi ],/*51*/	[ a = a/~bi,    b = b,         c = c,         d = d/~bi,    e = e/~bi,    f = f*~bi ],/*52*/	[ a = a*~bi,    b = b,         c = c/~bi,    d = d*~bi,    e = e,         f = f/~bi ],/*53*/	[ a = a,         b = b*~bi,    c = c,         d = d,         e = e,         f = f ],/*54*/	[ a = a/~bi, b = b/~bi, c = c*~bi, d = d/~bi, e = e*~bi, f = f*~bi ],/*55*/	[ a = a,         b = b,         c = c,         d = d*~bi,    e = e/~bi,    f = f ],/*56*/	[ a = a*~bi,    b = b,         c = c,         d = d,         e = e,         f = f/~bi ],/*57*/	[ a = a,         b = b*~bi,    c = c/~bi,    d = d,         e = e*~bi,    f = f ],/*58*/	[ a = a/~bi,    b = b,         c = c*~bi,    d = d/~bi,    e = e,         f = f*~bi ],/*59*/	[ a = a*~bi,    b = b,         c = c/~bi,    d = d,         e = e,         f = f/~bi ],/*60*/	[ a = a/~bi,    b = b,         c = c,         d = d,         e = e,         f = f*~bi ],/*61*/	[ a = a*~bi,    b = b,         c = c,         d = d,         e = e,         f = f ],/*62*/	[ a = a/~bi, b = b/~bi, c = c*~bi, d = d*~bi, e = e/~bi, f = f/~bi ],/*63*/	[ a = a,         b = b*~bi,    c = c/~bi,    d = d,         e = e,         f = f*~bi ],/*64*/	[ a = a*~bi, b = b/~bi, c = c*~bi, d = d/~bi, e = e*~bi, f = f/~bi ]]};

	~kws_setting_2_a = {[/*1*/	#a,b,c,d,e,f=[ ~a,~b,~c,~d,~e,~f  ],/*2*/	[ a = a*~n1/~bi, b = b*~n1/~bi, c = c*~n1/~bi, d = d*~n1/~bi, e = e*~n1/~bi, f = f*~n1/~bi ],/*3*/	[ a = a,         b = b*~bi,    c = c,         d = d,         e = e,         f = f*~bi    ],/*4*/	[ a = a*~bi,    b = b/~bi,    c = c,         d = d,         e = e*~bi,    f = f/~bi    ],/*5*/	[ a = a/~bi,    b = b*~bi,    c = c,         d = d*~bi,    e = e,         f = f*~bi    ],/*6*/	[ a = a*~bi,    b = b,         c = c*~bi,    d = d/~bi,    e = e,         f = f/~bi    ],/*7*/	[ a = a/~bi,    b = b/~bi,    c = c/~bi,    d = d,         e = e,         f = f         ],/*8*/	[ a = a,         b = b*~bi,    c = c,         d = d,         e = e/~bi,    f = f         ],/*9*/	[ a = a*~bi,    b = b,         c = c,         d = d*~bi,    e = e*~bi,    f = f*~bi    ],/*10*/	[ a = a,         b = b,         c = c*~bi,    d = d/~bi,    e = e,         f = f         ],/*11*/	[ a = a/~bi,    b = b/~bi,    c = c/~bi,    d = d*~bi,    e = e,         f = f         ],/*12*/	[ a = a*~n2*~bi, b = b*~n2*~bi, c = c*~n2*~bi, d = d*~n2/~bi, e = e*~n2/~bi, f = f*~n2/~bi ],/*13*/	[ a = a,         b = b,         c = c,         d = d*~bi,    e = e,         f = f*~bi    ],/*14*/	[ a = a,         b = b/~bi,    c = c,         d = d,         e = e*~bi,    f = f         ],/*15*/	[ a = a/~bi,    b = b,         c = c/~bi,    d = d,         e = e/~bi,    f = f/~bi    ],/*16*/	[ a = a,         b = b,         c = c*~bi,    d = d/~bi,    e = e,         f = f         ],/*17*/	[ a = a,         b = b*~bi,    c = c,         d = d,         e = e,         f = f*~bi    ],/*18*/	[ a = a*~n3*~bi, b = b*~n3/~bi, c = c*~n3/~bi, d = d*~n3*~bi, e = e*~n3*~bi, f = f*~n3/~bi ],/*19*/	[ a = a/~bi,    b = b,         c = c,         d = d/~bi,    e = e,         f = f*~bi    ],/*20*/	[ a = a*~bi,    b = b*~bi,    c = c,         d = d,         e = e/~bi,    f = f/~bi    ],/*21*/	[ a = a,         b = b/~bi,    c = c*~bi,    d = d,         e = e,         f = f*~bi    ],/*22*/	[ a = a,         b = b,         c = c/~bi,    d = d*~bi,    e = e,         f = f         ],/*23*/	[ a = a,         b = b,         c = c,         d = d/~bi,    e = e,         f = f/~bi    ],/*24*/	[ a = a/~bi,    b = b,         c = c,         d = d,         e = e,         f = f*~bi    ],/*25*/	[ a = a*~bi,    b = b*~bi,    c = c*~bi,    d = d,         e = e,         f = f         ],/*26*/	[ a = a,         b = b/~bi,    c = c/~bi,    d = d*~bi,    e = e*~bi,    f = f         ],/*27*/	[ a = a,         b = b,         c = c,         d = d/~bi,    e = e/~bi,    f = f         ],/*28*/	[ a = a*~n4/~bi, b = b*~n4*~bi, c = c*~n4*~bi, d = d*~n4*~bi, e = e*~n4*~bi, f = f*~n4/~bi ],/*29*/	[ a = a,         b = b,         c = c/~bi,    d = d/~bi,    e = e,         f = f         ],/*30*/	[ a = a*~n5*~bi, b = b*~n5/~bi, c = c*~n5*~bi, d = d*~n5*~bi, e = e*~n5/~bi, f = f*~n5*~bi ],/*31*/	[ a = a/~bi,    b = b*~bi,    c = c,         d = d,         e = e,         f = f/~bi    ],/*32*/	[ a = a,         b = b/~bi,    c = c,         d = d,         e = e*~bi,    f = f         ],/*33*/	[ a = a*~bi,    b = b*~bi,    c = c,         d = d,         e = e/~bi,    f = f         ],/*34*/	[ a = a/~bi,    b = b/~bi,    c = c,         d = d,         e = e*~bi,    f = f*~bi    ],/*35*/	[ a = a*~bi,    b = b,         c = c,         d = d/~bi,    e = e/~bi,    f = f/~bi    ],/*36*/	[ a = a/~bi,    b = b,         c = c/~bi,    d = d*~bi,    e = e,         f = f*~bi    ],/*37*/	[ a = a*~bi,    b = b*~bi,    c = c,         d = d,         e = e,         f = f         ],/*38*/	[ a = a,         b = b/~bi,    c = c*~bi,    d = d/~bi,    e = e*~bi,    f = f         ],/*39*/	[ a = a*~n6/~bi, b = b*~n6*~bi, c = c*~n6/~bi, d = d*~n6*~bi, e = e*~n6/~bi, f = f*~n6/~bi ],/*40*/	[ a = a,         b = b/~bi,    c = c*~bi,    d = d/~bi,    e = e*~bi,    f = f         ],/*41*/	[ a = a*~bi,    b = b,         c = c/~bi,    d = d,         e = e,         f = f*~bi    ],/*42*/	[ a = a,         b = b*~bi,    c = c,         d = d,         e = e/~bi,    f = f         ],/*43*/	[ a = a/~bi,    b = b,         c = c*~bi,    d = d*~bi,    e = e*~bi,    f = f         ],/*44*/	[ a = a*~bi,    b = b,         c = c,         d = d,         e = e,         f = f/~bi    ],/*45*/	[ a = a/~bi,    b = b,         c = c,         d = d/~bi,    e = e/~bi,    f = f         ],/*46*/	[ a = a,         b = b/~bi,    c = c/~bi,    d = d*~bi,    e = e*~bi,    f = f         ],/*47*/	[ a = a,         b = b*~bi,    c = c*~bi,    d = d/~bi,    e = e,         f = f         ],/*48*/	[ a = a,         b = b,         c = c/~bi,    d = d*~bi,    e = e,         f = f         ],/*49*/	[ a = a,         b = b,         c = c*~bi,    d = d,         e = e/~bi,    f = f*~bi    ],/*50*/	[ a = a*~bi,    b = b/~bi,    c = c,         d = d,         e = e*~bi,    f = f/~bi    ],/*51*/	[ a = a/~bi,    b = b,         c = c,         d = d/~bi,    e = e/~bi,    f = f*~bi    ],/*52*/	[ a = a*~bi,    b = b,         c = c/~bi,    d = d*~bi,    e = e,         f = f/~bi    ],/*53*/	[ a = a,         b = b*~bi,    c = c,         d = d,         e = e,         f = f         ],/*54*/	[ a = a*~n7/~bi, b = b*~n7/~bi, c = c*~n7*~bi, d = d*~n7/~bi, e = e*~n7*~bi, f = f*~n7*~bi ],/*55*/	[ a = a,         b = b,         c = c,         d = d*~bi,    e = e/~bi,    f = f         ],/*56*/	[ a = a*~bi,    b = b,         c = c,         d = d,         e = e,         f = f/~bi    ],/*57*/	[ a = a,         b = b*~bi,    c = c/~bi,    d = d,         e = e*~bi,    f = f         ],/*58*/	[ a = a/~bi,    b = b,         c = c*~bi,    d = d/~bi,    e = e,         f = f*~bi    ],/*59*/	[ a = a*~bi,    b = b,         c = c/~bi,    d = d,         e = e,         f = f/~bi    ],/*60*/	[ a = a/~bi,    b = b,         c = c,         d = d,         e = e,         f = f*~bi    ],/*61*/	[ a = a*~bi,    b = b,         c = c,         d = d,         e = e,         f = f         ],/*62*/	[ a = a*~n8/~bi, b = b*~n8/~bi, c = c*~n8*~bi, d = d*~n8*~bi, e = e*~n8/~bi, f = f*~n8/~bi ],/*63*/	[ a = a,         b = b*~bi,    c = c/~bi,    d = d,         e = e,         f = f*~bi    ],/*64*/	[ a = a*~n9*~bi, b = b*~n9/~bi, c = c*~n9*~bi, d = d*~n9/~bi, e = e*~n9*~bi, f = f*~n9/~bi ]]};
	~kws_setting_2_b = {[/*1*/	[ a = a,         b = b*~bi,    c = c,         d = d*~bi,    e = e,         f = f*~bi    ],/*2*/	[ a = a*~n1/~bi, b = b*~n1/~bi, c = c*~n1/~bi, d = d*~n1/~bi, e = e*~n1/~bi, f = f*~n1/~bi ],/*3*/	[ a = a,         b = b*~bi,    c = c,         d = d,         e = e,         f = f*~bi    ],/*4*/	[ a = a*~bi,    b = b/~bi,    c = c,         d = d,         e = e*~bi,    f = f/~bi    ],/*5*/	[ a = a/~bi,    b = b*~bi,    c = c,         d = d*~bi,    e = e,         f = f*~bi    ],/*6*/	[ a = a*~bi,    b = b,         c = c*~bi,    d = d/~bi,    e = e,         f = f/~bi    ],/*7*/	[ a = a/~bi,    b = b/~bi,    c = c/~bi,    d = d,         e = e,         f = f         ],/*8*/	[ a = a,         b = b*~bi,    c = c,         d = d,         e = e/~bi,    f = f         ],/*9*/	[ a = a*~bi,    b = b,         c = c,         d = d*~bi,    e = e*~bi,    f = f*~bi    ],/*10*/	[ a = a,         b = b,         c = c*~bi,    d = d/~bi,    e = e,         f = f         ],/*11*/	[ a = a/~bi,    b = b/~bi,    c = c/~bi,    d = d*~bi,    e = e,         f = f         ],/*12*/	[ a = a*~n2*~bi, b = b*~n2*~bi, c = c*~n2*~bi, d = d*~n2/~bi, e = e*~n2/~bi, f = f*~n2/~bi ],/*13*/	[ a = a,         b = b,         c = c,         d = d*~bi,    e = e,         f = f*~bi    ],/*14*/	[ a = a,         b = b/~bi,    c = c,         d = d,         e = e*~bi,    f = f         ],/*15*/	[ a = a/~bi,    b = b,         c = c/~bi,    d = d,         e = e/~bi,    f = f/~bi    ],/*16*/	[ a = a,         b = b,         c = c*~bi,    d = d/~bi,    e = e,         f = f         ],/*17*/	[ a = a,         b = b*~bi,    c = c,         d = d,         e = e,         f = f*~bi    ],/*18*/	[ a = a*~n3*~bi, b = b*~n3/~bi, c = c*~n3/~bi, d = d*~n3*~bi, e = e*~n3*~bi, f = f*~n3/~bi ],/*19*/	[ a = a/~bi,    b = b,         c = c,         d = d/~bi,    e = e,         f = f*~bi    ],/*20*/	[ a = a*~bi,    b = b*~bi,    c = c,         d = d,         e = e/~bi,    f = f/~bi    ],/*21*/	[ a = a,         b = b/~bi,    c = c*~bi,    d = d,         e = e,         f = f*~bi    ],/*22*/	[ a = a,         b = b,         c = c/~bi,    d = d*~bi,    e = e,         f = f         ],/*23*/	[ a = a,         b = b,         c = c,         d = d/~bi,    e = e,         f = f/~bi    ],/*24*/	[ a = a/~bi,    b = b,         c = c,         d = d,         e = e,         f = f*~bi    ],/*25*/	[ a = a*~bi,    b = b*~bi,    c = c*~bi,    d = d,         e = e,         f = f         ],/*26*/	[ a = a,         b = b/~bi,    c = c/~bi,    d = d*~bi,    e = e*~bi,    f = f         ],/*27*/	[ a = a,         b = b,         c = c,         d = d/~bi,    e = e/~bi,    f = f         ],/*28*/	[ a = a*~n4/~bi, b = b*~n4*~bi, c = c*~n4*~bi, d = d*~n4*~bi, e = e*~n4*~bi, f = f*~n4/~bi ],/*29*/	[ a = a,         b = b,         c = c/~bi,    d = d/~bi,    e = e,         f = f         ],/*30*/	[ a = a*~n5*~bi, b = b*~n5/~bi, c = c*~n5*~bi, d = d*~n5*~bi, e = e*~n5/~bi, f = f*~n5*~bi ],/*31*/	[ a = a/~bi,    b = b*~bi,    c = c,         d = d,         e = e,         f = f/~bi    ],/*32*/	[ a = a,         b = b/~bi,    c = c,         d = d,         e = e*~bi,    f = f         ],/*33*/	[ a = a*~bi,    b = b*~bi,    c = c,         d = d,         e = e/~bi,    f = f         ],/*34*/	[ a = a/~bi,    b = b/~bi,    c = c,         d = d,         e = e*~bi,    f = f*~bi    ],/*35*/	[ a = a*~bi,    b = b,         c = c,         d = d/~bi,    e = e/~bi,    f = f/~bi    ],/*36*/	[ a = a/~bi,    b = b,         c = c/~bi,    d = d*~bi,    e = e,         f = f*~bi    ],/*37*/	[ a = a*~bi,    b = b*~bi,    c = c,         d = d,         e = e,         f = f         ],/*38*/	[ a = a,         b = b/~bi,    c = c*~bi,    d = d/~bi,    e = e*~bi,    f = f         ],/*39*/	[ a = a*~n6/~bi, b = b*~n6*~bi, c = c*~n6/~bi, d = d*~n6*~bi, e = e*~n6/~bi, f = f*~n6/~bi ],/*40*/	[ a = a,         b = b/~bi,    c = c*~bi,    d = d/~bi,    e = e*~bi,    f = f         ],/*41*/	[ a = a*~bi,    b = b,         c = c/~bi,    d = d,         e = e,         f = f*~bi    ],/*42*/	[ a = a,         b = b*~bi,    c = c,         d = d,         e = e/~bi,    f = f         ],/*43*/	[ a = a/~bi,    b = b,         c = c*~bi,    d = d*~bi,    e = e*~bi,    f = f         ],/*44*/	[ a = a*~bi,    b = b,         c = c,         d = d,         e = e,         f = f/~bi    ],/*45*/	[ a = a/~bi,    b = b,         c = c,         d = d/~bi,    e = e/~bi,    f = f         ],/*46*/	[ a = a,         b = b/~bi,    c = c/~bi,    d = d*~bi,    e = e*~bi,    f = f         ],/*47*/	[ a = a,         b = b*~bi,    c = c*~bi,    d = d/~bi,    e = e,         f = f         ],/*48*/	[ a = a,         b = b,         c = c/~bi,    d = d*~bi,    e = e,         f = f         ],/*49*/	[ a = a,         b = b,         c = c*~bi,    d = d,         e = e/~bi,    f = f*~bi    ],/*50*/	[ a = a*~bi,    b = b/~bi,    c = c,         d = d,         e = e*~bi,    f = f/~bi    ],/*51*/	[ a = a/~bi,    b = b,         c = c,         d = d/~bi,    e = e/~bi,    f = f*~bi    ],/*52*/	[ a = a*~bi,    b = b,         c = c/~bi,    d = d*~bi,    e = e,         f = f/~bi    ],/*53*/	[ a = a,         b = b*~bi,    c = c,         d = d,         e = e,         f = f         ],/*54*/	[ a = a*~n7/~bi, b = b*~n7/~bi, c = c*~n7*~bi, d = d*~n7/~bi, e = e*~n7*~bi, f = f*~n7*~bi ],/*55*/	[ a = a,         b = b,         c = c,         d = d*~bi,    e = e/~bi,    f = f         ],/*56*/	[ a = a*~bi,    b = b,         c = c,         d = d,         e = e,         f = f/~bi    ],/*57*/	[ a = a,         b = b*~bi,    c = c/~bi,    d = d,         e = e*~bi,    f = f         ],/*58*/	[ a = a/~bi,    b = b,         c = c*~bi,    d = d/~bi,    e = e,         f = f*~bi    ],/*59*/	[ a = a*~bi,    b = b,         c = c/~bi,    d = d,         e = e,         f = f/~bi    ],/*60*/	[ a = a/~bi,    b = b,         c = c,         d = d,         e = e,         f = f*~bi    ],/*61*/	[ a = a*~bi,    b = b,         c = c,         d = d,         e = e,         f = f         ],/*62*/	[ a = a*~n8/~bi, b = b*~n8/~bi, c = c*~n8*~bi, d = d*~n8*~bi, e = e*~n8/~bi, f = f*~n8/~bi ],/*63*/	[ a = a,         b = b*~bi,    c = c/~bi,    d = d,         e = e,         f = f*~bi    ],/*64*/	[ a = a*~n9*~bi, b = b*~n9/~bi, c = c*~n9*~bi, d = d*~n9/~bi, e = e*~n9*~bi, f = f*~n9/~bi ]]};

	~kws_setting_3_a = {[/*1*/	#a,b,c,d,e,f=[ ~a,~b,~c,~d,~e,~f  ],/*2*/	[ a = a*~n1/~bi,    b = b*~n1/~bi,    c = c*~n1/~bi,    d = d*~n1/~bi,    e = e*~n1/~bi,    f = f*~n1/~bi    ],/*3*/	[ a = a*~n1,         b = b*~n1*~bi,    c = c*~n1,         d = d*~n1,         e = e*~n1,         f = f*~n1*~bi    ],/*4*/	[ a = a*~n1*~bi,    b = b*~n1/~bi,    c = c*~n1,         d = d*~n1,         e = e*~n1*~bi,    f = f*~n1/~bi    ],/*5*/	[ a = a*~n1/~bi,    b = b*~n1*~bi,    c = c*~n1,         d = d*~n1*~bi,    e = e*~n1,         f = f*~n1*~bi    ],/*6*/	[ a = a*~n1*~bi,    b = b*~n1,         c = c*~n1*~bi,    d = d*~n1/~bi,    e = e*~n1,         f = f*~n1/~bi    ],/*7*/	[ a = a*~n1/~bi,    b = b*~n1/~bi,    c = c*~n1/~bi,    d = d*~n1,         e = e*~n1,         f = f*~n1         ],/*8*/	[ a = a*~n1,         b = b*~n1*~bi,    c = c*~n1,         d = d*~n1,         e = e*~n1/~bi,    f = f*~n1         ],/*9*/	[ a = a*~n1*~bi,    b = b*~n1,         c = c*~n1,         d = d*~n1*~bi,    e = e*~n1*~bi,    f = f*~n1*~bi    ],/*10*/	[ a = a*~n1,         b = b*~n1,         c = c*~n1*~bi,    d = d*~n1/~bi,    e = e*~n1,         f = f*~n1         ],/*11*/	[ a = a*~n1/~bi,    b = b*~n1/~bi,    c = c*~n1/~bi,    d = d*~n1*~bi,    e = e*~n1,         f = f*~n1         ],/*12*/	[ a = a*~n1*~bi,    b = b*~n1*~bi,    c = c*~n1*~bi,    d = d*~n1/~bi,    e = e*~n1/~bi,    f = f*~n1/~bi    ],/*13*/	[ a = a*~n1,         b = b*~n1,         c = c*~n1,         d = d*~n1*~bi,    e = e*~n1,         f = f*~n1*~bi    ],/*14*/	[ a = a*~n1,         b = b*~n1/~bi,    c = c*~n1,         d = d*~n1,         e = e*~n1*~bi,    f = f*~n1         ],/*15*/	[ a = a*~n1/~bi,    b = b*~n1,         c = c*~n1/~bi,    d = d*~n1,         e = e*~n1/~bi,    f = f*~n1/~bi    ],/*16*/	[ a = a*~n1,         b = b*~n1,         c = c*~n1*~bi,    d = d*~n1/~bi,    e = e*~n1,         f = f*~n1         ],/*17*/	[ a = a*~n1,         b = b*~n1*~bi,    c = c*~n1,         d = d*~n1,         e = e*~n1,         f = f*~n1*~bi    ],/*18*/	[ a = a*~n1*~bi,    b = b*~n1/~bi,    c = c*~n1/~bi,    d = d*~n1*~bi,    e = e*~n1*~bi,    f = f*~n1/~bi    ],/*19*/	[ a = a*~n1/~bi,    b = b*~n1,         c = c*~n1,         d = d*~n1/~bi,    e = e*~n1,         f = f*~n1*~bi    ],/*20*/	[ a = a*~n1*~bi,    b = b*~n1*~bi,    c = c*~n1,         d = d*~n1,         e = e*~n1/~bi,    f = f*~n1/~bi    ],/*21*/	[ a = a*~n1,         b = b*~n1/~bi,    c = c*~n1*~bi,    d = d*~n1,         e = e*~n1,         f = f*~n1*~bi    ],/*22*/	[ a = a*~n1,         b = b*~n1,         c = c*~n1/~bi,    d = d*~n1*~bi,    e = e*~n1,         f = f*~n1         ],/*23*/	[ a = a*~n1,         b = b*~n1,         c = c*~n1,         d = d*~n1/~bi,    e = e*~n1,         f = f*~n1/~bi    ],/*24*/	[ a = a*~n1/~bi,    b = b*~n1,         c = c*~n1,         d = d*~n1,         e = e*~n1,         f = f*~n1*~bi    ],/*25*/	[ a = a*~n1*~bi,    b = b*~n1*~bi,    c = c*~n1*~bi,    d = d*~n1,         e = e*~n1,         f = f*~n1         ],/*26*/	[ a = a*~n1,         b = b*~n1/~bi,    c = c*~n1/~bi,    d = d*~n1*~bi,    e = e*~n1*~bi,    f = f*~n1         ],/*27*/	[ a = a*~n1,         b = b*~n1,         c = c*~n1,         d = d*~n1/~bi,    e = e*~n1/~bi,    f = f*~n1         ],/*28*/	[ a = a*~n1/~bi,    b = b*~n1*~bi,    c = c*~n1*~bi,    d = d*~n1*~bi,    e = e*~n1*~bi,    f = f*~n1/~bi    ],/*29*/	[ a = a*~n1,         b = b*~n1,         c = c*~n1/~bi,    d = d*~n1/~bi,    e = e*~n1,         f = f*~n1         ],/*30*/	[ a = a*~n1*~bi,    b = b*~n1/~bi,    c = c*~n1*~bi,    d = d*~n1*~bi,    e = e*~n1/~bi,    f = f*~n1*~bi    ],/*31*/	[ a = a*~n1/~bi,    b = b*~n1*~bi,    c = c*~n1,         d = d*~n1,         e = e*~n1,         f = f*~n1/~bi    ],/*32*/	[ a = a*~n1,         b = b*~n1/~bi,    c = c*~n1,         d = d*~n1,         e = e*~n1*~bi,    f = f*~n1         ],/*33*/	[ a = a*~n1*~bi,    b = b*~n1*~bi,    c = c*~n1,         d = d*~n1,         e = e*~n1/~bi,    f = f*~n1         ],/*34*/	[ a = a*~n1/~bi,    b = b*~n1/~bi,    c = c*~n1,         d = d*~n1,         e = e*~n1*~bi,    f = f*~n1*~bi    ],/*35*/	[ a = a*~n1*~bi,    b = b*~n1,         c = c*~n1,         d = d*~n1/~bi,    e = e*~n1/~bi,    f = f*~n1/~bi    ],/*36*/	[ a = a*~n1/~bi,    b = b*~n1,         c = c*~n1/~bi,    d = d*~n1*~bi,    e = e*~n1,         f = f*~n1*~bi    ],/*37*/	[ a = a*~n1*~bi,    b = b*~n1*~bi,    c = c*~n1,         d = d*~n1,         e = e*~n1,         f = f*~n1         ],/*38*/	[ a = a*~n1,         b = b*~n1/~bi,    c = c*~n1*~bi,    d = d*~n1/~bi,    e = e*~n1*~bi,    f = f*~n1         ],/*39*/	[ a = a*~n1/~bi,    b = b*~n1*~bi,    c = c*~n1/~bi,    d = d*~n1*~bi,    e = e*~n1/~bi,    f = f*~n1/~bi    ],/*40*/	[ a = a*~n1,         b = b*~n1/~bi,    c = c*~n1*~bi,    d = d*~n1/~bi,    e = e*~n1*~bi,    f = f*~n1         ],/*41*/	[ a = a*~n1*~bi,    b = b*~n1,         c = c*~n1/~bi,    d = d*~n1,         e = e*~n1,         f = f*~n1*~bi    ],/*42*/	[ a = a*~n1,         b = b*~n1*~bi,    c = c*~n1,         d = d*~n1,         e = e*~n1/~bi,    f = f*~n1         ],/*43*/	[ a = a*~n1/~bi,    b = b*~n1,         c = c*~n1*~bi,    d = d*~n1*~bi,    e = e*~n1*~bi,    f = f*~n1         ],/*44*/	[ a = a*~n1*~bi,    b = b*~n1,         c = c*~n1,         d = d*~n1,         e = e*~n1,         f = f*~n1/~bi    ],/*45*/	[ a = a*~n1/~bi,    b = b*~n1,         c = c*~n1,         d = d*~n1/~bi,    e = e*~n1/~bi,    f = f*~n1         ],/*46*/	[ a = a*~n1,         b = b*~n1/~bi,    c = c*~n1/~bi,    d = d*~n1*~bi,    e = e*~n1*~bi,    f = f*~n1         ],/*47*/	[ a = a*~n1,         b = b*~n1*~bi,    c = c*~n1*~bi,    d = d*~n1/~bi,    e = e*~n1,         f = f*~n1         ],/*48*/	[ a = a*~n1,         b = b*~n1,         c = c*~n1/~bi,    d = d*~n1*~bi,    e = e*~n1,         f = f*~n1         ],/*49*/	[ a = a*~n1,         b = b*~n1,         c = c*~n1*~bi,    d = d*~n1,         e = e*~n1/~bi,    f = f*~n1*~bi    ],/*50*/	[ a = a*~n1*~bi,    b = b*~n1/~bi,    c = c*~n1,         d = d*~n1,         e = e*~n1*~bi,    f = f*~n1/~bi    ],/*51*/	[ a = a*~n1/~bi,    b = b*~n1,         c = c*~n1,         d = d*~n1/~bi,    e = e*~n1/~bi,    f = f*~n1*~bi    ],/*52*/	[ a = a*~n1*~bi,    b = b*~n1,         c = c*~n1/~bi,    d = d*~n1*~bi,    e = e*~n1,         f = f*~n1/~bi    ],/*53*/	[ a = a*~n1,         b = b*~n1*~bi,    c = c*~n1,         d = d*~n1,         e = e*~n1,         f = f*~n1         ],/*54*/	[ a = a*~n1/~bi,    b = b*~n1/~bi,    c = c*~n1*~bi,    d = d*~n1/~bi,    e = e*~n1*~bi,    f = f*~n1*~bi    ],/*55*/	[ a = a*~n1,         b = b*~n1,         c = c*~n1,         d = d*~n1*~bi,    e = e*~n1/~bi,    f = f*~n1         ],/*56*/	[ a = a*~n1*~bi,    b = b*~n1,         c = c*~n1,         d = d*~n1,         e = e*~n1,         f = f*~n1/~bi    ],/*57*/	[ a = a*~n1,         b = b*~n1*~bi,    c = c*~n1/~bi,    d = d*~n1,         e = e*~n1*~bi,    f = f*~n1         ],/*58*/	[ a = a*~n1/~bi,    b = b*~n1,         c = c*~n1*~bi,    d = d*~n1/~bi,    e = e*~n1,         f = f*~n1*~bi    ],/*59*/	[ a = a*~n1*~bi,    b = b*~n1,         c = c*~n1/~bi,    d = d*~n1,         e = e*~n1,         f = f*~n1/~bi    ],/*60*/	[ a = a*~n1/~bi,    b = b*~n1,         c = c*~n1,         d = d*~n1,         e = e*~n1,         f = f*~n1*~bi    ],/*61*/	[ a = a*~n1*~bi,    b = b*~n1,         c = c*~n1,         d = d*~n1,         e = e*~n1,         f = f*~n1         ],/*62*/	[ a = a*~n1/~bi,    b = b*~n1/~bi,    c = c*~n1*~bi,    d = d*~n1*~bi,    e = e*~n1/~bi,    f = f*~n1/~bi    ],/*63*/	[ a = a*~n1,         b = b*~n1*~bi,    c = c*~n1/~bi,    d = d*~n1,         e = e*~n1,         f = f*~n1*~bi    ],/*64*/	[ a = a*~n1*~bi,    b = b*~n1/~bi,    c = c*~n1*~bi,    d = d*~n1/~bi,    e = e*~n1*~bi,    f = f*~n1/~bi    ]]};
	~kws_setting_3_b = {[/*1*/	[ a = a*~n1,         b = b*~n1*~bi,    c = c*~n1,         d = d*~n1*~bi,    e = e*~n1,         f = f*~n1*~bi    ],/*2*/	[ a = a*~n1/~bi,    b = b*~n1/~bi,    c = c*~n1/~bi,    d = d*~n1/~bi,    e = e*~n1/~bi,    f = f*~n1/~bi    ],/*3*/	[ a = a*~n1,         b = b*~n1*~bi,    c = c*~n1,         d = d*~n1,         e = e*~n1,         f = f*~n1*~bi    ],/*4*/	[ a = a*~n1*~bi,    b = b*~n1/~bi,    c = c*~n1,         d = d*~n1,         e = e*~n1*~bi,    f = f*~n1/~bi    ],/*5*/	[ a = a*~n1/~bi,    b = b*~n1*~bi,    c = c*~n1,         d = d*~n1*~bi,    e = e*~n1,         f = f*~n1*~bi    ],/*6*/	[ a = a*~n1*~bi,    b = b*~n1,         c = c*~n1*~bi,    d = d*~n1/~bi,    e = e*~n1,         f = f*~n1/~bi    ],/*7*/	[ a = a*~n1/~bi,    b = b*~n1/~bi,    c = c*~n1/~bi,    d = d*~n1,         e = e*~n1,         f = f*~n1         ],/*8*/	[ a = a*~n1,         b = b*~n1*~bi,    c = c*~n1,         d = d*~n1,         e = e*~n1/~bi,    f = f*~n1         ],/*9*/	[ a = a*~n1*~bi,    b = b*~n1,         c = c*~n1,         d = d*~n1*~bi,    e = e*~n1*~bi,    f = f*~n1*~bi    ],/*10*/	[ a = a*~n1,         b = b*~n1,         c = c*~n1*~bi,    d = d*~n1/~bi,    e = e*~n1,         f = f*~n1         ],/*11*/	[ a = a*~n1/~bi,    b = b*~n1/~bi,    c = c*~n1/~bi,    d = d*~n1*~bi,    e = e*~n1,         f = f*~n1         ],/*12*/	[ a = a*~n1*~bi,    b = b*~n1*~bi,    c = c*~n1*~bi,    d = d*~n1/~bi,    e = e*~n1/~bi,    f = f*~n1/~bi    ],/*13*/	[ a = a*~n1,         b = b*~n1,         c = c*~n1,         d = d*~n1*~bi,    e = e*~n1,         f = f*~n1*~bi    ],/*14*/	[ a = a*~n1,         b = b*~n1/~bi,    c = c*~n1,         d = d*~n1,         e = e*~n1*~bi,    f = f*~n1         ],/*15*/	[ a = a*~n1/~bi,    b = b*~n1,         c = c*~n1/~bi,    d = d*~n1,         e = e*~n1/~bi,    f = f*~n1/~bi    ],/*16*/	[ a = a*~n1,         b = b*~n1,         c = c*~n1*~bi,    d = d*~n1/~bi,    e = e*~n1,         f = f*~n1         ],/*17*/	[ a = a*~n1,         b = b*~n1*~bi,    c = c*~n1,         d = d*~n1,         e = e*~n1,         f = f*~n1*~bi    ],/*18*/	[ a = a*~n1*~bi,    b = b*~n1/~bi,    c = c*~n1/~bi,    d = d*~n1*~bi,    e = e*~n1*~bi,    f = f*~n1/~bi    ],/*19*/	[ a = a*~n1/~bi,    b = b*~n1,         c = c*~n1,         d = d*~n1/~bi,    e = e*~n1,         f = f*~n1*~bi    ],/*20*/	[ a = a*~n1*~bi,    b = b*~n1*~bi,    c = c*~n1,         d = d*~n1,         e = e*~n1/~bi,    f = f*~n1/~bi    ],/*21*/	[ a = a*~n1,         b = b*~n1/~bi,    c = c*~n1*~bi,    d = d*~n1,         e = e*~n1,         f = f*~n1*~bi    ],/*22*/	[ a = a*~n1,         b = b*~n1,         c = c*~n1/~bi,    d = d*~n1*~bi,    e = e*~n1,         f = f*~n1         ],/*23*/	[ a = a*~n1,         b = b*~n1,         c = c*~n1,         d = d*~n1/~bi,    e = e*~n1,         f = f*~n1/~bi    ],/*24*/	[ a = a*~n1/~bi,    b = b*~n1,         c = c*~n1,         d = d*~n1,         e = e*~n1,         f = f*~n1*~bi    ],/*25*/	[ a = a*~n1*~bi,    b = b*~n1*~bi,    c = c*~n1*~bi,    d = d*~n1,         e = e*~n1,         f = f*~n1         ],/*26*/	[ a = a*~n1,         b = b*~n1/~bi,    c = c*~n1/~bi,    d = d*~n1*~bi,    e = e*~n1*~bi,    f = f*~n1         ],/*27*/	[ a = a*~n1,         b = b*~n1,         c = c*~n1,         d = d*~n1/~bi,    e = e*~n1/~bi,    f = f*~n1         ],/*28*/	[ a = a*~n1/~bi,    b = b*~n1*~bi,    c = c*~n1*~bi,    d = d*~n1*~bi,    e = e*~n1*~bi,    f = f*~n1/~bi    ],/*29*/	[ a = a*~n1,         b = b*~n1,         c = c*~n1/~bi,    d = d*~n1/~bi,    e = e*~n1,         f = f*~n1         ],/*30*/	[ a = a*~n1*~bi,    b = b*~n1/~bi,    c = c*~n1*~bi,    d = d*~n1*~bi,    e = e*~n1/~bi,    f = f*~n1*~bi    ],/*31*/	[ a = a*~n1/~bi,    b = b*~n1*~bi,    c = c*~n1,         d = d*~n1,         e = e*~n1,         f = f*~n1/~bi    ],/*32*/	[ a = a*~n1,         b = b*~n1/~bi,    c = c*~n1,         d = d*~n1,         e = e*~n1*~bi,    f = f*~n1         ],/*33*/	[ a = a*~n1*~bi,    b = b*~n1*~bi,    c = c*~n1,         d = d*~n1,         e = e*~n1/~bi,    f = f*~n1         ],/*34*/	[ a = a*~n1/~bi,    b = b*~n1/~bi,    c = c*~n1,         d = d*~n1,         e = e*~n1*~bi,    f = f*~n1*~bi    ],/*35*/	[ a = a*~n1*~bi,    b = b*~n1,         c = c*~n1,         d = d*~n1/~bi,    e = e*~n1/~bi,    f = f*~n1/~bi    ],/*36*/	[ a = a*~n1/~bi,    b = b*~n1,         c = c*~n1/~bi,    d = d*~n1*~bi,    e = e*~n1,         f = f*~n1*~bi    ],/*37*/	[ a = a*~n1*~bi,    b = b*~n1*~bi,    c = c*~n1,         d = d*~n1,         e = e*~n1,         f = f*~n1         ],/*38*/	[ a = a*~n1,         b = b*~n1/~bi,    c = c*~n1*~bi,    d = d*~n1/~bi,    e = e*~n1*~bi,    f = f*~n1         ],/*39*/	[ a = a*~n1/~bi,    b = b*~n1*~bi,    c = c*~n1/~bi,    d = d*~n1*~bi,    e = e*~n1/~bi,    f = f*~n1/~bi    ],/*40*/	[ a = a*~n1,         b = b*~n1/~bi,    c = c*~n1*~bi,    d = d*~n1/~bi,    e = e*~n1*~bi,    f = f*~n1         ],/*41*/	[ a = a*~n1*~bi,    b = b*~n1,         c = c*~n1/~bi,    d = d*~n1,         e = e*~n1,         f = f*~n1*~bi    ],/*42*/	[ a = a*~n1,         b = b*~n1*~bi,    c = c*~n1,         d = d*~n1,         e = e*~n1/~bi,    f = f*~n1         ],/*43*/	[ a = a*~n1/~bi,    b = b*~n1,         c = c*~n1*~bi,    d = d*~n1*~bi,    e = e*~n1*~bi,    f = f*~n1         ],/*44*/	[ a = a*~n1*~bi,    b = b*~n1,         c = c*~n1,         d = d*~n1,         e = e*~n1,         f = f*~n1/~bi    ],/*45*/	[ a = a*~n1/~bi,    b = b*~n1,         c = c*~n1,         d = d*~n1/~bi,    e = e*~n1/~bi,    f = f*~n1         ],/*46*/	[ a = a*~n1,         b = b*~n1/~bi,    c = c*~n1/~bi,    d = d*~n1*~bi,    e = e*~n1*~bi,    f = f*~n1         ],/*47*/	[ a = a*~n1,         b = b*~n1*~bi,    c = c*~n1*~bi,    d = d*~n1/~bi,    e = e*~n1,         f = f*~n1         ],/*48*/	[ a = a*~n1,         b = b*~n1,         c = c*~n1/~bi,    d = d*~n1*~bi,    e = e*~n1,         f = f*~n1         ],/*49*/	[ a = a*~n1,         b = b*~n1,         c = c*~n1*~bi,    d = d*~n1,         e = e*~n1/~bi,    f = f*~n1*~bi    ],/*50*/	[ a = a*~n1*~bi,    b = b*~n1/~bi,    c = c*~n1,         d = d*~n1,         e = e*~n1*~bi,    f = f*~n1/~bi    ],/*51*/	[ a = a*~n1/~bi,    b = b*~n1,         c = c*~n1,         d = d*~n1/~bi,    e = e*~n1/~bi,    f = f*~n1*~bi    ],/*52*/	[ a = a*~n1*~bi,    b = b*~n1,         c = c*~n1/~bi,    d = d*~n1*~bi,    e = e*~n1,         f = f*~n1/~bi    ],/*53*/	[ a = a*~n1,         b = b*~n1*~bi,    c = c*~n1,         d = d*~n1,         e = e*~n1,         f = f*~n1         ],/*54*/	[ a = a*~n1/~bi,    b = b*~n1/~bi,    c = c*~n1*~bi,    d = d*~n1/~bi,    e = e*~n1*~bi,    f = f*~n1*~bi    ],/*55*/	[ a = a*~n1,         b = b*~n1,         c = c*~n1,         d = d*~n1*~bi,    e = e*~n1/~bi,    f = f*~n1         ],/*56*/	[ a = a*~n1*~bi,    b = b*~n1,         c = c*~n1,         d = d*~n1,         e = e*~n1,         f = f*~n1/~bi    ],/*57*/	[ a = a*~n1,         b = b*~n1*~bi,    c = c*~n1/~bi,    d = d*~n1,         e = e*~n1*~bi,    f = f*~n1         ],/*58*/	[ a = a*~n1/~bi,    b = b*~n1,         c = c*~n1*~bi,    d = d*~n1/~bi,    e = e*~n1,         f = f*~n1*~bi    ],/*59*/	[ a = a*~n1*~bi,    b = b*~n1,         c = c*~n1/~bi,    d = d*~n1,         e = e*~n1,         f = f*~n1/~bi    ],/*60*/	[ a = a*~n1/~bi,    b = b*~n1,         c = c*~n1,         d = d*~n1,         e = e*~n1,         f = f*~n1*~bi    ],/*61*/	[ a = a*~n1*~bi,    b = b*~n1,         c = c*~n1,         d = d*~n1,         e = e*~n1,         f = f*~n1         ],/*62*/	[ a = a*~n1/~bi,    b = b*~n1/~bi,    c = c*~n1*~bi,    d = d*~n1*~bi,    e = e*~n1/~bi,    f = f*~n1/~bi    ],/*63*/	[ a = a*~n1,         b = b*~n1*~bi,    c = c*~n1/~bi,    d = d*~n1,         e = e*~n1,         f = f*~n1*~bi    ],/*64*/	[ a = a*~n1*~bi,    b = b*~n1/~bi,    c = c*~n1*~bi,    d = d*~n1/~bi,    e = e*~n1*~bi,    f = f*~n1/~bi    ]]};


	//synthdefs

	~gsine = {

		SynthDef(\gsineicfld1, {arg graindur = 0.04, dur = 2000, atk = 0.007, rel = 0.01, gate = 1, amp = 1, i = 1, vol = ~vol, rate = 20, tune = 0,dseqval,
			a, b, c, d, e, f, pan=0, fc = 1;
			var s1, out, env1, s2, dseq;
			9.do(x = 0; {("n"++(x=x+1)).asSymbol.envirPut(~n_value1)}); //for custom values replace "~n_value1" with "[a, b, c, d, etc...].at(x-1)" with the variable amount the same as the #.do value - for all synthdefs
			dseq = Dseq(
				case
				{~kws_setting == 1}{~kws_setting_1_a.value;}
				{~kws_setting == 2}{~kws_setting_2_a.value;}
				{~kws_setting == 3}{~kws_setting_3_a.value;} ++ Array.fill((~gsinenum*~first_harmonic -1), {
					case
					{~kws_setting == 1}{~kws_setting_1_b.value;}
					{~kws_setting == 2}{~kws_setting_2_b.value;}
					{~kws_setting == 3}{~kws_setting_3_b.value;}}).flatten, inf);
			s1 = GrainSin.ar(1, Impulse.ar(dur), 1/(dur),Demand.ar(Impulse.ar(dur), 0, dseq));
			if(~low_pass_filter_on == 1, {s1 = BLowPass.ar(s1, ~low_pass_filter_freq_limit);}, {s1 = s1});
			OffsetOut.ar(0, s1.dup*vol);
		}, [\ir]).add;

		SynthDef(\gsineicrld1, {arg graindur = 0.04, dur = 2000, atk = 0.007, rel = 0.01, gate = 1, amp = 1, i = 1, vol = ~vol, rate = 20, tune = 0,dseqval,
			a, b, c, d, e, f, pan=0, fc = 1, id = -1;
			var s1, out, env1, s2, dseq;
			9.do(x = 0; {("n"++(x=x+1)).asSymbol.envirPut(~n_value1)});
			dseq = Dseq([
				case
				{~kws_setting == 1}{~kws_setting_1_a.value;}
				{~kws_setting == 2}{~kws_setting_2_a.value;}
				{~kws_setting == 3}{~kws_setting_3_a.value;} ++ Array.fill((~gsinenum*~first_harmonic -1), {
					case
					{~kws_setting == 1}{~kws_setting_1_b.value;}
					{~kws_setting == 2}{~kws_setting_2_b.value;}
					{~kws_setting == 3}{~kws_setting_3_b.value;}}).flatten].flatten.reverse, inf);
			s1 = GrainSin.ar(1, Impulse.ar(dur), 1/(dur), Demand.ar(Impulse.ar(dur), 0, dseq));
			if(~low_pass_filter_on == 1, {s1 = BLowPass.ar(s1, ~low_pass_filter_freq_limit);}, {s1 = s1});
			OffsetOut.ar(0, s1.dup*vol);
		}, [\ir]).add;

		SynthDef(\gsineicfld2, {arg graindur = 0.04, dur = 2000, atk = 0.007, rel = 0.01, gate = 1, amp = 1, i = 1, vol = ~vol, rate = 20, tune = 0,dseqval,
			a, b, c, d, e, f, pan=0, fc = 1;
			var s1, out, env1, s2, dseq;
			9.do(x = 0; {("n"++(x=x+1)).asSymbol.envirPut(~n_value2)});
			dseq = Dseq(
				case
				{~kws_setting == 1}{~kws_setting_1_a.value;}
				{~kws_setting == 2}{~kws_setting_2_a.value;}
				{~kws_setting == 3}{~kws_setting_3_a.value;} ++ Array.fill((~gsinenum*~second_harmonic -1), {
					case
					{~kws_setting == 1}{~kws_setting_1_b.value;}
					{~kws_setting == 2}{~kws_setting_2_b.value;}
					{~kws_setting == 3}{~kws_setting_3_b.value;}}).flatten, inf);
			s1 = GrainSin.ar(1, Impulse.ar(dur), 1/(dur),Demand.ar(Impulse.ar(dur), 0, dseq));
			if(~low_pass_filter_on == 1, {s1 = BLowPass.ar(s1, ~low_pass_filter_freq_limit);}, {s1 = s1});
			OffsetOut.ar(0, s1.dup*vol);
		}, [\ir]).add;

		SynthDef(\gsineicrld2, {arg graindur = 0.04, dur = 2000, atk = 0.007, rel = 0.01, gate = 1, amp = 1, i = 1, vol = ~vol, rate = 20, tune = 0,dseqval,
			a, b, c, d, e, f, pan=0, fc = 1, id = -1;
			var s1, out, env1, s2, dseq;
			9.do(x = 0; {("n"++(x=x+1)).asSymbol.envirPut(~n_value2)});
			dseq = Dseq([
				case
				{~kws_setting == 1}{~kws_setting_1_a.value;}
				{~kws_setting == 2}{~kws_setting_2_a.value;}
				{~kws_setting == 3}{~kws_setting_3_a.value;} ++ Array.fill((~gsinenum*~second_harmonic -1), {
					case
					{~kws_setting == 1}{~kws_setting_1_b.value;}
					{~kws_setting == 2}{~kws_setting_2_b.value;}
					{~kws_setting == 3}{~kws_setting_3_b.value;}}).flatten].flatten.reverse, inf);
			s1 = GrainSin.ar(1, Impulse.ar(dur), 1/(dur), Demand.ar(Impulse.ar(dur), 0, dseq));
			if(~low_pass_filter_on == 1, {s1 = BLowPass.ar(s1, ~low_pass_filter_freq_limit);}, {s1 = s1});
			OffsetOut.ar(0, s1.dup*vol);
		}, [\ir]).add;

		SynthDef(\gsineicfld6, {arg graindur = 0.04, dur = 2000, atk = 0.007, rel = 0.01, gate = 1, amp = 1, i = 1, vol = ~vol, rate = 20, tune = 0,dseqval,
			a, b, c, d, e, f, pan=0, fc = 1;
			var s1, out, env1, s2, dseq;
			9.do(x = 0; {("n"++(x=x+1)).asSymbol.envirPut(~n_value6)});
			dseq = Dseq(
				case
				{~kws_setting == 1}{~kws_setting_1_a.value;}
				{~kws_setting == 2}{~kws_setting_2_a.value;}
				{~kws_setting == 3}{~kws_setting_3_a.value;} ++ Array.fill((~gsinenum*~third_harmonic -1), {
					case
					{~kws_setting == 1}{~kws_setting_1_b.value;}
					{~kws_setting == 2}{~kws_setting_2_b.value;}
					{~kws_setting == 3}{~kws_setting_3_b.value;}}).flatten, inf);
			s1 = GrainSin.ar(1, Impulse.ar(dur), 1/(dur),Demand.ar(Impulse.ar(dur), 0, dseq));
			if(~low_pass_filter_on == 1, {s1 = BLowPass.ar(s1, ~low_pass_filter_freq_limit);}, {s1 = s1});
			OffsetOut.ar(0, s1.dup*vol);
		}, [\ir]).add;

		SynthDef(\gsineicrld6, {arg graindur = 0.04, dur = 2000, atk = 0.007, rel = 0.01, gate = 1, amp = 1, i = 1, vol = ~vol, rate = 20, tune = 0,dseqval,
			a, b, c, d, e, f, pan=0, fc = 1;
			var s1, out, env1, s2, dseq;
			9.do(x = 0; {("n"++(x=x+1)).asSymbol.envirPut(~n_value6)});
			dseq = Dseq([
				case
				{~kws_setting == 1}{~kws_setting_1_a.value;}
				{~kws_setting == 2}{~kws_setting_2_a.value;}
				{~kws_setting == 3}{~kws_setting_3_a.value;} ++ Array.fill((~gsinenum*~third_harmonic -1), {
					case
					{~kws_setting == 1}{~kws_setting_1_b.value;}
					{~kws_setting == 2}{~kws_setting_2_b.value;}
					{~kws_setting == 3}{~kws_setting_3_b.value;}}).flatten].flatten.reverse, inf);
			s1 = GrainSin.ar(1, Impulse.ar(dur), 1/(dur), Demand.ar(Impulse.ar(dur), 0, dseq));
			if(~low_pass_filter_on == 1, {s1 = BLowPass.ar(s1, ~low_pass_filter_freq_limit);}, {s1 = s1});
			OffsetOut.ar(0, s1.dup*vol);
		}, [\ir]).add;

		if(~sendreplysynthdef_on == 1, {

			~synthflow_random_sendreply_answer_f1 = '/synthflow_random_sendreply_answer_f1';
			~synthflow_random_sendreply_answer_f2 = '/synthflow_random_sendreply_answer_f2';
			~synthflow_random_sendreply_answer_f3 = '/synthflow_random_sendreply_answer_f3';

			3.do(~sendreply_x = 0; {

				~sendreply_x=~sendreply_x+1;

				SynthDef(\gsineicfld6_f++(~sendreply_x), {arg graindur = 0.04, dur = 2000, atk = 0.007, rel = 0.01, gate = 1, amp = 1, i = 1, vol = ~vol, rate = 20, tune = 0,dseqval,
					a, b, c, d, e, f, pan=0, fc = 1;
					var s1, out, env1, s2, dseq;
					9.do(x = 0; {("n"++(x=x+1)).asSymbol.envirPut(~n_value6)});
					dseq = Dseq(
						case
						{~kws_setting == 1}{~kws_setting_1_a.value;}
						{~kws_setting == 2}{~kws_setting_2_a.value;}
						{~kws_setting == 3}{~kws_setting_3_a.value;} ++ Array.fill((~gsinenum*~third_harmonic -1), {
							case
							{~kws_setting == 1}{~kws_setting_1_b.value;}
							{~kws_setting == 2}{~kws_setting_2_b.value;}
							{~kws_setting == 3}{~kws_setting_3_b.value;}}).flatten, inf);
					s1 = GrainSin.ar(1, Impulse.ar(dur), 1/(dur),Demand.ar(Impulse.ar(dur), 0, dseq));
					if(~low_pass_filter_on == 1, {s1 = BLowPass.ar(s1, ~low_pass_filter_freq_limit);}, {s1 = s1});
					OffsetOut.ar(0, s1.dup*vol);
					SendReply.ar(PulseDivider.ar(Impulse.ar(dur), (~kws_setting_1_a.value.size*(~gsinenum*~third_harmonic))), ("synthflow_random_sendreply_answer_f"++(~sendreply_x)).asSymbol.envirGet, [ dseq]);
				}, [\ir]).add;

			});
		});
	};


	//sendyreply functions

	~send_reply_func_western = {~freqmap.at(rrand(60, 91));};
	~send_reply_func_eastern = {(rrand(~freqmap.at(60), ~freqmap.at(91);))};

	case
	{~sendreplyfuncswitch == 1;}{~send_reply_func = ~send_reply_func_western;}
	{~sendreplyfuncswitch == 2;}{~send_reply_func = ~send_reply_func_eastern;};

	OSCFunc({~f1 = ~send_reply_func.value; AppClock.sched(0,{~synthflow.value;});}, '/synthflow_random_sendreply_answer_f1');
	OSCFunc({~f2 = ~send_reply_func.value; AppClock.sched(0,{~synthflow.value;});}, '/synthflow_random_sendreply_answer_f2');
	OSCFunc({~f3 = ~send_reply_func.value; AppClock.sched(0,{~synthflow.value;});}, '/synthflow_random_sendreply_answer_f3');


	//set base (lowest) frequencies, set starting values for synthdef, and load synthdef on server boot

	if((~gsinenum == nil) or: (~synthdef != "gsineicld"), {
		(
			if(~basefreq == nil, {~basefreq = ~base_frequency});
			~fmult = 16;
			(#a,b,c,d,e,f = [ ~basefreq,~basefreq,~basefreq,~basefreq,~basefreq,~basefreq  ];
				~a = a; ~b = b; ~c =c; ~d = d; ~e = e;~f=f;);

			~synthdef = "gsineicld"; ~gsinenum = ~synthdefnum;

			~gsine.value;
		);
	});


	//generate GUI window

	w = Window("Timewave Synth", Rect(0,0,Window.screenBounds.width,Window.screenBounds.height), border:true);

	view = UserView(w, Window.screenBounds);
	view.clearOnRefresh = false;
	view.background = Color.black;

	//vertical grid (inactive)

	/*~b1 = Window.screenBounds.width/(12*4) /*25.462962962963*/; ~btu = 31; ~btd = 375; ~bw = 0.5; ~bh = 80; ~bcolor = Color.grey;
	View(w, Rect(~b1, ~btu, ~bw, ~bh)).background = ~bcolor;
	View(w, Rect(~b1, ~btd, ~bw, ~bh)).background = ~bcolor;
	54.do({View(w, Rect(~b1 = ~b1+(Window.screenBounds.width/(12*4)), ~btu, ~bw, ~bh)).background = ~bcolor;});
	~b1 = Window.screenBounds.width/(12*4);
	54.do({View(w, Rect(~b1 = ~b1+(Window.screenBounds.width/(12*4)), ~btd, ~bw, ~bh)).background = ~bcolor;});*/


	//horizontal grid

	~nh = 2;
	~nw = ~nh*1.6180339887499;

	~tgrid = 30;
	~bgrid = Window.screenBounds.height-(Window.screenBounds.height/1.6180339887499)+30;

	~dc1 = ~tgrid-5; ~dc2 = ~bgrid-5; ~dca = 10;

	4.do(x=~tgrid-10; {View(w, Rect(1, x=x+10, Window.screenBounds.width, 0.5)).background = Color.new255(51, 51, 51)});
	4.do(x=~bgrid-10; {View(w, Rect(1, x=x+10, Window.screenBounds.width, 0.5)).background = Color.new255(51, 51, 51)});

	~z1 = (View(w, Rect((if(~f1 == nil, {f1.value},{~f1.value}).explin(~outmin1,~outmax1,0,Window.screenBounds.width)), ~dc1=~dc1+10, ~nw, 2)).background = Color.white;);
	~z2 = (View(w, Rect((if(~f2 == nil, {f2.value},{~f2.value}).explin(~outmin1,~outmax1,0,Window.screenBounds.width)), ~dc1=~dc1+10, ~nw, 2)).background = Color.white;);
	~z3 = (View(w, Rect((if(~f3 == nil, {f3.value},{~f3.value}).explin(~outmin1,~outmax1,0,Window.screenBounds.width)), ~dc1=~dc1+10, ~nw, 2)).background = Color.white;);
	~zmid = (View(w, Rect(x, 280, ~nw, 2)).background = Color.clear;);
	~z25 = (View(w, Rect((if(~f1 == nil, {f1.value},{~f1.value}).explin(~outmin2,~outmax2,0,Window.screenBounds.width)), ~dc2=~dc2+10, ~nw, 2)).background = Color.white;);
	~z26 = (View(w, Rect((if(~f2 == nil, {f2.value},{~f2.value}).explin(~outmin2,~outmax2,0,Window.screenBounds.width)), ~dc2=~dc2+10, ~nw, 2)).background = Color.white;);
	~z27 = (View(w, Rect((if(~f3 == nil, {f3.value},{~f3.value}).explin(~outmin2,~outmax2,0,Window.screenBounds.width)), ~dc2=~dc2+10, ~nw, 2)).background = Color.white;);

	~dc1 = ~tgrid-5; ~dc2 = ~bgrid-5; ~dca = 10;


	//synth functions (open, flow, slide, pause, free)

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

		if((~f1 > ~outmaxa) or: (~f1 < ~outmina), {~z25.close;~z1.close;~z25 = (View(w, Rect((~f1.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+10, ~nw, 2)).background = Color.white;);}, {~z1.close;~z25.close;~z1 = (View(w, Rect((~f1.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+10, ~nw, 2)).background = Color.white;);});
		if((~f2 > ~outmaxa) or: (~f2 < ~outmina), {~z26.close;~z2.close;~z26 = (View(w, Rect((~f2.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+20, ~nw, 2)).background = Color.white;);}, {~z2.close;~z26.close;~z2 = (View(w, Rect((~f2.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+20, ~nw, 2)).background = Color.white;);});
		if((~f3 > ~outmaxa) or: (~f3 < ~outmina), {~z27.close;~z3.close;~z27 = (View(w, Rect((~f3.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+30, ~nw, 2)).background = Color.white;);}, {~z3.close;~z27.close;~z3 = (View(w, Rect((~f3.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+30, ~nw, 2)).background = Color.white;);});

		b3.value = 1;
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

		if((~f1 > ~outmaxa) or: (~f1 < ~outmina), {~z25.close;~z1.close;~z25 = (View(w, Rect((~f1.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+10, ~nw, 2)).background = Color.white;);}, {~z1.close;~z25.close;~z1 = (View(w, Rect((~f1.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+10, ~nw, 2)).background = Color.white;);});
		if((~f2 > ~outmaxa) or: (~f2 < ~outmina), {~z26.close;~z2.close;~z26 = (View(w, Rect((~f2.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+20, ~nw, 2)).background = Color.white;);}, {~z2.close;~z26.close;~z2 = (View(w, Rect((~f2.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+20, ~nw, 2)).background = Color.white;);});
		if((~f3 > ~outmaxa) or: (~f3 < ~outmina), {~z27.close;~z3.close;~z27 = (View(w, Rect((~f3.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+30, ~nw, 2)).background = Color.white;);}, {~z3.close;~z27.close;~z3 = (View(w, Rect((~f3.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+30, ~nw, 2)).background = Color.white;);});
	};

	~synthslide = {
		case
		{~l1a1.isRunning == true}{(//fprog
			~slideroutine = Routine({1.do({var vol1,vol2,vol3,s1,s2,s3,s4,s5,s6;
				#vol1,vol2,vol3 = [~vol1,~vol2,~vol3];
				~slidedo.do({~slidecount=~slidecount-1;
					(
						[ ~f1=~f1+g,~f2=~f2+h,~f3=~f3+i ];
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
					);

					{if(~slidecount==0,{
						if((~f1 > ~outmaxa) or: (~f1 < ~outmina), {~z25.close;~z1.close;~z25 = (View(w, Rect((~f1.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+10, ~nw, 2)).background = Color.white;);}, {~z1.close;~z25.close;~z1 = (View(w, Rect((~f1.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+10, ~nw, 2)).background = Color.white;);});
						if((~f2 > ~outmaxa) or: (~f2 < ~outmina), {~z26.close;~z2.close;~z26 = (View(w, Rect((~f2.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+20, ~nw, 2)).background = Color.white;);}, {~z2.close;~z26.close;~z2 = (View(w, Rect((~f2.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+20, ~nw, 2)).background = Color.white;);});
						if((~f3 > ~outmaxa) or: (~f3 < ~outmina), {~z27.close;~z3.close;~z27 = (View(w, Rect((~f3.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+30, ~nw, 2)).background = Color.white;);}, {~z3.close;~z27.close;~z3 = (View(w, Rect((~f3.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+30, ~nw, 2)).background = Color.white;);});
					});}.defer;

					(~slidetime/~slidedo).wait;});});}).play;);}
		{~l1a.isRunning == true} {(//fprog
			~slideroutine = Routine({1.do({var vol1,vol2,vol3,s1,s2,s3,s4,s5,s6;
				#vol1,vol2,vol3= [~vol1,~vol2,~vol3];
				~slidedo.do({~slidecount=~slidecount-1;
					(
						[ ~f1=~f1+g,~f2=~f2+h,~f3=~f3+i ];
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
					);

					{if(~slidecount==0,{if((~f1 > ~outmaxa) or: (~f1 < ~outmina), {~z25.close;~z1.close;~z25 = (View(w, Rect((~f1.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+10, ~nw, 2)).background = Color.white;);}, {~z1.close;~z25.close;~z1 = (View(w, Rect((~f1.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+10, ~nw, 2)).background = Color.white;);});
						if((~f2 > ~outmaxa) or: (~f2 < ~outmina), {~z26.close;~z2.close;~z26 = (View(w, Rect((~f2.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+20, ~nw, 2)).background = Color.white;);}, {~z2.close;~z26.close;~z2 = (View(w, Rect((~f2.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+20, ~nw, 2)).background = Color.white;);});
						if((~f3 > ~outmaxa) or: (~f3 < ~outmina), {~z27.close;~z3.close;~z27 = (View(w, Rect((~f3.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+30, ~nw, 2)).background = Color.white;);}, {~z3.close;~z27.close;~z3 = (View(w, Rect((~f3.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+30, ~nw, 2)).background = Color.white;);});
					});}.defer;

					(~slidetime/~slidedo).wait;});});}).play;);};
	};

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


	//timer values

	case
	{~slot1 == nil}{""}
	{~slot2 == nil}{""}
	{~slot3 == nil}{""}
	{~slot4 == nil}{""}
	{~slot5 == nil}{""}
	{~slot6 == nil}{""}
	{~slot7 == nil}{""}
	{~slot8 == nil}{""};

	~timevals = {(~tst = TextView(w, Rect(~tspl,~tspt, ~tspw, ~tsph)).background_(Color.black);
		(~tst.string =
			"o1:_"++~time1o.value.asString++"_f1:_"++~time1f.value.asString++"_s1:_"++~time1s.value.asString++"\n" ++
			"o2:_"++~time2o.value.asString++"_f2:_"++~time2f.value.asString++"_s2:_"++~time2s.value.asString++"\n" ++
			"o3:_"++~time3o.value.asString++"_f3:_"++~time3f.value.asString++"_s3:_"++~time3s.value.asString++"\n" ++
			"o4:_"++~time4o.value.asString++"_f4:_"++~time4f.value.asString++"_s4:_"++~time4s.value.asString++"\n" ++
			"o5:_"++~time5o.value.asString++"_f5:_"++~time5f.value.asString++"_s5:_"++~time5s.value.asString++"\n" ++
			"o6:_"++~time6o.value.asString++"_f6:_"++~time6f.value.asString++"_s6:_"++~time6s.value.asString++"\n" ++
			"o7:_"++~time7o.value.asString++"_f7:_"++~time7f.value.asString++"_s7:_"++~time7s.value.asString++"\n" ++
			"o8:_"++~time8o.value.asString++"_f8:_"++~time8f.value.asString++"_s8:_"++~time8s.value.asString++"\n" ++"\n" ++
			if(~slot8 != ~slot, {
				(~slot1 = ~slot2).asString++"\n" ++
				(~slot2 = ~slot3).asString++"\n" ++
				(~slot3 = ~slot4).asString++"\n" ++
				(~slot4 = ~slot5).asString++"\n" ++
				(~slot5 = ~slot6).asString++"\n" ++
				(~slot6 = ~slot7).asString++"\n" ++
				(~slot7 = ~slot8).asString++"\n" ++
				(~slot8 = ~slot).asString;
			},{
				(~slot1).asString++"\n" ++
				(~slot2).asString++"\n" ++
				(~slot3).asString++"\n" ++
				(~slot4).asString++"\n" ++
				(~slot5).asString++"\n" ++
				(~slot6).asString++"\n" ++
				(~slot7).asString++"\n" ++
				(~slot8).asString;
			});

		);
		~tst.stringColor = Color.white;
	)};


	//monitoring number of synths function

	~numsynthsfunc = {
		if((~numsynths != nil) or: (~numsynths.isPlaying == true), {~numsynths.stop;});
		~numsynths = Routine({inf.do({if((s.numSynths > 19) and: (3.wait; s.numSynths > 19) and: (6.wait; s.numSynths > 19), {

			AppClock.sched(0, {
				if(~numsynthmessage != nil, {~numsynthmessage.close;});
				~numsynthmessage = View(w, Rect(Window.screenBounds.width-(340+46),Window.screenBounds.height-(340+46/1.6180339887499)-110,340+46,340+46/1.6180339887499)).background_(Color.black).front;
				~numsynthmessagestring = StaticText(~numsynthmessage, Rect(0,0,340+46,340+46/1.6180339887499)).background_(Color.black);
				~numsynthmessagestring.align = \topLeft;
				~numsynthmessagestring.string ="Warning:"++"\n"++"\n"++"More than the normal amount of synths are currently running. It is recommended to free the server by pressing "+"ctrl/cmd - period".quote+" and then pressing the "+"ok".quote+" button. Otherwise, you can press the "+"cancel".quote+" button to allow the synths to keep running. If you press the "+"cancel".quote+" button this message will not show again unless "+"synth0".quote+" has been pressed.";
				~numsynthmessagestring.stringColor = Color.white;
				~numsynthmessagebutton1 = Button.new(~numsynthmessage,Rect(120-46,340/1.6180339887499-30,46,46/1.6180339887499)).states_([["ok",Color.white,Color.black]]).action_({AppClock.sched(0, {~numsynthmessage.close; ~numsynths.play; ~midifunc.value;});});
				~numsynthmessagebutton2 = Button.new(~numsynthmessage,Rect(320+46-100,340/1.6180339887499-30,46,46/1.6180339887499)).states_([["cancel",Color.white,Color.black]]).action_({AppClock.sched(0, {~numsynths.stop; ~numsynthmessage.close;});});
				~numsynthmessage.front;
			});
		}); 1.wait;});}).play;
	};

	~numsynthsfunc.value;


	//mouse down action

	view.mouseDownAction = {
		|v, x, y, mod, butNum|
		point = [x,y];
		if(butNum == 0, { v.refresh;

			//generate dots on mouse down action

			~tgrid = 30;
			~bgrid = Window.screenBounds.height-(Window.screenBounds.height/1.6180339887499)+30;

			case
			{y<~tgrid} {nil}
			{y>=(~tgrid) and: y<=(~tgrid=~tgrid+10)}  {~z1.close;~z1 = (View(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
			{y>=(~tgrid) and: y<=(~tgrid=~tgrid+10)}  {~z2.close;~z2 = (View(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
			{y>=(~tgrid) and: y<=(~tgrid=~tgrid+10)}  {~z3.close;~z3 = (View(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
			{y>~tgrid and: y<~bgrid} {nil}
			{y>=(~bgrid) and: y<=(~bgrid=~bgrid+10)} {~z1.close;~z1 = (View(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
			{y>=(~bgrid) and: y<=(~bgrid=~bgrid+10)} {~z2.close;~z2 = (View(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
			{y>=(~bgrid) and: y<=(~bgrid=~bgrid+10)} {~z3.close;~z3 = (View(w, Rect(x, y, ~nw, 2)).background = Color.white;)};
		}, {});

		~tgrid = 30;
		~bgrid = Window.screenBounds.height-(Window.screenBounds.height/1.6180339887499)+30;

		//set synth values on mouse down action

		case
		{~l1a.isRunning == true}{
			case
			{y<~tgrid} {nil}
			{y>=(~tgrid) and: y<=(~tgrid=~tgrid+10)} {
				~l1a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
				~l1b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value); ~f1=q.value; ~undof1=~f1;
				~l1c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
				~l1d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
				~l1e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
				~l1f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}
			{y>=(~tgrid) and: y<=(~tgrid=~tgrid+10)} {
				~l2a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
				~l2b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value); ~f2=q.value; ~undof2=~f2;
				~l2c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
				~l2d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
				~l2e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
				~l2f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}
			{y>=(~tgrid) and: y<=(~tgrid=~tgrid+10)} {
				~l3a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
				~l3b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value); ~f3=q.value; ~undof3=~f3;
				~l3c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
				~l3d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
				~l3e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
				~l3f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}
			{y>~tgrid and: y<~bgrid} {nil}
			{y>=(~bgrid) and: y<=(~bgrid=~bgrid+10)} {
				~l1a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l1b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value); ~f1=q.value; ~undof1=~f1;
				~l1c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
				~l1d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
				~l1e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
				~l1f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);}
			{y>=(~bgrid) and: y<=(~bgrid=~bgrid+10)} {
				~l2a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l2b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value); ~f2=q.value; ~undof2=~f2;
				~l2c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
				~l2d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
				~l2e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
				~l2f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);}
			{y>=(~bgrid) and: y<=(~bgrid=~bgrid+10)} {
				~l3a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l3b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value); ~f3=q.value; ~undof3=~f3;
				~l3c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
				~l3d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
				~l3e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
				~l3f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);};
		}
		{~l1a1.isRunning == true}{
			case
			{y<~tgrid} {nil}
			{y>=(~tgrid) and: y<=(~tgrid=~tgrid+10)} {
				~l1a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
				~l1b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value); ~f1=q.value; ~undof1=~f1;
				~l1c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
				~l1d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
				~l1e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
				~l1f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}
			{y>=(~tgrid) and: y<=(~tgrid=~tgrid+10)} {
				~l2a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
				~l2b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value); ~f2=q.value; ~undof2=~f2;
				~l2c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
				~l2d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
				~l2e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
				~l2f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}
			{y>=(~tgrid) and: y<=(~tgrid=~tgrid+10)} {
				~l3a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
				~l3b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value); ~f3=q.value; ~undof3=~f3;
				~l3c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
				~l3d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
				~l3e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
				~l3f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}
			{y>~tgrid and: y<~bgrid} {nil}
			{y>=(~bgrid) and: y<=(~bgrid=~bgrid+10)} {
				~l1a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l1b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value); ~f1=q.value; ~undof1=~f1;
				~l1c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
				~l1d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
				~l1e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
				~l1f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);}
			{y>=(~bgrid) and: y<=(~bgrid=~bgrid+10)} {
				~l2a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l2b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value); ~f2=q.value; ~undof2=~f2;
				~l2c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
				~l2d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
				~l2e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
				~l2f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);}
			{y>=(~bgrid) and: y<=(~bgrid=~bgrid+10)} {
				~l3a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l3b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value); ~f3=q.value; ~undof3=~f3;
				~l3c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
				~l3d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
				~l3e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
				~l3f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);};
		};
	};


	//mouse move action

	view.mouseMoveAction = {
		|v, x, y|

		~nh = 2;
		~nw = ~nh*1.6180339887499;

		//generate dots on mouse move action

		~tgrid = 30;
		~bgrid = Window.screenBounds.height-(Window.screenBounds.height/1.6180339887499)+30;

		case
		{y<~tgrid} {nil}
		{y>=(~tgrid) and: y<=(~tgrid=~tgrid+10)}  {~z1.close;~z25.close;~z1 = (View(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
		{y>=(~tgrid) and: y<=(~tgrid=~tgrid+10)}  {~z2.close;~z26.close;~z2 = (View(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
		{y>=(~tgrid) and: y<=(~tgrid=~tgrid+10)}  {~z3.close;~z27.close;~z3 = (View(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
		{y>~tgrid and: y<~bgrid} {nil}
		{y>=(~bgrid) and: y<=(~bgrid=~bgrid+10)} {~z1.close;~z25.close;~z1 = (View(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
		{y>=(~bgrid) and: y<=(~bgrid=~bgrid+10)} {~z2.close;~z26.close;~z2 = (View(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
		{y>=(~bgrid) and: y<=(~bgrid=~bgrid+10)} {~z3.close;~z27.close;~z3 = (View(w, Rect(x, y, ~nw, 2)).background = Color.white;)};
		w.refresh;

		~tgrid = 30;
		~bgrid = Window.screenBounds.height-(Window.screenBounds.height/1.6180339887499)+30;

		//set synth values on mouse move action

		case
		{~l1a.isRunning == true}{
			case
			{y<~tgrid} {nil}
			{y>=(~tgrid) and: y<=(~tgrid=~tgrid+10)} {
				~l1a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
				~l1b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value); ~f1=q.value; ~undof1=~f1;
				~l1c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
				~l1d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
				~l1e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
				~l1f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}
			{y>=(~tgrid) and: y<=(~tgrid=~tgrid+10)} {
				~l2a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
				~l2b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value); ~f2=q.value; ~undof2=~f2;
				~l2c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
				~l2d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
				~l2e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
				~l2f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}
			{y>=(~tgrid) and: y<=(~tgrid=~tgrid+10)} {
				~l3a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
				~l3b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value); ~f3=q.value; ~undof3=~f3;
				~l3c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
				~l3d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
				~l3e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
				~l3f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}
			{y>~tgrid and: y<~bgrid} {nil}
			{y>=(~bgrid) and: y<=(~bgrid=~bgrid+10)} {
				~l1a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l1b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value); ~f1=q.value; ~undof1=~f1;
				~l1c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
				~l1d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
				~l1e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
				~l1f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);}
			{y>=(~bgrid) and: y<=(~bgrid=~bgrid+10)} {
				~l2a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l2b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value); ~f2=q.value; ~undof2=~f2;
				~l2c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
				~l2d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
				~l2e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
				~l2f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);}
			{y>=(~bgrid) and: y<=(~bgrid=~bgrid+10)} {
				~l3a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l3b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value); ~f3=q.value; ~undof3=~f3;
				~l3c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
				~l3d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
				~l3e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
				~l3f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);};
		}
		{~l1a1.isRunning == true}{
			case
			{y<~tgrid} {nil}
			{y>=(~tgrid) and: y<=(~tgrid=~tgrid+10)} {
				~l1a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
				~l1b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value); ~f1=q.value; ~undof1=~f1;
				~l1c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
				~l1d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
				~l1e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
				~l1f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}
			{y>=(~tgrid) and: y<=(~tgrid=~tgrid+10)} {
				~l2a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
				~l2b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value); ~f2=q.value; ~undof2=~f2;
				~l2c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
				~l2d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
				~l2e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
				~l2f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}
			{y>=(~tgrid) and: y<=(~tgrid=~tgrid+10)} {
				~l3a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
				~l3b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value); ~f3=q.value; ~undof3=~f3;
				~l3c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
				~l3d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
				~l3e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
				~l3f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}
			{y>~tgrid and: y<~bgrid} {nil}
			{y>=(~bgrid) and: y<=(~bgrid=~bgrid+10)} {
				~l1a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l1b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value); ~f1=q.value; ~undof1=~f1;
				~l1c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
				~l1d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
				~l1e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
				~l1f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);}
			{y>=(~bgrid) and: y<=(~bgrid=~bgrid+10)} {
				~l2a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l2b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value); ~f2=q.value; ~undof2=~f2;
				~l2c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
				~l2d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
				~l2e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
				~l2f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);}
			{y>=(~bgrid) and: y<=(~bgrid=~bgrid+10)} {
				~l3a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l3b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value); ~f3=q.value; ~undof3=~f3;
				~l3c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
				~l3d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
				~l3e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
				~l3f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);};
		};
	};

	~tgrid = 30;
	~bgrid = Window.screenBounds.height-(Window.screenBounds.height/1.6180339887499)+30;
	~dc1 = ~tgrid-5; ~dc2 = ~bgrid-5; ~dca = 10;

	~bpl = Window.screenBounds.width-340;
	~bpt = Window.screenBounds.height-88;
	~bph = 40;
	~bpw = 40/1.6180339887499;


	//copy button

	b = Button.new(w,Rect(Window.screenBounds.width*0+80,Window.screenBounds.height-52,60,60/1.6180339887499)).states_([["copy",Color.white,Color.black],["copy",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button;
		if(button.value == 1, {

			~tsc = TextView(w, Rect(0,5, Window.screenBounds.width, 354)).background_(Color.black);
			(~tsc.string =
				"current chord/frequencies: "++"\n"++"\n"++

				"[~f1="++~f1.asString++",~f2="++~f2.asString++",~f3="++~f3.asString++"]"++"\n"++"\n"++

				"saved open/flow 1-8 frequencies (in script format): "++"\n"++"\n"++

				"[~f1="++~fp1.asString++",~f2="++~fp2.asString++",~f3="++~fp3.asString++"];"++" "++"~synthopen.value; ~trace.value; (a).wait;"++"\n"++
				"[~f1="++~fp1b.asString++",~f2="++~fp2b.asString++",~f3="++~fp3b.asString++"];"++" "++"~synthflow.value; ~trace.value; (a).wait;"++"\n"++
				"[~f1="++~fp1c.asString++",~f2="++~fp2c.asString++",~f3="++~fp3c.asString++"];"++" "++"~synthflow.value; ~trace.value; (a).wait;"++"\n"++
				"[~f1="++~fp1d.asString++",~f2="++~fp2d.asString++",~f3="++~fp3d.asString++"];"++" "++"~synthflow.value; ~trace.value; (a).wait;"++"\n"++
				"[~f1="++~fp1e.asString++",~f2="++~fp2e.asString++",~f3="++~fp3e.asString++"];"++" "++"~synthflow.value; ~trace.value; (a).wait;"++"\n"++
				"[~f1="++~fp1f.asString++",~f2="++~fp2f.asString++",~f3="++~fp3f.asString++"];"++" "++"~synthflow.value; ~trace.value; (a).wait;"++"\n"++
				"[~f1="++~fp1g.asString++",~f2="++~fp2g.asString++",~f3="++~fp3g.asString++"];"++" "++"~synthflow.value; ~trace.value; (a).wait;"++"\n"++
				"[~f1="++~fp1h.asString++",~f2="++~fp2h.asString++",~f3="++~fp3h.asString++"];"++" "++"~synthflow.value; ~trace.value; (a).wait;"++"\n"++"\n"++

				"saved slide 1-8 frequencies (in script format): "++"\n"++"\n"++

				"#s,t,u = [ ~f1,~f2,~f3 ]; [~f1="++~fp1.asString++",~f2="++~fp2.asString++",~f3="++~fp3.asString++"];"++" "++"~slidetime = 1; ~slidedo = 432; ~synthslide.value; ~trace.value; (a).wait;"++"\n"++
				"#s,t,u = [ ~f1,~f2,~f3 ]; [~f1="++~fp1b.asString++",~f2="++~fp2b.asString++",~f3="++~fp3b.asString++"];"++" "++"~slidetime = 1; ~slidedo = 432; ~synthslide.value; ~trace.value; (a).wait;"++"\n"++
				"#s,t,u = [ ~f1,~f2,~f3 ]; [~f1="++~fp1c.asString++",~f2="++~fp2c.asString++",~f3="++~fp3c.asString++"];"++" "++"~slidetime = 1; ~slidedo = 432; ~synthslide.value; ~trace.value; (a).wait;"++"\n"++
				"#s,t,u = [ ~f1,~f2,~f3 ]; [~f1="++~fp1d.asString++",~f2="++~fp2d.asString++",~f3="++~fp3d.asString++"];"++" "++"~slidetime = 1; ~slidedo = 432; ~synthslide.value; ~trace.value; (a).wait;"++"\n"++
				"#s,t,u = [ ~f1,~f2,~f3 ]; [~f1="++~fp1e.asString++",~f2="++~fp2e.asString++",~f3="++~fp3e.asString++"];"++" "++"~slidetime = 1; ~slidedo = 432; ~synthslide.value; ~trace.value; (a).wait;"++"\n"++
				"#s,t,u = [ ~f1,~f2,~f3 ]; [~f1="++~fp1f.asString++",~f2="++~fp2f.asString++",~f3="++~fp3f.asString++"];"++" "++"~slidetime = 1; ~slidedo = 432; ~synthslide.value; ~trace.value; (a).wait;"++"\n"++
				"#s,t,u = [ ~f1,~f2,~f3 ]; [~f1="++~fp1g.asString++",~f2="++~fp2g.asString++",~f3="++~fp3g.asString++"];"++" "++"~slidetime = 1; ~slidedo = 432; ~synthslide.value; ~trace.value; (a).wait;"++"\n"++
				"#s,t,u = [ ~f1,~f2,~f3 ]; [~f1="++~fp1h.asString++",~f2="++~fp2h.asString++",~f3="++~fp3h.asString++"];"++" "++"~slidetime = 1; ~slidedo = 432; ~synthslide.value; ~trace.value; (a).wait;"
			);
			~tsc.stringColor = Color.white;
			[ ~f1,~f2,~f3 ].postln;},
		{~tsc.close;});
	});


	/*//stop timer button

	sts = Button.new(w,Rect(Window.screenBounds.width-20-20-20-20,~bpt+69+5,20,20/1.6180339887499)).states_([["st",Color.white,Color.black],["st",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button;
	if(~timer.isPlaying == true, {
	if(~tst.value == nil, {~timer.stop; ~systemclock.stop; ~systemclock.clear;},{~tst.close;
	~timevals.value;
	~timer.stop; ~systemclock.stop; ~systemclock.clear;});
	});
	});*/


	//timer button

	~ts = Button.new(w,Rect(Window.screenBounds.width*0+20,Window.screenBounds.height-52,60,60/1.6180339887499)).states_([["tsynth0",Color.white,Color.black],["tsynth1",Color.white,Color.black]]).action_({arg synthbutton; synthbutton.value.postln}).action_({arg synthbutton; if(synthbutton.value == 1, {

		~sts = Button.new(w,Rect(~bp01l-90,~bp01t,80,20)).states_([["stop timer",Color.white,Color.black],["stop timer",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button;
			if(~timer.isPlaying == true, {
				if(~tst.value == nil, {~timer.stop; ~systemclock.stop; ~systemclock.clear;},{~tst.close;
					~timevals.value;
					~timer.stop; ~systemclock.stop; ~systemclock.clear;});
			});
		});

		if(~tst != nil, {~tst.close});
		~timevals.value;
		~timer.stop; ~systemclock.stop; ~systemclock.clear;},{if(~tst.value == nil, {~timer.stop; ~systemclock.stop; ~systemclock.clear;},{~timer.stop; ~systemclock.stop; ~systemclock.clear; ~tst.close; ~sts.close;})});

	});


	//start/stop synth button

	b3 = Button.new(w,Rect(Window.screenBounds.width*0+20,Window.screenBounds.height-88,60,60/1.6180339887499)).states_([["synth0",Color.white,Color.black],["synth1",Color.white,Color.black]]).action_({arg synthbutton; synthbutton.value.postln}).action_({
		arg synthbutton; if(synthbutton.value == 1, {
			~l1a = Synth(\gsineicfld, [\dur, 432]).register;~l1a1 = Synth(\gsineicfld, [\dur, 432]).register;[~l1a, ~l1a1].do(_.free);~l1a = Synth(\gsineicfld, [\dur, 432]).register;~l1a1 = Synth(\gsineicfld, [\dur, 432]).register;[~l1a, ~l1a1].do(_.free);
			~synthopen.value;
			~numsynths.stop; ~numsynthsfunc.value;
			~midifunc.value;
		},
		{~synthfree.value; b4.value = 0;})
	});


	//pause/unpause button

	b4 = Button.new(w,Rect(Window.screenBounds.width*0+80,Window.screenBounds.height-88,60,60/1.6180339887499)).states_([["pause0",Color.white,Color.black],["pause1",Color.white,Color.black]]).action_({arg synthbutton; synthbutton.value.postln}).action_({
		arg synthbutton; if(synthbutton.value == 1, {~synthpause.value; if(~ts.value == 1, {~timer.stop;});},
			{~synthflow.value; if(~ts.value != 1, {nil}, {SystemClock.play(~timer);})})
	});


	//generate values for number of KW(King Wen) sequences in a timewave half-cycle (or amplitude x2) pop-up menu

	x=0;
	~menu2values = Array.fill(24, {(x=x+1).asString++" kws"});


	//number of KW(King Wen) sequences in a timewave half-cycle (or amplitude x2) upon starting value

	case
	{~gsinenum == nil}{~menu2start = ~menu2values.at(~synthdefnum-1)}
	{~gsinenum == 1}{~menu2start = ~menu2values.at(0)}
	{~gsinenum == 2}{~menu2start = ~menu2values.at(1)}
	{~gsinenum == 3}{~menu2start = ~menu2values.at(2)}
	{~gsinenum == 4}{~menu2start = ~menu2values.at(3)}
	{~gsinenum == 5}{~menu2start = ~menu2values.at(4)}
	{~gsinenum == 6}{~menu2start = ~menu2values.at(5)}
	{~gsinenum == 7}{~menu2start = ~menu2values.at(6)}
	{~gsinenum == 8}{~menu2start = ~menu2values.at(7)}
	{~gsinenum == 9}{~menu2start = ~menu2values.at(8)}
	{~gsinenum == 10}{~menu2start = ~menu2values.at(9)}
	{~gsinenum == 11}{~menu2start = ~menu2values.at(10)}
	{~gsinenum == 12}{~menu2start = ~menu2values.at(11)}
	{~gsinenum == 13}{~menu2start = ~menu2values.at(12)}
	{~gsinenum == 14}{~menu2start = ~menu2values.at(13)}
	{~gsinenum == 15}{~menu2start = ~menu2values.at(14)}
	{~gsinenum == 16}{~menu2start = ~menu2values.at(15)}
	{~gsinenum == 17}{~menu2start = ~menu2values.at(16)}
	{~gsinenum == 18}{~menu2start = ~menu2values.at(17)}
	{~gsinenum == 19}{~menu2start = ~menu2values.at(18)}
	{~gsinenum == 20}{~menu2start = ~menu2values.at(19)}
	{~gsinenum == 21}{~menu2start = ~menu2values.at(20)}
	{~gsinenum == 22}{~menu2start = ~menu2values.at(21)}
	{~gsinenum == 23}{~menu2start = ~menu2values.at(22)}
	{~gsinenum == 24}{~menu2start = ~menu2values.at(23)};
	if(~menu2synthdefstart.value == nil, {~menu2synthdefstart = ~synthdefnum}, {~menu2synthdefstart = ~gsinenum});

	if(~low_pass_filter_set_value == nil, {~low_pass_filter_set_value = ~low_pass_filter_freq_limit});
	if(~low_pass_filter_set_value != ~low_pass_filter_freq_limit, {~low_pass_filter_set_value = ~low_pass_filter_freq_limit});


	//settings function

	~settingsbutton = Button.new(w,Rect(20+60*2+15+25,Window.screenBounds.height-88+(30/1.6180339887499*0),60,60/1.6180339887499)).states_([["settings",Color.white,Color.black],["settings",Color.white,Color.black]]).action_({arg button;

		if(button.value == 1, {

			({
				arg  top = 0,width=150, revertwidth=75, height = 25,  heightbox = 25, lefttime = 0 , lefttimebox = width+5,  widthbox=165, leftdo = lefttimebox+widthbox+5, leftdobox = leftdo+57, inc=0, lw = 0,  uw = 0, numw = 40;
				var tall, stall, iall, siall, st1, st2, st3, st4, st5, st6, st7, st8, st9, st10, st11, st12, si1, si2, si3, si4, si5, si6, si7, si8, t1,t2,t3,t4,t5,t6,t7,t8,t9,t10,t11,t12,i1,i2,i3,i4,i5,i6,i7,i8,i9,i10,i11,i12;
				~settingsview = View(w, Rect(20+60*2+15+25,Window.screenBounds.height-340,340,340/1.6180339887499)).front;
				/*w.view.decorator=FlowLayout(w.view.bounds);
				w.view.decorator.gap=2@2;*/

				top = 0;

				t1 = StaticText(~settingsview, Rect(lefttime , top=top, width, height)).background_(Color.black).string_("KWS number").stringColor_(Color.white);
				t2 = StaticText(~settingsview, Rect(lefttime , top=top+height+5, width, height)).background_(Color.black).string_("base(lowest) freq(hz)").stringColor_(Color.white);
				t3 = StaticText(~settingsview, Rect(lefttime , top=top+height+5, width, height)).background_(Color.black).string_("synthdef type").stringColor_(Color.white);
				t4 = StaticText(~settingsview, Rect(lefttime , top=top+height+5, width, height)).background_(Color.black).string_("lp filter limit(hz)").stringColor_(Color.white);
				t5 = StaticText(~settingsview, Rect(lefttime , top=top+height+5, width, height)).background_(Color.black).string_("automate").stringColor_(Color.white);


				top = 0;


				//number of KW(King Wen) sequences in a timewave half-cycle (or amplitude x2) pop-up menu

				~menu2 = PopUpMenu(~settingsview,Rect(lefttimebox , top=top, widthbox, heightbox)).items_(~mvalue = (-1); [~menu2start.asString]++Array.fill(24, {~menu2values.at(~mvalue = ~mvalue+1);});).background_(Color.black).stringColor_(Color.white).action_({arg button;

					if(~st != nil, {~st.close});
					~st = StaticText(~settingsview, Rect(lefttime, top, 200, 20)).background_(Color.black);
					~st.stringColor = Color.white;
					~st.string = "# of kws in halfcycle selected";
					AppClock.sched(~gm,{~st.close;});
				});


				//pop-menu for timewave base (lowest) frequency

				~bfreqstart = ~basefreq;
				~bfreq = PopUpMenu(~settingsview, Rect(lefttimebox , top=top+heightbox+5, widthbox, heightbox)).items_(~bfreqv = (-1); [~basefreq.asString]++Array.fill(140, {~basefreqmap.at(~bfreqv=~bfreqv+1).asString})).background_(Color.black).stringColor_(Color.white).action_({arg button;

					if(~st != nil, {~st.close});
					~st = StaticText(~settingsview, Rect(lefttime, top, 200, 20)).background_(Color.black);
					~st.stringColor = Color.white;
					~st.string = "basefreq selected";
					AppClock.sched(~gm,{~st.close;});
				});


				//synthdef pop-up menu

				~gsinemenu = PopUpMenu(~settingsview, Rect(lefttimebox , top=top+heightbox+5, widthbox, heightbox)).items_(["psine1","psine2","psine3","hsine1","hsine2","hsine3","psineuf1","psineuf2","psineuf3","hsineuf1","hsineuf2","hsineuf3"]).background_(Color.black).stringColor_(Color.white).action_({arg button;

					if(~gsinemenu.value == 0,  {~kws_setting = 1; ~ratio_setting = "psine1"; ~low_pass_filter_on = 1; ~gs = 0;});
					if(~gsinemenu.value == 1,  {~kws_setting = 2; ~ratio_setting = "psine2"; ~low_pass_filter_on = 1; ~gs = 1;});
					if(~gsinemenu.value == 2,  {~kws_setting = 3; ~ratio_setting = "psine3"; ~low_pass_filter_on = 1; ~gs = 2;});
					if(~gsinemenu.value == 3,  {~kws_setting = 1; ~ratio_setting = "hsine1"; ~low_pass_filter_on = 1; ~gs = 3;});
					if(~gsinemenu.value == 4,  {~kws_setting = 2; ~ratio_setting = "hsine2"; ~low_pass_filter_on = 1; ~gs = 4;});
					if(~gsinemenu.value == 5,  {~kws_setting = 3; ~ratio_setting = "hsine3"; ~low_pass_filter_on = 1; ~gs = 5;});
					if(~gsinemenu.value == 6,  {~kws_setting = 1; ~ratio_setting = "psine1"; ~low_pass_filter_on = 0; ~gs = 6;});
					if(~gsinemenu.value == 7,  {~kws_setting = 2; ~ratio_setting = "psine2"; ~low_pass_filter_on = 0; ~gs = 7;});
					if(~gsinemenu.value == 8,  {~kws_setting = 3; ~ratio_setting = "psine3"; ~low_pass_filter_on = 0; ~gs = 8;});
					if(~gsinemenu.value == 9,  {~kws_setting = 1; ~ratio_setting = "hsine1"; ~low_pass_filter_on = 0; ~gs = 9;});
					if(~gsinemenu.value == 10, {~kws_setting = 2; ~ratio_setting = "hsine2"; ~low_pass_filter_on = 0; ~gs = 10;});
					if(~gsinemenu.value == 11, {~kws_setting = 3; ~ratio_setting = "hsine3"; ~low_pass_filter_on = 0; ~gs = 11;});

					if(~st != nil, {~st.close});
					~st = StaticText(~settingsview, Rect(lefttime, top, 200, 20)).background_(Color.black);
					~st.stringColor = Color.white;
					~st.string = "synthdef setting selected";
					AppClock.sched(~gm,{~st.close;});
				});

				if(~gs == nil, {~gs = 0;});

				case
				{~gs == 0}{~gsinemenu.value = 0;}
				{~gs == 1}{~gsinemenu.value = 1;}
				{~gs == 2}{~gsinemenu.value = 2;}
				{~gs == 3}{~gsinemenu.value = 3;}
				{~gs == 4}{~gsinemenu.value = 4;}
				{~gs == 5}{~gsinemenu.value = 5;}
				{~gs == 0}{~gsinemenu.value = 6;}
				{~gs == 1}{~gsinemenu.value = 7;}
				{~gs == 2}{~gsinemenu.value = 8;}
				{~gs == 3}{~gsinemenu.value = 9;}
				{~gs == 4}{~gsinemenu.value = 10;}
				{~gs == 5}{~gsinemenu.value = 11;};


				//set low-pass filter frequency limit

				~low_pass_filter_textfield = TextField(~settingsview, Rect(lefttimebox , top=top+heightbox+5, widthbox, heightbox));
				~low_pass_filter_textfield.string = ~low_pass_filter_set_value.asString;
				~low_pass_filter_textfield.background_(Color.black);
				~low_pass_filter_textfield.stringColor_(Color.white);
				~low_pass_filter_textfield.action = {arg value; ~freqsetvalue = value.value;

					~freqset_textfield_func.value; //this function is found after line 2900

					~low_pass_filter_set_value = ~freqsetvalue.value;

					~low_pass_filter_textfield.string = ~low_pass_filter_set_value.asString;

					if(~low_pass_filter_set_value != 0, {
						if(~st != nil, {~st.close});
						~st = StaticText(~settingsview, Rect(lefttime, top, 240, 20)).background_(Color.black);
						~st.stringColor = Color.white;
						~st.string = "low-pass filter freq limit selected";
						AppClock.sched(~gm,{~st.close;});
					}, {~low_pass_filter_set_value = ~low_pass_filter_freq_limit; ~low_pass_filter_textfield.string = ~low_pass_filter_set_value.asString;});
				};


				//switch to sendreply functions

				~sendreplymenu = PopUpMenu(~settingsview,Rect(lefttimebox , top=top+heightbox+5, widthbox, heightbox)).items_(["off","western scale","eastern scale"]).background_(Color.black).stringColor_(Color.white).action_({arg button;

					case
					{button.value == 0;}{~sendreplymenu_value = 0;}
					{button.value == 1;}{~sendreplymenu_value = 1;}
					{button.value == 2;}{~sendreplymenu_value = 2;};

					if(~st != nil, {~st.close});
					~st = StaticText(~settingsview, Rect(lefttime, top, 200, 20)).background_(Color.black);
					~st.stringColor = Color.white;
					~st.string = "automate setting selected";
					AppClock.sched(~gm,{~st.close;});
				});

				if(~sendreplymenu_value == nil, {~sendreplymenu_value = 0;});

				case
				{~sendreplymenu_value == 0}{~sendreplymenu.value = 0;}
				{~sendreplymenu_value == 1}{~sendreplymenu.value = 1;}
				{~sendreplymenu_value == 2}{~sendreplymenu.value = 2;};


				//set button for all settings

				~set1=Button(~settingsview,Rect(lefttimebox+widthbox-60, top=top+height+20, 60, 60/~gm)).states_([["set",Color.white,Color.black]]).mouseDownAction_({

					if(~bfreq.value > 0, {~basefreq = ~basefreqmap.at(~bfreq.value - 1)}, {~basefreq = ~bfreqstart});

					(#a,b,c,d,e,f =	[ ~basefreq,~basefreq,~basefreq,~basefreq,~basefreq,~basefreq  ]; ~a = a; ~b = b; ~c =c; ~d = d; ~e = e;~f=f;);

					~low_pass_filter_freq_limit = ~low_pass_filter_set_value;


					//set n1-n9 values

					case
					{~ratio_setting == "psine1";}{~n_value1 = ~gm;    ~n_value2 = ~gm2;   ~n_value6 = ~gm6;}
					{~ratio_setting == "psine2";}{~n_value1 = ~ngm1;  ~n_value2 = ~ngm2;  ~n_value6 = ~ngm6;}
					{~ratio_setting == "psine3";}{~n_value1 = ~nngm1; ~n_value2 = ~nngm2; ~n_value6 = ~nngm6;}
					{~ratio_setting == "hsine1";}{~n_value1 = ~h1;    ~n_value2 = ~h2;    ~n_value6 = ~h6;}
					{~ratio_setting == "hsine2";}{~n_value1 = ~nh1;   ~n_value2 = ~nh2;   ~n_value6 = ~nh6;}
					{~ratio_setting == "hsine3";}{~n_value1 = ~nnh1;  ~n_value2 = ~nnh2;  ~n_value6 = ~nnh6;};


					//sendyreply values

					case
					{~sendreplymenu.value ==  0}{~sendreplysynthdef_on = 0;}
					{~sendreplymenu.value ==  1}{~sendreplysynthdef_on = 1; ~send_reply_func = ~send_reply_func_western; ~sendreplyfuncswitch = 1;}
					{~sendreplymenu.value ==  2}{~sendreplysynthdef_on = 1; ~send_reply_func = ~send_reply_func_eastern; ~sendreplyfuncswitch = 2;};


					//evaluate synthdefs(gsine)

					case
					{~menu2.value == 0}{~gsinenum = ~menu2synthdefstart; ~gsine.value;}
					{~menu2.value == 1}{~gsinenum = 1; ~gsine.value;}
					{~menu2.value == 2}{~gsinenum = 2; ~gsine.value;}
					{~menu2.value == 3}{~gsinenum = 3; ~gsine.value;}
					{~menu2.value == 4}{~gsinenum = 4; ~gsine.value;}
					{~menu2.value == 5}{~gsinenum = 5; ~gsine.value;}
					{~menu2.value == 6}{~gsinenum = 6; ~gsine.value;}
					{~menu2.value == 7}{~gsinenum = 7; ~gsine.value;}
					{~menu2.value == 8}{~gsinenum = 8; ~gsine.value;}
					{~menu2.value == 9}{~gsinenum = 9; ~gsine.value;}
					{~menu2.value == 10}{~gsinenum = 10; ~gsine.value;}
					{~menu2.value == 11}{~gsinenum = 11; ~gsine.value;}
					{~menu2.value == 12}{~gsinenum = 12; ~gsine.value;}
					{~menu2.value == 13}{~gsinenum = 13; ~gsine.value;}
					{~menu2.value == 14}{~gsinenum = 14; ~gsine.value;}
					{~menu2.value == 15}{~gsinenum = 15; ~gsine.value;}
					{~menu2.value == 16}{~gsinenum = 16; ~gsine.value;}
					{~menu2.value == 17}{~gsinenum = 17; ~gsine.value;}
					{~menu2.value == 18}{~gsinenum = 18; ~gsine.value;}
					{~menu2.value == 19}{~gsinenum = 19; ~gsine.value;}
					{~menu2.value == 20}{~gsinenum = 20; ~gsine.value;}
					{~menu2.value == 21}{~gsinenum = 21; ~gsine.value;}
					{~menu2.value == 22}{~gsinenum = 22; ~gsine.value;}
					{~menu2.value == 23}{~gsinenum = 23; ~gsine.value;}
					{~menu2.value == 24}{~gsinenum = 24; ~gsine.value;};

					~st_load = StaticText(~settingsview, Rect(lefttime, top, 200, 20)).background_(Color.black);
					~st_load.stringColor = Color.white;
					~st_load.string = "loaded.";
					AppClock.sched(~gm,{if(~st != nil, {~st.close}); ~st_load.close;});

				});

				~settingsview.background_(Color.black);

				/*~closessettingsbutton = Button.new(~settingsview,Rect(lefttimebox+widthbox-40, top, 40, 40/~gm)).states_([["close",Color.white,Color.black]]).action_({arg button;

				~settingsview.close; ~settingsbutton.value = 0;
				});*/


			}.value);

			~settingsview.front;
		}, {~settingsview.close});
	});


	//open/flow/slide buttons coordinate values

	~bph = 26;
	~bpw = 26/1.6180339887499;
	~bpl = Window.screenBounds.width-(~bph*8)-20;
	~bpt = Window.screenBounds.height-88;

	~bp01l = ~bpl;
	~bp02l = ~bpl+(~bph*1);
	~bp03l = ~bpl+(~bph*2);
	~bp04l = ~bpl+(~bph*3);
	~bp05l = ~bpl+(~bph*4);
	~bp06l = ~bpl+(~bph*5);
	~bp07l = ~bpl+(~bph*6);
	~bp08l = ~bpl+(~bph*7);
	~bpf1l = ~bpl;
	~bpf2l = ~bpl+(~bph*1);
	~bpf3l = ~bpl+(~bph*2);
	~bpf4l = ~bpl+(~bph*3);
	~bpf5l = ~bpl+(~bph*4);
	~bpf6l = ~bpl+(~bph*5);
	~bpf7l = ~bpl+(~bph*6);
	~bpf8l = ~bpl+(~bph*7);

	~bp01t = ~bpt;
	~bp02t = ~bpt;
	~bp03t = ~bpt;
	~bp04t = ~bpt;
	~bp05t = ~bpt;
	~bp06t = ~bpt;
	~bp07t = ~bpt;
	~bp08t = ~bpt;
	~bpf1t = ~bpt+~bpw;
	~bpf2t = ~bpt+~bpw;
	~bpf3t = ~bpt+~bpw;
	~bpf4t = ~bpt+~bpw;
	~bpf5t = ~bpt+~bpw;
	~bpf6t = ~bpt+~bpw;
	~bpf7t = ~bpt+~bpw;
	~bpf8t = ~bpt+~bpw;

	~bp01h = ~bph;
	~bp02h = ~bph;
	~bp03h = ~bph;
	~bp04h = ~bph;
	~bp05h = ~bph;
	~bp06h = ~bph;
	~bp07h = ~bph;
	~bp08h = ~bph;
	~bpf1h = ~bph;
	~bpf2h = ~bph;
	~bpf3h = ~bph;
	~bpf4h = ~bph;
	~bpf5h = ~bph;
	~bpf6h = ~bph;
	~bpf7h = ~bph;
	~bpf8h = ~bph;

	~bp01w = ~bpw;
	~bp02w = ~bpw;
	~bp03w = ~bpw;
	~bp04w = ~bpw;
	~bp05w = ~bpw;
	~bp06w = ~bpw;
	~bp07w = ~bpw;
	~bp08w = ~bpw;
	~bpf1w = ~bpw;
	~bpf2w = ~bpw;
	~bpf3w = ~bpw;
	~bpf4w = ~bpw;
	~bpf5w = ~bpw;
	~bpf6w = ~bpw;
	~bpf7w = ~bpw;
	~bpf8w = ~bpw;

	~tspw=280+210;
	~tsph=280+210/~gm;
	~tspl=Window.screenBounds.width-~tspw;
	~tspt=~bpt-310;


	//synthopen 1-8 buttons

	~bplaceo1 = Button.new(w,Rect(~bp01l,~bp01t,~bp01h,~bp01w)).states_([["o1",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button;

		[~f1=~fp1,~f2=~fp2,~f3=~fp3];

		~synthopen.value;
		~currentsynth = "o1"; ~synthmonitorfunc.value;

		if(~ts.value == 1,
			{if(~tst == nil, {nil}, {~tst.close;});
				~timevals.value;
				~timer.stop; ~systemclock.stop; ~systemclock.clear; ~time1o = 0;
				~timer = Routine({inf.do({
					~time1o =
					~time1o+0.01; ~slot = "o1_"+~time1o.asString; 0.01.wait;});}); ~systemclock = SystemClock.play(~timer);},
			{nil});
	});

	~bplaceo2 = Button.new(w,Rect(~bp02l,~bp02t,~bp02h,~bp02w)).states_([["o2",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button;

		[~f1=~fp1b,~f2=~fp2b,~f3=~fp3b];

		~synthopen.value;
		~currentsynth = "o2"; ~synthmonitorfunc.value;

		if(~ts.value == 1,
			{if(~tst == nil, {nil}, {~tst.close;});
				~timevals.value;
				~timer.stop; ~systemclock.stop; ~systemclock.clear; ~time2o = 0;
				~timer = Routine({inf.do({
					~time2o =
					~time2o+0.01; ~slot = "o2_"+~time2o.asString; 0.01.wait;});}); ~systemclock = SystemClock.play(~timer);},
			{nil});
	});
	~bplaceo3 = Button.new(w,Rect(~bp03l,~bp03t,~bp03h,~bp03w)).states_([["o3",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button;

		[~f1=~fp1c,~f2=~fp2c,~f3=~fp3c];

		~synthopen.value;
		~currentsynth = "o3"; ~synthmonitorfunc.value;

		if(~ts.value == 1,
			{if(~tst == nil, {nil}, {~tst.close;});
				~timevals.value;
				~timer.stop; ~systemclock.stop; ~systemclock.clear; ~time3o = 0;
				~timer = Routine({inf.do({
					~time3o =
					~time3o+0.01; ~slot = "o3_"+~time3o.asString; 0.01.wait;});}); ~systemclock = SystemClock.play(~timer);},
			{nil});
	});
	~bplaceo4 = Button.new(w,Rect(~bp04l,~bp04t,~bp04h,~bp04w)).states_([["o4",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button;

		[~f1=~fp1d,~f2=~fp2d,~f3=~fp3d];

		~synthopen.value;
		~currentsynth = "o4"; ~synthmonitorfunc.value;

		if(~ts.value == 1,
			{if(~tst == nil, {nil}, {~tst.close;});
				~timevals.value;
				~timer.stop; ~systemclock.stop; ~systemclock.clear; ~time4o = 0;
				~timer = Routine({inf.do({
					~time4o =
					~time4o+0.01; ~slot = "o4_"+~time4o.asString; 0.01.wait;});}); ~systemclock = SystemClock.play(~timer);},
			{nil});

	});

	~bplaceo5 = Button.new(w,Rect(~bp05l,~bp05t,~bp05h,~bp05w)).states_([["o5",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button;

		[~f1=~fp1e,~f2=~fp2e,~f3=~fp3e];

		~synthopen.value;
		~currentsynth = "o5"; ~synthmonitorfunc.value;

		if(~ts.value == 1,
			{if(~tst == nil, {nil}, {~tst.close;});
				~timevals.value;
				~timer.stop; ~systemclock.stop; ~systemclock.clear; ~time5o = 0;
				~timer = Routine({inf.do({
					~time5o =
					~time5o+0.01; ~slot = "o5_"+~time5o.asString; 0.01.wait;});}); ~systemclock = SystemClock.play(~timer);},
			{nil});

	});
	~bplaceo6 = Button.new(w,Rect(~bp06l,~bp06t,~bp06h,~bp06w)).states_([["o6",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button;

		[~f1=~fp1f,~f2=~fp2f,~f3=~fp3f];

		~synthopen.value;
		~currentsynth = "o6"; ~synthmonitorfunc.value;

		if(~ts.value == 1,
			{if(~tst == nil, {nil}, {~tst.close;});
				~timevals.value;
				~timer.stop; ~systemclock.stop; ~systemclock.clear; ~time6o = 0;
				~timer = Routine({inf.do({
					~time6o =
					~time6o+0.01; ~slot = "o6_"+~time6o.asString; 0.01.wait;});}); ~systemclock = SystemClock.play(~timer);},
			{nil});
	});
	~bplaceo7 = Button.new(w,Rect(~bp07l,~bp07t,~bp07h,~bp07w)).states_([["o7",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button;

		[~f1=~fp1g,~f2=~fp2g,~f3=~fp3g];

		~synthopen.value;
		~currentsynth = "o7"; ~synthmonitorfunc.value;

		if(~ts.value == 1,
			{if(~tst == nil, {nil}, {~tst.close;});
				~timevals.value;
				~timer.stop; ~systemclock.stop; ~systemclock.clear; ~time7o = 0;
				~timer = Routine({inf.do({
					~time7o =
					~time7o+0.01; ~slot = "o7_"+~time7o.asString; 0.01.wait;});}); ~systemclock = SystemClock.play(~timer);},
			{nil});
	});
	~bplaceo8 = Button.new(w,Rect(~bp08l,~bp08t,~bp08h,~bp08w)).states_([["o8",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button;

		[~f1=~fp1h,~f2=~fp2h,~f3=~fp3h];

		~synthopen.value;
		~currentsynth = "o8"; ~synthmonitorfunc.value;

		if(~ts.value == 1,
			{if(~tst == nil, {nil}, {~tst.close;});
				~timevals.value;
				~timer.stop; ~systemclock.stop; ~systemclock.clear; ~time8o = 0;
				~timer = Routine({inf.do({
					~time8o =
					~time8o+0.01; ~slot = "o8_"+~time8o.asString; 0.01.wait;});}); ~systemclock = SystemClock.play(~timer);},
			{nil});
	});


	//synthflow 1-8 buttons

	~bplacef1 = Button.new(w,Rect(~bpf1l,~bpf1t,~bpf1h,~bpf1w)).states_([["f1",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button;

		[~f1=~fp1,~f2=~fp2,~f3=~fp3];

		~synthflow.value;
		~currentsynth = "f1"; ~synthmonitorfunc.value;

		if(~ts.value == 1,
			{if(~tst == nil, {nil}, {~tst.close;});
				~timevals.value;
				~timer.stop; ~systemclock.stop; ~systemclock.clear; ~time1f = 0;
				~timer = Routine({inf.do({
					~time1f =
					~time1f+0.01; ~slot = "f1_"+~time1f.asString; 0.01.wait;});}); ~systemclock = SystemClock.play(~timer);},
			{nil});
	});
	~bplacef2 = Button.new(w,Rect(~bpf2l,~bpf2t,~bpf2h,~bpf2w)).states_([["f2",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button;

		[~f1=~fp1b,~f2=~fp2b,~f3=~fp3b];

		~synthflow.value;
		~currentsynth = "f2"; ~synthmonitorfunc.value;

		if(~ts.value == 1,
			{if(~tst == nil, {nil}, {~tst.close;});
				~timevals.value;
				~timer.stop; ~systemclock.stop; ~systemclock.clear; ~time2f = 0;
				~timer = Routine({inf.do({
					~time2f =
					~time2f+0.01; ~slot = "f2_"+~time2f.asString; 0.01.wait;});}); ~systemclock = SystemClock.play(~timer);},
			{nil});
	});

	~bplacef3 = Button.new(w,Rect(~bpf3l,~bpf3t,~bpf3h,~bpf3w)).states_([["f3",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button;

		[~f1=~fp1c,~f2=~fp2c,~f3=~fp3c];

		~synthflow.value;
		~currentsynth = "f3"; ~synthmonitorfunc.value;

		if(~ts.value == 1,
			{if(~tst == nil, {nil}, {~tst.close;});
				~timevals.value;
				~timer.stop; ~systemclock.stop; ~systemclock.clear; ~time3f = 0;
				~timer = Routine({inf.do({
					~time3f =
					~time3f+0.01; ~slot = "f3_"+~time3f.asString; 0.01.wait;});}); ~systemclock = SystemClock.play(~timer);},
			{nil});
	});
	~bplacef4 = Button.new(w,Rect(~bpf4l,~bpf4t,~bpf4h,~bpf4w)).states_([["f4",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button;

		[~f1=~fp1d,~f2=~fp2d,~f3=~fp3d];

		~synthflow.value;
		~currentsynth = "f4"; ~synthmonitorfunc.value;

		if(~ts.value == 1,
			{if(~tst == nil, {nil}, {~tst.close;});
				~timevals.value;
				~timer.stop; ~systemclock.stop; ~systemclock.clear; ~time4f = 0;
				~timer = Routine({inf.do({
					~time4f =
					~time4f+0.01; ~slot = "f4_"+~time4f.asString; 0.01.wait;});}); ~systemclock = SystemClock.play(~timer);},
			{nil});
	});

	~bplacef5 = Button.new(w,Rect(~bpf5l,~bpf5t,~bpf5h,~bpf5w)).states_([["f5",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button;

		[~f1=~fp1e,~f2=~fp2e,~f3=~fp3e];

		~synthflow.value;
		~currentsynth = "f5"; ~synthmonitorfunc.value;

		if(~ts.value == 1,
			{if(~tst == nil, {nil}, {~tst.close;});
				~timevals.value;
				~timer.stop; ~systemclock.stop; ~systemclock.clear; ~time5f = 0;
				~timer = Routine({inf.do({
					~time5f =
					~time5f+0.01; ~slot = "f5_"+~time5f.asString; 0.01.wait;});}); ~systemclock = SystemClock.play(~timer);},
			{nil});
	});

	~bplacef6 = Button.new(w,Rect(~bpf6l,~bpf6t,~bpf6h,~bpf6w)).states_([["f6",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button;

		[~f1=~fp1f,~f2=~fp2f,~f3=~fp3f];

		~synthflow.value;
		~currentsynth = "f6"; ~synthmonitorfunc.value;

		if(~ts.value == 1,
			{if(~tst == nil, {nil}, {~tst.close;});
				~timevals.value;
				~timer.stop; ~systemclock.stop; ~systemclock.clear; ~time6f = 0;
				~timer = Routine({inf.do({
					~time6f =
					~time6f+0.01; ~slot = "f6_"+~time6f.asString; 0.01.wait;});}); ~systemclock = SystemClock.play(~timer);},
			{nil});
	});


	~bplacef7 = Button.new(w,Rect(~bpf7l,~bpf7t,~bpf7h,~bpf7w)).states_([["f7",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button;

		[~f1=~fp1g,~f2=~fp2g,~f3=~fp3g];

		~synthflow.value;
		~currentsynth = "f7"; ~synthmonitorfunc.value;

		if(~ts.value == 1,
			{if(~tst == nil, {nil}, {~tst.close;});
				~timevals.value;
				~timer.stop; ~systemclock.stop; ~systemclock.clear; ~time7f = 0;
				~timer = Routine({inf.do({
					~time7f =
					~time7f+0.01; ~slot = "f7_"+~time7f.asString; 0.01.wait;});}); ~systemclock = SystemClock.play(~timer);},
			{nil});
	});
	~bplacef8 = Button.new(w,Rect(~bpf8l,~bpf8t,~bpf8h,~bpf8w)).states_([["f8",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button;

		[~f1=~fp1h,~f2=~fp2h,~f3=~fp3h];

		~synthflow.value;
		~currentsynth = "f8"; ~synthmonitorfunc.value;

		if(~ts.value == 1,
			{if(~tst == nil, {nil}, {~tst.close;});
				~timevals.value;
				~timer.stop; ~systemclock.stop; ~systemclock.clear; ~time8f = 0;
				~timer = Routine({inf.do({
					~time8f =
					~time8f+0.01; ~slot = "f8_"+~time8f.asString; 0.01.wait;});}); ~systemclock = SystemClock.play(~timer);},
			{nil});
	});


	//synthslide 1-8 buttons

	~bplaces1 = Button.new(w,Rect(~bpf1l,~bpf1t+~bpf1w,~bpf1h,~bpf1w)).states_([["s1",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button;

		if(~slidetime1 == nil, {~slidetime1 = 4}); if(~slidedo1 == nil, {~slidedo1 = 2000;}); ~slidecount = ~slidedo1;
		#g,h,i = (([ ~f1,~f2,~f3 ]-
			[ ~fp1,~fp2,~fp3 ])*(-1)/~slidedo1);

		~slidetime =~slidetime1; ~slidedo = ~slidedo1;

		~slideroutine.stop;

		~synthslide.value;
		~currentsynth = "s1"; ~synthmonitorfunc.value;

		if(~ts.value == 1,
			{if(~tst == nil, {nil}, {~tst.close;});
				~timevals.value;
				~timer.stop; ~systemclock.stop; ~systemclock.clear; ~time1s = 0;
				~timer = Routine({inf.do({
					~time1s =
					~time1s+0.01; ~slot = "s1_"+~time1s.asString; 0.01.wait;});}); ~systemclock = SystemClock.play(~timer);},
			{nil});

	});
	~bplaces2 = Button.new(w,Rect(~bpf2l,~bpf2t+~bpf2w,~bpf2h,~bpf2w)).states_([["s2",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button;

		if(~slidetime2 == nil, {~slidetime2 = 4}); if(~slidedo2 == nil, {~slidedo2 = 2000;}); ~slidecount = ~slidedo2;
		#g,h,i = (([ ~f1,~f2,~f3 ]-
			[ ~fp1b,~fp2b,~fp3b ])*(-1)/~slidedo2);

		~slidetime = ~slidetime2; ~slidedo = ~slidedo2;

		~slideroutine.stop;

		~synthslide.value;
		~currentsynth = "s2"; ~synthmonitorfunc.value;

		if(~ts.value == 1,
			{if(~tst == nil, {nil}, {~tst.close;});
				~timevals.value;
				~timer.stop; ~systemclock.stop; ~systemclock.clear; ~time2s = 0;
				~timer = Routine({inf.do({
					~time2s =
					~time2s+0.01; ~slot = "s2_"+~time2s.asString; 0.01.wait;});}); ~systemclock = SystemClock.play(~timer);},
			{nil});

	});
	~bplaces3 = Button.new(w,Rect(~bpf3l,~bpf3t+~bpf3w,~bpf3h,~bpf3w)).states_([["s3",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button;

		if(~slidetime3 == nil, {~slidetime3 = 4}); if(~slidedo3 == nil, {~slidedo3 = 2000;}); ~slidecount = ~slidedo3;
		#g,h,i = (([ ~f1,~f2,~f3 ]-
			[ ~fp1c,~fp2c,~fp3c ])*(-1)/~slidedo3);

		~slidetime = ~slidetime3; ~slidedo = ~slidedo3;

		~slideroutine.stop;

		~synthslide.value;
		~currentsynth = "s3"; ~synthmonitorfunc.value;

		if(~ts.value == 1,
			{if(~tst == nil, {nil}, {~tst.close;});
				~timevals.value;
				~timer.stop; ~systemclock.stop; ~systemclock.clear; ~time3s = 0;
				~timer = Routine({inf.do({
					~time3s =
					~time3s+0.01; ~slot = "s3_"+~time3s.asString; 0.01.wait;});}); ~systemclock = SystemClock.play(~timer);},
			{nil});

	});
	~bplaces4 = Button.new(w,Rect(~bpf4l,~bpf4t+~bpf4w,~bpf4h,~bpf4w)).states_([["s4",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button;

		if(~slidetime4 == nil, {~slidetime4 = 4}); if(~slidedo4 == nil, {~slidedo4 = 2000;}); ~slidecount = ~slidedo4;
		#g,h,i = (([ ~f1,~f2,~f3 ]-
			[ ~fp1d,~fp2d,~fp3d ])*(-1)/~slidedo4);

		~slidetime = ~slidetime4; ~slidedo = ~slidedo4;

		~slideroutine.stop;

		~synthslide.value;
		~currentsynth = "s4"; ~synthmonitorfunc.value;

		if(~ts.value == 1,
			{if(~tst == nil, {nil}, {~tst.close;});
				~timevals.value;
				~timer.stop; ~systemclock.stop; ~systemclock.clear; ~time4s = 0;
				~timer = Routine({inf.do({
					~time4s =
					~time4s+0.01; ~slot = "s4_"+~time4s.asString; 0.01.wait;});}); ~systemclock = SystemClock.play(~timer);},
			{nil});
	});
	~bplaces5 = Button.new(w,Rect(~bpf5l,~bpf5t+~bpf5w,~bpf5h,~bpf5w)).states_([["s5",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button;

		if(~slidetime5 == nil, {~slidetime5 = 4}); if(~slidedo5 == nil, {~slidedo5 = 2000;}); ~slidecount = ~slidedo5;
		#g,h,i = (([ ~f1,~f2,~f3 ]-
			[ ~fp1e,~fp2e,~fp3e ])*(-1)/~slidedo5);

		~slidetime = ~slidetime5; ~slidedo = ~slidedo5;

		~slideroutine.stop;

		~synthslide.value;
		~currentsynth = "s5"; ~synthmonitorfunc.value;

		if(~ts.value == 1,
			{if(~tst == nil, {nil}, {~tst.close;});
				~timevals.value;
				~timer.stop; ~systemclock.stop; ~systemclock.clear; ~time5s = 0;
				~timer = Routine({inf.do({
					~time5s =
					~time5s+0.01; ~slot = "s5_"+~time5s.asString; 0.01.wait;});}); ~systemclock = SystemClock.play(~timer);},
			{nil});

	});
	~bplaces6 = Button.new(w,Rect(~bpf6l,~bpf6t+~bpf6w,~bpf6h,~bpf6w)).states_([["s6",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button;

		if(~slidetime6 == nil, {~slidetime6 = 4}); if(~slidedo6 == nil, {~slidedo6 = 2000;}); ~slidecount = ~slidedo6;
		#g,h,i = (([ ~f1,~f2,~f3 ]-
			[ ~fp1f,~fp2f,~fp3f ])*(-1)/~slidedo6);

		~slidetime = ~slidetime6; ~slidedo = ~slidedo6;
		~slideroutine.stop;

		~synthslide.value;
		~currentsynth = "s6"; ~synthmonitorfunc.value;

		if(~ts.value == 1,
			{if(~tst == nil, {nil}, {~tst.close;});
				~timevals.value;
				~timer.stop; ~systemclock.stop; ~systemclock.clear; ~time6s = 0;
				~timer = Routine({inf.do({
					~time6s =
					~time6s+0.01; ~slot = "s6_"+~time6s.asString; 0.01.wait;});}); ~systemclock = SystemClock.play(~timer);},
			{nil});

	});
	~bplaces7 = Button.new(w,Rect(~bpf7l,~bpf7t+~bpf7w,~bpf7h,~bpf7w)).states_([["s7",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button;

		if(~slidetime7 == nil, {~slidetime7 = 4}); if(~slidedo7 == nil, {~slidedo7 = 2000;}); ~slidecount = ~slidedo7;
		#g,h,i = (([ ~f1,~f2,~f3 ]-
			[ ~fp1g,~fp2g,~fp3g ])*(-1)/~slidedo7);

		~slidetime = ~slidetime7; ~slidedo = ~slidedo7;
		~slideroutine.stop;

		~synthslide.value;
		~currentsynth = "s7"; ~synthmonitorfunc.value;

		if(~ts.value == 1,
			{if(~tst == nil, {nil}, {~tst.close;});
				~timevals.value;
				~timer.stop; ~systemclock.stop; ~systemclock.clear; ~time7s = 0;
				~timer = Routine({inf.do({
					~time7s =
					~time7s+0.01; ~slot = "s7_"+~time7s.asString; 0.01.wait;});}); ~systemclock = SystemClock.play(~timer);},
			{nil});

	});
	~bplaces8 = Button.new(w,Rect(~bpf8l,~bpf8t+~bpf8w,~bpf8h,~bpf8w)).states_([["s8",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button;

		if(~slidetime8 == nil, {~slidetime8 = 4}); if(~slidedo8 == nil, {~slidedo8 = 2000;}); ~slidecount = ~slidedo8;
		#g,h,i = (([ ~f1,~f2,~f3 ]-
			[ ~fp1h,~fp2h,~fp3h])*(-1)/~slidedo8);

		~slidetime = ~slidetime8; ~slidedo = ~slidedo8;

		~slideroutine.stop;

		~synthslide.value;
		~currentsynth = "s8"; ~synthmonitorfunc.value;

		if(~ts.value == 1,
			{if(~tst == nil, {nil}, {~tst.close;});
				~timevals.value;
				~timer.stop; ~systemclock.stop; ~systemclock.clear; ~time8s = 0;
				~timer = Routine({inf.do({
					~time8s =
					~time8s+0.01; ~slot = "s8_"+~time8s.asString; 0.01.wait;});}); ~systemclock = SystemClock.play(~timer);},
			{nil});
	});


	//if slidetime/slidedo is nil

	if(~slidetimeall == nil, {~slidetimeall = 1});
	if(~slidetime1 == nil, {~slidetime1 = 1});
	if(~slidetime2 == nil, {~slidetime2 = 1});
	if(~slidetime3 == nil, {~slidetime3 = 1});
	if(~slidetime4 == nil, {~slidetime4 = 1});
	if(~slidetime5 == nil, {~slidetime5 = 1});
	if(~slidetime6 == nil, {~slidetime6 = 1});
	if(~slidetime7 == nil, {~slidetime7 = 1});
	if(~slidetime8 == nil, {~slidetime8 = 1});

	if(~slidedoall == nil, {~slidedoall = 432});
	if(~slidedo1 == nil, {~slidedo1 = 432});
	if(~slidedo2 == nil, {~slidedo2 = 432});
	if(~slidedo3 == nil, {~slidedo3 = 432});
	if(~slidedo4 == nil, {~slidedo4 = 432});
	if(~slidedo5 == nil, {~slidedo5 = 432});
	if(~slidedo6 == nil, {~slidedo6 = 432});
	if(~slidedo7 == nil, {~slidedo7 = 432});
	if(~slidedo8 == nil, {~slidedo8 = 432});


	//frequency set function

	~freqset_textfield_func = {
		~freqsetvalue = ~freqsetvalue.asString;
		~freqsetvalue = ~freqsetvalue.separate;
		~freqsetvalue = ~freqsetvalue.reject{arg item;
			(item != "1") and:
			(item != "2") and:
			(item != "3") and:
			(item != "4") and:
			(item != "5") and:
			(item != "6") and:
			(item != "7") and:
			(item != "8") and:
			(item != "9") and:
			(item != "0") and:
			(item != ".") and:
			(item != "+") and:
			(item != "-") and:
			(item != "*") and:
			(item != "/") and:
			(item != "**") and:
			(item != "%")
		};
		~freqsetvalue = ~freqsetvalue.join.asString.interpret;
	};


	//extra options button

	~extraoptions = Button.new(w,Rect(Window.screenBounds.width-20-20-20,~bpt+69+5,20,20/1.6180339887499)).states_([["eo",Color.white,Color.black],["eo",Color.white,Color.black]]).action_({arg button;

		if(button.value == 1, {

			~extraoptionsview = View(w, Rect(Window.screenBounds.width-(540),Window.screenBounds.height-(340+46/1.6180339887499)-150,340+46,380+46/1.6180339887499)).front;
			~extraoptionsview.background_(Color.black);

			//set slide values button

			~slidevals = Button.new(~extraoptionsview,Rect(0,25,120,20)).states_([["slide values",Color.white,Color.black],["slide values",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button;

				if(button.value == 1, {
					({
						arg lefttime = 0 , lefttimebox = 52, leftdo = lefttimebox+widthbox+6, leftdobox = leftdo+57, top = 0,width=52, height = 16,  widthbox=52, heightbox = 16, inc=0, lw = 0,  uw = 0, numw = 40;
						var tall, stall, iall, siall, st1, st2, st3, st4, st5, st6, st7, st8, si1, si2, si3, si4, si5, si6, si7, si8, t1,t2,t3,t4,t5,t6,t7,t8,i1,i2,i3,i4,i5,i6,i7,i8;
						~slideview = View(w, Rect(Window.screenBounds.width-(340+46),Window.screenBounds.height-(340+46/1.6180339887499)-150,340+46,380+46/1.6180339887499)).front;
						/*w.view.decorator=FlowLayout(w.view.bounds);
						w.view.decorator.gap=2@2;*/

						tall = StaticText(~slideview, Rect(lefttime , top=top, width, height)).background_(Color.black).string_("all time").stringColor_(Color.white);
						t1 = StaticText(~slideview, Rect(lefttime , top=top+height, width, height)).background_(Color.black).string_("s1 time").stringColor_(Color.white);
						t2 = StaticText(~slideview, Rect(lefttime , top=top+height, width, height)).background_(Color.black).string_("s2 time").stringColor_(Color.white);
						t3 = StaticText(~slideview, Rect(lefttime , top=top+height, width, height)).background_(Color.black).string_("s3 time").stringColor_(Color.white);

						top = 0;

						stall=NumberBox(~slideview, Rect(lefttimebox , top=top, widthbox, heightbox)).background_(Color.black).normalColor_(Color.white;).value_(~slidetimeall).maxDecimals_(9);
						st1=NumberBox(~slideview, Rect(lefttimebox , top=top+heightbox, widthbox, heightbox)).background_(Color.black).normalColor_(Color.white;).value_(~slidetime1).maxDecimals_(9);
						st2=NumberBox(~slideview, Rect(lefttimebox , top=top+heightbox, widthbox, heightbox)).background_(Color.black).normalColor_(Color.white;).value_(~slidetime2).maxDecimals_(9);
						st3=NumberBox(~slideview, Rect(lefttimebox , top=top+heightbox, widthbox, heightbox)).background_(Color.black).normalColor_(Color.white;).value_(~slidetime3).maxDecimals_(9);

						top = 0;

						iall = StaticText(~slideview, Rect(leftdo , top=top, width, height)).background_(Color.black).string_("all incr").stringColor_(Color.white);
						i1 = StaticText(~slideview, Rect(leftdo , top=top+height, width, height)).background_(Color.black).string_("s1 incr").stringColor_(Color.white);
						i2 = StaticText(~slideview, Rect(leftdo , top=top+height, width, height)).background_(Color.black).string_("s2 incr").stringColor_(Color.white);
						i3 = StaticText(~slideview, Rect(leftdo , top=top+height, width, height)).background_(Color.black).string_("s3 incr").stringColor_(Color.white);

						top = 0;

						siall=NumberBox(~slideview, Rect(leftdobox , top=top, widthbox, heightbox)).background_(Color.black).normalColor_(Color.white;).value_(~slidedoall);
						si1=NumberBox(~slideview, Rect(leftdobox , top=top+heightbox, widthbox, heightbox)).background_(Color.black).normalColor_(Color.white;).value_(~slidedo1);
						si2=NumberBox(~slideview, Rect(leftdobox , top=top+heightbox, widthbox, heightbox)).background_(Color.black).normalColor_(Color.white;).value_(~slidedo2);
						si3=NumberBox(~slideview, Rect(leftdobox , top=top+heightbox, widthbox, heightbox)).background_(Color.black).normalColor_(Color.white;).value_(~slidedo3);

						stall.action_({arg val;
							~slidetimeall = val.value;
							~slidetime1 = val.value;
							~slidetime2 = val.value;
							~slidetime3 = val.value;
							~slideview.close; ~slidevals.valueAction_(1);
						});
						st1.action_({arg val; ~slidetime1 = val.value;});
						st2.action_({arg val; ~slidetime2 = val.value;});
						st3.action_({arg val; ~slidetime3 = val.value;});


						siall.action_({arg val;
							~slidedoall = val.value;
							~slidedo1 = val.value;
							~slidedo2 = val.value;
							~slidedo3 = val.value;
							~slideview.close; ~slidevals.valueAction_(1);
						});
						si1.action_({arg val; ~slidedo1 = val.value;});
						si2.action_({arg val; ~slidedo2 = val.value;});
						si3.action_({arg val; ~slidedo3 = val.value;});

						~slideview.background_(Color.black);

						~closeslidebutton = Button.new(~slideview,Rect(leftdobox+widthbox-40, top+40, 40, 40/~gm)).states_([["close",Color.white,Color.black]]).action_({arg button;

							~slideview.close; ~slidevals.value = 0;
						});

					}.value);

					~slideview.front;
				}, {~slideview.close;});
			});


			//set individual or all synth frequencies button

			~beforefreqsetfreqs = [ ~f1,~f2,~f3 ];

			~synthfreqset = Button.new(~extraoptionsview,Rect(0,0,120,20)).states_([["set frequencies",Color.white,Color.black],["set frequencies",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button;

				if(button.value == 1, {
					({
						arg  top = 0,width=88, revertwidth=75, height = 16,  heightbox = 16, lefttime = 0 , lefttimebox = width+5,  widthbox=165, leftdo = lefttimebox+widthbox+5, leftdobox = leftdo+57, inc=0, lw = 0,  uw = 0, numw = 40;
						var tall, stall, iall, siall, st1, st2, st3, st4, st5, st6, st7, st8, st9, st10, st11, st12, si1, si2, si3, si4, si5, si6, si7, si8, t1,t2,t3,t4,t5,t6,t7,t8,t9,t10,t11,t12,i1,i2,i3,i4,i5,i6,i7,i8,i9,i10,i11,i12;
						~synthfreqsetview = View(w, Rect(Window.screenBounds.width-(340+46),Window.screenBounds.height-(340+46/1.6180339887499)-150,340+46,380+46/1.6180339887499)).front;
						/*w.view.decorator=FlowLayout(w.view.bounds);
						w.view.decorator.gap=2@2;*/

						t1 = StaticText(~synthfreqsetview, Rect(lefttime , top=top, width, height)).background_(Color.black).string_("freq 1 (f1)").stringColor_(Color.white);
						t2 = StaticText(~synthfreqsetview, Rect(lefttime , top=top+height, width, height)).background_(Color.black).string_("freq 2 (f2)").stringColor_(Color.white);
						t3 = StaticText(~synthfreqsetview, Rect(lefttime , top=top+height, width, height)).background_(Color.black).string_("freq 3 (f3)").stringColor_(Color.white);
						tall = StaticText(~synthfreqsetview, Rect(lefttime , top=top+height+10, width, height)).background_(Color.black).string_("all freqs").stringColor_(Color.white);

						top = 0;

						st1=TextField(~synthfreqsetview, Rect(lefttimebox , top=top, widthbox, heightbox)).background_(Color.black).stringColor_(Color.white).value_(~f1);
						st2=TextField(~synthfreqsetview, Rect(lefttimebox , top=top+heightbox, widthbox, heightbox)).background_(Color.black).stringColor_(Color.white).value_(~f2);
						st3=TextField(~synthfreqsetview, Rect(lefttimebox , top=top+heightbox, widthbox, heightbox)).background_(Color.black).stringColor_(Color.white).value_(~f3);
						stall=TextField(~synthfreqsetview, Rect(lefttimebox , top=top+heightbox+10, widthbox, heightbox)).background_(Color.black).stringColor_(Color.white).value_(~f1);

						top = 0;

						i1 = Button.new(~synthfreqsetview, Rect(leftdo , top=top, revertwidth, height)).states_([["f1 revert",Color.white,Color.black],["f1 revert",Color.white,Color.black]]).action_({arg button; if(~f1_revert != nil, {if(~f1 != ~f1_revert, {~f1_un_revert = ~f1; ~f1 = ~f1_revert;}, {if(~f1_un_revert != nil, {~f1 = ~f1_un_revert;});}); ~synthflow.value; st1.string = ~f1.asString;});});
						i2 = Button.new(~synthfreqsetview, Rect(leftdo , top=top+height, revertwidth, height)).states_([["f2 revert",Color.white,Color.black],["f2 revert",Color.white,Color.black]]).action_({arg button; if(~f2_revert != nil, {if(~f2 != ~f2_revert, {~f2_un_revert = ~f2; ~f2 = ~f2_revert;}, {if(~f2_un_revert != nil, {~f2 = ~f2_un_revert;});}); ~synthflow.value; st2.string = ~f2.asString;});});
						i3 = Button.new(~synthfreqsetview, Rect(leftdo , top=top+height, revertwidth, height)).states_([["f3 revert",Color.white,Color.black],["f3 revert",Color.white,Color.black]]).action_({arg button; if(~f3_revert != nil, {if(~f3 != ~f3_revert, {~f3_un_revert = ~f3; ~f3 = ~f3_revert;}, {if(~f3_un_revert != nil, {~f3 = ~f3_un_revert;});}); ~synthflow.value; st3.string = ~f3.asString;});});
						iall = Button.new(~synthfreqsetview, Rect(leftdo , top=top+height+10, revertwidth, height)).states_([["all revert",Color.white,Color.black],["all revert",Color.white,Color.black]]).action_({arg button; if(~f_all_revert != nil, {if([ ~f1,~f2,~f3 ] != ~f_all_revert.flatten, {~f_all_un_revert = [ ~f1,~f2,~f3 ].flatten; 8.do(x = 0; {("f"++(x=x+1)).asSymbol.envirPut(~f_all_revert.flatten.at(x-1);)});}, {if(~f_all_un_revert != nil, {8.do(x = 0; {("f"++(x=x+1)).asSymbol.envirPut(~f_all_un_revert.flatten.at(x-1);)});});}); ~synthflow.value; stall.string = ~f1.asString;});});


						stall.action_({arg val; ~freqsetvalue = val.value; ~freqset_textfield_func.value; ~f_all_revert = [ ~f1,~f2,~f3 ]; 8.do(x = 0; {("f"++(x=x+1)).asSymbol.envirPut(~freqsetvalue;)}); ~synthflow.value; stall.string = ~freqsetvalue.asString;});
						st1.action_({arg val; ~freqsetvalue = val.value; ~freqset_textfield_func.value; ~f1_revert = ~f1; ~f1 = ~freqsetvalue; ~synthflow.value; st1.string = ~freqsetvalue.asString;});
						st2.action_({arg val; ~freqsetvalue = val.value; ~freqset_textfield_func.value; ~f2_revert = ~f2; ~f2 = ~freqsetvalue; ~synthflow.value; st2.string = ~freqsetvalue.asString;});
						st3.action_({arg val; ~freqsetvalue = val.value; ~freqset_textfield_func.value; ~f3_revert = ~f3; ~f3 = ~freqsetvalue; ~synthflow.value; st3.string = ~freqsetvalue.asString;});

						~synthfreqsetview.background_(Color.black);

						~closesfreqsetbutton = Button.new(~synthfreqsetview,Rect(leftdo+revertwidth-40, top=top+height+20, 40, 40/~gm)).states_([["close",Color.white,Color.black]]).action_({arg button;

							~synthfreqsetview.close;
						});

						~beforefreqsetrevert = Button.new(~synthfreqsetview,Rect(lefttime, top+(40/~gm)-height, revertwidth+150, height)).states_([["restore freqs before opening eo",Color.white,Color.black],["revert",Color.white,Color.black]]).action_({arg button;

							if([ ~f1,~f2,~f3 ] != ~beforefreqsetfreqs.flatten, {~beforefreqsetfreqs_unrestore = [ ~f1,~f2,~f3 ]; 8.do(x = 0; {("f"++(x=x+1)).asSymbol.envirPut(~beforefreqsetfreqs.flatten.at(x-1);)});}, {if(~beforefreqsetfreqs_unrestore != nil, {8.do(x = 0; {("f"++(x=x+1)).asSymbol.envirPut(~beforefreqsetfreqs_unrestore.flatten.at(x-1);)});});}); ~synthflow.value;
						});


					}.value);

					~synthfreqsetview.front;
				}, {~synthfreqsetview.close});
			});


			Button.new(~extraoptionsview,Rect(0,80,120,20)).states_([["close eo",Color.white,Color.black],["close eo",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button;

				~extraoptionsview.close; ~slideview.close; ~synthfreqsetview.close; ~extraoptions.value = 0;

			});

		}, {~extraoptionsview.close; ~slideview.close; ~synthfreqset.close;});
	});


	//mute/unmute 1-8 buttons

	mute1 = Button.new(w,Rect(~bpl+(16*1),~bpt+69+5,16,16/1.6180339887499)).states_([["1",Color.white,Color.black],["",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button;
		case
		{~l1a1.isRunning == true}{
			if(button.value == 0, {
				(~vol1 = ~vol;
					1.do({
						~l1a1.set(\vol, ~vol1);  ~l1b1.set(\vol, ~vol1);
						~l1c1.set(\vol, ~vol1);  ~l1d1.set(\vol, ~vol1);
						~l1e1.set(\vol, ~vol1);  ~l1f1.set(\vol, ~vol1);

				}););
			}, {(~vol1 = 0;
				1.do({
					~l1a1.set(\vol, ~vol1);  ~l1b1.set(\vol, ~vol1);
					~l1c1.set(\vol, ~vol1);  ~l1d1.set(\vol, ~vol1);
					~l1e1.set(\vol, ~vol1);  ~l1f1.set(\vol, ~vol1);

			}););
			});
		}
		{~l1a.isRunning == true}{
			if(button.value == 0, {
				(~vol1 = ~vol;
					1.do({
						~l1a.set(\vol, ~vol1);  ~l1b.set(\vol, ~vol1);
						~l1c.set(\vol, ~vol1);  ~l1d.set(\vol, ~vol1);
						~l1e.set(\vol, ~vol1);  ~l1f.set(\vol, ~vol1);

				}););
			}, {(~vol1 = 0;
				1.do({
					~l1a.set(\vol, ~vol1);  ~l1b.set(\vol, ~vol1);
					~l1c.set(\vol, ~vol1);  ~l1d.set(\vol, ~vol1);
					~l1e.set(\vol, ~vol1);  ~l1f.set(\vol, ~vol1);

			}););
			});
		};
	});

	mute2 = Button.new(w,Rect(~bpl+(16*2),~bpt+69+5,16,16/1.6180339887499)).states_([["2",Color.white,Color.black],["",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button;
		case
		{~l1a1.isRunning == true}{
			if(button.value == 0, {
				(~vol2 = ~vol;
					1.do({
						~l2a1.set(\vol, ~vol2);  ~l2b1.set(\vol, ~vol2);
						~l2c1.set(\vol, ~vol2);  ~l2d1.set(\vol, ~vol2);
						~l2e1.set(\vol, ~vol2);  ~l2f1.set(\vol, ~vol2);

				}););
			}, {(~vol2 = 0;
				1.do({
					~l2a1.set(\vol, ~vol2);  ~l2b1.set(\vol, ~vol2);
					~l2c1.set(\vol, ~vol2);  ~l2d1.set(\vol, ~vol2);
					~l2e1.set(\vol, ~vol2);  ~l2f1.set(\vol, ~vol2);

			}););
			});
		}
		{~l1a.isRunning == true}{
			if(button.value == 0, {
				(~vol2 = ~vol;
					1.do({
						~l2a.set(\vol, ~vol2);  ~l2b.set(\vol, ~vol2);
						~l2c.set(\vol, ~vol2);  ~l2d.set(\vol, ~vol2);
						~l2e.set(\vol, ~vol2);  ~l2f.set(\vol, ~vol2);

				}););
			}, {(~vol2 = 0;
				1.do({
					~l2a.set(\vol, ~vol2);  ~l2b.set(\vol, ~vol2);
					~l2c.set(\vol, ~vol2);  ~l2d.set(\vol, ~vol2);
					~l2e.set(\vol, ~vol2);  ~l2f.set(\vol, ~vol2);

			}););
			});
		};
	});
	mute3 = Button.new(w,Rect(~bpl+(16*3),~bpt+69+5,16,16/1.6180339887499)).states_([["3",Color.white,Color.black],["",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button;
		case
		{~l1a1.isRunning == true}{
			if(button.value == 0, {
				(~vol3 = ~vol;
					1.do({
						~l3a1.set(\vol, ~vol3);  ~l3b1.set(\vol, ~vol3);
						~l3c1.set(\vol, ~vol3);  ~l3d1.set(\vol, ~vol3);
						~l3e1.set(\vol, ~vol3);  ~l3f1.set(\vol, ~vol3);

				}););
			}, {(~vol3 = 0;
				1.do({
					~l3a1.set(\vol, ~vol3);  ~l3b1.set(\vol, ~vol3);
					~l3c1.set(\vol, ~vol3);  ~l3d1.set(\vol, ~vol3);
					~l3e1.set(\vol, ~vol3);  ~l3f1.set(\vol, ~vol3);

			}););
			});
		}
		{~l1a.isRunning == true}{
			if(button.value == 0, {
				(~vol3 = ~vol;
					1.do({
						~l3a.set(\vol, ~vol3);  ~l3b.set(\vol, ~vol3);
						~l3c.set(\vol, ~vol3);  ~l3d.set(\vol, ~vol3);
						~l3e.set(\vol, ~vol3);  ~l3f.set(\vol, ~vol3);

				}););
			}, {(~vol3 = 0;
				1.do({
					~l3a.set(\vol, ~vol3);  ~l3b.set(\vol, ~vol3);
					~l3c.set(\vol, ~vol3);  ~l3d.set(\vol, ~vol3);
					~l3e.set(\vol, ~vol3);  ~l3f.set(\vol, ~vol3);

			}););
			});
		};
	});


	//mute/unmute all button

	muteall = Button.new(w,Rect(~bpl+(0),~bpt+69+5,16,16/1.6180339887499)).states_([["m",Color.white,Color.black],["u",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button;

		if(button.value == 0, {
			mute1.value = 0;
			mute2.value = 0;
			mute3.value = 0;

			~vol1 = ~vol;
			~vol2 = ~vol;
			~vol3 = ~vol;

		},
		{
			mute1.value = 1;
			mute2.value = 1;
			mute3.value = 1;

			~vol1 = 0;
			~vol2 = 0;
			~vol3 = 0;

		});
		~synthflow.value;
	});


	//midi Korg NanoKontrol function

	~midifunc = {
		~snb = 0;
		/*~etemp = EqualTemperament(12, calibratefreq: 432, calibratenote: 69);*/


		//midi set frequency

		MIDIFunc.cc({if(~snb == 0, {~snb = 1},{~snb = 0});}, ccNum: 60);
		MIDIdef.cc('l1', { |val|
			case
			{~l1a.isRunning == true}{
				~l1a.set(\dur, ~f1 = \dur.asSpec.map(val / 127));
				~l1b.set(\dur,      \dur.asSpec.map(val / 127));
				~l1c.set(\dur,      \dur.asSpec.map(val / 127)/~icd3);
				~l1d.set(\dur,      \dur.asSpec.map(val / 127)/~icd3);
				~l1e.set(\dur,      \dur.asSpec.map(val / 127)/~icd6);
				~l1f.set(\dur,      \dur.asSpec.map(val / 127)/~icd6);
			}{~l1a1.isRunning == true}{
				~l1a1.set(\dur, ~f1 = \dur.asSpec.map(val / 127));
				~l1b1.set(\dur,      \dur.asSpec.map(val / 127));
				~l1c1.set(\dur,      \dur.asSpec.map(val / 127)/~icd3);
				~l1d1.set(\dur,      \dur.asSpec.map(val / 127)/~icd3);
				~l1e1.set(\dur,      \dur.asSpec.map(val / 127)/~icd6);
				~l1f1.set(\dur,      \dur.asSpec.map(val / 127)/~icd6);
			};
			~tunefreq1 = ~f1; ~f1 = ~f1+~f1t;
			{if((~f1 > ~outmaxa) or: (~f1 < ~outmina), {~z25.close;~z1.close;~z25 = (View(w, Rect((~f1.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+10, ~nw, 2)).background = Color.white;);}, {~z1.close;~z25.close;~z1 = (View(w, Rect((~f1.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+10, ~nw, 2)).background = Color.white;);});
			}.defer;
		}, ccNum: [0]);
		MIDIdef.cc('l2', { |val|
			case
			{~l1a.isRunning == true}{
				~l2a.set(\dur, ~f2 = \dur.asSpec.map(val / 127));
				~l2b.set(\dur,      \dur.asSpec.map(val / 127));
				~l2c.set(\dur,      \dur.asSpec.map(val / 127)/~icd3);
				~l2d.set(\dur,      \dur.asSpec.map(val / 127)/~icd3);
				~l2e.set(\dur,      \dur.asSpec.map(val / 127)/~icd6);
				~l2f.set(\dur,      \dur.asSpec.map(val / 127)/~icd6);
			}{~l1a1.isRunning == true}{
				~l2a1.set(\dur, ~f2 = \dur.asSpec.map(val / 127));
				~l2b1.set(\dur,      \dur.asSpec.map(val / 127));
				~l2c1.set(\dur,      \dur.asSpec.map(val / 127)/~icd3);
				~l2d1.set(\dur,      \dur.asSpec.map(val / 127)/~icd3);
				~l2e1.set(\dur,      \dur.asSpec.map(val / 127)/~icd6);
				~l2f1.set(\dur,      \dur.asSpec.map(val / 127)/~icd6);
			};
			~tunefreq2 = ~f2; ~f2 = ~f2+~f2t;
			{if((~f2 > ~outmaxa) or: (~f2 < ~outmina), {~z26.close;~z2.close;~z26 = (View(w, Rect((~f2.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+20, ~nw, 2)).background = Color.white;);}, {~z2.close;~z26.close;~z2 = (View(w, Rect((~f2.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+20, ~nw, 2)).background = Color.white;);});
			}.defer;
		}, ccNum: [1]);
		MIDIdef.cc('l3', { |val|
			case
			{~l1a.isRunning == true}{
				~l3a.set(\dur, ~f3 = \dur.asSpec.map(val / 127));
				~l3b.set(\dur,      \dur.asSpec.map(val / 127));
				~l3c.set(\dur,      \dur.asSpec.map(val / 127)/~icd3);
				~l3d.set(\dur,      \dur.asSpec.map(val / 127)/~icd3);
				~l3e.set(\dur,      \dur.asSpec.map(val / 127)/~icd6);
				~l3f.set(\dur,      \dur.asSpec.map(val / 127)/~icd6);
			}{~l1a1.isRunning == true}{
				~l3a1.set(\dur, ~f3 = \dur.asSpec.map(val / 127));
				~l3b1.set(\dur,      \dur.asSpec.map(val / 127));
				~l3c1.set(\dur,      \dur.asSpec.map(val / 127)/~icd3);
				~l3d1.set(\dur,      \dur.asSpec.map(val / 127)/~icd3);
				~l3e1.set(\dur,      \dur.asSpec.map(val / 127)/~icd6);
				~l3f1.set(\dur,      \dur.asSpec.map(val / 127)/~icd6);
			};
			~tunefreq3 = ~f3; ~f3 = ~f3+~f3t;
			{if((~f3 > ~outmaxa) or: (~f3 < ~outmina), {~z27.close;~z3.close;~z27 = (View(w, Rect((~f3.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+30, ~nw, 2)).background = Color.white;);}, {~z3.close;~z27.close;~z3 = (View(w, Rect((~f3.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+30, ~nw, 2)).background = Color.white;);});
			}.defer;
		}, ccNum: 2);


		//if midi tuning frequency values are nil

		if(~f1t == nil, {~f1t = 0});
		if(~f2t == nil, {~f2t = 0});
		if(~f3t == nil, {~f3t = 0});


		//midi set tuning frequency

		MIDIFunc.cc({|val|
			~f1 = ~f1-~f1t;
			Spec.add(\tune, ([0, ~tunefreq1*~stepratio-~tunefreq1, \lin]));
			case
			{~l1a.isRunning == true}{
				~l1a.set(\tune, ~f1t = \tune.asSpec.map(val / 127));
				~l1b.set(\tune,      \tune.asSpec.map(val / 127));
				~l1c.set(\tune,      \tune.asSpec.map(val / 127)/~icd3);
				~l1d.set(\tune,      \tune.asSpec.map(val / 127)/~icd3);
				~l1e.set(\tune,      \tune.asSpec.map(val / 127)/~icd6);
				~l1f.set(\tune,      \tune.asSpec.map(val / 127)/~icd6);
			}{~l1a1.isRunning == true}{
				~l1a1.set(\tune, ~f1t = \tune.asSpec.map(val / 127));
				~l1b1.set(\tune,      \tune.asSpec.map(val / 127));
				~l1c1.set(\tune,      \tune.asSpec.map(val / 127)/~icd3);
				~l1d1.set(\tune,      \tune.asSpec.map(val / 127)/~icd3);
				~l1e1.set(\tune,      \tune.asSpec.map(val / 127)/~icd6);
				~l1f1.set(\tune,      \tune.asSpec.map(val / 127)/~icd6);
			};
			~f1 = ~f1+~f1t;
			{if((~f1 > ~outmaxa) or: (~f1 < ~outmina), {~z25.close;~z1.close;~z25 = (View(w, Rect((~f1.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+10, ~nw, 2)).background = Color.white;);}, {~z1.close;~z25.close;~z1 = (View(w, Rect((~f1.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+10, ~nw, 2)).background = Color.white;);});
			}.defer;
		}, ccNum: 16);
		MIDIFunc.cc({|val|
			~f2 = ~f2-~f2t;
			Spec.add(\tune, ([0, ~tunefreq2*~stepratio-~tunefreq2, \lin]));
			case
			{~l1a.isRunning == true}{
				~l2a.set(\tune, ~f2t = \tune.asSpec.map(val / 127));
				~l2b.set(\tune,      \tune.asSpec.map(val / 127));
				~l2c.set(\tune,      \tune.asSpec.map(val / 127)/~icd3);
				~l2d.set(\tune,      \tune.asSpec.map(val / 127)/~icd3);
				~l2e.set(\tune,      \tune.asSpec.map(val / 127)/~icd6);
				~l2f.set(\tune,      \tune.asSpec.map(val / 127)/~icd6);
			}{~l1a1.isRunning == true}{
				~l2a1.set(\tune, ~f2t = \tune.asSpec.map(val / 127));
				~l2b1.set(\tune,      \tune.asSpec.map(val / 127));
				~l2c1.set(\tune,      \tune.asSpec.map(val / 127)/~icd3);
				~l2d1.set(\tune,      \tune.asSpec.map(val / 127)/~icd3);
				~l2e1.set(\tune,      \tune.asSpec.map(val / 127)/~icd6);
				~l2f1.set(\tune,      \tune.asSpec.map(val / 127)/~icd6);
			};
			~f2 = ~f2+~f2t;
			{if((~f2 > ~outmaxa) or: (~f2 < ~outmina), {~z26.close;~z2.close;~z26 = (View(w, Rect((~f2.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+20, ~nw, 2)).background = Color.white;);}, {~z2.close;~z26.close;~z2 = (View(w, Rect((~f2.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+20, ~nw, 2)).background = Color.white;);});
			}.defer;
		}, ccNum: 17);
		MIDIFunc.cc({|val|
			~f3 = ~f3-~f3t;
			Spec.add(\tune, ([0, ~tunefreq3*~stepratio-~tunefreq3, \lin]));
			case
			{~l1a.isRunning == true}{
				~l3a.set(\tune, ~f3t = \tune.asSpec.map(val / 127));
				~l3b.set(\tune,      \tune.asSpec.map(val / 127));
				~l3c.set(\tune,      \tune.asSpec.map(val / 127)/~icd3);
				~l3d.set(\tune,      \tune.asSpec.map(val / 127)/~icd3);
				~l3e.set(\tune,      \tune.asSpec.map(val / 127)/~icd6);
				~l3f.set(\tune,      \tune.asSpec.map(val / 127)/~icd6);
			}{~l1a1.isRunning == true}{
				~l3a1.set(\tune, ~f3t = \tune.asSpec.map(val / 127));
				~l3b1.set(\tune,      \tune.asSpec.map(val / 127));
				~l3c1.set(\tune,      \tune.asSpec.map(val / 127)/~icd3);
				~l3d1.set(\tune,      \tune.asSpec.map(val / 127)/~icd3);
				~l3e1.set(\tune,      \tune.asSpec.map(val / 127)/~icd6);
				~l3f1.set(\tune,      \tune.asSpec.map(val / 127)/~icd6);
			};
			~f3 = ~f3+~f3t;
			{if((~f3 > ~outmaxa) or: (~f3 < ~outmina), {~z27.close;~z3.close;~z27 = (View(w, Rect((~f3.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+30, ~nw, 2)).background = Color.white;);}, {~z3.close;~z27.close;~z3 = (View(w, Rect((~f3.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+30, ~nw, 2)).background = Color.white;);});
			}.defer;
		}, ccNum: 18);


		//Korg NanoKontrol button assignments


		//start/stop synth and pause/unpause synth buttons

		MIDIFunc.cc({|val| {case{b3.value == 0}{b3.valueAction = 1};}.defer;}, ccNum: 41);
		MIDIFunc.cc({|val| {case{b3.value == 1}{b3.valueAction = 0};}.defer;}, ccNum: 42);
		MIDIFunc.cc({|val| {case{b4.value == 0}{b4.valueAction = 1};}.defer;}, ccNum: 43);
		MIDIFunc.cc({|val| {case{b4.value == 1}{b4.valueAction = 0};}.defer;}, ccNum: 44);


		//open/flow/slide buttons (inactive)

		/*MIDIFunc.cc({|val| {~bplaceo1.valueAction=0}.defer;}, ccNum: 32);
		MIDIFunc.cc({|val| {~bplaceo2.valueAction=0}.defer;}, ccNum: 33);
		MIDIFunc.cc({|val| {~bplaceo3.valueAction=0}.defer;}, ccNum: 34);
		MIDIFunc.cc({|val| {~bplaceo4.valueAction=0}.defer;}, ccNum: 35);
		MIDIFunc.cc({|val| {~bplaceo5.valueAction=0}.defer;}, ccNum: 36);
		MIDIFunc.cc({|val| {~bplaceo6.valueAction=0}.defer;}, ccNum: 37);
		MIDIFunc.cc({|val| {~bplaceo7.valueAction=0}.defer;}, ccNum: 38);
		MIDIFunc.cc({|val| {~bplaceo8.valueAction=0}.defer;}, ccNum: 39);
		MIDIFunc.cc({|val| {~bplacef1.valueAction=0}.defer;}, ccNum: 48);
		MIDIFunc.cc({|val| {~bplacef2.valueAction=0}.defer;}, ccNum: 49);
		MIDIFunc.cc({|val| {~bplacef3.valueAction=0}.defer;}, ccNum: 50);
		MIDIFunc.cc({|val| {~bplacef4.valueAction=0}.defer;}, ccNum: 51);
		MIDIFunc.cc({|val| {~bplacef5.valueAction=0}.defer;}, ccNum: 52);
		MIDIFunc.cc({|val| {~bplacef6.valueAction=0}.defer;}, ccNum: 53);
		MIDIFunc.cc({|val| {~bplacef7.valueAction=0}.defer;}, ccNum: 54);
		MIDIFunc.cc({|val| {~bplacef8.valueAction=0}.defer;}, ccNum: 55);
		MIDIFunc.cc({|val| {~bplaces1.valueAction=0}.defer;}, ccNum: 64);
		MIDIFunc.cc({|val| {~bplaces2.valueAction=0}.defer;}, ccNum: 65);
		MIDIFunc.cc({|val| {~bplaces3.valueAction=0}.defer;}, ccNum: 66);
		MIDIFunc.cc({|val| {~bplaces4.valueAction=0}.defer;}, ccNum: 67);
		MIDIFunc.cc({|val| {~bplaces5.valueAction=0}.defer;}, ccNum: 68);
		MIDIFunc.cc({|val| {~bplaces6.valueAction=0}.defer;}, ccNum: 69);
		MIDIFunc.cc({|val| {~bplaces7.valueAction=0}.defer;}, ccNum: 70);
		MIDIFunc.cc({|val| {~bplaces8.valueAction=0}.defer;}, ccNum: 71);
		*/


		//mute/unmute buttons

		MIDIFunc.cc({|val| {mute1.valueAction = 1;}.defer;}, ccNum: 48);
		MIDIFunc.cc({|val| {mute2.valueAction = 1;}.defer;}, ccNum: 49);
		MIDIFunc.cc({|val| {mute3.valueAction = 1;}.defer;}, ccNum: 50);
		MIDIFunc.cc({|val| {mute1.valueAction = 1;mute2.valueAction = 1;mute3.valueAction = 1;}.defer;}, ccNum: 58);
		MIDIFunc.cc({|val| {mute1.valueAction = 0;}.defer;}, ccNum: 32);
		MIDIFunc.cc({|val| {mute2.valueAction = 0;}.defer;}, ccNum: 33);
		MIDIFunc.cc({|val| {mute3.valueAction = 0;}.defer;}, ccNum: 34);
		MIDIFunc.cc({|val| {mute1.valueAction = 0;mute2.valueAction = 0;mute3.valueAction = 0;}.defer;}, ccNum: 59);

		/*MIDIFunc.cc({ |val| ([~a2,~b2,~c2,~d2,~e2,~f2]).postln;}, ccNum: [0]);*/
		/*MIDIFunc.cc({ |val|~l1.set(\tune, 0);}, ccNum: [32]);*/
		/*MIDIFunc.cc({ |val| ([(~w),(~x),(~y),(~z),(~u),(~v),~r,~s]).postln;}, ccNum: [64]);*/
		/*~basefreq= 432.cpsmidi-69;*/
		/*Spec.add(\dur, ~etemp.cps([0, 127, \exp]));*/

		Spec.add(\dur, ([~freqmap.at(0), ~freqmap.at(127), \exp]));
		/*Spec.add(\tune, ([0, 128, \lin]));*/
	};


	//evaluate midi function

	~midifunc.value;


	//keyboard number buttons to choose synth

	keycodeb = Button.new(w,Rect(Window.screenBounds.width-20-16,~bpt+160,16,16/1.6180339887499)).states_([
		["1",Color.white,Color.black],
		["2",Color.white,Color.black],
		["3",Color.white,Color.black]]).action_({arg button;

		case
		{button.value == 0}{
			~z25.background = Color.green; ~z1.background = Color.green;
			~z26.background = Color.white; ~z2.background = Color.white;
			~z27.background = Color.white; ~z3.background = Color.white;
		}
		{button.value == 1}{
			~z25.background = Color.white; ~z1.background = Color.white;
			~z26.background = Color.green; ~z2.background = Color.green;
			~z27.background = Color.white; ~z3.background = Color.white;
		}
		{button.value == 2}{
			~z25.background = Color.white; ~z1.background = Color.white;
			~z26.background = Color.white; ~z2.background = Color.white;
			~z27.background = Color.green; ~z3.background = Color.green;
		};
	});


	//misc. keyboard buttons

	w.view.keyDownAction = { arg view, char, modifiers, unicode, keycode;
		[char, modifiers, unicode, keycode];

		//copy
		if(unicode == ~c_unicode, {
			case
			{b.value == 0}{b.valueAction = 1}
			{b.value == 1}{b.valueAction = 0};
		});

		//start/stop synth
		if(unicode == ~s_unicode, {
			case
			{b3.value == 0}{b3.valueAction = 1}
			{b3.value == 1}{b3.valueAction = 0};
		});

		//pause/unpause synth
		if(unicode == ~spacebar_unicode, {
			case
			{b4.value == 0}{b4.valueAction = 1}
			{b4.value == 1}{b4.valueAction = 0};
		});

		//timer function
		if(unicode == ~t_unicode, {
			case
			{~ts.value == 0}{~ts.valueAction = 1}
			{~ts.value == 1}{~ts.valueAction = 0};
		});

		//routine function
		if(unicode == ~r_unicode, {
			case
			{~rviewbutton.value == 0}{~rviewbutton.valueAction = 1}
			{~rviewbutton.value == 1}{~rviewbutton.valueAction = 0};
		});

		//mute/unmute all synths
		if(unicode == ~m_unicode, {
			case
			{muteall.value == 0}{muteall.valueAction = 1}
			{muteall.value == 1}{muteall.valueAction = 0};
		});

		//minimize GUI window
		if(unicode == ~escape_unicode, {w.minimize;

			~fullscreen_correct = {w.fullScreen};
			~fscview = UserView(w, Rect(0,0, Window.screenBounds.width-100, Window.screenBounds.height;));
			~fullscreen_button = Button.new(w,Rect(Window.screenBounds.width/2-35,Window.screenBounds.height/2+120,150,20)).states_([["re-adjust to fullscreen",Color.white,Color.black]]).action_({arg button; w.fullScreen; ~fullscreen_button.close; ~fullscreen_button = nil;});
			~fscview.mouseEnterAction_{|v, x, y| ~fullscreen_correct.value; ~fullscreen_correct = nil; ~fscview.close; ~fscview = nil; ~fullscreen_button.close; ~fullscreen_button = nil;};
		});

		/*if((unicode == ~escape_unicode) and: (info.isClosed == false), {info.close;});
		if((unicode == ~escape_unicode) and: (b.isClosed == false), {b.close;});

		//minimize GUI window
		if((unicode == ~escape_unicode) and: (((b.isClosed == true) and: (info.isClosed == true)) or: ((b.isClosed == true)) or: (info.isClosed == true)), {w.minimize;});
		*/
		/*if(unicode == ~escape_unicode , {
		if((b.isClosed == true) and: (info.isClosed == true), {~min.value});
		if(info.isClosed == false, {info.valueAction  = 0;});
		if(b.isClosed == false, {b.valueAction = 0;});
		});*/


		//keyboard number actions

		case
		{unicode == ~one_unicode}{keycodeb.valueAction_(0)}
		{unicode == ~two_unicode}{keycodeb.valueAction_(1)}
		{unicode == ~three_unicode}{keycodeb.valueAction_(2)}


		//keyboard up/down arrow actions

		{(keycode == ~uparrow_keycode) or: (unicode == ~i_unicode)}{keycodeb.valueAction_(keycodeb.value-1)}
		{(keycode == ~downarrow_keycode) or: (unicode == ~k_unicode)}{keycodeb.valueAction_(keycodeb.value+1)};


		//set synth frequency using left/right arrow keys or j/l keys

		if((~f1 >= ~freqmap.at(127)), {~freqmap.at(127)},
			{if((keycodeb.value == 0) and: (((keycode == ~rightarrow_keycode) or: (keycode == ~rightarrow_keycode1)) or: (unicode == ~l_unicode)), {
				~freqmapval1 = ~f1.cpsmidi.round;
				case
				{~l1a.isRunning == true}{
					~l1a.set(\dur, ~f1 = ~freqmap.at(~freqmapval1 = ~freqmapval1.value+1));
					~l1b.set(\dur, ~f1);
					~l1c.set(\dur, ~f1/~icd3);
					~l1d.set(\dur, ~f1/~icd3);
					~l1e.set(\dur, ~f1/~icd6);
					~l1f.set(\dur, ~f1/~icd6);
				}
				{~l1a1.isRunning == true}{
					~l1a1.set(\dur, ~f1 = ~freqmap.at(~freqmapval1 = ~freqmapval1.value+1));
					~l1b1.set(\dur, ~f1);
					~l1c1.set(\dur, ~f1/~icd3);
					~l1d1.set(\dur, ~f1/~icd3);
					~l1e1.set(\dur, ~f1/~icd6);
					~l1f1.set(\dur, ~f1/~icd6);
				};
				if((~f1 > ~outmaxa) or: (~f1 < ~outmina), {~z25.close;~z1.close;~z25 = (View(w, Rect((~f1.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+10, ~nw, 2)).background = Color.white;);}, {~z1.close;~z25.close;~z1 = (View(w, Rect((~f1.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+10, ~nw, 2)).background = Color.white;);});
				~z25.background = Color.green; ~z1.background = Color.green;
				~z26.background = Color.white; ~z2.background = Color.white;
				~z27.background = Color.white; ~z3.background = Color.white;
		});});
		if((~f1 <= ~freqmap.at(0)), {~freqmap.at(0)},
			{if((keycodeb.value == 0) and: (((keycode == ~leftarrow_keycode) or: (keycode == ~leftarrow_keycode1)) or: (unicode == ~j_unicode)), {
				~freqmapval1 = ~f1.cpsmidi.round;
				case
				{~l1a.isRunning == true}{
					~l1a.set(\dur, ~f1 = ~freqmap.at(~freqmapval1 = ~freqmapval1.value-1));
					~l1b.set(\dur, ~f1);
					~l1c.set(\dur, ~f1/~icd3);
					~l1d.set(\dur, ~f1/~icd3);
					~l1e.set(\dur, ~f1/~icd6);
					~l1f.set(\dur, ~f1/~icd6);
				}
				{~l1a1.isRunning == true}{
					~l1a1.set(\dur, ~f1 = ~freqmap.at(~freqmapval1 = ~freqmapval1.value-1));
					~l1b1.set(\dur, ~f1);
					~l1c1.set(\dur, ~f1/~icd3);
					~l1d1.set(\dur, ~f1/~icd3);
					~l1e1.set(\dur, ~f1/~icd6);
					~l1f1.set(\dur, ~f1/~icd6);
				};
				if((~f1 > ~outmaxa) or: (~f1 < ~outmina), {~z25.close;~z1.close;~z25 = (View(w, Rect((~f1.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+10, ~nw, 2)).background = Color.white;);}, {~z1.close;~z25.close;~z1 = (View(w, Rect((~f1.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+10, ~nw, 2)).background = Color.white;);});

				~z25.background = Color.green; ~z1.background = Color.green;
				~z26.background = Color.white; ~z2.background = Color.white;
				~z27.background = Color.white; ~z3.background = Color.white;
				~z28.background = Color.white; ~z4.background = Color.white;
		});});

		if((~f2 >= ~freqmap.at(127)), {~freqmap.at(127)},
			{if((keycodeb.value == 1) and: (((keycode == ~rightarrow_keycode) or: (keycode == ~rightarrow_keycode1)) or: (unicode == ~l_unicode)), {
				~freqmapval2 = ~f2.cpsmidi.round;
				case
				{~l1a.isRunning == true}{
					~l2a.set(\dur, ~f2 = ~freqmap.at(~freqmapval2 = ~freqmapval2.value+1));
					~l2b.set(\dur, ~f2);
					~l2c.set(\dur, ~f2/~icd3);
					~l2d.set(\dur, ~f2/~icd3);
					~l2e.set(\dur, ~f2/~icd6);
					~l2f.set(\dur, ~f2/~icd6);
				}
				{~l1a1.isRunning == true}{
					~l2a1.set(\dur, ~f2 = ~freqmap.at(~freqmapval2 = ~freqmapval2.value+1));
					~l2b1.set(\dur, ~f2);
					~l2c1.set(\dur, ~f2/~icd3);
					~l2d1.set(\dur, ~f2/~icd3);
					~l2e1.set(\dur, ~f2/~icd6);
					~l2f1.set(\dur, ~f2/~icd6);
				};
				if((~f2 > ~outmaxa) or: (~f2 < ~outmina), {~z26.close;~z2.close;~z26 = (View(w, Rect((~f2.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+20, ~nw, 2)).background = Color.white;);}, {~z2.close;~z26.close;~z2 = (View(w, Rect((~f2.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+20, ~nw, 2)).background = Color.white;);});
				~z25.background = Color.white; ~z1.background = Color.white;
				~z26.background = Color.green; ~z2.background = Color.green;
				~z27.background = Color.white; ~z3.background = Color.white;
		});});
		if((~f2 <= ~freqmap.at(0)), {~freqmap.at(0)},
			{if((keycodeb.value == 1) and: (((keycode == ~leftarrow_keycode) or: (keycode == ~leftarrow_keycode1)) or: (unicode == ~j_unicode)), {
				~freqmapval2 = ~f2.cpsmidi.round;
				case
				{~l1a.isRunning == true}{
					~l2a.set(\dur, ~f2 = ~freqmap.at(~freqmapval2 = ~freqmapval2.value-1));
					~l2b.set(\dur, ~f2);
					~l2c.set(\dur, ~f2/~icd3);
					~l2d.set(\dur, ~f2/~icd3);
					~l2e.set(\dur, ~f2/~icd6);
					~l2f.set(\dur, ~f2/~icd6);
				}
				{~l1a1.isRunning == true}{
					~l2a1.set(\dur, ~f2 = ~freqmap.at(~freqmapval2 = ~freqmapval2.value-1));
					~l2b1.set(\dur, ~f2);
					~l2c1.set(\dur, ~f2/~icd3);
					~l2d1.set(\dur, ~f2/~icd3);
					~l2e1.set(\dur, ~f2/~icd6);
					~l2f1.set(\dur, ~f2/~icd6);
				};
				if((~f2 > ~outmaxa) or: (~f2 < ~outmina), {~z26.close;~z2.close;~z26 = (View(w, Rect((~f2.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+20, ~nw, 2)).background = Color.white;);}, {~z2.close;~z26.close;~z2 = (View(w, Rect((~f2.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+20, ~nw, 2)).background = Color.white;);});

				~z25.background = Color.white; ~z1.background = Color.white;
				~z26.background = Color.green; ~z2.background = Color.green;
				~z27.background = Color.white; ~z3.background = Color.white;
		});});

		if((~f3 >= ~freqmap.at(127)), {~freqmap.at(127)},
			{if((keycodeb.value == 2) and: (((keycode == ~rightarrow_keycode) or: (keycode == ~rightarrow_keycode1)) or: (unicode == ~l_unicode)), {
				~freqmapval3 = ~f3.cpsmidi.round;
				case
				{~l1a.isRunning == true}{
					~l3a.set(\dur, ~f3 = ~freqmap.at(~freqmapval3 = ~freqmapval3.value+1));
					~l3b.set(\dur, ~f3);
					~l3c.set(\dur, ~f3/~icd3);
					~l3d.set(\dur, ~f3/~icd3);
					~l3e.set(\dur, ~f3/~icd6);
					~l3f.set(\dur, ~f3/~icd6);
				}
				{~l1a1.isRunning == true}{
					~l3a1.set(\dur, ~f3 = ~freqmap.at(~freqmapval3 = ~freqmapval3.value+1));
					~l3b1.set(\dur, ~f3);
					~l3c1.set(\dur, ~f3/~icd3);
					~l3d1.set(\dur, ~f3/~icd3);
					~l3e1.set(\dur, ~f3/~icd6);
					~l3f1.set(\dur, ~f3/~icd6);
				};
				if((~f3 > ~outmaxa) or: (~f3 < ~outmina), {~z27.close;~z3.close;~z27 = (View(w, Rect((~f3.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+30, ~nw, 2)).background = Color.white;);}, {~z3.close;~z27.close;~z3 = (View(w, Rect((~f3.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+30, ~nw, 2)).background = Color.white;);});
				~z25.background = Color.white; ~z1.background = Color.white;
				~z26.background = Color.white; ~z2.background = Color.white;
				~z27.background = Color.green; ~z3.background = Color.green;
		});});
		if((~f3 <= ~freqmap.at(0)), {~freqmap.at(0)},
			{if((keycodeb.value == 2) and: (((keycode == ~leftarrow_keycode) or: (keycode == ~leftarrow_keycode1)) or: (unicode == ~j_unicode)), {
				~freqmapval3 = ~f3.cpsmidi.round;
				case
				{~l1a.isRunning == true}{
					~l3a.set(\dur, ~f3 = ~freqmap.at(~freqmapval3 = ~freqmapval3.value-1));
					~l3b.set(\dur, ~f3);
					~l3c.set(\dur, ~f3/~icd3);
					~l3d.set(\dur, ~f3/~icd3);
					~l3e.set(\dur, ~f3/~icd6);
					~l3f.set(\dur, ~f3/~icd6);
				}
				{~l1a1.isRunning == true}{
					~l3a1.set(\dur, ~f3 = ~freqmap.at(~freqmapval3 = ~freqmapval3.value-1));
					~l3b1.set(\dur, ~f3);
					~l3c1.set(\dur, ~f3/~icd3);
					~l3d1.set(\dur, ~f3/~icd3);
					~l3e1.set(\dur, ~f3/~icd6);
					~l3f1.set(\dur, ~f3/~icd6);
				};
				if((~f3 > ~outmaxa) or: (~f3 < ~outmina), {~z27.close;~z3.close;~z27 = (View(w, Rect((~f3.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+30, ~nw, 2)).background = Color.white;);}, {~z3.close;~z27.close;~z3 = (View(w, Rect((~f3.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+30, ~nw, 2)).background = Color.white;);});

				~z25.background = Color.white; ~z1.background = Color.white;
				~z26.background = Color.white; ~z2.background = Color.white;
				~z27.background = Color.green; ~z3.background = Color.green;
		});});
	};


	//if routine function values are nil

	if(~rslot1a == nil, {~rslot1a = ~bplaceo1;}); if(~rslot1b == nil, {~rslot1b = ~bplacef1;});
	if(~rslot2 == nil, {~rslot2 = ~bplacef2;});
	if(~rslot3 == nil, {~rslot3 = ~bplacef3;});
	if(~rslot4 == nil, {~rslot4 = ~bplacef4;});
	if(~rslot5 == nil, {~rslot5 = ~bplacef5;});
	if(~rslot6 == nil, {~rslot6 = ~bplacef6;});
	if(~rslot7 == nil, {~rslot7 = ~bplacef7;});
	if(~rslot8 == nil, {~rslot8 = ~bplacef8;});
	if(~rtimeall == nil, {~rtimeall = 4;});
	if(~rtime1 == nil, {~rtime1 = 4;});
	if(~rtime2 == nil, {~rtime2 = 4;});
	if(~rtime3 == nil, {~rtime3 = 4;});
	if(~rtime4 == nil, {~rtime4 = 4;});
	if(~rtime5 == nil, {~rtime5 = 4;});
	if(~rtime6 == nil, {~rtime6 = 4;});
	if(~rtime7 == nil, {~rtime7 = 4;});
	if(~rtime8 == nil, {~rtime8 = 4;});
	if(~rdoall == nil, {~rdoall = 1;});
	if(~rdo1a == nil, {~rdo1a = "o1";}); if(~rdo1b == nil, {~rdo1b = "f1";});
	if(~rdo2 == nil, {~rdo2 = "f2";});
	if(~rdo3 == nil, {~rdo3 = "f3";});
	if(~rdo4 == nil, {~rdo4 = "f4";});
	if(~rdo5 == nil, {~rdo5 = "f5";});
	if(~rdo6 == nil, {~rdo6 = "f6";});
	if(~rdo7 == nil, {~rdo7 = "f7";});
	if(~rdo8 == nil, {~rdo8 = "f8";});


	//misc. routine button functions (see below)

	~si1aset = {
		if(~si1a.value == "o1", {~rslot1a = ~bplaceo1; ~rdo1a = ~si1a.value;});
		if(~si1a.value == "f1", {~rslot1a = ~bplacef1; ~rdo1a = ~si1a.value;});
		if(~si1a.value == "s1", {~rslot1a = ~bplaces1; ~rdo1a = ~si1a.value;});
		if(~si1a.value == "o2", {~rslot1a = ~bplaceo2; ~rdo1a = ~si1a.value;});
		if(~si1a.value == "f2", {~rslot1a = ~bplacef2; ~rdo1a = ~si1a.value;});
		if(~si1a.value == "s2", {~rslot1a = ~bplaces2; ~rdo1a = ~si1a.value;});
		if(~si1a.value == "o3", {~rslot1a = ~bplaceo3; ~rdo1a = ~si1a.value;});
		if(~si1a.value == "f3", {~rslot1a = ~bplacef3; ~rdo1a = ~si1a.value;});
		if(~si1a.value == "s3", {~rslot1a = ~bplaces3; ~rdo1a = ~si1a.value;});
		if(~si1a.value == "o4", {~rslot1a = ~bplaceo4; ~rdo1a = ~si1a.value;});
		if(~si1a.value == "f4", {~rslot1a = ~bplacef4; ~rdo1a = ~si1a.value;});
		if(~si1a.value == "s4", {~rslot1a = ~bplaces4; ~rdo1a = ~si1a.value;});
		if(~si1a.value == "o5", {~rslot1a = ~bplaceo5; ~rdo1a = ~si1a.value;});
		if(~si1a.value == "f5", {~rslot1a = ~bplacef5; ~rdo1a = ~si1a.value;});
		if(~si1a.value == "s5", {~rslot1a = ~bplaces5; ~rdo1a = ~si1a.value;});
		if(~si1a.value == "o6", {~rslot1a = ~bplaceo6; ~rdo1a = ~si1a.value;});
		if(~si1a.value == "f6", {~rslot1a = ~bplacef6; ~rdo1a = ~si1a.value;});
		if(~si1a.value == "s6", {~rslot1a = ~bplaces6; ~rdo1a = ~si1a.value;});
		if(~si1a.value == "o7", {~rslot1a = ~bplaceo7; ~rdo1a = ~si1a.value;});
		if(~si1a.value == "f7", {~rslot1a = ~bplacef7; ~rdo1a = ~si1a.value;});
		if(~si1a.value == "s7", {~rslot1a = ~bplaces7; ~rdo1a = ~si1a.value;});
		if(~si1a.value == "o8", {~rslot1a = ~bplaceo8; ~rdo1a = ~si1a.value;});
		if(~si1a.value == "f8", {~rslot1a = ~bplacef8; ~rdo1a = ~si1a.value;});
		if(~si1a.value == "s8", {~rslot1a = ~bplaces8; ~rdo1a = ~si1a.value;});
	};
	~si1bset = {
		if(~si1b.value == "o1", {~rslot1b = ~bplaceo1; ~rdo1b = ~si1b.value;});
		if(~si1b.value == "f1", {~rslot1b = ~bplacef1; ~rdo1b = ~si1b.value;});
		if(~si1b.value == "s1", {~rslot1b = ~bplaces1; ~rdo1b = ~si1b.value;});
		if(~si1b.value == "o2", {~rslot1b = ~bplaceo2; ~rdo1b = ~si1b.value;});
		if(~si1b.value == "f2", {~rslot1b = ~bplacef2; ~rdo1b = ~si1b.value;});
		if(~si1b.value == "s2", {~rslot1b = ~bplaces2; ~rdo1b = ~si1b.value;});
		if(~si1b.value == "o3", {~rslot1b = ~bplaceo3; ~rdo1b = ~si1b.value;});
		if(~si1b.value == "f3", {~rslot1b = ~bplacef3; ~rdo1b = ~si1b.value;});
		if(~si1b.value == "s3", {~rslot1b = ~bplaces3; ~rdo1b = ~si1b.value;});
		if(~si1b.value == "o4", {~rslot1b = ~bplaceo4; ~rdo1b = ~si1b.value;});
		if(~si1b.value == "f4", {~rslot1b = ~bplacef4; ~rdo1b = ~si1b.value;});
		if(~si1b.value == "s4", {~rslot1b = ~bplaces4; ~rdo1b = ~si1b.value;});
		if(~si1b.value == "o5", {~rslot1b = ~bplaceo5; ~rdo1b = ~si1b.value;});
		if(~si1b.value == "f5", {~rslot1b = ~bplacef5; ~rdo1b = ~si1b.value;});
		if(~si1b.value == "s5", {~rslot1b = ~bplaces5; ~rdo1b = ~si1b.value;});
		if(~si1b.value == "o6", {~rslot1b = ~bplaceo6; ~rdo1b = ~si1b.value;});
		if(~si1b.value == "f6", {~rslot1b = ~bplacef6; ~rdo1b = ~si1b.value;});
		if(~si1b.value == "s6", {~rslot1b = ~bplaces6; ~rdo1b = ~si1b.value;});
		if(~si1b.value == "o7", {~rslot1b = ~bplaceo7; ~rdo1b = ~si1b.value;});
		if(~si1b.value == "f7", {~rslot1b = ~bplacef7; ~rdo1b = ~si1b.value;});
		if(~si1b.value == "s7", {~rslot1b = ~bplaces7; ~rdo1b = ~si1b.value;});
		if(~si1b.value == "o8", {~rslot1b = ~bplaceo8; ~rdo1b = ~si1b.value;});
		if(~si1b.value == "f8", {~rslot1b = ~bplacef8; ~rdo1b = ~si1b.value;});
		if(~si1b.value == "s8", {~rslot1b = ~bplaces8; ~rdo1b = ~si1b.value;});
	};
	~si2set = {
		if(~si2.value == "o1", {~rslot2 = ~bplaceo1; ~rdo2 = ~si2.value;});
		if(~si2.value == "f1", {~rslot2 = ~bplacef1; ~rdo2 = ~si2.value;});
		if(~si2.value == "s1", {~rslot2 = ~bplaces1; ~rdo2 = ~si2.value;});
		if(~si2.value == "o2", {~rslot2 = ~bplaceo2; ~rdo2 = ~si2.value;});
		if(~si2.value == "f2", {~rslot2 = ~bplacef2; ~rdo2 = ~si2.value;});
		if(~si2.value == "s2", {~rslot2 = ~bplaces2; ~rdo2 = ~si2.value;});
		if(~si2.value == "o3", {~rslot2 = ~bplaceo3; ~rdo2 = ~si2.value;});
		if(~si2.value == "f3", {~rslot2 = ~bplacef3; ~rdo2 = ~si2.value;});
		if(~si2.value == "s3", {~rslot2 = ~bplaces3; ~rdo2 = ~si2.value;});
		if(~si2.value == "o4", {~rslot2 = ~bplaceo4; ~rdo2 = ~si2.value;});
		if(~si2.value == "f4", {~rslot2 = ~bplacef4; ~rdo2 = ~si2.value;});
		if(~si2.value == "s4", {~rslot2 = ~bplaces4; ~rdo2 = ~si2.value;});
		if(~si2.value == "o5", {~rslot2 = ~bplaceo5; ~rdo2 = ~si2.value;});
		if(~si2.value == "f5", {~rslot2 = ~bplacef5; ~rdo2 = ~si2.value;});
		if(~si2.value == "s5", {~rslot2 = ~bplaces5; ~rdo2 = ~si2.value;});
		if(~si2.value == "o6", {~rslot2 = ~bplaceo6; ~rdo2 = ~si2.value;});
		if(~si2.value == "f6", {~rslot2 = ~bplacef6; ~rdo2 = ~si2.value;});
		if(~si2.value == "s6", {~rslot2 = ~bplaces6; ~rdo2 = ~si2.value;});
		if(~si2.value == "o7", {~rslot2 = ~bplaceo7; ~rdo2 = ~si2.value;});
		if(~si2.value == "f7", {~rslot2 = ~bplacef7; ~rdo2 = ~si2.value;});
		if(~si2.value == "s7", {~rslot2 = ~bplaces7; ~rdo2 = ~si2.value;});
		if(~si2.value == "o8", {~rslot2 = ~bplaceo8; ~rdo2 = ~si2.value;});
		if(~si2.value == "f8", {~rslot2 = ~bplacef8; ~rdo2 = ~si2.value;});
		if(~si2.value == "s8", {~rslot2 = ~bplaces8; ~rdo2 = ~si2.value;});
	};
	~si3set = {
		if(~si3.value == "o1", {~rslot3 = ~bplaceo1; ~rdo3 = ~si3.value;});
		if(~si3.value == "f1", {~rslot3 = ~bplacef1; ~rdo3 = ~si3.value;});
		if(~si3.value == "s1", {~rslot3 = ~bplaces1; ~rdo3 = ~si3.value;});
		if(~si3.value == "o2", {~rslot3 = ~bplaceo2; ~rdo3 = ~si3.value;});
		if(~si3.value == "f2", {~rslot3 = ~bplacef2; ~rdo3 = ~si3.value;});
		if(~si3.value == "s2", {~rslot3 = ~bplaces2; ~rdo3 = ~si3.value;});
		if(~si3.value == "o3", {~rslot3 = ~bplaceo3; ~rdo3 = ~si3.value;});
		if(~si3.value == "f3", {~rslot3 = ~bplacef3; ~rdo3 = ~si3.value;});
		if(~si3.value == "s3", {~rslot3 = ~bplaces3; ~rdo3 = ~si3.value;});
		if(~si3.value == "o4", {~rslot3 = ~bplaceo4; ~rdo3 = ~si3.value;});
		if(~si3.value == "f4", {~rslot3 = ~bplacef4; ~rdo3 = ~si3.value;});
		if(~si3.value == "s4", {~rslot3 = ~bplaces4; ~rdo3 = ~si3.value;});
		if(~si3.value == "o5", {~rslot3 = ~bplaceo5; ~rdo3 = ~si3.value;});
		if(~si3.value == "f5", {~rslot3 = ~bplacef5; ~rdo3 = ~si3.value;});
		if(~si3.value == "s5", {~rslot3 = ~bplaces5; ~rdo3 = ~si3.value;});
		if(~si3.value == "o6", {~rslot3 = ~bplaceo6; ~rdo3 = ~si3.value;});
		if(~si3.value == "f6", {~rslot3 = ~bplacef6; ~rdo3 = ~si3.value;});
		if(~si3.value == "s6", {~rslot3 = ~bplaces6; ~rdo3 = ~si3.value;});
		if(~si3.value == "o7", {~rslot3 = ~bplaceo7; ~rdo3 = ~si3.value;});
		if(~si3.value == "f7", {~rslot3 = ~bplacef7; ~rdo3 = ~si3.value;});
		if(~si3.value == "s7", {~rslot3 = ~bplaces7; ~rdo3 = ~si3.value;});
		if(~si3.value == "o8", {~rslot3 = ~bplaceo8; ~rdo3 = ~si3.value;});
		if(~si3.value == "f8", {~rslot3 = ~bplacef8; ~rdo3 = ~si3.value;});
		if(~si3.value == "s8", {~rslot3 = ~bplaces8; ~rdo3 = ~si3.value;});
	};
	~si4set = {
		if(~si4.value == "o1", {~rslot4 = ~bplaceo1; ~rdo4 = ~si4.value;});
		if(~si4.value == "f1", {~rslot4 = ~bplacef1; ~rdo4 = ~si4.value;});
		if(~si4.value == "s1", {~rslot4 = ~bplaces1; ~rdo4 = ~si4.value;});
		if(~si4.value == "o2", {~rslot4 = ~bplaceo2; ~rdo4 = ~si4.value;});
		if(~si4.value == "f2", {~rslot4 = ~bplacef2; ~rdo4 = ~si4.value;});
		if(~si4.value == "s2", {~rslot4 = ~bplaces2; ~rdo4 = ~si4.value;});
		if(~si4.value == "o3", {~rslot4 = ~bplaceo3; ~rdo4 = ~si4.value;});
		if(~si4.value == "f3", {~rslot4 = ~bplacef3; ~rdo4 = ~si4.value;});
		if(~si4.value == "s3", {~rslot4 = ~bplaces3; ~rdo4 = ~si4.value;});
		if(~si4.value == "o4", {~rslot4 = ~bplaceo4; ~rdo4 = ~si4.value;});
		if(~si4.value == "f4", {~rslot4 = ~bplacef4; ~rdo4 = ~si4.value;});
		if(~si4.value == "s4", {~rslot4 = ~bplaces4; ~rdo4 = ~si4.value;});
		if(~si4.value == "o5", {~rslot4 = ~bplaceo5; ~rdo4 = ~si4.value;});
		if(~si4.value == "f5", {~rslot4 = ~bplacef5; ~rdo4 = ~si4.value;});
		if(~si4.value == "s5", {~rslot4 = ~bplaces5; ~rdo4 = ~si4.value;});
		if(~si4.value == "o6", {~rslot4 = ~bplaceo6; ~rdo4 = ~si4.value;});
		if(~si4.value == "f6", {~rslot4 = ~bplacef6; ~rdo4 = ~si4.value;});
		if(~si4.value == "s6", {~rslot4 = ~bplaces6; ~rdo4 = ~si4.value;});
		if(~si4.value == "o7", {~rslot4 = ~bplaceo7; ~rdo4 = ~si4.value;});
		if(~si4.value == "f7", {~rslot4 = ~bplacef7; ~rdo4 = ~si4.value;});
		if(~si4.value == "s7", {~rslot4 = ~bplaces7; ~rdo4 = ~si4.value;});
		if(~si4.value == "o8", {~rslot4 = ~bplaceo8; ~rdo4 = ~si4.value;});
		if(~si4.value == "f8", {~rslot4 = ~bplacef8; ~rdo4 = ~si4.value;});
		if(~si4.value == "s8", {~rslot4 = ~bplaces8; ~rdo4 = ~si4.value;});
	};
	~si5set = {
		if(~si5.value == "o1", {~rslot5 = ~bplaceo1; ~rdo5 = ~si5.value;});
		if(~si5.value == "f1", {~rslot5 = ~bplacef1; ~rdo5 = ~si5.value;});
		if(~si5.value == "s1", {~rslot5 = ~bplaces1; ~rdo5 = ~si5.value;});
		if(~si5.value == "o2", {~rslot5 = ~bplaceo2; ~rdo5 = ~si5.value;});
		if(~si5.value == "f2", {~rslot5 = ~bplacef2; ~rdo5 = ~si5.value;});
		if(~si5.value == "s2", {~rslot5 = ~bplaces2; ~rdo5 = ~si5.value;});
		if(~si5.value == "o3", {~rslot5 = ~bplaceo3; ~rdo5 = ~si5.value;});
		if(~si5.value == "f3", {~rslot5 = ~bplacef3; ~rdo5 = ~si5.value;});
		if(~si5.value == "s3", {~rslot5 = ~bplaces3; ~rdo5 = ~si5.value;});
		if(~si5.value == "o4", {~rslot5 = ~bplaceo4; ~rdo5 = ~si5.value;});
		if(~si5.value == "f4", {~rslot5 = ~bplacef4; ~rdo5 = ~si5.value;});
		if(~si5.value == "s4", {~rslot5 = ~bplaces4; ~rdo5 = ~si5.value;});
		if(~si5.value == "o5", {~rslot5 = ~bplaceo5; ~rdo5 = ~si5.value;});
		if(~si5.value == "f5", {~rslot5 = ~bplacef5; ~rdo5 = ~si5.value;});
		if(~si5.value == "s5", {~rslot5 = ~bplaces5; ~rdo5 = ~si5.value;});
		if(~si5.value == "o6", {~rslot5 = ~bplaceo6; ~rdo5 = ~si5.value;});
		if(~si5.value == "f6", {~rslot5 = ~bplacef6; ~rdo5 = ~si5.value;});
		if(~si5.value == "s6", {~rslot5 = ~bplaces6; ~rdo5 = ~si5.value;});
		if(~si5.value == "o7", {~rslot5 = ~bplaceo7; ~rdo5 = ~si5.value;});
		if(~si5.value == "f7", {~rslot5 = ~bplacef7; ~rdo5 = ~si5.value;});
		if(~si5.value == "s7", {~rslot5 = ~bplaces7; ~rdo5 = ~si5.value;});
		if(~si5.value == "o8", {~rslot5 = ~bplaceo8; ~rdo5 = ~si5.value;});
		if(~si5.value == "f8", {~rslot5 = ~bplacef8; ~rdo5 = ~si5.value;});
		if(~si5.value == "s8", {~rslot5 = ~bplaces8; ~rdo5 = ~si5.value;});
	};
	~si6set = {
		if(~si6.value == "o1", {~rslot6 = ~bplaceo1; ~rdo6 = ~si6.value;});
		if(~si6.value == "f1", {~rslot6 = ~bplacef1; ~rdo6 = ~si6.value;});
		if(~si6.value == "s1", {~rslot6 = ~bplaces1; ~rdo6 = ~si6.value;});
		if(~si6.value == "o2", {~rslot6 = ~bplaceo2; ~rdo6 = ~si6.value;});
		if(~si6.value == "f2", {~rslot6 = ~bplacef2; ~rdo6 = ~si6.value;});
		if(~si6.value == "s2", {~rslot6 = ~bplaces2; ~rdo6 = ~si6.value;});
		if(~si6.value == "o3", {~rslot6 = ~bplaceo3; ~rdo6 = ~si6.value;});
		if(~si6.value == "f3", {~rslot6 = ~bplacef3; ~rdo6 = ~si6.value;});
		if(~si6.value == "s3", {~rslot6 = ~bplaces3; ~rdo6 = ~si6.value;});
		if(~si6.value == "o4", {~rslot6 = ~bplaceo4; ~rdo6 = ~si6.value;});
		if(~si6.value == "f4", {~rslot6 = ~bplacef4; ~rdo6 = ~si6.value;});
		if(~si6.value == "s4", {~rslot6 = ~bplaces4; ~rdo6 = ~si6.value;});
		if(~si6.value == "o5", {~rslot6 = ~bplaceo5; ~rdo6 = ~si6.value;});
		if(~si6.value == "f5", {~rslot6 = ~bplacef5; ~rdo6 = ~si6.value;});
		if(~si6.value == "s5", {~rslot6 = ~bplaces5; ~rdo6 = ~si6.value;});
		if(~si6.value == "o6", {~rslot6 = ~bplaceo6; ~rdo6 = ~si6.value;});
		if(~si6.value == "f6", {~rslot6 = ~bplacef6; ~rdo6 = ~si6.value;});
		if(~si6.value == "s6", {~rslot6 = ~bplaces6; ~rdo6 = ~si6.value;});
		if(~si6.value == "o7", {~rslot6 = ~bplaceo7; ~rdo6 = ~si6.value;});
		if(~si6.value == "f7", {~rslot6 = ~bplacef7; ~rdo6 = ~si6.value;});
		if(~si6.value == "s7", {~rslot6 = ~bplaces7; ~rdo6 = ~si6.value;});
		if(~si6.value == "o8", {~rslot6 = ~bplaceo8; ~rdo6 = ~si6.value;});
		if(~si6.value == "f8", {~rslot6 = ~bplacef8; ~rdo6 = ~si6.value;});
		if(~si6.value == "s8", {~rslot6 = ~bplaces8; ~rdo6 = ~si6.value;});
	};
	~si7set = {
		if(~si7.value == "o1", {~rslot7 = ~bplaceo1; ~rdo7 = ~si7.value;});
		if(~si7.value == "f1", {~rslot7 = ~bplacef1; ~rdo7 = ~si7.value;});
		if(~si7.value == "s1", {~rslot7 = ~bplaces1; ~rdo7 = ~si7.value;});
		if(~si7.value == "o2", {~rslot7 = ~bplaceo2; ~rdo7 = ~si7.value;});
		if(~si7.value == "f2", {~rslot7 = ~bplacef2; ~rdo7 = ~si7.value;});
		if(~si7.value == "s2", {~rslot7 = ~bplaces2; ~rdo7 = ~si7.value;});
		if(~si7.value == "o3", {~rslot7 = ~bplaceo3; ~rdo7 = ~si7.value;});
		if(~si7.value == "f3", {~rslot7 = ~bplacef3; ~rdo7 = ~si7.value;});
		if(~si7.value == "s3", {~rslot7 = ~bplaces3; ~rdo7 = ~si7.value;});
		if(~si7.value == "o4", {~rslot7 = ~bplaceo4; ~rdo7 = ~si7.value;});
		if(~si7.value == "f4", {~rslot7 = ~bplacef4; ~rdo7 = ~si7.value;});
		if(~si7.value == "s4", {~rslot7 = ~bplaces4; ~rdo7 = ~si7.value;});
		if(~si7.value == "o5", {~rslot7 = ~bplaceo5; ~rdo7 = ~si7.value;});
		if(~si7.value == "f5", {~rslot7 = ~bplacef5; ~rdo7 = ~si7.value;});
		if(~si7.value == "s5", {~rslot7 = ~bplaces5; ~rdo7 = ~si7.value;});
		if(~si7.value == "o6", {~rslot7 = ~bplaceo6; ~rdo7 = ~si7.value;});
		if(~si7.value == "f6", {~rslot7 = ~bplacef6; ~rdo7 = ~si7.value;});
		if(~si7.value == "s6", {~rslot7 = ~bplaces6; ~rdo7 = ~si7.value;});
		if(~si7.value == "o7", {~rslot7 = ~bplaceo7; ~rdo7 = ~si7.value;});
		if(~si7.value == "f7", {~rslot7 = ~bplacef7; ~rdo7 = ~si7.value;});
		if(~si7.value == "s7", {~rslot7 = ~bplaces7; ~rdo7 = ~si7.value;});
		if(~si7.value == "o8", {~rslot7 = ~bplaceo8; ~rdo7 = ~si7.value;});
		if(~si7.value == "f8", {~rslot7 = ~bplacef8; ~rdo7 = ~si7.value;});
		if(~si7.value == "s8", {~rslot7 = ~bplaces8; ~rdo7 = ~si7.value;});
	};
	~si8set = {
		if(~si8.value == "o1", {~rslot8 = ~bplaceo1; ~rdo8 = ~si8.value;});
		if(~si8.value == "f1", {~rslot8 = ~bplacef1; ~rdo8 = ~si8.value;});
		if(~si8.value == "s1", {~rslot8 = ~bplaces1; ~rdo8 = ~si8.value;});
		if(~si8.value == "o2", {~rslot8 = ~bplaceo2; ~rdo8 = ~si8.value;});
		if(~si8.value == "f2", {~rslot8 = ~bplacef2; ~rdo8 = ~si8.value;});
		if(~si8.value == "s2", {~rslot8 = ~bplaces2; ~rdo8 = ~si8.value;});
		if(~si8.value == "o3", {~rslot8 = ~bplaceo3; ~rdo8 = ~si8.value;});
		if(~si8.value == "f3", {~rslot8 = ~bplacef3; ~rdo8 = ~si8.value;});
		if(~si8.value == "s3", {~rslot8 = ~bplaces3; ~rdo8 = ~si8.value;});
		if(~si8.value == "o4", {~rslot8 = ~bplaceo4; ~rdo8 = ~si8.value;});
		if(~si8.value == "f4", {~rslot8 = ~bplacef4; ~rdo8 = ~si8.value;});
		if(~si8.value == "s4", {~rslot8 = ~bplaces4; ~rdo8 = ~si8.value;});
		if(~si8.value == "o5", {~rslot8 = ~bplaceo5; ~rdo8 = ~si8.value;});
		if(~si8.value == "f5", {~rslot8 = ~bplacef5; ~rdo8 = ~si8.value;});
		if(~si8.value == "s5", {~rslot8 = ~bplaces5; ~rdo8 = ~si8.value;});
		if(~si8.value == "o6", {~rslot8 = ~bplaceo6; ~rdo8 = ~si8.value;});
		if(~si8.value == "f6", {~rslot8 = ~bplacef6; ~rdo8 = ~si8.value;});
		if(~si8.value == "s6", {~rslot8 = ~bplaces6; ~rdo8 = ~si8.value;});
		if(~si8.value == "o7", {~rslot8 = ~bplaceo7; ~rdo8 = ~si8.value;});
		if(~si8.value == "f7", {~rslot8 = ~bplacef7; ~rdo8 = ~si8.value;});
		if(~si8.value == "s7", {~rslot8 = ~bplaces7; ~rdo8 = ~si8.value;});
		if(~si8.value == "o8", {~rslot8 = ~bplaceo8; ~rdo8 = ~si8.value;});
		if(~si8.value == "f8", {~rslot8 = ~bplacef8; ~rdo8 = ~si8.value;});
		if(~si8.value == "s8", {~rslot8 = ~bplaces8; ~rdo8 = ~si8.value;});
	};


	//routine function button

	~rviewbutton = Button.new(w,Rect(Window.screenBounds.width-20-20,~bpt+69+5-(20/~gm),20,20/1.6180339887499)).states_([["r",Color.white,Color.black],["r",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button;

		if(button.value == 1, {
			({
				arg leftdo = 0 , leftdobox = 52, lefttime = leftdobox+widthbox+6, lefttimebox = lefttime+57, top = 0,width=52, height = 16,  widthbox=52, heightbox = 16, inc=0, lw = 0,  uw = 0, numw = 40;
				var tall, stall, iall, siall, st1, st2, st3, st4, st5, st6, st7, st8,  t1,t2,t3,t4,t5,t6,t7,t8,i1,i2,i3,i4,i5,i6,i7,i8;
				~rview = View(w, Rect(Window.screenBounds.width-(340+46),Window.screenBounds.height-(340+46/1.6180339887499)-110,340+46,340+46/1.6180339887499)).front;
				/*w.view.decorator=FlowLayout(w.view.bounds);
				w.view.decorator.gap=2@2;*/

				top = 0;

				i1 = StaticText(~rview, Rect(leftdo , top=top, width, height)).background_(Color.black).string_("rslot1").stringColor_(Color.white);
				i2 = StaticText(~rview, Rect(leftdo , top=top+height, width, height)).background_(Color.black).string_("rslot2").stringColor_(Color.white);
				i3 = StaticText(~rview, Rect(leftdo , top=top+height, width, height)).background_(Color.black).string_("rslot3").stringColor_(Color.white);
				i4 = StaticText(~rview, Rect(leftdo , top=top+height, width, height)).background_(Color.black).string_("rslot4").stringColor_(Color.white);
				i5 = StaticText(~rview, Rect(leftdo , top=top+height, width, height)).background_(Color.black).string_("rslot5").stringColor_(Color.white);
				i6 = StaticText(~rview, Rect(leftdo , top=top+height, width, height)).background_(Color.black).string_("rslot6").stringColor_(Color.white);
				i7 = StaticText(~rview, Rect(leftdo , top=top+height, width, height)).background_(Color.black).string_("rslot7").stringColor_(Color.white);
				i8 = StaticText(~rview, Rect(leftdo , top=top+height, width, height)).background_(Color.black).string_("rslot8").stringColor_(Color.white);

				top = 0;

				~si1a=TextField(~rview, Rect(leftdobox , top=top, widthbox/2, heightbox)).background_(Color.black).stringColor_(Color.white).value_(~rdo1a);
				~si1b=TextField(~rview, Rect(leftdobox+(widthbox/2) , top=top, widthbox/2, heightbox)).background_(Color.black).stringColor_(Color.white).value_(~rdo1b);
				~si2=TextField(~rview, Rect(leftdobox , top=top+heightbox, widthbox, heightbox)).background_(Color.black).stringColor_(Color.white).value_(~rdo2);
				~si3=TextField(~rview, Rect(leftdobox , top=top+heightbox, widthbox, heightbox)).background_(Color.black).stringColor_(Color.white).value_(~rdo3);
				~si4=TextField(~rview, Rect(leftdobox , top=top+heightbox, widthbox, heightbox)).background_(Color.black).stringColor_(Color.white).value_(~rdo4);
				~si5=TextField(~rview, Rect(leftdobox , top=top+heightbox, widthbox, heightbox)).background_(Color.black).stringColor_(Color.white).value_(~rdo5);
				~si6=TextField(~rview, Rect(leftdobox , top=top+heightbox, widthbox, heightbox)).background_(Color.black).stringColor_(Color.white).value_(~rdo6);
				~si7=TextField(~rview, Rect(leftdobox , top=top+heightbox, widthbox, heightbox)).background_(Color.black).stringColor_(Color.white).value_(~rdo7);
				~si8=TextField(~rview, Rect(leftdobox , top=top+heightbox, widthbox, heightbox)).background_(Color.black).stringColor_(Color.white).value_(~rdo8);

				top = 0;

				t1 = StaticText(~rview, Rect(lefttime , top=top, width, height)).background_(Color.black).string_("rtime1").stringColor_(Color.white);
				t2 = StaticText(~rview, Rect(lefttime , top=top+height, width, height)).background_(Color.black).string_("rtime2").stringColor_(Color.white);
				t3 = StaticText(~rview, Rect(lefttime , top=top+height, width, height)).background_(Color.black).string_("rtime3").stringColor_(Color.white);
				t4 = StaticText(~rview, Rect(lefttime , top=top+height, width, height)).background_(Color.black).string_("rtime4").stringColor_(Color.white);
				t5 = StaticText(~rview, Rect(lefttime , top=top+height, width, height)).background_(Color.black).string_("rtime5").stringColor_(Color.white);
				t6 = StaticText(~rview, Rect(lefttime , top=top+height, width, height)).background_(Color.black).string_("rtime6").stringColor_(Color.white);
				t7 = StaticText(~rview, Rect(lefttime , top=top+height, width, height)).background_(Color.black).string_("rtime7").stringColor_(Color.white);
				t8 = StaticText(~rview, Rect(lefttime , top=top+height, width, height)).background_(Color.black).string_("rtime8").stringColor_(Color.white);
				tall = StaticText(~rview, Rect(lefttime , top=top+height, width, height)).background_(Color.black).string_("all time").stringColor_(Color.white);


				top = 0;

				st1=NumberBox(~rview, Rect(lefttimebox , top=top, widthbox, heightbox)).background_(Color.black).normalColor_(Color.white;).value_(~rtime1);
				st2=NumberBox(~rview, Rect(lefttimebox , top=top+heightbox, widthbox, heightbox)).background_(Color.black).normalColor_(Color.white;).value_(~rtime2);
				st3=NumberBox(~rview, Rect(lefttimebox , top=top+heightbox, widthbox, heightbox)).background_(Color.black).normalColor_(Color.white;).value_(~rtime3);
				st4=NumberBox(~rview, Rect(lefttimebox , top=top+heightbox, widthbox, heightbox)).background_(Color.black).normalColor_(Color.white;).value_(~rtime4);
				st5=NumberBox(~rview, Rect(lefttimebox , top=top+heightbox, widthbox, heightbox)).background_(Color.black).normalColor_(Color.white;).value_(~rtime5);
				st6=NumberBox(~rview, Rect(lefttimebox , top=top+heightbox, widthbox, heightbox)).background_(Color.black).normalColor_(Color.white;).value_(~rtime6);
				st7=NumberBox(~rview, Rect(lefttimebox , top=top+heightbox, widthbox, heightbox)).background_(Color.black).normalColor_(Color.white;).value_(~rtime7);
				st8=NumberBox(~rview, Rect(lefttimebox , top=top+heightbox, widthbox, heightbox)).background_(Color.black).normalColor_(Color.white;).value_(~rtime8);
				stall=NumberBox(~rview, Rect(lefttimebox , top=top+heightbox, widthbox, heightbox)).background_(Color.black).normalColor_(Color.white;).value_(~rtimeall);

				~si1a.action_({~si1aset.value});
				~si1b.action_({~si1bset.value});
				~si2.action_({~si2set.value});
				~si3.action_({~si3set.value});
				~si4.action_({~si4set.value});
				~si5.action_({~si5set.value});
				~si6.action_({~si6set.value});
				~si7.action_({~si7set.value});
				~si8.action_({~si8set.value});

				stall.action_({arg val;
					~rtimeall = val.value;
					~rtime1 = val.value;
					~rtime2 = val.value;
					~rtime3 = val.value;
					~rtime4 = val.value;
					~rtime5 = val.value;
					~rtime6 = val.value;
					~rtime7 = val.value;
					~rtime8 = val.value;
					~rview.close; ~rviewbutton.valueAction_(1);
				});
				st1.action_({arg val; ~rtime1 = val.value;});
				st2.action_({arg val; ~rtime2 = val.value;});
				st3.action_({arg val; ~rtime3 = val.value;});
				st4.action_({arg val; ~rtime4 = val.value;});
				st5.action_({arg val; ~rtime5 = val.value;});
				st6.action_({arg val; ~rtime6 = val.value;});
				st7.action_({arg val; ~rtime7 = val.value;});
				st8.action_({arg val; ~rtime8 = val.value;});

				~rview.background_(Color.black);

				~metronomeincr = 1;

				~routinebutton = Button.new(~rview,Rect(0, top+40, 40, 40/~gm)).states_([["loop",Color.white,Color.black],["stop",Color.white,Color.black]]).action_({arg button;

					if(button.value == 1, {

						~metronome = Task({
							inf.do({
								AppClock.sched(0, {~metronomebutton.value = 1;});
								~metronomeincr.wait;
								AppClock.sched(0, {~metronomebutton.value = 0;});
								~metronomeincr.wait;
							});
						});

						~loop = Task({
							1.do({
								{~rslot1a.valueAction_(0)}.defer;
								~rtime1.wait;
								{~rslot2.valueAction_(0)}.defer;
								~rtime2.wait;
								{~rslot3.valueAction_(0)}.defer;
								~rtime3.wait;
								{~rslot4.valueAction_(0)}.defer;
								~rtime4.wait;
								{~rslot5.valueAction_(0)}.defer;
								~rtime5.wait;
								{~rslot6.valueAction_(0)}.defer;
								~rtime6.wait;
								{~rslot7.valueAction_(0)}.defer;
								~rtime7.wait;
								{~rslot8.valueAction_(0)}.defer;
								~rtime8.wait;
							});
							inf.do({
								{~rslot1b.valueAction_(0)}.defer;
								~rtime1.wait;
								{~rslot2.valueAction_(0)}.defer;
								~rtime2.wait;
								{~rslot3.valueAction_(0)}.defer;
								~rtime3.wait;
								{~rslot4.valueAction_(0)}.defer;
								~rtime4.wait;
								{~rslot5.valueAction_(0)}.defer;
								~rtime5.wait;
								{~rslot6.valueAction_(0)}.defer;
								~rtime6.wait;
								{~rslot7.valueAction_(0)}.defer;
								~rtime7.wait;
								{~rslot8.valueAction_(0)}.defer;
								~rtime8.wait;
							});
					}); SystemClock(~metronome.start); SystemClock(~loop.start); ~numsynths.stop;}, {

						SystemClock(~metronome.stop); SystemClock(~loop.stop); SystemClock(~loop.reset); ~synthfree.value; ~pauseroutinebutton.value = 0; ~numsynths.stop; ~numsynthsfunc.value;});
				});

				~pauseroutinebutton = Button.new(~rview,Rect(50, top+40, 40, 40/~gm)).states_([["pause",Color.white,Color.black],["loop",Color.white,Color.black]]).action_({arg button;

					if(button.value == 1, {SystemClock(~loop.pause); ~synthpause.value;}, {SystemClock(~loop.resume); ~synthflow.value;});
				});

				~closeroutinebutton = Button.new(~rview,Rect(220, top+40, 40, 40/~gm)).states_([["close",Color.white,Color.black]]).action_({arg button;

					~rview.close; ~rviewbutton.value = 0;
				});

				~metronomebutton = Button.new(~rview,Rect(120, top+40, 40, 40/~gm)).states_([["",Color.white,Color.red],["",Color.white,Color.blue]]).action_({arg button;});

			}.value);

			if(~loop.isPlaying == true, {~routinebutton.value = 1;});
			~rview.front;
		}, {~rview.close});
	});


	//synth identifier function

	~synthmonitor = StaticText(w, Rect(Window.screenBounds.width-14,~bpt+49,18,18/1.6180339887499)).background_(Color.black).stringColor_(Color.white);
	~synthmonitor.string = if(~currentsynth == nil, {"nil".asString});

	~synthmonitorfunc = {
		~synthmonitor.close;
		~synthmonitor = StaticText(w, Rect(Window.screenBounds.width-14,~bpt+49,18,18/1.6180339887499)).background_(Color.black).stringColor_(Color.white);
		~synthmonitor.string = ~currentsynth.asString;
		~synthmonitor.font = Font(size: 10);
	};

	~synthmonitorfunc.value;


	//cpu, # of ugens, # of synths, and current frequencies display

	~cpumonitor = StaticText(w, Rect(Window.screenBounds.width-500,~bpt-200,500,90/1.6180339887499)).background_(Color.black).stringColor_(Color.white);
	~cpumonitor.close;

	~cpumonitorfunc =  {
		~cpumonitor.close;
		~cpumonitor = StaticText(w, Rect(20,~bpt-100,800,124/1.6180339887499)).background_(Color.black).stringColor_(Color.white);
		if(~settingsbutton.value == 1, {~cpumonitorroutine.stop; ~cpumonitor.close; ~cpumonitorbutton.value = 0;});
		~cpumonitor.string =
		"cpu: "+s.avgCPU.asString+"%"++"\n" ++
		"ugens: "+s.numUGens.asString++"\n" ++
		"synths: "+s.numSynths.asString++"\n" ++
		/*"f1 = "++~f1.round(0.01)++", f2 = "++~f2.round(0.01)++", f3 = "++~f3.round(0.01)++", f4 = "++~f4.round(0.01)++", f5 = "++~f5.round(0.01)++", f6 = "++~f6.round(0.01)++","++"f7 = "++~f7.round(0.01)++", f8 = "++~f8.round(0.01);
		*/		~f1.round(0.01)++", "++~f2.round(0.01)++", "++~f3.round(0.01);
		/*[ ~f1.round(0.01), ~f2.round(0.01), ~f3.round(0.01),~f4.round(0.01),~f5.round(0.01),~f6.round(0.01),~f7.round(0.01),~f8.round(0.01) ].asString;
		*/	~cpumonitor.font = Font(size: 14);
	};

	~cpumonitorroutine = Routine({
		inf.do({
			AppClock.sched(0, {
				~cpumonitorfunc.value;
			});
			1.wait;
		});
	});

	~cpumonitorbutton = Button.new(w,Rect(Window.screenBounds.width-20-20-20-20,~bpt+69+5,20,20/1.6180339887499)).states_([["cm",Color.white,Color.black],["cm",Color.white,Color.black]]).action_({arg button;

		if(button.value == 1, {
			~cpumonitorroutine.reset;
			~cpumonitorroutine.play;
		}, {~cpumonitorroutine.stop; ~cpumonitor.close;});

	});


	//information button

	info = Button.new(w,Rect(Window.screenBounds.width-20-20,~bpt+69+5,20,20/1.6180339887499)).states_([["i",Color.white,Color.black],["i",Color.white,Color.black]]).action_({arg button;

		if(button.value == 1, {
			~hb = TextView(w, Rect(0,0, Window.screenBounds.width, Window.screenBounds.height-200)).background_(Color.black);
			(~hb.string =
				"(scroll down to see more)"++"\n"++"\n"++"\n"++
				"ctrl/cmd-period: stop synth/free server"++"\n"++"\n"++"\n"++
				"GUI Buttons"++"\n"++"\n"++"\n"++
				"synth0/synth1: start/stop synth set"++"\n"++"\n"++
				"pause0/pause1: pause/unpause synth set"++"\n"++"\n"++
				"tsynth0/tsynth1: tsynth0 to allow timed synth set, then click on any o, f, or s button to time a progression. click on the stop timer button in the bottom right to stop the timer."++"\n"++"tsynth1 to dis-allow timed synth set"++"\n"++"\n"++
				"copy: copy frequency/note info"++"\n"++"\n"++
				"settings button:"++"\n"++"\n"++
				"     KWS number: change number of kw(King Wen) sequences in a timewave half-cycle (or amplitude x2). press set to load."++"\n"++"\n"++
				"     base(lowest) freq(hz): set the base(lowest) frequency of timewave cycle. press set to load."++"\n"++"\n"++
				"     synthdef type: psine1-psine3 (based on phi, with low-pass filter), hsine1-hsine3 (based on 19.47:360, with low-pass filter), psineuf1-psineuf3 (based on phi, without low-pass filter),"++"\n"++"     hsineuf1-hsineuf3 (based on 19.47:360, without low-pass filter) - set synthdef type. press set to load."++"\n"++"\n"++
				"     lp filter limit(hz): change the low-pass filter frequency limit. default is 1728. press set to load."++"\n"++"\n"++
				"     automate: setting for automated mid-timewave sequence events. press set to load."++"\n"++"\n"++
				"s1-s8: set/save note positions"++"\n"++"\n"++
				"g1-g8: groups of saved note positions"++"\n"++"\n"++
				"uc-u8: undo changes to set note positions. press set to load"++"\n"++"\n"++
				"rc, /rc: start recording/stop recording"++"\n"++"\n"++
				"prc: pause recording"++"\n"++"\n"++
				"o1-o8: play set/saved note positions by opening a new synth set"++"\n"++"\n"++
				"f1-f8: flow transition to set/saved note positions"++"\n"++"\n"++
				"s1-s8: slide transition to set/saved note positions"++"\n"++"\n"++
				"m/u: mute/unmute all"++"\n"++"\n"++
				"1-3: mute or unmute individual synth"++"\n"++"\n"++
				"cm: cpu percentage/number of ugens/number of synths display"++"\n"++"\n"++
				"rw: random western scale"++"\n"++"\n"++
				"re: random eastern scale"++"\n"++"\n"++
				"r: routine/loop function - rslot for synth set, rtime for time between transitions"++"\n"++"\n"++
				"eo: extra options - set frequencies, set slide time/increment"++"\n"++"\n"++
				"i: help"++"\n"++"\n"++
				"m: minimize window"++"\n"++"\n"++
				"c: close window"++"\n"++"\n"++"\n"++
				"Keyboard Functions (functionality will vary with device)"++"\n"++"\n"++"\n"++
				"s: start/stop synth set"++"\n"++"\n"++
				"space bar: pause/unpause synth set"++"\n"++"\n"++
				"ctrl-period/cmd-period: stop synth/free server"++"\n"++"\n"++
				"left/right arrow(or J and L): move down/up note"++"\n"++"\n"++
				"up/down arrow(or I and K): change synth for left/right arrow note function"++"\n"++"\n"++
				"#1-3 on keyboard: choose synth for left/right arrow note function"++"\n"++"\n"++
				"r: routine/loop function - rslot for synth set, rtime for time between transitions"++"\n"++"\n"++
				"m: mute/unmute all"++"\n"++"\n"++
				"c: copy function"++"\n"++"\n"++
				"t: timed synth function"++"\n"++"\n"++
				"esc: minimize window"
				;
			);
			~hb.stringColor = Color.white;
		},
		{~hb.close;});
	});


	//random notes button 1

	~randombutton1 = Button.new(w,Rect(Window.screenBounds.width-20-20-20-20,~bpt+69+5-(20/~gm),20,20/1.6180339887499)).states_([["rw",Color.white,Color.black]]).action_({arg button;

		if((~l1a.isRunning == true) or: (~l1a1.isRunning == true), {
			8.do(x = 0; {("f"++(x=x+1)).asSymbol.envirPut(~freqmap.at(rrand(36, 91));)});
			~synthflow.value;
		});
	});


	//random notes button 2

	~randombutton2 = Button.new(w,Rect(Window.screenBounds.width-20-20-20,~bpt+69+5-(20/~gm),20,20/1.6180339887499)).states_([["re",Color.white,Color.black]]).action_({arg button;

		if((~l1a.isRunning == true) or: (~l1a1.isRunning == true), {
			8.do(x = 0; {("f"++(x=x+1)).asSymbol.envirPut((~freqmap.at(127)/8).rand;)});
			~synthflow.value;
		});
	});


	//setgroup buttons, sg1-sg8

	~setgroup1 = Button.new(w,Rect(Window.screenBounds.width-(Window.screenBounds.width/2)-(20*4),~bpt+69+5,20,20/1.6180339887499)).states_([["g1",Color.white,Color.black],["s1",Color.green,Color.black]]).action_({arg button;

		if(button.value == 1, {
			12.do(x = 0; {("fp"++(x=x+1)).asSymbol.envirPut([~sg1a1,~sg1a2,~sg1a3,~sg1a4,~sg1a5,~sg1a6,~sg1a7,~sg1a8,~sg1a9,~sg1a10,~sg1a11,~sg1a12].at(x-1))});
			12.do(x = 0; {("fp"++(x=x+1)++"b").asSymbol.envirPut([~sg1b1,~sg1b2,~sg1b3,~sg1b4,~sg1b5,~sg1b6,~sg1b7,~sg1b8,~sg1b9,~sg1b10,~sg1b11,~sg1b12].at(x-1))});
			12.do(x = 0; {("fp"++(x=x+1)++"c").asSymbol.envirPut([~sg1c1,~sg1c2,~sg1c3,~sg1c4,~sg1c5,~sg1c6,~sg1c7,~sg1c8,~sg1c9,~sg1c10,~sg1c11,~sg1c12].at(x-1))});
			12.do(x = 0; {("fp"++(x=x+1)++"d").asSymbol.envirPut([~sg1d1,~sg1d2,~sg1d3,~sg1d4,~sg1d5,~sg1d6,~sg1d7,~sg1d8,~sg1d9,~sg1d10,~sg1d11,~sg1d12].at(x-1))});
			12.do(x = 0; {("fp"++(x=x+1)++"e").asSymbol.envirPut([~sg1e1,~sg1e2,~sg1e3,~sg1e4,~sg1e5,~sg1e6,~sg1e7,~sg1e8,~sg1e9,~sg1e10,~sg1e11,~sg1e12].at(x-1))});
			12.do(x = 0; {("fp"++(x=x+1)++"f").asSymbol.envirPut([~sg1f1,~sg1f2,~sg1f3,~sg1f4,~sg1f5,~sg1f6,~sg1f7,~sg1f8,~sg1f9,~sg1f10,~sg1f11,~sg1f12].at(x-1))});
			12.do(x = 0; {("fp"++(x=x+1)++"g").asSymbol.envirPut([~sg1g1,~sg1g2,~sg1g3,~sg1g4,~sg1g5,~sg1g6,~sg1g7,~sg1g8,~sg1g9,~sg1g10,~sg1g11,~sg1g12].at(x-1))});
			12.do(x = 0; {("fp"++(x=x+1)++"h").asSymbol.envirPut([~sg1h1,~sg1h2,~sg1h3,~sg1h4,~sg1h5,~sg1h6,~sg1h7,~sg1h8,~sg1h9,~sg1h10,~sg1h11,~sg1h12].at(x-1))});

			~setgroup2.value = 0;
			~setgroup3.value = 0;
			~setgroup4.value = 0;
			~setgroup5.value = 0;
			~setgroup6.value = 0;
			~setgroup7.value = 0;
			~setgroup8.value = 0;

			~setgroupval = 1;
		});
	});
	~setgroup2 = Button.new(w,Rect(Window.screenBounds.width-(Window.screenBounds.width/2)-(20*3),~bpt+69+5,20,20/1.6180339887499)).states_([["g2",Color.white,Color.black],["s2",Color.green,Color.black]]).action_({arg button;

		if(button.value == 1, {
			12.do(x = 0; {("fp"++(x=x+1)).asSymbol.envirPut([~sg2a1,~sg2a2,~sg2a3,~sg2a4,~sg2a5,~sg2a6,~sg2a7,~sg2a8,~sg2a9,~sg2a10,~sg2a11,~sg2a12].at(x-1))});
			12.do(x = 0; {("fp"++(x=x+1)++"b").asSymbol.envirPut([~sg2b1,~sg2b2,~sg2b3,~sg2b4,~sg2b5,~sg2b6,~sg2b7,~sg2b8,~sg2b9,~sg2b10,~sg2b11,~sg2b12].at(x-1))});
			12.do(x = 0; {("fp"++(x=x+1)++"c").asSymbol.envirPut([~sg2c1,~sg2c2,~sg2c3,~sg2c4,~sg2c5,~sg2c6,~sg2c7,~sg2c8,~sg2c9,~sg2c10,~sg2c11,~sg2c12].at(x-1))});
			12.do(x = 0; {("fp"++(x=x+1)++"d").asSymbol.envirPut([~sg2d1,~sg2d2,~sg2d3,~sg2d4,~sg2d5,~sg2d6,~sg2d7,~sg2d8,~sg2d9,~sg2d10,~sg2d11,~sg2d12].at(x-1))});
			12.do(x = 0; {("fp"++(x=x+1)++"e").asSymbol.envirPut([~sg2e1,~sg2e2,~sg2e3,~sg2e4,~sg2e5,~sg2e6,~sg2e7,~sg2e8,~sg2e9,~sg2e10,~sg2e11,~sg2e12].at(x-1))});
			12.do(x = 0; {("fp"++(x=x+1)++"f").asSymbol.envirPut([~sg2f1,~sg2f2,~sg2f3,~sg2f4,~sg2f5,~sg2f6,~sg2f7,~sg2f8,~sg2f9,~sg2f10,~sg2f11,~sg2f12].at(x-1))});
			12.do(x = 0; {("fp"++(x=x+1)++"g").asSymbol.envirPut([~sg2g1,~sg2g2,~sg2g3,~sg2g4,~sg2g5,~sg2g6,~sg2g7,~sg2g8,~sg2g9,~sg2g10,~sg2g11,~sg2g12].at(x-1))});
			12.do(x = 0; {("fp"++(x=x+1)++"h").asSymbol.envirPut([~sg2h1,~sg2h2,~sg2h3,~sg2h4,~sg2h5,~sg2h6,~sg2h7,~sg2h8,~sg2h9,~sg2h10,~sg2h11,~sg2h12].at(x-1))});

			~setgroup1.value = 0;
			~setgroup3.value = 0;
			~setgroup4.value = 0;
			~setgroup5.value = 0;
			~setgroup6.value = 0;
			~setgroup7.value = 0;
			~setgroup8.value = 0;

			~setgroupval = 2;
		});
	});
	~setgroup3 = Button.new(w,Rect(Window.screenBounds.width-(Window.screenBounds.width/2)-(20*2),~bpt+69+5,20,20/1.6180339887499)).states_([["g3",Color.white,Color.black],["s3",Color.green,Color.black]]).action_({arg button;

		if(button.value == 1, {
			12.do(x = 0; {("fp"++(x=x+1)).asSymbol.envirPut([~sg3a1,~sg3a2,~sg3a3,~sg3a4,~sg3a5,~sg3a6,~sg3a7,~sg3a8,~sg3a9,~sg3a10,~sg3a11,~sg3a12].at(x-1))});
			12.do(x = 0; {("fp"++(x=x+1)++"b").asSymbol.envirPut([~sg3b1,~sg3b2,~sg3b3,~sg3b4,~sg3b5,~sg3b6,~sg3b7,~sg3b8,~sg3b9,~sg3b10,~sg3b11,~sg3b12].at(x-1))});
			12.do(x = 0; {("fp"++(x=x+1)++"c").asSymbol.envirPut([~sg3c1,~sg3c2,~sg3c3,~sg3c4,~sg3c5,~sg3c6,~sg3c7,~sg3c8,~sg3c9,~sg3c10,~sg3c11,~sg3c12].at(x-1))});
			12.do(x = 0; {("fp"++(x=x+1)++"d").asSymbol.envirPut([~sg3d1,~sg3d2,~sg3d3,~sg3d4,~sg3d5,~sg3d6,~sg3d7,~sg3d8,~sg3d9,~sg3d10,~sg3d11,~sg3d12].at(x-1))});
			12.do(x = 0; {("fp"++(x=x+1)++"e").asSymbol.envirPut([~sg3e1,~sg3e2,~sg3e3,~sg3e4,~sg3e5,~sg3e6,~sg3e7,~sg3e8,~sg3e9,~sg3e10,~sg3e11,~sg3e12].at(x-1))});
			12.do(x = 0; {("fp"++(x=x+1)++"f").asSymbol.envirPut([~sg3f1,~sg3f2,~sg3f3,~sg3f4,~sg3f5,~sg3f6,~sg3f7,~sg3f8,~sg3f9,~sg3f10,~sg3f11,~sg3f12].at(x-1))});
			12.do(x = 0; {("fp"++(x=x+1)++"g").asSymbol.envirPut([~sg3g1,~sg3g2,~sg3g3,~sg3g4,~sg3g5,~sg3g6,~sg3g7,~sg3g8,~sg3g9,~sg3g10,~sg3g11,~sg3g12].at(x-1))});
			12.do(x = 0; {("fp"++(x=x+1)++"h").asSymbol.envirPut([~sg3h1,~sg3h2,~sg3h3,~sg3h4,~sg3h5,~sg3h6,~sg3h7,~sg3h8,~sg3h9,~sg3h10,~sg3h11,~sg3h12].at(x-1))});

			~setgroup1.value = 0;
			~setgroup2.value = 0;
			~setgroup4.value = 0;
			~setgroup5.value = 0;
			~setgroup6.value = 0;
			~setgroup7.value = 0;
			~setgroup8.value = 0;

			~setgroupval = 3;
		});
	});
	~setgroup4 = Button.new(w,Rect(Window.screenBounds.width-(Window.screenBounds.width/2)-(20*1),~bpt+69+5,20,20/1.6180339887499)).states_([["g4",Color.white,Color.black],["s4",Color.green,Color.black]]).action_({arg button;

		if(button.value == 1, {
			12.do(x = 0; {("fp"++(x=x+1)).asSymbol.envirPut([~sg4a1,~sg4a2,~sg4a3,~sg4a4,~sg4a5,~sg4a6,~sg4a7,~sg4a8,~sg4a9,~sg4a10,~sg4a11,~sg4a12].at(x-1))});
			12.do(x = 0; {("fp"++(x=x+1)++"b").asSymbol.envirPut([~sg4b1,~sg4b2,~sg4b3,~sg4b4,~sg4b5,~sg4b6,~sg4b7,~sg4b8,~sg4b9,~sg4b10,~sg4b11,~sg4b12].at(x-1))});
			12.do(x = 0; {("fp"++(x=x+1)++"c").asSymbol.envirPut([~sg4c1,~sg4c2,~sg4c3,~sg4c4,~sg4c5,~sg4c6,~sg4c7,~sg4c8,~sg4c9,~sg4c10,~sg4c11,~sg4c12].at(x-1))});
			12.do(x = 0; {("fp"++(x=x+1)++"d").asSymbol.envirPut([~sg4d1,~sg4d2,~sg4d3,~sg4d4,~sg4d5,~sg4d6,~sg4d7,~sg4d8,~sg4d9,~sg4d10,~sg4d11,~sg4d12].at(x-1))});
			12.do(x = 0; {("fp"++(x=x+1)++"e").asSymbol.envirPut([~sg4e1,~sg4e2,~sg4e3,~sg4e4,~sg4e5,~sg4e6,~sg4e7,~sg4e8,~sg4e9,~sg4e10,~sg4e11,~sg4e12].at(x-1))});
			12.do(x = 0; {("fp"++(x=x+1)++"f").asSymbol.envirPut([~sg4f1,~sg4f2,~sg4f3,~sg4f4,~sg4f5,~sg4f6,~sg4f7,~sg4f8,~sg4f9,~sg4f10,~sg4f11,~sg4f12].at(x-1))});
			12.do(x = 0; {("fp"++(x=x+1)++"g").asSymbol.envirPut([~sg4g1,~sg4g2,~sg4g3,~sg4g4,~sg4g5,~sg4g6,~sg4g7,~sg4g8,~sg4g9,~sg4g10,~sg4g11,~sg4g12].at(x-1))});
			12.do(x = 0; {("fp"++(x=x+1)++"h").asSymbol.envirPut([~sg4h1,~sg4h2,~sg4h3,~sg4h4,~sg4h5,~sg4h6,~sg4h7,~sg4h8,~sg4h9,~sg4h10,~sg4h11,~sg4h12].at(x-1))});

			~setgroup1.value = 0;
			~setgroup2.value = 0;
			~setgroup3.value = 0;
			~setgroup5.value = 0;
			~setgroup6.value = 0;
			~setgroup7.value = 0;
			~setgroup8.value = 0;

			~setgroupval = 4;
		});
	});
	~setgroup5 = Button.new(w,Rect(Window.screenBounds.width-(Window.screenBounds.width/2)+(0*1),~bpt+69+5,20,20/1.6180339887499)).states_([["g5",Color.white,Color.black],["s5",Color.green,Color.black]]).action_({arg button;

		if(button.value == 1, {
			12.do(x = 0; {("fp"++(x=x+1)).asSymbol.envirPut([~sg5a1,~sg5a2,~sg5a3,~sg5a4,~sg5a5,~sg5a6,~sg5a7,~sg5a8,~sg5a9,~sg5a10,~sg5a11,~sg5a12].at(x-1))});
			12.do(x = 0; {("fp"++(x=x+1)++"b").asSymbol.envirPut([~sg5b1,~sg5b2,~sg5b3,~sg5b4,~sg5b5,~sg5b6,~sg5b7,~sg5b8,~sg5b9,~sg5b10,~sg5b11,~sg5b12].at(x-1))});
			12.do(x = 0; {("fp"++(x=x+1)++"c").asSymbol.envirPut([~sg5c1,~sg5c2,~sg5c3,~sg5c4,~sg5c5,~sg5c6,~sg5c7,~sg5c8,~sg5c9,~sg5c10,~sg5c11,~sg5c12].at(x-1))});
			12.do(x = 0; {("fp"++(x=x+1)++"d").asSymbol.envirPut([~sg5d1,~sg5d2,~sg5d3,~sg5d4,~sg5d5,~sg5d6,~sg5d7,~sg5d8,~sg5d9,~sg5d10,~sg5d11,~sg5d12].at(x-1))});
			12.do(x = 0; {("fp"++(x=x+1)++"e").asSymbol.envirPut([~sg5e1,~sg5e2,~sg5e3,~sg5e4,~sg5e5,~sg5e6,~sg5e7,~sg5e8,~sg5e9,~sg5e10,~sg5e11,~sg5e12].at(x-1))});
			12.do(x = 0; {("fp"++(x=x+1)++"f").asSymbol.envirPut([~sg5f1,~sg5f2,~sg5f3,~sg5f4,~sg5f5,~sg5f6,~sg5f7,~sg5f8,~sg5f9,~sg5f10,~sg5f11,~sg5f12].at(x-1))});
			12.do(x = 0; {("fp"++(x=x+1)++"g").asSymbol.envirPut([~sg5g1,~sg5g2,~sg5g3,~sg5g4,~sg5g5,~sg5g6,~sg5g7,~sg5g8,~sg5g9,~sg5g10,~sg5g11,~sg5g12].at(x-1))});
			12.do(x = 0; {("fp"++(x=x+1)++"h").asSymbol.envirPut([~sg5h1,~sg5h2,~sg5h3,~sg5h4,~sg5h5,~sg5h6,~sg5h7,~sg5h8,~sg5h9,~sg5h10,~sg5h11,~sg5h12].at(x-1))});

			~setgroup1.value = 0;
			~setgroup2.value = 0;
			~setgroup3.value = 0;
			~setgroup4.value = 0;
			~setgroup6.value = 0;
			~setgroup7.value = 0;
			~setgroup8.value = 0;

			~setgroupval = 5;
		});
	});
	~setgroup6 = Button.new(w,Rect(Window.screenBounds.width-(Window.screenBounds.width/2)+(20*1),~bpt+69+5,20,20/1.6180339887499)).states_([["g6",Color.white,Color.black],["s6",Color.green,Color.black]]).action_({arg button;

		if(button.value == 1, {
			12.do(x = 0; {("fp"++(x=x+1)).asSymbol.envirPut([~sg6a1,~sg6a2,~sg6a3,~sg6a4,~sg6a5,~sg6a6,~sg6a7,~sg6a8,~sg6a9,~sg6a10,~sg6a11,~sg6a12].at(x-1))});
			12.do(x = 0; {("fp"++(x=x+1)++"b").asSymbol.envirPut([~sg6b1,~sg6b2,~sg6b3,~sg6b4,~sg6b5,~sg6b6,~sg6b7,~sg6b8,~sg6b9,~sg6b10,~sg6b11,~sg6b12].at(x-1))});
			12.do(x = 0; {("fp"++(x=x+1)++"c").asSymbol.envirPut([~sg6c1,~sg6c2,~sg6c3,~sg6c4,~sg6c5,~sg6c6,~sg6c7,~sg6c8,~sg6c9,~sg6c10,~sg6c11,~sg6c12].at(x-1))});
			12.do(x = 0; {("fp"++(x=x+1)++"d").asSymbol.envirPut([~sg6d1,~sg6d2,~sg6d3,~sg6d4,~sg6d5,~sg6d6,~sg6d7,~sg6d8,~sg6d9,~sg6d10,~sg6d11,~sg6d12].at(x-1))});
			12.do(x = 0; {("fp"++(x=x+1)++"e").asSymbol.envirPut([~sg6e1,~sg6e2,~sg6e3,~sg6e4,~sg6e5,~sg6e6,~sg6e7,~sg6e8,~sg6e9,~sg6e10,~sg6e11,~sg6e12].at(x-1))});
			12.do(x = 0; {("fp"++(x=x+1)++"f").asSymbol.envirPut([~sg6f1,~sg6f2,~sg6f3,~sg6f4,~sg6f5,~sg6f6,~sg6f7,~sg6f8,~sg6f9,~sg6f10,~sg6f11,~sg6f12].at(x-1))});
			12.do(x = 0; {("fp"++(x=x+1)++"g").asSymbol.envirPut([~sg6g1,~sg6g2,~sg6g3,~sg6g4,~sg6g5,~sg6g6,~sg6g7,~sg6g8,~sg6g9,~sg6g10,~sg6g11,~sg6g12].at(x-1))});
			12.do(x = 0; {("fp"++(x=x+1)++"h").asSymbol.envirPut([~sg6h1,~sg6h2,~sg6h3,~sg6h4,~sg6h5,~sg6h6,~sg6h7,~sg6h8,~sg6h9,~sg6h10,~sg6h11,~sg6h12].at(x-1))});

			~setgroup1.value = 0;
			~setgroup2.value = 0;
			~setgroup3.value = 0;
			~setgroup4.value = 0;
			~setgroup5.value = 0;
			~setgroup7.value = 0;
			~setgroup8.value = 0;

			~setgroupval = 6;
		});
	});
	~setgroup7 = Button.new(w,Rect(Window.screenBounds.width-(Window.screenBounds.width/2)+(20*2),~bpt+69+5,20,20/1.6180339887499)).states_([["g7",Color.white,Color.black],["s7",Color.green,Color.black]]).action_({arg button;

		if(button.value == 1, {
			12.do(x = 0; {("fp"++(x=x+1)).asSymbol.envirPut([~sg7a1,~sg7a2,~sg7a3,~sg7a4,~sg7a5,~sg7a6,~sg7a7,~sg7a8,~sg7a9,~sg7a10,~sg7a11,~sg7a12].at(x-1))});
			12.do(x = 0; {("fp"++(x=x+1)++"b").asSymbol.envirPut([~sg7b1,~sg7b2,~sg7b3,~sg7b4,~sg7b5,~sg7b6,~sg7b7,~sg7b8,~sg7b9,~sg7b10,~sg7b11,~sg7b12].at(x-1))});
			12.do(x = 0; {("fp"++(x=x+1)++"c").asSymbol.envirPut([~sg7c1,~sg7c2,~sg7c3,~sg7c4,~sg7c5,~sg7c6,~sg7c7,~sg7c8,~sg7c9,~sg7c10,~sg7c11,~sg7c12].at(x-1))});
			12.do(x = 0; {("fp"++(x=x+1)++"d").asSymbol.envirPut([~sg7d1,~sg7d2,~sg7d3,~sg7d4,~sg7d5,~sg7d6,~sg7d7,~sg7d8,~sg7d9,~sg7d10,~sg7d11,~sg7d12].at(x-1))});
			12.do(x = 0; {("fp"++(x=x+1)++"e").asSymbol.envirPut([~sg7e1,~sg7e2,~sg7e3,~sg7e4,~sg7e5,~sg7e6,~sg7e7,~sg7e8,~sg7e9,~sg7e10,~sg7e11,~sg7e12].at(x-1))});
			12.do(x = 0; {("fp"++(x=x+1)++"f").asSymbol.envirPut([~sg7f1,~sg7f2,~sg7f3,~sg7f4,~sg7f5,~sg7f6,~sg7f7,~sg7f8,~sg7f9,~sg7f10,~sg7f11,~sg7f12].at(x-1))});
			12.do(x = 0; {("fp"++(x=x+1)++"g").asSymbol.envirPut([~sg7g1,~sg7g2,~sg7g3,~sg7g4,~sg7g5,~sg7g6,~sg7g7,~sg7g8,~sg7g9,~sg7g10,~sg7g11,~sg7g12].at(x-1))});
			12.do(x = 0; {("fp"++(x=x+1)++"h").asSymbol.envirPut([~sg7h1,~sg7h2,~sg7h3,~sg7h4,~sg7h5,~sg7h6,~sg7h7,~sg7h8,~sg7h9,~sg7h10,~sg7h11,~sg7h12].at(x-1))});

			~setgroup1.value = 0;
			~setgroup2.value = 0;
			~setgroup3.value = 0;
			~setgroup4.value = 0;
			~setgroup5.value = 0;
			~setgroup6.value = 0;
			~setgroup8.value = 0;

			~setgroupval = 7;
		});
	});
	~setgroup8 = Button.new(w,Rect(Window.screenBounds.width-(Window.screenBounds.width/2)+(20*3),~bpt+69+5,20,20/1.6180339887499)).states_([["g8",Color.white,Color.black],["s8",Color.green,Color.black]]).action_({arg button;

		if(button.value == 1, {
			12.do(x = 0; {("fp"++(x=x+1)).asSymbol.envirPut([~sg8a1,~sg8a2,~sg8a3,~sg8a4,~sg8a5,~sg8a6,~sg8a7,~sg8a8,~sg8a9,~sg8a10,~sg8a11,~sg8a12].at(x-1))});
			12.do(x = 0; {("fp"++(x=x+1)++"b").asSymbol.envirPut([~sg8b1,~sg8b2,~sg8b3,~sg8b4,~sg8b5,~sg8b6,~sg8b7,~sg8b8,~sg8b9,~sg8b10,~sg8b11,~sg8b12].at(x-1))});
			12.do(x = 0; {("fp"++(x=x+1)++"c").asSymbol.envirPut([~sg8c1,~sg8c2,~sg8c3,~sg8c4,~sg8c5,~sg8c6,~sg8c7,~sg8c8,~sg8c9,~sg8c10,~sg8c11,~sg8c12].at(x-1))});
			12.do(x = 0; {("fp"++(x=x+1)++"d").asSymbol.envirPut([~sg8d1,~sg8d2,~sg8d3,~sg8d4,~sg8d5,~sg8d6,~sg8d7,~sg8d8,~sg8d9,~sg8d10,~sg8d11,~sg8d12].at(x-1))});
			12.do(x = 0; {("fp"++(x=x+1)++"e").asSymbol.envirPut([~sg8e1,~sg8e2,~sg8e3,~sg8e4,~sg8e5,~sg8e6,~sg8e7,~sg8e8,~sg8e9,~sg8e10,~sg8e11,~sg8e12].at(x-1))});
			12.do(x = 0; {("fp"++(x=x+1)++"f").asSymbol.envirPut([~sg8f1,~sg8f2,~sg8f3,~sg8f4,~sg8f5,~sg8f6,~sg8f7,~sg8f8,~sg8f9,~sg8f10,~sg8f11,~sg8f12].at(x-1))});
			12.do(x = 0; {("fp"++(x=x+1)++"g").asSymbol.envirPut([~sg8g1,~sg8g2,~sg8g3,~sg8g4,~sg8g5,~sg8g6,~sg8g7,~sg8g8,~sg8g9,~sg8g10,~sg8g11,~sg8g12].at(x-1))});
			12.do(x = 0; {("fp"++(x=x+1)++"h").asSymbol.envirPut([~sg8h1,~sg8h2,~sg8h3,~sg8h4,~sg8h5,~sg8h6,~sg8h7,~sg8h8,~sg8h9,~sg8h10,~sg8h11,~sg8h12].at(x-1))});

			~setgroup1.value = 0;
			~setgroup2.value = 0;
			~setgroup3.value = 0;
			~setgroup4.value = 0;
			~setgroup5.value = 0;
			~setgroup6.value = 0;
			~setgroup7.value = 0;

			~setgroupval = 8;
		});
	});


	//if setgroup values are nil

	if(~setgroupval == nil, {~setgroup1.value = 1;});
	if(~setgroupval == 1, {~setgroup1.value = 1;});
	if(~setgroupval == 2, {~setgroup2.value = 1;});
	if(~setgroupval == 3, {~setgroup3.value = 1;});
	if(~setgroupval == 4, {~setgroup4.value = 1;});
	if(~setgroupval == 5, {~setgroup5.value = 1;});
	if(~setgroupval == 6, {~setgroup6.value = 1;});
	if(~setgroupval == 7, {~setgroup7.value = 1;});
	if(~setgroupval == 8, {~setgroup8.value = 1;});


	//save chord notes buttons, s1-s8

	n1 = Button.new(w,Rect(Window.screenBounds.width-(Window.screenBounds.width/2)-(60*2),Window.screenBounds.height-88,60,60/1.6180339887499)).states_([["s1",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button; if(((button.value == 0) or: (button.value == 1)), {~r1=~fp1;~r2=~fp2;~r3=~fp3;~r4=~fp4;~r5=~fp5;~r6=~fp6;~r7=~fp7;~r8=~fp8;~r9=~fp9;~r10=~fp10;~r11=~fp11;~r12=~fp12; 12.do(x = 0; {("fp"++(x=x+1)).asSymbol.envirPut([ ~f1,~f2,~f3,~f4,~f5,~f6,~f7,~f8,~f9,~f10,~f11,~f12 ].at(x-1))}); "s"++"\n"++[ ~f1,~f2,~f3,~f4,~f5,~f6,~f7,~f8,~f9,~f10,~f11,~f12 ].asString.postString; ~u1=~f1;~u2=~f2;~u3=~f3;~u4=~f4;~u5=~f5;~u6=~f6;~u7=~f7;~u8=~f8;~u9=~f9;~u10=~f10;~u11=~f11;~u12=~f12; ~si1aset.value;~si1bset.value;

		if(~setgroup1.value == 1, {12.do(x = 0; {("sg1a"++(x=x+1)).asSymbol.envirPut([~fp1,~fp2,~fp3,~fp4,~fp5,~fp6,~fp7,~fp8,~fp9,~fp10,~fp11,~fp12].at(x-1))});});
		if(~setgroup2.value == 1, {12.do(x = 0; {("sg2a"++(x=x+1)).asSymbol.envirPut([~fp1,~fp2,~fp3,~fp4,~fp5,~fp6,~fp7,~fp8,~fp9,~fp10,~fp11,~fp12].at(x-1))});});
		if(~setgroup3.value == 1, {12.do(x = 0; {("sg3a"++(x=x+1)).asSymbol.envirPut([~fp1,~fp2,~fp3,~fp4,~fp5,~fp6,~fp7,~fp8,~fp9,~fp10,~fp11,~fp12].at(x-1))});});
		if(~setgroup4.value == 1, {12.do(x = 0; {("sg4a"++(x=x+1)).asSymbol.envirPut([~fp1,~fp2,~fp3,~fp4,~fp5,~fp6,~fp7,~fp8,~fp9,~fp10,~fp11,~fp12].at(x-1))});});
		if(~setgroup5.value == 1, {12.do(x = 0; {("sg5a"++(x=x+1)).asSymbol.envirPut([~fp1,~fp2,~fp3,~fp4,~fp5,~fp6,~fp7,~fp8,~fp9,~fp10,~fp11,~fp12].at(x-1))});});
		if(~setgroup6.value == 1, {12.do(x = 0; {("sg6a"++(x=x+1)).asSymbol.envirPut([~fp1,~fp2,~fp3,~fp4,~fp5,~fp6,~fp7,~fp8,~fp9,~fp10,~fp11,~fp12].at(x-1))});});
		if(~setgroup7.value == 1, {12.do(x = 0; {("sg7a"++(x=x+1)).asSymbol.envirPut([~fp1,~fp2,~fp3,~fp4,~fp5,~fp6,~fp7,~fp8,~fp9,~fp10,~fp11,~fp12].at(x-1))});});
		if(~setgroup8.value == 1, {12.do(x = 0; {("sg8a"++(x=x+1)).asSymbol.envirPut([~fp1,~fp2,~fp3,~fp4,~fp5,~fp6,~fp7,~fp8,~fp9,~fp10,~fp11,~fp12].at(x-1))});});

		n1.states_([["s1",Color.green,Color.black]]);
		n2.states_([["s2",Color.white,Color.black]]);
		n3.states_([["s3",Color.white,Color.black]]);
		n4.states_([["s4",Color.white,Color.black]]);
		n5.states_([["s5",Color.white,Color.black]]);
		n6.states_([["s6",Color.white,Color.black]]);
		n7.states_([["s7",Color.white,Color.black]]);
		n8.states_([["s8",Color.white,Color.black]]);
	});});

	n2 = Button.new(w,Rect(Window.screenBounds.width-(Window.screenBounds.width/2)-(60*1),Window.screenBounds.height-88,60,60/1.6180339887499)).states_([["s2",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button; if(((button.value == 0) or: (button.value == 1)), {~r1b=~fp1b;~r2b=~fp2b;~r3b=~fp3b;~r4b=~fp4b;~r5b=~fp5b;~r6b=~fp6b;~r7b=~fp7b;~r8b=~fp8b;~r9b=~fp9b;~r10b=~fp10b;~r11b=~fp11b;~r12b=~fp12b; 12.do(x = 0; {("fp"++(x=x+1)++"b").asSymbol.envirPut([ ~f1,~f2,~f3,~f4,~f5,~f6,~f7,~f8,~f9,~f10,~f11,~f12 ].at(x-1))}); "s"++"\n"++[ ~f1,~f2,~f3,~f4,~f5,~f6,~f7,~f8,~f9,~f10,~f11,~f12 ].asString.postString; ~u1b=~f1;~u2b=~f2;~u3b=~f3;~u4b=~f4;~u5b=~f5;~u6b=~f6;~u7b=~f7;~u8b=~f8;~u9b=~f9;~u10b=~f10;~u11b=~f11;~u12b=~f12; ~si2set.value;

		if(~setgroup1.value == 1, {12.do(x = 0; {("sg1b"++(x=x+1)).asSymbol.envirPut([~fp1b,~fp2b,~fp3b,~fp4b,~fp5b,~fp6b,~fp7b,~fp8b,~fp9b,~fp10b,~fp11b,~fp12b].at(x-1))});});
		if(~setgroup2.value == 1, {12.do(x = 0; {("sg2b"++(x=x+1)).asSymbol.envirPut([~fp1b,~fp2b,~fp3b,~fp4b,~fp5b,~fp6b,~fp7b,~fp8b,~fp9b,~fp10b,~fp11b,~fp12b].at(x-1))});});
		if(~setgroup3.value == 1, {12.do(x = 0; {("sg3b"++(x=x+1)).asSymbol.envirPut([~fp1b,~fp2b,~fp3b,~fp4b,~fp5b,~fp6b,~fp7b,~fp8b,~fp9b,~fp10b,~fp11b,~fp12b].at(x-1))});});
		if(~setgroup4.value == 1, {12.do(x = 0; {("sg4b"++(x=x+1)).asSymbol.envirPut([~fp1b,~fp2b,~fp3b,~fp4b,~fp5b,~fp6b,~fp7b,~fp8b,~fp9b,~fp10b,~fp11b,~fp12b].at(x-1))});});
		if(~setgroup5.value == 1, {12.do(x = 0; {("sg5b"++(x=x+1)).asSymbol.envirPut([~fp1b,~fp2b,~fp3b,~fp4b,~fp5b,~fp6b,~fp7b,~fp8b,~fp9b,~fp10b,~fp11b,~fp12b].at(x-1))});});
		if(~setgroup6.value == 1, {12.do(x = 0; {("sg6b"++(x=x+1)).asSymbol.envirPut([~fp1b,~fp2b,~fp3b,~fp4b,~fp5b,~fp6b,~fp7b,~fp8b,~fp9b,~fp10b,~fp11b,~fp12b].at(x-1))});});
		if(~setgroup7.value == 1, {12.do(x = 0; {("sg7b"++(x=x+1)).asSymbol.envirPut([~fp1b,~fp2b,~fp3b,~fp4b,~fp5b,~fp6b,~fp7b,~fp8b,~fp9b,~fp10b,~fp11b,~fp12b].at(x-1))});});
		if(~setgroup8.value == 1, {12.do(x = 0; {("sg8b"++(x=x+1)).asSymbol.envirPut([~fp1b,~fp2b,~fp3b,~fp4b,~fp5b,~fp6b,~fp7b,~fp8b,~fp9b,~fp10b,~fp11b,~fp12b].at(x-1))});});

		n1.states_([["s1",Color.white,Color.black]]);
		n2.states_([["s2",Color.green,Color.black]]);
		n3.states_([["s3",Color.white,Color.black]]);
		n4.states_([["s4",Color.white,Color.black]]);
		n5.states_([["s5",Color.white,Color.black]]);
		n6.states_([["s6",Color.white,Color.black]]);
		n7.states_([["s7",Color.white,Color.black]]);
		n8.states_([["s8",Color.white,Color.black]]);
	});});
	n3 = Button.new(w,Rect(Window.screenBounds.width-(Window.screenBounds.width/2)+(0),   Window.screenBounds.height-88,60,60/1.6180339887499)).states_([["s3",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button; if(((button.value == 0) or: (button.value == 1)), {~r1c=~fp1c;~r2c=~fp2c;~r3c=~fp3c;~r4c=~fp4c;~r5c=~fp5c;~r6c=~fp6c;~r7c=~fp7c;~r8c=~fp8c;~r9c=~fp9c;~r10c=~fp10c;~r11c=~fp11c;~r12c=~fp12c; 12.do(x = 0; {("fp"++(x=x+1)++"c").asSymbol.envirPut([ ~f1,~f2,~f3,~f4,~f5,~f6,~f7,~f8,~f9,~f10,~f11,~f12 ].at(x-1))}); "s"++"\n"++[ ~f1,~f2,~f3,~f4,~f5,~f6,~f7,~f8,~f9,~f10,~f11,~f12 ].asString.postString; ~u1c=~f1;~u2c=~f2;~u3c=~f3;~u4c=~f4;~u5c=~f5;~u6c=~f6;~u7c=~f7;~u8c=~f8;~u9c=~f9;~u10c=~f10;~u11c=~f11;~u12c=~f12; ~si3set.value;

		if(~setgroup1.value == 1, {12.do(x = 0; {("sg1c"++(x=x+1)).asSymbol.envirPut([~fp1c,~fp2c,~fp3c,~fp4c,~fp5c,~fp6c,~fp7c,~fp8c,~fp9c,~fp10c,~fp11c,~fp12c].at(x-1))});});
		if(~setgroup2.value == 1, {12.do(x = 0; {("sg2c"++(x=x+1)).asSymbol.envirPut([~fp1c,~fp2c,~fp3c,~fp4c,~fp5c,~fp6c,~fp7c,~fp8c,~fp9c,~fp10c,~fp11c,~fp12c].at(x-1))});});
		if(~setgroup3.value == 1, {12.do(x = 0; {("sg3c"++(x=x+1)).asSymbol.envirPut([~fp1c,~fp2c,~fp3c,~fp4c,~fp5c,~fp6c,~fp7c,~fp8c,~fp9c,~fp10c,~fp11c,~fp12c].at(x-1))});});
		if(~setgroup4.value == 1, {12.do(x = 0; {("sg4c"++(x=x+1)).asSymbol.envirPut([~fp1c,~fp2c,~fp3c,~fp4c,~fp5c,~fp6c,~fp7c,~fp8c,~fp9c,~fp10c,~fp11c,~fp12c].at(x-1))});});
		if(~setgroup5.value == 1, {12.do(x = 0; {("sg5c"++(x=x+1)).asSymbol.envirPut([~fp1c,~fp2c,~fp3c,~fp4c,~fp5c,~fp6c,~fp7c,~fp8c,~fp9c,~fp10c,~fp11c,~fp12c].at(x-1))});});
		if(~setgroup6.value == 1, {12.do(x = 0; {("sg6c"++(x=x+1)).asSymbol.envirPut([~fp1c,~fp2c,~fp3c,~fp4c,~fp5c,~fp6c,~fp7c,~fp8c,~fp9c,~fp10c,~fp11c,~fp12c].at(x-1))});});
		if(~setgroup7.value == 1, {12.do(x = 0; {("sg7c"++(x=x+1)).asSymbol.envirPut([~fp1c,~fp2c,~fp3c,~fp4c,~fp5c,~fp6c,~fp7c,~fp8c,~fp9c,~fp10c,~fp11c,~fp12c].at(x-1))});});
		if(~setgroup8.value == 1, {12.do(x = 0; {("sg8c"++(x=x+1)).asSymbol.envirPut([~fp1c,~fp2c,~fp3c,~fp4c,~fp5c,~fp6c,~fp7c,~fp8c,~fp9c,~fp10c,~fp11c,~fp12c].at(x-1))});});

		n1.states_([["s1",Color.white,Color.black]]);
		n2.states_([["s2",Color.white,Color.black]]);
		n3.states_([["s3",Color.green,Color.black]]);
		n4.states_([["s4",Color.white,Color.black]]);
		n5.states_([["s5",Color.white,Color.black]]);
		n6.states_([["s6",Color.white,Color.black]]);
		n7.states_([["s7",Color.white,Color.black]]);
		n8.states_([["s8",Color.white,Color.black]]);
	});});
	n4 = Button.new(w,Rect(Window.screenBounds.width-(Window.screenBounds.width/2)+(60*1),Window.screenBounds.height-88,60,60/1.6180339887499)).states_([["s4",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button; if(((button.value == 0) or: (button.value == 1)), {~r1d=~fp1d;~r2d=~fp2d;~r3d=~fp3d;~r4d=~fp4d;~r5d=~fp5d;~r6d=~fp6d;~r7d=~fp7d;~r8d=~fp8d;~r9d=~fp9d;~r10d=~fp10d;~r11d=~fp11d;~r12d=~fp12d; 12.do(x = 0; {("fp"++(x=x+1)++"d").asSymbol.envirPut([ ~f1,~f2,~f3,~f4,~f5,~f6,~f7,~f8,~f9,~f10,~f11,~f12 ].at(x-1))}); "s"++"\n"++[ ~f1,~f2,~f3,~f4,~f5,~f6,~f7,~f8,~f9,~f10,~f11,~f12 ].asString.postString; ~u1d=~f1;~u2d=~f2;~u3d=~f3;~u4d=~f4;~u5d=~f5;~u6d=~f6;~u7d=~f7;~u8d=~f8;~u9d=~f9;~u10d=~f10;~u11d=~f11;~u12d=~f12; ~si4set.value;

		if(~setgroup1.value == 1, {12.do(x = 0; {("sg1d"++(x=x+1)).asSymbol.envirPut([~fp1d,~fp2d,~fp3d,~fp4d,~fp5d,~fp6d,~fp7d,~fp8d,~fp9d,~fp10d,~fp11d,~fp12d].at(x-1))});});
		if(~setgroup2.value == 1, {12.do(x = 0; {("sg2d"++(x=x+1)).asSymbol.envirPut([~fp1d,~fp2d,~fp3d,~fp4d,~fp5d,~fp6d,~fp7d,~fp8d,~fp9d,~fp10d,~fp11d,~fp12d].at(x-1))});});
		if(~setgroup3.value == 1, {12.do(x = 0; {("sg3d"++(x=x+1)).asSymbol.envirPut([~fp1d,~fp2d,~fp3d,~fp4d,~fp5d,~fp6d,~fp7d,~fp8d,~fp9d,~fp10d,~fp11d,~fp12d].at(x-1))});});
		if(~setgroup4.value == 1, {12.do(x = 0; {("sg4d"++(x=x+1)).asSymbol.envirPut([~fp1d,~fp2d,~fp3d,~fp4d,~fp5d,~fp6d,~fp7d,~fp8d,~fp9d,~fp10d,~fp11d,~fp12d].at(x-1))});});
		if(~setgroup5.value == 1, {12.do(x = 0; {("sg5d"++(x=x+1)).asSymbol.envirPut([~fp1d,~fp2d,~fp3d,~fp4d,~fp5d,~fp6d,~fp7d,~fp8d,~fp9d,~fp10d,~fp11d,~fp12d].at(x-1))});});
		if(~setgroup6.value == 1, {12.do(x = 0; {("sg6d"++(x=x+1)).asSymbol.envirPut([~fp1d,~fp2d,~fp3d,~fp4d,~fp5d,~fp6d,~fp7d,~fp8d,~fp9d,~fp10d,~fp11d,~fp12d].at(x-1))});});
		if(~setgroup7.value == 1, {12.do(x = 0; {("sg7d"++(x=x+1)).asSymbol.envirPut([~fp1d,~fp2d,~fp3d,~fp4d,~fp5d,~fp6d,~fp7d,~fp8d,~fp9d,~fp10d,~fp11d,~fp12d].at(x-1))});});
		if(~setgroup8.value == 1, {12.do(x = 0; {("sg8d"++(x=x+1)).asSymbol.envirPut([~fp1d,~fp2d,~fp3d,~fp4d,~fp5d,~fp6d,~fp7d,~fp8d,~fp9d,~fp10d,~fp11d,~fp12d].at(x-1))});});

		n1.states_([["s1",Color.white,Color.black]]);
		n2.states_([["s2",Color.white,Color.black]]);
		n3.states_([["s3",Color.white,Color.black]]);
		n4.states_([["s4",Color.green,Color.black]]);
		n5.states_([["s5",Color.white,Color.black]]);
		n6.states_([["s6",Color.white,Color.black]]);
		n7.states_([["s7",Color.white,Color.black]]);
		n8.states_([["s8",Color.white,Color.black]]);
	});});
	n5 = Button.new(w,Rect(Window.screenBounds.width-(Window.screenBounds.width/2)-(60*2),Window.screenBounds.height-52,60,60/1.6180339887499)).states_([["s5",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button; if(((button.value == 0) or: (button.value == 1)), {~r1e=~fp1e;~r2e=~fp2e;~r3e=~fp3e;~r4e=~fp4e;~r5e=~fp5e;~r6e=~fp6e;~r7e=~fp7e;~r8e=~fp8e;~r9e=~fp9e;~r10e=~fp10e;~r11e=~fp11e;~r12e=~fp12e; 12.do(x = 0; {("fp"++(x=x+1)++"e").asSymbol.envirPut([ ~f1,~f2,~f3,~f4,~f5,~f6,~f7,~f8,~f9,~f10,~f11,~f12 ].at(x-1))}); "s"++"\n"++[ ~f1,~f2,~f3,~f4,~f5,~f6,~f7,~f8,~f9,~f10,~f11,~f12 ].asString.postString; ~u1e=~f1;~u2e=~f2;~u3e=~f3;~u4e=~f4;~u5e=~f5;~u6e=~f6;~u7e=~f7;~u8e=~f8;~u9e=~f9;~u10e=~f10;~u11e=~f11;~u12e=~f12; ~si5set.value;

		if(~setgroup1.value == 1, {12.do(x = 0; {("sg1e"++(x=x+1)).asSymbol.envirPut([~fp1e,~fp2e,~fp3e,~fp4e,~fp5e,~fp6e,~fp7e,~fp8e,~fp9e,~fp10e,~fp11e,~fp12e].at(x-1))});});
		if(~setgroup2.value == 1, {12.do(x = 0; {("sg2e"++(x=x+1)).asSymbol.envirPut([~fp1e,~fp2e,~fp3e,~fp4e,~fp5e,~fp6e,~fp7e,~fp8e,~fp9e,~fp10e,~fp11e,~fp12e].at(x-1))});});
		if(~setgroup3.value == 1, {12.do(x = 0; {("sg3e"++(x=x+1)).asSymbol.envirPut([~fp1e,~fp2e,~fp3e,~fp4e,~fp5e,~fp6e,~fp7e,~fp8e,~fp9e,~fp10e,~fp11e,~fp12e].at(x-1))});});
		if(~setgroup4.value == 1, {12.do(x = 0; {("sg4e"++(x=x+1)).asSymbol.envirPut([~fp1e,~fp2e,~fp3e,~fp4e,~fp5e,~fp6e,~fp7e,~fp8e,~fp9e,~fp10e,~fp11e,~fp12e].at(x-1))});});
		if(~setgroup5.value == 1, {12.do(x = 0; {("sg5e"++(x=x+1)).asSymbol.envirPut([~fp1e,~fp2e,~fp3e,~fp4e,~fp5e,~fp6e,~fp7e,~fp8e,~fp9e,~fp10e,~fp11e,~fp12e].at(x-1))});});
		if(~setgroup6.value == 1, {12.do(x = 0; {("sg6e"++(x=x+1)).asSymbol.envirPut([~fp1e,~fp2e,~fp3e,~fp4e,~fp5e,~fp6e,~fp7e,~fp8e,~fp9e,~fp10e,~fp11e,~fp12e].at(x-1))});});
		if(~setgroup7.value == 1, {12.do(x = 0; {("sg7e"++(x=x+1)).asSymbol.envirPut([~fp1e,~fp2e,~fp3e,~fp4e,~fp5e,~fp6e,~fp7e,~fp8e,~fp9e,~fp10e,~fp11e,~fp12e].at(x-1))});});
		if(~setgroup8.value == 1, {12.do(x = 0; {("sg8e"++(x=x+1)).asSymbol.envirPut([~fp1e,~fp2e,~fp3e,~fp4e,~fp5e,~fp6e,~fp7e,~fp8e,~fp9e,~fp10e,~fp11e,~fp12e].at(x-1))});});

		n1.states_([["s1",Color.white,Color.black]]);
		n2.states_([["s2",Color.white,Color.black]]);
		n3.states_([["s3",Color.white,Color.black]]);
		n4.states_([["s4",Color.white,Color.black]]);
		n5.states_([["s5",Color.green,Color.black]]);
		n6.states_([["s6",Color.white,Color.black]]);
		n7.states_([["s7",Color.white,Color.black]]);
		n8.states_([["s8",Color.white,Color.black]]);
	});});
	n6 = Button.new(w,Rect(Window.screenBounds.width-(Window.screenBounds.width/2)-(60*1),Window.screenBounds.height-52,60,60/1.6180339887499)).states_([["s6",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button; if(((button.value == 0) or: (button.value == 1)), {~r1f=~fp1f;~r2f=~fp2f;~r3f=~fp3f;~r4f=~fp4f;~r5f=~fp5f;~r6f=~fp6f;~r7f=~fp7f;~r8f=~fp8f;~r9f=~fp9f;~r10f=~fp10f;~r11f=~fp11f;~r12f=~fp12f; 12.do(x = 0; {("fp"++(x=x+1)++"f").asSymbol.envirPut([ ~f1,~f2,~f3,~f4,~f5,~f6,~f7,~f8,~f9,~f10,~f11,~f12 ].at(x-1))}); "s"++"\n"++[ ~f1,~f2,~f3,~f4,~f5,~f6,~f7,~f8,~f9,~f10,~f11,~f12 ].asString.postString; ~u1f=~f1;~u2f=~f2;~u3f=~f3;~u4f=~f4;~u5f=~f5;~u6f=~f6;~u7f=~f7;~u8f=~f8;~u9f=~f9;~u10f=~f10;~u11e=~f11;~u12f=~f12; ~si6set.value;

		if(~setgroup1.value == 1, {12.do(x = 0; {("sg1f"++(x=x+1)).asSymbol.envirPut([~fp1f,~fp2f,~fp3f,~fp4f,~fp5f,~fp6f,~fp7f,~fp8f,~fp9f,~fp10f,~fp11f,~fp12f].at(x-1))});});
		if(~setgroup2.value == 1, {12.do(x = 0; {("sg2f"++(x=x+1)).asSymbol.envirPut([~fp1f,~fp2f,~fp3f,~fp4f,~fp5f,~fp6f,~fp7f,~fp8f,~fp9f,~fp10f,~fp11f,~fp12f].at(x-1))});});
		if(~setgroup3.value == 1, {12.do(x = 0; {("sg3f"++(x=x+1)).asSymbol.envirPut([~fp1f,~fp2f,~fp3f,~fp4f,~fp5f,~fp6f,~fp7f,~fp8f,~fp9f,~fp10f,~fp11f,~fp12f].at(x-1))});});
		if(~setgroup4.value == 1, {12.do(x = 0; {("sg4f"++(x=x+1)).asSymbol.envirPut([~fp1f,~fp2f,~fp3f,~fp4f,~fp5f,~fp6f,~fp7f,~fp8f,~fp9f,~fp10f,~fp11f,~fp12f].at(x-1))});});
		if(~setgroup5.value == 1, {12.do(x = 0; {("sg5f"++(x=x+1)).asSymbol.envirPut([~fp1f,~fp2f,~fp3f,~fp4f,~fp5f,~fp6f,~fp7f,~fp8f,~fp9f,~fp10f,~fp11f,~fp12f].at(x-1))});});
		if(~setgroup6.value == 1, {12.do(x = 0; {("sg6f"++(x=x+1)).asSymbol.envirPut([~fp1f,~fp2f,~fp3f,~fp4f,~fp5f,~fp6f,~fp7f,~fp8f,~fp9f,~fp10f,~fp11f,~fp12f].at(x-1))});});
		if(~setgroup7.value == 1, {12.do(x = 0; {("sg7f"++(x=x+1)).asSymbol.envirPut([~fp1f,~fp2f,~fp3f,~fp4f,~fp5f,~fp6f,~fp7f,~fp8f,~fp9f,~fp10f,~fp11f,~fp12f].at(x-1))});});
		if(~setgroup8.value == 1, {12.do(x = 0; {("sg8f"++(x=x+1)).asSymbol.envirPut([~fp1f,~fp2f,~fp3f,~fp4f,~fp5f,~fp6f,~fp7f,~fp8f,~fp9f,~fp10f,~fp11f,~fp12f].at(x-1))});});

		n1.states_([["s1",Color.white,Color.black]]);
		n2.states_([["s2",Color.white,Color.black]]);
		n3.states_([["s3",Color.white,Color.black]]);
		n4.states_([["s4",Color.white,Color.black]]);
		n5.states_([["s5",Color.white,Color.black]]);
		n6.states_([["s6",Color.green,Color.black]]);
		n7.states_([["s7",Color.white,Color.black]]);
		n8.states_([["s8",Color.white,Color.black]]);
	});});
	n7 = Button.new(w,Rect(Window.screenBounds.width-(Window.screenBounds.width/2)+(0),   Window.screenBounds.height-52,60,60/1.6180339887499)).states_([["s7",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button; if(((button.value == 0) or: (button.value == 1)), {~r1g=~fp1g;~r2g=~fp2g;~r3g=~fp3g;~r4g=~fp4g;~r5g=~fp5g;~r6g=~fp6g;~r7g=~fp7g;~r8g=~fp8g;~r9g=~fp9g;~r10g=~fp10g;~r11g=~fp11g;~r12g=~fp12g; 12.do(x = 0; {("fp"++(x=x+1)++"g").asSymbol.envirPut([ ~f1,~f2,~f3,~f4,~f5,~f6,~f7,~f8,~f9,~f10,~f11,~f12 ].at(x-1))}); "s"++"\n"++[ ~f1,~f2,~f3,~f4,~f5,~f6,~f7,~f8,~f9,~f10,~f11,~f12 ].asString.postString; ~u1g=~f1;~u2g=~f2;~u3g=~f3;~u4g=~f4;~u5g=~f5;~u6g=~f6;~u7g=~f7;~u8g=~f8;~u9g=~f9;~u10g=~f10;~u11f=~f11;~u12g=~f12; ~si7set.value;

		if(~setgroup1.value == 1, {12.do(x = 0; {("sg1g"++(x=x+1)).asSymbol.envirPut([~fp1g,~fp2g,~fp3g,~fp4g,~fp5g,~fp6g,~fp7g,~fp8g,~fp9g,~fp10g,~fp11g,~fp12g].at(x-1))});});
		if(~setgroup2.value == 1, {12.do(x = 0; {("sg2g"++(x=x+1)).asSymbol.envirPut([~fp1g,~fp2g,~fp3g,~fp4g,~fp5g,~fp6g,~fp7g,~fp8g,~fp9g,~fp10g,~fp11g,~fp12g].at(x-1))});});
		if(~setgroup3.value == 1, {12.do(x = 0; {("sg3g"++(x=x+1)).asSymbol.envirPut([~fp1g,~fp2g,~fp3g,~fp4g,~fp5g,~fp6g,~fp7g,~fp8g,~fp9g,~fp10g,~fp11g,~fp12g].at(x-1))});});
		if(~setgroup4.value == 1, {12.do(x = 0; {("sg4g"++(x=x+1)).asSymbol.envirPut([~fp1g,~fp2g,~fp3g,~fp4g,~fp5g,~fp6g,~fp7g,~fp8g,~fp9g,~fp10g,~fp11g,~fp12g].at(x-1))});});
		if(~setgroup5.value == 1, {12.do(x = 0; {("sg5g"++(x=x+1)).asSymbol.envirPut([~fp1g,~fp2g,~fp3g,~fp4g,~fp5g,~fp6g,~fp7g,~fp8g,~fp9g,~fp10g,~fp11g,~fp12g].at(x-1))});});
		if(~setgroup6.value == 1, {12.do(x = 0; {("sg6g"++(x=x+1)).asSymbol.envirPut([~fp1g,~fp2g,~fp3g,~fp4g,~fp5g,~fp6g,~fp7g,~fp8g,~fp9g,~fp10g,~fp11g,~fp12g].at(x-1))});});
		if(~setgroup7.value == 1, {12.do(x = 0; {("sg7g"++(x=x+1)).asSymbol.envirPut([~fp1g,~fp2g,~fp3g,~fp4g,~fp5g,~fp6g,~fp7g,~fp8g,~fp9g,~fp10g,~fp11g,~fp12g].at(x-1))});});
		if(~setgroup8.value == 1, {12.do(x = 0; {("sg8g"++(x=x+1)).asSymbol.envirPut([~fp1g,~fp2g,~fp3g,~fp4g,~fp5g,~fp6g,~fp7g,~fp8g,~fp9g,~fp10g,~fp11g,~fp12g].at(x-1))});});

		n1.states_([["s1",Color.white,Color.black]]);
		n2.states_([["s2",Color.white,Color.black]]);
		n3.states_([["s3",Color.white,Color.black]]);
		n4.states_([["s4",Color.white,Color.black]]);
		n5.states_([["s5",Color.white,Color.black]]);
		n6.states_([["s6",Color.white,Color.black]]);
		n7.states_([["s7",Color.green,Color.black]]);
		n8.states_([["s8",Color.white,Color.black]]);
	});});
	n8 = Button.new(w,Rect(Window.screenBounds.width-(Window.screenBounds.width/2)+(60*1),Window.screenBounds.height-52,60,60/1.6180339887499)).states_([["s8",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button; if(((button.value == 0) or: (button.value == 1)), {~r1h=~fp1h;~r2h=~fp2h;~r3h=~fp3h;~r4h=~fp4h;~r5h=~fp5h;~r6h=~fp6h;~r7h=~fp7h;~r8h=~fp8h;~r9h=~fp9h;~r10h=~fp10h;~r11h=~fp11h;~r12h=~fp12h; 12.do(x = 0; {("fp"++(x=x+1)++"h").asSymbol.envirPut([ ~f1,~f2,~f3,~f4,~f5,~f6,~f7,~f8,~f9,~f10,~f11,~f12 ].at(x-1))}); "s"++"\n"++[ ~f1,~f2,~f3,~f4,~f5,~f6,~f7,~f8,~f9,~f10,~f11,~f12 ].asString.postString; ~u1h=~f1;~u2h=~f2;~u3h=~f3;~u4h=~f4;~u5h=~f5;~u6h=~f6;~u7h=~f7;~u8h=~f8;~u9h=~f9;~u10h=~f10;~u11g=~f11;~u12h=~f12; ~si8set.value;

		if(~setgroup1.value == 1, {12.do(x = 0; {("sg1h"++(x=x+1)).asSymbol.envirPut([~fp1h,~fp2h,~fp3h,~fp4h,~fp5h,~fp6h,~fp7h,~fp8h,~fp9h,~fp10h,~fp11h,~fp12h].at(x-1))});});
		if(~setgroup2.value == 1, {12.do(x = 0; {("sg2h"++(x=x+1)).asSymbol.envirPut([~fp1h,~fp2h,~fp3h,~fp4h,~fp5h,~fp6h,~fp7h,~fp8h,~fp9h,~fp10h,~fp11h,~fp12h].at(x-1))});});
		if(~setgroup3.value == 1, {12.do(x = 0; {("sg3h"++(x=x+1)).asSymbol.envirPut([~fp1h,~fp2h,~fp3h,~fp4h,~fp5h,~fp6h,~fp7h,~fp8h,~fp9h,~fp10h,~fp11h,~fp12h].at(x-1))});});
		if(~setgroup4.value == 1, {12.do(x = 0; {("sg4h"++(x=x+1)).asSymbol.envirPut([~fp1h,~fp2h,~fp3h,~fp4h,~fp5h,~fp6h,~fp7h,~fp8h,~fp9h,~fp10h,~fp11h,~fp12h].at(x-1))});});
		if(~setgroup5.value == 1, {12.do(x = 0; {("sg5h"++(x=x+1)).asSymbol.envirPut([~fp1h,~fp2h,~fp3h,~fp4h,~fp5h,~fp6h,~fp7h,~fp8h,~fp9h,~fp10h,~fp11h,~fp12h].at(x-1))});});
		if(~setgroup6.value == 1, {12.do(x = 0; {("sg6h"++(x=x+1)).asSymbol.envirPut([~fp1h,~fp2h,~fp3h,~fp4h,~fp5h,~fp6h,~fp7h,~fp8h,~fp9h,~fp10h,~fp11h,~fp12h].at(x-1))});});
		if(~setgroup7.value == 1, {12.do(x = 0; {("sg7h"++(x=x+1)).asSymbol.envirPut([~fp1h,~fp2h,~fp3h,~fp4h,~fp5h,~fp6h,~fp7h,~fp8h,~fp9h,~fp10h,~fp11h,~fp12h].at(x-1))});});
		if(~setgroup8.value == 1, {12.do(x = 0; {("sg8h"++(x=x+1)).asSymbol.envirPut([~fp1h,~fp2h,~fp3h,~fp4h,~fp5h,~fp6h,~fp7h,~fp8h,~fp9h,~fp10h,~fp11h,~fp12h].at(x-1))});});

		n1.states_([["s1",Color.white,Color.black]]);
		n2.states_([["s2",Color.white,Color.black]]);
		n3.states_([["s3",Color.white,Color.black]]);
		n4.states_([["s4",Color.white,Color.black]]);
		n5.states_([["s5",Color.white,Color.black]]);
		n6.states_([["s6",Color.white,Color.black]]);
		n7.states_([["s7",Color.white,Color.black]]);
		n8.states_([["s8",Color.green,Color.black]]);
	});});


	//undo saved chord pop-up menu

	~undo = PopUpMenu(w, Rect(Window.screenBounds.width-(Window.screenBounds.width/3)+39,Window.screenBounds.height-52+19.777087639995-(40/1.6180339887499)-8,40,40/1.6180339887499)).items_(["uc","u1","u2","u3","u4","u5","u6","u7","u8"]).background_(Color.black).stringColor_(Color.white).action_({arg button;});


	//set button for undo pop-up menu

	set2 = Button.new(w,Rect(Window.screenBounds.width-(Window.screenBounds.width/3)+40+39,Window.screenBounds.height-52+19.777087639995-(40/1.6180339887499)-8,40,40/1.6180339887499)).states_([["set",Color.white,Color.black]]).action_({arg button;
		case
		{~undo.value == 0}{if(([ ~f1,~f2,~f3,~f4,~f5,~f6,~f7,~f8,~f9,~f10,~f11,~f12 ] != [~undof1,~undof2,~undof3,~undof4,~undof5,~undof6,~undof7,~undof8,~undof9,~undof10,~undof11,~undof12]).postln, {12.do(x = 0; {("f"++(x=x+1)).asSymbol.envirPut([~undof1,~undof2,~undof3,~undof4,~undof5,~undof6,~undof7,~undof8,~undof9,~undof10,~undof11,~undof12].at(x-1))});}/*,{12.do(x = 0; {("f"++(x=x+1)).asSymbol.envirPut([~redof1,~redof2,~redof3,~redof4,~redof5,~redof6,~redof7,~redof8,~redof9,~redof10,~redof11,~redof12].at(x-1))});}*/);~undo.value = 0;}
		{~undo.value == 1}{if(([~fp1,~fp2,~fp3,~fp4,~fp5,~fp6,~fp7,~fp8,~fp9,~fp10,~fp11,~fp12] == [~r1,~r2,~r3,~r4,~r5,~r6,~r7,~r8,~r9,~r10,~r11,~r12]).postln, {12.do(x = 0; {("fp"++(x=x+1)).asSymbol.envirPut([~u1,~u2,~u3,~u4,~u5,~u6,~u7,~u8,~u9,~u10,~u11,~u12].at(x-1))});},{12.do(x = 0; {("fp"++(x=x+1)).asSymbol.envirPut([~r1,~r2,~r3,~r4,~r5,~r6,~r7,~r8,~r9,~r10,~r11,~r12].at(x-1))});});~undo.value = 0;}
		{~undo.value == 2}{if([~fp1b,~fp2b,~fp3b,~fp4b,~fp5b,~fp6b,~fp7b,~fp8b,~fp9b,~fp10b,~fp11b,~fp12b] == [~r1b,~r2b,~r3b,~r4b,~r5b,~r6b,~r7b,~r8b,~r9b,~r10b,~r11b,~r12b], {12.do(x = 0; {("fp"++(x=x+1)++"b").asSymbol.envirPut([~u1b,~u2b,~u3b,~u4b,~u5b,~u6b,~u7b,~u8b,~u9b,~u10b,~u11b,~u12b].at(x-1))});},{12.do(x = 0; {("fp"++(x=x+1)++"b").asSymbol.envirPut([~r1b,~r2b,~r3b,~r4b,~r5b,~r6b,~r7b,~r8b,~r9b,~r10b,~r11b,~r12b].at(x-1))});});~undo.value = 0;}
		{~undo.value == 3}{if([~fp1c,~fp2c,~fp3c,~fp4c,~fp5c,~fp6c,~fp7c,~fp8c,~fp9c,~fp10c,~fp11c,~fp12c] == [~r1c,~r2c,~r3c,~r4c,~r5c,~r6c,~r7c,~r8c,~r9c,~r10c,~r11c,~r12c], {12.do(x = 0; {("fp"++(x=x+1)++"c").asSymbol.envirPut([~u1c,~u2c,~u3c,~u4c,~u5c,~u6c,~u7c,~u8c,~u9c,~u10c,~u11c,~u12c].at(x-1))});},{12.do(x = 0; {("fp"++(x=x+1)++"c").asSymbol.envirPut([~r1c,~r2c,~r3c,~r4c,~r5c,~r6c,~r7c,~r8c,~r9c,~r10c,~r11c,~r12c].at(x-1))});});~undo.value = 0;}
		{~undo.value == 4}{if([~fp1d,~fp2d,~fp3d,~fp4d,~fp5d,~fp6d,~fp7d,~fp8d,~fp9d,~fp10d,~fp11d,~fp12d] == [~r1d,~r2d,~r3d,~r4d,~r5d,~r6d,~r7d,~r8d,~r9d,~r10d,~r11d,~r12d], {12.do(x = 0; {("fp"++(x=x+1)++"d").asSymbol.envirPut([~u1d,~u2d,~u3d,~u4d,~u5d,~u6d,~u7d,~u8d,~u9d,~u10d,~u11d,~u12d].at(x-1))});},{12.do(x = 0; {("fp"++(x=x+1)++"d").asSymbol.envirPut([~r1d,~r2d,~r3d,~r4d,~r5d,~r6d,~r7d,~r8d,~r9d,~r10d,~r11d,~r12d].at(x-1))});});~undo.value = 0;}
		{~undo.value == 5}{if([~fp1e,~fp2e,~fp3e,~fp4e,~fp5e,~fp6e,~fp7e,~fp8e,~fp9e,~fp10e,~fp11e,~fp12e] == [~r1e,~r2e,~r3e,~r4e,~r5e,~r6e,~r7e,~r8e,~r9e,~r10e,~r11e,~r12e], {12.do(x = 0; {("fp"++(x=x+1)++"e").asSymbol.envirPut([~u1e,~u2e,~u3e,~u4e,~u5e,~u6e,~u7e,~u8e,~u9e,~u10e,~u11e,~u12e].at(x-1))});},{12.do(x = 0; {("fp"++(x=x+1)++"e").asSymbol.envirPut([~r1e,~r2e,~r3e,~r4e,~r5e,~r6e,~r7e,~r8e,~r9e,~r10e,~r11e,~r12e].at(x-1))});});~undo.value = 0;}
		{~undo.value == 6}{if([~fp1f,~fp2f,~fp3f,~fp4f,~fp5f,~fp6f,~fp7f,~fp8f,~fp9f,~fp10f,~fp11f,~fp12f] == [~r1f,~r2f,~r3f,~r4f,~r5f,~r6f,~r7f,~r8f,~r9f,~r10f,~r11f,~r12f], {12.do(x = 0; {("fp"++(x=x+1)++"f").asSymbol.envirPut([~u1f,~u2f,~u3f,~u4f,~u5f,~u6f,~u7f,~u8f,~u9f,~u10f,~u11f,~u12f].at(x-1))});},{12.do(x = 0; {("fp"++(x=x+1)++"f").asSymbol.envirPut([~r1f,~r2f,~r3f,~r4f,~r5f,~r6f,~r7f,~r8f,~r9f,~r10f,~r11f,~r12f].at(x-1))});});~undo.value = 0;}
		{~undo.value == 7}{if([~fp1g,~fp2g,~fp3g,~fp4g,~fp5g,~fp6g,~fp7g,~fp8g,~fp9g,~fp10g,~fp11g,~fp12g] == [~r1g,~r2g,~r3g,~r4g,~r5g,~r6g,~r7g,~r8g,~r9g,~r10g,~r11g,~r12g], {12.do(x = 0; {("fp"++(x=x+1)++"g").asSymbol.envirPut([~u1g,~u2g,~u3g,~u4g,~u5g,~u6g,~u7g,~u8g,~u9g,~u10g,~u11g,~u12g].at(x-1))});},{12.do(x = 0; {("fp"++(x=x+1)++"g").asSymbol.envirPut([~r1g,~r2g,~r3g,~r4g,~r5g,~r6g,~r7g,~r8g,~r9g,~r10g,~r11g,~r12g].at(x-1))});});~undo.value = 0;}
		{~undo.value == 8}{if([~fp1h,~fp2h,~fp3h,~fp4h,~fp5h,~fp6h,~fp7h,~fp8h,~fp9h,~fp10h,~fp11h,~fp12h] == [~r1h,~r2h,~r3h,~r4h,~r5h,~r6h,~r7h,~r8h,~r9h,~r10h,~r11h,~r12h], {12.do(x = 0; {("fp"++(x=x+1)++"h").asSymbol.envirPut([~u1h,~u2h,~u3h,~u4h,~u5h,~u6h,~u7h,~u8h,~u9h,~u10h,~u11h,~u12h].at(x-1))});},{12.do(x = 0; {("fp"++(x=x+1)++"g").asSymbol.envirPut([~r1h,~r2h,~r3h,~r4h,~r5h,~r6h,~r7h,~r8h,~r9h,~r10h,~r11h,~r12h].at(x-1))});});~undo.value = 0;};
	});


	//record/stop record button

	~startrecord = Button.new(w,Rect(Window.screenBounds.width-(Window.screenBounds.width/3)+39,Window.screenBounds.height-52+19.777087639995,28,28/1.6180339887499)).states_([["rc",Color.white,Color.black],["/rc",Color.black,Color.red]]).action_({arg button;

		if(button.value == 1, {~numsynths.stop; s.record; if(button.value == 0, {button.value = 1});},
			{s.stopRecording; ~startrecord.value = 0; ~pauserecord.value = 0; ~numsynths.stop; ~numsynths.play;});
	});


	//pause record button

	~pauserecord = Button.new(w,Rect(Window.screenBounds.width-(Window.screenBounds.width/3)+28+39,Window.screenBounds.height-52+19.777087639995,28,28/1.6180339887499)).states_([["prc",Color.white,Color.black],["/prc",Color.black,Color.blue]]).action_({arg button; if(button == 1, {Server.default.pauseRecording;}, {Server.default.record});});


	//minimize GUI window button

	~min = Button.new(w,Rect(Window.screenBounds.width-20,~bpt+69+5-(20/1.6180339887499),20,20/1.6180339887499)).states_([["m",Color.white,Color.black]]).action_({arg button; w.minimize;

		~fullscreen_correct = {w.fullScreen};
		~fscview = UserView(w, Rect(0,0, Window.screenBounds.width-100, Window.screenBounds.height;));
		~fullscreen_button = Button.new(w,Rect(Window.screenBounds.width/2-35,Window.screenBounds.height/2+120,150,20)).states_([["re-adjust to fullscreen",Color.white,Color.black]]).action_({arg button; w.fullScreen; ~fullscreen_button.close; ~fullscreen_button = nil;});
		~fscview.mouseEnterAction_{|v, x, y| ~fullscreen_correct.value; ~fullscreen_correct = nil; ~fscview.close; ~fscview = nil; ~fullscreen_button.close; ~fullscreen_button = nil;};
	});


	//close GUI window button

	~close = Button.new(w,Rect(Window.screenBounds.width-20,~bpt+69+5,20,20/1.6180339887499)).states_([["c",Color.white,Color.black]]).action_({arg button;

		if(~closemessage != nil, {~closemessage.close}, {nil});
		~closemessage = View(w, Rect(Window.screenBounds.width-(340+46),Window.screenBounds.height-(340+46/1.6180339887499)-110,340+46,340+46/1.6180339887499)).background_(Color.black).front;
		~closemessagestring = StaticText(~closemessage, Rect(0,0,340+46,340+46/1.6180339887499)).background_(Color.black);
		~closemessagestring.align = \center;
		~closemessagestring.string ="Close Timewave Synth?";
		~closemessagestring.stringColor = Color.white;
		~closemessagebutton1 = Button.new(~closemessage,Rect(120-46+40,340/1.6180339887499-30,46,46/1.6180339887499)).states_([["Yes",Color.white,Color.black]]).action_({AppClock.sched(0, {~cpumonitorroutine.stop; ~metronome.stop; ~loop.stop; ~loop.reset; ~numsynths.stop; w.close; Task({1.do({if(~l1a.isRunning == true or: ~l1a1.isRunning == true, {~synthfree.value;}, {nil}); 1.wait; Server.freeAll;});}).play;});});
		~closemessagebutton2 = Button.new(~closemessage,Rect(320+46-130,340/1.6180339887499-30,46,46/1.6180339887499)).states_([["No",Color.white,Color.black]]).action_({AppClock.sched(0, {~closemessage.close;});});
		~closemessage.front;

	});


	w.front; w.fullScreen;

	/* e-mail: ken_brant@ymail.com */

}.value);
);
);


//Interpreted King Wen Sequences

/*

(#a,b,c,d,e,f = /*[ 128.43436842029,128.43436842029,128.43436842029,128.43436842029,128.43436842029,128.43436842029  ]*/
[ ~basefreq,~basefreq,~basefreq,~basefreq,~basefreq,~basefreq  ];
~a = a; ~b = b; ~c =c; ~d = d; ~e = e;~f=f;);

~fth = 1.4142135623729;
~bi  = ~fth; (~bi  = "binary interval" - intverval of key change to a hexagram line's opposite in King Wen sequence)


(First Setting)

/*1*/	#a,b,c,d,e,f=[ ~a,~b,~c,~d,~e,~f  ],
/*2*/	[ a = a/~bi, b = b/~bi, c = c/~bi, d = d/~bi, e = e/~bi, f = f/~bi ],
/*3*/	[ a = a,     b = b*~bi, c = c,     d = d,     e = e,     f = f*~bi ],
/*4*/	[ a = a*~bi, b = b/~bi, c = c,     d = d,     e = e*~bi, f = f/~bi ],
/*5*/	[ a = a/~bi, b = b*~bi, c = c,     d = d*~bi, e = e,     f = f*~bi ],
/*6*/	[ a = a*~bi, b = b,     c = c*~bi, d = d/~bi, e = e,     f = f/~bi ],
/*7*/	[ a = a/~bi, b = b/~bi, c = c/~bi, d = d,     e = e,     f = f     ],
/*8*/	[ a = a,     b = b*~bi, c = c,     d = d,     e = e/~bi, f = f     ],
/*9*/	[ a = a*~bi, b = b,     c = c,     d = d*~bi, e = e*~bi, f = f*~bi ],
/*10*/	[ a = a,     b = b,     c = c*~bi, d = d/~bi, e = e,     f = f     ],
/*11*/	[ a = a/~bi, b = b/~bi, c = c/~bi, d = d*~bi, e = e,     f = f     ],
/*12*/	[ a = a*~bi, b = b*~bi, c = c*~bi, d = d/~bi, e = e/~bi, f = f/~bi ],
/*13*/	[ a = a,     b = b,     c = c,     d = d*~bi, e = e,     f = f*~bi ],
/*14*/	[ a = a,     b = b/~bi, c = c,     d = d,     e = e*~bi, f = f     ],
/*15*/	[ a = a/~bi, b = b,     c = c/~bi, d = d,     e = e/~bi, f = f/~bi ],
/*16*/	[ a = a,     b = b,     c = c*~bi, d = d/~bi, e = e,     f = f     ],
/*17*/	[ a = a,     b = b*~bi, c = c,     d = d,     e = e,     f = f*~bi ],
/*18*/	[ a = a*~bi, b = b/~bi, c = c/~bi, d = d*~bi, e = e*~bi, f = f/~bi ],
/*19*/	[ a = a/~bi, b = b,     c = c,     d = d/~bi, e = e,     f = f*~bi ],
/*20*/	[ a = a*~bi, b = b*~bi, c = c,     d = d,     e = e/~bi, f = f/~bi ],
/*21*/	[ a = a,     b = b/~bi, c = c*~bi, d = d,     e = e,     f = f*~bi ],
/*22*/	[ a = a,     b = b,     c = c/~bi, d = d*~bi, e = e,     f = f     ],
/*23*/	[ a = a,     b = b,     c = c,     d = d/~bi, e = e,     f = f/~bi ],
/*24*/	[ a = a/~bi, b = b,     c = c,     d = d,     e = e,     f = f*~bi ],
/*25*/	[ a = a*~bi, b = b*~bi, c = c*~bi, d = d,     e = e,     f = f     ],
/*26*/	[ a = a,     b = b/~bi, c = c/~bi, d = d*~bi, e = e*~bi, f = f 	   ],
/*27*/	[ a = a,     b = b,     c = c,     d = d/~bi, e = e/~bi, f = f     ],
/*28*/	[ a = a/~bi, b = b*~bi, c = c*~bi, d = d*~bi, e = e*~bi, f = f/~bi ],
/*29*/	[ a = a,     b = b,     c = c/~bi, d = d/~bi, e = e,     f = f     ],
/*30*/	[ a = a*~bi, b = b/~bi, c = c*~bi, d = d*~bi, e = e/~bi, f = f*~bi ],
/*31*/	[ a = a/~bi, b = b*~bi, c = c,     d = d,     e = e,     f = f/~bi ],
/*32*/	[ a = a,     b = b/~bi, c = c,     d = d,     e = e*~bi, f = f     ],
/*33*/	[ a = a*~bi, b = b*~bi, c = c,     d = d,     e = e/~bi, f = f     ],
/*34*/	[ a = a/~bi, b = b/~bi, c = c,     d = d,     e = e*~bi, f = f*~bi ],
/*35*/	[ a = a*~bi, b = b,     c = c,     d = d/~bi, e = e/~bi, f = f/~bi ],
/*36*/	[ a = a/~bi, b = b,     c = c/~bi, d = d*~bi, e = e,     f = f*~bi ],
/*37*/	[ a = a*~bi, b = b*~bi, c = c,     d = d,     e = e,     f = f     ],
/*38*/	[ a = a,     b = b/~bi, c = c*~bi, d = d/~bi, e = e*~bi, f = f     ],
/*39*/	[ a = a/~bi, b = b*~bi, c = c/~bi, d = d*~bi, e = e/~bi, f = f/~bi ],
/*40*/	[ a = a,     b = b/~bi, c = c*~bi, d = d/~bi, e = e*~bi, f = f     ],
/*41*/	[ a = a*~bi, b = b,     c = c/~bi, d = d,     e = e,     f = f*~bi ],
/*42*/	[ a = a,     b = b*~bi, c = c,     d = d,     e = e/~bi, f = f     ],
/*43*/	[ a = a/~bi, b = b,     c = c*~bi, d = d*~bi, e = e*~bi, f = f     ],
/*44*/	[ a = a*~bi, b = b,     c = c,     d = d,     e = e,     f = f/~bi ],
/*45*/	[ a = a/~bi, b = b,     c = c,     d = d/~bi, e = e/~bi, f = f     ],
/*46*/	[ a = a,     b = b/~bi, c = c/~bi, d = d*~bi, e = e*~bi, f = f     ],
/*47*/	[ a = a,     b = b*~bi, c = c*~bi, d = d/~bi, e = e,     f = f     ],
/*48*/	[ a = a,     b = b,     c = c/~bi, d = d*~bi, e = e,     f = f     ],
/*49*/	[ a = a,     b = b,     c = c*~bi, d = d,     e = e/~bi, f = f*~bi ],
/*50*/	[ a = a*~bi, b = b/~bi, c = c,     d = d,     e = e*~bi, f = f/~bi ],
/*51*/	[ a = a/~bi, b = b,     c = c,     d = d/~bi, e = e/~bi, f = f*~bi ],
/*52*/	[ a = a*~bi, b = b,     c = c/~bi, d = d*~bi, e = e,     f = f/~bi ],
/*53*/	[ a = a,     b = b*~bi, c = c,     d = d,     e = e,     f = f     ],
/*54*/	[ a = a/~bi, b = b/~bi, c = c*~bi, d = d/~bi, e = e*~bi, f = f*~bi ],
/*55*/	[ a = a,     b = b,     c = c,     d = d*~bi, e = e/~bi, f = f     ],
/*56*/	[ a = a*~bi, b = b,     c = c,     d = d,     e = e,     f = f/~bi ],
/*57*/	[ a = a,     b = b*~bi, c = c/~bi, d = d,     e = e*~bi, f = f     ],
/*58*/	[ a = a/~bi, b = b,     c = c*~bi, d = d/~bi, e = e,     f = f*~bi ],
/*59*/	[ a = a*~bi, b = b,     c = c/~bi, d = d,     e = e,     f = f/~bi ],
/*60*/	[ a = a/~bi, b = b,     c = c,     d = d,     e = e,     f = f*~bi ],
/*61*/	[ a = a*~bi, b = b,     c = c,     d = d,     e = e,     f = f     ],
/*62*/	[ a = a/~bi, b = b/~bi, c = c*~bi, d = d*~bi, e = e/~bi, f = f/~bi ],
/*63*/	[ a = a,     b = b*~bi, c = c/~bi, d = d,     e = e,     f = f*~bi ],
/*64*/	[ a = a*~bi, b = b/~bi, c = c*~bi, d = d/~bi, e = e*~bi, f = f/~bi ]

/*1*/	[ a = a*~n1, b = b*~n1*~bi, c = c*~n1, d = d*~n1*~bi, e = e*~n1, f = f*~n1*~bi ],...


(Second Setting)

/*1*/	#a,b,c,d,e,f=[ ~a,~b,~c,~d,~e,~f  ],
/*2*/	[ a = a*~n1/~bi, b = b*~n1/~bi, c = c*~n1/~bi, d = d*~n1/~bi, e = e*~n1/~bi, f = f*~n1/~bi ],
/*3*/	[ a = a,         b = b*~bi,     c = c,         d = d,         e = e,         f = f*~bi     ],
/*4*/	[ a = a*~bi,     b = b/~bi,     c = c,         d = d,         e = e*~bi,     f = f/~bi     ],
/*5*/	[ a = a/~bi,     b = b*~bi,     c = c,         d = d*~bi,     e = e,         f = f*~bi     ],
/*6*/	[ a = a*~bi,     b = b,         c = c*~bi,     d = d/~bi,     e = e,         f = f/~bi     ],
/*7*/	[ a = a/~bi,     b = b/~bi,     c = c/~bi,     d = d,         e = e,         f = f         ],
/*8*/	[ a = a,         b = b*~bi,     c = c,         d = d,         e = e/~bi,     f = f         ],
/*9*/	[ a = a*~bi,     b = b,         c = c,         d = d*~bi,     e = e*~bi,     f = f*~bi     ],
/*10*/	[ a = a,         b = b,         c = c*~bi,     d = d/~bi,     e = e,         f = f         ],
/*11*/	[ a = a/~bi,     b = b/~bi,     c = c/~bi,     d = d*~bi,     e = e,         f = f         ],
/*12*/	[ a = a*~n2*~bi, b = b*~n2*~bi, c = c*~n2*~bi, d = d*~n2/~bi, e = e*~n2/~bi, f = f*~n2/~bi ],
/*13*/	[ a = a,         b = b,         c = c,         d = d*~bi,     e = e,         f = f*~bi     ],
/*14*/	[ a = a,         b = b/~bi,     c = c,         d = d,         e = e*~bi,     f = f         ],
/*15*/	[ a = a/~bi,     b = b,         c = c/~bi,     d = d,         e = e/~bi,     f = f/~bi     ],
/*16*/	[ a = a,         b = b,         c = c*~bi,     d = d/~bi,     e = e,         f = f         ],
/*17*/	[ a = a,         b = b*~bi,     c = c,         d = d,         e = e,         f = f*~bi     ],
/*18*/	[ a = a*~n3*~bi, b = b*~n3/~bi, c = c*~n3/~bi, d = d*~n3*~bi, e = e*~n3*~bi, f = f*~n3/~bi ],
/*19*/	[ a = a/~bi,     b = b,         c = c,         d = d/~bi,     e = e,         f = f*~bi     ],
/*20*/	[ a = a*~bi,     b = b*~bi,     c = c,         d = d,         e = e/~bi,     f = f/~bi     ],
/*21*/	[ a = a,         b = b/~bi,     c = c*~bi,     d = d,         e = e,         f = f*~bi     ],
/*22*/	[ a = a,         b = b,         c = c/~bi,     d = d*~bi,     e = e,         f = f         ],
/*23*/	[ a = a,         b = b,         c = c,         d = d/~bi,     e = e,         f = f/~bi     ],
/*24*/	[ a = a/~bi,     b = b,         c = c,         d = d,         e = e,         f = f*~bi     ],
/*25*/	[ a = a*~bi,     b = b*~bi,     c = c*~bi,     d = d,         e = e,         f = f         ],
/*26*/	[ a = a,         b = b/~bi,     c = c/~bi,     d = d*~bi,     e = e*~bi,     f = f         ],
/*27*/	[ a = a,         b = b,         c = c,         d = d/~bi,     e = e/~bi,     f = f         ],
/*28*/	[ a = a*~n4/~bi, b = b*~n4*~bi, c = c*~n4*~bi, d = d*~n4*~bi, e = e*~n4*~bi, f = f*~n4/~bi ],
/*29*/	[ a = a,         b = b,         c = c/~bi,     d = d/~bi,     e = e,         f = f         ],
/*30*/	[ a = a*~n5*~bi, b = b*~n5/~bi, c = c*~n5*~bi, d = d*~n5*~bi, e = e*~n5/~bi, f = f*~n5*~bi ],
/*31*/	[ a = a/~bi,     b = b*~bi,     c = c,         d = d,         e = e,         f = f/~bi     ],
/*32*/	[ a = a,         b = b/~bi,     c = c,         d = d,         e = e*~bi,     f = f         ],
/*33*/	[ a = a*~bi,     b = b*~bi,     c = c,         d = d,         e = e/~bi,     f = f         ],
/*34*/	[ a = a/~bi,     b = b/~bi,     c = c,         d = d,         e = e*~bi,     f = f*~bi     ],
/*35*/	[ a = a*~bi,     b = b,         c = c,         d = d/~bi,     e = e/~bi,     f = f/~bi     ],
/*36*/	[ a = a/~bi,     b = b,         c = c/~bi,     d = d*~bi,     e = e,         f = f*~bi     ],
/*37*/	[ a = a*~bi,     b = b*~bi,     c = c,         d = d,         e = e,         f = f         ],
/*38*/	[ a = a,         b = b/~bi,     c = c*~bi,     d = d/~bi,     e = e*~bi,     f = f         ],
/*39*/	[ a = a*~n6/~bi, b = b*~n6*~bi, c = c*~n6/~bi, d = d*~n6*~bi, e = e*~n6/~bi, f = f*~n6/~bi ],
/*40*/	[ a = a,         b = b/~bi,     c = c*~bi,     d = d/~bi,     e = e*~bi,     f = f         ],
/*41*/	[ a = a*~bi,     b = b,         c = c/~bi,     d = d,         e = e,         f = f*~bi     ],
/*42*/	[ a = a,         b = b*~bi,     c = c,         d = d,         e = e/~bi,     f = f         ],
/*43*/	[ a = a/~bi,     b = b,         c = c*~bi,     d = d*~bi,     e = e*~bi,     f = f         ],
/*44*/	[ a = a*~bi,     b = b,         c = c,         d = d,         e = e,         f = f/~bi     ],
/*45*/	[ a = a/~bi,     b = b,         c = c,         d = d/~bi,     e = e/~bi,     f = f         ],
/*46*/	[ a = a,         b = b/~bi,     c = c/~bi,     d = d*~bi,     e = e*~bi,     f = f         ],
/*47*/	[ a = a,         b = b*~bi,     c = c*~bi,     d = d/~bi,     e = e,         f = f         ],
/*48*/	[ a = a,         b = b,         c = c/~bi,     d = d*~bi,     e = e,         f = f         ],
/*49*/	[ a = a,         b = b,         c = c*~bi,     d = d,         e = e/~bi,     f = f*~bi     ],
/*50*/	[ a = a*~bi,     b = b/~bi,     c = c,         d = d,         e = e*~bi,     f = f/~bi     ],
/*51*/	[ a = a/~bi,     b = b,         c = c,         d = d/~bi,     e = e/~bi,     f = f*~bi     ],
/*52*/	[ a = a*~bi,     b = b,         c = c/~bi,     d = d*~bi,     e = e,         f = f/~bi     ],
/*53*/	[ a = a,         b = b*~bi,     c = c,         d = d,         e = e,         f = f         ],
/*54*/	[ a = a*~n7/~bi, b = b*~n7/~bi, c = c*~n7*~bi, d = d*~n7/~bi, e = e*~n7*~bi, f = f*~n7*~bi ],
/*55*/	[ a = a,         b = b,         c = c,         d = d*~bi,     e = e/~bi,     f = f         ],
/*56*/	[ a = a*~bi,     b = b,         c = c,         d = d,         e = e,         f = f/~bi     ],
/*57*/	[ a = a,         b = b*~bi,     c = c/~bi,     d = d,         e = e*~bi,     f = f         ],
/*58*/	[ a = a/~bi,     b = b,         c = c*~bi,     d = d/~bi,     e = e,         f = f*~bi     ],
/*59*/	[ a = a*~bi,     b = b,         c = c/~bi,     d = d,         e = e,         f = f/~bi     ],
/*60*/	[ a = a/~bi,     b = b,         c = c,         d = d,         e = e,         f = f*~bi     ],
/*61*/	[ a = a*~bi,     b = b,         c = c,         d = d,         e = e,         f = f         ],
/*62*/	[ a = a*~n8/~bi, b = b*~n8/~bi, c = c*~n8*~bi, d = d*~n8*~bi, e = e*~n8/~bi, f = f*~n8/~bi ],
/*63*/	[ a = a,         b = b*~bi,     c = c/~bi,     d = d,         e = e,         f = f*~bi     ],
/*64*/	[ a = a*~n9*~bi, b = b*~n9/~bi, c = c*~n9*~bi, d = d*~n9/~bi, e = e*~n9*~bi, f = f*~n9/~bi ]

/*1*/	[ a = a,         b = b*~bi,     c = c,         d = d*~bi,     e = e,         f = f*~bi     ],...


(Third Setting)

/*1*/	#a,b,c,d,e,f=[ ~a,~b,~c,~d,~e,~f  ],
/*2*/	[ a = a*~n1/~bi, b = b*~n1/~bi, c = c*~n1/~bi, d = d*~n1/~bi, e = e*~n1/~bi, f = f*~n1/~bi ],
/*3*/	[ a = a*~n1,     b = b*~n1*~bi, c = c*~n1,     d = d*~n1,     e = e*~n1,     f = f*~n1*~bi ],
/*4*/	[ a = a*~n1*~bi, b = b*~n1/~bi, c = c*~n1,     d = d*~n1,     e = e*~n1*~bi, f = f*~n1/~bi ],
/*5*/	[ a = a*~n1/~bi, b = b*~n1*~bi, c = c*~n1,     d = d*~n1*~bi, e = e*~n1,     f = f*~n1*~bi ],
/*6*/	[ a = a*~n1*~bi, b = b*~n1,     c = c*~n1*~bi, d = d*~n1/~bi, e = e*~n1,     f = f*~n1/~bi ],
/*7*/	[ a = a*~n1/~bi, b = b*~n1/~bi, c = c*~n1/~bi, d = d*~n1,     e = e*~n1,     f = f*~n1     ],
/*8*/	[ a = a*~n1,     b = b*~n1*~bi, c = c*~n1,     d = d*~n1,     e = e*~n1/~bi, f = f*~n1     ],
/*9*/	[ a = a*~n1*~bi, b = b*~n1,     c = c*~n1,     d = d*~n1*~bi, e = e*~n1*~bi, f = f*~n1*~bi ],
/*10*/	[ a = a*~n1,     b = b*~n1,     c = c*~n1*~bi, d = d*~n1/~bi, e = e*~n1,     f = f*~n1     ],
/*11*/	[ a = a*~n1/~bi, b = b*~n1/~bi, c = c*~n1/~bi, d = d*~n1*~bi, e = e*~n1,     f = f*~n1     ],
/*12*/	[ a = a*~n1*~bi, b = b*~n1*~bi, c = c*~n1*~bi, d = d*~n1/~bi, e = e*~n1/~bi, f = f*~n1/~bi ],
/*13*/	[ a = a*~n1,     b = b*~n1,     c = c*~n1,     d = d*~n1*~bi, e = e*~n1,     f = f*~n1*~bi ],
/*14*/	[ a = a*~n1,     b = b*~n1/~bi, c = c*~n1,     d = d*~n1,     e = e*~n1*~bi, f = f*~n1     ],
/*15*/	[ a = a*~n1/~bi, b = b*~n1,     c = c*~n1/~bi, d = d*~n1,     e = e*~n1/~bi, f = f*~n1/~bi ],
/*16*/	[ a = a*~n1,     b = b*~n1,     c = c*~n1*~bi, d = d*~n1/~bi, e = e*~n1,     f = f*~n1     ],
/*17*/	[ a = a*~n1,     b = b*~n1*~bi, c = c*~n1,     d = d*~n1,     e = e*~n1,     f = f*~n1*~bi ],
/*18*/	[ a = a*~n1*~bi, b = b*~n1/~bi, c = c*~n1/~bi, d = d*~n1*~bi, e = e*~n1*~bi, f = f*~n1/~bi ],
/*19*/	[ a = a*~n1/~bi, b = b*~n1,     c = c*~n1,     d = d*~n1/~bi, e = e*~n1,     f = f*~n1*~bi ],
/*20*/	[ a = a*~n1*~bi, b = b*~n1*~bi, c = c*~n1,     d = d*~n1,     e = e*~n1/~bi, f = f*~n1/~bi ],
/*21*/	[ a = a*~n1,     b = b*~n1/~bi, c = c*~n1*~bi, d = d*~n1,     e = e*~n1,     f = f*~n1*~bi ],
/*22*/	[ a = a*~n1,     b = b*~n1,     c = c*~n1/~bi, d = d*~n1*~bi, e = e*~n1,     f = f*~n1     ],
/*23*/	[ a = a*~n1,     b = b*~n1,     c = c*~n1,     d = d*~n1/~bi, e = e*~n1,     f = f*~n1/~bi ],
/*24*/	[ a = a*~n1/~bi, b = b*~n1,     c = c*~n1,     d = d*~n1,     e = e*~n1,     f = f*~n1*~bi ],
/*25*/	[ a = a*~n1*~bi, b = b*~n1*~bi, c = c*~n1*~bi, d = d*~n1,     e = e*~n1,     f = f*~n1     ],
/*26*/	[ a = a*~n1,     b = b*~n1/~bi, c = c*~n1/~bi, d = d*~n1*~bi, e = e*~n1*~bi, f = f*~n1     ],
/*27*/	[ a = a*~n1,     b = b*~n1,     c = c*~n1,     d = d*~n1/~bi, e = e*~n1/~bi, f = f*~n1     ],
/*28*/	[ a = a*~n1/~bi, b = b*~n1*~bi, c = c*~n1*~bi, d = d*~n1*~bi, e = e*~n1*~bi, f = f*~n1/~bi ],
/*29*/	[ a = a*~n1,     b = b*~n1,     c = c*~n1/~bi, d = d*~n1/~bi, e = e*~n1,     f = f*~n1     ],
/*30*/	[ a = a*~n1*~bi, b = b*~n1/~bi, c = c*~n1*~bi, d = d*~n1*~bi, e = e*~n1/~bi, f = f*~n1*~bi ],
/*31*/	[ a = a*~n1/~bi, b = b*~n1*~bi, c = c*~n1,     d = d*~n1,     e = e*~n1,     f = f*~n1/~bi ],
/*32*/	[ a = a*~n1,     b = b*~n1/~bi, c = c*~n1,     d = d*~n1,     e = e*~n1*~bi, f = f*~n1     ],
/*33*/	[ a = a*~n1*~bi, b = b*~n1*~bi, c = c*~n1,     d = d*~n1,     e = e*~n1/~bi, f = f*~n1     ],
/*34*/	[ a = a*~n1/~bi, b = b*~n1/~bi, c = c*~n1,     d = d*~n1,     e = e*~n1*~bi, f = f*~n1*~bi ],
/*35*/	[ a = a*~n1*~bi, b = b*~n1,     c = c*~n1,     d = d*~n1/~bi, e = e*~n1/~bi, f = f*~n1/~bi ],
/*36*/	[ a = a*~n1/~bi, b = b*~n1,     c = c*~n1/~bi, d = d*~n1*~bi, e = e*~n1,     f = f*~n1*~bi ],
/*37*/	[ a = a*~n1*~bi, b = b*~n1*~bi, c = c*~n1,     d = d*~n1,     e = e*~n1,     f = f*~n1     ],
/*38*/	[ a = a*~n1,     b = b*~n1/~bi, c = c*~n1*~bi, d = d*~n1/~bi, e = e*~n1*~bi, f = f*~n1     ],
/*39*/	[ a = a*~n1/~bi, b = b*~n1*~bi, c = c*~n1/~bi, d = d*~n1*~bi, e = e*~n1/~bi, f = f*~n1/~bi ],
/*40*/	[ a = a*~n1,     b = b*~n1/~bi, c = c*~n1*~bi, d = d*~n1/~bi, e = e*~n1*~bi, f = f*~n1     ],
/*41*/	[ a = a*~n1*~bi, b = b*~n1,     c = c*~n1/~bi, d = d*~n1,     e = e*~n1,     f = f*~n1*~bi ],
/*42*/	[ a = a*~n1,     b = b*~n1*~bi, c = c*~n1,     d = d*~n1,     e = e*~n1/~bi, f = f*~n1     ],
/*43*/	[ a = a*~n1/~bi, b = b*~n1,     c = c*~n1*~bi, d = d*~n1*~bi, e = e*~n1*~bi, f = f*~n1     ],
/*44*/	[ a = a*~n1*~bi, b = b*~n1,     c = c*~n1,     d = d*~n1,     e = e*~n1,     f = f*~n1/~bi ],
/*45*/	[ a = a*~n1/~bi, b = b*~n1,     c = c*~n1,     d = d*~n1/~bi, e = e*~n1/~bi, f = f*~n1     ],
/*46*/	[ a = a*~n1,     b = b*~n1/~bi, c = c*~n1/~bi, d = d*~n1*~bi, e = e*~n1*~bi, f = f*~n1     ],
/*47*/	[ a = a*~n1,     b = b*~n1*~bi, c = c*~n1*~bi, d = d*~n1/~bi, e = e*~n1,     f = f*~n1     ],
/*48*/	[ a = a*~n1,     b = b*~n1,     c = c*~n1/~bi, d = d*~n1*~bi, e = e*~n1,     f = f*~n1     ],
/*49*/	[ a = a*~n1,     b = b*~n1,     c = c*~n1*~bi, d = d*~n1,     e = e*~n1/~bi, f = f*~n1*~bi ],
/*50*/	[ a = a*~n1*~bi, b = b*~n1/~bi, c = c*~n1,     d = d*~n1,     e = e*~n1*~bi, f = f*~n1/~bi ],
/*51*/	[ a = a*~n1/~bi, b = b*~n1,     c = c*~n1,     d = d*~n1/~bi, e = e*~n1/~bi, f = f*~n1*~bi ],
/*52*/	[ a = a*~n1*~bi, b = b*~n1,     c = c*~n1/~bi, d = d*~n1*~bi, e = e*~n1,     f = f*~n1/~bi ],
/*53*/	[ a = a*~n1,     b = b*~n1*~bi, c = c*~n1,     d = d*~n1,     e = e*~n1,     f = f*~n1     ],
/*54*/	[ a = a*~n1/~bi, b = b*~n1/~bi, c = c*~n1*~bi, d = d*~n1/~bi, e = e*~n1*~bi, f = f*~n1*~bi ],
/*55*/	[ a = a*~n1,     b = b*~n1,     c = c*~n1,     d = d*~n1*~bi, e = e*~n1/~bi, f = f*~n1     ],
/*56*/	[ a = a*~n1*~bi, b = b*~n1,     c = c*~n1,     d = d*~n1,     e = e*~n1,     f = f*~n1/~bi ],
/*57*/	[ a = a*~n1,     b = b*~n1*~bi, c = c*~n1/~bi, d = d*~n1,     e = e*~n1*~bi, f = f*~n1     ],
/*58*/	[ a = a*~n1/~bi, b = b*~n1,     c = c*~n1*~bi, d = d*~n1/~bi, e = e*~n1,     f = f*~n1*~bi ],
/*59*/	[ a = a*~n1*~bi, b = b*~n1,     c = c*~n1/~bi, d = d*~n1,     e = e*~n1,     f = f*~n1/~bi ],
/*60*/	[ a = a*~n1/~bi, b = b*~n1,     c = c*~n1,     d = d*~n1,     e = e*~n1,     f = f*~n1*~bi ],
/*61*/	[ a = a*~n1*~bi, b = b*~n1,     c = c*~n1,     d = d*~n1,     e = e*~n1,     f = f*~n1     ],
/*62*/	[ a = a*~n1/~bi, b = b*~n1/~bi, c = c*~n1*~bi, d = d*~n1*~bi, e = e*~n1/~bi, f = f*~n1/~bi ],
/*63*/	[ a = a*~n1,     b = b*~n1*~bi, c = c*~n1/~bi, d = d*~n1,     e = e*~n1,     f = f*~n1*~bi ],
/*64*/	[ a = a*~n1*~bi, b = b*~n1/~bi, c = c*~n1*~bi, d = d*~n1/~bi, e = e*~n1*~bi, f = f*~n1/~bi ]

/*1*/	[ a = a*~n1,     b = b*~n1*~bi, c = c*~n1,     d = d*~n1*~bi, e = e*~n1,     f = f*~n1*~bi ],...

*/
