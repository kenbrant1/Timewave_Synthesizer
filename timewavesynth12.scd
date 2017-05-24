(
//To run the synth, click anywhere within the parenthesis above and press "ctrl - enter" or "cmd - return".
//A guide to using the instrument is available by clicking on the "i" button in the bottom right corner of the GUI.
//Several lines down, where it says "//VARIABLES YOU MAY WISH TO CHANGE", are variables that you can change for various things,
//including key codes for keyboard functions.

//It is recommended to reboot the interpreter in the "Language" toolbar, or by hightlighting - (thisProcess.platform.recompile);
//and pressing "ctrl - enter" or "cmd - return", before each server boot. Rebooting the interpreter is not needed to
//evaluate the code below if the server is booted.

//You can program/make a song by using the "timewavesynth12script.scd" file

//This synth is compatible with the Korg NanoKontrol 2

s.options.memSize = 2097152/4;
MIDIIn.connectAll;

(
s.boot;
s.waitForBoot({
	var point, w, view, view2,
	vol = 0.02,mute1,mute2,mute3,mute4,mute5,mute6,mute7,mute8,mute9,mute10,mute11,mute12,muteall,unmuteall,
	g1,g2,g6,g8,g33,g48,g64,g72,g88,gm,ngm1,ngm2,ngm6,set1,set2,menu1,menu2,
	ts,sts,str,spaceb,b1,b2,b3,b4,button,button1,info,
	n1,n2,n3,n4,n5,n6,n7,n8,keycodeb,
	f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,
	fp1,fp2,fp3,fp4,fp5,fp6,fp7,fp8,fp9,fp10,fp11,fp12,
	fp1b,fp2b,fp3b,fp4b,fp5b,fp6b,fp7b,fp8b,fp9b,fp10b,fp11b,fp12b,
	fp1c,fp2c,fp3c,fp4c,fp5c,fp6c,fp7c,fp8c,fp9c,fp10c,fp11c,fp12c,
	fp1d,fp2d,fp3d,fp4d,fp5d,fp6d,fp7d,fp8d,fp9d,fp10d,fp11d,fp12d,
	fp1e,fp2e,fp3e,fp4e,fp5e,fp6e,fp7e,fp8e,fp9e,fp10e,fp11e,fp12e,
	fp1f,fp2f,fp3f,fp4f,fp5f,fp6f,fp7f,fp8f,fp9f,fp10f,fp11f,fp12f,
	fp1g,fp2g,fp3g,fp4g,fp5g,fp6g,fp7g,fp8g,fp9g,fp10g,fp11g,fp12g,
	fp1h,fp2h,fp3h,fp4h,fp5h,fp6h,fp7h,fp8h,fp9h,fp10h,fp11h,fp12h;


	//VARIABLES YOU MAY WISH TO CHANGE


	//note A tuning frequency in hz

	~tuning_frequency = 432; //default 432 hz

	~freqmap = (
		i = ~tuning_frequency
		/ (2 ** (69 / 12)); a = (-1); b = (-1);
		Array.fill(128, {i * (2 ** (((a=a+1) / 12).trunc)) * ( (2 ** (12.reciprocal)) ** ((b=b+1)  % 12));
	}));/*~freqmap = (i = 8.0271480262684/*-0.0000000000024*/; ~stepratio = 1.0594630943593; Array.fill(128, { i = i*~stepratio;}));*/


	//base frequency for synth inst

	~base_frequency = ~freqmap.at(48); //default 48
	~synthdefnum = 7; //default 7

	//volume

	~vol = 0.005; //default 0.005
	~vol1 = ~vol;
	~vol2 = ~vol;
	~vol3 = ~vol;
	~vol4 = ~vol;
	~vol5 = ~vol;
	~vol6 = ~vol;
	~vol7 = ~vol;
	~vol8 = ~vol;
	~vol9 = ~vol;
	~vol10 = ~vol;
	~vol11 = ~vol;
	~vol12 = ~vol;


	//Key codes for keyboard functions - either unicode or keycode. To find key codes, see below:

	~rightarrow_keycode = 114;
	~leftarrow_keycode = 113;
	~uparrow_keycode = 111;
	~downarrow_keycode = 116;
	~enter_unicode = 13;
	~s_unicode = 115;
	~m_unicode = 109;
	~r_unicode = 114;
	~u_unicode = 117;
	~t_unicode = 116;
	~c_unicode = 99;
	~i_unicode = 105;
	~k_unicode = 107;
	~j_unicode = 106;
	~l_unicode = 108;
	~spacebar_unicode = 32;
	~one_unicode = 49;
	~two_unicode = 50;
	~three_unicode = 51;
	~four_unicode = 52;
	~five_unicode = 53;
	~six_unicode = 54;
	~seven_unicode = 55;
	~eight_unicode = 56;
	~nine_unicode = 57;
	~ten_unicode = 48;
	~eleven_unicode = 45;
	~twelve_unicode = 61;
	~escape_unicode = 27;


	//To find key codes in post window... Hightlight the function and its parenthesis in red below,
	//and press "ctrl - enter" or cmd - return" - then a small window called "test" will pop up...
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

	//increase or decrease magnitude of second and third harmonics

	~icd3 = 3; //3
	~icd6 = 6; //6


	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


	//starting notes

	#f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12 =
	[432,457.68805676322,484.90360486965,513.73747368118,544.28589355459,576.65081700145,610.94025894518,647.26865721073,685.75725445026,726.53450277921,769.73649247325,815.50740615698];

	if(([ ~f1,~f2,~f3,~f4,~f5,~f6,~f7,~f8,~f9,~f10,~f11,~f12 ] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil]), {12.do(x = 0; {("f"++(x=x+1)).asSymbol.envirPut([f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12].at(x-1))});});

	#fp1,fp2,fp3,fp4,fp5,fp6,fp7,fp8,fp9,fp10,fp11,fp12 = [~u1,~u2,~u3,~u4,~u5,~u6,~u7,~u8,~u9,~u10,~u11,~u12];
	#fp1b,fp2b,fp3b,fp4b,fp5b,fp6b,fp7b,fp8b,fp9b,fp10b,fp11b,fp12b = [~u1b,~u2b,~u3b,~u4b,~u5b,~u6b,~u7b,~u8b,~u9b,~u10b,~u11b,~u12b];
	#fp1c,fp2c,fp3c,fp4c,fp5c,fp6c,fp7c,fp8c,fp9c,fp10c,fp11c,fp12c = [~u1c,~u2c,~u3c,~u4c,~u5c,~u6c,~u7c,~u8c,~u9c,~u10c,~u11c,~u12c];
	#fp1d,fp2d,fp3d,fp4d,fp5d,fp6d,fp7d,fp8d,fp9d,fp10d,fp11d,fp12d = [~u1d,~u2d,~u3d,~u4d,~u5d,~u6d,~u7d,~u8d,~u9d,~u10d,~u11d,~u12d];
	#fp1e,fp2e,fp3e,fp4e,fp5e,fp6e,fp7e,fp8e,fp9e,fp10e,fp11e,fp12e = [~u1e,~u2e,~u3e,~u4e,~u5e,~u6e,~u7e,~u8e,~u9e,~u10e,~u11e,~u12e];
	#fp1f,fp2f,fp3f,fp4f,fp5f,fp6f,fp7f,fp8f,fp9f,fp10f,fp11f,fp12f = [~u1f,~u2f,~u3f,~u4f,~u5f,~u6f,~u7f,~u8f,~u9f,~u10f,~u11f,~u12f];
	#fp1g,fp2g,fp3g,fp4g,fp5g,fp6g,fp7g,fp8g,fp9g,fp10g,fp11g,fp12g = [~u1g,~u2g,~u3g,~u4g,~u5g,~u6g,~u7g,~u8g,~u9g,~u10g,~u11g,~u12g];
	#fp1h,fp2h,fp3h,fp4h,fp5h,fp6h,fp7h,fp8h,fp9h,fp10h,fp11h,fp12h = [~u1h,~u2h,~u3h,~u4h,~u5h,~u6h,~u7h,~u8h,~u9h,~u10h,~u11h,~u12h];

	if([fp1,fp2,fp3,fp4,fp5,fp6,fp7,fp8,fp9,fp10,fp11,fp12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {#fp1,fp2,fp3,fp4,fp5,fp6,fp7,fp8,fp9,fp10,fp11,fp12 = [ ~f1,~f2,~f3,~f4,~f5,~f6,~f7,~f8,~f9,~f10,~f11,~f12 ];});
	if([fp1b,fp2b,fp3b,fp4b,fp5b,fp6b,fp7b,fp8b,fp9b,fp10b,fp11b,fp12b] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {#fp1b,fp2b,fp3b,fp4b,fp5b,fp6b,fp7b,fp8b,fp9b,fp10b,fp11b,fp12b = [ ~f1,~f2,~f3,~f4,~f5,~f6,~f7,~f8,~f9,~f10,~f11,~f12 ];});
	if([fp1c,fp2c,fp3c,fp4c,fp5c,fp6c,fp7c,fp8c,fp9c,fp10c,fp11c,fp12c] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {#fp1c,fp2c,fp3c,fp4c,fp5c,fp6c,fp7c,fp8c,fp9c,fp10c,fp11c,fp12c = [ ~f1,~f2,~f3,~f4,~f5,~f6,~f7,~f8,~f9,~f10,~f11,~f12 ];});
	if([fp1d,fp2d,fp3d,fp4d,fp5d,fp6d,fp7d,fp8d,fp9d,fp10d,fp11d,fp12d] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {#fp1d,fp2d,fp3d,fp4d,fp5d,fp6d,fp7d,fp8d,fp9d,fp10d,fp11d,fp12d = [ ~f1,~f2,~f3,~f4,~f5,~f6,~f7,~f8,~f9,~f10,~f11,~f12 ];});
	if([fp1e,fp2e,fp3e,fp4e,fp5e,fp6e,fp7e,fp8e,fp9e,fp10e,fp11e,fp12e] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {#fp1e,fp2e,fp3e,fp4e,fp5e,fp6e,fp7e,fp8e,fp9e,fp10e,fp11e,fp12e = [ ~f1,~f2,~f3,~f4,~f5,~f6,~f7,~f8,~f9,~f10,~f11,~f12 ];});
	if([fp1f,fp2f,fp3f,fp4f,fp5f,fp6f,fp7f,fp8f,fp9f,fp10f,fp11f,fp12f] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {#fp1f,fp2f,fp3f,fp4f,fp5f,fp6f,fp7f,fp8f,fp9f,fp10f,fp11f,fp12f = [ ~f1,~f2,~f3,~f4,~f5,~f6,~f7,~f8,~f9,~f10,~f11,~f12 ];});
	if([fp1g,fp2g,fp3g,fp4g,fp5g,fp6g,fp7g,fp8g,fp9g,fp10g,fp11g,fp12g] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {#fp1g,fp2g,fp3g,fp4g,fp5g,fp6g,fp7g,fp8g,fp9g,fp10g,fp11g,fp12g = [ ~f1,~f2,~f3,~f4,~f5,~f6,~f7,~f8,~f9,~f10,~f11,~f12 ];});
	if([fp1h,fp2h,fp3h,fp4h,fp5h,fp6h,fp7h,fp8h,fp9h,fp10h,fp11h,fp12h] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {#fp1h,fp2h,fp3h,fp4h,fp5h,fp6h,fp7h,fp8h,fp9h,fp10h,fp11h,fp12h = [ ~f1,~f2,~f3,~f4,~f5,~f6,~f7,~f8,~f9,~f10,~f11,~f12 ];});

	if([~sg1a1,~sg1a2,~sg1a3,~sg1a4,~sg1a5,~sg1a6,~sg1a7,~sg1a8,~sg1a9,~sg1a10,~sg1a11,~sg1a12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg1a1=~f1,~sg1a2=~f2,~sg1a3=~f3,~sg1a4=~f4,~sg1a5=~f5,~sg1a6=~f6,~sg1a7=~f7,~sg1a8=~f8,~sg1a9=~f9,~sg1a10=~f10,~sg1a11=~f11,~sg1a12=~f12];});
	if([~sg1b1,~sg1b2,~sg1b3,~sg1b4,~sg1b5,~sg1b6,~sg1b7,~sg1b8,~sg1b9,~sg1b10,~sg1b11,~sg1b12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg1b1=~f1,~sg1b2=~f2,~sg1b3=~f3,~sg1b4=~f4,~sg1b5=~f5,~sg1b6=~f6,~sg1b7=~f7,~sg1b8=~f8,~sg1b9=~f9,~sg1b10=~f10,~sg1b11=~f11,~sg1b12=~f12];});
	if([~sg1c1,~sg1c2,~sg1c3,~sg1c4,~sg1c5,~sg1c6,~sg1c7,~sg1c8,~sg1c9,~sg1c10,~sg1c11,~sg1c12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg1c1=~f1,~sg1c2=~f2,~sg1c3=~f3,~sg1c4=~f4,~sg1c5=~f5,~sg1c6=~f6,~sg1c7=~f7,~sg1c8=~f8,~sg1c9=~f9,~sg1c10=~f10,~sg1c11=~f11,~sg1c12=~f12];});
	if([~sg1d1,~sg1d2,~sg1d3,~sg1d4,~sg1d5,~sg1d6,~sg1d7,~sg1d8,~sg1d9,~sg1d10,~sg1d11,~sg1d12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg1d1=~f1,~sg1d2=~f2,~sg1d3=~f3,~sg1d4=~f4,~sg1d5=~f5,~sg1d6=~f6,~sg1d7=~f7,~sg1d8=~f8,~sg1d9=~f9,~sg1d10=~f10,~sg1d11=~f11,~sg1d12=~f12];});
	if([~sg1e1,~sg1e2,~sg1e3,~sg1e4,~sg1e5,~sg1e6,~sg1e7,~sg1e8,~sg1e9,~sg1e10,~sg1e11,~sg1e12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg1e1=~f1,~sg1e2=~f2,~sg1e3=~f3,~sg1e4=~f4,~sg1e5=~f5,~sg1e6=~f6,~sg1e7=~f7,~sg1e8=~f8,~sg1e9=~f9,~sg1e10=~f10,~sg1e11=~f11,~sg1e12=~f12];});
	if([~sg1f1,~sg1f2,~sg1f3,~sg1f4,~sg1f5,~sg1f6,~sg1f7,~sg1f8,~sg1f9,~sg1f10,~sg1f11,~sg1f12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg1f1=~f1,~sg1f2=~f2,~sg1f3=~f3,~sg1f4=~f4,~sg1f5=~f5,~sg1f6=~f6,~sg1f7=~f7,~sg1f8=~f8,~sg1f9=~f9,~sg1f10=~f10,~sg1f11=~f11,~sg1f12=~f12];});
	if([~sg1g1,~sg1g2,~sg1g3,~sg1g4,~sg1g5,~sg1g6,~sg1g7,~sg1g8,~sg1g9,~sg1g10,~sg1g11,~sg1g12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg1g1=~f1,~sg1g2=~f2,~sg1g3=~f3,~sg1g4=~f4,~sg1g5=~f5,~sg1g6=~f6,~sg1g7=~f7,~sg1g8=~f8,~sg1g9=~f9,~sg1g10=~f10,~sg1g11=~f11,~sg1g12=~f12];});
	if([~sg1h1,~sg1h2,~sg1h3,~sg1h4,~sg1h5,~sg1h6,~sg1h7,~sg1h8,~sg1h9,~sg1h10,~sg1h11,~sg1h12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg1h1=~f1,~sg1h2=~f2,~sg1h3=~f3,~sg1h4=~f4,~sg1h5=~f5,~sg1h6=~f6,~sg1h7=~f7,~sg1h8=~f8,~sg1h9=~f9,~sg1h10=~f10,~sg1h11=~f11,~sg1h12=~f12];});
	if([~sg2a1,~sg2a2,~sg2a3,~sg2a4,~sg2a5,~sg2a6,~sg2a7,~sg2a8,~sg2a9,~sg2a10,~sg2a11,~sg2a12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg2a1=~f1,~sg2a2=~f2,~sg2a3=~f3,~sg2a4=~f4,~sg2a5=~f5,~sg2a6=~f6,~sg2a7=~f7,~sg2a8=~f8,~sg2a9=~f9,~sg2a10=~f10,~sg2a11=~f11,~sg2a12=~f12];});
	if([~sg2b1,~sg2b2,~sg2b3,~sg2b4,~sg2b5,~sg2b6,~sg2b7,~sg2b8,~sg2b9,~sg2b10,~sg2b11,~sg2b12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg2b1=~f1,~sg2b2=~f2,~sg2b3=~f3,~sg2b4=~f4,~sg2b5=~f5,~sg2b6=~f6,~sg2b7=~f7,~sg2b8=~f8,~sg2b9=~f9,~sg2b10=~f10,~sg2b11=~f11,~sg2b12=~f12];});
	if([~sg2c1,~sg2c2,~sg2c3,~sg2c4,~sg2c5,~sg2c6,~sg2c7,~sg2c8,~sg2c9,~sg2c10,~sg2c11,~sg2c12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg2c1=~f1,~sg2c2=~f2,~sg2c3=~f3,~sg2c4=~f4,~sg2c5=~f5,~sg2c6=~f6,~sg2c7=~f7,~sg2c8=~f8,~sg2c9=~f9,~sg2c10=~f10,~sg2c11=~f11,~sg2c12=~f12];});
	if([~sg2d1,~sg2d2,~sg2d3,~sg2d4,~sg2d5,~sg2d6,~sg2d7,~sg2d8,~sg2d9,~sg2d10,~sg2d11,~sg2d12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg2d1=~f1,~sg2d2=~f2,~sg2d3=~f3,~sg2d4=~f4,~sg2d5=~f5,~sg2d6=~f6,~sg2d7=~f7,~sg2d8=~f8,~sg2d9=~f9,~sg2d10=~f10,~sg2d11=~f11,~sg2d12=~f12];});
	if([~sg2e1,~sg2e2,~sg2e3,~sg2e4,~sg2e5,~sg2e6,~sg2e7,~sg2e8,~sg2e9,~sg2e10,~sg2e11,~sg2e12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg2e1=~f1,~sg2e2=~f2,~sg2e3=~f3,~sg2e4=~f4,~sg2e5=~f5,~sg2e6=~f6,~sg2e7=~f7,~sg2e8=~f8,~sg2e9=~f9,~sg2e10=~f10,~sg2e11=~f11,~sg2e12=~f12];});
	if([~sg2f1,~sg2f2,~sg2f3,~sg2f4,~sg2f5,~sg2f6,~sg2f7,~sg2f8,~sg2f9,~sg2f10,~sg2f11,~sg2f12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg2f1=~f1,~sg2f2=~f2,~sg2f3=~f3,~sg2f4=~f4,~sg2f5=~f5,~sg2f6=~f6,~sg2f7=~f7,~sg2f8=~f8,~sg2f9=~f9,~sg2f10=~f10,~sg2f11=~f11,~sg2f12=~f12];});
	if([~sg2g1,~sg2g2,~sg2g3,~sg2g4,~sg2g5,~sg2g6,~sg2g7,~sg2g8,~sg2g9,~sg2g10,~sg2g11,~sg2g12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg2g1=~f1,~sg2g2=~f2,~sg2g3=~f3,~sg2g4=~f4,~sg2g5=~f5,~sg2g6=~f6,~sg2g7=~f7,~sg2g8=~f8,~sg2g9=~f9,~sg2g10=~f10,~sg2g11=~f11,~sg2g12=~f12];});
	if([~sg2h1,~sg2h2,~sg2h3,~sg2h4,~sg2h5,~sg2h6,~sg2h7,~sg2h8,~sg2h9,~sg2h10,~sg2h11,~sg2h12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg2h1=~f1,~sg2h2=~f2,~sg2h3=~f3,~sg2h4=~f4,~sg2h5=~f5,~sg2h6=~f6,~sg2h7=~f7,~sg2h8=~f8,~sg2h9=~f9,~sg2h10=~f10,~sg2h11=~f11,~sg2h12=~f12];});
	if([~sg3a1,~sg3a2,~sg3a3,~sg3a4,~sg3a5,~sg3a6,~sg3a7,~sg3a8,~sg3a9,~sg3a10,~sg3a11,~sg3a12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg3a1=~f1,~sg3a2=~f2,~sg3a3=~f3,~sg3a4=~f4,~sg3a5=~f5,~sg3a6=~f6,~sg3a7=~f7,~sg3a8=~f8,~sg3a9=~f9,~sg3a10=~f10,~sg3a11=~f11,~sg3a12=~f12];});
	if([~sg3b1,~sg3b2,~sg3b3,~sg3b4,~sg3b5,~sg3b6,~sg3b7,~sg3b8,~sg3b9,~sg3b10,~sg3b11,~sg3b12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg3b1=~f1,~sg3b2=~f2,~sg3b3=~f3,~sg3b4=~f4,~sg3b5=~f5,~sg3b6=~f6,~sg3b7=~f7,~sg3b8=~f8,~sg3b9=~f9,~sg3b10=~f10,~sg3b11=~f11,~sg3b12=~f12];});
	if([~sg3c1,~sg3c2,~sg3c3,~sg3c4,~sg3c5,~sg3c6,~sg3c7,~sg3c8,~sg3c9,~sg3c10,~sg3c11,~sg3c12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg3c1=~f1,~sg3c2=~f2,~sg3c3=~f3,~sg3c4=~f4,~sg3c5=~f5,~sg3c6=~f6,~sg3c7=~f7,~sg3c8=~f8,~sg3c9=~f9,~sg3c10=~f10,~sg3c11=~f11,~sg3c12=~f12];});
	if([~sg3d1,~sg3d2,~sg3d3,~sg3d4,~sg3d5,~sg3d6,~sg3d7,~sg3d8,~sg3d9,~sg3d10,~sg3d11,~sg3d12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg3d1=~f1,~sg3d2=~f2,~sg3d3=~f3,~sg3d4=~f4,~sg3d5=~f5,~sg3d6=~f6,~sg3d7=~f7,~sg3d8=~f8,~sg3d9=~f9,~sg3d10=~f10,~sg3d11=~f11,~sg3d12=~f12];});
	if([~sg3e1,~sg3e2,~sg3e3,~sg3e4,~sg3e5,~sg3e6,~sg3e7,~sg3e8,~sg3e9,~sg3e10,~sg3e11,~sg3e12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg3e1=~f1,~sg3e2=~f2,~sg3e3=~f3,~sg3e4=~f4,~sg3e5=~f5,~sg3e6=~f6,~sg3e7=~f7,~sg3e8=~f8,~sg3e9=~f9,~sg3e10=~f10,~sg3e11=~f11,~sg3e12=~f12];});
	if([~sg3f1,~sg3f2,~sg3f3,~sg3f4,~sg3f5,~sg3f6,~sg3f7,~sg3f8,~sg3f9,~sg3f10,~sg3f11,~sg3f12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg3f1=~f1,~sg3f2=~f2,~sg3f3=~f3,~sg3f4=~f4,~sg3f5=~f5,~sg3f6=~f6,~sg3f7=~f7,~sg3f8=~f8,~sg3f9=~f9,~sg3f10=~f10,~sg3f11=~f11,~sg3f12=~f12];});
	if([~sg3g1,~sg3g2,~sg3g3,~sg3g4,~sg3g5,~sg3g6,~sg3g7,~sg3g8,~sg3g9,~sg3g10,~sg3g11,~sg3g12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg3g1=~f1,~sg3g2=~f2,~sg3g3=~f3,~sg3g4=~f4,~sg3g5=~f5,~sg3g6=~f6,~sg3g7=~f7,~sg3g8=~f8,~sg3g9=~f9,~sg3g10=~f10,~sg3g11=~f11,~sg3g12=~f12];});
	if([~sg3h1,~sg3h2,~sg3h3,~sg3h4,~sg3h5,~sg3h6,~sg3h7,~sg3h8,~sg3h9,~sg3h10,~sg3h11,~sg3h12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg3h1=~f1,~sg3h2=~f2,~sg3h3=~f3,~sg3h4=~f4,~sg3h5=~f5,~sg3h6=~f6,~sg3h7=~f7,~sg3h8=~f8,~sg3h9=~f9,~sg3h10=~f10,~sg3h11=~f11,~sg3h12=~f12];});
	if([~sg4a1,~sg4a2,~sg4a3,~sg4a4,~sg4a5,~sg4a6,~sg4a7,~sg4a8,~sg4a9,~sg4a10,~sg4a11,~sg4a12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg4a1=~f1,~sg4a2=~f2,~sg4a3=~f3,~sg4a4=~f4,~sg4a5=~f5,~sg4a6=~f6,~sg4a7=~f7,~sg4a8=~f8,~sg4a9=~f9,~sg4a10=~f10,~sg4a11=~f11,~sg4a12=~f12];});
	if([~sg4b1,~sg4b2,~sg4b3,~sg4b4,~sg4b5,~sg4b6,~sg4b7,~sg4b8,~sg4b9,~sg4b10,~sg4b11,~sg4b12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg4b1=~f1,~sg4b2=~f2,~sg4b3=~f3,~sg4b4=~f4,~sg4b5=~f5,~sg4b6=~f6,~sg4b7=~f7,~sg4b8=~f8,~sg4b9=~f9,~sg4b10=~f10,~sg4b11=~f11,~sg4b12=~f12];});
	if([~sg4c1,~sg4c2,~sg4c3,~sg4c4,~sg4c5,~sg4c6,~sg4c7,~sg4c8,~sg4c9,~sg4c10,~sg4c11,~sg4c12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg4c1=~f1,~sg4c2=~f2,~sg4c3=~f3,~sg4c4=~f4,~sg4c5=~f5,~sg4c6=~f6,~sg4c7=~f7,~sg4c8=~f8,~sg4c9=~f9,~sg4c10=~f10,~sg4c11=~f11,~sg4c12=~f12];});
	if([~sg4d1,~sg4d2,~sg4d3,~sg4d4,~sg4d5,~sg4d6,~sg4d7,~sg4d8,~sg4d9,~sg4d10,~sg4d11,~sg4d12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg4d1=~f1,~sg4d2=~f2,~sg4d3=~f3,~sg4d4=~f4,~sg4d5=~f5,~sg4d6=~f6,~sg4d7=~f7,~sg4d8=~f8,~sg4d9=~f9,~sg4d10=~f10,~sg4d11=~f11,~sg4d12=~f12];});
	if([~sg4e1,~sg4e2,~sg4e3,~sg4e4,~sg4e5,~sg4e6,~sg4e7,~sg4e8,~sg4e9,~sg4e10,~sg4e11,~sg4e12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg4e1=~f1,~sg4e2=~f2,~sg4e3=~f3,~sg4e4=~f4,~sg4e5=~f5,~sg4e6=~f6,~sg4e7=~f7,~sg4e8=~f8,~sg4e9=~f9,~sg4e10=~f10,~sg4e11=~f11,~sg4e12=~f12];});
	if([~sg4f1,~sg4f2,~sg4f3,~sg4f4,~sg4f5,~sg4f6,~sg4f7,~sg4f8,~sg4f9,~sg4f10,~sg4f11,~sg4f12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg4f1=~f1,~sg4f2=~f2,~sg4f3=~f3,~sg4f4=~f4,~sg4f5=~f5,~sg4f6=~f6,~sg4f7=~f7,~sg4f8=~f8,~sg4f9=~f9,~sg4f10=~f10,~sg4f11=~f11,~sg4f12=~f12];});
	if([~sg4g1,~sg4g2,~sg4g3,~sg4g4,~sg4g5,~sg4g6,~sg4g7,~sg4g8,~sg4g9,~sg4g10,~sg4g11,~sg4g12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg4g1=~f1,~sg4g2=~f2,~sg4g3=~f3,~sg4g4=~f4,~sg4g5=~f5,~sg4g6=~f6,~sg4g7=~f7,~sg4g8=~f8,~sg4g9=~f9,~sg4g10=~f10,~sg4g11=~f11,~sg4g12=~f12];});
	if([~sg4h1,~sg4h2,~sg4h3,~sg4h4,~sg4h5,~sg4h6,~sg4h7,~sg4h8,~sg4h9,~sg4h10,~sg4h11,~sg4h12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg4h1=~f1,~sg4h2=~f2,~sg4h3=~f3,~sg4h4=~f4,~sg4h5=~f5,~sg4h6=~f6,~sg4h7=~f7,~sg4h8=~f8,~sg4h9=~f9,~sg4h10=~f10,~sg4h11=~f11,~sg4h12=~f12];});
	if([~sg5a1,~sg5a2,~sg5a3,~sg5a4,~sg5a5,~sg5a6,~sg5a7,~sg5a8,~sg5a9,~sg5a10,~sg5a11,~sg5a12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg5a1=~f1,~sg5a2=~f2,~sg5a3=~f3,~sg5a4=~f4,~sg5a5=~f5,~sg5a6=~f6,~sg5a7=~f7,~sg5a8=~f8,~sg5a9=~f9,~sg5a10=~f10,~sg5a11=~f11,~sg5a12=~f12];});
	if([~sg5b1,~sg5b2,~sg5b3,~sg5b4,~sg5b5,~sg5b6,~sg5b7,~sg5b8,~sg5b9,~sg5b10,~sg5b11,~sg5b12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg5b1=~f1,~sg5b2=~f2,~sg5b3=~f3,~sg5b4=~f4,~sg5b5=~f5,~sg5b6=~f6,~sg5b7=~f7,~sg5b8=~f8,~sg5b9=~f9,~sg5b10=~f10,~sg5b11=~f11,~sg5b12=~f12];});
	if([~sg5c1,~sg5c2,~sg5c3,~sg5c4,~sg5c5,~sg5c6,~sg5c7,~sg5c8,~sg5c9,~sg5c10,~sg5c11,~sg5c12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg5c1=~f1,~sg5c2=~f2,~sg5c3=~f3,~sg5c4=~f4,~sg5c5=~f5,~sg5c6=~f6,~sg5c7=~f7,~sg5c8=~f8,~sg5c9=~f9,~sg5c10=~f10,~sg5c11=~f11,~sg5c12=~f12];});
	if([~sg5d1,~sg5d2,~sg5d3,~sg5d4,~sg5d5,~sg5d6,~sg5d7,~sg5d8,~sg5d9,~sg5d10,~sg5d11,~sg5d12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg5d1=~f1,~sg5d2=~f2,~sg5d3=~f3,~sg5d4=~f4,~sg5d5=~f5,~sg5d6=~f6,~sg5d7=~f7,~sg5d8=~f8,~sg5d9=~f9,~sg5d10=~f10,~sg5d11=~f11,~sg5d12=~f12];});
	if([~sg5e1,~sg5e2,~sg5e3,~sg5e4,~sg5e5,~sg5e6,~sg5e7,~sg5e8,~sg5e9,~sg5e10,~sg5e11,~sg5e12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg5e1=~f1,~sg5e2=~f2,~sg5e3=~f3,~sg5e4=~f4,~sg5e5=~f5,~sg5e6=~f6,~sg5e7=~f7,~sg5e8=~f8,~sg5e9=~f9,~sg5e10=~f10,~sg5e11=~f11,~sg5e12=~f12];});
	if([~sg5f1,~sg5f2,~sg5f3,~sg5f4,~sg5f5,~sg5f6,~sg5f7,~sg5f8,~sg5f9,~sg5f10,~sg5f11,~sg5f12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg5f1=~f1,~sg5f2=~f2,~sg5f3=~f3,~sg5f4=~f4,~sg5f5=~f5,~sg5f6=~f6,~sg5f7=~f7,~sg5f8=~f8,~sg5f9=~f9,~sg5f10=~f10,~sg5f11=~f11,~sg5f12=~f12];});
	if([~sg5g1,~sg5g2,~sg5g3,~sg5g4,~sg5g5,~sg5g6,~sg5g7,~sg5g8,~sg5g9,~sg5g10,~sg5g11,~sg5g12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg5g1=~f1,~sg5g2=~f2,~sg5g3=~f3,~sg5g4=~f4,~sg5g5=~f5,~sg5g6=~f6,~sg5g7=~f7,~sg5g8=~f8,~sg5g9=~f9,~sg5g10=~f10,~sg5g11=~f11,~sg5g12=~f12];});
	if([~sg5h1,~sg5h2,~sg5h3,~sg5h4,~sg5h5,~sg5h6,~sg5h7,~sg5h8,~sg5h9,~sg5h10,~sg5h11,~sg5h12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg5h1=~f1,~sg5h2=~f2,~sg5h3=~f3,~sg5h4=~f4,~sg5h5=~f5,~sg5h6=~f6,~sg5h7=~f7,~sg5h8=~f8,~sg5h9=~f9,~sg5h10=~f10,~sg5h11=~f11,~sg5h12=~f12];});
	if([~sg6a1,~sg6a2,~sg6a3,~sg6a4,~sg6a5,~sg6a6,~sg6a7,~sg6a8,~sg6a9,~sg6a10,~sg6a11,~sg6a12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg6a1=~f1,~sg6a2=~f2,~sg6a3=~f3,~sg6a4=~f4,~sg6a5=~f5,~sg6a6=~f6,~sg6a7=~f7,~sg6a8=~f8,~sg6a9=~f9,~sg6a10=~f10,~sg6a11=~f11,~sg6a12=~f12];});
	if([~sg6b1,~sg6b2,~sg6b3,~sg6b4,~sg6b5,~sg6b6,~sg6b7,~sg6b8,~sg6b9,~sg6b10,~sg6b11,~sg6b12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg6b1=~f1,~sg6b2=~f2,~sg6b3=~f3,~sg6b4=~f4,~sg6b5=~f5,~sg6b6=~f6,~sg6b7=~f7,~sg6b8=~f8,~sg6b9=~f9,~sg6b10=~f10,~sg6b11=~f11,~sg6b12=~f12];});
	if([~sg6c1,~sg6c2,~sg6c3,~sg6c4,~sg6c5,~sg6c6,~sg6c7,~sg6c8,~sg6c9,~sg6c10,~sg6c11,~sg6c12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg6c1=~f1,~sg6c2=~f2,~sg6c3=~f3,~sg6c4=~f4,~sg6c5=~f5,~sg6c6=~f6,~sg6c7=~f7,~sg6c8=~f8,~sg6c9=~f9,~sg6c10=~f10,~sg6c11=~f11,~sg6c12=~f12];});
	if([~sg6d1,~sg6d2,~sg6d3,~sg6d4,~sg6d5,~sg6d6,~sg6d7,~sg6d8,~sg6d9,~sg6d10,~sg6d11,~sg6d12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg6d1=~f1,~sg6d2=~f2,~sg6d3=~f3,~sg6d4=~f4,~sg6d5=~f5,~sg6d6=~f6,~sg6d7=~f7,~sg6d8=~f8,~sg6d9=~f9,~sg6d10=~f10,~sg6d11=~f11,~sg6d12=~f12];});
	if([~sg6e1,~sg6e2,~sg6e3,~sg6e4,~sg6e5,~sg6e6,~sg6e7,~sg6e8,~sg6e9,~sg6e10,~sg6e11,~sg6e12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg6e1=~f1,~sg6e2=~f2,~sg6e3=~f3,~sg6e4=~f4,~sg6e5=~f5,~sg6e6=~f6,~sg6e7=~f7,~sg6e8=~f8,~sg6e9=~f9,~sg6e10=~f10,~sg6e11=~f11,~sg6e12=~f12];});
	if([~sg6f1,~sg6f2,~sg6f3,~sg6f4,~sg6f5,~sg6f6,~sg6f7,~sg6f8,~sg6f9,~sg6f10,~sg6f11,~sg6f12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg6f1=~f1,~sg6f2=~f2,~sg6f3=~f3,~sg6f4=~f4,~sg6f5=~f5,~sg6f6=~f6,~sg6f7=~f7,~sg6f8=~f8,~sg6f9=~f9,~sg6f10=~f10,~sg6f11=~f11,~sg6f12=~f12];});
	if([~sg6g1,~sg6g2,~sg6g3,~sg6g4,~sg6g5,~sg6g6,~sg6g7,~sg6g8,~sg6g9,~sg6g10,~sg6g11,~sg6g12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg6g1=~f1,~sg6g2=~f2,~sg6g3=~f3,~sg6g4=~f4,~sg6g5=~f5,~sg6g6=~f6,~sg6g7=~f7,~sg6g8=~f8,~sg6g9=~f9,~sg6g10=~f10,~sg6g11=~f11,~sg6g12=~f12];});
	if([~sg6h1,~sg6h2,~sg6h3,~sg6h4,~sg6h5,~sg6h6,~sg6h7,~sg6h8,~sg6h9,~sg6h10,~sg6h11,~sg6h12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg6h1=~f1,~sg6h2=~f2,~sg6h3=~f3,~sg6h4=~f4,~sg6h5=~f5,~sg6h6=~f6,~sg6h7=~f7,~sg6h8=~f8,~sg6h9=~f9,~sg6h10=~f10,~sg6h11=~f11,~sg6h12=~f12];});
	if([~sg7a1,~sg7a2,~sg7a3,~sg7a4,~sg7a5,~sg7a6,~sg7a7,~sg7a8,~sg7a9,~sg7a10,~sg7a11,~sg7a12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg7a1=~f1,~sg7a2=~f2,~sg7a3=~f3,~sg7a4=~f4,~sg7a5=~f5,~sg7a6=~f6,~sg7a7=~f7,~sg7a8=~f8,~sg7a9=~f9,~sg7a10=~f10,~sg7a11=~f11,~sg7a12=~f12];});
	if([~sg7b1,~sg7b2,~sg7b3,~sg7b4,~sg7b5,~sg7b6,~sg7b7,~sg7b8,~sg7b9,~sg7b10,~sg7b11,~sg7b12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg7b1=~f1,~sg7b2=~f2,~sg7b3=~f3,~sg7b4=~f4,~sg7b5=~f5,~sg7b6=~f6,~sg7b7=~f7,~sg7b8=~f8,~sg7b9=~f9,~sg7b10=~f10,~sg7b11=~f11,~sg7b12=~f12];});
	if([~sg7c1,~sg7c2,~sg7c3,~sg7c4,~sg7c5,~sg7c6,~sg7c7,~sg7c8,~sg7c9,~sg7c10,~sg7c11,~sg7c12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg7c1=~f1,~sg7c2=~f2,~sg7c3=~f3,~sg7c4=~f4,~sg7c5=~f5,~sg7c6=~f6,~sg7c7=~f7,~sg7c8=~f8,~sg7c9=~f9,~sg7c10=~f10,~sg7c11=~f11,~sg7c12=~f12];});
	if([~sg7d1,~sg7d2,~sg7d3,~sg7d4,~sg7d5,~sg7d6,~sg7d7,~sg7d8,~sg7d9,~sg7d10,~sg7d11,~sg7d12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg7d1=~f1,~sg7d2=~f2,~sg7d3=~f3,~sg7d4=~f4,~sg7d5=~f5,~sg7d6=~f6,~sg7d7=~f7,~sg7d8=~f8,~sg7d9=~f9,~sg7d10=~f10,~sg7d11=~f11,~sg7d12=~f12];});
	if([~sg7e1,~sg7e2,~sg7e3,~sg7e4,~sg7e5,~sg7e6,~sg7e7,~sg7e8,~sg7e9,~sg7e10,~sg7e11,~sg7e12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg7e1=~f1,~sg7e2=~f2,~sg7e3=~f3,~sg7e4=~f4,~sg7e5=~f5,~sg7e6=~f6,~sg7e7=~f7,~sg7e8=~f8,~sg7e9=~f9,~sg7e10=~f10,~sg7e11=~f11,~sg7e12=~f12];});
	if([~sg7f1,~sg7f2,~sg7f3,~sg7f4,~sg7f5,~sg7f6,~sg7f7,~sg7f8,~sg7f9,~sg7f10,~sg7f11,~sg7f12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg7f1=~f1,~sg7f2=~f2,~sg7f3=~f3,~sg7f4=~f4,~sg7f5=~f5,~sg7f6=~f6,~sg7f7=~f7,~sg7f8=~f8,~sg7f9=~f9,~sg7f10=~f10,~sg7f11=~f11,~sg7f12=~f12];});
	if([~sg7g1,~sg7g2,~sg7g3,~sg7g4,~sg7g5,~sg7g6,~sg7g7,~sg7g8,~sg7g9,~sg7g10,~sg7g11,~sg7g12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg7g1=~f1,~sg7g2=~f2,~sg7g3=~f3,~sg7g4=~f4,~sg7g5=~f5,~sg7g6=~f6,~sg7g7=~f7,~sg7g8=~f8,~sg7g9=~f9,~sg7g10=~f10,~sg7g11=~f11,~sg7g12=~f12];});
	if([~sg7h1,~sg7h2,~sg7h3,~sg7h4,~sg7h5,~sg7h6,~sg7h7,~sg7h8,~sg7h9,~sg7h10,~sg7h11,~sg7h12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg7h1=~f1,~sg7h2=~f2,~sg7h3=~f3,~sg7h4=~f4,~sg7h5=~f5,~sg7h6=~f6,~sg7h7=~f7,~sg7h8=~f8,~sg7h9=~f9,~sg7h10=~f10,~sg7h11=~f11,~sg7h12=~f12];});
	if([~sg8a1,~sg8a2,~sg8a3,~sg8a4,~sg8a5,~sg8a6,~sg8a7,~sg8a8,~sg8a9,~sg8a10,~sg8a11,~sg8a12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg8a1=~f1,~sg8a2=~f2,~sg8a3=~f3,~sg8a4=~f4,~sg8a5=~f5,~sg8a6=~f6,~sg8a7=~f7,~sg8a8=~f8,~sg8a9=~f9,~sg8a10=~f10,~sg8a11=~f11,~sg8a12=~f12];});
	if([~sg8b1,~sg8b2,~sg8b3,~sg8b4,~sg8b5,~sg8b6,~sg8b7,~sg8b8,~sg8b9,~sg8b10,~sg8b11,~sg8b12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg8b1=~f1,~sg8b2=~f2,~sg8b3=~f3,~sg8b4=~f4,~sg8b5=~f5,~sg8b6=~f6,~sg8b7=~f7,~sg8b8=~f8,~sg8b9=~f9,~sg8b10=~f10,~sg8b11=~f11,~sg8b12=~f12];});
	if([~sg8c1,~sg8c2,~sg8c3,~sg8c4,~sg8c5,~sg8c6,~sg8c7,~sg8c8,~sg8c9,~sg8c10,~sg8c11,~sg8c12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg8c1=~f1,~sg8c2=~f2,~sg8c3=~f3,~sg8c4=~f4,~sg8c5=~f5,~sg8c6=~f6,~sg8c7=~f7,~sg8c8=~f8,~sg8c9=~f9,~sg8c10=~f10,~sg8c11=~f11,~sg8c12=~f12];});
	if([~sg8d1,~sg8d2,~sg8d3,~sg8d4,~sg8d5,~sg8d6,~sg8d7,~sg8d8,~sg8d9,~sg8d10,~sg8d11,~sg8d12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg8d1=~f1,~sg8d2=~f2,~sg8d3=~f3,~sg8d4=~f4,~sg8d5=~f5,~sg8d6=~f6,~sg8d7=~f7,~sg8d8=~f8,~sg8d9=~f9,~sg8d10=~f10,~sg8d11=~f11,~sg8d12=~f12];});
	if([~sg8e1,~sg8e2,~sg8e3,~sg8e4,~sg8e5,~sg8e6,~sg8e7,~sg8e8,~sg8e9,~sg8e10,~sg8e11,~sg8e12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg8e1=~f1,~sg8e2=~f2,~sg8e3=~f3,~sg8e4=~f4,~sg8e5=~f5,~sg8e6=~f6,~sg8e7=~f7,~sg8e8=~f8,~sg8e9=~f9,~sg8e10=~f10,~sg8e11=~f11,~sg8e12=~f12];});
	if([~sg8f1,~sg8f2,~sg8f3,~sg8f4,~sg8f5,~sg8f6,~sg8f7,~sg8f8,~sg8f9,~sg8f10,~sg8f11,~sg8f12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg8f1=~f1,~sg8f2=~f2,~sg8f3=~f3,~sg8f4=~f4,~sg8f5=~f5,~sg8f6=~f6,~sg8f7=~f7,~sg8f8=~f8,~sg8f9=~f9,~sg8f10=~f10,~sg8f11=~f11,~sg8f12=~f12];});
	if([~sg8g1,~sg8g2,~sg8g3,~sg8g4,~sg8g5,~sg8g6,~sg8g7,~sg8g8,~sg8g9,~sg8g10,~sg8g11,~sg8g12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg8g1=~f1,~sg8g2=~f2,~sg8g3=~f3,~sg8g4=~f4,~sg8g5=~f5,~sg8g6=~f6,~sg8g7=~f7,~sg8g8=~f8,~sg8g9=~f9,~sg8g10=~f10,~sg8g11=~f11,~sg8g12=~f12];});
	if([~sg8h1,~sg8h2,~sg8h3,~sg8h4,~sg8h5,~sg8h6,~sg8h7,~sg8h8,~sg8h9,~sg8h10,~sg8h11,~sg8h12] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil], {[~sg8h1=~f1,~sg8h2=~f2,~sg8h3=~f3,~sg8h4=~f4,~sg8h5=~f5,~sg8h6=~f6,~sg8h7=~f7,~sg8h8=~f8,~sg8h9=~f9,~sg8h10=~f10,~sg8h11=~f11,~sg8h12=~f12];});


	//synthdefs

	~gsine1 = {
		SynthDef(\gsineicfld1, {arg graindur = 0.04, dur = 2000, atk = 0.007, rel = 0.01, gate = 1, amp = 1, i = 1, vol = ~vol, rate = 20, tune = 0,dseqval,
			a, b, c, d, e, f, pan=0, fc = 1;
			var s1, out, env1, s2, dseq,n1,n2,n3,n4,n5,n6,n7,n8,n9;
			#n1=[~gm];
			dseq = Dseq([/*1*/	#a,b,c,d,e,f=[ ~a,~b,~c,~d,~e,~f  ],/*2*/	[ a = a/~fth, b = b/~fth, c = c/~fth, d = d/~fth, e = e/~fth, f = f/~fth ],/*3*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f*~fth  ],/*4*/	[ a = a*~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f/~fth  ],/*5*/	[ a = a/~fth,    b = b*~fth,    c = c,         d = d*~fth,    e = e,         f = f*~fth ],/*6*/	[ a = a*~fth,    b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f/~fth  ],/*7*/	[ a = a/~fth,    b = b/~fth,    c = c/~fth,    d = d,         e = e,         f = f ],/*8*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*9*/	[ a = a*~fth,    b = b,         c = c,         d = d*~fth,    e = e*~fth,    f = f*~fth ],/*10*/	[ a = a,         b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*11*/	[ a = a/~fth,    b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*12*/	[ a = a*~fth, b = b*~fth, c = c*~fth, d = d/~fth, e = e/~fth, f = f/~fth ],/*13*/	[ a = a,         b = b,         c = c,         d = d*~fth,    e = e,         f = f*~fth ],/*14*/	[ a = a,         b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f],/*15*/	[ a = a/~fth,    b = b,         c = c/~fth,    d = d,         e = e/~fth,    f = f/~fth ],/*16*/	[ a = a,         b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*17*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f*~fth],/*18*/	[ a = a*~fth, b = b/~fth, c = c/~fth, d = d*~fth, e = e*~fth, f = f/~fth ],/*19*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e,         f = f*~fth ],/*20*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f/~fth ],/*21*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d,         e = e,         f = f*~fth ],/*22*/	[ a = a,         b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*23*/	[ a = a,         b = b,         c = c,         d = d/~fth,    e = e,         f = f/~fth ],/*24*/	[ a = a/~fth,    b = b,         c = c,         d = d,         e = e,         f = f*~fth ],/*25*/	[ a = a*~fth,    b = b*~fth,    c = c*~fth,    d = d,         e = e,         f = f ],/*26*/	[ a = a,         b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*27*/	[ a = a,         b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f ],/*28*/	[ a = a/~fth, b = b*~fth, c = c*~fth, d = d*~fth, e = e*~fth, f = f/~fth ],/*29*/	[ a = a,         b = b,         c = c/~fth,    d = d/~fth,    e = e,         f = f ],/*30*/	[ a = a*~fth, b = b/~fth, c = c*~fth, d = d*~fth, e = e/~fth, f = f*~fth ],/*31*/	[ a = a/~fth,    b = b*~fth,    c = c,         d = d,         e = e,         f = f/~fth ],/*32*/	[ a = a,         b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f ],/*33*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*34*/	[ a = a/~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f*~fth ],/*35*/	[ a = a*~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f/~fth ],/*36*/	[ a = a/~fth,    b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f*~fth ],/*37*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e,         f = f ],/*38*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d/~fth,    e = e*~fth,    f = f ],/*39*/	[ a = a/~fth, b = b*~fth, c = c/~fth, d = d*~fth, e = e/~fth, f = f/~fth ],/*40*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d/~fth,    e = e*~fth,    f = f ],/*41*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d,         e = e,         f = f*~fth ],/*42*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*43*/	[ a = a/~fth,    b = b,         c = c*~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*44*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f/~fth ],/*45*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f ],/*46*/	[ a = a,         b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*47*/	[ a = a,         b = b*~fth,    c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*48*/	[ a = a,         b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*49*/	[ a = a,         b = b,         c = c*~fth,    d = d,         e = e/~fth,    f = f*~fth ],/*50*/	[ a = a*~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f/~fth ],/*51*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f*~fth ],/*52*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f/~fth ],/*53*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f ],/*54*/	[ a = a/~fth, b = b/~fth, c = c*~fth, d = d/~fth, e = e*~fth, f = f*~fth ],/*55*/	[ a = a,         b = b,         c = c,         d = d*~fth,    e = e/~fth,    f = f ],/*56*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f/~fth ],/*57*/	[ a = a,         b = b*~fth,    c = c/~fth,    d = d,         e = e*~fth,    f = f ],/*58*/	[ a = a/~fth,    b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f*~fth ],/*59*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d,         e = e,         f = f/~fth ],/*60*/	[ a = a/~fth,    b = b,         c = c,         d = d,         e = e,         f = f*~fth ],/*61*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f ],/*62*/	[ a = a/~fth, b = b/~fth, c = c*~fth, d = d*~fth, e = e/~fth, f = f/~fth ],/*63*/	[ a = a,         b = b*~fth,    c = c/~fth,    d = d,         e = e,         f = f*~fth ],/*64*/	[ a = a*~fth, b = b/~fth, c = c*~fth, d = d/~fth, e = e*~fth, f = f/~fth ]]
				++Array.fill((~gsinenum -1), {[/*1*/	[ a = a*n1,         b = b*n1*~fth,    c = c*n1,         d = d*n1*~fth,    e = e*n1,         f = f*n1*~fth ],/*2*/	[ a = a/~fth, b = b/~fth, c = c/~fth, d = d/~fth, e = e/~fth, f = f/~fth ],/*3*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f*~fth  ],/*4*/	[ a = a*~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f/~fth  ],/*5*/	[ a = a/~fth,    b = b*~fth,    c = c,         d = d*~fth,    e = e,         f = f*~fth ],/*6*/	[ a = a*~fth,    b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f/~fth  ],/*7*/	[ a = a/~fth,    b = b/~fth,    c = c/~fth,    d = d,         e = e,         f = f ],/*8*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*9*/	[ a = a*~fth,    b = b,         c = c,         d = d*~fth,    e = e*~fth,    f = f*~fth ],/*10*/	[ a = a,         b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*11*/	[ a = a/~fth,    b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*12*/	[ a = a*~fth, b = b*~fth, c = c*~fth, d = d/~fth, e = e/~fth, f = f/~fth ],/*13*/	[ a = a,         b = b,         c = c,         d = d*~fth,    e = e,         f = f*~fth ],/*14*/	[ a = a,         b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f],/*15*/	[ a = a/~fth,    b = b,         c = c/~fth,    d = d,         e = e/~fth,    f = f/~fth ],/*16*/	[ a = a,         b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*17*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f*~fth],/*18*/	[ a = a*~fth, b = b/~fth, c = c/~fth, d = d*~fth, e = e*~fth, f = f/~fth ],/*19*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e,         f = f*~fth ],/*20*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f/~fth ],/*21*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d,         e = e,         f = f*~fth ],/*22*/	[ a = a,         b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*23*/	[ a = a,         b = b,         c = c,         d = d/~fth,    e = e,         f = f/~fth ],/*24*/	[ a = a/~fth,    b = b,         c = c,         d = d,         e = e,         f = f*~fth ],/*25*/	[ a = a*~fth,    b = b*~fth,    c = c*~fth,    d = d,         e = e,         f = f ],/*26*/	[ a = a,         b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*27*/	[ a = a,         b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f ],/*28*/	[ a = a/~fth, b = b*~fth, c = c*~fth, d = d*~fth, e = e*~fth, f = f/~fth ],/*29*/	[ a = a,         b = b,         c = c/~fth,    d = d/~fth,    e = e,         f = f ],/*30*/	[ a = a*~fth, b = b/~fth, c = c*~fth, d = d*~fth, e = e/~fth, f = f*~fth ],/*31*/	[ a = a/~fth,    b = b*~fth,    c = c,         d = d,         e = e,         f = f/~fth ],/*32*/	[ a = a,         b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f ],/*33*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*34*/	[ a = a/~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f*~fth ],/*35*/	[ a = a*~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f/~fth ],/*36*/	[ a = a/~fth,    b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f*~fth ],/*37*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e,         f = f ],/*38*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d/~fth,    e = e*~fth,    f = f ],/*39*/	[ a = a/~fth, b = b*~fth, c = c/~fth, d = d*~fth, e = e/~fth, f = f/~fth ],/*40*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d/~fth,    e = e*~fth,    f = f ],/*41*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d,         e = e,         f = f*~fth ],/*42*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*43*/	[ a = a/~fth,    b = b,         c = c*~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*44*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f/~fth ],/*45*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f ],/*46*/	[ a = a,         b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*47*/	[ a = a,         b = b*~fth,    c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*48*/	[ a = a,         b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*49*/	[ a = a,         b = b,         c = c*~fth,    d = d,         e = e/~fth,    f = f*~fth ],/*50*/	[ a = a*~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f/~fth ],/*51*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f*~fth ],/*52*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f/~fth ],/*53*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f ],/*54*/	[ a = a/~fth, b = b/~fth, c = c*~fth, d = d/~fth, e = e*~fth, f = f*~fth ],/*55*/	[ a = a,         b = b,         c = c,         d = d*~fth,    e = e/~fth,    f = f ],/*56*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f/~fth ],/*57*/	[ a = a,         b = b*~fth,    c = c/~fth,    d = d,         e = e*~fth,    f = f ],/*58*/	[ a = a/~fth,    b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f*~fth ],/*59*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d,         e = e,         f = f/~fth ],/*60*/	[ a = a/~fth,    b = b,         c = c,         d = d,         e = e,         f = f*~fth ],/*61*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f ],/*62*/	[ a = a/~fth, b = b/~fth, c = c*~fth, d = d*~fth, e = e/~fth, f = f/~fth ],/*63*/	[ a = a,         b = b*~fth,    c = c/~fth,    d = d,         e = e,         f = f*~fth ],/*64*/	[ a = a*~fth, b = b/~fth, c = c*~fth, d = d/~fth, e = e*~fth, f = f/~fth ]]
			}).flatten, inf);
			s1 = GrainSin.ar(1, Impulse.ar(dur+tune), 1/(dur+tune),Demand.ar(Impulse.ar(dur+tune), 0, dseq)*fc);
			OffsetOut.ar(0, s1.dup*vol);
		}, [\ir]).add;

		SynthDef(\gsineicrld1, {arg graindur = 0.04, dur = 2000, atk = 0.007, rel = 0.01, gate = 1, amp = 1, i = 1, vol = ~vol, rate = 20, tune = 0,dseqval,
			a, b, c, d, e, f, pan=0, fc = 1, id = -1;
			var s1, out, env1, s2, dseq,n1,n2,n3,n4,n5,n6,n7,n8,n9,af;
			#n1=[~gm];
			dseq = Dseq([[/*1*/	#a,b,c,d,e,f=[ ~a,~b,~c,~d,~e,~f  ],/*2*/	[ a = a/~fth, b = b/~fth, c = c/~fth, d = d/~fth, e = e/~fth, f = f/~fth ],/*3*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f*~fth  ],/*4*/	[ a = a*~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f/~fth  ],/*5*/	[ a = a/~fth,    b = b*~fth,    c = c,         d = d*~fth,    e = e,         f = f*~fth ],/*6*/	[ a = a*~fth,    b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f/~fth  ],/*7*/	[ a = a/~fth,    b = b/~fth,    c = c/~fth,    d = d,         e = e,         f = f ],/*8*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*9*/	[ a = a*~fth,    b = b,         c = c,         d = d*~fth,    e = e*~fth,    f = f*~fth ],/*10*/	[ a = a,         b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*11*/	[ a = a/~fth,    b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*12*/	[ a = a*~fth, b = b*~fth, c = c*~fth, d = d/~fth, e = e/~fth, f = f/~fth ],/*13*/	[ a = a,         b = b,         c = c,         d = d*~fth,    e = e,         f = f*~fth ],/*14*/	[ a = a,         b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f],/*15*/	[ a = a/~fth,    b = b,         c = c/~fth,    d = d,         e = e/~fth,    f = f/~fth ],/*16*/	[ a = a,         b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*17*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f*~fth],/*18*/	[ a = a*~fth, b = b/~fth, c = c/~fth, d = d*~fth, e = e*~fth, f = f/~fth ],/*19*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e,         f = f*~fth ],/*20*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f/~fth ],/*21*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d,         e = e,         f = f*~fth ],/*22*/	[ a = a,         b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*23*/	[ a = a,         b = b,         c = c,         d = d/~fth,    e = e,         f = f/~fth ],/*24*/	[ a = a/~fth,    b = b,         c = c,         d = d,         e = e,         f = f*~fth ],/*25*/	[ a = a*~fth,    b = b*~fth,    c = c*~fth,    d = d,         e = e,         f = f ],/*26*/	[ a = a,         b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*27*/	[ a = a,         b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f ],/*28*/	[ a = a/~fth, b = b*~fth, c = c*~fth, d = d*~fth, e = e*~fth, f = f/~fth ],/*29*/	[ a = a,         b = b,         c = c/~fth,    d = d/~fth,    e = e,         f = f ],/*30*/	[ a = a*~fth, b = b/~fth, c = c*~fth, d = d*~fth, e = e/~fth, f = f*~fth ],/*31*/	[ a = a/~fth,    b = b*~fth,    c = c,         d = d,         e = e,         f = f/~fth ],/*32*/	[ a = a,         b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f ],/*33*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*34*/	[ a = a/~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f*~fth ],/*35*/	[ a = a*~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f/~fth ],/*36*/	[ a = a/~fth,    b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f*~fth ],/*37*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e,         f = f ],/*38*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d/~fth,    e = e*~fth,    f = f ],/*39*/	[ a = a/~fth, b = b*~fth, c = c/~fth, d = d*~fth, e = e/~fth, f = f/~fth ],/*40*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d/~fth,    e = e*~fth,    f = f ],/*41*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d,         e = e,         f = f*~fth ],/*42*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*43*/	[ a = a/~fth,    b = b,         c = c*~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*44*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f/~fth ],/*45*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f ],/*46*/	[ a = a,         b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*47*/	[ a = a,         b = b*~fth,    c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*48*/	[ a = a,         b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*49*/	[ a = a,         b = b,         c = c*~fth,    d = d,         e = e/~fth,    f = f*~fth ],/*50*/	[ a = a*~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f/~fth ],/*51*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f*~fth ],/*52*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f/~fth ],/*53*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f ],/*54*/	[ a = a/~fth, b = b/~fth, c = c*~fth, d = d/~fth, e = e*~fth, f = f*~fth ],/*55*/	[ a = a,         b = b,         c = c,         d = d*~fth,    e = e/~fth,    f = f ],/*56*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f/~fth ],/*57*/	[ a = a,         b = b*~fth,    c = c/~fth,    d = d,         e = e*~fth,    f = f ],/*58*/	[ a = a/~fth,    b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f*~fth ],/*59*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d,         e = e,         f = f/~fth ],/*60*/	[ a = a/~fth,    b = b,         c = c,         d = d,         e = e,         f = f*~fth ],/*61*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f ],/*62*/	[ a = a/~fth, b = b/~fth, c = c*~fth, d = d*~fth, e = e/~fth, f = f/~fth ],/*63*/	[ a = a,         b = b*~fth,    c = c/~fth,    d = d,         e = e,         f = f*~fth ],/*64*/	[ a = a*~fth, b = b/~fth, c = c*~fth, d = d/~fth, e = e*~fth, f = f/~fth ]]
				++Array.fill((~gsinenum -1), {[/*1*/	[ a = a*n1,         b = b*n1*~fth,    c = c*n1,         d = d*n1*~fth,    e = e*n1,         f = f*n1*~fth ],/*2*/	[ a = a/~fth, b = b/~fth, c = c/~fth, d = d/~fth, e = e/~fth, f = f/~fth ],/*3*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f*~fth  ],/*4*/	[ a = a*~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f/~fth  ],/*5*/	[ a = a/~fth,    b = b*~fth,    c = c,         d = d*~fth,    e = e,         f = f*~fth ],/*6*/	[ a = a*~fth,    b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f/~fth  ],/*7*/	[ a = a/~fth,    b = b/~fth,    c = c/~fth,    d = d,         e = e,         f = f ],/*8*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*9*/	[ a = a*~fth,    b = b,         c = c,         d = d*~fth,    e = e*~fth,    f = f*~fth ],/*10*/	[ a = a,         b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*11*/	[ a = a/~fth,    b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*12*/	[ a = a*~fth, b = b*~fth, c = c*~fth, d = d/~fth, e = e/~fth, f = f/~fth ],/*13*/	[ a = a,         b = b,         c = c,         d = d*~fth,    e = e,         f = f*~fth ],/*14*/	[ a = a,         b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f],/*15*/	[ a = a/~fth,    b = b,         c = c/~fth,    d = d,         e = e/~fth,    f = f/~fth ],/*16*/	[ a = a,         b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*17*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f*~fth],/*18*/	[ a = a*~fth, b = b/~fth, c = c/~fth, d = d*~fth, e = e*~fth, f = f/~fth ],/*19*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e,         f = f*~fth ],/*20*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f/~fth ],/*21*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d,         e = e,         f = f*~fth ],/*22*/	[ a = a,         b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*23*/	[ a = a,         b = b,         c = c,         d = d/~fth,    e = e,         f = f/~fth ],/*24*/	[ a = a/~fth,    b = b,         c = c,         d = d,         e = e,         f = f*~fth ],/*25*/	[ a = a*~fth,    b = b*~fth,    c = c*~fth,    d = d,         e = e,         f = f ],/*26*/	[ a = a,         b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*27*/	[ a = a,         b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f ],/*28*/	[ a = a/~fth, b = b*~fth, c = c*~fth, d = d*~fth, e = e*~fth, f = f/~fth ],/*29*/	[ a = a,         b = b,         c = c/~fth,    d = d/~fth,    e = e,         f = f ],/*30*/	[ a = a*~fth, b = b/~fth, c = c*~fth, d = d*~fth, e = e/~fth, f = f*~fth ],/*31*/	[ a = a/~fth,    b = b*~fth,    c = c,         d = d,         e = e,         f = f/~fth ],/*32*/	[ a = a,         b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f ],/*33*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*34*/	[ a = a/~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f*~fth ],/*35*/	[ a = a*~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f/~fth ],/*36*/	[ a = a/~fth,    b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f*~fth ],/*37*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e,         f = f ],/*38*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d/~fth,    e = e*~fth,    f = f ],/*39*/	[ a = a/~fth, b = b*~fth, c = c/~fth, d = d*~fth, e = e/~fth, f = f/~fth ],/*40*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d/~fth,    e = e*~fth,    f = f ],/*41*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d,         e = e,         f = f*~fth ],/*42*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*43*/	[ a = a/~fth,    b = b,         c = c*~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*44*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f/~fth ],/*45*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f ],/*46*/	[ a = a,         b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*47*/	[ a = a,         b = b*~fth,    c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*48*/	[ a = a,         b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*49*/	[ a = a,         b = b,         c = c*~fth,    d = d,         e = e/~fth,    f = f*~fth ],/*50*/	[ a = a*~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f/~fth ],/*51*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f*~fth ],/*52*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f/~fth ],/*53*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f ],/*54*/	[ a = a/~fth, b = b/~fth, c = c*~fth, d = d/~fth, e = e*~fth, f = f*~fth ],/*55*/	[ a = a,         b = b,         c = c,         d = d*~fth,    e = e/~fth,    f = f ],/*56*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f/~fth ],/*57*/	[ a = a,         b = b*~fth,    c = c/~fth,    d = d,         e = e*~fth,    f = f ],/*58*/	[ a = a/~fth,    b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f*~fth ],/*59*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d,         e = e,         f = f/~fth ],/*60*/	[ a = a/~fth,    b = b,         c = c,         d = d,         e = e,         f = f*~fth ],/*61*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f ],/*62*/	[ a = a/~fth, b = b/~fth, c = c*~fth, d = d*~fth, e = e/~fth, f = f/~fth ],/*63*/	[ a = a,         b = b*~fth,    c = c/~fth,    d = d,         e = e,         f = f*~fth ],/*64*/	[ a = a*~fth, b = b/~fth, c = c*~fth, d = d/~fth, e = e*~fth, f = f/~fth ]]
			}).flatten].flatten.reverse, inf);
			s1 = GrainSin.ar(1, Impulse.ar(dur+tune), 1/(dur+tune), Demand.ar(Impulse.ar(dur+tune), 0, dseq));
			OffsetOut.ar(0, s1.dup*vol);
		}, [\ir]).add;

		SynthDef(\gsineicfld2, {arg graindur = 0.04, dur = 2000, atk = 0.007, rel = 0.01, gate = 1, amp = 1, i = 1, vol = ~vol, rate = 20, tune = 0,dseqval,
			a, b, c, d, e, f, pan=0, fc = 1;
			var s1, out, env1, s2, dseq,n1,n2,n3,n4,n5,n6,n7,n8,n9;
			#n1=[~gm2];
			dseq = Dseq([/*1*/	#a,b,c,d,e,f=[ ~a,~b,~c,~d,~e,~f  ],/*2*/	[ a = a/~fth, b = b/~fth, c = c/~fth, d = d/~fth, e = e/~fth, f = f/~fth ],/*3*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f*~fth  ],/*4*/	[ a = a*~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f/~fth  ],/*5*/	[ a = a/~fth,    b = b*~fth,    c = c,         d = d*~fth,    e = e,         f = f*~fth ],/*6*/	[ a = a*~fth,    b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f/~fth  ],/*7*/	[ a = a/~fth,    b = b/~fth,    c = c/~fth,    d = d,         e = e,         f = f ],/*8*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*9*/	[ a = a*~fth,    b = b,         c = c,         d = d*~fth,    e = e*~fth,    f = f*~fth ],/*10*/	[ a = a,         b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*11*/	[ a = a/~fth,    b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*12*/	[ a = a*~fth, b = b*~fth, c = c*~fth, d = d/~fth, e = e/~fth, f = f/~fth ],/*13*/	[ a = a,         b = b,         c = c,         d = d*~fth,    e = e,         f = f*~fth ],/*14*/	[ a = a,         b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f],/*15*/	[ a = a/~fth,    b = b,         c = c/~fth,    d = d,         e = e/~fth,    f = f/~fth ],/*16*/	[ a = a,         b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*17*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f*~fth],/*18*/	[ a = a*~fth, b = b/~fth, c = c/~fth, d = d*~fth, e = e*~fth, f = f/~fth ],/*19*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e,         f = f*~fth ],/*20*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f/~fth ],/*21*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d,         e = e,         f = f*~fth ],/*22*/	[ a = a,         b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*23*/	[ a = a,         b = b,         c = c,         d = d/~fth,    e = e,         f = f/~fth ],/*24*/	[ a = a/~fth,    b = b,         c = c,         d = d,         e = e,         f = f*~fth ],/*25*/	[ a = a*~fth,    b = b*~fth,    c = c*~fth,    d = d,         e = e,         f = f ],/*26*/	[ a = a,         b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*27*/	[ a = a,         b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f ],/*28*/	[ a = a/~fth, b = b*~fth, c = c*~fth, d = d*~fth, e = e*~fth, f = f/~fth ],/*29*/	[ a = a,         b = b,         c = c/~fth,    d = d/~fth,    e = e,         f = f ],/*30*/	[ a = a*~fth, b = b/~fth, c = c*~fth, d = d*~fth, e = e/~fth, f = f*~fth ],/*31*/	[ a = a/~fth,    b = b*~fth,    c = c,         d = d,         e = e,         f = f/~fth ],/*32*/	[ a = a,         b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f ],/*33*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*34*/	[ a = a/~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f*~fth ],/*35*/	[ a = a*~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f/~fth ],/*36*/	[ a = a/~fth,    b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f*~fth ],/*37*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e,         f = f ],/*38*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d/~fth,    e = e*~fth,    f = f ],/*39*/	[ a = a/~fth, b = b*~fth, c = c/~fth, d = d*~fth, e = e/~fth, f = f/~fth ],/*40*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d/~fth,    e = e*~fth,    f = f ],/*41*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d,         e = e,         f = f*~fth ],/*42*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*43*/	[ a = a/~fth,    b = b,         c = c*~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*44*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f/~fth ],/*45*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f ],/*46*/	[ a = a,         b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*47*/	[ a = a,         b = b*~fth,    c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*48*/	[ a = a,         b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*49*/	[ a = a,         b = b,         c = c*~fth,    d = d,         e = e/~fth,    f = f*~fth ],/*50*/	[ a = a*~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f/~fth ],/*51*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f*~fth ],/*52*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f/~fth ],/*53*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f ],/*54*/	[ a = a/~fth, b = b/~fth, c = c*~fth, d = d/~fth, e = e*~fth, f = f*~fth ],/*55*/	[ a = a,         b = b,         c = c,         d = d*~fth,    e = e/~fth,    f = f ],/*56*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f/~fth ],/*57*/	[ a = a,         b = b*~fth,    c = c/~fth,    d = d,         e = e*~fth,    f = f ],/*58*/	[ a = a/~fth,    b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f*~fth ],/*59*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d,         e = e,         f = f/~fth ],/*60*/	[ a = a/~fth,    b = b,         c = c,         d = d,         e = e,         f = f*~fth ],/*61*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f ],/*62*/	[ a = a/~fth, b = b/~fth, c = c*~fth, d = d*~fth, e = e/~fth, f = f/~fth ],/*63*/	[ a = a,         b = b*~fth,    c = c/~fth,    d = d,         e = e,         f = f*~fth ],/*64*/	[ a = a*~fth, b = b/~fth, c = c*~fth, d = d/~fth, e = e*~fth, f = f/~fth ]]
				++Array.fill((~gsinenum*2 -1), {[/*1*/	[ a = a*n1,         b = b*n1*~fth,    c = c*n1,         d = d*n1*~fth,    e = e*n1,         f = f*n1*~fth ],/*2*/	[ a = a/~fth, b = b/~fth, c = c/~fth, d = d/~fth, e = e/~fth, f = f/~fth ],/*3*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f*~fth  ],/*4*/	[ a = a*~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f/~fth  ],/*5*/	[ a = a/~fth,    b = b*~fth,    c = c,         d = d*~fth,    e = e,         f = f*~fth ],/*6*/	[ a = a*~fth,    b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f/~fth  ],/*7*/	[ a = a/~fth,    b = b/~fth,    c = c/~fth,    d = d,         e = e,         f = f ],/*8*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*9*/	[ a = a*~fth,    b = b,         c = c,         d = d*~fth,    e = e*~fth,    f = f*~fth ],/*10*/	[ a = a,         b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*11*/	[ a = a/~fth,    b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*12*/	[ a = a*~fth, b = b*~fth, c = c*~fth, d = d/~fth, e = e/~fth, f = f/~fth ],/*13*/	[ a = a,         b = b,         c = c,         d = d*~fth,    e = e,         f = f*~fth ],/*14*/	[ a = a,         b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f],/*15*/	[ a = a/~fth,    b = b,         c = c/~fth,    d = d,         e = e/~fth,    f = f/~fth ],/*16*/	[ a = a,         b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*17*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f*~fth],/*18*/	[ a = a*~fth, b = b/~fth, c = c/~fth, d = d*~fth, e = e*~fth, f = f/~fth ],/*19*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e,         f = f*~fth ],/*20*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f/~fth ],/*21*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d,         e = e,         f = f*~fth ],/*22*/	[ a = a,         b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*23*/	[ a = a,         b = b,         c = c,         d = d/~fth,    e = e,         f = f/~fth ],/*24*/	[ a = a/~fth,    b = b,         c = c,         d = d,         e = e,         f = f*~fth ],/*25*/	[ a = a*~fth,    b = b*~fth,    c = c*~fth,    d = d,         e = e,         f = f ],/*26*/	[ a = a,         b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*27*/	[ a = a,         b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f ],/*28*/	[ a = a/~fth, b = b*~fth, c = c*~fth, d = d*~fth, e = e*~fth, f = f/~fth ],/*29*/	[ a = a,         b = b,         c = c/~fth,    d = d/~fth,    e = e,         f = f ],/*30*/	[ a = a*~fth, b = b/~fth, c = c*~fth, d = d*~fth, e = e/~fth, f = f*~fth ],/*31*/	[ a = a/~fth,    b = b*~fth,    c = c,         d = d,         e = e,         f = f/~fth ],/*32*/	[ a = a,         b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f ],/*33*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*34*/	[ a = a/~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f*~fth ],/*35*/	[ a = a*~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f/~fth ],/*36*/	[ a = a/~fth,    b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f*~fth ],/*37*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e,         f = f ],/*38*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d/~fth,    e = e*~fth,    f = f ],/*39*/	[ a = a/~fth, b = b*~fth, c = c/~fth, d = d*~fth, e = e/~fth, f = f/~fth ],/*40*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d/~fth,    e = e*~fth,    f = f ],/*41*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d,         e = e,         f = f*~fth ],/*42*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*43*/	[ a = a/~fth,    b = b,         c = c*~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*44*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f/~fth ],/*45*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f ],/*46*/	[ a = a,         b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*47*/	[ a = a,         b = b*~fth,    c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*48*/	[ a = a,         b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*49*/	[ a = a,         b = b,         c = c*~fth,    d = d,         e = e/~fth,    f = f*~fth ],/*50*/	[ a = a*~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f/~fth ],/*51*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f*~fth ],/*52*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f/~fth ],/*53*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f ],/*54*/	[ a = a/~fth, b = b/~fth, c = c*~fth, d = d/~fth, e = e*~fth, f = f*~fth ],/*55*/	[ a = a,         b = b,         c = c,         d = d*~fth,    e = e/~fth,    f = f ],/*56*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f/~fth ],/*57*/	[ a = a,         b = b*~fth,    c = c/~fth,    d = d,         e = e*~fth,    f = f ],/*58*/	[ a = a/~fth,    b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f*~fth ],/*59*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d,         e = e,         f = f/~fth ],/*60*/	[ a = a/~fth,    b = b,         c = c,         d = d,         e = e,         f = f*~fth ],/*61*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f ],/*62*/	[ a = a/~fth, b = b/~fth, c = c*~fth, d = d*~fth, e = e/~fth, f = f/~fth ],/*63*/	[ a = a,         b = b*~fth,    c = c/~fth,    d = d,         e = e,         f = f*~fth ],/*64*/	[ a = a*~fth, b = b/~fth, c = c*~fth, d = d/~fth, e = e*~fth, f = f/~fth ]]
			}).flatten, inf);
			s1 = GrainSin.ar(1, Impulse.ar(dur+tune), 1/(dur+tune),Demand.ar(Impulse.ar(dur+tune), 0, dseq)*fc);
			OffsetOut.ar(0, s1.dup*vol);
		}, [\ir]).add;

		SynthDef(\gsineicrld2, {arg graindur = 0.04, dur = 2000, atk = 0.007, rel = 0.01, gate = 1, amp = 1, i = 1, vol = ~vol, rate = 20, tune = 0,dseqval,
			a, b, c, d, e, f, pan=0, fc = 1, id = -1;
			var s1, out, env1, s2, dseq,n1,n2,n3,n4,n5,n6,n7,n8,n9,af;
			#n1=[~gm2];
			dseq = Dseq([[/*1*/	#a,b,c,d,e,f=[ ~a,~b,~c,~d,~e,~f  ],/*2*/	[ a = a/~fth, b = b/~fth, c = c/~fth, d = d/~fth, e = e/~fth, f = f/~fth ],/*3*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f*~fth  ],/*4*/	[ a = a*~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f/~fth  ],/*5*/	[ a = a/~fth,    b = b*~fth,    c = c,         d = d*~fth,    e = e,         f = f*~fth ],/*6*/	[ a = a*~fth,    b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f/~fth  ],/*7*/	[ a = a/~fth,    b = b/~fth,    c = c/~fth,    d = d,         e = e,         f = f ],/*8*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*9*/	[ a = a*~fth,    b = b,         c = c,         d = d*~fth,    e = e*~fth,    f = f*~fth ],/*10*/	[ a = a,         b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*11*/	[ a = a/~fth,    b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*12*/	[ a = a*~fth, b = b*~fth, c = c*~fth, d = d/~fth, e = e/~fth, f = f/~fth ],/*13*/	[ a = a,         b = b,         c = c,         d = d*~fth,    e = e,         f = f*~fth ],/*14*/	[ a = a,         b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f],/*15*/	[ a = a/~fth,    b = b,         c = c/~fth,    d = d,         e = e/~fth,    f = f/~fth ],/*16*/	[ a = a,         b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*17*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f*~fth],/*18*/	[ a = a*~fth, b = b/~fth, c = c/~fth, d = d*~fth, e = e*~fth, f = f/~fth ],/*19*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e,         f = f*~fth ],/*20*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f/~fth ],/*21*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d,         e = e,         f = f*~fth ],/*22*/	[ a = a,         b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*23*/	[ a = a,         b = b,         c = c,         d = d/~fth,    e = e,         f = f/~fth ],/*24*/	[ a = a/~fth,    b = b,         c = c,         d = d,         e = e,         f = f*~fth ],/*25*/	[ a = a*~fth,    b = b*~fth,    c = c*~fth,    d = d,         e = e,         f = f ],/*26*/	[ a = a,         b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*27*/	[ a = a,         b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f ],/*28*/	[ a = a/~fth, b = b*~fth, c = c*~fth, d = d*~fth, e = e*~fth, f = f/~fth ],/*29*/	[ a = a,         b = b,         c = c/~fth,    d = d/~fth,    e = e,         f = f ],/*30*/	[ a = a*~fth, b = b/~fth, c = c*~fth, d = d*~fth, e = e/~fth, f = f*~fth ],/*31*/	[ a = a/~fth,    b = b*~fth,    c = c,         d = d,         e = e,         f = f/~fth ],/*32*/	[ a = a,         b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f ],/*33*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*34*/	[ a = a/~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f*~fth ],/*35*/	[ a = a*~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f/~fth ],/*36*/	[ a = a/~fth,    b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f*~fth ],/*37*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e,         f = f ],/*38*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d/~fth,    e = e*~fth,    f = f ],/*39*/	[ a = a/~fth, b = b*~fth, c = c/~fth, d = d*~fth, e = e/~fth, f = f/~fth ],/*40*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d/~fth,    e = e*~fth,    f = f ],/*41*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d,         e = e,         f = f*~fth ],/*42*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*43*/	[ a = a/~fth,    b = b,         c = c*~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*44*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f/~fth ],/*45*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f ],/*46*/	[ a = a,         b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*47*/	[ a = a,         b = b*~fth,    c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*48*/	[ a = a,         b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*49*/	[ a = a,         b = b,         c = c*~fth,    d = d,         e = e/~fth,    f = f*~fth ],/*50*/	[ a = a*~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f/~fth ],/*51*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f*~fth ],/*52*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f/~fth ],/*53*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f ],/*54*/	[ a = a/~fth, b = b/~fth, c = c*~fth, d = d/~fth, e = e*~fth, f = f*~fth ],/*55*/	[ a = a,         b = b,         c = c,         d = d*~fth,    e = e/~fth,    f = f ],/*56*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f/~fth ],/*57*/	[ a = a,         b = b*~fth,    c = c/~fth,    d = d,         e = e*~fth,    f = f ],/*58*/	[ a = a/~fth,    b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f*~fth ],/*59*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d,         e = e,         f = f/~fth ],/*60*/	[ a = a/~fth,    b = b,         c = c,         d = d,         e = e,         f = f*~fth ],/*61*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f ],/*62*/	[ a = a/~fth, b = b/~fth, c = c*~fth, d = d*~fth, e = e/~fth, f = f/~fth ],/*63*/	[ a = a,         b = b*~fth,    c = c/~fth,    d = d,         e = e,         f = f*~fth ],/*64*/	[ a = a*~fth, b = b/~fth, c = c*~fth, d = d/~fth, e = e*~fth, f = f/~fth ]]
				++Array.fill((~gsinenum*2 -1), {[/*1*/	[ a = a*n1,         b = b*n1*~fth,    c = c*n1,         d = d*n1*~fth,    e = e*n1,         f = f*n1*~fth ],/*2*/	[ a = a/~fth, b = b/~fth, c = c/~fth, d = d/~fth, e = e/~fth, f = f/~fth ],/*3*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f*~fth  ],/*4*/	[ a = a*~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f/~fth  ],/*5*/	[ a = a/~fth,    b = b*~fth,    c = c,         d = d*~fth,    e = e,         f = f*~fth ],/*6*/	[ a = a*~fth,    b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f/~fth  ],/*7*/	[ a = a/~fth,    b = b/~fth,    c = c/~fth,    d = d,         e = e,         f = f ],/*8*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*9*/	[ a = a*~fth,    b = b,         c = c,         d = d*~fth,    e = e*~fth,    f = f*~fth ],/*10*/	[ a = a,         b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*11*/	[ a = a/~fth,    b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*12*/	[ a = a*~fth, b = b*~fth, c = c*~fth, d = d/~fth, e = e/~fth, f = f/~fth ],/*13*/	[ a = a,         b = b,         c = c,         d = d*~fth,    e = e,         f = f*~fth ],/*14*/	[ a = a,         b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f],/*15*/	[ a = a/~fth,    b = b,         c = c/~fth,    d = d,         e = e/~fth,    f = f/~fth ],/*16*/	[ a = a,         b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*17*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f*~fth],/*18*/	[ a = a*~fth, b = b/~fth, c = c/~fth, d = d*~fth, e = e*~fth, f = f/~fth ],/*19*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e,         f = f*~fth ],/*20*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f/~fth ],/*21*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d,         e = e,         f = f*~fth ],/*22*/	[ a = a,         b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*23*/	[ a = a,         b = b,         c = c,         d = d/~fth,    e = e,         f = f/~fth ],/*24*/	[ a = a/~fth,    b = b,         c = c,         d = d,         e = e,         f = f*~fth ],/*25*/	[ a = a*~fth,    b = b*~fth,    c = c*~fth,    d = d,         e = e,         f = f ],/*26*/	[ a = a,         b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*27*/	[ a = a,         b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f ],/*28*/	[ a = a/~fth, b = b*~fth, c = c*~fth, d = d*~fth, e = e*~fth, f = f/~fth ],/*29*/	[ a = a,         b = b,         c = c/~fth,    d = d/~fth,    e = e,         f = f ],/*30*/	[ a = a*~fth, b = b/~fth, c = c*~fth, d = d*~fth, e = e/~fth, f = f*~fth ],/*31*/	[ a = a/~fth,    b = b*~fth,    c = c,         d = d,         e = e,         f = f/~fth ],/*32*/	[ a = a,         b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f ],/*33*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*34*/	[ a = a/~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f*~fth ],/*35*/	[ a = a*~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f/~fth ],/*36*/	[ a = a/~fth,    b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f*~fth ],/*37*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e,         f = f ],/*38*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d/~fth,    e = e*~fth,    f = f ],/*39*/	[ a = a/~fth, b = b*~fth, c = c/~fth, d = d*~fth, e = e/~fth, f = f/~fth ],/*40*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d/~fth,    e = e*~fth,    f = f ],/*41*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d,         e = e,         f = f*~fth ],/*42*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*43*/	[ a = a/~fth,    b = b,         c = c*~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*44*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f/~fth ],/*45*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f ],/*46*/	[ a = a,         b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*47*/	[ a = a,         b = b*~fth,    c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*48*/	[ a = a,         b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*49*/	[ a = a,         b = b,         c = c*~fth,    d = d,         e = e/~fth,    f = f*~fth ],/*50*/	[ a = a*~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f/~fth ],/*51*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f*~fth ],/*52*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f/~fth ],/*53*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f ],/*54*/	[ a = a/~fth, b = b/~fth, c = c*~fth, d = d/~fth, e = e*~fth, f = f*~fth ],/*55*/	[ a = a,         b = b,         c = c,         d = d*~fth,    e = e/~fth,    f = f ],/*56*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f/~fth ],/*57*/	[ a = a,         b = b*~fth,    c = c/~fth,    d = d,         e = e*~fth,    f = f ],/*58*/	[ a = a/~fth,    b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f*~fth ],/*59*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d,         e = e,         f = f/~fth ],/*60*/	[ a = a/~fth,    b = b,         c = c,         d = d,         e = e,         f = f*~fth ],/*61*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f ],/*62*/	[ a = a/~fth, b = b/~fth, c = c*~fth, d = d*~fth, e = e/~fth, f = f/~fth ],/*63*/	[ a = a,         b = b*~fth,    c = c/~fth,    d = d,         e = e,         f = f*~fth ],/*64*/	[ a = a*~fth, b = b/~fth, c = c*~fth, d = d/~fth, e = e*~fth, f = f/~fth ]]
			}).flatten].flatten.reverse, inf);
			s1 = GrainSin.ar(1, Impulse.ar(dur+tune), 1/(dur+tune), Demand.ar(Impulse.ar(dur+tune), 0, dseq));
			OffsetOut.ar(0, s1.dup*vol);
		}, [\ir]).add;

		SynthDef(\gsineicfld6, {arg graindur = 0.04, dur = 2000, atk = 0.007, rel = 0.01, gate = 1, amp = 1, i = 1, vol = ~vol, rate = 20, tune = 0,dseqval,
			a, b, c, d, e, f, pan=0, fc = 1;
			var s1, out, env1, s2, dseq,n1,n2,n3,n4,n5,n6,n7,n8,n9;
			#n1=[~gm6];
			dseq = Dseq([/*1*/	#a,b,c,d,e,f=[ ~a,~b,~c,~d,~e,~f  ],/*2*/	[ a = a/~fth, b = b/~fth, c = c/~fth, d = d/~fth, e = e/~fth, f = f/~fth ],/*3*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f*~fth  ],/*4*/	[ a = a*~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f/~fth  ],/*5*/	[ a = a/~fth,    b = b*~fth,    c = c,         d = d*~fth,    e = e,         f = f*~fth ],/*6*/	[ a = a*~fth,    b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f/~fth  ],/*7*/	[ a = a/~fth,    b = b/~fth,    c = c/~fth,    d = d,         e = e,         f = f ],/*8*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*9*/	[ a = a*~fth,    b = b,         c = c,         d = d*~fth,    e = e*~fth,    f = f*~fth ],/*10*/	[ a = a,         b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*11*/	[ a = a/~fth,    b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*12*/	[ a = a*~fth, b = b*~fth, c = c*~fth, d = d/~fth, e = e/~fth, f = f/~fth ],/*13*/	[ a = a,         b = b,         c = c,         d = d*~fth,    e = e,         f = f*~fth ],/*14*/	[ a = a,         b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f],/*15*/	[ a = a/~fth,    b = b,         c = c/~fth,    d = d,         e = e/~fth,    f = f/~fth ],/*16*/	[ a = a,         b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*17*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f*~fth],/*18*/	[ a = a*~fth, b = b/~fth, c = c/~fth, d = d*~fth, e = e*~fth, f = f/~fth ],/*19*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e,         f = f*~fth ],/*20*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f/~fth ],/*21*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d,         e = e,         f = f*~fth ],/*22*/	[ a = a,         b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*23*/	[ a = a,         b = b,         c = c,         d = d/~fth,    e = e,         f = f/~fth ],/*24*/	[ a = a/~fth,    b = b,         c = c,         d = d,         e = e,         f = f*~fth ],/*25*/	[ a = a*~fth,    b = b*~fth,    c = c*~fth,    d = d,         e = e,         f = f ],/*26*/	[ a = a,         b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*27*/	[ a = a,         b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f ],/*28*/	[ a = a/~fth, b = b*~fth, c = c*~fth, d = d*~fth, e = e*~fth, f = f/~fth ],/*29*/	[ a = a,         b = b,         c = c/~fth,    d = d/~fth,    e = e,         f = f ],/*30*/	[ a = a*~fth, b = b/~fth, c = c*~fth, d = d*~fth, e = e/~fth, f = f*~fth ],/*31*/	[ a = a/~fth,    b = b*~fth,    c = c,         d = d,         e = e,         f = f/~fth ],/*32*/	[ a = a,         b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f ],/*33*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*34*/	[ a = a/~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f*~fth ],/*35*/	[ a = a*~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f/~fth ],/*36*/	[ a = a/~fth,    b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f*~fth ],/*37*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e,         f = f ],/*38*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d/~fth,    e = e*~fth,    f = f ],/*39*/	[ a = a/~fth, b = b*~fth, c = c/~fth, d = d*~fth, e = e/~fth, f = f/~fth ],/*40*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d/~fth,    e = e*~fth,    f = f ],/*41*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d,         e = e,         f = f*~fth ],/*42*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*43*/	[ a = a/~fth,    b = b,         c = c*~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*44*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f/~fth ],/*45*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f ],/*46*/	[ a = a,         b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*47*/	[ a = a,         b = b*~fth,    c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*48*/	[ a = a,         b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*49*/	[ a = a,         b = b,         c = c*~fth,    d = d,         e = e/~fth,    f = f*~fth ],/*50*/	[ a = a*~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f/~fth ],/*51*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f*~fth ],/*52*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f/~fth ],/*53*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f ],/*54*/	[ a = a/~fth, b = b/~fth, c = c*~fth, d = d/~fth, e = e*~fth, f = f*~fth ],/*55*/	[ a = a,         b = b,         c = c,         d = d*~fth,    e = e/~fth,    f = f ],/*56*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f/~fth ],/*57*/	[ a = a,         b = b*~fth,    c = c/~fth,    d = d,         e = e*~fth,    f = f ],/*58*/	[ a = a/~fth,    b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f*~fth ],/*59*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d,         e = e,         f = f/~fth ],/*60*/	[ a = a/~fth,    b = b,         c = c,         d = d,         e = e,         f = f*~fth ],/*61*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f ],/*62*/	[ a = a/~fth, b = b/~fth, c = c*~fth, d = d*~fth, e = e/~fth, f = f/~fth ],/*63*/	[ a = a,         b = b*~fth,    c = c/~fth,    d = d,         e = e,         f = f*~fth ],/*64*/	[ a = a*~fth, b = b/~fth, c = c*~fth, d = d/~fth, e = e*~fth, f = f/~fth ]]
				++Array.fill((~gsinenum*6 -1), {[/*1*/	[ a = a*n1,         b = b*n1*~fth,    c = c*n1,         d = d*n1*~fth,    e = e*n1,         f = f*n1*~fth ],/*2*/	[ a = a/~fth, b = b/~fth, c = c/~fth, d = d/~fth, e = e/~fth, f = f/~fth ],/*3*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f*~fth  ],/*4*/	[ a = a*~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f/~fth  ],/*5*/	[ a = a/~fth,    b = b*~fth,    c = c,         d = d*~fth,    e = e,         f = f*~fth ],/*6*/	[ a = a*~fth,    b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f/~fth  ],/*7*/	[ a = a/~fth,    b = b/~fth,    c = c/~fth,    d = d,         e = e,         f = f ],/*8*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*9*/	[ a = a*~fth,    b = b,         c = c,         d = d*~fth,    e = e*~fth,    f = f*~fth ],/*10*/	[ a = a,         b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*11*/	[ a = a/~fth,    b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*12*/	[ a = a*~fth, b = b*~fth, c = c*~fth, d = d/~fth, e = e/~fth, f = f/~fth ],/*13*/	[ a = a,         b = b,         c = c,         d = d*~fth,    e = e,         f = f*~fth ],/*14*/	[ a = a,         b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f],/*15*/	[ a = a/~fth,    b = b,         c = c/~fth,    d = d,         e = e/~fth,    f = f/~fth ],/*16*/	[ a = a,         b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*17*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f*~fth],/*18*/	[ a = a*~fth, b = b/~fth, c = c/~fth, d = d*~fth, e = e*~fth, f = f/~fth ],/*19*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e,         f = f*~fth ],/*20*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f/~fth ],/*21*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d,         e = e,         f = f*~fth ],/*22*/	[ a = a,         b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*23*/	[ a = a,         b = b,         c = c,         d = d/~fth,    e = e,         f = f/~fth ],/*24*/	[ a = a/~fth,    b = b,         c = c,         d = d,         e = e,         f = f*~fth ],/*25*/	[ a = a*~fth,    b = b*~fth,    c = c*~fth,    d = d,         e = e,         f = f ],/*26*/	[ a = a,         b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*27*/	[ a = a,         b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f ],/*28*/	[ a = a/~fth, b = b*~fth, c = c*~fth, d = d*~fth, e = e*~fth, f = f/~fth ],/*29*/	[ a = a,         b = b,         c = c/~fth,    d = d/~fth,    e = e,         f = f ],/*30*/	[ a = a*~fth, b = b/~fth, c = c*~fth, d = d*~fth, e = e/~fth, f = f*~fth ],/*31*/	[ a = a/~fth,    b = b*~fth,    c = c,         d = d,         e = e,         f = f/~fth ],/*32*/	[ a = a,         b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f ],/*33*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*34*/	[ a = a/~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f*~fth ],/*35*/	[ a = a*~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f/~fth ],/*36*/	[ a = a/~fth,    b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f*~fth ],/*37*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e,         f = f ],/*38*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d/~fth,    e = e*~fth,    f = f ],/*39*/	[ a = a/~fth, b = b*~fth, c = c/~fth, d = d*~fth, e = e/~fth, f = f/~fth ],/*40*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d/~fth,    e = e*~fth,    f = f ],/*41*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d,         e = e,         f = f*~fth ],/*42*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*43*/	[ a = a/~fth,    b = b,         c = c*~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*44*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f/~fth ],/*45*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f ],/*46*/	[ a = a,         b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*47*/	[ a = a,         b = b*~fth,    c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*48*/	[ a = a,         b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*49*/	[ a = a,         b = b,         c = c*~fth,    d = d,         e = e/~fth,    f = f*~fth ],/*50*/	[ a = a*~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f/~fth ],/*51*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f*~fth ],/*52*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f/~fth ],/*53*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f ],/*54*/	[ a = a/~fth, b = b/~fth, c = c*~fth, d = d/~fth, e = e*~fth, f = f*~fth ],/*55*/	[ a = a,         b = b,         c = c,         d = d*~fth,    e = e/~fth,    f = f ],/*56*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f/~fth ],/*57*/	[ a = a,         b = b*~fth,    c = c/~fth,    d = d,         e = e*~fth,    f = f ],/*58*/	[ a = a/~fth,    b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f*~fth ],/*59*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d,         e = e,         f = f/~fth ],/*60*/	[ a = a/~fth,    b = b,         c = c,         d = d,         e = e,         f = f*~fth ],/*61*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f ],/*62*/	[ a = a/~fth, b = b/~fth, c = c*~fth, d = d*~fth, e = e/~fth, f = f/~fth ],/*63*/	[ a = a,         b = b*~fth,    c = c/~fth,    d = d,         e = e,         f = f*~fth ],/*64*/	[ a = a*~fth, b = b/~fth, c = c*~fth, d = d/~fth, e = e*~fth, f = f/~fth ]]
			}).flatten, inf);
			s1 = GrainSin.ar(1, Impulse.ar(dur+tune), 1/(dur+tune),Demand.ar(Impulse.ar(dur+tune), 0, dseq)*fc);
			OffsetOut.ar(0, s1.dup*vol);
		}, [\ir]).add;

		SynthDef(\gsineicrld6, {arg graindur = 0.04, dur = 2000, atk = 0.007, rel = 0.01, gate = 1, amp = 1, i = 1, vol = ~vol, rate = 20, tune = 0,dseqval,
			a, b, c, d, e, f, pan=0, fc = 1;
			var s1, out, env1, s2, dseq,n1,n2,n3,n4,n5,n6,n7,n8,n9;
			#n1=[~gm6];
			dseq = Dseq([[/*1*/	#a,b,c,d,e,f=[ ~a,~b,~c,~d,~e,~f  ],/*2*/	[ a = a/~fth, b = b/~fth, c = c/~fth, d = d/~fth, e = e/~fth, f = f/~fth ],/*3*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f*~fth  ],/*4*/	[ a = a*~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f/~fth  ],/*5*/	[ a = a/~fth,    b = b*~fth,    c = c,         d = d*~fth,    e = e,         f = f*~fth ],/*6*/	[ a = a*~fth,    b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f/~fth  ],/*7*/	[ a = a/~fth,    b = b/~fth,    c = c/~fth,    d = d,         e = e,         f = f ],/*8*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*9*/	[ a = a*~fth,    b = b,         c = c,         d = d*~fth,    e = e*~fth,    f = f*~fth ],/*10*/	[ a = a,         b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*11*/	[ a = a/~fth,    b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*12*/	[ a = a*~fth, b = b*~fth, c = c*~fth, d = d/~fth, e = e/~fth, f = f/~fth ],/*13*/	[ a = a,         b = b,         c = c,         d = d*~fth,    e = e,         f = f*~fth ],/*14*/	[ a = a,         b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f],/*15*/	[ a = a/~fth,    b = b,         c = c/~fth,    d = d,         e = e/~fth,    f = f/~fth ],/*16*/	[ a = a,         b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*17*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f*~fth],/*18*/	[ a = a*~fth, b = b/~fth, c = c/~fth, d = d*~fth, e = e*~fth, f = f/~fth ],/*19*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e,         f = f*~fth ],/*20*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f/~fth ],/*21*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d,         e = e,         f = f*~fth ],/*22*/	[ a = a,         b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*23*/	[ a = a,         b = b,         c = c,         d = d/~fth,    e = e,         f = f/~fth ],/*24*/	[ a = a/~fth,    b = b,         c = c,         d = d,         e = e,         f = f*~fth ],/*25*/	[ a = a*~fth,    b = b*~fth,    c = c*~fth,    d = d,         e = e,         f = f ],/*26*/	[ a = a,         b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*27*/	[ a = a,         b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f ],/*28*/	[ a = a/~fth, b = b*~fth, c = c*~fth, d = d*~fth, e = e*~fth, f = f/~fth ],/*29*/	[ a = a,         b = b,         c = c/~fth,    d = d/~fth,    e = e,         f = f ],/*30*/	[ a = a*~fth, b = b/~fth, c = c*~fth, d = d*~fth, e = e/~fth, f = f*~fth ],/*31*/	[ a = a/~fth,    b = b*~fth,    c = c,         d = d,         e = e,         f = f/~fth ],/*32*/	[ a = a,         b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f ],/*33*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*34*/	[ a = a/~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f*~fth ],/*35*/	[ a = a*~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f/~fth ],/*36*/	[ a = a/~fth,    b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f*~fth ],/*37*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e,         f = f ],/*38*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d/~fth,    e = e*~fth,    f = f ],/*39*/	[ a = a/~fth, b = b*~fth, c = c/~fth, d = d*~fth, e = e/~fth, f = f/~fth ],/*40*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d/~fth,    e = e*~fth,    f = f ],/*41*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d,         e = e,         f = f*~fth ],/*42*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*43*/	[ a = a/~fth,    b = b,         c = c*~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*44*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f/~fth ],/*45*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f ],/*46*/	[ a = a,         b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*47*/	[ a = a,         b = b*~fth,    c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*48*/	[ a = a,         b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*49*/	[ a = a,         b = b,         c = c*~fth,    d = d,         e = e/~fth,    f = f*~fth ],/*50*/	[ a = a*~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f/~fth ],/*51*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f*~fth ],/*52*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f/~fth ],/*53*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f ],/*54*/	[ a = a/~fth, b = b/~fth, c = c*~fth, d = d/~fth, e = e*~fth, f = f*~fth ],/*55*/	[ a = a,         b = b,         c = c,         d = d*~fth,    e = e/~fth,    f = f ],/*56*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f/~fth ],/*57*/	[ a = a,         b = b*~fth,    c = c/~fth,    d = d,         e = e*~fth,    f = f ],/*58*/	[ a = a/~fth,    b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f*~fth ],/*59*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d,         e = e,         f = f/~fth ],/*60*/	[ a = a/~fth,    b = b,         c = c,         d = d,         e = e,         f = f*~fth ],/*61*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f ],/*62*/	[ a = a/~fth, b = b/~fth, c = c*~fth, d = d*~fth, e = e/~fth, f = f/~fth ],/*63*/	[ a = a,         b = b*~fth,    c = c/~fth,    d = d,         e = e,         f = f*~fth ],/*64*/	[ a = a*~fth, b = b/~fth, c = c*~fth, d = d/~fth, e = e*~fth, f = f/~fth ]]
				++Array.fill((~gsinenum*6 -1), {[/*1*/	[ a = a*n1,         b = b*n1*~fth,    c = c*n1,         d = d*n1*~fth,    e = e*n1,         f = f*n1*~fth ],/*2*/	[ a = a/~fth, b = b/~fth, c = c/~fth, d = d/~fth, e = e/~fth, f = f/~fth ],/*3*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f*~fth  ],/*4*/	[ a = a*~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f/~fth  ],/*5*/	[ a = a/~fth,    b = b*~fth,    c = c,         d = d*~fth,    e = e,         f = f*~fth ],/*6*/	[ a = a*~fth,    b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f/~fth  ],/*7*/	[ a = a/~fth,    b = b/~fth,    c = c/~fth,    d = d,         e = e,         f = f ],/*8*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*9*/	[ a = a*~fth,    b = b,         c = c,         d = d*~fth,    e = e*~fth,    f = f*~fth ],/*10*/	[ a = a,         b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*11*/	[ a = a/~fth,    b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*12*/	[ a = a*~fth, b = b*~fth, c = c*~fth, d = d/~fth, e = e/~fth, f = f/~fth ],/*13*/	[ a = a,         b = b,         c = c,         d = d*~fth,    e = e,         f = f*~fth ],/*14*/	[ a = a,         b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f],/*15*/	[ a = a/~fth,    b = b,         c = c/~fth,    d = d,         e = e/~fth,    f = f/~fth ],/*16*/	[ a = a,         b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*17*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f*~fth],/*18*/	[ a = a*~fth, b = b/~fth, c = c/~fth, d = d*~fth, e = e*~fth, f = f/~fth ],/*19*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e,         f = f*~fth ],/*20*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f/~fth ],/*21*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d,         e = e,         f = f*~fth ],/*22*/	[ a = a,         b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*23*/	[ a = a,         b = b,         c = c,         d = d/~fth,    e = e,         f = f/~fth ],/*24*/	[ a = a/~fth,    b = b,         c = c,         d = d,         e = e,         f = f*~fth ],/*25*/	[ a = a*~fth,    b = b*~fth,    c = c*~fth,    d = d,         e = e,         f = f ],/*26*/	[ a = a,         b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*27*/	[ a = a,         b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f ],/*28*/	[ a = a/~fth, b = b*~fth, c = c*~fth, d = d*~fth, e = e*~fth, f = f/~fth ],/*29*/	[ a = a,         b = b,         c = c/~fth,    d = d/~fth,    e = e,         f = f ],/*30*/	[ a = a*~fth, b = b/~fth, c = c*~fth, d = d*~fth, e = e/~fth, f = f*~fth ],/*31*/	[ a = a/~fth,    b = b*~fth,    c = c,         d = d,         e = e,         f = f/~fth ],/*32*/	[ a = a,         b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f ],/*33*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*34*/	[ a = a/~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f*~fth ],/*35*/	[ a = a*~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f/~fth ],/*36*/	[ a = a/~fth,    b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f*~fth ],/*37*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e,         f = f ],/*38*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d/~fth,    e = e*~fth,    f = f ],/*39*/	[ a = a/~fth, b = b*~fth, c = c/~fth, d = d*~fth, e = e/~fth, f = f/~fth ],/*40*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d/~fth,    e = e*~fth,    f = f ],/*41*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d,         e = e,         f = f*~fth ],/*42*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*43*/	[ a = a/~fth,    b = b,         c = c*~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*44*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f/~fth ],/*45*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f ],/*46*/	[ a = a,         b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*47*/	[ a = a,         b = b*~fth,    c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*48*/	[ a = a,         b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*49*/	[ a = a,         b = b,         c = c*~fth,    d = d,         e = e/~fth,    f = f*~fth ],/*50*/	[ a = a*~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f/~fth ],/*51*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f*~fth ],/*52*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f/~fth ],/*53*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f ],/*54*/	[ a = a/~fth, b = b/~fth, c = c*~fth, d = d/~fth, e = e*~fth, f = f*~fth ],/*55*/	[ a = a,         b = b,         c = c,         d = d*~fth,    e = e/~fth,    f = f ],/*56*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f/~fth ],/*57*/	[ a = a,         b = b*~fth,    c = c/~fth,    d = d,         e = e*~fth,    f = f ],/*58*/	[ a = a/~fth,    b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f*~fth ],/*59*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d,         e = e,         f = f/~fth ],/*60*/	[ a = a/~fth,    b = b,         c = c,         d = d,         e = e,         f = f*~fth ],/*61*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f ],/*62*/	[ a = a/~fth, b = b/~fth, c = c*~fth, d = d*~fth, e = e/~fth, f = f/~fth ],/*63*/	[ a = a,         b = b*~fth,    c = c/~fth,    d = d,         e = e,         f = f*~fth ],/*64*/	[ a = a*~fth, b = b/~fth, c = c*~fth, d = d/~fth, e = e*~fth, f = f/~fth ]]
			}).flatten].flatten.reverse, inf);
			s1 = GrainSin.ar(1, Impulse.ar(dur+tune), 1/(dur+tune),Demand.ar(Impulse.ar(dur+tune), 0, dseq)*fc);
			OffsetOut.ar(0, s1.dup*vol);
		}, [\ir]).add;


	};

	~gsine2 = {
		SynthDef(\gsineicfld1, {arg graindur = 0.04, dur = 2000, atk = 0.007, rel = 0.01, gate = 1, amp = 1, i = 1, vol = ~vol, rate = 20, tune = 0,dseqval,
			a, b, c, d, e, f, pan=0, fc = 1;
			var s1, out, env1, s2, dseq,n1,n2,n3,n4,n5,n6,n7,n8,n9;
			#n1,n2,n3,n4,n5,n6,n7,n8,n9=[~ngm1,~ngm1,~ngm1,~ngm1,~ngm1,~ngm1,~ngm1,~ngm1,~ngm1];
			dseq = Dseq([/*1*/	#a,b,c,d,e,f=[ ~a,~b,~c,~d,~e,~f  ],/*2*/	[ a = a/~fth*n1, b = b/~fth*n1, c = c/~fth*n1, d = d/~fth*n1, e = e/~fth*n1, f = f/~fth*n1 ],/*3*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f*~fth  ],/*4*/	[ a = a*~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f/~fth  ],/*5*/	[ a = a/~fth,    b = b*~fth,    c = c,         d = d*~fth,    e = e,         f = f*~fth ],/*6*/	[ a = a*~fth,    b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f/~fth  ],/*7*/	[ a = a/~fth,    b = b/~fth,    c = c/~fth,    d = d,         e = e,         f = f ],/*8*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*9*/	[ a = a*~fth,    b = b,         c = c,         d = d*~fth,    e = e*~fth,    f = f*~fth ],/*10*/	[ a = a,         b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*11*/	[ a = a/~fth,    b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*12*/	[ a = a*~fth*n2, b = b*~fth*n2, c = c*~fth*n2, d = d/~fth*n2, e = e/~fth*n2, f = f/~fth*n2 ],/*13*/	[ a = a,         b = b,         c = c,         d = d*~fth,    e = e,         f = f*~fth ],/*14*/	[ a = a,         b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f],/*15*/	[ a = a/~fth,    b = b,         c = c/~fth,    d = d,         e = e/~fth,    f = f/~fth ],/*16*/	[ a = a,         b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*17*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f*~fth],/*18*/	[ a = a*~fth*n3, b = b/~fth*n3, c = c/~fth*n3, d = d*~fth*n3, e = e*~fth*n3, f = f/~fth*n3 ],/*19*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e,         f = f*~fth ],/*20*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f/~fth ],/*21*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d,         e = e,         f = f*~fth ],/*22*/	[ a = a,         b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*23*/	[ a = a,         b = b,         c = c,         d = d/~fth,    e = e,         f = f/~fth ],/*24*/	[ a = a/~fth,    b = b,         c = c,         d = d,         e = e,         f = f*~fth ],/*25*/	[ a = a*~fth,    b = b*~fth,    c = c*~fth,    d = d,         e = e,         f = f ],/*26*/	[ a = a,         b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*27*/	[ a = a,         b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f ],/*28*/	[ a = a/~fth*n4, b = b*~fth*n4, c = c*~fth*n4, d = d*~fth*n4, e = e*~fth*n4, f = f/~fth*n4 ],/*29*/	[ a = a,         b = b,         c = c/~fth,    d = d/~fth,    e = e,         f = f ],/*30*/	[ a = a*~fth*n5, b = b/~fth*n5, c = c*~fth*n5, d = d*~fth*n5, e = e/~fth*n5, f = f*~fth*n5 ],/*31*/	[ a = a/~fth,    b = b*~fth,    c = c,         d = d,         e = e,         f = f/~fth ],/*32*/	[ a = a,         b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f ],/*33*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*34*/	[ a = a/~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f*~fth ],/*35*/	[ a = a*~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f/~fth ],/*36*/	[ a = a/~fth,    b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f*~fth ],/*37*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e,         f = f ],/*38*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d/~fth,    e = e*~fth,    f = f ],/*39*/	[ a = a/~fth*n6, b = b*~fth*n6, c = c/~fth*n6, d = d*~fth*n6, e = e/~fth*n6, f = f/~fth*n6 ],/*40*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d/~fth,    e = e*~fth,    f = f ],/*41*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d,         e = e,         f = f*~fth ],/*42*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*43*/	[ a = a/~fth,    b = b,         c = c*~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*44*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f/~fth ],/*45*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f ],/*46*/	[ a = a,         b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*47*/	[ a = a,         b = b*~fth,    c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*48*/	[ a = a,         b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*49*/	[ a = a,         b = b,         c = c*~fth,    d = d,         e = e/~fth,    f = f*~fth ],/*50*/	[ a = a*~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f/~fth ],/*51*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f*~fth ],/*52*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f/~fth ],/*53*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f ],/*54*/	[ a = a/~fth*n7, b = b/~fth*n7, c = c*~fth*n7, d = d/~fth*n7, e = e*~fth*n7, f = f*~fth*n7 ],/*55*/	[ a = a,         b = b,         c = c,         d = d*~fth,    e = e/~fth,    f = f ],/*56*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f/~fth ],/*57*/	[ a = a,         b = b*~fth,    c = c/~fth,    d = d,         e = e*~fth,    f = f ],/*58*/	[ a = a/~fth,    b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f*~fth ],/*59*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d,         e = e,         f = f/~fth ],/*60*/	[ a = a/~fth,    b = b,         c = c,         d = d,         e = e,         f = f*~fth ],/*61*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f ],/*62*/	[ a = a/~fth*n8, b = b/~fth*n8, c = c*~fth*n8, d = d*~fth*n8, e = e/~fth*n8, f = f/~fth*n8 ],/*63*/	[ a = a,         b = b*~fth,    c = c/~fth,    d = d,         e = e,         f = f*~fth ],/*64*/	[ a = a*~fth*n9, b = b/~fth*n9, c = c*~fth*n9, d = d/~fth*n9, e = e*~fth*n9, f = f/~fth*n9 ]]
				++Array.fill((~gsinenum -1), {[/*1*/	[ a = a,         b = b*~fth,    c = c,         d = d*~fth,    e = e,         f = f*~fth ],/*2*/	[ a = a/~fth*n1, b = b/~fth*n1, c = c/~fth*n1, d = d/~fth*n1, e = e/~fth*n1, f = f/~fth*n1 ],/*3*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f*~fth  ],/*4*/	[ a = a*~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f/~fth  ],/*5*/	[ a = a/~fth,    b = b*~fth,    c = c,         d = d*~fth,    e = e,         f = f*~fth ],/*6*/	[ a = a*~fth,    b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f/~fth  ],/*7*/	[ a = a/~fth,    b = b/~fth,    c = c/~fth,    d = d,         e = e,         f = f ],/*8*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*9*/	[ a = a*~fth,    b = b,         c = c,         d = d*~fth,    e = e*~fth,    f = f*~fth ],/*10*/	[ a = a,         b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*11*/	[ a = a/~fth,    b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*12*/	[ a = a*~fth*n2, b = b*~fth*n2, c = c*~fth*n2, d = d/~fth*n2, e = e/~fth*n2, f = f/~fth*n2 ],/*13*/	[ a = a,         b = b,         c = c,         d = d*~fth,    e = e,         f = f*~fth ],/*14*/	[ a = a,         b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f],/*15*/	[ a = a/~fth,    b = b,         c = c/~fth,    d = d,         e = e/~fth,    f = f/~fth ],/*16*/	[ a = a,         b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*17*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f*~fth],/*18*/	[ a = a*~fth*n3, b = b/~fth*n3, c = c/~fth*n3, d = d*~fth*n3, e = e*~fth*n3, f = f/~fth*n3 ],/*19*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e,         f = f*~fth ],/*20*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f/~fth ],/*21*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d,         e = e,         f = f*~fth ],/*22*/	[ a = a,         b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*23*/	[ a = a,         b = b,         c = c,         d = d/~fth,    e = e,         f = f/~fth ],/*24*/	[ a = a/~fth,    b = b,         c = c,         d = d,         e = e,         f = f*~fth ],/*25*/	[ a = a*~fth,    b = b*~fth,    c = c*~fth,    d = d,         e = e,         f = f ],/*26*/	[ a = a,         b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*27*/	[ a = a,         b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f ],/*28*/	[ a = a/~fth*n4, b = b*~fth*n4, c = c*~fth*n4, d = d*~fth*n4, e = e*~fth*n4, f = f/~fth*n4 ],/*29*/	[ a = a,         b = b,         c = c/~fth,    d = d/~fth,    e = e,         f = f ],/*30*/	[ a = a*~fth*n5, b = b/~fth*n5, c = c*~fth*n5, d = d*~fth*n5, e = e/~fth*n5, f = f*~fth*n5 ],/*31*/	[ a = a/~fth,    b = b*~fth,    c = c,         d = d,         e = e,         f = f/~fth ],/*32*/	[ a = a,         b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f ],/*33*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*34*/	[ a = a/~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f*~fth ],/*35*/	[ a = a*~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f/~fth ],/*36*/	[ a = a/~fth,    b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f*~fth ],/*37*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e,         f = f ],/*38*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d/~fth,    e = e*~fth,    f = f ],/*39*/	[ a = a/~fth*n6, b = b*~fth*n6, c = c/~fth*n6, d = d*~fth*n6, e = e/~fth*n6, f = f/~fth*n6 ],/*40*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d/~fth,    e = e*~fth,    f = f ],/*41*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d,         e = e,         f = f*~fth ],/*42*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*43*/	[ a = a/~fth,    b = b,         c = c*~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*44*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f/~fth ],/*45*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f ],/*46*/	[ a = a,         b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*47*/	[ a = a,         b = b*~fth,    c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*48*/	[ a = a,         b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*49*/	[ a = a,         b = b,         c = c*~fth,    d = d,         e = e/~fth,    f = f*~fth ],/*50*/	[ a = a*~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f/~fth ],/*51*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f*~fth ],/*52*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f/~fth ],/*53*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f ],/*54*/	[ a = a/~fth*n7, b = b/~fth*n7, c = c*~fth*n7, d = d/~fth*n7, e = e*~fth*n7, f = f*~fth*n7 ],/*55*/	[ a = a,         b = b,         c = c,         d = d*~fth,    e = e/~fth,    f = f ],/*56*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f/~fth ],/*57*/	[ a = a,         b = b*~fth,    c = c/~fth,    d = d,         e = e*~fth,    f = f ],/*58*/	[ a = a/~fth,    b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f*~fth ],/*59*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d,         e = e,         f = f/~fth ],/*60*/	[ a = a/~fth,    b = b,         c = c,         d = d,         e = e,         f = f*~fth ],/*61*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f ],/*62*/	[ a = a/~fth*n8, b = b/~fth*n8, c = c*~fth*n8, d = d*~fth*n8, e = e/~fth*n8, f = f/~fth*n8 ],/*63*/	[ a = a,         b = b*~fth,    c = c/~fth,    d = d,         e = e,         f = f*~fth ],/*64*/	[ a = a*~fth*n9, b = b/~fth*n9, c = c*~fth*n9, d = d/~fth*n9, e = e*~fth*n9, f = f/~fth*n9 ]]
			}).flatten, inf);
			s1 = GrainSin.ar(1, Impulse.ar(dur+tune), 1/(dur+tune),Demand.ar(Impulse.ar(dur+tune), 0, dseq)*fc);
			OffsetOut.ar(0, s1.dup*vol);
		}, [\ir]).add;

		SynthDef(\gsineicrld1, {arg graindur = 0.04, dur = 2000, atk = 0.007, rel = 0.01, gate = 1, amp = 1, i = 1, vol = ~vol, rate = 20, tune = 0,dseqval,
			a, b, c, d, e, f, pan=0, fc = 1, id = -1;
			var s1, out, env1, s2, dseq,n1,n2,n3,n4,n5,n6,n7,n8,n9,af;
			#n1,n2,n3,n4,n5,n6,n7,n8,n9=[~ngm1,~ngm1,~ngm1,~ngm1,~ngm1,~ngm1,~ngm1,~ngm1,~ngm1];
			dseq = Dseq([[/*1*/	#a,b,c,d,e,f=[ ~a,~b,~c,~d,~e,~f  ],/*2*/	[ a = a/~fth*n1, b = b/~fth*n1, c = c/~fth*n1, d = d/~fth*n1, e = e/~fth*n1, f = f/~fth*n1 ],/*3*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f*~fth  ],/*4*/	[ a = a*~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f/~fth  ],/*5*/	[ a = a/~fth,    b = b*~fth,    c = c,         d = d*~fth,    e = e,         f = f*~fth ],/*6*/	[ a = a*~fth,    b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f/~fth  ],/*7*/	[ a = a/~fth,    b = b/~fth,    c = c/~fth,    d = d,         e = e,         f = f ],/*8*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*9*/	[ a = a*~fth,    b = b,         c = c,         d = d*~fth,    e = e*~fth,    f = f*~fth ],/*10*/	[ a = a,         b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*11*/	[ a = a/~fth,    b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*12*/	[ a = a*~fth*n2, b = b*~fth*n2, c = c*~fth*n2, d = d/~fth*n2, e = e/~fth*n2, f = f/~fth*n2 ],/*13*/	[ a = a,         b = b,         c = c,         d = d*~fth,    e = e,         f = f*~fth ],/*14*/	[ a = a,         b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f],/*15*/	[ a = a/~fth,    b = b,         c = c/~fth,    d = d,         e = e/~fth,    f = f/~fth ],/*16*/	[ a = a,         b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*17*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f*~fth],/*18*/	[ a = a*~fth*n3, b = b/~fth*n3, c = c/~fth*n3, d = d*~fth*n3, e = e*~fth*n3, f = f/~fth*n3 ],/*19*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e,         f = f*~fth ],/*20*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f/~fth ],/*21*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d,         e = e,         f = f*~fth ],/*22*/	[ a = a,         b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*23*/	[ a = a,         b = b,         c = c,         d = d/~fth,    e = e,         f = f/~fth ],/*24*/	[ a = a/~fth,    b = b,         c = c,         d = d,         e = e,         f = f*~fth ],/*25*/	[ a = a*~fth,    b = b*~fth,    c = c*~fth,    d = d,         e = e,         f = f ],/*26*/	[ a = a,         b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*27*/	[ a = a,         b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f ],/*28*/	[ a = a/~fth*n4, b = b*~fth*n4, c = c*~fth*n4, d = d*~fth*n4, e = e*~fth*n4, f = f/~fth*n4 ],/*29*/	[ a = a,         b = b,         c = c/~fth,    d = d/~fth,    e = e,         f = f ],/*30*/	[ a = a*~fth*n5, b = b/~fth*n5, c = c*~fth*n5, d = d*~fth*n5, e = e/~fth*n5, f = f*~fth*n5 ],/*31*/	[ a = a/~fth,    b = b*~fth,    c = c,         d = d,         e = e,         f = f/~fth ],/*32*/	[ a = a,         b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f ],/*33*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*34*/	[ a = a/~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f*~fth ],/*35*/	[ a = a*~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f/~fth ],/*36*/	[ a = a/~fth,    b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f*~fth ],/*37*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e,         f = f ],/*38*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d/~fth,    e = e*~fth,    f = f ],/*39*/	[ a = a/~fth*n6, b = b*~fth*n6, c = c/~fth*n6, d = d*~fth*n6, e = e/~fth*n6, f = f/~fth*n6 ],/*40*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d/~fth,    e = e*~fth,    f = f ],/*41*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d,         e = e,         f = f*~fth ],/*42*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*43*/	[ a = a/~fth,    b = b,         c = c*~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*44*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f/~fth ],/*45*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f ],/*46*/	[ a = a,         b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*47*/	[ a = a,         b = b*~fth,    c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*48*/	[ a = a,         b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*49*/	[ a = a,         b = b,         c = c*~fth,    d = d,         e = e/~fth,    f = f*~fth ],/*50*/	[ a = a*~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f/~fth ],/*51*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f*~fth ],/*52*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f/~fth ],/*53*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f ],/*54*/	[ a = a/~fth*n7, b = b/~fth*n7, c = c*~fth*n7, d = d/~fth*n7, e = e*~fth*n7, f = f*~fth*n7 ],/*55*/	[ a = a,         b = b,         c = c,         d = d*~fth,    e = e/~fth,    f = f ],/*56*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f/~fth ],/*57*/	[ a = a,         b = b*~fth,    c = c/~fth,    d = d,         e = e*~fth,    f = f ],/*58*/	[ a = a/~fth,    b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f*~fth ],/*59*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d,         e = e,         f = f/~fth ],/*60*/	[ a = a/~fth,    b = b,         c = c,         d = d,         e = e,         f = f*~fth ],/*61*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f ],/*62*/	[ a = a/~fth*n8, b = b/~fth*n8, c = c*~fth*n8, d = d*~fth*n8, e = e/~fth*n8, f = f/~fth*n8 ],/*63*/	[ a = a,         b = b*~fth,    c = c/~fth,    d = d,         e = e,         f = f*~fth ],/*64*/	[ a = a*~fth*n9, b = b/~fth*n9, c = c*~fth*n9, d = d/~fth*n9, e = e*~fth*n9, f = f/~fth*n9 ]]
				++Array.fill((~gsinenum -1), {[/*1*/	[ a = a,         b = b*~fth,    c = c,         d = d*~fth,    e = e,         f = f*~fth ],/*2*/	[ a = a/~fth*n1, b = b/~fth*n1, c = c/~fth*n1, d = d/~fth*n1, e = e/~fth*n1, f = f/~fth*n1 ],/*3*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f*~fth  ],/*4*/	[ a = a*~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f/~fth  ],/*5*/	[ a = a/~fth,    b = b*~fth,    c = c,         d = d*~fth,    e = e,         f = f*~fth ],/*6*/	[ a = a*~fth,    b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f/~fth  ],/*7*/	[ a = a/~fth,    b = b/~fth,    c = c/~fth,    d = d,         e = e,         f = f ],/*8*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*9*/	[ a = a*~fth,    b = b,         c = c,         d = d*~fth,    e = e*~fth,    f = f*~fth ],/*10*/	[ a = a,         b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*11*/	[ a = a/~fth,    b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*12*/	[ a = a*~fth*n2, b = b*~fth*n2, c = c*~fth*n2, d = d/~fth*n2, e = e/~fth*n2, f = f/~fth*n2 ],/*13*/	[ a = a,         b = b,         c = c,         d = d*~fth,    e = e,         f = f*~fth ],/*14*/	[ a = a,         b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f],/*15*/	[ a = a/~fth,    b = b,         c = c/~fth,    d = d,         e = e/~fth,    f = f/~fth ],/*16*/	[ a = a,         b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*17*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f*~fth],/*18*/	[ a = a*~fth*n3, b = b/~fth*n3, c = c/~fth*n3, d = d*~fth*n3, e = e*~fth*n3, f = f/~fth*n3 ],/*19*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e,         f = f*~fth ],/*20*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f/~fth ],/*21*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d,         e = e,         f = f*~fth ],/*22*/	[ a = a,         b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*23*/	[ a = a,         b = b,         c = c,         d = d/~fth,    e = e,         f = f/~fth ],/*24*/	[ a = a/~fth,    b = b,         c = c,         d = d,         e = e,         f = f*~fth ],/*25*/	[ a = a*~fth,    b = b*~fth,    c = c*~fth,    d = d,         e = e,         f = f ],/*26*/	[ a = a,         b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*27*/	[ a = a,         b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f ],/*28*/	[ a = a/~fth*n4, b = b*~fth*n4, c = c*~fth*n4, d = d*~fth*n4, e = e*~fth*n4, f = f/~fth*n4 ],/*29*/	[ a = a,         b = b,         c = c/~fth,    d = d/~fth,    e = e,         f = f ],/*30*/	[ a = a*~fth*n5, b = b/~fth*n5, c = c*~fth*n5, d = d*~fth*n5, e = e/~fth*n5, f = f*~fth*n5 ],/*31*/	[ a = a/~fth,    b = b*~fth,    c = c,         d = d,         e = e,         f = f/~fth ],/*32*/	[ a = a,         b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f ],/*33*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*34*/	[ a = a/~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f*~fth ],/*35*/	[ a = a*~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f/~fth ],/*36*/	[ a = a/~fth,    b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f*~fth ],/*37*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e,         f = f ],/*38*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d/~fth,    e = e*~fth,    f = f ],/*39*/	[ a = a/~fth*n6, b = b*~fth*n6, c = c/~fth*n6, d = d*~fth*n6, e = e/~fth*n6, f = f/~fth*n6 ],/*40*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d/~fth,    e = e*~fth,    f = f ],/*41*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d,         e = e,         f = f*~fth ],/*42*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*43*/	[ a = a/~fth,    b = b,         c = c*~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*44*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f/~fth ],/*45*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f ],/*46*/	[ a = a,         b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*47*/	[ a = a,         b = b*~fth,    c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*48*/	[ a = a,         b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*49*/	[ a = a,         b = b,         c = c*~fth,    d = d,         e = e/~fth,    f = f*~fth ],/*50*/	[ a = a*~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f/~fth ],/*51*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f*~fth ],/*52*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f/~fth ],/*53*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f ],/*54*/	[ a = a/~fth*n7, b = b/~fth*n7, c = c*~fth*n7, d = d/~fth*n7, e = e*~fth*n7, f = f*~fth*n7 ],/*55*/	[ a = a,         b = b,         c = c,         d = d*~fth,    e = e/~fth,    f = f ],/*56*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f/~fth ],/*57*/	[ a = a,         b = b*~fth,    c = c/~fth,    d = d,         e = e*~fth,    f = f ],/*58*/	[ a = a/~fth,    b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f*~fth ],/*59*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d,         e = e,         f = f/~fth ],/*60*/	[ a = a/~fth,    b = b,         c = c,         d = d,         e = e,         f = f*~fth ],/*61*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f ],/*62*/	[ a = a/~fth*n8, b = b/~fth*n8, c = c*~fth*n8, d = d*~fth*n8, e = e/~fth*n8, f = f/~fth*n8 ],/*63*/	[ a = a,         b = b*~fth,    c = c/~fth,    d = d,         e = e,         f = f*~fth ],/*64*/	[ a = a*~fth*n9, b = b/~fth*n9, c = c*~fth*n9, d = d/~fth*n9, e = e*~fth*n9, f = f/~fth*n9 ]]
			}).flatten].flatten.reverse, inf);
			s1 = GrainSin.ar(1, Impulse.ar(dur+tune), 1/(dur+tune), Demand.ar(Impulse.ar(dur+tune), 0, dseq));
			OffsetOut.ar(0, s1.dup*vol);
		}, [\ir]).add;

		SynthDef(\gsineicfld2, {arg graindur = 0.04, dur = 2000, atk = 0.007, rel = 0.01, gate = 1, amp = 1, i = 1, vol = ~vol, rate = 20, tune = 0,dseqval,
			a, b, c, d, e, f, pan=0, fc = 1;
			var s1, out, env1, s2, dseq,n1,n2,n3,n4,n5,n6,n7,n8,n9;
			#n1,n2,n3,n4,n5,n6,n7,n8,n9=[~ngm2,~ngm2,~ngm2,~ngm2,~ngm2,~ngm2,~ngm2,~ngm2,~ngm2];
			dseq = Dseq([/*1*/	#a,b,c,d,e,f=[ ~a,~b,~c,~d,~e,~f  ],/*2*/	[ a = a/~fth*n1, b = b/~fth*n1, c = c/~fth*n1, d = d/~fth*n1, e = e/~fth*n1, f = f/~fth*n1 ],/*3*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f*~fth  ],/*4*/	[ a = a*~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f/~fth  ],/*5*/	[ a = a/~fth,    b = b*~fth,    c = c,         d = d*~fth,    e = e,         f = f*~fth ],/*6*/	[ a = a*~fth,    b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f/~fth  ],/*7*/	[ a = a/~fth,    b = b/~fth,    c = c/~fth,    d = d,         e = e,         f = f ],/*8*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*9*/	[ a = a*~fth,    b = b,         c = c,         d = d*~fth,    e = e*~fth,    f = f*~fth ],/*10*/	[ a = a,         b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*11*/	[ a = a/~fth,    b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*12*/	[ a = a*~fth*n2, b = b*~fth*n2, c = c*~fth*n2, d = d/~fth*n2, e = e/~fth*n2, f = f/~fth*n2 ],/*13*/	[ a = a,         b = b,         c = c,         d = d*~fth,    e = e,         f = f*~fth ],/*14*/	[ a = a,         b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f],/*15*/	[ a = a/~fth,    b = b,         c = c/~fth,    d = d,         e = e/~fth,    f = f/~fth ],/*16*/	[ a = a,         b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*17*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f*~fth],/*18*/	[ a = a*~fth*n3, b = b/~fth*n3, c = c/~fth*n3, d = d*~fth*n3, e = e*~fth*n3, f = f/~fth*n3 ],/*19*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e,         f = f*~fth ],/*20*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f/~fth ],/*21*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d,         e = e,         f = f*~fth ],/*22*/	[ a = a,         b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*23*/	[ a = a,         b = b,         c = c,         d = d/~fth,    e = e,         f = f/~fth ],/*24*/	[ a = a/~fth,    b = b,         c = c,         d = d,         e = e,         f = f*~fth ],/*25*/	[ a = a*~fth,    b = b*~fth,    c = c*~fth,    d = d,         e = e,         f = f ],/*26*/	[ a = a,         b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*27*/	[ a = a,         b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f ],/*28*/	[ a = a/~fth*n4, b = b*~fth*n4, c = c*~fth*n4, d = d*~fth*n4, e = e*~fth*n4, f = f/~fth*n4 ],/*29*/	[ a = a,         b = b,         c = c/~fth,    d = d/~fth,    e = e,         f = f ],/*30*/	[ a = a*~fth*n5, b = b/~fth*n5, c = c*~fth*n5, d = d*~fth*n5, e = e/~fth*n5, f = f*~fth*n5 ],/*31*/	[ a = a/~fth,    b = b*~fth,    c = c,         d = d,         e = e,         f = f/~fth ],/*32*/	[ a = a,         b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f ],/*33*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*34*/	[ a = a/~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f*~fth ],/*35*/	[ a = a*~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f/~fth ],/*36*/	[ a = a/~fth,    b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f*~fth ],/*37*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e,         f = f ],/*38*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d/~fth,    e = e*~fth,    f = f ],/*39*/	[ a = a/~fth*n6, b = b*~fth*n6, c = c/~fth*n6, d = d*~fth*n6, e = e/~fth*n6, f = f/~fth*n6 ],/*40*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d/~fth,    e = e*~fth,    f = f ],/*41*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d,         e = e,         f = f*~fth ],/*42*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*43*/	[ a = a/~fth,    b = b,         c = c*~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*44*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f/~fth ],/*45*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f ],/*46*/	[ a = a,         b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*47*/	[ a = a,         b = b*~fth,    c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*48*/	[ a = a,         b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*49*/	[ a = a,         b = b,         c = c*~fth,    d = d,         e = e/~fth,    f = f*~fth ],/*50*/	[ a = a*~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f/~fth ],/*51*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f*~fth ],/*52*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f/~fth ],/*53*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f ],/*54*/	[ a = a/~fth*n7, b = b/~fth*n7, c = c*~fth*n7, d = d/~fth*n7, e = e*~fth*n7, f = f*~fth*n7 ],/*55*/	[ a = a,         b = b,         c = c,         d = d*~fth,    e = e/~fth,    f = f ],/*56*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f/~fth ],/*57*/	[ a = a,         b = b*~fth,    c = c/~fth,    d = d,         e = e*~fth,    f = f ],/*58*/	[ a = a/~fth,    b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f*~fth ],/*59*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d,         e = e,         f = f/~fth ],/*60*/	[ a = a/~fth,    b = b,         c = c,         d = d,         e = e,         f = f*~fth ],/*61*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f ],/*62*/	[ a = a/~fth*n8, b = b/~fth*n8, c = c*~fth*n8, d = d*~fth*n8, e = e/~fth*n8, f = f/~fth*n8 ],/*63*/	[ a = a,         b = b*~fth,    c = c/~fth,    d = d,         e = e,         f = f*~fth ],/*64*/	[ a = a*~fth*n9, b = b/~fth*n9, c = c*~fth*n9, d = d/~fth*n9, e = e*~fth*n9, f = f/~fth*n9 ]]
				++Array.fill((~gsinenum*2 -1), {[/*1*/	[ a = a,         b = b*~fth,    c = c,         d = d*~fth,    e = e,         f = f*~fth ],/*2*/	[ a = a/~fth*n1, b = b/~fth*n1, c = c/~fth*n1, d = d/~fth*n1, e = e/~fth*n1, f = f/~fth*n1 ],/*3*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f*~fth  ],/*4*/	[ a = a*~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f/~fth  ],/*5*/	[ a = a/~fth,    b = b*~fth,    c = c,         d = d*~fth,    e = e,         f = f*~fth ],/*6*/	[ a = a*~fth,    b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f/~fth  ],/*7*/	[ a = a/~fth,    b = b/~fth,    c = c/~fth,    d = d,         e = e,         f = f ],/*8*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*9*/	[ a = a*~fth,    b = b,         c = c,         d = d*~fth,    e = e*~fth,    f = f*~fth ],/*10*/	[ a = a,         b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*11*/	[ a = a/~fth,    b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*12*/	[ a = a*~fth*n2, b = b*~fth*n2, c = c*~fth*n2, d = d/~fth*n2, e = e/~fth*n2, f = f/~fth*n2 ],/*13*/	[ a = a,         b = b,         c = c,         d = d*~fth,    e = e,         f = f*~fth ],/*14*/	[ a = a,         b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f],/*15*/	[ a = a/~fth,    b = b,         c = c/~fth,    d = d,         e = e/~fth,    f = f/~fth ],/*16*/	[ a = a,         b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*17*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f*~fth],/*18*/	[ a = a*~fth*n3, b = b/~fth*n3, c = c/~fth*n3, d = d*~fth*n3, e = e*~fth*n3, f = f/~fth*n3 ],/*19*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e,         f = f*~fth ],/*20*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f/~fth ],/*21*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d,         e = e,         f = f*~fth ],/*22*/	[ a = a,         b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*23*/	[ a = a,         b = b,         c = c,         d = d/~fth,    e = e,         f = f/~fth ],/*24*/	[ a = a/~fth,    b = b,         c = c,         d = d,         e = e,         f = f*~fth ],/*25*/	[ a = a*~fth,    b = b*~fth,    c = c*~fth,    d = d,         e = e,         f = f ],/*26*/	[ a = a,         b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*27*/	[ a = a,         b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f ],/*28*/	[ a = a/~fth*n4, b = b*~fth*n4, c = c*~fth*n4, d = d*~fth*n4, e = e*~fth*n4, f = f/~fth*n4 ],/*29*/	[ a = a,         b = b,         c = c/~fth,    d = d/~fth,    e = e,         f = f ],/*30*/	[ a = a*~fth*n5, b = b/~fth*n5, c = c*~fth*n5, d = d*~fth*n5, e = e/~fth*n5, f = f*~fth*n5 ],/*31*/	[ a = a/~fth,    b = b*~fth,    c = c,         d = d,         e = e,         f = f/~fth ],/*32*/	[ a = a,         b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f ],/*33*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*34*/	[ a = a/~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f*~fth ],/*35*/	[ a = a*~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f/~fth ],/*36*/	[ a = a/~fth,    b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f*~fth ],/*37*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e,         f = f ],/*38*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d/~fth,    e = e*~fth,    f = f ],/*39*/	[ a = a/~fth*n6, b = b*~fth*n6, c = c/~fth*n6, d = d*~fth*n6, e = e/~fth*n6, f = f/~fth*n6 ],/*40*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d/~fth,    e = e*~fth,    f = f ],/*41*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d,         e = e,         f = f*~fth ],/*42*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*43*/	[ a = a/~fth,    b = b,         c = c*~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*44*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f/~fth ],/*45*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f ],/*46*/	[ a = a,         b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*47*/	[ a = a,         b = b*~fth,    c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*48*/	[ a = a,         b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*49*/	[ a = a,         b = b,         c = c*~fth,    d = d,         e = e/~fth,    f = f*~fth ],/*50*/	[ a = a*~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f/~fth ],/*51*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f*~fth ],/*52*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f/~fth ],/*53*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f ],/*54*/	[ a = a/~fth*n7, b = b/~fth*n7, c = c*~fth*n7, d = d/~fth*n7, e = e*~fth*n7, f = f*~fth*n7 ],/*55*/	[ a = a,         b = b,         c = c,         d = d*~fth,    e = e/~fth,    f = f ],/*56*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f/~fth ],/*57*/	[ a = a,         b = b*~fth,    c = c/~fth,    d = d,         e = e*~fth,    f = f ],/*58*/	[ a = a/~fth,    b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f*~fth ],/*59*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d,         e = e,         f = f/~fth ],/*60*/	[ a = a/~fth,    b = b,         c = c,         d = d,         e = e,         f = f*~fth ],/*61*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f ],/*62*/	[ a = a/~fth*n8, b = b/~fth*n8, c = c*~fth*n8, d = d*~fth*n8, e = e/~fth*n8, f = f/~fth*n8 ],/*63*/	[ a = a,         b = b*~fth,    c = c/~fth,    d = d,         e = e,         f = f*~fth ],/*64*/	[ a = a*~fth*n9, b = b/~fth*n9, c = c*~fth*n9, d = d/~fth*n9, e = e*~fth*n9, f = f/~fth*n9 ]]
			}).flatten, inf);
			s1 = GrainSin.ar(1, Impulse.ar(dur+tune), 1/(dur+tune),Demand.ar(Impulse.ar(dur+tune), 0, dseq)*fc);
			OffsetOut.ar(0, s1.dup*vol);
		}, [\ir]).add;

		SynthDef(\gsineicrld2, {arg graindur = 0.04, dur = 2000, atk = 0.007, rel = 0.01, gate = 1, amp = 1, i = 1, vol = ~vol, rate = 20, tune = 0,dseqval,
			a, b, c, d, e, f, pan=0, fc = 1, id = -1;
			var s1, out, env1, s2, dseq,n1,n2,n3,n4,n5,n6,n7,n8,n9,af;
			#n1,n2,n3,n4,n5,n6,n7,n8,n9=[~ngm2,~ngm2,~ngm2,~ngm2,~ngm2,~ngm2,~ngm2,~ngm2,~ngm2];
			dseq = Dseq([[/*1*/	#a,b,c,d,e,f=[ ~a,~b,~c,~d,~e,~f  ],/*2*/	[ a = a/~fth*n1, b = b/~fth*n1, c = c/~fth*n1, d = d/~fth*n1, e = e/~fth*n1, f = f/~fth*n1 ],/*3*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f*~fth  ],/*4*/	[ a = a*~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f/~fth  ],/*5*/	[ a = a/~fth,    b = b*~fth,    c = c,         d = d*~fth,    e = e,         f = f*~fth ],/*6*/	[ a = a*~fth,    b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f/~fth  ],/*7*/	[ a = a/~fth,    b = b/~fth,    c = c/~fth,    d = d,         e = e,         f = f ],/*8*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*9*/	[ a = a*~fth,    b = b,         c = c,         d = d*~fth,    e = e*~fth,    f = f*~fth ],/*10*/	[ a = a,         b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*11*/	[ a = a/~fth,    b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*12*/	[ a = a*~fth*n2, b = b*~fth*n2, c = c*~fth*n2, d = d/~fth*n2, e = e/~fth*n2, f = f/~fth*n2 ],/*13*/	[ a = a,         b = b,         c = c,         d = d*~fth,    e = e,         f = f*~fth ],/*14*/	[ a = a,         b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f],/*15*/	[ a = a/~fth,    b = b,         c = c/~fth,    d = d,         e = e/~fth,    f = f/~fth ],/*16*/	[ a = a,         b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*17*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f*~fth],/*18*/	[ a = a*~fth*n3, b = b/~fth*n3, c = c/~fth*n3, d = d*~fth*n3, e = e*~fth*n3, f = f/~fth*n3 ],/*19*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e,         f = f*~fth ],/*20*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f/~fth ],/*21*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d,         e = e,         f = f*~fth ],/*22*/	[ a = a,         b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*23*/	[ a = a,         b = b,         c = c,         d = d/~fth,    e = e,         f = f/~fth ],/*24*/	[ a = a/~fth,    b = b,         c = c,         d = d,         e = e,         f = f*~fth ],/*25*/	[ a = a*~fth,    b = b*~fth,    c = c*~fth,    d = d,         e = e,         f = f ],/*26*/	[ a = a,         b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*27*/	[ a = a,         b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f ],/*28*/	[ a = a/~fth*n4, b = b*~fth*n4, c = c*~fth*n4, d = d*~fth*n4, e = e*~fth*n4, f = f/~fth*n4 ],/*29*/	[ a = a,         b = b,         c = c/~fth,    d = d/~fth,    e = e,         f = f ],/*30*/	[ a = a*~fth*n5, b = b/~fth*n5, c = c*~fth*n5, d = d*~fth*n5, e = e/~fth*n5, f = f*~fth*n5 ],/*31*/	[ a = a/~fth,    b = b*~fth,    c = c,         d = d,         e = e,         f = f/~fth ],/*32*/	[ a = a,         b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f ],/*33*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*34*/	[ a = a/~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f*~fth ],/*35*/	[ a = a*~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f/~fth ],/*36*/	[ a = a/~fth,    b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f*~fth ],/*37*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e,         f = f ],/*38*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d/~fth,    e = e*~fth,    f = f ],/*39*/	[ a = a/~fth*n6, b = b*~fth*n6, c = c/~fth*n6, d = d*~fth*n6, e = e/~fth*n6, f = f/~fth*n6 ],/*40*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d/~fth,    e = e*~fth,    f = f ],/*41*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d,         e = e,         f = f*~fth ],/*42*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*43*/	[ a = a/~fth,    b = b,         c = c*~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*44*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f/~fth ],/*45*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f ],/*46*/	[ a = a,         b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*47*/	[ a = a,         b = b*~fth,    c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*48*/	[ a = a,         b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*49*/	[ a = a,         b = b,         c = c*~fth,    d = d,         e = e/~fth,    f = f*~fth ],/*50*/	[ a = a*~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f/~fth ],/*51*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f*~fth ],/*52*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f/~fth ],/*53*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f ],/*54*/	[ a = a/~fth*n7, b = b/~fth*n7, c = c*~fth*n7, d = d/~fth*n7, e = e*~fth*n7, f = f*~fth*n7 ],/*55*/	[ a = a,         b = b,         c = c,         d = d*~fth,    e = e/~fth,    f = f ],/*56*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f/~fth ],/*57*/	[ a = a,         b = b*~fth,    c = c/~fth,    d = d,         e = e*~fth,    f = f ],/*58*/	[ a = a/~fth,    b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f*~fth ],/*59*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d,         e = e,         f = f/~fth ],/*60*/	[ a = a/~fth,    b = b,         c = c,         d = d,         e = e,         f = f*~fth ],/*61*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f ],/*62*/	[ a = a/~fth*n8, b = b/~fth*n8, c = c*~fth*n8, d = d*~fth*n8, e = e/~fth*n8, f = f/~fth*n8 ],/*63*/	[ a = a,         b = b*~fth,    c = c/~fth,    d = d,         e = e,         f = f*~fth ],/*64*/	[ a = a*~fth*n9, b = b/~fth*n9, c = c*~fth*n9, d = d/~fth*n9, e = e*~fth*n9, f = f/~fth*n9 ]]
				++Array.fill((~gsinenum*2 -1), {[/*1*/	[ a = a,         b = b*~fth,    c = c,         d = d*~fth,    e = e,         f = f*~fth ],/*2*/	[ a = a/~fth*n1, b = b/~fth*n1, c = c/~fth*n1, d = d/~fth*n1, e = e/~fth*n1, f = f/~fth*n1 ],/*3*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f*~fth  ],/*4*/	[ a = a*~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f/~fth  ],/*5*/	[ a = a/~fth,    b = b*~fth,    c = c,         d = d*~fth,    e = e,         f = f*~fth ],/*6*/	[ a = a*~fth,    b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f/~fth  ],/*7*/	[ a = a/~fth,    b = b/~fth,    c = c/~fth,    d = d,         e = e,         f = f ],/*8*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*9*/	[ a = a*~fth,    b = b,         c = c,         d = d*~fth,    e = e*~fth,    f = f*~fth ],/*10*/	[ a = a,         b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*11*/	[ a = a/~fth,    b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*12*/	[ a = a*~fth*n2, b = b*~fth*n2, c = c*~fth*n2, d = d/~fth*n2, e = e/~fth*n2, f = f/~fth*n2 ],/*13*/	[ a = a,         b = b,         c = c,         d = d*~fth,    e = e,         f = f*~fth ],/*14*/	[ a = a,         b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f],/*15*/	[ a = a/~fth,    b = b,         c = c/~fth,    d = d,         e = e/~fth,    f = f/~fth ],/*16*/	[ a = a,         b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*17*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f*~fth],/*18*/	[ a = a*~fth*n3, b = b/~fth*n3, c = c/~fth*n3, d = d*~fth*n3, e = e*~fth*n3, f = f/~fth*n3 ],/*19*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e,         f = f*~fth ],/*20*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f/~fth ],/*21*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d,         e = e,         f = f*~fth ],/*22*/	[ a = a,         b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*23*/	[ a = a,         b = b,         c = c,         d = d/~fth,    e = e,         f = f/~fth ],/*24*/	[ a = a/~fth,    b = b,         c = c,         d = d,         e = e,         f = f*~fth ],/*25*/	[ a = a*~fth,    b = b*~fth,    c = c*~fth,    d = d,         e = e,         f = f ],/*26*/	[ a = a,         b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*27*/	[ a = a,         b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f ],/*28*/	[ a = a/~fth*n4, b = b*~fth*n4, c = c*~fth*n4, d = d*~fth*n4, e = e*~fth*n4, f = f/~fth*n4 ],/*29*/	[ a = a,         b = b,         c = c/~fth,    d = d/~fth,    e = e,         f = f ],/*30*/	[ a = a*~fth*n5, b = b/~fth*n5, c = c*~fth*n5, d = d*~fth*n5, e = e/~fth*n5, f = f*~fth*n5 ],/*31*/	[ a = a/~fth,    b = b*~fth,    c = c,         d = d,         e = e,         f = f/~fth ],/*32*/	[ a = a,         b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f ],/*33*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*34*/	[ a = a/~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f*~fth ],/*35*/	[ a = a*~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f/~fth ],/*36*/	[ a = a/~fth,    b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f*~fth ],/*37*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e,         f = f ],/*38*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d/~fth,    e = e*~fth,    f = f ],/*39*/	[ a = a/~fth*n6, b = b*~fth*n6, c = c/~fth*n6, d = d*~fth*n6, e = e/~fth*n6, f = f/~fth*n6 ],/*40*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d/~fth,    e = e*~fth,    f = f ],/*41*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d,         e = e,         f = f*~fth ],/*42*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*43*/	[ a = a/~fth,    b = b,         c = c*~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*44*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f/~fth ],/*45*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f ],/*46*/	[ a = a,         b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*47*/	[ a = a,         b = b*~fth,    c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*48*/	[ a = a,         b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*49*/	[ a = a,         b = b,         c = c*~fth,    d = d,         e = e/~fth,    f = f*~fth ],/*50*/	[ a = a*~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f/~fth ],/*51*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f*~fth ],/*52*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f/~fth ],/*53*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f ],/*54*/	[ a = a/~fth*n7, b = b/~fth*n7, c = c*~fth*n7, d = d/~fth*n7, e = e*~fth*n7, f = f*~fth*n7 ],/*55*/	[ a = a,         b = b,         c = c,         d = d*~fth,    e = e/~fth,    f = f ],/*56*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f/~fth ],/*57*/	[ a = a,         b = b*~fth,    c = c/~fth,    d = d,         e = e*~fth,    f = f ],/*58*/	[ a = a/~fth,    b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f*~fth ],/*59*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d,         e = e,         f = f/~fth ],/*60*/	[ a = a/~fth,    b = b,         c = c,         d = d,         e = e,         f = f*~fth ],/*61*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f ],/*62*/	[ a = a/~fth*n8, b = b/~fth*n8, c = c*~fth*n8, d = d*~fth*n8, e = e/~fth*n8, f = f/~fth*n8 ],/*63*/	[ a = a,         b = b*~fth,    c = c/~fth,    d = d,         e = e,         f = f*~fth ],/*64*/	[ a = a*~fth*n9, b = b/~fth*n9, c = c*~fth*n9, d = d/~fth*n9, e = e*~fth*n9, f = f/~fth*n9 ]]
			}).flatten].flatten.reverse, inf);
			s1 = GrainSin.ar(1, Impulse.ar(dur+tune), 1/(dur+tune), Demand.ar(Impulse.ar(dur+tune), 0, dseq));
			OffsetOut.ar(0, s1.dup*vol);
		}, [\ir]).add;

		SynthDef(\gsineicfld6, {arg graindur = 0.04, dur = 2000, atk = 0.007, rel = 0.01, gate = 1, amp = 1, i = 1, vol = ~vol, rate = 20, tune = 0,dseqval,
			a, b, c, d, e, f, pan=0, fc = 1;
			var s1, out, env1, s2, dseq,n1,n2,n3,n4,n5,n6,n7,n8,n9;
			#n1,n2,n3,n4,n5,n6,n7,n8,n9=[~ngm6,~ngm6,~ngm6,~ngm6,~ngm6,~ngm6,~ngm6,~ngm6,~ngm6];
			dseq = Dseq([/*1*/	#a,b,c,d,e,f=[ ~a,~b,~c,~d,~e,~f  ],/*2*/	[ a = a/~fth*n1, b = b/~fth*n1, c = c/~fth*n1, d = d/~fth*n1, e = e/~fth*n1, f = f/~fth*n1 ],/*3*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f*~fth  ],/*4*/	[ a = a*~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f/~fth  ],/*5*/	[ a = a/~fth,    b = b*~fth,    c = c,         d = d*~fth,    e = e,         f = f*~fth ],/*6*/	[ a = a*~fth,    b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f/~fth  ],/*7*/	[ a = a/~fth,    b = b/~fth,    c = c/~fth,    d = d,         e = e,         f = f ],/*8*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*9*/	[ a = a*~fth,    b = b,         c = c,         d = d*~fth,    e = e*~fth,    f = f*~fth ],/*10*/	[ a = a,         b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*11*/	[ a = a/~fth,    b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*12*/	[ a = a*~fth*n2, b = b*~fth*n2, c = c*~fth*n2, d = d/~fth*n2, e = e/~fth*n2, f = f/~fth*n2 ],/*13*/	[ a = a,         b = b,         c = c,         d = d*~fth,    e = e,         f = f*~fth ],/*14*/	[ a = a,         b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f],/*15*/	[ a = a/~fth,    b = b,         c = c/~fth,    d = d,         e = e/~fth,    f = f/~fth ],/*16*/	[ a = a,         b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*17*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f*~fth],/*18*/	[ a = a*~fth*n3, b = b/~fth*n3, c = c/~fth*n3, d = d*~fth*n3, e = e*~fth*n3, f = f/~fth*n3 ],/*19*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e,         f = f*~fth ],/*20*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f/~fth ],/*21*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d,         e = e,         f = f*~fth ],/*22*/	[ a = a,         b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*23*/	[ a = a,         b = b,         c = c,         d = d/~fth,    e = e,         f = f/~fth ],/*24*/	[ a = a/~fth,    b = b,         c = c,         d = d,         e = e,         f = f*~fth ],/*25*/	[ a = a*~fth,    b = b*~fth,    c = c*~fth,    d = d,         e = e,         f = f ],/*26*/	[ a = a,         b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*27*/	[ a = a,         b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f ],/*28*/	[ a = a/~fth*n4, b = b*~fth*n4, c = c*~fth*n4, d = d*~fth*n4, e = e*~fth*n4, f = f/~fth*n4 ],/*29*/	[ a = a,         b = b,         c = c/~fth,    d = d/~fth,    e = e,         f = f ],/*30*/	[ a = a*~fth*n5, b = b/~fth*n5, c = c*~fth*n5, d = d*~fth*n5, e = e/~fth*n5, f = f*~fth*n5 ],/*31*/	[ a = a/~fth,    b = b*~fth,    c = c,         d = d,         e = e,         f = f/~fth ],/*32*/	[ a = a,         b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f ],/*33*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*34*/	[ a = a/~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f*~fth ],/*35*/	[ a = a*~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f/~fth ],/*36*/	[ a = a/~fth,    b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f*~fth ],/*37*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e,         f = f ],/*38*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d/~fth,    e = e*~fth,    f = f ],/*39*/	[ a = a/~fth*n6, b = b*~fth*n6, c = c/~fth*n6, d = d*~fth*n6, e = e/~fth*n6, f = f/~fth*n6 ],/*40*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d/~fth,    e = e*~fth,    f = f ],/*41*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d,         e = e,         f = f*~fth ],/*42*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*43*/	[ a = a/~fth,    b = b,         c = c*~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*44*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f/~fth ],/*45*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f ],/*46*/	[ a = a,         b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*47*/	[ a = a,         b = b*~fth,    c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*48*/	[ a = a,         b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*49*/	[ a = a,         b = b,         c = c*~fth,    d = d,         e = e/~fth,    f = f*~fth ],/*50*/	[ a = a*~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f/~fth ],/*51*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f*~fth ],/*52*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f/~fth ],/*53*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f ],/*54*/	[ a = a/~fth*n7, b = b/~fth*n7, c = c*~fth*n7, d = d/~fth*n7, e = e*~fth*n7, f = f*~fth*n7 ],/*55*/	[ a = a,         b = b,         c = c,         d = d*~fth,    e = e/~fth,    f = f ],/*56*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f/~fth ],/*57*/	[ a = a,         b = b*~fth,    c = c/~fth,    d = d,         e = e*~fth,    f = f ],/*58*/	[ a = a/~fth,    b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f*~fth ],/*59*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d,         e = e,         f = f/~fth ],/*60*/	[ a = a/~fth,    b = b,         c = c,         d = d,         e = e,         f = f*~fth ],/*61*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f ],/*62*/	[ a = a/~fth*n8, b = b/~fth*n8, c = c*~fth*n8, d = d*~fth*n8, e = e/~fth*n8, f = f/~fth*n8 ],/*63*/	[ a = a,         b = b*~fth,    c = c/~fth,    d = d,         e = e,         f = f*~fth ],/*64*/	[ a = a*~fth*n9, b = b/~fth*n9, c = c*~fth*n9, d = d/~fth*n9, e = e*~fth*n9, f = f/~fth*n9 ]]
				++Array.fill((~gsinenum*6 -1), {[/*1*/	[ a = a,         b = b*~fth,    c = c,         d = d*~fth,    e = e,         f = f*~fth ],/*2*/	[ a = a/~fth*n1, b = b/~fth*n1, c = c/~fth*n1, d = d/~fth*n1, e = e/~fth*n1, f = f/~fth*n1 ],/*3*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f*~fth  ],/*4*/	[ a = a*~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f/~fth  ],/*5*/	[ a = a/~fth,    b = b*~fth,    c = c,         d = d*~fth,    e = e,         f = f*~fth ],/*6*/	[ a = a*~fth,    b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f/~fth  ],/*7*/	[ a = a/~fth,    b = b/~fth,    c = c/~fth,    d = d,         e = e,         f = f ],/*8*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*9*/	[ a = a*~fth,    b = b,         c = c,         d = d*~fth,    e = e*~fth,    f = f*~fth ],/*10*/	[ a = a,         b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*11*/	[ a = a/~fth,    b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*12*/	[ a = a*~fth*n2, b = b*~fth*n2, c = c*~fth*n2, d = d/~fth*n2, e = e/~fth*n2, f = f/~fth*n2 ],/*13*/	[ a = a,         b = b,         c = c,         d = d*~fth,    e = e,         f = f*~fth ],/*14*/	[ a = a,         b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f],/*15*/	[ a = a/~fth,    b = b,         c = c/~fth,    d = d,         e = e/~fth,    f = f/~fth ],/*16*/	[ a = a,         b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*17*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f*~fth],/*18*/	[ a = a*~fth*n3, b = b/~fth*n3, c = c/~fth*n3, d = d*~fth*n3, e = e*~fth*n3, f = f/~fth*n3 ],/*19*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e,         f = f*~fth ],/*20*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f/~fth ],/*21*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d,         e = e,         f = f*~fth ],/*22*/	[ a = a,         b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*23*/	[ a = a,         b = b,         c = c,         d = d/~fth,    e = e,         f = f/~fth ],/*24*/	[ a = a/~fth,    b = b,         c = c,         d = d,         e = e,         f = f*~fth ],/*25*/	[ a = a*~fth,    b = b*~fth,    c = c*~fth,    d = d,         e = e,         f = f ],/*26*/	[ a = a,         b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*27*/	[ a = a,         b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f ],/*28*/	[ a = a/~fth*n4, b = b*~fth*n4, c = c*~fth*n4, d = d*~fth*n4, e = e*~fth*n4, f = f/~fth*n4 ],/*29*/	[ a = a,         b = b,         c = c/~fth,    d = d/~fth,    e = e,         f = f ],/*30*/	[ a = a*~fth*n5, b = b/~fth*n5, c = c*~fth*n5, d = d*~fth*n5, e = e/~fth*n5, f = f*~fth*n5 ],/*31*/	[ a = a/~fth,    b = b*~fth,    c = c,         d = d,         e = e,         f = f/~fth ],/*32*/	[ a = a,         b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f ],/*33*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*34*/	[ a = a/~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f*~fth ],/*35*/	[ a = a*~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f/~fth ],/*36*/	[ a = a/~fth,    b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f*~fth ],/*37*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e,         f = f ],/*38*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d/~fth,    e = e*~fth,    f = f ],/*39*/	[ a = a/~fth*n6, b = b*~fth*n6, c = c/~fth*n6, d = d*~fth*n6, e = e/~fth*n6, f = f/~fth*n6 ],/*40*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d/~fth,    e = e*~fth,    f = f ],/*41*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d,         e = e,         f = f*~fth ],/*42*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*43*/	[ a = a/~fth,    b = b,         c = c*~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*44*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f/~fth ],/*45*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f ],/*46*/	[ a = a,         b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*47*/	[ a = a,         b = b*~fth,    c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*48*/	[ a = a,         b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*49*/	[ a = a,         b = b,         c = c*~fth,    d = d,         e = e/~fth,    f = f*~fth ],/*50*/	[ a = a*~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f/~fth ],/*51*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f*~fth ],/*52*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f/~fth ],/*53*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f ],/*54*/	[ a = a/~fth*n7, b = b/~fth*n7, c = c*~fth*n7, d = d/~fth*n7, e = e*~fth*n7, f = f*~fth*n7 ],/*55*/	[ a = a,         b = b,         c = c,         d = d*~fth,    e = e/~fth,    f = f ],/*56*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f/~fth ],/*57*/	[ a = a,         b = b*~fth,    c = c/~fth,    d = d,         e = e*~fth,    f = f ],/*58*/	[ a = a/~fth,    b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f*~fth ],/*59*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d,         e = e,         f = f/~fth ],/*60*/	[ a = a/~fth,    b = b,         c = c,         d = d,         e = e,         f = f*~fth ],/*61*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f ],/*62*/	[ a = a/~fth*n8, b = b/~fth*n8, c = c*~fth*n8, d = d*~fth*n8, e = e/~fth*n8, f = f/~fth*n8 ],/*63*/	[ a = a,         b = b*~fth,    c = c/~fth,    d = d,         e = e,         f = f*~fth ],/*64*/	[ a = a*~fth*n9, b = b/~fth*n9, c = c*~fth*n9, d = d/~fth*n9, e = e*~fth*n9, f = f/~fth*n9 ]]
			}).flatten, inf);
			s1 = GrainSin.ar(1, Impulse.ar(dur+tune), 1/(dur+tune),Demand.ar(Impulse.ar(dur+tune), 0, dseq)*fc);
			OffsetOut.ar(0, s1.dup*vol);
		}, [\ir]).add;

		SynthDef(\gsineicrld6, {arg graindur = 0.04, dur = 2000, atk = 0.007, rel = 0.01, gate = 1, amp = 1, i = 1, vol = ~vol, rate = 20, tune = 0,dseqval,
			a, b, c, d, e, f, pan=0, fc = 1;
			var s1, out, env1, s2, dseq,n1,n2,n3,n4,n5,n6,n7,n8,n9;
			#n1,n2,n3,n4,n5,n6,n7,n8,n9=[~ngm6,~ngm6,~ngm6,~ngm6,~ngm6,~ngm6,~ngm6,~ngm6,~ngm6];
			dseq = Dseq([[/*1*/	#a,b,c,d,e,f=[ ~a,~b,~c,~d,~e,~f  ],/*2*/	[ a = a/~fth*n1, b = b/~fth*n1, c = c/~fth*n1, d = d/~fth*n1, e = e/~fth*n1, f = f/~fth*n1 ],/*3*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f*~fth  ],/*4*/	[ a = a*~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f/~fth  ],/*5*/	[ a = a/~fth,    b = b*~fth,    c = c,         d = d*~fth,    e = e,         f = f*~fth ],/*6*/	[ a = a*~fth,    b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f/~fth  ],/*7*/	[ a = a/~fth,    b = b/~fth,    c = c/~fth,    d = d,         e = e,         f = f ],/*8*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*9*/	[ a = a*~fth,    b = b,         c = c,         d = d*~fth,    e = e*~fth,    f = f*~fth ],/*10*/	[ a = a,         b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*11*/	[ a = a/~fth,    b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*12*/	[ a = a*~fth*n2, b = b*~fth*n2, c = c*~fth*n2, d = d/~fth*n2, e = e/~fth*n2, f = f/~fth*n2 ],/*13*/	[ a = a,         b = b,         c = c,         d = d*~fth,    e = e,         f = f*~fth ],/*14*/	[ a = a,         b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f],/*15*/	[ a = a/~fth,    b = b,         c = c/~fth,    d = d,         e = e/~fth,    f = f/~fth ],/*16*/	[ a = a,         b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*17*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f*~fth],/*18*/	[ a = a*~fth*n3, b = b/~fth*n3, c = c/~fth*n3, d = d*~fth*n3, e = e*~fth*n3, f = f/~fth*n3 ],/*19*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e,         f = f*~fth ],/*20*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f/~fth ],/*21*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d,         e = e,         f = f*~fth ],/*22*/	[ a = a,         b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*23*/	[ a = a,         b = b,         c = c,         d = d/~fth,    e = e,         f = f/~fth ],/*24*/	[ a = a/~fth,    b = b,         c = c,         d = d,         e = e,         f = f*~fth ],/*25*/	[ a = a*~fth,    b = b*~fth,    c = c*~fth,    d = d,         e = e,         f = f ],/*26*/	[ a = a,         b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*27*/	[ a = a,         b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f ],/*28*/	[ a = a/~fth*n4, b = b*~fth*n4, c = c*~fth*n4, d = d*~fth*n4, e = e*~fth*n4, f = f/~fth*n4 ],/*29*/	[ a = a,         b = b,         c = c/~fth,    d = d/~fth,    e = e,         f = f ],/*30*/	[ a = a*~fth*n5, b = b/~fth*n5, c = c*~fth*n5, d = d*~fth*n5, e = e/~fth*n5, f = f*~fth*n5 ],/*31*/	[ a = a/~fth,    b = b*~fth,    c = c,         d = d,         e = e,         f = f/~fth ],/*32*/	[ a = a,         b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f ],/*33*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*34*/	[ a = a/~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f*~fth ],/*35*/	[ a = a*~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f/~fth ],/*36*/	[ a = a/~fth,    b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f*~fth ],/*37*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e,         f = f ],/*38*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d/~fth,    e = e*~fth,    f = f ],/*39*/	[ a = a/~fth*n6, b = b*~fth*n6, c = c/~fth*n6, d = d*~fth*n6, e = e/~fth*n6, f = f/~fth*n6 ],/*40*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d/~fth,    e = e*~fth,    f = f ],/*41*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d,         e = e,         f = f*~fth ],/*42*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*43*/	[ a = a/~fth,    b = b,         c = c*~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*44*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f/~fth ],/*45*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f ],/*46*/	[ a = a,         b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*47*/	[ a = a,         b = b*~fth,    c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*48*/	[ a = a,         b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*49*/	[ a = a,         b = b,         c = c*~fth,    d = d,         e = e/~fth,    f = f*~fth ],/*50*/	[ a = a*~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f/~fth ],/*51*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f*~fth ],/*52*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f/~fth ],/*53*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f ],/*54*/	[ a = a/~fth*n7, b = b/~fth*n7, c = c*~fth*n7, d = d/~fth*n7, e = e*~fth*n7, f = f*~fth*n7 ],/*55*/	[ a = a,         b = b,         c = c,         d = d*~fth,    e = e/~fth,    f = f ],/*56*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f/~fth ],/*57*/	[ a = a,         b = b*~fth,    c = c/~fth,    d = d,         e = e*~fth,    f = f ],/*58*/	[ a = a/~fth,    b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f*~fth ],/*59*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d,         e = e,         f = f/~fth ],/*60*/	[ a = a/~fth,    b = b,         c = c,         d = d,         e = e,         f = f*~fth ],/*61*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f ],/*62*/	[ a = a/~fth*n8, b = b/~fth*n8, c = c*~fth*n8, d = d*~fth*n8, e = e/~fth*n8, f = f/~fth*n8 ],/*63*/	[ a = a,         b = b*~fth,    c = c/~fth,    d = d,         e = e,         f = f*~fth ],/*64*/	[ a = a*~fth*n9, b = b/~fth*n9, c = c*~fth*n9, d = d/~fth*n9, e = e*~fth*n9, f = f/~fth*n9 ]]
				++Array.fill((~gsinenum*6 -1), {[/*1*/	[ a = a,         b = b*~fth,    c = c,         d = d*~fth,    e = e,         f = f*~fth ],/*2*/	[ a = a/~fth*n1, b = b/~fth*n1, c = c/~fth*n1, d = d/~fth*n1, e = e/~fth*n1, f = f/~fth*n1 ],/*3*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f*~fth  ],/*4*/	[ a = a*~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f/~fth  ],/*5*/	[ a = a/~fth,    b = b*~fth,    c = c,         d = d*~fth,    e = e,         f = f*~fth ],/*6*/	[ a = a*~fth,    b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f/~fth  ],/*7*/	[ a = a/~fth,    b = b/~fth,    c = c/~fth,    d = d,         e = e,         f = f ],/*8*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*9*/	[ a = a*~fth,    b = b,         c = c,         d = d*~fth,    e = e*~fth,    f = f*~fth ],/*10*/	[ a = a,         b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*11*/	[ a = a/~fth,    b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*12*/	[ a = a*~fth*n2, b = b*~fth*n2, c = c*~fth*n2, d = d/~fth*n2, e = e/~fth*n2, f = f/~fth*n2 ],/*13*/	[ a = a,         b = b,         c = c,         d = d*~fth,    e = e,         f = f*~fth ],/*14*/	[ a = a,         b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f],/*15*/	[ a = a/~fth,    b = b,         c = c/~fth,    d = d,         e = e/~fth,    f = f/~fth ],/*16*/	[ a = a,         b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*17*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f*~fth],/*18*/	[ a = a*~fth*n3, b = b/~fth*n3, c = c/~fth*n3, d = d*~fth*n3, e = e*~fth*n3, f = f/~fth*n3 ],/*19*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e,         f = f*~fth ],/*20*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f/~fth ],/*21*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d,         e = e,         f = f*~fth ],/*22*/	[ a = a,         b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*23*/	[ a = a,         b = b,         c = c,         d = d/~fth,    e = e,         f = f/~fth ],/*24*/	[ a = a/~fth,    b = b,         c = c,         d = d,         e = e,         f = f*~fth ],/*25*/	[ a = a*~fth,    b = b*~fth,    c = c*~fth,    d = d,         e = e,         f = f ],/*26*/	[ a = a,         b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*27*/	[ a = a,         b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f ],/*28*/	[ a = a/~fth*n4, b = b*~fth*n4, c = c*~fth*n4, d = d*~fth*n4, e = e*~fth*n4, f = f/~fth*n4 ],/*29*/	[ a = a,         b = b,         c = c/~fth,    d = d/~fth,    e = e,         f = f ],/*30*/	[ a = a*~fth*n5, b = b/~fth*n5, c = c*~fth*n5, d = d*~fth*n5, e = e/~fth*n5, f = f*~fth*n5 ],/*31*/	[ a = a/~fth,    b = b*~fth,    c = c,         d = d,         e = e,         f = f/~fth ],/*32*/	[ a = a,         b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f ],/*33*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*34*/	[ a = a/~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f*~fth ],/*35*/	[ a = a*~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f/~fth ],/*36*/	[ a = a/~fth,    b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f*~fth ],/*37*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e,         f = f ],/*38*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d/~fth,    e = e*~fth,    f = f ],/*39*/	[ a = a/~fth*n6, b = b*~fth*n6, c = c/~fth*n6, d = d*~fth*n6, e = e/~fth*n6, f = f/~fth*n6 ],/*40*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d/~fth,    e = e*~fth,    f = f ],/*41*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d,         e = e,         f = f*~fth ],/*42*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*43*/	[ a = a/~fth,    b = b,         c = c*~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*44*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f/~fth ],/*45*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f ],/*46*/	[ a = a,         b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*47*/	[ a = a,         b = b*~fth,    c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*48*/	[ a = a,         b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*49*/	[ a = a,         b = b,         c = c*~fth,    d = d,         e = e/~fth,    f = f*~fth ],/*50*/	[ a = a*~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f/~fth ],/*51*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f*~fth ],/*52*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f/~fth ],/*53*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f ],/*54*/	[ a = a/~fth*n7, b = b/~fth*n7, c = c*~fth*n7, d = d/~fth*n7, e = e*~fth*n7, f = f*~fth*n7 ],/*55*/	[ a = a,         b = b,         c = c,         d = d*~fth,    e = e/~fth,    f = f ],/*56*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f/~fth ],/*57*/	[ a = a,         b = b*~fth,    c = c/~fth,    d = d,         e = e*~fth,    f = f ],/*58*/	[ a = a/~fth,    b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f*~fth ],/*59*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d,         e = e,         f = f/~fth ],/*60*/	[ a = a/~fth,    b = b,         c = c,         d = d,         e = e,         f = f*~fth ],/*61*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f ],/*62*/	[ a = a/~fth*n8, b = b/~fth*n8, c = c*~fth*n8, d = d*~fth*n8, e = e/~fth*n8, f = f/~fth*n8 ],/*63*/	[ a = a,         b = b*~fth,    c = c/~fth,    d = d,         e = e,         f = f*~fth ],/*64*/	[ a = a*~fth*n9, b = b/~fth*n9, c = c*~fth*n9, d = d/~fth*n9, e = e*~fth*n9, f = f/~fth*n9 ]]
			}).flatten].flatten.reverse, inf);
			s1 = GrainSin.ar(1, Impulse.ar(dur+tune), 1/(dur+tune),Demand.ar(Impulse.ar(dur+tune), 0, dseq)*fc);
			OffsetOut.ar(0, s1.dup*vol);
		}, [\ir]).add;


	};


	//starting values for synthdefs

	if((~gsinenum == nil) and: (~synthdef != "gsineicld"), {
		(
			if(~basefreq == nil, {~basefreq = ~base_frequency});
			~fmult = 16;
			(#a,b,c,d,e,f = [ ~basefreq,~basefreq,~basefreq,~basefreq,~basefreq,~basefreq  ];
				~a = a; ~b = b; ~c =c; ~d = d; ~e = e;~f=f;);

			~fth = 1.4142135623729;
			~gm = 1.6180339887499;
			~gm2 = 1.2720196495141;
			~gm6 = 1.0835058821738;
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
			~ngm1 = 1.0549232131786;
			~ngm2 = 1.0270945492887;
			~ngm6 = 1.0089511542031;
			~nval = ~ngm6;

			~synthdef = "gsineicld"; ~gsinenum = ~synthdefnum;
			case
			{~gsine == nil}{~gsine1.value}
			{~gsine == 0}{~gsine1.value;}
			{~gsine == 1}{~gsine2.value;};

		);
	});


	//generaate GUI window

	w = Window("Timewave Synth", Rect(0,0,Window.screenBounds.width,Window.screenBounds.height), border:true);

	view = UserView(w, Window.screenBounds);
	view.clearOnRefresh = false;
	view.background = Color.black;

	//vertical grid (inactive)

	/*~b1 = Window.screenBounds.width/(12*4) /*25.462962962963*/; ~btu = 31; ~btd = 375; ~bw = 0.5; ~bh = 120; ~bcolor = Color.grey;
	CompositeView(w, Rect(~b1, ~btu, ~bw, ~bh)).background = ~bcolor;
	CompositeView(w, Rect(~b1, ~btd, ~bw, ~bh)).background = ~bcolor;
	54.do({CompositeView(w, Rect(~b1 = ~b1+(Window.screenBounds.width/(12*4)), ~btu, ~bw, ~bh)).background = ~bcolor;});
	~b1 = Window.screenBounds.width/(12*4);
	54.do({CompositeView(w, Rect(~b1 = ~b1+(Window.screenBounds.width/(12*4)), ~btd, ~bw, ~bh)).background = ~bcolor;});*/

	~nh = 2;
	~nw = ~nh*1.6180339887499;

	~tgrid = 30;
	~bgrid = Window.screenBounds.height-(Window.screenBounds.height/1.6180339887499)+30;

	~dc1 = ~tgrid-5; ~dc2 = ~bgrid-5; ~dca = 10;

	//horizontal grid

	13.do(x=~tgrid-10; {CompositeView(w, Rect(1, x=x+10, Window.screenBounds.width, 0.5)).background = Color.new255(51, 51, 51)});
	13.do(x=~bgrid-10; {CompositeView(w, Rect(1, x=x+10, Window.screenBounds.width, 0.5)).background = Color.new255(51, 51, 51)});

	~z1 = (CompositeView(w, Rect((if(~f1 == nil, {f1.value},{~f1.value}).explin(~outmin1,~outmax1,0,Window.screenBounds.width)), ~dc1=~dc1+10, ~nw, 2)).background = Color.white;);
	~z2 = (CompositeView(w, Rect((if(~f2 == nil, {f2.value},{~f2.value}).explin(~outmin1,~outmax1,0,Window.screenBounds.width)), ~dc1=~dc1+10, ~nw, 2)).background = Color.white;);
	~z3 = (CompositeView(w, Rect((if(~f3 == nil, {f3.value},{~f3.value}).explin(~outmin1,~outmax1,0,Window.screenBounds.width)), ~dc1=~dc1+10, ~nw, 2)).background = Color.white;);
	~z4 = (CompositeView(w, Rect((if(~f4 == nil, {f4.value},{~f4.value}).explin(~outmin1,~outmax1,0,Window.screenBounds.width)), ~dc1=~dc1+10, ~nw, 2)).background = Color.white;);
	~z5 = (CompositeView(w, Rect((if(~f5 == nil, {f5.value},{~f5.value}).explin(~outmin1,~outmax1,0,Window.screenBounds.width)), ~dc1=~dc1+10, ~nw, 2)).background = Color.white;);
	~z6 = (CompositeView(w, Rect((if(~f6 == nil, {f6.value},{~f6.value}).explin(~outmin1,~outmax1,0,Window.screenBounds.width)), ~dc1=~dc1+10, ~nw, 2)).background = Color.white;);
	~z7 = (CompositeView(w, Rect((if(~f7 == nil, {f7.value},{~f7.value}).explin(~outmin1,~outmax1,0,Window.screenBounds.width)), ~dc1=~dc1+10, ~nw, 2)).background = Color.white;);
	~z8 = (CompositeView(w, Rect((if(~f8 == nil, {f8.value},{~f8.value}).explin(~outmin1,~outmax1,0,Window.screenBounds.width)), ~dc1=~dc1+10, ~nw, 2)).background = Color.white;);
	~z9 = (CompositeView(w, Rect((if(~f9 == nil, {f9.value},{~f9.value}).explin(~outmin1,~outmax1,0,Window.screenBounds.width)), ~dc1=~dc1+10, ~nw, 2)).background = Color.white;);
	~z10 = (CompositeView(w, Rect((if(~f10 == nil, {f10.value},{~f10.value}).explin(~outmin1,~outmax1,0,Window.screenBounds.width)), ~dc1=~dc1+10, ~nw, 2)).background = Color.white;);
	~z11 = (CompositeView(w, Rect((if(~f11 == nil, {f11.value},{~f11.value}).explin(~outmin1,~outmax1,0,Window.screenBounds.width)), ~dc1=~dc1+10, ~nw, 2)).background = Color.white;);
	~z12 = (CompositeView(w, Rect((if(~f12 == nil, {f12.value},{~f12.value}).explin(~outmin1,~outmax1,0,Window.screenBounds.width)), ~dc1=~dc1+10, ~nw, 2)).background = Color.white;);
	~zmid = (CompositeView(w, Rect(x, 280, ~nw, 2)).background = Color.clear;);
	~z25 = (CompositeView(w, Rect((if(~f1 == nil, {f1.value},{~f1.value}).explin(~outmin2,~outmax2,0,Window.screenBounds.width)), ~dc2=~dc2+10, ~nw, 2)).background = Color.white;);
	~z26 = (CompositeView(w, Rect((if(~f2 == nil, {f2.value},{~f2.value}).explin(~outmin2,~outmax2,0,Window.screenBounds.width)), ~dc2=~dc2+10, ~nw, 2)).background = Color.white;);
	~z27 = (CompositeView(w, Rect((if(~f3 == nil, {f3.value},{~f3.value}).explin(~outmin2,~outmax2,0,Window.screenBounds.width)), ~dc2=~dc2+10, ~nw, 2)).background = Color.white;);
	~z28 = (CompositeView(w, Rect((if(~f4 == nil, {f4.value},{~f4.value}).explin(~outmin2,~outmax2,0,Window.screenBounds.width)), ~dc2=~dc2+10, ~nw, 2)).background = Color.white;);
	~z29 = (CompositeView(w, Rect((if(~f5 == nil, {f5.value},{~f5.value}).explin(~outmin2,~outmax2,0,Window.screenBounds.width)), ~dc2=~dc2+10, ~nw, 2)).background = Color.white;);
	~z30 = (CompositeView(w, Rect((if(~f6 == nil, {f6.value},{~f6.value}).explin(~outmin2,~outmax2,0,Window.screenBounds.width)), ~dc2=~dc2+10, ~nw, 2)).background = Color.white;);
	~z31 = (CompositeView(w, Rect((if(~f7 == nil, {f7.value},{~f7.value}).explin(~outmin2,~outmax2,0,Window.screenBounds.width)), ~dc2=~dc2+10, ~nw, 2)).background = Color.white;);
	~z32 = (CompositeView(w, Rect((if(~f8 == nil, {f8.value},{~f8.value}).explin(~outmin2,~outmax2,0,Window.screenBounds.width)), ~dc2=~dc2+10, ~nw, 2)).background = Color.white;);
	~z33 = (CompositeView(w, Rect((if(~f9 == nil, {f9.value},{~f9.value}).explin(~outmin2,~outmax2,0,Window.screenBounds.width)), ~dc2=~dc2+10, ~nw, 2)).background = Color.white;);
	~z34 = (CompositeView(w, Rect((if(~f10 == nil, {f10.value},{~f10.value}).explin(~outmin2,~outmax2,0,Window.screenBounds.width)), ~dc2=~dc2+10, ~nw, 2)).background = Color.white;);
	~z35 = (CompositeView(w, Rect((if(~f11 == nil, {f11.value},{~f11.value}).explin(~outmin2,~outmax2,0,Window.screenBounds.width)), ~dc2=~dc2+10, ~nw, 2)).background = Color.white;);
	~z36 = (CompositeView(w, Rect((if(~f12 == nil, {f12.value},{~f12.value}).explin(~outmin2,~outmax2,0,Window.screenBounds.width)), ~dc2=~dc2+10, ~nw, 2)).background = Color.white;);


	~dc1 = ~tgrid-5; ~dc2 = ~bgrid-5; ~dca = 10;


	//synth functions (open, flow, slide, pause, free)

	~synthopen = {
		case
		{((~l1a.isRunning == false) and: (~l1a1.isRunning == false)) or: ~l1a1.isRunning == true}{
			(1.do({var vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8,vol9,vol10,vol11,vol12,s1,s2,s3,s4,s5,s6,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,tune=0;
				#vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8,vol9,vol10,vol11,vol12 = [~vol1,~vol2,~vol3,~vol4,~vol5,~vol6,~vol7,~vol8,~vol9,~vol10,~vol11,~vol12];
				#f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12 = [ 0,0,0,0,0,0,0,0,0,0,0,0 ];
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
				~l9a1.set(\dur, f9,    \vol, vol9,  \tune, tune);          ~l9b1.set(\dur, f9,  \vol, vol9, \tune, tune);
				~l9c1.set(\dur, f9/~icd3,       \vol, vol9,  \tune, tune); ~l9d1.set(\dur, f9/~icd3,  \vol, vol9, \tune, tune);
				~l9e1.set(\dur, f9/~icd6,       \vol, vol9,  \tune, tune); ~l9f1.set(\dur, f9/~icd6,  \vol, vol9, \tune, tune);
				~l10a1.set(\dur, f10,  \vol, vol10,  \tune, tune);         ~l10b1.set(\dur, f10,  \vol, vol10, \tune, tune);
				~l10c1.set(\dur, f10/~icd3,     \vol, vol10,  \tune, tune);~l10d1.set(\dur, f10/~icd3,  \vol, vol10, \tune, tune);
				~l10e1.set(\dur, f10/~icd6,     \vol, vol10,  \tune, tune);~l10f1.set(\dur, f10/~icd6,  \vol, vol10, \tune, tune);
				~l11a1.set(\dur, f11,  \vol, vol11,  \tune, tune);         ~l11b1.set(\dur, f11,  \vol, vol11, \tune, tune);
				~l11c1.set(\dur, f11/~icd3,     \vol, vol11,  \tune, tune);~l11d1.set(\dur, f11/~icd3,  \vol, vol11, \tune, tune);
				~l11e1.set(\dur, f11/~icd6,     \vol, vol11,  \tune, tune);~l11f1.set(\dur, f11/~icd6,  \vol, vol11, \tune, tune);
				~l12a1.set(\dur, f12,  \vol, vol12,  \tune, tune);         ~l12b1.set(\dur, f12,  \vol, vol12, \tune, tune);
				~l12c1.set(\dur, f12/~icd3,     \vol, vol12,  \tune, tune);~l12d1.set(\dur, f12/~icd3,  \vol, vol12, \tune, tune);
				~l12e1.set(\dur, f12/~icd6,     \vol, vol12,  \tune, tune);~l12f1.set(\dur, f12/~icd6,  \vol, vol12, \tune, tune);
			}););

			(
				1.do({var vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8,vol9,vol10,vol11,vol12,s1,s2,s3,s4,s5,s6,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,tune=0;
					#vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8,vol9,vol10,vol11,vol12 = [~vol1,~vol2,~vol3,~vol4,~vol5,~vol6,~vol7,~vol8,~vol9,~vol10,~vol11,~vol12];
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
					~l8a = Synth(s1, [\dur, ~f8,    \vol, vol8, \tune, tune]);       ~l8b = Synth(s2, [\dur, ~f8,   \vol, vol8, \tune, tune]);
					~l8c = Synth(s3, [\dur, ~f8/~icd3,  \vol, vol8, \tune, tune]);   ~l8d = Synth(s4, [\dur, ~f8/~icd3, \vol, vol8, \tune, tune]);
					~l8e = Synth(s5, [\dur, ~f8/~icd6,  \vol, vol8, \tune, tune]);   ~l8f = Synth(s6, [\dur, ~f8/~icd6, \vol, vol8, \tune, tune]);
					~l9a = Synth(s1, [\dur, ~f9,    \vol, vol9, \tune, tune]);       ~l9b = Synth(s2, [\dur, ~f9,   \vol, vol9, \tune, tune]);
					~l9c = Synth(s3, [\dur, ~f9/~icd3,  \vol, vol9, \tune, tune]);   ~l9d = Synth(s4, [\dur, ~f9/~icd3, \vol, vol9, \tune, tune]);
					~l9e = Synth(s5, [\dur, ~f9/~icd6,  \vol, vol9, \tune, tune]);   ~l9f = Synth(s6, [\dur, ~f9/~icd6, \vol, vol9, \tune, tune]);
					~l10a = Synth(s1, [\dur,~f10,  \vol, vol10, \tune, tune]);       ~l10b = Synth(s2, [\dur, ~f10, \vol, vol10, \tune, tune]);
					~l10c = Synth(s3, [\dur, ~f10/~icd3,  \vol, vol10, \tune, tune]);~l10d = Synth(s4, [\dur, ~f10/~icd3,  \vol, vol10, \tune, tune]);
					~l10e = Synth(s5, [\dur, ~f10/~icd6,  \vol, vol10, \tune, tune]);~l10f = Synth(s6, [\dur, ~f10/~icd6,  \vol, vol10, \tune, tune]);
					~l11a = Synth(s1, [\dur,~f11,   \vol, vol11, \tune, tune]);      ~l11b = Synth(s2, [\dur, ~f11,    \vol, vol11, \tune, tune]);
					~l11c = Synth(s3, [\dur, ~f11/~icd3,  \vol, vol11, \tune, tune]);~l11d = Synth(s4, [\dur, ~f11/~icd3,  \vol, vol11, \tune, tune]);
					~l11e = Synth(s5, [\dur, ~f11/~icd6,  \vol, vol11, \tune, tune]);~l11f = Synth(s6, [\dur, ~f11/~icd6,  \vol, vol11, \tune, tune]);
					~l12a = Synth(s1, [\dur,~f12,   \vol, vol12, \tune, tune]);      ~l12b = Synth(s2, [\dur, ~f12,    \vol, vol12, \tune, tune]);
					~l12c = Synth(s3, [\dur, ~f12/~icd3,  \vol, vol12, \tune, tune]);~l12d = Synth(s4, [\dur, ~f12/~icd3,  \vol, vol12, \tune, tune]);
					~l12e = Synth(s5, [\dur, ~f12/~icd6,  \vol, vol12, \tune, tune]);~l12f = Synth(s6, [\dur, ~f12/~icd6,  \vol, vol12, \tune, tune]);
				});
			);
			AppClock.sched(0.161803398875,{
				([~l1a1,~l1b1,~l1c1,~l1d1,~l1e1,~l1f1,~l2a1,~l2b1,~l2c1,~l2d1,~l2e1,~l2f1,~l3a1,~l3b1,~l3c1,~l3d1,~l3e1,~l3f1,~l4a1,~l4b1,~l4c1,~l4d1,~l4e1,~l4f1,~l5a1,~l5b1,~l5c1,~l5d1,~l5e1,~l5f1,~l6a1,~l6b1,~l6c1,~l6d1,~l6e1,~l6f1,~l7a1,~l7b1,~l7c1,~l7d1,~l7e1,~l7f1,~l8a1,~l8b1,~l8c1,~l8d1,~l8e1,~l8f1,~l9a1,~l9b1,~l9c1,~l9d1,~l9e1,~l9f1,~l10a1,~l10b1,~l10c1,~l10d1,~l10e1,~l10f1,~l11a1,~l11b1,~l11c1,~l11d1,~l11e1,~l11f1,~l12a1,~l12b1,~l12c1,~l12d1,~l12e1,~l12f1 ].do(_.free)); ~slideroutine.stop;
			});
		}
		{~l1a.isRunning == true}{
			(1.do({var vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8,vol9,vol10,vol11,vol12,s1,s2,s3,s4,s5,s6,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,tune=0;
				#vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8,vol9,vol10,vol11,vol12 = [~vol1,~vol2,~vol3,~vol4,~vol5,~vol6,~vol7,~vol8,~vol9,~vol10,~vol11,~vol12];
				#f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12 = [ 0,0,0,0,0,0,0,0,0,0,0,0 ];
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
				~l9a.set(\dur, f9,    \vol, vol9,  \tune, tune);          ~l9b.set(\dur, f9,  \vol, vol9, \tune, tune);
				~l9c.set(\dur, f9/~icd3,       \vol, vol9,  \tune, tune); ~l9d.set(\dur, f9/~icd3,  \vol, vol9, \tune, tune);
				~l9e.set(\dur, f9/~icd6,       \vol, vol9,  \tune, tune); ~l9f.set(\dur, f9/~icd6,  \vol, vol9, \tune, tune);
				~l10a.set(\dur, f10,  \vol, vol10,  \tune, tune);         ~l10b.set(\dur, f10,  \vol, vol10, \tune, tune);
				~l10c.set(\dur, f10/~icd3,     \vol, vol10,  \tune, tune);~l10d.set(\dur, f10/~icd3,  \vol, vol10, \tune, tune);
				~l10e.set(\dur, f10/~icd6,     \vol, vol10,  \tune, tune);~l10f.set(\dur, f10/~icd6,  \vol, vol10, \tune, tune);
				~l11a.set(\dur, f11,  \vol, vol11,  \tune, tune);         ~l11b.set(\dur, f11,  \vol, vol11, \tune, tune);
				~l11c.set(\dur, f11/~icd3,     \vol, vol11,  \tune, tune);~l11d.set(\dur, f11/~icd3,  \vol, vol11, \tune, tune);
				~l11e.set(\dur, f11/~icd6,     \vol, vol11,  \tune, tune);~l11f.set(\dur, f11/~icd6,  \vol, vol11, \tune, tune);
				~l12a.set(\dur, f12,  \vol, vol12,  \tune, tune);         ~l12b.set(\dur, f12,  \vol, vol12, \tune, tune);
				~l12c.set(\dur, f12/~icd3,     \vol, vol12,  \tune, tune);~l12d.set(\dur, f12/~icd3,  \vol, vol12, \tune, tune);
				~l12e.set(\dur, f12/~icd6,     \vol, vol12,  \tune, tune);~l12f.set(\dur, f12/~icd6,  \vol, vol12, \tune, tune);
			}););

			(
				1.do({var vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8,vol9,vol10,vol11,vol12,s1,s2,s3,s4,s5,s6,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,tune=0;
					#vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8,vol9,vol10,vol11,vol12 = [~vol1,~vol2,~vol3,~vol4,~vol5,~vol6,~vol7,~vol8,~vol9,~vol10,~vol11,~vol12];
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
					~l8a1 = Synth(s1, [\dur, ~f8,    \vol, vol8, \tune, tune]);       ~l8b1 = Synth(s2, [\dur, ~f8,   \vol, vol8, \tune, tune]);
					~l8c1 = Synth(s3, [\dur, ~f8/~icd3,  \vol, vol8, \tune, tune]);   ~l8d1 = Synth(s4, [\dur, ~f8/~icd3, \vol, vol8, \tune, tune]);
					~l8e1 = Synth(s5, [\dur, ~f8/~icd6,  \vol, vol8, \tune, tune]);   ~l8f1 = Synth(s6, [\dur, ~f8/~icd6, \vol, vol8, \tune, tune]);
					~l9a1 = Synth(s1, [\dur, ~f9,    \vol, vol9, \tune, tune]);       ~l9b1 = Synth(s2, [\dur, ~f9,   \vol, vol9, \tune, tune]);
					~l9c1 = Synth(s3, [\dur, ~f9/~icd3,  \vol, vol9, \tune, tune]);   ~l9d1 = Synth(s4, [\dur, ~f9/~icd3, \vol, vol9, \tune, tune]);
					~l9e1 = Synth(s5, [\dur, ~f9/~icd6,  \vol, vol9, \tune, tune]);   ~l9f1 = Synth(s6, [\dur, ~f9/~icd6, \vol, vol9, \tune, tune]);
					~l10a1 = Synth(s1, [\dur,~f10,  \vol, vol10, \tune, tune]);       ~l10b1 = Synth(s2, [\dur, ~f10, \vol, vol10, \tune, tune]);
					~l10c1 = Synth(s3, [\dur, ~f10/~icd3,  \vol, vol10, \tune, tune]);~l10d1 = Synth(s4, [\dur, ~f10/~icd3,  \vol, vol10, \tune, tune]);
					~l10e1 = Synth(s5, [\dur, ~f10/~icd6,  \vol, vol10, \tune, tune]);~l10f1 = Synth(s6, [\dur, ~f10/~icd6,  \vol, vol10, \tune, tune]);
					~l11a1 = Synth(s1, [\dur,~f11,   \vol, vol11, \tune, tune]);      ~l11b1 = Synth(s2, [\dur, ~f11,    \vol, vol11, \tune, tune]);
					~l11c1 = Synth(s3, [\dur, ~f11/~icd3,  \vol, vol11, \tune, tune]);~l11d1 = Synth(s4, [\dur, ~f11/~icd3,  \vol, vol11, \tune, tune]);
					~l11e1 = Synth(s5, [\dur, ~f11/~icd6,  \vol, vol11, \tune, tune]);~l11f1 = Synth(s6, [\dur, ~f11/~icd6,  \vol, vol11, \tune, tune]);
					~l12a1 = Synth(s1, [\dur,~f12,   \vol, vol12, \tune, tune]);      ~l12b1 = Synth(s2, [\dur, ~f12,    \vol, vol12, \tune, tune]);
					~l12c1 = Synth(s3, [\dur, ~f12/~icd3,  \vol, vol12, \tune, tune]);~l12d1 = Synth(s4, [\dur, ~f12/~icd3,  \vol, vol12, \tune, tune]);
					~l12e1 = Synth(s5, [\dur, ~f12/~icd6,  \vol, vol12, \tune, tune]);~l12f1 = Synth(s6, [\dur, ~f12/~icd6,  \vol, vol12, \tune, tune]);

				});
			);
			AppClock.sched(0.161803398875,{
				([~l1a,~l1b,~l1c,~l1d,~l1e,~l1f,~l2a,~l2b,~l2c,~l2d,~l2e,~l2f,~l3a,~l3b,~l3c,~l3d,~l3e,~l3f,~l4a,~l4b,~l4c,~l4d,~l4e,~l4f,~l5a,~l5b,~l5c,~l5d,~l5e,~l5f,~l6a,~l6b,~l6c,~l6d,~l6e,~l6f,~l7a,~l7b,~l7c,~l7d,~l7e,~l7f,~l8a,~l8b,~l8c,~l8d,~l8e,~l8f,~l9a,~l9b,~l9c,~l9d,~l9e,~l9f,~l10a,~l10b,~l10c,~l10d,~l10e,~l10f,~l11a,~l11b,~l11c,~l11d,~l11e,~l11f,~l12a,~l12b,~l12c,~l12d,~l12e,~l12f].do(_.free)); ~slideroutine.stop;
			});
		};

		if((~f1 > ~outmaxa) or: (~f1 < ~outmina), {~z25.close;~z1.close;~z25 = (CompositeView(w, Rect((~f1.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+10, ~nw, 2)).background = Color.white;);}, {~z1.close;~z25.close;~z1 = (CompositeView(w, Rect((~f1.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+10, ~nw, 2)).background = Color.white;);});
		if((~f2 > ~outmaxa) or: (~f2 < ~outmina), {~z26.close;~z2.close;~z26 = (CompositeView(w, Rect((~f2.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+20, ~nw, 2)).background = Color.white;);}, {~z2.close;~z26.close;~z2 = (CompositeView(w, Rect((~f2.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+20, ~nw, 2)).background = Color.white;);});
		if((~f3 > ~outmaxa) or: (~f3 < ~outmina), {~z27.close;~z3.close;~z27 = (CompositeView(w, Rect((~f3.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+30, ~nw, 2)).background = Color.white;);}, {~z3.close;~z27.close;~z3 = (CompositeView(w, Rect((~f3.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+30, ~nw, 2)).background = Color.white;);});
		if((~f4 > ~outmaxa) or: (~f4 < ~outmina), {~z28.close;~z4.close;~z28 = (CompositeView(w, Rect((~f4.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+40, ~nw, 2)).background = Color.white;);}, {~z4.close;~z28.close;~z4 = (CompositeView(w, Rect((~f4.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+40, ~nw, 2)).background = Color.white;);});
		if((~f5 > ~outmaxa) or: (~f5 < ~outmina), {~z29.close;~z5.close;~z29 = (CompositeView(w, Rect((~f5.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+50, ~nw, 2)).background = Color.white;);}, {~z5.close;~z29.close;~z5 = (CompositeView(w, Rect((~f5.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+50, ~nw, 2)).background = Color.white;);});
		if((~f6 > ~outmaxa) or: (~f6 < ~outmina), {~z30.close;~z6.close;~z30 = (CompositeView(w, Rect((~f6.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+60, ~nw, 2)).background = Color.white;);}, {~z6.close;~z30.close;~z6 = (CompositeView(w, Rect((~f6.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+60, ~nw, 2)).background = Color.white;);});
		if((~f7 > ~outmaxa) or: (~f7 < ~outmina), {~z31.close;~z7.close;~z31 = (CompositeView(w, Rect((~f7.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+70, ~nw, 2)).background = Color.white;);}, {~z7.close;~z31.close;~z7 = (CompositeView(w, Rect((~f7.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+70, ~nw, 2)).background = Color.white;);});
		if((~f8 > ~outmaxa) or: (~f8 < ~outmina), {~z32.close;~z8.close;~z32 = (CompositeView(w, Rect((~f8.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+80, ~nw, 2)).background = Color.white;);}, {~z8.close;~z32.close;~z8 = (CompositeView(w, Rect((~f8.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+80, ~nw, 2)).background = Color.white;);});
		if((~f9 > ~outmaxa) or: (~f9 < ~outmina), {~z33.close;~z9.close;~z33 = (CompositeView(w, Rect((~f9.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+90, ~nw, 2)).background = Color.white;);}, {~z9.close;~z33.close;~z9 = (CompositeView(w, Rect((~f9.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+90, ~nw, 2)).background = Color.white;);});
		if((~f10 > ~outmaxa) or: (~f10 < ~outmina), {~z34.close;~z10.close;~z34 = (CompositeView(w, Rect((~f10.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+100, ~nw, 2)).background = Color.white;);}, {~z10.close;~z34.close;~z10 = (CompositeView(w, Rect((~f10.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+100, ~nw, 2)).background = Color.white;);});
		if((~f11 > ~outmaxa) or: (~f11 < ~outmina), {~z35.close;~z11.close;~z35 = (CompositeView(w, Rect((~f11.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+110, ~nw, 2)).background = Color.white;);}, {~z11.close;~z35.close;~z11 = (CompositeView(w, Rect((~f11.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+110, ~nw, 2)).background = Color.white;);});
		if((~f12 > ~outmaxa) or: (~f12 < ~outmina), {~z36.close;~z12.close;~z36 = (CompositeView(w, Rect((~f12.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+120, ~nw, 2)).background = Color.white;);}, {~z12.close;~z36.close;~z12 = (CompositeView(w, Rect((~f12.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+120, ~nw, 2)).background = Color.white;);});

		b3.value = 1;
	};

	~synthflow = {
		case
		{~l1a1.isRunning == true}{
			(1.do({var vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8,vol9,vol10,vol11,vol12,s1,s2,s3,s4,s5,s6,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,tune=0;
				#vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8,vol9,vol10,vol11,vol12 = [~vol1,~vol2,~vol3,~vol4,~vol5,~vol6,~vol7,~vol8,~vol9,~vol10,~vol11,~vol12];
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
				~l9a1.set(\dur, ~f9,    \vol, vol9,  \tune, tune);          ~l9b1.set(\dur, ~f9,  \vol, vol9, \tune, tune);
				~l9c1.set(\dur, ~f9/~icd3,       \vol, vol9,  \tune, tune); ~l9d1.set(\dur, ~f9/~icd3,  \vol, vol9, \tune, tune);
				~l9e1.set(\dur, ~f9/~icd6,       \vol, vol9,  \tune, tune); ~l9f1.set(\dur, ~f9/~icd6,  \vol, vol9, \tune, tune);
				~l10a1.set(\dur, ~f10,  \vol, vol10,  \tune, tune);         ~l10b1.set(\dur, ~f10,  \vol, vol10, \tune, tune);
				~l10c1.set(\dur, ~f10/~icd3,     \vol, vol10,  \tune, tune);~l10d1.set(\dur, ~f10/~icd3,  \vol, vol10, \tune, tune);
				~l10e1.set(\dur, ~f10/~icd6,     \vol, vol10,  \tune, tune);~l10f1.set(\dur, ~f10/~icd6,  \vol, vol10, \tune, tune);
				~l11a1.set(\dur, ~f11,  \vol, vol11,  \tune, tune);         ~l11b1.set(\dur, ~f11,  \vol, vol11, \tune, tune);
				~l11c1.set(\dur, ~f11/~icd3,     \vol, vol11,  \tune, tune);~l11d1.set(\dur, ~f11/~icd3,  \vol, vol11, \tune, tune);
				~l11e1.set(\dur, ~f11/~icd6,     \vol, vol11,  \tune, tune);~l11f1.set(\dur, ~f11/~icd6,  \vol, vol11, \tune, tune);
				~l12a1.set(\dur, ~f12,  \vol, vol12,  \tune, tune);         ~l12b1.set(\dur, ~f12,  \vol, vol12, \tune, tune);
				~l12c1.set(\dur, ~f12/~icd3,     \vol, vol12,  \tune, tune);~l12d1.set(\dur, ~f12/~icd3,  \vol, vol12, \tune, tune);
				~l12e1.set(\dur, ~f12/~icd6,     \vol, vol12,  \tune, tune);~l12f1.set(\dur, ~f12/~icd6,  \vol, vol12, \tune, tune);
			}););
		}
		{~l1a.isRunning == true} {
			(1.do({var vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8,vol9,vol10,vol11,vol12,s1,s2,s3,s4,s5,s6,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,tune=0;
				#vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8,vol9,vol10,vol11,vol12 = [~vol1,~vol2,~vol3,~vol4,~vol5,~vol6,~vol7,~vol8,~vol9,~vol10,~vol11,~vol12];
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
				~l9a.set(\dur, ~f9,    \vol, vol9,  \tune, tune);          ~l9b.set(\dur, ~f9,  \vol, vol9, \tune, tune);
				~l9c.set(\dur, ~f9/~icd3,       \vol, vol9,  \tune, tune); ~l9d.set(\dur, ~f9/~icd3,  \vol, vol9, \tune, tune);
				~l9e.set(\dur, ~f9/~icd6,       \vol, vol9,  \tune, tune); ~l9f.set(\dur, ~f9/~icd6,  \vol, vol9, \tune, tune);
				~l10a.set(\dur, ~f10,  \vol, vol10,  \tune, tune);         ~l10b.set(\dur, ~f10,  \vol, vol10, \tune, tune);
				~l10c.set(\dur, ~f10/~icd3,     \vol, vol10,  \tune, tune);~l10d.set(\dur, ~f10/~icd3,  \vol, vol10, \tune, tune);
				~l10e.set(\dur, ~f10/~icd6,     \vol, vol10,  \tune, tune);~l10f.set(\dur, ~f10/~icd6,  \vol, vol10, \tune, tune);
				~l11a.set(\dur, ~f11,  \vol, vol11,  \tune, tune);         ~l11b.set(\dur, ~f11,  \vol, vol11, \tune, tune);
				~l11c.set(\dur, ~f11/~icd3,     \vol, vol11,  \tune, tune);~l11d.set(\dur, ~f11/~icd3,  \vol, vol11, \tune, tune);
				~l11e.set(\dur, ~f11/~icd6,     \vol, vol11,  \tune, tune);~l11f.set(\dur, ~f11/~icd6,  \vol, vol11, \tune, tune);
				~l12a.set(\dur, ~f12,  \vol, vol12,  \tune, tune);         ~l12b.set(\dur, ~f12,  \vol, vol12, \tune, tune);
				~l12c.set(\dur, ~f12/~icd3,     \vol, vol12,  \tune, tune);~l12d.set(\dur, ~f12/~icd3,  \vol, vol12, \tune, tune);
				~l12e.set(\dur, ~f12/~icd6,     \vol, vol12,  \tune, tune);~l12f.set(\dur, ~f12/~icd6,  \vol, vol12, \tune, tune);

			}););
		};

		if((~f1 > ~outmaxa) or: (~f1 < ~outmina), {~z25.close;~z1.close;~z25 = (CompositeView(w, Rect((~f1.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+10, ~nw, 2)).background = Color.white;);}, {~z1.close;~z25.close;~z1 = (CompositeView(w, Rect((~f1.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+10, ~nw, 2)).background = Color.white;);});
		if((~f2 > ~outmaxa) or: (~f2 < ~outmina), {~z26.close;~z2.close;~z26 = (CompositeView(w, Rect((~f2.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+20, ~nw, 2)).background = Color.white;);}, {~z2.close;~z26.close;~z2 = (CompositeView(w, Rect((~f2.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+20, ~nw, 2)).background = Color.white;);});
		if((~f3 > ~outmaxa) or: (~f3 < ~outmina), {~z27.close;~z3.close;~z27 = (CompositeView(w, Rect((~f3.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+30, ~nw, 2)).background = Color.white;);}, {~z3.close;~z27.close;~z3 = (CompositeView(w, Rect((~f3.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+30, ~nw, 2)).background = Color.white;);});
		if((~f4 > ~outmaxa) or: (~f4 < ~outmina), {~z28.close;~z4.close;~z28 = (CompositeView(w, Rect((~f4.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+40, ~nw, 2)).background = Color.white;);}, {~z4.close;~z28.close;~z4 = (CompositeView(w, Rect((~f4.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+40, ~nw, 2)).background = Color.white;);});
		if((~f5 > ~outmaxa) or: (~f5 < ~outmina), {~z29.close;~z5.close;~z29 = (CompositeView(w, Rect((~f5.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+50, ~nw, 2)).background = Color.white;);}, {~z5.close;~z29.close;~z5 = (CompositeView(w, Rect((~f5.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+50, ~nw, 2)).background = Color.white;);});
		if((~f6 > ~outmaxa) or: (~f6 < ~outmina), {~z30.close;~z6.close;~z30 = (CompositeView(w, Rect((~f6.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+60, ~nw, 2)).background = Color.white;);}, {~z6.close;~z30.close;~z6 = (CompositeView(w, Rect((~f6.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+60, ~nw, 2)).background = Color.white;);});
		if((~f7 > ~outmaxa) or: (~f7 < ~outmina), {~z31.close;~z7.close;~z31 = (CompositeView(w, Rect((~f7.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+70, ~nw, 2)).background = Color.white;);}, {~z7.close;~z31.close;~z7 = (CompositeView(w, Rect((~f7.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+70, ~nw, 2)).background = Color.white;);});
		if((~f8 > ~outmaxa) or: (~f8 < ~outmina), {~z32.close;~z8.close;~z32 = (CompositeView(w, Rect((~f8.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+80, ~nw, 2)).background = Color.white;);}, {~z8.close;~z32.close;~z8 = (CompositeView(w, Rect((~f8.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+80, ~nw, 2)).background = Color.white;);});
		if((~f9 > ~outmaxa) or: (~f9 < ~outmina), {~z33.close;~z9.close;~z33 = (CompositeView(w, Rect((~f9.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+90, ~nw, 2)).background = Color.white;);}, {~z9.close;~z33.close;~z9 = (CompositeView(w, Rect((~f9.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+90, ~nw, 2)).background = Color.white;);});
		if((~f10 > ~outmaxa) or: (~f10 < ~outmina), {~z34.close;~z10.close;~z34 = (CompositeView(w, Rect((~f10.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+100, ~nw, 2)).background = Color.white;);}, {~z10.close;~z34.close;~z10 = (CompositeView(w, Rect((~f10.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+100, ~nw, 2)).background = Color.white;);});
		if((~f11 > ~outmaxa) or: (~f11 < ~outmina), {~z35.close;~z11.close;~z35 = (CompositeView(w, Rect((~f11.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+110, ~nw, 2)).background = Color.white;);}, {~z11.close;~z35.close;~z11 = (CompositeView(w, Rect((~f11.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+110, ~nw, 2)).background = Color.white;);});
		if((~f12 > ~outmaxa) or: (~f12 < ~outmina), {~z36.close;~z12.close;~z36 = (CompositeView(w, Rect((~f12.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+120, ~nw, 2)).background = Color.white;);}, {~z12.close;~z36.close;~z12 = (CompositeView(w, Rect((~f12.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+120, ~nw, 2)).background = Color.white;);});

	};

	~synthslide = {
		case
		{~l1a1.isRunning == true}{(//fprog
			~slideroutine = Routine({1.do({var vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8,vol9,vol10,vol11,vol12,s1,s2,s3,s4,s5,s6,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,tune=0;
				#vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8,vol9,vol10,vol11,vol12 = [~vol1,~vol2,~vol3,~vol4,~vol5,~vol6,~vol7,~vol8,~vol9,~vol10,~vol11,~vol12];
				~slidedo.do({~slidecount=~slidecount-1;
					(
						[ ~f1=~f1+g,~f2=~f2+h,~f3=~f3+i,~f4=~f4+j,~f5=~f5+k,~f6=~f6+l,~f7=~f7+m,~f8=~f8+n,~f9=~f9+o,~f10=~f10+p,~f11=~f11+q,~f12=~f12+r ];
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
						~l9a1.set(\dur, ~f9,    \vol, vol9,  \tune, tune);          ~l9b1.set(\dur, ~f9,  \vol, vol9, \tune, tune);
						~l9c1.set(\dur, ~f9/~icd3,       \vol, vol9,  \tune, tune); ~l9d1.set(\dur, ~f9/~icd3,  \vol, vol9, \tune, tune);
						~l9e1.set(\dur, ~f9/~icd6,       \vol, vol9,  \tune, tune); ~l9f1.set(\dur, ~f9/~icd6,  \vol, vol9, \tune, tune);
						~l10a1.set(\dur, ~f10,  \vol, vol10,  \tune, tune);         ~l10b1.set(\dur, ~f10,  \vol, vol10, \tune, tune);
						~l10c1.set(\dur, ~f10/~icd3,     \vol, vol10,  \tune, tune);~l10d1.set(\dur, ~f10/~icd3,  \vol, vol10, \tune, tune);
						~l10e1.set(\dur, ~f10/~icd6,     \vol, vol10,  \tune, tune);~l10f1.set(\dur, ~f10/~icd6,  \vol, vol10, \tune, tune);
						~l11a1.set(\dur, ~f11,  \vol, vol11,  \tune, tune);         ~l11b1.set(\dur, ~f11,  \vol, vol11, \tune, tune);
						~l11c1.set(\dur, ~f11/~icd3,     \vol, vol11,  \tune, tune);~l11d1.set(\dur, ~f11/~icd3,  \vol, vol11, \tune, tune);
						~l11e1.set(\dur, ~f11/~icd6,     \vol, vol11,  \tune, tune);~l11f1.set(\dur, ~f11/~icd6,  \vol, vol11, \tune, tune);
						~l12a1.set(\dur, ~f12,  \vol, vol12,  \tune, tune);         ~l12b1.set(\dur, ~f12,  \vol, vol12, \tune, tune);
						~l12c1.set(\dur, ~f12/~icd3,     \vol, vol12,  \tune, tune);~l12d1.set(\dur, ~f12/~icd3,  \vol, vol12, \tune, tune);
						~l12e1.set(\dur, ~f12/~icd6,     \vol, vol12,  \tune, tune);~l12f1.set(\dur, ~f12/~icd6,  \vol, vol12, \tune, tune);

					);

					{if(~slidecount==0,{
						if((~f1 > ~outmaxa) or: (~f1 < ~outmina), {~z25.close;~z1.close;~z25 = (CompositeView(w, Rect((~f1.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+10, ~nw, 2)).background = Color.white;);}, {~z1.close;~z25.close;~z1 = (CompositeView(w, Rect((~f1.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+10, ~nw, 2)).background = Color.white;);});
						if((~f2 > ~outmaxa) or: (~f2 < ~outmina), {~z26.close;~z2.close;~z26 = (CompositeView(w, Rect((~f2.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+20, ~nw, 2)).background = Color.white;);}, {~z2.close;~z26.close;~z2 = (CompositeView(w, Rect((~f2.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+20, ~nw, 2)).background = Color.white;);});
						if((~f3 > ~outmaxa) or: (~f3 < ~outmina), {~z27.close;~z3.close;~z27 = (CompositeView(w, Rect((~f3.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+30, ~nw, 2)).background = Color.white;);}, {~z3.close;~z27.close;~z3 = (CompositeView(w, Rect((~f3.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+30, ~nw, 2)).background = Color.white;);});
						if((~f4 > ~outmaxa) or: (~f4 < ~outmina), {~z28.close;~z4.close;~z28 = (CompositeView(w, Rect((~f4.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+40, ~nw, 2)).background = Color.white;);}, {~z4.close;~z28.close;~z4 = (CompositeView(w, Rect((~f4.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+40, ~nw, 2)).background = Color.white;);});
						if((~f5 > ~outmaxa) or: (~f5 < ~outmina), {~z29.close;~z5.close;~z29 = (CompositeView(w, Rect((~f5.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+50, ~nw, 2)).background = Color.white;);}, {~z5.close;~z29.close;~z5 = (CompositeView(w, Rect((~f5.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+50, ~nw, 2)).background = Color.white;);});
						if((~f6 > ~outmaxa) or: (~f6 < ~outmina), {~z30.close;~z6.close;~z30 = (CompositeView(w, Rect((~f6.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+60, ~nw, 2)).background = Color.white;);}, {~z6.close;~z30.close;~z6 = (CompositeView(w, Rect((~f6.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+60, ~nw, 2)).background = Color.white;);});
						if((~f7 > ~outmaxa) or: (~f7 < ~outmina), {~z31.close;~z7.close;~z31 = (CompositeView(w, Rect((~f7.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+70, ~nw, 2)).background = Color.white;);}, {~z7.close;~z31.close;~z7 = (CompositeView(w, Rect((~f7.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+70, ~nw, 2)).background = Color.white;);});
						if((~f8 > ~outmaxa) or: (~f8 < ~outmina), {~z32.close;~z8.close;~z32 = (CompositeView(w, Rect((~f8.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+80, ~nw, 2)).background = Color.white;);}, {~z8.close;~z32.close;~z8 = (CompositeView(w, Rect((~f8.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+80, ~nw, 2)).background = Color.white;);});
						if((~f9 > ~outmaxa) or: (~f9 < ~outmina), {~z33.close;~z9.close;~z33 = (CompositeView(w, Rect((~f9.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+90, ~nw, 2)).background = Color.white;);}, {~z9.close;~z33.close;~z9 = (CompositeView(w, Rect((~f9.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+90, ~nw, 2)).background = Color.white;);});
						if((~f10 > ~outmaxa) or: (~f10 < ~outmina), {~z34.close;~z10.close;~z34 = (CompositeView(w, Rect((~f10.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+100, ~nw, 2)).background = Color.white;);}, {~z10.close;~z34.close;~z10 = (CompositeView(w, Rect((~f10.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+100, ~nw, 2)).background = Color.white;);});
						if((~f11 > ~outmaxa) or: (~f11 < ~outmina), {~z35.close;~z11.close;~z35 = (CompositeView(w, Rect((~f11.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+110, ~nw, 2)).background = Color.white;);}, {~z11.close;~z35.close;~z11 = (CompositeView(w, Rect((~f11.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+110, ~nw, 2)).background = Color.white;);});
						if((~f12 > ~outmaxa) or: (~f12 < ~outmina), {~z36.close;~z12.close;~z36 = (CompositeView(w, Rect((~f12.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+120, ~nw, 2)).background = Color.white;);}, {~z12.close;~z36.close;~z12 = (CompositeView(w, Rect((~f12.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+120, ~nw, 2)).background = Color.white;);});
					});}.defer;

					(~slidetime/~slidedo).wait;});});}).play;);}
		{~l1a.isRunning == true} {(//fprog
			~slideroutine = Routine({1.do({var vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8,vol9,vol10,vol11,vol12,s1,s2,s3,s4,s5,s6,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,tune=0;
				#vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8,vol9,vol10,vol11,vol12 = [~vol1,~vol2,~vol3,~vol4,~vol5,~vol6,~vol7,~vol8,~vol9,~vol10,~vol11,~vol12];
				~slidedo.do({~slidecount=~slidecount-1;
					(
						[ ~f1=~f1+g,~f2=~f2+h,~f3=~f3+i,~f4=~f4+j,~f5=~f5+k,~f6=~f6+l,~f7=~f7+m,~f8=~f8+n,~f9=~f9+o,~f10=~f10+p,~f11=~f11+q,~f12=~f12+r ];
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
						~l9a.set(\dur, ~f9,    \vol, vol9,  \tune, tune);          ~l9b.set(\dur, ~f9,  \vol, vol9, \tune, tune);
						~l9c.set(\dur, ~f9/~icd3,       \vol, vol9,  \tune, tune); ~l9d.set(\dur, ~f9/~icd3,  \vol, vol9, \tune, tune);
						~l9e.set(\dur, ~f9/~icd6,       \vol, vol9,  \tune, tune); ~l9f.set(\dur, ~f9/~icd6,  \vol, vol9, \tune, tune);
						~l10a.set(\dur, ~f10,  \vol, vol10,  \tune, tune);         ~l10b.set(\dur, ~f10,  \vol, vol10, \tune, tune);
						~l10c.set(\dur, ~f10/~icd3,     \vol, vol10,  \tune, tune);~l10d.set(\dur, ~f10/~icd3,  \vol, vol10, \tune, tune);
						~l10e.set(\dur, ~f10/~icd6,     \vol, vol10,  \tune, tune);~l10f.set(\dur, ~f10/~icd6,  \vol, vol10, \tune, tune);
						~l11a.set(\dur, ~f11,  \vol, vol11,  \tune, tune);         ~l11b.set(\dur, ~f11,  \vol, vol11, \tune, tune);
						~l11c.set(\dur, ~f11/~icd3,     \vol, vol11,  \tune, tune);~l11d.set(\dur, ~f11/~icd3,  \vol, vol11, \tune, tune);
						~l11e.set(\dur, ~f11/~icd6,     \vol, vol11,  \tune, tune);~l11f.set(\dur, ~f11/~icd6,  \vol, vol11, \tune, tune);
						~l12a.set(\dur, ~f12,  \vol, vol12,  \tune, tune);         ~l12b.set(\dur, ~f12,  \vol, vol12, \tune, tune);
						~l12c.set(\dur, ~f12/~icd3,     \vol, vol12,  \tune, tune);~l12d.set(\dur, ~f12/~icd3,  \vol, vol12, \tune, tune);
						~l12e.set(\dur, ~f12/~icd6,     \vol, vol12,  \tune, tune);~l12f.set(\dur, ~f12/~icd6,  \vol, vol12, \tune, tune);


					);

					{if(~slidecount==0,{
						if((~f1 > ~outmaxa) or: (~f1 < ~outmina), {~z25.close;~z1.close;~z25 = (CompositeView(w, Rect((~f1.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+10, ~nw, 2)).background = Color.white;);}, {~z1.close;~z25.close;~z1 = (CompositeView(w, Rect((~f1.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+10, ~nw, 2)).background = Color.white;);});
						if((~f2 > ~outmaxa) or: (~f2 < ~outmina), {~z26.close;~z2.close;~z26 = (CompositeView(w, Rect((~f2.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+20, ~nw, 2)).background = Color.white;);}, {~z2.close;~z26.close;~z2 = (CompositeView(w, Rect((~f2.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+20, ~nw, 2)).background = Color.white;);});
						if((~f3 > ~outmaxa) or: (~f3 < ~outmina), {~z27.close;~z3.close;~z27 = (CompositeView(w, Rect((~f3.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+30, ~nw, 2)).background = Color.white;);}, {~z3.close;~z27.close;~z3 = (CompositeView(w, Rect((~f3.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+30, ~nw, 2)).background = Color.white;);});
						if((~f4 > ~outmaxa) or: (~f4 < ~outmina), {~z28.close;~z4.close;~z28 = (CompositeView(w, Rect((~f4.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+40, ~nw, 2)).background = Color.white;);}, {~z4.close;~z28.close;~z4 = (CompositeView(w, Rect((~f4.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+40, ~nw, 2)).background = Color.white;);});
						if((~f5 > ~outmaxa) or: (~f5 < ~outmina), {~z29.close;~z5.close;~z29 = (CompositeView(w, Rect((~f5.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+50, ~nw, 2)).background = Color.white;);}, {~z5.close;~z29.close;~z5 = (CompositeView(w, Rect((~f5.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+50, ~nw, 2)).background = Color.white;);});
						if((~f6 > ~outmaxa) or: (~f6 < ~outmina), {~z30.close;~z6.close;~z30 = (CompositeView(w, Rect((~f6.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+60, ~nw, 2)).background = Color.white;);}, {~z6.close;~z30.close;~z6 = (CompositeView(w, Rect((~f6.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+60, ~nw, 2)).background = Color.white;);});
						if((~f7 > ~outmaxa) or: (~f7 < ~outmina), {~z31.close;~z7.close;~z31 = (CompositeView(w, Rect((~f7.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+70, ~nw, 2)).background = Color.white;);}, {~z7.close;~z31.close;~z7 = (CompositeView(w, Rect((~f7.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+70, ~nw, 2)).background = Color.white;);});
						if((~f8 > ~outmaxa) or: (~f8 < ~outmina), {~z32.close;~z8.close;~z32 = (CompositeView(w, Rect((~f8.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+80, ~nw, 2)).background = Color.white;);}, {~z8.close;~z32.close;~z8 = (CompositeView(w, Rect((~f8.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+80, ~nw, 2)).background = Color.white;);});
						if((~f9 > ~outmaxa) or: (~f9 < ~outmina), {~z33.close;~z9.close;~z33 = (CompositeView(w, Rect((~f9.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+90, ~nw, 2)).background = Color.white;);}, {~z9.close;~z33.close;~z9 = (CompositeView(w, Rect((~f9.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+90, ~nw, 2)).background = Color.white;);});
						if((~f10 > ~outmaxa) or: (~f10 < ~outmina), {~z34.close;~z10.close;~z34 = (CompositeView(w, Rect((~f10.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+100, ~nw, 2)).background = Color.white;);}, {~z10.close;~z34.close;~z10 = (CompositeView(w, Rect((~f10.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+100, ~nw, 2)).background = Color.white;);});
						if((~f11 > ~outmaxa) or: (~f11 < ~outmina), {~z35.close;~z11.close;~z35 = (CompositeView(w, Rect((~f11.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+110, ~nw, 2)).background = Color.white;);}, {~z11.close;~z35.close;~z11 = (CompositeView(w, Rect((~f11.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+110, ~nw, 2)).background = Color.white;);});
						if((~f12 > ~outmaxa) or: (~f12 < ~outmina), {~z36.close;~z12.close;~z36 = (CompositeView(w, Rect((~f12.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+120, ~nw, 2)).background = Color.white;);}, {~z12.close;~z36.close;~z12 = (CompositeView(w, Rect((~f12.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+120, ~nw, 2)).background = Color.white;);});
					});}.defer;

					(~slidetime/~slidedo).wait;});});}).play;);};
	};

	~synthpause = {(
		case
		{~l1a1.isRunning == true}{
			(1.do({var vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8,vol9,vol10,vol11,vol12,s1,s2,s3,s4,s5,s6,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,tune=0;
				#vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8,vol9,vol10,vol11,vol12 = [~vol1,~vol2,~vol3,~vol4,~vol5,~vol6,~vol7,~vol8,~vol9,~vol10,~vol11,~vol12];
				#f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12 = [ 0,0,0,0,0,0,0,0,0,0,0,0 ];
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
				~l9a1.set(\dur, f9,    \vol, vol9,  \tune, tune);          ~l9b1.set(\dur, f9,  \vol, vol9, \tune, tune);
				~l9c1.set(\dur, f9/~icd3,       \vol, vol9,  \tune, tune); ~l9d1.set(\dur, f9/~icd3,  \vol, vol9, \tune, tune);
				~l9e1.set(\dur, f9/~icd6,       \vol, vol9,  \tune, tune); ~l9f1.set(\dur, f9/~icd6,  \vol, vol9, \tune, tune);
				~l10a1.set(\dur, f10,  \vol, vol10,  \tune, tune);         ~l10b1.set(\dur, f10,  \vol, vol10, \tune, tune);
				~l10c1.set(\dur, f10/~icd3,     \vol, vol10,  \tune, tune);~l10d1.set(\dur, f10/~icd3,  \vol, vol10, \tune, tune);
				~l10e1.set(\dur, f10/~icd6,     \vol, vol10,  \tune, tune);~l10f1.set(\dur, f10/~icd6,  \vol, vol10, \tune, tune);
				~l11a1.set(\dur, f11,  \vol, vol11,  \tune, tune);         ~l11b1.set(\dur, f11,  \vol, vol11, \tune, tune);
				~l11c1.set(\dur, f11/~icd3,     \vol, vol11,  \tune, tune);~l11d1.set(\dur, f11/~icd3,  \vol, vol11, \tune, tune);
				~l11e1.set(\dur, f11/~icd6,     \vol, vol11,  \tune, tune);~l11f1.set(\dur, f11/~icd6,  \vol, vol11, \tune, tune);
				~l12a1.set(\dur, f12,  \vol, vol12,  \tune, tune);         ~l12b1.set(\dur, f12,  \vol, vol12, \tune, tune);
				~l12c1.set(\dur, f12/~icd3,     \vol, vol12,  \tune, tune);~l12d1.set(\dur, f12/~icd3,  \vol, vol12, \tune, tune);
				~l12e1.set(\dur, f12/~icd6,     \vol, vol12,  \tune, tune);~l12f1.set(\dur, f12/~icd6,  \vol, vol12, \tune, tune);
			}););
		}
		{~l1a.isRunning == true} {
			(1.do({var vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8,vol9,vol10,vol11,vol12,s1,s2,s3,s4,s5,s6,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,tune=0;
				#vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8,vol9,vol10,vol11,vol12 = [~vol1,~vol2,~vol3,~vol4,~vol5,~vol6,~vol7,~vol8,~vol9,~vol10,~vol11,~vol12];
				#f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12 = [ 0,0,0,0,0,0,0,0,0,0,0,0 ];
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
				~l9a.set(\dur, f9,    \vol, vol9,  \tune, tune);          ~l9b.set(\dur, f9,  \vol, vol9, \tune, tune);
				~l9c.set(\dur, f9/~icd3,       \vol, vol9,  \tune, tune); ~l9d.set(\dur, f9/~icd3,  \vol, vol9, \tune, tune);
				~l9e.set(\dur, f9/~icd6,       \vol, vol9,  \tune, tune); ~l9f.set(\dur, f9/~icd6,  \vol, vol9, \tune, tune);
				~l10a.set(\dur, f10,  \vol, vol10,  \tune, tune);         ~l10b.set(\dur, f10,  \vol, vol10, \tune, tune);
				~l10c.set(\dur, f10/~icd3,     \vol, vol10,  \tune, tune);~l10d.set(\dur, f10/~icd3,  \vol, vol10, \tune, tune);
				~l10e.set(\dur, f10/~icd6,     \vol, vol10,  \tune, tune);~l10f.set(\dur, f10/~icd6,  \vol, vol10, \tune, tune);
				~l11a.set(\dur, f11,  \vol, vol11,  \tune, tune);         ~l11b.set(\dur, f11,  \vol, vol11, \tune, tune);
				~l11c.set(\dur, f11/~icd3,     \vol, vol11,  \tune, tune);~l11d.set(\dur, f11/~icd3,  \vol, vol11, \tune, tune);
				~l11e.set(\dur, f11/~icd6,     \vol, vol11,  \tune, tune);~l11f.set(\dur, f11/~icd6,  \vol, vol11, \tune, tune);
				~l12a.set(\dur, f12,  \vol, vol12,  \tune, tune);         ~l12b.set(\dur, f12,  \vol, vol12, \tune, tune);
				~l12c.set(\dur, f12/~icd3,     \vol, vol12,  \tune, tune);~l12d.set(\dur, f12/~icd3,  \vol, vol12, \tune, tune);
				~l12e.set(\dur, f12/~icd6,     \vol, vol12,  \tune, tune);~l12f.set(\dur, f12/~icd6,  \vol, vol12, \tune, tune);

			}););
		};
		);
	};

	~synthfree = {
		(
			case
			{((~l1a.isRunning == false) and: (~l1a1.isRunning == false)) or: ~l1a1.isRunning == true}{
				(1.do({var vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8,vol9,vol10,vol11,vol12,s1,s2,s3,s4,s5,s6,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,tune=0;
					#vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8,vol9,vol10,vol11,vol12 = [~vol1,~vol2,~vol3,~vol4,~vol5,~vol6,~vol7,~vol8,~vol9,~vol10,~vol11,~vol12];
					#f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12 = [ 0,0,0,0,0,0,0,0,0,0,0,0 ];
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
					~l9a1.set(\dur, f9,    \vol, vol9,  \tune, tune);          ~l9b1.set(\dur, f9,  \vol, vol9, \tune, tune);
					~l9c1.set(\dur, f9/~icd3,       \vol, vol9,  \tune, tune); ~l9d1.set(\dur, f9/~icd3,  \vol, vol9, \tune, tune);
					~l9e1.set(\dur, f9/~icd6,       \vol, vol9,  \tune, tune); ~l9f1.set(\dur, f9/~icd6,  \vol, vol9, \tune, tune);
					~l10a1.set(\dur, f10,  \vol, vol10,  \tune, tune);         ~l10b1.set(\dur, f10,  \vol, vol10, \tune, tune);
					~l10c1.set(\dur, f10/~icd3,     \vol, vol10,  \tune, tune);~l10d1.set(\dur, f10/~icd3,  \vol, vol10, \tune, tune);
					~l10e1.set(\dur, f10/~icd6,     \vol, vol10,  \tune, tune);~l10f1.set(\dur, f10/~icd6,  \vol, vol10, \tune, tune);
					~l11a1.set(\dur, f11,  \vol, vol11,  \tune, tune);         ~l11b1.set(\dur, f11,  \vol, vol11, \tune, tune);
					~l11c1.set(\dur, f11/~icd3,     \vol, vol11,  \tune, tune);~l11d1.set(\dur, f11/~icd3,  \vol, vol11, \tune, tune);
					~l11e1.set(\dur, f11/~icd6,     \vol, vol11,  \tune, tune);~l11f1.set(\dur, f11/~icd6,  \vol, vol11, \tune, tune);
					~l12a1.set(\dur, f12,  \vol, vol12,  \tune, tune);         ~l12b1.set(\dur, f12,  \vol, vol12, \tune, tune);
					~l12c1.set(\dur, f12/~icd3,     \vol, vol12,  \tune, tune);~l12d1.set(\dur, f12/~icd3,  \vol, vol12, \tune, tune);
					~l12e1.set(\dur, f12/~icd6,     \vol, vol12,  \tune, tune);~l12f1.set(\dur, f12/~icd6,  \vol, vol12, \tune, tune);
				}););
				AppClock.sched(0.161803398875,{
					([~l1a1,~l1b1,~l1c1,~l1d1,~l1e1,~l1f1,~l2a1,~l2b1,~l2c1,~l2d1,~l2e1,~l2f1,~l3a1,~l3b1,~l3c1,~l3d1,~l3e1,~l3f1,~l4a1,~l4b1,~l4c1,~l4d1,~l4e1,~l4f1,~l5a1,~l5b1,~l5c1,~l5d1,~l5e1,~l5f1,~l6a1,~l6b1,~l6c1,~l6d1,~l6e1,~l6f1,~l7a1,~l7b1,~l7c1,~l7d1,~l7e1,~l7f1,~l8a1,~l8b1,~l8c1,~l8d1,~l8e1,~l8f1,~l9a1,~l9b1,~l9c1,~l9d1,~l9e1,~l9f1,~l10a1,~l10b1,~l10c1,~l10d1,~l10e1,~l10f1,~l11a1,~l11b1,~l11c1,~l11d1,~l11e1,~l11f1,~l12a1,~l12b1,~l12c1,~l12d1,~l12e1,~l12f1 ].do(_.free)); ~slideroutine.stop;
				});
			}
			{~l1a.isRunning == true}{
				(1.do({var vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8,vol9,vol10,vol11,vol12,s1,s2,s3,s4,s5,s6,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,tune=0;
					#vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8,vol9,vol10,vol11,vol12 = [~vol1,~vol2,~vol3,~vol4,~vol5,~vol6,~vol7,~vol8,~vol9,~vol10,~vol11,~vol12];
					#f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12 = [ 0,0,0,0,0,0,0,0,0,0,0,0 ];
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
					~l9a.set(\dur, f9,    \vol, vol9,  \tune, tune);          ~l9b.set(\dur, f9,  \vol, vol9, \tune, tune);
					~l9c.set(\dur, f9/~icd3,       \vol, vol9,  \tune, tune); ~l9d.set(\dur, f9/~icd3,  \vol, vol9, \tune, tune);
					~l9e.set(\dur, f9/~icd6,       \vol, vol9,  \tune, tune); ~l9f.set(\dur, f9/~icd6,  \vol, vol9, \tune, tune);
					~l10a.set(\dur, f10,  \vol, vol10,  \tune, tune);         ~l10b.set(\dur, f10,  \vol, vol10, \tune, tune);
					~l10c.set(\dur, f10/~icd3,     \vol, vol10,  \tune, tune);~l10d.set(\dur, f10/~icd3,  \vol, vol10, \tune, tune);
					~l10e.set(\dur, f10/~icd6,     \vol, vol10,  \tune, tune);~l10f.set(\dur, f10/~icd6,  \vol, vol10, \tune, tune);
					~l11a.set(\dur, f11,  \vol, vol11,  \tune, tune);         ~l11b.set(\dur, f11,  \vol, vol11, \tune, tune);
					~l11c.set(\dur, f11/~icd3,     \vol, vol11,  \tune, tune);~l11d.set(\dur, f11/~icd3,  \vol, vol11, \tune, tune);
					~l11e.set(\dur, f11/~icd6,     \vol, vol11,  \tune, tune);~l11f.set(\dur, f11/~icd6,  \vol, vol11, \tune, tune);
					~l12a.set(\dur, f12,  \vol, vol12,  \tune, tune);         ~l12b.set(\dur, f12,  \vol, vol12, \tune, tune);
					~l12c.set(\dur, f12/~icd3,     \vol, vol12,  \tune, tune);~l12d.set(\dur, f12/~icd3,  \vol, vol12, \tune, tune);
					~l12e.set(\dur, f12/~icd6,     \vol, vol12,  \tune, tune);~l12f.set(\dur, f12/~icd6,  \vol, vol12, \tune, tune);
				}););
				AppClock.sched(0.161803398875,{
					([~l1a,~l1b,~l1c,~l1d,~l1e,~l1f,~l2a,~l2b,~l2c,~l2d,~l2e,~l2f,~l3a,~l3b,~l3c,~l3d,~l3e,~l3f,~l4a,~l4b,~l4c,~l4d,~l4e,~l4f,~l5a,~l5b,~l5c,~l5d,~l5e,~l5f,~l6a,~l6b,~l6c,~l6d,~l6e,~l6f,~l7a,~l7b,~l7c,~l7d,~l7e,~l7f,~l8a,~l8b,~l8c,~l8d,~l8e,~l8f,~l9a,~l9b,~l9c,~l9d,~l9e,~l9f,~l10a,~l10b,~l10c,~l10d,~l10e,~l10f,~l11a,~l11b,~l11c,~l11d,~l11e,~l11f,~l12a,~l12b,~l12c,~l12d,~l12e,~l12f].do(_.free)); ~slideroutine.stop;
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
		~numsynths = Routine({inf.do({if((s.numSynths > 73) and: (3.wait; s.numSynths > 73) and: (6.wait; s.numSynths > 73), {

			AppClock.sched(0, {
				if(~numsynthmessage != nil, {~numsynthmessage.close;});
				~numsynthmessage = View(w, Rect(Window.screenBounds.width-(340+46),Window.screenBounds.height-(340+46/1.6180339887499)-110,340+46,340+46/1.6180339887499)).background_(Color.black).front;
				~numsynthmessagestring = StaticText(~numsynthmessage, Rect(0,0,340+46,340+46/1.6180339887499)).background_(Color.black);
				~numsynthmessagestring.align = \topLeft;
				~numsynthmessagestring.string ="Warning:"++"\n"++"\n"++"More than the normal amount of synths are currently running. It is recommended to free the server by pressing "+"ctrl/cmd - period".quote+" and then pressing the "+"ok".quote+" button. Otherwise, you can press the "+"cancel".quote+" button to allow the synths to keep running. If you press the "+"cancel".quote+" button this message will not show again unless "+"synth0".quote+" has been pressed.";
				~numsynthmessagestring.stringColor = Color.white;
				~numsynthmessagebutton1 = Button.new(~numsynthmessage,Rect(320+46-100,340/1.6180339887499-30,46,46/1.6180339887499)).states_([["ok",Color.white,Color.black]]).action_({AppClock.sched(0, {~numsynthmessage.close; ~numsynths.play; ~midifunc.value;});});
				~numsynthmessagebutton2 = Button.new(~numsynthmessage,Rect(120-46,340/1.6180339887499-30,46,46/1.6180339887499)).states_([["cancel",Color.white,Color.black]]).action_({AppClock.sched(0, {~numsynths.stop; ~numsynthmessage.close;});});
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
			{y>=(~tgrid) and: y<=(~tgrid=~tgrid+10)}  {~z1.close;~z1 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
			{y>=(~tgrid) and: y<=(~tgrid=~tgrid+10)}  {~z2.close;~z2 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
			{y>=(~tgrid) and: y<=(~tgrid=~tgrid+10)}  {~z3.close;~z3 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
			{y>=(~tgrid) and: y<=(~tgrid=~tgrid+10)}  {~z4.close;~z4 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
			{y>=(~tgrid) and: y<=(~tgrid=~tgrid+10)}  {~z5.close;~z5 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
			{y>=(~tgrid) and: y<=(~tgrid=~tgrid+10)}  {~z6.close;~z6 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
			{y>=(~tgrid) and: y<=(~tgrid=~tgrid+10)}  {~z7.close;~z7 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
			{y>=(~tgrid) and: y<=(~tgrid=~tgrid+10)}  {~z8.close;~z8 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
			{y>=(~tgrid) and: y<=(~tgrid=~tgrid+10)}  {~z9.close;~z9 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
			{y>=(~tgrid) and: y<=(~tgrid=~tgrid+10)}  {~z10.close;~z10 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
			{y>=(~tgrid) and: y<=(~tgrid=~tgrid+10)}  {~z11.close;~z11 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
			{y>=(~tgrid) and: y<=(~tgrid=~tgrid+10)}  {~z12.close;~z12 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
			{y>~tgrid and: y<~bgrid} {nil}
			{y>=(~bgrid) and: y<=(~bgrid=~bgrid+10)} {~z1.close;~z1 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
			{y>=(~bgrid) and: y<=(~bgrid=~bgrid+10)} {~z2.close;~z2 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
			{y>=(~bgrid) and: y<=(~bgrid=~bgrid+10)} {~z3.close;~z3 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
			{y>=(~bgrid) and: y<=(~bgrid=~bgrid+10)} {~z4.close;~z4 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
			{y>=(~bgrid) and: y<=(~bgrid=~bgrid+10)} {~z5.close;~z5 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
			{y>=(~bgrid) and: y<=(~bgrid=~bgrid+10)} {~z6.close;~z6 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
			{y>=(~bgrid) and: y<=(~bgrid=~bgrid+10)} {~z7.close;~z7 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
			{y>=(~bgrid) and: y<=(~bgrid=~bgrid+10)} {~z8.close;~z8 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
			{y>=(~bgrid) and: y<=(~bgrid=~bgrid+10)} {~z9.close;~z9 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
			{y>=(~bgrid) and: y<=(~bgrid=~bgrid+10)} {~z10.close;~z10 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
			{y>=(~bgrid) and: y<=(~bgrid=~bgrid+10)} {~z11.close;~z11 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
			{y>=(~bgrid) and: y<=(~bgrid=~bgrid+10)} {~z12.close;~z12 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
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
			{y>=(~tgrid) and: y<=(~tgrid=~tgrid+10)} {
				~l4a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
				~l4b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value); ~f4=q.value; ~undof4=~f4;
				~l4c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
				~l4d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
				~l4e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
				~l4f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}
			{y>=(~tgrid) and: y<=(~tgrid=~tgrid+10)} {
				~l5a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
				~l5b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value); ~f5=q.value; ~undof5=~f5;
				~l5c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
				~l5d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
				~l5e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
				~l5f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}
			{y>=(~tgrid) and: y<=(~tgrid=~tgrid+10)} {
				~l6a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
				~l6b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value); ~f6=q.value; ~undof6=~f6;
				~l6c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
				~l6d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
				~l6e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
				~l6f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}
			{y>=(~tgrid) and: y<=(~tgrid=~tgrid+10)} {
				~l7a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
				~l7b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value); ~f7=q.value; ~undof7=~f7;
				~l7c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
				~l7d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
				~l7e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
				~l7f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}
			{y>=(~tgrid) and: y<=(~tgrid=~tgrid+10)} {
				~l8a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
				~l8b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value); ~f8=q.value; ~undof8=~f8;
				~l8c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
				~l8d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
				~l8e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
				~l8f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}
			{y>=(~tgrid) and: y<=(~tgrid=~tgrid+10)} {
				~l9a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
				~l9b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value); ~f9=q.value; ~undof9=~f9;
				~l9c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
				~l9d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
				~l9e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
				~l9f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}
			{y>=(~tgrid) and: y<=(~tgrid=~tgrid+10)} {
				~l10a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
				~l10b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value); ~f10=q.value; ~undof10=~f10;
				~l10c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
				~l10d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
				~l10e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
				~l10f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}
			{y>=(~tgrid) and: y<=(~tgrid=~tgrid+10)} {
				~l11a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
				~l11b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value); ~f11=q.value; ~undof11=~f11;
				~l11c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
				~l11d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
				~l11e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
				~l11f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}
			{y>=(~tgrid) and: y<=(~tgrid=~tgrid+10)} {
				~l12a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
				~l12b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value); ~f12=q.value; ~undof12=~f12;
				~l12c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
				~l12d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
				~l12e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
				~l12f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}
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
				~l3f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);}
			{y>=(~bgrid) and: y<=(~bgrid=~bgrid+10)} {
				~l4a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l4b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value); ~f4=q.value; ~undof4=~f4;
				~l4c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
				~l4d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
				~l4e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
				~l4f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);}
			{y>=(~bgrid) and: y<=(~bgrid=~bgrid+10)} {
				~l5a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l5b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value); ~f5=q.value; ~undof5=~f5;
				~l5c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
				~l5d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
				~l5e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
				~l5f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);}
			{y>=(~bgrid) and: y<=(~bgrid=~bgrid+10)} {
				~l6a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l6b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value); ~f6=q.value; ~undof6=~f6;
				~l6c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
				~l6d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
				~l6e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
				~l6f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);}
			{y>=(~bgrid) and: y<=(~bgrid=~bgrid+10)} {
				~l7a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l7b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value); ~f7=q.value; ~undof7=~f7;
				~l7c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
				~l7d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
				~l7e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
				~l7f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);}
			{y>=(~bgrid) and: y<=(~bgrid=~bgrid+10)} {
				~l8a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l8b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value); ~f8=q.value; ~undof8=~f8;
				~l8c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
				~l8d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
				~l8e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
				~l8f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);}
			{y>=(~bgrid) and: y<=(~bgrid=~bgrid+10)} {
				~l9a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l9b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value); ~f9=q.value; ~undof9=~f9;
				~l9c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
				~l9d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
				~l9e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
				~l9f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);}
			{y>=(~bgrid) and: y<=(~bgrid=~bgrid+10)} {
				~l10a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l10b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value); ~f10=q.value; ~undof10=~f10;
				~l10c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
				~l10d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
				~l10e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
				~l10f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);}
			{y>=(~bgrid) and: y<=(~bgrid=~bgrid+10)} {
				~l11a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l11b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value); ~f11=q.value; ~undof11=~f11;
				~l11c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
				~l11d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
				~l11e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
				~l11f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);}
			{y>=(~bgrid) and: y<=(~bgrid=~bgrid+10)} {
				~l12a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l12b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value); ~f12=q.value; ~undof12=~f12;
				~l12c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
				~l12d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
				~l12e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
				~l12f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);};
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
			{y>=(~tgrid) and: y<=(~tgrid=~tgrid+10)} {
				~l4a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
				~l4b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value); ~f4=q.value; ~undof4=~f4;
				~l4c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
				~l4d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
				~l4e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
				~l4f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}
			{y>=(~tgrid) and: y<=(~tgrid=~tgrid+10)} {
				~l5a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
				~l5b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value); ~f5=q.value; ~undof5=~f5;
				~l5c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
				~l5d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
				~l5e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
				~l5f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}
			{y>=(~tgrid) and: y<=(~tgrid=~tgrid+10)} {
				~l6a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
				~l6b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value); ~f6=q.value; ~undof6=~f6;
				~l6c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
				~l6d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
				~l6e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
				~l6f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}
			{y>=(~tgrid) and: y<=(~tgrid=~tgrid+10)} {
				~l7a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
				~l7b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value); ~f7=q.value; ~undof7=~f7;
				~l7c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
				~l7d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
				~l7e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
				~l7f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}
			{y>=(~tgrid) and: y<=(~tgrid=~tgrid+10)} {
				~l8a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
				~l8b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value); ~f8=q.value; ~undof8=~f8;
				~l8c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
				~l8d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
				~l8e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
				~l8f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}
			{y>=(~tgrid) and: y<=(~tgrid=~tgrid+10)} {
				~l9a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
				~l9b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value); ~f9=q.value; ~undof9=~f9;
				~l9c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
				~l9d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
				~l9e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
				~l9f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}
			{y>=(~tgrid) and: y<=(~tgrid=~tgrid+10)} {
				~l10a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
				~l10b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value); ~f10=q.value; ~undof10=~f10;
				~l10c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
				~l10d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
				~l10e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
				~l10f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}
			{y>=(~tgrid) and: y<=(~tgrid=~tgrid+10)} {
				~l11a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
				~l11b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value); ~f11=q.value; ~undof11=~f11;
				~l11c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
				~l11d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
				~l11e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
				~l11f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}
			{y>=(~tgrid) and: y<=(~tgrid=~tgrid+10)} {
				~l12a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
				~l12b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value); ~f12=q.value; ~undof12=~f12;
				~l12c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
				~l12d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
				~l12e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
				~l12f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}
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
				~l3f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);}
			{y>=(~bgrid) and: y<=(~bgrid=~bgrid+10)} {
				~l4a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l4b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value); ~f4=q.value; ~undof4=~f4;
				~l4c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
				~l4d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
				~l4e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
				~l4f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);}
			{y>=(~bgrid) and: y<=(~bgrid=~bgrid+10)} {
				~l5a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l5b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value); ~f5=q.value; ~undof5=~f5;
				~l5c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
				~l5d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
				~l5e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
				~l5f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);}
			{y>=(~bgrid) and: y<=(~bgrid=~bgrid+10)} {
				~l6a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l6b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value); ~f6=q.value; ~undof6=~f6;
				~l6c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
				~l6d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
				~l6e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
				~l6f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);}
			{y>=(~bgrid) and: y<=(~bgrid=~bgrid+10)} {
				~l7a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l7b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value); ~f7=q.value; ~undof7=~f7;
				~l7c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
				~l7d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
				~l7e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
				~l7f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);}
			{y>=(~bgrid) and: y<=(~bgrid=~bgrid+10)} {
				~l8a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l8b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value); ~f8=q.value; ~undof8=~f8;
				~l8c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
				~l8d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
				~l8e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
				~l8f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);}
			{y>=(~bgrid) and: y<=(~bgrid=~bgrid+10)} {
				~l9a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l9b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value); ~f9=q.value; ~undof9=~f9;
				~l9c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
				~l9d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
				~l9e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
				~l9f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);}
			{y>=(~bgrid) and: y<=(~bgrid=~bgrid+10)} {
				~l10a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l10b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value); ~f10=q.value; ~undof10=~f10;
				~l10c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
				~l10d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
				~l10e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
				~l10f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);}
			{y>=(~bgrid) and: y<=(~bgrid=~bgrid+10)} {
				~l11a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l11b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value); ~f11=q.value; ~undof11=~f11;
				~l11c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
				~l11d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
				~l11e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
				~l11f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);}
			{y>=(~bgrid) and: y<=(~bgrid=~bgrid+10)} {
				~l12a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l12b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value); ~f12=q.value; ~undof12=~f12;
				~l12c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
				~l12d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
				~l12e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
				~l12f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);};
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
		{y>=(~tgrid) and: y<=(~tgrid=~tgrid+10)}  {~z1.close;~z25.close;~z1 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
		{y>=(~tgrid) and: y<=(~tgrid=~tgrid+10)}  {~z2.close;~z26.close;~z2 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
		{y>=(~tgrid) and: y<=(~tgrid=~tgrid+10)}  {~z3.close;~z27.close;~z3 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
		{y>=(~tgrid) and: y<=(~tgrid=~tgrid+10)}  {~z4.close;~z28.close;~z4 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
		{y>=(~tgrid) and: y<=(~tgrid=~tgrid+10)}  {~z5.close;~z29.close;~z5 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
		{y>=(~tgrid) and: y<=(~tgrid=~tgrid+10)}  {~z6.close;~z30.close;~z6 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
		{y>=(~tgrid) and: y<=(~tgrid=~tgrid+10)}  {~z7.close;~z31.close;~z7 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
		{y>=(~tgrid) and: y<=(~tgrid=~tgrid+10)}  {~z8.close;~z32.close;~z8 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
		{y>=(~tgrid) and: y<=(~tgrid=~tgrid+10)}  {~z9.close;~z33.close;~z9 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
		{y>=(~tgrid) and: y<=(~tgrid=~tgrid+10)}  {~z10.close;~z34.close;~z10 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
		{y>=(~tgrid) and: y<=(~tgrid=~tgrid+10)}  {~z11.close;~z35.close;~z11 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
		{y>=(~tgrid) and: y<=(~tgrid=~tgrid+10)}  {~z12.close;~z36.close;~z12 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
		{y>~tgrid and: y<~bgrid} {nil}
		{y>=(~bgrid) and: y<=(~bgrid=~bgrid+10)} {~z1.close;~z25.close;~z1 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
		{y>=(~bgrid) and: y<=(~bgrid=~bgrid+10)} {~z2.close;~z26.close;~z2 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
		{y>=(~bgrid) and: y<=(~bgrid=~bgrid+10)} {~z3.close;~z27.close;~z3 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
		{y>=(~bgrid) and: y<=(~bgrid=~bgrid+10)} {~z4.close;~z28.close;~z4 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
		{y>=(~bgrid) and: y<=(~bgrid=~bgrid+10)} {~z5.close;~z29.close;~z5 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
		{y>=(~bgrid) and: y<=(~bgrid=~bgrid+10)} {~z6.close;~z30.close;~z6 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
		{y>=(~bgrid) and: y<=(~bgrid=~bgrid+10)} {~z7.close;~z31.close;~z7 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
		{y>=(~bgrid) and: y<=(~bgrid=~bgrid+10)} {~z8.close;~z32.close;~z8 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
		{y>=(~bgrid) and: y<=(~bgrid=~bgrid+10)} {~z9.close;~z33.close;~z9 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
		{y>=(~bgrid) and: y<=(~bgrid=~bgrid+10)} {~z10.close;~z34.close;~z10 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
		{y>=(~bgrid) and: y<=(~bgrid=~bgrid+10)} {~z11.close;~z35.close;~z11 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
		{y>=(~bgrid) and: y<=(~bgrid=~bgrid+10)} {~z12.close;~z36.close;~z12 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)};
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
			{y>=(~tgrid) and: y<=(~tgrid=~tgrid+10)} {
				~l4a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
				~l4b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value); ~f4=q.value; ~undof4=~f4;
				~l4c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
				~l4d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
				~l4e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
				~l4f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}
			{y>=(~tgrid) and: y<=(~tgrid=~tgrid+10)} {
				~l5a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
				~l5b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value); ~f5=q.value; ~undof5=~f5;
				~l5c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
				~l5d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
				~l5e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
				~l5f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}
			{y>=(~tgrid) and: y<=(~tgrid=~tgrid+10)} {
				~l6a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
				~l6b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value); ~f6=q.value; ~undof6=~f6;
				~l6c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
				~l6d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
				~l6e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
				~l6f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}
			{y>=(~tgrid) and: y<=(~tgrid=~tgrid+10)} {
				~l7a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
				~l7b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value); ~f7=q.value; ~undof7=~f7;
				~l7c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
				~l7d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
				~l7e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
				~l7f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}
			{y>=(~tgrid) and: y<=(~tgrid=~tgrid+10)} {
				~l8a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
				~l8b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value); ~f8=q.value; ~undof8=~f8;
				~l8c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
				~l8d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
				~l8e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
				~l8f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}
			{y>=(~tgrid) and: y<=(~tgrid=~tgrid+10)} {
				~l9a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
				~l9b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value); ~f9=q.value; ~undof9=~f9;
				~l9c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
				~l9d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
				~l9e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
				~l9f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}
			{y>=(~tgrid) and: y<=(~tgrid=~tgrid+10)} {
				~l10a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
				~l10b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value); ~f10=q.value; ~undof10=~f10;
				~l10c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
				~l10d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
				~l10e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
				~l10f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}
			{y>=(~tgrid) and: y<=(~tgrid=~tgrid+10)} {
				~l11a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
				~l11b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value); ~f11=q.value; ~undof11=~f11;
				~l11c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
				~l11d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
				~l11e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
				~l11f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}
			{y>=(~tgrid) and: y<=(~tgrid=~tgrid+10)} {
				~l12a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
				~l12b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value); ~f12=q.value; ~undof12=~f12;
				~l12c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
				~l12d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
				~l12e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
				~l12f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}
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
				~l3f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);}
			{y>=(~bgrid) and: y<=(~bgrid=~bgrid+10)} {
				~l4a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l4b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value); ~f4=q.value; ~undof4=~f4;
				~l4c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
				~l4d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
				~l4e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
				~l4f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);}
			{y>=(~bgrid) and: y<=(~bgrid=~bgrid+10)} {
				~l5a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l5b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value); ~f5=q.value; ~undof5=~f5;
				~l5c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
				~l5d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
				~l5e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
				~l5f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);}
			{y>=(~bgrid) and: y<=(~bgrid=~bgrid+10)} {
				~l6a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l6b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value); ~f6=q.value; ~undof6=~f6;
				~l6c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
				~l6d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
				~l6e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
				~l6f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);}
			{y>=(~bgrid) and: y<=(~bgrid=~bgrid+10)} {
				~l7a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l7b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value); ~f7=q.value; ~undof7=~f7;
				~l7c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
				~l7d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
				~l7e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
				~l7f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);}
			{y>=(~bgrid) and: y<=(~bgrid=~bgrid+10)} {
				~l8a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l8b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value); ~f8=q.value; ~undof8=~f8;
				~l8c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
				~l8d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
				~l8e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
				~l8f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);}
			{y>=(~bgrid) and: y<=(~bgrid=~bgrid+10)} {
				~l9a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l9b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value); ~f9=q.value; ~undof9=~f9;
				~l9c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
				~l9d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
				~l9e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
				~l9f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);}
			{y>=(~bgrid) and: y<=(~bgrid=~bgrid+10)} {
				~l10a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l10b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value); ~f10=q.value; ~undof10=~f10;
				~l10c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
				~l10d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
				~l10e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
				~l10f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);}
			{y>=(~bgrid) and: y<=(~bgrid=~bgrid+10)} {
				~l11a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l11b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value); ~f11=q.value; ~undof11=~f11;
				~l11c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
				~l11d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
				~l11e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
				~l11f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);}
			{y>=(~bgrid) and: y<=(~bgrid=~bgrid+10)} {
				~l12a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l12b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value); ~f12=q.value; ~undof12=~f12;
				~l12c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
				~l12d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
				~l12e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
				~l12f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);};
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
			{y>=(~tgrid) and: y<=(~tgrid=~tgrid+10)} {
				~l4a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
				~l4b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value); ~f4=q.value; ~undof4=~f4;
				~l4c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
				~l4d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
				~l4e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
				~l4f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}
			{y>=(~tgrid) and: y<=(~tgrid=~tgrid+10)} {
				~l5a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
				~l5b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value); ~f5=q.value; ~undof5=~f5;
				~l5c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
				~l5d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
				~l5e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
				~l5f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}
			{y>=(~tgrid) and: y<=(~tgrid=~tgrid+10)} {
				~l6a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
				~l6b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value); ~f6=q.value; ~undof6=~f6;
				~l6c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
				~l6d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
				~l6e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
				~l6f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}
			{y>=(~tgrid) and: y<=(~tgrid=~tgrid+10)} {
				~l7a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
				~l7b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value); ~f7=q.value; ~undof7=~f7;
				~l7c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
				~l7d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
				~l7e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
				~l7f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}
			{y>=(~tgrid) and: y<=(~tgrid=~tgrid+10)} {
				~l8a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
				~l8b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value); ~f8=q.value; ~undof8=~f8;
				~l8c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
				~l8d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
				~l8e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
				~l8f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}
			{y>=(~tgrid) and: y<=(~tgrid=~tgrid+10)} {
				~l9a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
				~l9b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value); ~f9=q.value; ~undof9=~f9;
				~l9c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
				~l9d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
				~l9e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
				~l9f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}
			{y>=(~tgrid) and: y<=(~tgrid=~tgrid+10)} {
				~l10a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
				~l10b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value); ~f10=q.value; ~undof10=~f10;
				~l10c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
				~l10d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
				~l10e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
				~l10f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}
			{y>=(~tgrid) and: y<=(~tgrid=~tgrid+10)} {
				~l11a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
				~l11b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value); ~f11=q.value; ~undof11=~f11;
				~l11c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
				~l11d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
				~l11e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
				~l11f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}
			{y>=(~tgrid) and: y<=(~tgrid=~tgrid+10)} {
				~l12a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
				~l12b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value); ~f12=q.value; ~undof12=~f12;
				~l12c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
				~l12d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
				~l12e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
				~l12f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}
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
				~l3f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);}
			{y>=(~bgrid) and: y<=(~bgrid=~bgrid+10)} {
				~l4a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l4b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value); ~f4=q.value; ~undof4=~f4;
				~l4c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
				~l4d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
				~l4e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
				~l4f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);}
			{y>=(~bgrid) and: y<=(~bgrid=~bgrid+10)} {
				~l5a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l5b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value); ~f5=q.value; ~undof5=~f5;
				~l5c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
				~l5d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
				~l5e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
				~l5f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);}
			{y>=(~bgrid) and: y<=(~bgrid=~bgrid+10)} {
				~l6a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l6b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value); ~f6=q.value; ~undof6=~f6;
				~l6c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
				~l6d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
				~l6e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
				~l6f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);}
			{y>=(~bgrid) and: y<=(~bgrid=~bgrid+10)} {
				~l7a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l7b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value); ~f7=q.value; ~undof7=~f7;
				~l7c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
				~l7d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
				~l7e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
				~l7f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);}
			{y>=(~bgrid) and: y<=(~bgrid=~bgrid+10)} {
				~l8a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l8b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value); ~f8=q.value; ~undof8=~f8;
				~l8c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
				~l8d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
				~l8e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
				~l8f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);}
			{y>=(~bgrid) and: y<=(~bgrid=~bgrid+10)} {
				~l9a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l9b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value); ~f9=q.value; ~undof9=~f9;
				~l9c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
				~l9d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
				~l9e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
				~l9f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);}
			{y>=(~bgrid) and: y<=(~bgrid=~bgrid+10)} {
				~l10a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l10b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value); ~f10=q.value; ~undof10=~f10;
				~l10c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
				~l10d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
				~l10e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
				~l10f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);}
			{y>=(~bgrid) and: y<=(~bgrid=~bgrid+10)} {
				~l11a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l11b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value); ~f11=q.value; ~undof11=~f11;
				~l11c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
				~l11d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
				~l11e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
				~l11f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);}
			{y>=(~bgrid) and: y<=(~bgrid=~bgrid+10)} {
				~l12a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l12b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value); ~f12=q.value; ~undof12=~f12;
				~l12c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
				~l12d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
				~l12e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
				~l12f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);};
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

			~tsc = TextView(w, Rect(0,0, 1600*2, 354)).background_(Color.black);
			(~tsc.string =
				"saved open/flow 1-8: "++"\n"++"\n"++
				"[~f1="++fp1.asString++",~f2="++fp2.asString++",~f3="++fp3.asString++",~f4="++fp4.asString++",~f5="++fp5.asString++",~f6="++fp6.asString++",~f7="++fp7.asString++",~f8="++fp8.asString++",~f9="++fp9.asString++",~f10="++fp10.asString++",~f11="++fp11.asString++",~f12="++fp12.asString++"];"++" "++"~synthopen.value; ~trace.value; (a).wait;"++"\n"++
				"[~f1="++fp1b.asString++",~f2="++fp2b.asString++",~f3="++fp3b.asString++",~f4="++fp4b.asString++",~f5="++fp5b.asString++",~f6="++fp6b.asString++",~f7="++fp7b.asString++",~f8="++fp8b.asString++",~f9="++fp9b.asString++",~f10="++fp10b.asString++",~f11="++fp11b.asString++",~f12="++fp12b.asString++"];"++" "++"~synthflow.value; ~trace.value; (a).wait;"++"\n"++
				"[~f1="++fp1c.asString++",~f2="++fp2c.asString++",~f3="++fp3c.asString++",~f4="++fp4c.asString++",~f5="++fp5c.asString++",~f6="++fp6c.asString++",~f7="++fp7c.asString++",~f8="++fp8c.asString++",~f9="++fp9c.asString++",~f10="++fp10c.asString++",~f11="++fp11c.asString++",~f12="++fp12c.asString++"];"++" "++"~synthflow.value; ~trace.value; (a).wait;"++"\n"++
				"[~f1="++fp1d.asString++",~f2="++fp2d.asString++",~f3="++fp3d.asString++",~f4="++fp4d.asString++",~f5="++fp5d.asString++",~f6="++fp6d.asString++",~f7="++fp7d.asString++",~f8="++fp8d.asString++",~f9="++fp9d.asString++",~f10="++fp10d.asString++",~f11="++fp11d.asString++",~f12="++fp12d.asString++"];"++" "++"~synthflow.value; ~trace.value; (a).wait;"++"\n"++
				"[~f1="++fp1e.asString++",~f2="++fp2e.asString++",~f3="++fp3e.asString++",~f4="++fp4e.asString++",~f5="++fp5e.asString++",~f6="++fp6e.asString++",~f7="++fp7e.asString++",~f8="++fp8e.asString++",~f9="++fp9e.asString++",~f10="++fp10e.asString++",~f11="++fp11e.asString++",~f12="++fp12e.asString++"];"++" "++"~synthflow.value; ~trace.value; (a).wait;"++"\n"++
				"[~f1="++fp1f.asString++",~f2="++fp2f.asString++",~f3="++fp3f.asString++",~f4="++fp4f.asString++",~f5="++fp5f.asString++",~f6="++fp6f.asString++",~f7="++fp7f.asString++",~f8="++fp8f.asString++",~f9="++fp9f.asString++",~f10="++fp10f.asString++",~f11="++fp11f.asString++",~f12="++fp12f.asString++"];"++" "++"~synthflow.value; ~trace.value; (a).wait;"++"\n"++
				"[~f1="++fp1g.asString++",~f2="++fp2g.asString++",~f3="++fp3g.asString++",~f4="++fp4g.asString++",~f5="++fp5g.asString++",~f6="++fp6g.asString++",~f7="++fp7g.asString++",~f8="++fp8g.asString++",~f9="++fp9g.asString++",~f10="++fp10g.asString++",~f11="++fp11g.asString++",~f12="++fp12g.asString++"];"++" "++"~synthflow.value; ~trace.value; (a).wait;"++"\n"++
				"[~f1="++fp1h.asString++",~f2="++fp2h.asString++",~f3="++fp3h.asString++",~f4="++fp4h.asString++",~f5="++fp5h.asString++",~f6="++fp6h.asString++",~f7="++fp7h.asString++",~f8="++fp8h.asString++",~f9="++fp9h.asString++",~f10="++fp10h.asString++",~f11="++fp11h.asString++",~f12="++fp12h.asString++"];"++" "++"~synthflow.value; ~trace.value; (a).wait;"++"\n"++"\n"++

				"saved slide 1-8: "++"\n"++"\n"++

				"#o,p,q,r,s,t,u,v,w,x,y,z = [ ~f1,~f2,~f3,~f4,~f5,~f6,~f7,~f8,~f9,~f10,~f11,~f12 ]; [~f1="++fp1.asString++",~f2="++fp2.asString++",~f3="++fp3.asString++",~f4="++fp4.asString++",~f5="++fp5.asString++",~f6="++fp6.asString++",~f7="++fp7.asString++",~f8="++fp8.asString++",~f9="++fp9.asString++",~f10="++fp10.asString++",~f11="++fp11.asString++",~f12="++fp12.asString++"];"++" "++"~slidetime = 1; ~slidedo = 432; ~synthslide.value; ~trace.value; (a).wait;"++"\n"++
				"#o,p,q,r,s,t,u,v,w,x,y,z = [ ~f1,~f2,~f3,~f4,~f5,~f6,~f7,~f8,~f9,~f10,~f11,~f12 ]; [~f1="++fp1b.asString++",~f2="++fp2b.asString++",~f3="++fp3b.asString++",~f4="++fp4b.asString++",~f5="++fp5b.asString++",~f6="++fp6b.asString++",~f7="++fp7b.asString++",~f8="++fp8b.asString++",~f9="++fp9b.asString++",~f10="++fp10b.asString++",~f11="++fp11b.asString++",~f12="++fp12b.asString++"];"++" "++"~slidetime = 1; ~slidedo = 432; ~synthslide.value; ~trace.value; (a).wait;"++"\n"++
				"#o,p,q,r,s,t,u,v,w,x,y,z = [ ~f1,~f2,~f3,~f4,~f5,~f6,~f7,~f8,~f9,~f10,~f11,~f12 ]; [~f1="++fp1c.asString++",~f2="++fp2c.asString++",~f3="++fp3c.asString++",~f4="++fp4c.asString++",~f5="++fp5c.asString++",~f6="++fp6c.asString++",~f7="++fp7c.asString++",~f8="++fp8c.asString++",~f9="++fp9c.asString++",~f10="++fp10c.asString++",~f11="++fp11c.asString++",~f12="++fp12c.asString++"];"++" "++"~slidetime = 1; ~slidedo = 432; ~synthslide.value; ~trace.value; (a).wait;"++"\n"++
				"#o,p,q,r,s,t,u,v,w,x,y,z = [ ~f1,~f2,~f3,~f4,~f5,~f6,~f7,~f8,~f9,~f10,~f11,~f12 ]; [~f1="++fp1d.asString++",~f2="++fp2d.asString++",~f3="++fp3d.asString++",~f4="++fp4d.asString++",~f5="++fp5d.asString++",~f6="++fp6d.asString++",~f7="++fp7d.asString++",~f8="++fp8d.asString++",~f9="++fp9d.asString++",~f10="++fp10d.asString++",~f11="++fp11d.asString++",~f12="++fp12d.asString++"];"++" "++"~slidetime = 1; ~slidedo = 432; ~synthslide.value; ~trace.value; (a).wait;"++"\n"++
				"#o,p,q,r,s,t,u,v,w,x,y,z = [ ~f1,~f2,~f3,~f4,~f5,~f6,~f7,~f8,~f9,~f10,~f11,~f12 ]; [~f1="++fp1e.asString++",~f2="++fp2e.asString++",~f3="++fp3e.asString++",~f4="++fp4e.asString++",~f5="++fp5e.asString++",~f6="++fp6e.asString++",~f7="++fp7e.asString++",~f8="++fp8e.asString++",~f9="++fp9e.asString++",~f10="++fp10e.asString++",~f11="++fp11e.asString++",~f12="++fp12e.asString++"];"++" "++"~slidetime = 1; ~slidedo = 432; ~synthslide.value; ~trace.value; (a).wait;"++"\n"++
				"#o,p,q,r,s,t,u,v,w,x,y,z = [ ~f1,~f2,~f3,~f4,~f5,~f6,~f7,~f8,~f9,~f10,~f11,~f12 ]; [~f1="++fp1f.asString++",~f2="++fp2f.asString++",~f3="++fp3f.asString++",~f4="++fp4f.asString++",~f5="++fp5f.asString++",~f6="++fp6f.asString++",~f7="++fp7f.asString++",~f8="++fp8f.asString++",~f9="++fp9f.asString++",~f10="++fp10f.asString++",~f11="++fp11f.asString++",~f12="++fp12f.asString++"];"++" "++"~slidetime = 1; ~slidedo = 432; ~synthslide.value; ~trace.value; (a).wait;"++"\n"++
				"#o,p,q,r,s,t,u,v,w,x,y,z = [ ~f1,~f2,~f3,~f4,~f5,~f6,~f7,~f8,~f9,~f10,~f11,~f12 ]; [~f1="++fp1g.asString++",~f2="++fp2g.asString++",~f3="++fp3g.asString++",~f4="++fp4g.asString++",~f5="++fp5g.asString++",~f6="++fp6g.asString++",~f7="++fp7g.asString++",~f8="++fp8g.asString++",~f9="++fp9g.asString++",~f10="++fp10g.asString++",~f11="++fp11g.asString++",~f12="++fp12g.asString++"];"++" "++"~slidetime = 1; ~slidedo = 432; ~synthslide.value; ~trace.value; (a).wait;"++"\n"++
				"#o,p,q,r,s,t,u,v,w,x,y,z = [ ~f1,~f2,~f3,~f4,~f5,~f6,~f7,~f8,~f9,~f10,~f11,~f12 ]; [~f1="++fp1h.asString++",~f2="++fp2h.asString++",~f3="++fp3h.asString++",~f4="++fp4h.asString++",~f5="++fp5h.asString++",~f6="++fp6h.asString++",~f7="++fp7h.asString++",~f8="++fp8h.asString++",~f9="++fp9h.asString++",~f10="++fp10h.asString++",~f11="++fp11h.asString++",~f12="++fp12h.asString++"];"++" "++"~slidetime = 1; ~slidedo = 432; ~synthslide.value; ~trace.value; (a).wait;"++"\n"++"\n"++

				"current: "++"\n"++
				"[~f1="++~f1.asString++",~f2="++~f2.asString++",~f3="++~f3.asString++",~f4="++~f4.asString++",~f5="++~f5.asString++",~f6="++~f6.asString++",~f7="++~f7.asString++",~f8="++~f8.asString++",~f9="++~f9.asString++",~f10="++~f10.asString++",~f11="++~f11.asString++",~f12="++~f12.asString++"]"

			);
			~tsc.stringColor = Color.white;
			(str= [ ~f1,~f2,~f3,~f4,~f5,~f6,~f7,~f8,~f9,~f10,~f11,~f12 ];("echo"+str+"| xclip -selection clipboard").unixCmd;);
			[ ~f1,~f2,~f3,~f4,~f5,~f6,~f7,~f8,~f9,~f10,~f11,~f12 ].postln;},
			{~tsc.close;});
	});


	//stop timer button

	sts = Button.new(w,Rect(Window.screenBounds.width-20-20-20-20,~bpt+69+5,20,20/1.6180339887499)).states_([["st",Color.white,Color.black],["st",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button;
		if(~timer.isPlaying == true, {
			if(~tst.value == nil, {~timer.stop; ~systemclock.stop; ~systemclock.clear;},{~tst.close;
				~timevals.value;
				~timer.stop; ~systemclock.stop; ~systemclock.clear;});
		});
	});


	//timer button

	~ts = Button.new(w,Rect(Window.screenBounds.width*0+20,Window.screenBounds.height-52,60,60/1.6180339887499)).states_([["tsynth0",Color.white,Color.black],["tsynth1",Color.white,Color.black]]).action_({arg synthbutton; synthbutton.value.postln}).action_({arg synthbutton; if(synthbutton.value == 1, {
		if(~tst != nil, {~tst.close});
		~timevals.value;
		~timer.stop; ~systemclock.stop; ~systemclock.clear;},{if(~tst.value == nil, {~timer.stop; ~systemclock.stop; ~systemclock.clear;},{~timer.stop; ~systemclock.stop; ~systemclock.clear; ~tst.close;})})});


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
		arg synthbutton; if(synthbutton.value == 1, {~synthpause.value; ~timer.stop;},
			{~synthflow.value; if(~time == 0, {~timer.stop;}, {~timer = Routine({inf.do({~time = ~time+0.01; ~time.postln; 0.01.wait;});}); SystemClock.play(~timer);})})
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

		[~f1=fp1,~f2=fp2,~f3=fp3,~f4=fp4,~f5=fp5,~f6=fp6,~f7=fp7,~f8=fp8,~f9=fp9,~f10=fp10,~f11=fp11,~f12=fp12];

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

		[~f1=fp1b,~f2=fp2b,~f3=fp3b,~f4=fp4b,~f5=fp5b,~f6=fp6b,~f7=fp7b,~f8=fp8b,~f9=fp9b,~f10=fp10b,~f11=fp11b,~f12=fp12b];

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

		[~f1=fp1c,~f2=fp2c,~f3=fp3c,~f4=fp4c,~f5=fp5c,~f6=fp6c,~f7=fp7c,~f8=fp8c,~f9=fp9c,~f10=fp10c,~f11=fp11c,~f12=fp12c];

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

		[~f1=fp1d,~f2=fp2d,~f3=fp3d,~f4=fp4d,~f5=fp5d,~f6=fp6d,~f7=fp7d,~f8=fp8d,~f9=fp9d,~f10=fp10d,~f11=fp11d,~f12=fp12d];

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

		[~f1=fp1e,~f2=fp2e,~f3=fp3e,~f4=fp4e,~f5=fp5e,~f6=fp6e,~f7=fp7e,~f8=fp8e,~f9=fp9e,~f10=fp10e,~f11=fp11e,~f12=fp12e];

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

		[~f1=fp1f,~f2=fp2f,~f3=fp3f,~f4=fp4f,~f5=fp5f,~f6=fp6f,~f7=fp7f,~f8=fp8f,~f9=fp9f,~f10=fp10f,~f11=fp11f,~f12=fp12f];

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

		[~f1=fp1g,~f2=fp2g,~f3=fp3g,~f4=fp4g,~f5=fp5g,~f6=fp6g,~f7=fp7g,~f8=fp8g,~f9=fp9g,~f10=fp10g,~f11=fp11g,~f12=fp12g];

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

		[~f1=fp1h,~f2=fp2h,~f3=fp3h,~f4=fp4h,~f5=fp5h,~f6=fp6h,~f7=fp7h,~f8=fp8h,~f9=fp9h,~f10=fp10h,~f11=fp11h,~f12=fp12h];

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

		[~f1=fp1,~f2=fp2,~f3=fp3,~f4=fp4,~f5=fp5,~f6=fp6,~f7=fp7,~f8=fp8,~f9=fp9,~f10=fp10,~f11=fp11,~f12=fp12];

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

		[~f1=fp1b,~f2=fp2b,~f3=fp3b,~f4=fp4b,~f5=fp5b,~f6=fp6b,~f7=fp7b,~f8=fp8b,~f9=fp9b,~f10=fp10b,~f11=fp11b,~f12=fp12b];

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

		[~f1=fp1c,~f2=fp2c,~f3=fp3c,~f4=fp4c,~f5=fp5c,~f6=fp6c,~f7=fp7c,~f8=fp8c,~f9=fp9c,~f10=fp10c,~f11=fp11c,~f12=fp12c];

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

		[~f1=fp1d,~f2=fp2d,~f3=fp3d,~f4=fp4d,~f5=fp5d,~f6=fp6d,~f7=fp7d,~f8=fp8d,~f9=fp9d,~f10=fp10d,~f11=fp11d,~f12=fp12d];

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

		[~f1=fp1e,~f2=fp2e,~f3=fp3e,~f4=fp4e,~f5=fp5e,~f6=fp6e,~f7=fp7e,~f8=fp8e,~f9=fp9e,~f10=fp10e,~f11=fp11e,~f12=fp12e];

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

		[~f1=fp1f,~f2=fp2f,~f3=fp3f,~f4=fp4f,~f5=fp5f,~f6=fp6f,~f7=fp7f,~f8=fp8f,~f9=fp9f,~f10=fp10f,~f11=fp11f,~f12=fp12f];

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

		[~f1=fp1g,~f2=fp2g,~f3=fp3g,~f4=fp4g,~f5=fp5g,~f6=fp6g,~f7=fp7g,~f8=fp8g,~f9=fp9g,~f10=fp10g,~f11=fp11g,~f12=fp12g];

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

		[~f1=fp1h,~f2=fp2h,~f3=fp3h,~f4=fp4h,~f5=fp5h,~f6=fp6h,~f7=fp7h,~f8=fp8h,~f9=fp9h,~f10=fp10h,~f11=fp11h,~f12=fp12h];

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
		#g,h,i,j,k,l,m,n,o,p,q,r = (([ ~f1,~f2,~f3,~f4,~f5,~f6,~f7,~f8,~f9,~f10,~f11,~f12 ]-
			[ fp1,fp2,fp3,fp4,fp5,fp6,fp7,fp8,fp9,fp10,fp11,fp12 ])*(-1)/~slidedo1);

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
		#g,h,i,j,k,l,m,n,o,p,q,r = (([ ~f1,~f2,~f3,~f4,~f5,~f6,~f7,~f8,~f9,~f10,~f11,~f12 ]-
			[ fp1b,fp2b,fp3b,fp4b,fp5b,fp6b,fp7b,fp8b,fp9b,fp10b,fp11b,fp12b ])*(-1)/~slidedo2);

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
		#g,h,i,j,k,l,m,n,o,p,q,r = (([ ~f1,~f2,~f3,~f4,~f5,~f6,~f7,~f8,~f9,~f10,~f11,~f12 ]-
			[ fp1c,fp2c,fp3c,fp4c,fp5c,fp6c,fp7c,fp8c,fp9c,fp10c,fp11c,fp12c ])*(-1)/~slidedo3);

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
		#g,h,i,j,k,l,m,n,o,p,q,r = (([ ~f1,~f2,~f3,~f4,~f5,~f6,~f7,~f8,~f9,~f10,~f11,~f12 ]-
			[ fp1d,fp2d,fp3d,fp4d,fp5d,fp6d,fp7d,fp8d,fp9d,fp10d,fp11d,fp12d ])*(-1)/~slidedo4);

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
		#g,h,i,j,k,l,m,n,o,p,q,r = (([ ~f1,~f2,~f3,~f4,~f5,~f6,~f7,~f8,~f9,~f10,~f11,~f12 ]-
			[ fp1e,fp2e,fp3e,fp4e,fp5e,fp6e,fp7e,fp8e,fp9e,fp10e,fp11e,fp12e ])*(-1)/~slidedo5);

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
		#g,h,i,j,k,l,m,n,o,p,q,r = (([ ~f1,~f2,~f3,~f4,~f5,~f6,~f7,~f8,~f9,~f10,~f11,~f12 ]-
			[ fp1f,fp2f,fp3f,fp4f,fp5f,fp6f,fp7f,fp8f,fp9f,fp10f,fp11f,fp12f ])*(-1)/~slidedo6);

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
		#g,h,i,j,k,l,m,n,o,p,q,r = (([ ~f1,~f2,~f3,~f4,~f5,~f6,~f7,~f8,~f9,~f10,~f11,~f12 ]-
			[ fp1g,fp2g,fp3g,fp4g,fp5g,fp6g,fp7g,fp8g,fp9g,fp10g,fp11g,fp12g ])*(-1)/~slidedo7);

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
		#g,h,i,j,k,l,m,n,o,p,q,r = (([ ~f1,~f2,~f3,~f4,~f5,~f6,~f7,~f8,~f9,~f10,~f11,~f12 ]-
			[ fp1h,fp2h,fp3h,fp4h,fp5h,fp6h,fp7h,fp8h,fp9h,fp10h,fp11h,fp12h ])*(-1)/~slidedo8);

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


	//set slide values button

	~slidevals = Button.new(w,Rect(Window.screenBounds.width-20-20-20,~bpt+69+5,20,20/1.6180339887499)).states_([["s",Color.white,Color.black],["s",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button;

		if(button.value == 1, {
			({
				arg lefttime = 0 , lefttimebox = 52, leftdo = lefttimebox+widthbox+6, leftdobox = leftdo+57, top = 0,width=52, height = 16,  widthbox=52, heightbox = 16, inc=0, lw = 0,  uw = 0, numw = 40;
				var tall, stall, iall, siall, st1, st2, st3, st4, st5, st6, st7, st8, si1, si2, si3, si4, si5, si6, si7, si8, t1,t2,t3,t4,t5,t6,t7,t8,i1,i2,i3,i4,i5,i6,i7,i8;
				~slideview = View(w, Rect(Window.screenBounds.width-(340+46),Window.screenBounds.height-(340+46/1.6180339887499)-110,340+46,340+46/1.6180339887499)).front;
				/*w.view.decorator=FlowLayout(w.view.bounds);
				w.view.decorator.gap=2@2;*/

				tall = StaticText(~slideview, Rect(lefttime , top=top, width, height)).background_(Color.black).string_("all time").stringColor_(Color.white);
				t1 = StaticText(~slideview, Rect(lefttime , top=top+height, width, height)).background_(Color.black).string_("s1 time").stringColor_(Color.white);
				t2 = StaticText(~slideview, Rect(lefttime , top=top+height, width, height)).background_(Color.black).string_("s2 time").stringColor_(Color.white);
				t3 = StaticText(~slideview, Rect(lefttime , top=top+height, width, height)).background_(Color.black).string_("s3 time").stringColor_(Color.white);
				t4 = StaticText(~slideview, Rect(lefttime , top=top+height, width, height)).background_(Color.black).string_("s4 time").stringColor_(Color.white);
				t5 = StaticText(~slideview, Rect(lefttime , top=top+height, width, height)).background_(Color.black).string_("s5 time").stringColor_(Color.white);
				t6 = StaticText(~slideview, Rect(lefttime , top=top+height, width, height)).background_(Color.black).string_("s6 time").stringColor_(Color.white);
				t7 = StaticText(~slideview, Rect(lefttime , top=top+height, width, height)).background_(Color.black).string_("s7 time").stringColor_(Color.white);
				t8 = StaticText(~slideview, Rect(lefttime , top=top+height, width, height)).background_(Color.black).string_("s8 time").stringColor_(Color.white);

				top = 0;

				stall=NumberBox(~slideview, Rect(lefttimebox , top=top, widthbox, heightbox)).background_(Color.black).normalColor_(Color.white;).value_(~slidetimeall);
				st1=NumberBox(~slideview, Rect(lefttimebox , top=top+heightbox, widthbox, heightbox)).background_(Color.black).normalColor_(Color.white;).value_(~slidetime1);
				st2=NumberBox(~slideview, Rect(lefttimebox , top=top+heightbox, widthbox, heightbox)).background_(Color.black).normalColor_(Color.white;).value_(~slidetime2);
				st3=NumberBox(~slideview, Rect(lefttimebox , top=top+heightbox, widthbox, heightbox)).background_(Color.black).normalColor_(Color.white;).value_(~slidetime3);
				st4=NumberBox(~slideview, Rect(lefttimebox , top=top+heightbox, widthbox, heightbox)).background_(Color.black).normalColor_(Color.white;).value_(~slidetime4);
				st5=NumberBox(~slideview, Rect(lefttimebox , top=top+heightbox, widthbox, heightbox)).background_(Color.black).normalColor_(Color.white;).value_(~slidetime5);
				st6=NumberBox(~slideview, Rect(lefttimebox , top=top+heightbox, widthbox, heightbox)).background_(Color.black).normalColor_(Color.white;).value_(~slidetime6);
				st7=NumberBox(~slideview, Rect(lefttimebox , top=top+heightbox, widthbox, heightbox)).background_(Color.black).normalColor_(Color.white;).value_(~slidetime7);
				st8=NumberBox(~slideview, Rect(lefttimebox , top=top+heightbox, widthbox, heightbox)).background_(Color.black).normalColor_(Color.white;).value_(~slidetime8);

				top = 0;

				iall = StaticText(~slideview, Rect(leftdo , top=top, width, height)).background_(Color.black).string_("all incr").stringColor_(Color.white);
				i1 = StaticText(~slideview, Rect(leftdo , top=top+height, width, height)).background_(Color.black).string_("s1 incr").stringColor_(Color.white);
				i2 = StaticText(~slideview, Rect(leftdo , top=top+height, width, height)).background_(Color.black).string_("s2 incr").stringColor_(Color.white);
				i3 = StaticText(~slideview, Rect(leftdo , top=top+height, width, height)).background_(Color.black).string_("s3 incr").stringColor_(Color.white);
				i4 = StaticText(~slideview, Rect(leftdo , top=top+height, width, height)).background_(Color.black).string_("s4 incr").stringColor_(Color.white);
				i5 = StaticText(~slideview, Rect(leftdo , top=top+height, width, height)).background_(Color.black).string_("s5 incr").stringColor_(Color.white);
				i6 = StaticText(~slideview, Rect(leftdo , top=top+height, width, height)).background_(Color.black).string_("s6 incr").stringColor_(Color.white);
				i7 = StaticText(~slideview, Rect(leftdo , top=top+height, width, height)).background_(Color.black).string_("s7 incr").stringColor_(Color.white);
				i8 = StaticText(~slideview, Rect(leftdo , top=top+height, width, height)).background_(Color.black).string_("s8 incr").stringColor_(Color.white);

				top = 0;

				siall=NumberBox(~slideview, Rect(leftdobox , top=top, widthbox, heightbox)).background_(Color.black).normalColor_(Color.white;).value_(~slidedoall);
				si1=NumberBox(~slideview, Rect(leftdobox , top=top+heightbox, widthbox, heightbox)).background_(Color.black).normalColor_(Color.white;).value_(~slidedo1);
				si2=NumberBox(~slideview, Rect(leftdobox , top=top+heightbox, widthbox, heightbox)).background_(Color.black).normalColor_(Color.white;).value_(~slidedo2);
				si3=NumberBox(~slideview, Rect(leftdobox , top=top+heightbox, widthbox, heightbox)).background_(Color.black).normalColor_(Color.white;).value_(~slidedo3);
				si4=NumberBox(~slideview, Rect(leftdobox , top=top+heightbox, widthbox, heightbox)).background_(Color.black).normalColor_(Color.white;).value_(~slidedo4);
				si5=NumberBox(~slideview, Rect(leftdobox , top=top+heightbox, widthbox, heightbox)).background_(Color.black).normalColor_(Color.white;).value_(~slidedo5);
				si6=NumberBox(~slideview, Rect(leftdobox , top=top+heightbox, widthbox, heightbox)).background_(Color.black).normalColor_(Color.white;).value_(~slidedo6);
				si7=NumberBox(~slideview, Rect(leftdobox , top=top+heightbox, widthbox, heightbox)).background_(Color.black).normalColor_(Color.white;).value_(~slidedo7);
				si8=NumberBox(~slideview, Rect(leftdobox , top=top+heightbox, widthbox, heightbox)).background_(Color.black).normalColor_(Color.white;).value_(~slidedo8);

				stall.action_({arg val;
					~slidetimeall = val.value;
					~slidetime1 = val.value;
					~slidetime2 = val.value;
					~slidetime3 = val.value;
					~slidetime4 = val.value;
					~slidetime5 = val.value;
					~slidetime6 = val.value;
					~slidetime7 = val.value;
					~slidetime8 = val.value;
					~slideview.close; ~slidevals.valueAction_(1);
				});
				st1.action_({arg val; ~slidetime1 = val.value;});
				st2.action_({arg val; ~slidetime2 = val.value;});
				st3.action_({arg val; ~slidetime3 = val.value;});
				st4.action_({arg val; ~slidetime4 = val.value;});
				st5.action_({arg val; ~slidetime5 = val.value;});
				st6.action_({arg val; ~slidetime6 = val.value;});
				st7.action_({arg val; ~slidetime7 = val.value;});
				st8.action_({arg val; ~slidetime8 = val.value;});

				siall.action_({arg val;
					~slidedoall = val.value;
					~slidedo1 = val.value;
					~slidedo2 = val.value;
					~slidedo3 = val.value;
					~slidedo4 = val.value;
					~slidedo5 = val.value;
					~slidedo6 = val.value;
					~slidedo7 = val.value;
					~slidedo8 = val.value;
					~slideview.close; ~slidevals.valueAction_(1);
				});
				si1.action_({arg val; ~slidedo1 = val.value;});
				si2.action_({arg val; ~slidedo2 = val.value;});
				si3.action_({arg val; ~slidedo3 = val.value;});
				si4.action_({arg val; ~slidedo4 = val.value;});
				si5.action_({arg val; ~slidedo5 = val.value;});
				si6.action_({arg val; ~slidedo6 = val.value;});
				si7.action_({arg val; ~slidedo7 = val.value;});
				si8.action_({arg val; ~slidedo8 = val.value;});

				~slideview.background_(Color.black);

				~closeslidebutton = Button.new(~slideview,Rect(220, top+40, 40, 40/~gm)).states_([["close",Color.white,Color.black]]).action_({arg button;

					~slideview.close; ~slidevals.value = 0;
				});

			}.value);

			~slideview.front;
		}, {~slideview.close});
	});


	//mute/unmute 1-8 buttons

	mute1 = Button.new(w,Rect(~bpl+(0),~bpt+69+5-(16/1.6180339887499),16,16/1.6180339887499)).states_([["1",Color.white,Color.black],["",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button;
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

	mute2 = Button.new(w,Rect(~bpl+(16*1),~bpt+69+5-(16/1.6180339887499),16,16/1.6180339887499)).states_([["2",Color.white,Color.black],["",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button;
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
	mute3 = Button.new(w,Rect(~bpl+(16*2),~bpt+69+5-(16/1.6180339887499),16,16/1.6180339887499)).states_([["3",Color.white,Color.black],["",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button;
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
	mute4 = Button.new(w,Rect(~bpl+(16*3),~bpt+69+5-(16/1.6180339887499),16,16/1.6180339887499)).states_([["4",Color.white,Color.black],["",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button;
		case
		{~l1a1.isRunning == true}{
			if(button.value == 0, {
				(~vol4 = ~vol;
					1.do({
						~l4a1.set(\vol, ~vol4);  ~l4b1.set(\vol, ~vol4);
						~l4c1.set(\vol, ~vol4);  ~l4d1.set(\vol, ~vol4);
						~l4e1.set(\vol, ~vol4);  ~l4f1.set(\vol, ~vol4);

				}););
				}, {(~vol4 = 0;
					1.do({
						~l4a1.set(\vol, ~vol4);  ~l4b1.set(\vol, ~vol4);
						~l4c1.set(\vol, ~vol4);  ~l4d1.set(\vol, ~vol4);
						~l4e1.set(\vol, ~vol4);  ~l4f1.set(\vol, ~vol4);

					}););
			});
		}
		{~l1a.isRunning == true}{
			if(button.value == 0, {
				(~vol4 = ~vol;
					1.do({
						~l4a.set(\vol, ~vol4);  ~l4b.set(\vol, ~vol4);
						~l4c.set(\vol, ~vol4);  ~l4d.set(\vol, ~vol4);
						~l4e.set(\vol, ~vol4);  ~l4f.set(\vol, ~vol4);

				}););
				}, {(~vol4 = 0;
					1.do({
						~l4a.set(\vol, ~vol4);  ~l4b.set(\vol, ~vol4);
						~l4c.set(\vol, ~vol4);  ~l4d.set(\vol, ~vol4);
						~l4e.set(\vol, ~vol4);  ~l4f.set(\vol, ~vol4);

					}););
			});
		};
	});
	mute5 = Button.new(w,Rect(~bpl+(16*4),~bpt+69+5-(16/1.6180339887499),16,16/1.6180339887499)).states_([["5",Color.white,Color.black],["",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button;
		case
		{~l1a1.isRunning == true}{
			if(button.value == 0, {
				(~vol5 = ~vol;
					1.do({
						~l5a1.set(\vol, ~vol5);  ~l5b1.set(\vol, ~vol5);
						~l5c1.set(\vol, ~vol5);  ~l5d1.set(\vol, ~vol5);
						~l5e1.set(\vol, ~vol5);  ~l5f1.set(\vol, ~vol5);

				}););
				}, {(~vol5 = 0;
					1.do({
						~l5a1.set(\vol, ~vol5);  ~l5b1.set(\vol, ~vol5);
						~l5c1.set(\vol, ~vol5);  ~l5d1.set(\vol, ~vol5);
						~l5e1.set(\vol, ~vol5);  ~l5f1.set(\vol, ~vol5);

					}););
			});
		}
		{~l1a.isRunning == true}{
			if(button.value == 0, {
				(~vol5 = ~vol;
					1.do({
						~l5a.set(\vol, ~vol5);  ~l5b.set(\vol, ~vol5);
						~l5c.set(\vol, ~vol5);  ~l5d.set(\vol, ~vol5);
						~l5e.set(\vol, ~vol5);  ~l5f.set(\vol, ~vol5);

				}););
				}, {(~vol5 = 0;
					1.do({
						~l5a.set(\vol, ~vol5);  ~l5b.set(\vol, ~vol5);
						~l5c.set(\vol, ~vol5);  ~l5d.set(\vol, ~vol5);
						~l5e.set(\vol, ~vol5);  ~l5f.set(\vol, ~vol5);

					}););
			});
		};
	});
	mute6 = Button.new(w,Rect(~bpl+(16*5),~bpt+69+5-(16/1.6180339887499),16,16/1.6180339887499)).states_([["6",Color.white,Color.black],["",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button;
		case
		{~l1a1.isRunning == true}{
			if(button.value == 0, {
				(~vol6 = ~vol;
					1.do({
						~l6a1.set(\vol, ~vol6);  ~l6b1.set(\vol, ~vol6);
						~l6c1.set(\vol, ~vol6);  ~l6d1.set(\vol, ~vol6);
						~l6e1.set(\vol, ~vol6);  ~l6f1.set(\vol, ~vol6);

				}););
				}, {(~vol6 = 0;
					1.do({
						~l6a1.set(\vol, ~vol6);  ~l6b1.set(\vol, ~vol6);
						~l6c1.set(\vol, ~vol6);  ~l6d1.set(\vol, ~vol6);
						~l6e1.set(\vol, ~vol6);  ~l6f1.set(\vol, ~vol6);

					}););
			});
		}
		{~l1a.isRunning == true}{
			if(button.value == 0, {
				(~vol6 = ~vol;
					1.do({
						~l6a.set(\vol, ~vol6);  ~l6b.set(\vol, ~vol6);
						~l6c.set(\vol, ~vol6);  ~l6d.set(\vol, ~vol6);
						~l6e.set(\vol, ~vol6);  ~l6f.set(\vol, ~vol6);

				}););
				}, {(~vol6 = 0;
					1.do({
						~l6a.set(\vol, ~vol6);  ~l6b.set(\vol, ~vol6);
						~l6c.set(\vol, ~vol6);  ~l6d.set(\vol, ~vol6);
						~l6e.set(\vol, ~vol6);  ~l6f.set(\vol, ~vol6);

					}););
			});
		};

	});
	mute7 = Button.new(w,Rect(~bpl+(16*6),~bpt+69+5-(16/1.6180339887499),16,16/1.6180339887499)).states_([["7",Color.white,Color.black],["",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button;
		case
		{~l1a1.isRunning == true}{
			if(button.value == 0, {
				(~vol7 = ~vol;
					1.do({
						~l7a1.set(\vol, ~vol7);  ~l7b1.set(\vol, ~vol7);
						~l7c1.set(\vol, ~vol7);  ~l7d1.set(\vol, ~vol7);
						~l7e1.set(\vol, ~vol7);  ~l7f1.set(\vol, ~vol7);

				}););
				}, {(~vol7 = 0;
					1.do({
						~l7a1.set(\vol, ~vol7);  ~l7b1.set(\vol, ~vol7);
						~l7c1.set(\vol, ~vol7);  ~l7d1.set(\vol, ~vol7);
						~l7e1.set(\vol, ~vol7);  ~l7f1.set(\vol, ~vol7);

					}););
			});
		}
		{~l1a.isRunning == true}{
			if(button.value == 0, {
				(~vol7 = ~vol;
					1.do({
						~l7a.set(\vol, ~vol7);  ~l7b.set(\vol, ~vol7);
						~l7c.set(\vol, ~vol7);  ~l7d.set(\vol, ~vol7);
						~l7e.set(\vol, ~vol7);  ~l7f.set(\vol, ~vol7);

				}););
				}, {(~vol7 = 0;
					1.do({
						~l7a.set(\vol, ~vol7);  ~l7b.set(\vol, ~vol7);
						~l7c.set(\vol, ~vol7);  ~l7d.set(\vol, ~vol7);
						~l7e.set(\vol, ~vol7);  ~l7f.set(\vol, ~vol7);

					}););
			});
		};
	});
	mute8 = Button.new(w,Rect(~bpl+(16*7),~bpt+69+5-(16/1.6180339887499),16,16/1.6180339887499)).states_([["8",Color.white,Color.black],["",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button;
		case
		{~l1a1.isRunning == true}{
			if(button.value == 0, {
				(~vol8 = ~vol;
					1.do({
						~l8a1.set(\vol, ~vol8);  ~l8b1.set(\vol, ~vol8);
						~l8c1.set(\vol, ~vol8);  ~l8d1.set(\vol, ~vol8);
						~l8e1.set(\vol, ~vol8);  ~l8f1.set(\vol, ~vol8);

				}););
				}, {(~vol8 = 0;
					1.do({
						~l8a1.set(\vol, ~vol8);  ~l8b1.set(\vol, ~vol8);
						~l8c1.set(\vol, ~vol8);  ~l8d1.set(\vol, ~vol8);
						~l8e1.set(\vol, ~vol8);  ~l8f1.set(\vol, ~vol8);

					}););
			});
		}
		{~l1a.isRunning == true}{
			if(button.value == 0, {
				(~vol8 = ~vol;
					1.do({
						~l8a.set(\vol, ~vol8);  ~l8b.set(\vol, ~vol8);
						~l8c.set(\vol, ~vol8);  ~l8d.set(\vol, ~vol8);
						~l8e.set(\vol, ~vol8);  ~l8f.set(\vol, ~vol8);

				}););
				}, {(~vol8 = 0;
					1.do({
						~l8a.set(\vol, ~vol8);  ~l8b.set(\vol, ~vol8);
						~l8c.set(\vol, ~vol8);  ~l8d.set(\vol, ~vol8);
						~l8e.set(\vol, ~vol8);  ~l8f.set(\vol, ~vol8);

					}););
			});
		};
	});
	mute9 = Button.new(w,Rect(~bpl+(16*8),~bpt+69+5-(16/1.6180339887499),16,16/1.6180339887499)).states_([["9",Color.white,Color.black],["",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button;
		case
		{~l1a1.isRunning == true}{
			if(button.value == 0, {
				(~vol9 = ~vol;
					1.do({
						~l9a1.set(\vol, ~vol9);  ~l9b1.set(\vol, ~vol9);
						~l9c1.set(\vol, ~vol9);  ~l9d1.set(\vol, ~vol9);
						~l9e1.set(\vol, ~vol9);  ~l9f1.set(\vol, ~vol9);

				}););
				}, {(~vol9 = 0;
					1.do({
						~l9a1.set(\vol, ~vol9);  ~l9b1.set(\vol, ~vol9);
						~l9c1.set(\vol, ~vol9);  ~l9d1.set(\vol, ~vol9);
						~l9e1.set(\vol, ~vol9);  ~l9f1.set(\vol, ~vol9);

					}););
			});
		}
		{~l1a.isRunning == true}{
			if(button.value == 0, {
				(~vol9 = ~vol;
					1.do({
						~l9a.set(\vol, ~vol9);  ~l9b.set(\vol, ~vol9);
						~l9c.set(\vol, ~vol9);  ~l9d.set(\vol, ~vol9);
						~l9e.set(\vol, ~vol9);  ~l9f.set(\vol, ~vol9);

				}););
				}, {(~vol9 = 0;
					1.do({
						~l9a.set(\vol, ~vol9);  ~l9b.set(\vol, ~vol9);
						~l9c.set(\vol, ~vol9);  ~l9d.set(\vol, ~vol9);
						~l9e.set(\vol, ~vol9);  ~l9f.set(\vol, ~vol9);

					}););
			});
		};
	});
	mute10 = Button.new(w,Rect(~bpl+(0),~bpt+69+5,16,16/1.6180339887499)).states_([["10",Color.white,Color.black],["",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button;
		case
		{~l1a1.isRunning == true}{
			if(button.value == 0, {
				(~vol10 = ~vol;
					1.do({
						~l10a1.set(\vol, ~vol10);  ~l10b1.set(\vol, ~vol10);
						~l10c1.set(\vol, ~vol10);  ~l10d1.set(\vol, ~vol10);
						~l10e1.set(\vol, ~vol10);  ~l10f1.set(\vol, ~vol10);

				}););
				}, {(~vol10 = 0;
					1.do({
						~l10a1.set(\vol, ~vol10);  ~l10b1.set(\vol, ~vol10);
						~l10c1.set(\vol, ~vol10);  ~l10d1.set(\vol, ~vol10);
						~l10e1.set(\vol, ~vol10);  ~l10f1.set(\vol, ~vol10);

					}););
			});
		}
		{~l1a.isRunning == true}{
			if(button.value == 0, {
				(~vol10 = ~vol;
					1.do({
						~l10a.set(\vol, ~vol10);  ~l10b.set(\vol, ~vol10);
						~l10c.set(\vol, ~vol10);  ~l10d.set(\vol, ~vol10);
						~l10e.set(\vol, ~vol10);  ~l10f.set(\vol, ~vol10);

				}););
				}, {(~vol10 = 0;
					1.do({
						~l10a.set(\vol, ~vol10);  ~l10b.set(\vol, ~vol10);
						~l10c.set(\vol, ~vol10);  ~l10d.set(\vol, ~vol10);
						~l10e.set(\vol, ~vol10);  ~l10f.set(\vol, ~vol10);

					}););
			});
		};
	});
	mute11 = Button.new(w,Rect(~bpl+(16),~bpt+69+5,16,16/1.6180339887499)).states_([["11",Color.white,Color.black],["",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button;
		case
		{~l1a1.isRunning == true}{
			if(button.value == 0, {
				(~vol11 = ~vol;
					1.do({
						~l11a1.set(\vol, ~vol11);  ~l11b1.set(\vol, ~vol11);
						~l11c1.set(\vol, ~vol11);  ~l11d1.set(\vol, ~vol11);
						~l11e1.set(\vol, ~vol11);  ~l11f1.set(\vol, ~vol11);

				}););
				}, {(~vol11 = 0;
					1.do({
						~l11a1.set(\vol, ~vol11);  ~l8b1.set(\vol, ~vol11);
						~l11c1.set(\vol, ~vol11);  ~l8d1.set(\vol, ~vol11);
						~l11e1.set(\vol, ~vol11);  ~l8f1.set(\vol, ~vol11);

					}););
			});
		}
		{~l1a.isRunning == true}{
			if(button.value == 0, {
				(~vol11 = ~vol;
					1.do({
						~l11a.set(\vol, ~vol11);  ~l11b.set(\vol, ~vol11);
						~l11c.set(\vol, ~vol11);  ~l11d.set(\vol, ~vol11);
						~l11e.set(\vol, ~vol11);  ~l11f.set(\vol, ~vol11);

				}););
				}, {(~vol11 = 0;
					1.do({
						~l11a.set(\vol, ~vol11);  ~l11b.set(\vol, ~vol11);
						~l11c.set(\vol, ~vol11);  ~l11d.set(\vol, ~vol11);
						~l11e.set(\vol, ~vol11);  ~l11f.set(\vol, ~vol11);

					}););
			});
		};
	});
	mute12 = Button.new(w,Rect(~bpl+(16*2),~bpt+69+5,16,16/1.6180339887499)).states_([["12",Color.white,Color.black],["",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button;
		case
		{~l1a1.isRunning == true}{
			if(button.value == 0, {
				(~vol12 = ~vol;
					1.do({
						~l12a1.set(\vol, ~vol12);  ~l12b1.set(\vol, ~vol12);
						~l12c1.set(\vol, ~vol12);  ~l12d1.set(\vol, ~vol12);
						~l12e1.set(\vol, ~vol12);  ~l12f1.set(\vol, ~vol12);

				}););
				}, {(~vol12 = 0;
					1.do({
						~l12a1.set(\vol, ~vol12);  ~l12b1.set(\vol, ~vol12);
						~l12c1.set(\vol, ~vol12);  ~l12d1.set(\vol, ~vol12);
						~l12e1.set(\vol, ~vol12);  ~l12f1.set(\vol, ~vol12);

					}););
			});
		}
		{~l1a.isRunning == true}{
			if(button.value == 0, {
				(~vol12 = ~vol;
					1.do({
						~l12a.set(\vol, ~vol12);  ~l12b.set(\vol, ~vol12);
						~l12c.set(\vol, ~vol12);  ~l12d.set(\vol, ~vol12);
						~l12e.set(\vol, ~vol12);  ~l12f.set(\vol, ~vol12);

				}););
				}, {(~vol12 = 0;
					1.do({
						~l12a.set(\vol, ~vol12);  ~l12b.set(\vol, ~vol12);
						~l12c.set(\vol, ~vol12);  ~l12d.set(\vol, ~vol12);
						~l12e.set(\vol, ~vol12);  ~l12f.set(\vol, ~vol12);

					}););
			});
		};
	});


	//mute/unmute all button

	muteall = Button.new(w,Rect(~bpl+(16*3),~bpt+69+5,16,16/1.6180339887499)).states_([["m",Color.white,Color.black],["u",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button;

		if(button.value == 0, {
			mute1.value = 0;
			mute2.value = 0;
			mute3.value = 0;
			mute4.value = 0;
			mute5.value = 0;
			mute6.value = 0;
			mute7.value = 0;
			mute8.value = 0;
			mute9.value = 0;
			mute10.value = 0;
			mute11.value = 0;
			mute12.value = 0;

			~vol1 = ~vol;
			~vol2 = ~vol;
			~vol3 = ~vol;
			~vol4 = ~vol;
			~vol5 = ~vol;
			~vol6 = ~vol;
			~vol7 = ~vol;
			~vol8 = ~vol;
			~vol9 = ~vol;
			~vol10 = ~vol;
			~vol11 = ~vol;
			~vol12 = ~vol;
			},
			{
				mute1.value = 1;
				mute2.value = 1;
				mute3.value = 1;
				mute4.value = 1;
				mute5.value = 1;
				mute6.value = 1;
				mute7.value = 1;
				mute8.value = 1;
				mute9.value = 1;
				mute10.value = 1;
				mute11.value = 1;
				mute12.value = 1;

				~vol1 = 0;
				~vol2 = 0;
				~vol3 = 0;
				~vol4 = 0;
				~vol5 = 0;
				~vol6 = 0;
				~vol7 = 0;
				~vol8 = 0;
				~vol9 = 0;
				~vol10 = 0;
				~vol11 = 0;
				~vol12 = 0;
		});
		~synthflow.value;
	});


	//generate values for KW(King Wen) sequences per timewave instance pop-up menu

	x=0;
	~menu2values = Array.fill(20, {(x=x+1).asString++" kws/inst"});


	//KW(King Wen) sequences per timewave instance upon starting value

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
	{~gsinenum == 16}{~menu2start = ~menu2values.at(15)};
	if(~menu2synthdefstart.value == nil, {~menu2synthdefstart = ~synthdefnum}, {~menu2synthdefstart = ~gsinenum});


	//KW(King Wen) sequences per timewave instance pop-up menu

	menu2=PopUpMenu(w,Rect(20+60*2+16,Window.screenBounds.height-52+(30/1.6180339887499*0),60*2,60/1.6180339887499)).items_(~mvalue = (-1); [~menu2start.asString]++Array.fill(16, {~menu2values.at(~mvalue = ~mvalue+1);});).background_(Color.black).stringColor_(Color.white);


	//pop-menu for base frequency

	~bfreqstart = ~basefreq;
	~bfreq = PopUpMenu(w, Rect(20+60*2+16,Window.screenBounds.height-88+(30/1.6180339887499*0),120,60/1.6180339887499)).items_(~bfreqv = (-1); [~basefreq.asString++" hz"]++Array.fill(128, {~freqmap.at(~bfreqv=~bfreqv+1).asString++" hz"})).background_(Color.black).stringColor_(Color.white).action_({arg button;});


	//set button for KW sequences per timewave instance, basefreq, and gsine

	set1=Button(w,Rect(20+60*2+16+120, Window.screenBounds.height-52+(16/1.6180339887499*0),60,60/1.6180339887499)).states_([["set",Color.white,Color.black]]).mouseDownAction_({

		~st = StaticText(w, Rect(20+60*2+16+190,Window.screenBounds.height-40, 62, 20)).background_(Color.black);
		~st.stringColor = Color.white;
		~st.string = "loading...";
		AppClock.sched(0.2,{
			~st.close;
		});

		AppClock.sched(0,{

			if(~bfreq.value > 0, {~basefreq = ~freqmap.at(~bfreq.value - 1)}, {~basefreq = ~bfreqstart});

			(#a,b,c,d,e,f =	[ ~basefreq,~basefreq,~basefreq,~basefreq,~basefreq,~basefreq  ]; ~a = a; ~b = b; ~c =c; ~d = d; ~e = e;~f=f;);

			case
			{menu2.value == 0}{~gsinenum = ~menu2synthdefstart; ~gsine.value;}
			{menu2.value == 1}{~gsinenum = 1; ~gsine.value;}
			{menu2.value == 2}{~gsinenum = 2; ~gsine.value;}
			{menu2.value == 3}{~gsinenum = 3; ~gsine.value;}
			{menu2.value == 4}{~gsinenum = 4; ~gsine.value;}
			{menu2.value == 5}{~gsinenum = 5; ~gsine.value;}
			{menu2.value == 6}{~gsinenum = 6; ~gsine.value;}
			{menu2.value == 7}{~gsinenum = 7; ~gsine.value;}
			{menu2.value == 8}{~gsinenum = 8; ~gsine.value;}
			{menu2.value == 9}{~gsinenum = 9; ~gsine.value;}
			{menu2.value == 10}{~gsinenum = 10; ~gsine.value;}
			{menu2.value == 11}{~gsinenum = 11; ~gsine.value;}
			{menu2.value == 12}{~gsinenum = 12; ~gsine.value;}
			{menu2.value == 13}{~gsinenum = 13; ~gsine.value;}
			{menu2.value == 14}{~gsinenum = 14; ~gsine.value;}
			{menu2.value == 15}{~gsinenum = 15; ~gsine.value;}
			{menu2.value == 16}{~gsinenum = 16; ~gsine.value;};
		});

	})
	.action_({
	});


	//keyboard number buttons to choose synth

	keycodeb = Button.new(w,Rect(Window.screenBounds.width-20-16,~bpt+160,16,16/1.6180339887499)).states_([
		["1",Color.white,Color.black],
		["2",Color.white,Color.black],
		["3",Color.white,Color.black],
		["4",Color.white,Color.black],
		["5",Color.white,Color.black],
		["6",Color.white,Color.black],
		["7",Color.white,Color.black],
		["8",Color.white,Color.black],
		["9",Color.white,Color.black],
		["10",Color.white,Color.black],
		["11",Color.white,Color.black],
		["12",Color.white,Color.black]]).action_({arg button;

		case
		{button.value == 0}{
			~z25.background = Color.green; ~z1.background = Color.green;
			~z26.background = Color.white; ~z2.background = Color.white;
			~z27.background = Color.white; ~z3.background = Color.white;
			~z28.background = Color.white; ~z4.background = Color.white;
			~z29.background = Color.white; ~z5.background = Color.white;
			~z30.background = Color.white; ~z6.background = Color.white;
			~z31.background = Color.white; ~z7.background = Color.white;
			~z32.background = Color.white; ~z8.background = Color.white;
			~z33.background = Color.white; ~z9.background = Color.white;
			~z34.background = Color.white; ~z10.background = Color.white;
			~z35.background = Color.white; ~z11.background = Color.white;
			~z36.background = Color.white; ~z12.background = Color.white;
		}
		{button.value == 1}{
			~z25.background = Color.white; ~z1.background = Color.white;
			~z26.background = Color.green; ~z2.background = Color.green;
			~z27.background = Color.white; ~z3.background = Color.white;
			~z28.background = Color.white; ~z4.background = Color.white;
			~z29.background = Color.white; ~z5.background = Color.white;
			~z30.background = Color.white; ~z6.background = Color.white;
			~z31.background = Color.white; ~z7.background = Color.white;
			~z32.background = Color.white; ~z8.background = Color.white;
			~z33.background = Color.white; ~z9.background = Color.white;
			~z34.background = Color.white; ~z10.background = Color.white;
			~z35.background = Color.white; ~z11.background = Color.white;
			~z36.background = Color.white; ~z12.background = Color.white;
		}
		{button.value == 2}{
			~z25.background = Color.white; ~z1.background = Color.white;
			~z26.background = Color.white; ~z2.background = Color.white;
			~z27.background = Color.green; ~z3.background = Color.green;
			~z28.background = Color.white; ~z4.background = Color.white;
			~z29.background = Color.white; ~z5.background = Color.white;
			~z30.background = Color.white; ~z6.background = Color.white;
			~z31.background = Color.white; ~z7.background = Color.white;
			~z32.background = Color.white; ~z8.background = Color.white;
			~z33.background = Color.white; ~z9.background = Color.white;
			~z34.background = Color.white; ~z10.background = Color.white;
			~z35.background = Color.white; ~z11.background = Color.white;
			~z36.background = Color.white; ~z12.background = Color.white;
		}
		{button.value == 3}{
			~z25.background = Color.white; ~z1.background = Color.white;
			~z26.background = Color.white; ~z2.background = Color.white;
			~z27.background = Color.white; ~z3.background = Color.white;
			~z28.background = Color.green; ~z4.background = Color.green;
			~z29.background = Color.white; ~z5.background = Color.white;
			~z30.background = Color.white; ~z6.background = Color.white;
			~z31.background = Color.white; ~z7.background = Color.white;
			~z32.background = Color.white; ~z8.background = Color.white;
			~z33.background = Color.white; ~z9.background = Color.white;
			~z34.background = Color.white; ~z10.background = Color.white;
			~z35.background = Color.white; ~z11.background = Color.white;
			~z36.background = Color.white; ~z12.background = Color.white;
		}
		{button.value == 4}{
			~z25.background = Color.white; ~z1.background = Color.white;
			~z26.background = Color.white; ~z2.background = Color.white;
			~z27.background = Color.white; ~z3.background = Color.white;
			~z28.background = Color.white; ~z4.background = Color.white;
			~z29.background = Color.green; ~z5.background = Color.green;
			~z30.background = Color.white; ~z6.background = Color.white;
			~z31.background = Color.white; ~z7.background = Color.white;
			~z32.background = Color.white; ~z8.background = Color.white;
			~z33.background = Color.white; ~z9.background = Color.white;
			~z34.background = Color.white; ~z10.background = Color.white;
			~z35.background = Color.white; ~z11.background = Color.white;
			~z36.background = Color.white; ~z12.background = Color.white;
		}
		{button.value == 5}{
			~z25.background = Color.white; ~z1.background = Color.white;
			~z26.background = Color.white; ~z2.background = Color.white;
			~z27.background = Color.white; ~z3.background = Color.white;
			~z28.background = Color.white; ~z4.background = Color.white;
			~z29.background = Color.white; ~z5.background = Color.white;
			~z30.background = Color.green; ~z6.background = Color.green;
			~z31.background = Color.white; ~z7.background = Color.white;
			~z32.background = Color.white; ~z8.background = Color.white;
			~z33.background = Color.white; ~z9.background = Color.white;
			~z34.background = Color.white; ~z10.background = Color.white;
			~z35.background = Color.white; ~z11.background = Color.white;
			~z36.background = Color.white; ~z12.background = Color.white;
		}
		{button.value == 6}{
			~z25.background = Color.white; ~z1.background = Color.white;
			~z26.background = Color.white; ~z2.background = Color.white;
			~z27.background = Color.white; ~z3.background = Color.white;
			~z28.background = Color.white; ~z4.background = Color.white;
			~z29.background = Color.white; ~z5.background = Color.white;
			~z30.background = Color.white; ~z6.background = Color.white;
			~z31.background = Color.green; ~z7.background = Color.green;
			~z32.background = Color.white; ~z8.background = Color.white;
			~z33.background = Color.white; ~z9.background = Color.white;
			~z34.background = Color.white; ~z10.background = Color.white;
			~z35.background = Color.white; ~z11.background = Color.white;
			~z36.background = Color.white; ~z12.background = Color.white;
		}
		{button.value == 7}{
			~z25.background = Color.white; ~z1.background = Color.white;
			~z26.background = Color.white; ~z2.background = Color.white;
			~z27.background = Color.white; ~z3.background = Color.white;
			~z28.background = Color.white; ~z4.background = Color.white;
			~z29.background = Color.white; ~z5.background = Color.white;
			~z30.background = Color.white; ~z6.background = Color.white;
			~z31.background = Color.white; ~z7.background = Color.white;
			~z32.background = Color.green; ~z8.background = Color.green;
			~z33.background = Color.white; ~z9.background = Color.white;
			~z34.background = Color.white; ~z10.background = Color.white;
			~z35.background = Color.white; ~z11.background = Color.white;
			~z36.background = Color.white; ~z12.background = Color.white;
		}
		{button.value == 8}{
			~z25.background = Color.white; ~z1.background = Color.white;
			~z26.background = Color.white; ~z2.background = Color.white;
			~z27.background = Color.white; ~z3.background = Color.white;
			~z28.background = Color.white; ~z4.background = Color.white;
			~z29.background = Color.white; ~z5.background = Color.white;
			~z30.background = Color.white; ~z6.background = Color.white;
			~z31.background = Color.white; ~z7.background = Color.white;
			~z32.background = Color.white; ~z8.background = Color.white;
			~z33.background = Color.green; ~z9.background = Color.green;
			~z34.background = Color.white; ~z10.background = Color.white;
			~z35.background = Color.white; ~z11.background = Color.white;
			~z36.background = Color.white; ~z12.background = Color.white;
		}
		{button.value == 9}{
			~z25.background = Color.white; ~z1.background = Color.white;
			~z26.background = Color.white; ~z2.background = Color.white;
			~z27.background = Color.white; ~z3.background = Color.white;
			~z28.background = Color.white; ~z4.background = Color.white;
			~z29.background = Color.white; ~z5.background = Color.white;
			~z30.background = Color.white; ~z6.background = Color.white;
			~z31.background = Color.white; ~z7.background = Color.white;
			~z32.background = Color.white; ~z8.background = Color.white;
			~z33.background = Color.white; ~z9.background = Color.white;
			~z34.background = Color.green; ~z10.background = Color.green;
			~z35.background = Color.white; ~z11.background = Color.white;
			~z36.background = Color.white; ~z12.background = Color.white;
		}
		{button.value == 10}{
			~z25.background = Color.white; ~z1.background = Color.white;
			~z26.background = Color.white; ~z2.background = Color.white;
			~z27.background = Color.white; ~z3.background = Color.white;
			~z28.background = Color.white; ~z4.background = Color.white;
			~z29.background = Color.white; ~z5.background = Color.white;
			~z30.background = Color.white; ~z6.background = Color.white;
			~z31.background = Color.white; ~z7.background = Color.white;
			~z32.background = Color.white; ~z8.background = Color.white;
			~z33.background = Color.white; ~z9.background = Color.white;
			~z34.background = Color.white; ~z10.background = Color.white;
			~z35.background = Color.green; ~z11.background = Color.green;
			~z36.background = Color.white; ~z12.background = Color.white;
		}
		{button.value == 11}{
			~z25.background = Color.white; ~z1.background = Color.white;
			~z26.background = Color.white; ~z2.background = Color.white;
			~z27.background = Color.white; ~z3.background = Color.white;
			~z28.background = Color.white; ~z4.background = Color.white;
			~z29.background = Color.white; ~z5.background = Color.white;
			~z30.background = Color.white; ~z6.background = Color.white;
			~z31.background = Color.white; ~z7.background = Color.white;
			~z32.background = Color.white; ~z8.background = Color.white;
			~z33.background = Color.white; ~z9.background = Color.white;
			~z34.background = Color.white; ~z10.background = Color.white;
			~z35.background = Color.white; ~z11.background = Color.white;
			~z36.background = Color.green; ~z12.background = Color.green;
		}

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
		if(unicode == ~escape_unicode, {w.minimize;});


		//keyboard number actions

		case
		{unicode == ~one_unicode}{keycodeb.valueAction_(0)}
		{unicode == ~two_unicode}{keycodeb.valueAction_(1)}
		{unicode == ~three_unicode}{keycodeb.valueAction_(2)}
		{unicode == ~four_unicode}{keycodeb.valueAction_(3)}
		{unicode == ~five_unicode}{keycodeb.valueAction_(4)}
		{unicode == ~six_unicode}{keycodeb.valueAction_(5)}
		{unicode == ~seven_unicode}{keycodeb.valueAction_(6)}
		{unicode == ~eight_unicode}{keycodeb.valueAction_(7)}
		{unicode == ~nine_unicode}{keycodeb.valueAction_(8)}
		{unicode == ~ten_unicode}{keycodeb.valueAction_(9)}
		{unicode == ~eleven_unicode}{keycodeb.valueAction_(10)}
		{unicode == ~twelve_unicode}{keycodeb.valueAction_(11)}


		//keyboard up/down arrow actions

		{(keycode == ~uparrow_keycode) or: (unicode == ~i_unicode)}{keycodeb.valueAction_(keycodeb.value-1)}
		{(keycode == ~downarrow_keycode) or: (unicode == ~k_unicode)}{keycodeb.valueAction_(keycodeb.value+1)};


		//set synth frequency using left/right arrow keys or j/l keys

		if((~f1 >= ~freqmap.at(127)), {~freqmap.at(127)},
			{if((keycodeb.value == 0) and: ((keycode == ~rightarrow_keycode) or: (unicode == ~l_unicode)), {
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
				if((~f1 > ~outmaxa) or: (~f1 < ~outmina), {~z25.close;~z1.close;~z25 = (CompositeView(w, Rect((~f1.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+10, ~nw, 2)).background = Color.white;);}, {~z1.close;~z25.close;~z1 = (CompositeView(w, Rect((~f1.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+10, ~nw, 2)).background = Color.white;);});
				~z25.background = Color.green; ~z1.background = Color.green;
				~z26.background = Color.white; ~z2.background = Color.white;
				~z27.background = Color.white; ~z3.background = Color.white;
				~z28.background = Color.white; ~z4.background = Color.white;
				~z29.background = Color.white; ~z5.background = Color.white;
				~z30.background = Color.white; ~z6.background = Color.white;
				~z31.background = Color.white; ~z7.background = Color.white;
				~z32.background = Color.white; ~z8.background = Color.white;
				~z33.background = Color.white; ~z9.background = Color.white;
				~z34.background = Color.white; ~z10.background = Color.white;
				~z35.background = Color.white; ~z11.background = Color.white;
				~z36.background = Color.white; ~z12.background = Color.white;
		});});
		if((~f1 <= ~freqmap.at(0)), {~freqmap.at(0)},
			{if((keycodeb.value == 0) and: ((keycode == ~leftarrow_keycode) or: (unicode == ~j_unicode)), {
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
				if((~f1 > ~outmaxa) or: (~f1 < ~outmina), {~z25.close;~z1.close;~z25 = (CompositeView(w, Rect((~f1.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+10, ~nw, 2)).background = Color.white;);}, {~z1.close;~z25.close;~z1 = (CompositeView(w, Rect((~f1.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+10, ~nw, 2)).background = Color.white;);});

				~z25.background = Color.green; ~z1.background = Color.green;
				~z26.background = Color.white; ~z2.background = Color.white;
				~z27.background = Color.white; ~z3.background = Color.white;
				~z28.background = Color.white; ~z4.background = Color.white;
				~z29.background = Color.white; ~z5.background = Color.white;
				~z30.background = Color.white; ~z6.background = Color.white;
				~z31.background = Color.white; ~z7.background = Color.white;
				~z32.background = Color.white; ~z8.background = Color.white;
				~z33.background = Color.white; ~z9.background = Color.white;
				~z34.background = Color.white; ~z10.background = Color.white;
				~z35.background = Color.white; ~z11.background = Color.white;
				~z36.background = Color.white; ~z12.background = Color.white;
		});});

		if((~f2 >= ~freqmap.at(127)), {~freqmap.at(127)},
			{if((keycodeb.value == 1) and: ((keycode == ~rightarrow_keycode) or: (unicode == ~l_unicode)), {
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
				if((~f2 > ~outmaxa) or: (~f2 < ~outmina), {~z26.close;~z2.close;~z26 = (CompositeView(w, Rect((~f2.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+20, ~nw, 2)).background = Color.white;);}, {~z2.close;~z26.close;~z2 = (CompositeView(w, Rect((~f2.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+20, ~nw, 2)).background = Color.white;);});
				~z25.background = Color.white; ~z1.background = Color.white;
				~z26.background = Color.green; ~z2.background = Color.green;
				~z27.background = Color.white; ~z3.background = Color.white;
				~z28.background = Color.white; ~z4.background = Color.white;
				~z29.background = Color.white; ~z5.background = Color.white;
				~z30.background = Color.white; ~z6.background = Color.white;
				~z31.background = Color.white; ~z7.background = Color.white;
				~z32.background = Color.white; ~z8.background = Color.white;
				~z33.background = Color.white; ~z9.background = Color.white;
				~z34.background = Color.white; ~z10.background = Color.white;
				~z35.background = Color.white; ~z11.background = Color.white;
				~z36.background = Color.white; ~z12.background = Color.white;
		});});
		if((~f2 <= ~freqmap.at(0)), {~freqmap.at(0)},
			{if((keycodeb.value == 1) and: ((keycode == ~leftarrow_keycode) or: (unicode == ~j_unicode)), {
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
				if((~f2 > ~outmaxa) or: (~f2 < ~outmina), {~z26.close;~z2.close;~z26 = (CompositeView(w, Rect((~f2.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+20, ~nw, 2)).background = Color.white;);}, {~z2.close;~z26.close;~z2 = (CompositeView(w, Rect((~f2.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+20, ~nw, 2)).background = Color.white;);});

				~z25.background = Color.white; ~z1.background = Color.white;
				~z26.background = Color.green; ~z2.background = Color.green;
				~z27.background = Color.white; ~z3.background = Color.white;
				~z28.background = Color.white; ~z4.background = Color.white;
				~z29.background = Color.white; ~z5.background = Color.white;
				~z30.background = Color.white; ~z6.background = Color.white;
				~z31.background = Color.white; ~z7.background = Color.white;
				~z32.background = Color.white; ~z8.background = Color.white;
				~z33.background = Color.white; ~z9.background = Color.white;
				~z34.background = Color.white; ~z10.background = Color.white;
				~z35.background = Color.white; ~z11.background = Color.white;
				~z36.background = Color.white; ~z12.background = Color.white;
		});});

		if((~f3 >= ~freqmap.at(127)), {~freqmap.at(127)},
			{if((keycodeb.value == 2) and: ((keycode == ~rightarrow_keycode) or: (unicode == ~l_unicode)), {
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
				if((~f3 > ~outmaxa) or: (~f3 < ~outmina), {~z27.close;~z3.close;~z27 = (CompositeView(w, Rect((~f3.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+30, ~nw, 2)).background = Color.white;);}, {~z3.close;~z27.close;~z3 = (CompositeView(w, Rect((~f3.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+30, ~nw, 2)).background = Color.white;);});
				~z25.background = Color.white; ~z1.background = Color.white;
				~z26.background = Color.white; ~z2.background = Color.white;
				~z27.background = Color.green; ~z3.background = Color.green;
				~z28.background = Color.white; ~z4.background = Color.white;
				~z29.background = Color.white; ~z5.background = Color.white;
				~z30.background = Color.white; ~z6.background = Color.white;
				~z31.background = Color.white; ~z7.background = Color.white;
				~z32.background = Color.white; ~z8.background = Color.white;
				~z33.background = Color.white; ~z9.background = Color.white;
				~z34.background = Color.white; ~z10.background = Color.white;
				~z35.background = Color.white; ~z11.background = Color.white;
				~z36.background = Color.white; ~z12.background = Color.white;
		});});
		if((~f3 <= ~freqmap.at(0)), {~freqmap.at(0)},
			{if((keycodeb.value == 2) and: ((keycode == ~leftarrow_keycode) or: (unicode == ~j_unicode)), {
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
				if((~f3 > ~outmaxa) or: (~f3 < ~outmina), {~z27.close;~z3.close;~z27 = (CompositeView(w, Rect((~f3.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+30, ~nw, 2)).background = Color.white;);}, {~z3.close;~z27.close;~z3 = (CompositeView(w, Rect((~f3.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+30, ~nw, 2)).background = Color.white;);});

				~z25.background = Color.white; ~z1.background = Color.white;
				~z26.background = Color.white; ~z2.background = Color.white;
				~z27.background = Color.green; ~z3.background = Color.green;
				~z28.background = Color.white; ~z4.background = Color.white;
				~z29.background = Color.white; ~z5.background = Color.white;
				~z30.background = Color.white; ~z6.background = Color.white;
				~z31.background = Color.white; ~z7.background = Color.white;
				~z32.background = Color.white; ~z8.background = Color.white;
				~z33.background = Color.white; ~z9.background = Color.white;
				~z34.background = Color.white; ~z10.background = Color.white;
				~z35.background = Color.white; ~z11.background = Color.white;
				~z36.background = Color.white; ~z12.background = Color.white;
		});});

		if((~f4 >= ~freqmap.at(127)), {~freqmap.at(127)},
			{if((keycodeb.value == 3) and: ((keycode == ~rightarrow_keycode) or: (unicode == ~l_unicode)), {
				~freqmapval4 = ~f4.cpsmidi.round;
				case
				{~l1a.isRunning == true}{
					~l4a.set(\dur, ~f4 = ~freqmap.at(~freqmapval4 = ~freqmapval4.value+1));
					~l4b.set(\dur, ~f4);
					~l4c.set(\dur, ~f4/~icd3);
					~l4d.set(\dur, ~f4/~icd3);
					~l4e.set(\dur, ~f4/~icd6);
					~l4f.set(\dur, ~f4/~icd6);
				}
				{~l1a1.isRunning == true}{
					~l4a1.set(\dur, ~f4 = ~freqmap.at(~freqmapval4 = ~freqmapval4.value+1));
					~l4b1.set(\dur, ~f4);
					~l4c1.set(\dur, ~f4/~icd3);
					~l4d1.set(\dur, ~f4/~icd3);
					~l4e1.set(\dur, ~f4/~icd6);
					~l4f1.set(\dur, ~f4/~icd6);
				};
				if((~f4 > ~outmaxa) or: (~f4 < ~outmina), {~z28.close;~z4.close;~z28 = (CompositeView(w, Rect((~f4.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+40, ~nw, 2)).background = Color.white;);}, {~z4.close;~z28.close;~z4 = (CompositeView(w, Rect((~f4.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+40, ~nw, 2)).background = Color.white;);});
				~z25.background = Color.white; ~z1.background = Color.white;
				~z26.background = Color.white; ~z2.background = Color.white;
				~z27.background = Color.white; ~z3.background = Color.white;
				~z28.background = Color.green; ~z4.background = Color.green;
				~z29.background = Color.white; ~z5.background = Color.white;
				~z30.background = Color.white; ~z6.background = Color.white;
				~z31.background = Color.white; ~z7.background = Color.white;
				~z32.background = Color.white; ~z8.background = Color.white;
				~z33.background = Color.white; ~z9.background = Color.white;
				~z34.background = Color.white; ~z10.background = Color.white;
				~z35.background = Color.white; ~z11.background = Color.white;
				~z36.background = Color.white; ~z12.background = Color.white;
		});});
		if((~f4 <= ~freqmap.at(0)), {~freqmap.at(0)},
			{if((keycodeb.value == 3) and: ((keycode == ~leftarrow_keycode) or: (unicode == ~j_unicode)), {
				~freqmapval4 = ~f4.cpsmidi.round;
				case
				{~l1a.isRunning == true}{
					~l4a.set(\dur, ~f4 = ~freqmap.at(~freqmapval4 = ~freqmapval4.value-1));
					~l4b.set(\dur, ~f4);
					~l4c.set(\dur, ~f4/~icd3);
					~l4d.set(\dur, ~f4/~icd3);
					~l4e.set(\dur, ~f4/~icd6);
					~l4f.set(\dur, ~f4/~icd6);
				}
				{~l1a1.isRunning == true}{
					~l4a1.set(\dur, ~f4 = ~freqmap.at(~freqmapval4 = ~freqmapval4.value-1));
					~l4b1.set(\dur, ~f4);
					~l4c1.set(\dur, ~f4/~icd3);
					~l4d1.set(\dur, ~f4/~icd3);
					~l4e1.set(\dur, ~f4/~icd6);
					~l4f1.set(\dur, ~f4/~icd6);
				};
				if((~f4 > ~outmaxa) or: (~f4 < ~outmina), {~z28.close;~z4.close;~z28 = (CompositeView(w, Rect((~f4.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+40, ~nw, 2)).background = Color.white;);}, {~z4.close;~z28.close;~z4 = (CompositeView(w, Rect((~f4.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+40, ~nw, 2)).background = Color.white;);});

				~z25.background = Color.white; ~z1.background = Color.white;
				~z26.background = Color.white; ~z2.background = Color.white;
				~z27.background = Color.white; ~z3.background = Color.white;
				~z28.background = Color.green; ~z4.background = Color.green;
				~z29.background = Color.white; ~z5.background = Color.white;
				~z30.background = Color.white; ~z6.background = Color.white;
				~z31.background = Color.white; ~z7.background = Color.white;
				~z32.background = Color.white; ~z8.background = Color.white;
				~z33.background = Color.white; ~z9.background = Color.white;
				~z34.background = Color.white; ~z10.background = Color.white;
				~z35.background = Color.white; ~z11.background = Color.white;
				~z36.background = Color.white; ~z12.background = Color.white;
		});});

		if((~f5 >= ~freqmap.at(127)), {~freqmap.at(127)},
			{if((keycodeb.value == 4) and: ((keycode == ~rightarrow_keycode) or: (unicode == ~l_unicode)), {
				~freqmapval5 = ~f5.cpsmidi.round;
				case
				{~l1a.isRunning == true}{
					~l5a.set(\dur, ~f5 = ~freqmap.at(~freqmapval5 = ~freqmapval5.value+1));
					~l5b.set(\dur, ~f5);
					~l5c.set(\dur, ~f5/~icd3);
					~l5d.set(\dur, ~f5/~icd3);
					~l5e.set(\dur, ~f5/~icd6);
					~l5f.set(\dur, ~f5/~icd6);
				}
				{~l1a1.isRunning == true}{
					~l5a1.set(\dur, ~f5 = ~freqmap.at(~freqmapval5 = ~freqmapval5.value+1));
					~l5b1.set(\dur, ~f5);
					~l5c1.set(\dur, ~f5/~icd3);
					~l5d1.set(\dur, ~f5/~icd3);
					~l5e1.set(\dur, ~f5/~icd6);
					~l5f1.set(\dur, ~f5/~icd6);
				};
				if((~f5 > ~outmaxa) or: (~f5 < ~outmina), {~z29.close;~z5.close;~z29 = (CompositeView(w, Rect((~f5.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+50, ~nw, 2)).background = Color.white;);}, {~z5.close;~z29.close;~z5 = (CompositeView(w, Rect((~f5.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+50, ~nw, 2)).background = Color.white;);});
				~z25.background = Color.white; ~z1.background = Color.white;
				~z26.background = Color.white; ~z2.background = Color.white;
				~z27.background = Color.white; ~z3.background = Color.white;
				~z28.background = Color.white; ~z4.background = Color.white;
				~z29.background = Color.green; ~z5.background = Color.green;
				~z30.background = Color.white; ~z6.background = Color.white;
				~z31.background = Color.white; ~z7.background = Color.white;
				~z32.background = Color.white; ~z8.background = Color.white;
				~z33.background = Color.white; ~z9.background = Color.white;
				~z34.background = Color.white; ~z10.background = Color.white;
				~z35.background = Color.white; ~z11.background = Color.white;
				~z36.background = Color.white; ~z12.background = Color.white;
		});});
		if((~f5 <= ~freqmap.at(0)), {~freqmap.at(0)},
			{if((keycodeb.value == 4) and: ((keycode == ~leftarrow_keycode) or: (unicode == ~j_unicode)), {
				~freqmapval5 = ~f5.cpsmidi.round;
				case
				{~l1a.isRunning == true}{
					~l5a.set(\dur, ~f5 = ~freqmap.at(~freqmapval5 = ~freqmapval5.value-1));
					~l5b.set(\dur, ~f5);
					~l5c.set(\dur, ~f5/~icd3);
					~l5d.set(\dur, ~f5/~icd3);
					~l5e.set(\dur, ~f5/~icd6);
					~l5f.set(\dur, ~f5/~icd6);
				}
				{~l1a1.isRunning == true}{
					~l5a1.set(\dur, ~f5 = ~freqmap.at(~freqmapval5 = ~freqmapval5.value-1));
					~l5b1.set(\dur, ~f5);
					~l5c1.set(\dur, ~f5/~icd3);
					~l5d1.set(\dur, ~f5/~icd3);
					~l5e1.set(\dur, ~f5/~icd6);
					~l5f1.set(\dur, ~f5/~icd6);
				};
				if((~f5 > ~outmaxa) or: (~f5 < ~outmina), {~z29.close;~z5.close;~z29 = (CompositeView(w, Rect((~f5.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+50, ~nw, 2)).background = Color.white;);}, {~z5.close;~z29.close;~z5 = (CompositeView(w, Rect((~f5.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+50, ~nw, 2)).background = Color.white;);});

				~z25.background = Color.white; ~z1.background = Color.white;
				~z26.background = Color.white; ~z2.background = Color.white;
				~z27.background = Color.white; ~z3.background = Color.white;
				~z28.background = Color.white; ~z4.background = Color.white;
				~z29.background = Color.green; ~z5.background = Color.green;
				~z30.background = Color.white; ~z6.background = Color.white;
				~z31.background = Color.white; ~z7.background = Color.white;
				~z32.background = Color.white; ~z8.background = Color.white;
				~z33.background = Color.white; ~z9.background = Color.white;
				~z34.background = Color.white; ~z10.background = Color.white;
				~z35.background = Color.white; ~z11.background = Color.white;
				~z36.background = Color.white; ~z12.background = Color.white;
		});});

		if((~f6 >= ~freqmap.at(127)), {~freqmap.at(127)},
			{if((keycodeb.value == 5) and: ((keycode == ~rightarrow_keycode) or: (unicode == ~l_unicode)), {
				~freqmapval6 = ~f6.cpsmidi.round;
				case
				{~l1a.isRunning == true}{
					~l6a.set(\dur, ~f6 = ~freqmap.at(~freqmapval6 = ~freqmapval6.value+1));
					~l6b.set(\dur, ~f6);
					~l6c.set(\dur, ~f6/~icd3);
					~l6d.set(\dur, ~f6/~icd3);
					~l6e.set(\dur, ~f6/~icd6);
					~l6f.set(\dur, ~f6/~icd6);
				}
				{~l1a1.isRunning == true}{
					~l6a1.set(\dur, ~f6 = ~freqmap.at(~freqmapval6 = ~freqmapval6.value+1));
					~l6b1.set(\dur, ~f6);
					~l6c1.set(\dur, ~f6/~icd3);
					~l6d1.set(\dur, ~f6/~icd3);
					~l6e1.set(\dur, ~f6/~icd6);
					~l6f1.set(\dur, ~f6/~icd6);
				};
				if((~f6 > ~outmaxa) or: (~f6 < ~outmina), {~z30.close;~z6.close;~z30 = (CompositeView(w, Rect((~f6.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+60, ~nw, 2)).background = Color.white;);}, {~z6.close;~z30.close;~z6 = (CompositeView(w, Rect((~f6.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+60, ~nw, 2)).background = Color.white;);});
				~z25.background = Color.white; ~z1.background = Color.white;
				~z26.background = Color.white; ~z2.background = Color.white;
				~z27.background = Color.white; ~z3.background = Color.white;
				~z28.background = Color.white; ~z4.background = Color.white;
				~z29.background = Color.white; ~z5.background = Color.white;
				~z30.background = Color.green; ~z6.background = Color.green;
				~z31.background = Color.white; ~z7.background = Color.white;
				~z32.background = Color.white; ~z8.background = Color.white;
				~z33.background = Color.white; ~z9.background = Color.white;
				~z34.background = Color.white; ~z10.background = Color.white;
				~z35.background = Color.white; ~z11.background = Color.white;
				~z36.background = Color.white; ~z12.background = Color.white;
		});});
		if((~f6 <= ~freqmap.at(0)), {~freqmap.at(0)},
			{if((keycodeb.value == 5) and: ((keycode == ~leftarrow_keycode) or: (unicode == ~j_unicode)), {
				~freqmapval6 = ~f6.cpsmidi.round;
				case
				{~l1a.isRunning == true}{
					~l6a.set(\dur, ~f6 = ~freqmap.at(~freqmapval6 = ~freqmapval6.value-1));
					~l6b.set(\dur, ~f6);
					~l6c.set(\dur, ~f6/~icd3);
					~l6d.set(\dur, ~f6/~icd3);
					~l6e.set(\dur, ~f6/~icd6);
					~l6f.set(\dur, ~f6/~icd6);
				}
				{~l1a1.isRunning == true}{
					~l6a1.set(\dur, ~f6 = ~freqmap.at(~freqmapval6 = ~freqmapval6.value-1));
					~l6b1.set(\dur, ~f6);
					~l6c1.set(\dur, ~f6/~icd3);
					~l6d1.set(\dur, ~f6/~icd3);
					~l6e1.set(\dur, ~f6/~icd6);
					~l6f1.set(\dur, ~f6/~icd6);
				};
				if((~f6 > ~outmaxa) or: (~f6 < ~outmina), {~z30.close;~z6.close;~z30 = (CompositeView(w, Rect((~f6.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+60, ~nw, 2)).background = Color.white;);}, {~z6.close;~z30.close;~z6 = (CompositeView(w, Rect((~f6.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+60, ~nw, 2)).background = Color.white;);});

				~z25.background = Color.white; ~z1.background = Color.white;
				~z26.background = Color.white; ~z2.background = Color.white;
				~z27.background = Color.white; ~z3.background = Color.white;
				~z28.background = Color.white; ~z4.background = Color.white;
				~z29.background = Color.white; ~z5.background = Color.white;
				~z30.background = Color.green; ~z6.background = Color.green;
				~z31.background = Color.white; ~z7.background = Color.white;
				~z32.background = Color.white; ~z8.background = Color.white;
				~z33.background = Color.white; ~z9.background = Color.white;
				~z34.background = Color.white; ~z10.background = Color.white;
				~z35.background = Color.white; ~z11.background = Color.white;
				~z36.background = Color.white; ~z12.background = Color.white;
		});});

		if((~f7 >= ~freqmap.at(127)), {~freqmap.at(127)},
			{if((keycodeb.value == 6) and: ((keycode == ~rightarrow_keycode) or: (unicode == ~l_unicode)), {
				~freqmapval7 = ~f7.cpsmidi.round;
				case
				{~l1a.isRunning == true}{
					~l7a.set(\dur, ~f7 = ~freqmap.at(~freqmapval7 = ~freqmapval7.value+1));
					~l7b.set(\dur, ~f7);
					~l7c.set(\dur, ~f7/~icd3);
					~l7d.set(\dur, ~f7/~icd3);
					~l7e.set(\dur, ~f7/~icd6);
					~l7f.set(\dur, ~f7/~icd6);
				}
				{~l1a1.isRunning == true}{
					~l7a1.set(\dur, ~f7 = ~freqmap.at(~freqmapval7 = ~freqmapval7.value+1));
					~l7b1.set(\dur, ~f7);
					~l7c1.set(\dur, ~f7/~icd3);
					~l7d1.set(\dur, ~f7/~icd3);
					~l7e1.set(\dur, ~f7/~icd6);
					~l7f1.set(\dur, ~f7/~icd6);
				};
				if((~f7 > ~outmaxa) or: (~f7 < ~outmina), {~z31.close;~z7.close;~z31 = (CompositeView(w, Rect((~f7.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+70, ~nw, 2)).background = Color.white;);}, {~z7.close;~z31.close;~z7 = (CompositeView(w, Rect((~f7.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+70, ~nw, 2)).background = Color.white;);});
				~z25.background = Color.white; ~z1.background = Color.white;
				~z26.background = Color.white; ~z2.background = Color.white;
				~z27.background = Color.white; ~z3.background = Color.white;
				~z28.background = Color.white; ~z4.background = Color.white;
				~z29.background = Color.white; ~z5.background = Color.white;
				~z30.background = Color.white; ~z6.background = Color.white;
				~z31.background = Color.green; ~z7.background = Color.green;
				~z32.background = Color.white; ~z8.background = Color.white;
				~z33.background = Color.white; ~z9.background = Color.white;
				~z34.background = Color.white; ~z10.background = Color.white;
				~z35.background = Color.white; ~z11.background = Color.white;
				~z36.background = Color.white; ~z12.background = Color.white;
		});});
		if((~f7 <= ~freqmap.at(0)), {~freqmap.at(0)},
			{if((keycodeb.value == 6) and: ((keycode == ~leftarrow_keycode) or: (unicode == ~j_unicode)), {
				~freqmapval7 = ~f7.cpsmidi.round;
				case
				{~l1a.isRunning == true}{
					~l7a.set(\dur, ~f7 = ~freqmap.at(~freqmapval7 = ~freqmapval7.value-1));
					~l7b.set(\dur, ~f7);
					~l7c.set(\dur, ~f7/~icd3);
					~l7d.set(\dur, ~f7/~icd3);
					~l7e.set(\dur, ~f7/~icd6);
					~l7f.set(\dur, ~f7/~icd6);
				}
				{~l1a1.isRunning == true}{
					~l7a1.set(\dur, ~f7 = ~freqmap.at(~freqmapval7 = ~freqmapval7.value-1));
					~l7b1.set(\dur, ~f7);
					~l7c1.set(\dur, ~f7/~icd3);
					~l7d1.set(\dur, ~f7/~icd3);
					~l7e1.set(\dur, ~f7/~icd6);
					~l7f1.set(\dur, ~f7/~icd6);
				};
				if((~f7 > ~outmaxa) or: (~f7 < ~outmina), {~z31.close;~z7.close;~z31 = (CompositeView(w, Rect((~f7.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+70, ~nw, 2)).background = Color.white;);}, {~z7.close;~z31.close;~z7 = (CompositeView(w, Rect((~f7.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+70, ~nw, 2)).background = Color.white;);});

				~z25.background = Color.white; ~z1.background = Color.white;
				~z26.background = Color.white; ~z2.background = Color.white;
				~z27.background = Color.white; ~z3.background = Color.white;
				~z28.background = Color.white; ~z4.background = Color.white;
				~z29.background = Color.white; ~z5.background = Color.white;
				~z30.background = Color.white; ~z6.background = Color.white;
				~z31.background = Color.green; ~z7.background = Color.green;
				~z32.background = Color.white; ~z8.background = Color.white;
				~z33.background = Color.white; ~z9.background = Color.white;
				~z34.background = Color.white; ~z10.background = Color.white;
				~z35.background = Color.white; ~z11.background = Color.white;
				~z36.background = Color.white; ~z12.background = Color.white;
		});});

		if((~f8 >= ~freqmap.at(127)), {~freqmap.at(127)},
			{if((keycodeb.value == 7) and: ((keycode == ~rightarrow_keycode) or: (unicode == ~l_unicode)), {
				~freqmapval8 = ~f8.cpsmidi.round;
				case
				{~l1a.isRunning == true}{
					~l8a.set(\dur, ~f8 = ~freqmap.at(~freqmapval8 = ~freqmapval8.value+1));
					~l8b.set(\dur, ~f8);
					~l8c.set(\dur, ~f8/~icd3);
					~l8d.set(\dur, ~f8/~icd3);
					~l8e.set(\dur, ~f8/~icd6);
					~l8f.set(\dur, ~f8/~icd6);
				}
				{~l1a1.isRunning == true}{
					~l8a1.set(\dur, ~f8 = ~freqmap.at(~freqmapval8 = ~freqmapval8.value+1));
					~l8b1.set(\dur, ~f8);
					~l8c1.set(\dur, ~f8/~icd3);
					~l8d1.set(\dur, ~f8/~icd3);
					~l8e1.set(\dur, ~f8/~icd6);
					~l8f1.set(\dur, ~f8/~icd6);
				};
				if((~f8 > ~outmaxa) or: (~f8 < ~outmina), {~z32.close;~z8.close;~z32 = (CompositeView(w, Rect((~f8.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+80, ~nw, 2)).background = Color.white;);}, {~z8.close;~z32.close;~z8 = (CompositeView(w, Rect((~f8.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+80, ~nw, 2)).background = Color.white;);});
				~z25.background = Color.white; ~z1.background = Color.white;
				~z26.background = Color.white; ~z2.background = Color.white;
				~z27.background = Color.white; ~z3.background = Color.white;
				~z28.background = Color.white; ~z4.background = Color.white;
				~z29.background = Color.white; ~z5.background = Color.white;
				~z30.background = Color.white; ~z6.background = Color.white;
				~z31.background = Color.white; ~z7.background = Color.white;
				~z32.background = Color.green; ~z8.background = Color.green;
				~z33.background = Color.white; ~z9.background = Color.white;
				~z34.background = Color.white; ~z10.background = Color.white;
				~z35.background = Color.white; ~z11.background = Color.white;
				~z36.background = Color.white; ~z12.background = Color.white;
		});});
		if((~f8 <= ~freqmap.at(0)), {~freqmap.at(0)},
			{if((keycodeb.value == 7) and: ((keycode == ~leftarrow_keycode) or: (unicode == ~j_unicode)), {
				~freqmapval8 = ~f8.cpsmidi.round;
				case
				{~l1a.isRunning == true}{
					~l8a.set(\dur, ~f8 = ~freqmap.at(~freqmapval8 = ~freqmapval8.value-1));
					~l8b.set(\dur, ~f8);
					~l8c.set(\dur, ~f8/~icd3);
					~l8d.set(\dur, ~f8/~icd3);
					~l8e.set(\dur, ~f8/~icd6);
					~l8f.set(\dur, ~f8/~icd6);
				}
				{~l1a1.isRunning == true}{
					~l8a1.set(\dur, ~f8 = ~freqmap.at(~freqmapval8 = ~freqmapval8.value-1));
					~l8b1.set(\dur, ~f8);
					~l8c1.set(\dur, ~f8/~icd3);
					~l8d1.set(\dur, ~f8/~icd3);
					~l8e1.set(\dur, ~f8/~icd6);
					~l8f1.set(\dur, ~f8/~icd6);
				};
				if((~f8 > ~outmaxa) or: (~f8 < ~outmina), {~z32.close;~z8.close;~z32 = (CompositeView(w, Rect((~f8.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+80, ~nw, 2)).background = Color.white;);}, {~z8.close;~z32.close;~z8 = (CompositeView(w, Rect((~f8.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+80, ~nw, 2)).background = Color.white;);});

				~z25.background = Color.white; ~z1.background = Color.white;
				~z26.background = Color.white; ~z2.background = Color.white;
				~z27.background = Color.white; ~z3.background = Color.white;
				~z28.background = Color.white; ~z4.background = Color.white;
				~z29.background = Color.white; ~z5.background = Color.white;
				~z30.background = Color.white; ~z6.background = Color.white;
				~z31.background = Color.white; ~z7.background = Color.white;
				~z32.background = Color.green; ~z8.background = Color.green;
				~z33.background = Color.white; ~z9.background = Color.white;
				~z34.background = Color.white; ~z10.background = Color.white;
				~z35.background = Color.white; ~z11.background = Color.white;
				~z36.background = Color.white; ~z12.background = Color.white;
		});});

		if((~f9 >= ~freqmap.at(127)), {~freqmap.at(127)},
			{if((keycodeb.value == 8) and: ((keycode == ~rightarrow_keycode) or: (unicode == ~l_unicode)), {
				~freqmapval9 = ~f9.cpsmidi.round;
				case
				{~l1a.isRunning == true}{
					~l9a.set(\dur, ~f9 = ~freqmap.at(~freqmapval9 = ~freqmapval9.value+1));
					~l9b.set(\dur, ~f9);
					~l9c.set(\dur, ~f9/~icd3);
					~l9d.set(\dur, ~f9/~icd3);
					~l9e.set(\dur, ~f9/~icd6);
					~l9f.set(\dur, ~f9/~icd6);
				}
				{~l1a1.isRunning == true}{
					~l9a1.set(\dur, ~f9 = ~freqmap.at(~freqmapval9 = ~freqmapval9.value+1));
					~l9b1.set(\dur, ~f9);
					~l9c1.set(\dur, ~f9/~icd3);
					~l9d1.set(\dur, ~f9/~icd3);
					~l9e1.set(\dur, ~f9/~icd6);
					~l9f1.set(\dur, ~f9/~icd6);
				};
				if((~f9 > ~outmaxa) or: (~f9 < ~outmina), {~z33.close;~z9.close;~z33 = (CompositeView(w, Rect((~f9.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+90, ~nw, 2)).background = Color.white;);}, {~z9.close;~z33.close;~z9 = (CompositeView(w, Rect((~f9.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+90, ~nw, 2)).background = Color.white;);});
				~z25.background = Color.white; ~z1.background = Color.white;
				~z26.background = Color.white; ~z2.background = Color.white;
				~z27.background = Color.white; ~z3.background = Color.white;
				~z28.background = Color.white; ~z4.background = Color.white;
				~z29.background = Color.white; ~z5.background = Color.white;
				~z30.background = Color.white; ~z6.background = Color.white;
				~z31.background = Color.white; ~z7.background = Color.white;
				~z32.background = Color.white; ~z8.background = Color.white;
				~z33.background = Color.green; ~z9.background = Color.green;
				~z34.background = Color.white; ~z10.background = Color.white;
				~z35.background = Color.white; ~z11.background = Color.white;
				~z36.background = Color.white; ~z12.background = Color.white;
		});});
		if((~f9 <= ~freqmap.at(0)), {~freqmap.at(0)},
			{if((keycodeb.value == 8) and: ((keycode == ~leftarrow_keycode) or: (unicode == ~j_unicode)), {
				~freqmapval9 = ~f9.cpsmidi.round;
				case
				{~l1a.isRunning == true}{
					~l9a.set(\dur, ~f9 = ~freqmap.at(~freqmapval9 = ~freqmapval9.value-1));
					~l9b.set(\dur, ~f9);
					~l9c.set(\dur, ~f9/~icd3);
					~l9d.set(\dur, ~f9/~icd3);
					~l9e.set(\dur, ~f9/~icd6);
					~l9f.set(\dur, ~f9/~icd6);
				}
				{~l1a1.isRunning == true}{
					~l9a1.set(\dur, ~f9 = ~freqmap.at(~freqmapval9 = ~freqmapval9.value-1));
					~l9b1.set(\dur, ~f9);
					~l9c1.set(\dur, ~f9/~icd3);
					~l9d1.set(\dur, ~f9/~icd3);
					~l9e1.set(\dur, ~f9/~icd6);
					~l9f1.set(\dur, ~f9/~icd6);
				};
				if((~f9 > ~outmaxa) or: (~f9 < ~outmina), {~z33.close;~z9.close;~z33 = (CompositeView(w, Rect((~f9.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+90, ~nw, 2)).background = Color.white;);}, {~z9.close;~z33.close;~z9 = (CompositeView(w, Rect((~f9.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+90, ~nw, 2)).background = Color.white;);});

				~z25.background = Color.white; ~z1.background = Color.white;
				~z26.background = Color.white; ~z2.background = Color.white;
				~z27.background = Color.white; ~z3.background = Color.white;
				~z28.background = Color.white; ~z4.background = Color.white;
				~z29.background = Color.white; ~z5.background = Color.white;
				~z30.background = Color.white; ~z6.background = Color.white;
				~z31.background = Color.white; ~z7.background = Color.white;
				~z32.background = Color.white; ~z8.background = Color.white;
				~z33.background = Color.green; ~z9.background = Color.green;
				~z34.background = Color.white; ~z10.background = Color.white;
				~z35.background = Color.white; ~z11.background = Color.white;
				~z36.background = Color.white; ~z12.background = Color.white;
		});});

		if((~f10 >= ~freqmap.at(127)), {~freqmap.at(127)},
			{if((keycodeb.value == 9) and: ((keycode == ~rightarrow_keycode) or: (unicode == ~l_unicode)), {
				~freqmapval10 = ~f10.cpsmidi.round;
				case
				{~l1a.isRunning == true}{
					~l10a.set(\dur, ~f10 = ~freqmap.at(~freqmapval10 = ~freqmapval10.value+1));
					~l10b.set(\dur, ~f10);
					~l10c.set(\dur, ~f10/~icd3);
					~l10d.set(\dur, ~f10/~icd3);
					~l10e.set(\dur, ~f10/~icd6);
					~l10f.set(\dur, ~f10/~icd6);
				}
				{~l1a1.isRunning == true}{
					~l10a1.set(\dur, ~f10 = ~freqmap.at(~freqmapval10 = ~freqmapval10.value+1));
					~l10b1.set(\dur, ~f10);
					~l10c1.set(\dur, ~f10/~icd3);
					~l10d1.set(\dur, ~f10/~icd3);
					~l10e1.set(\dur, ~f10/~icd6);
					~l10f1.set(\dur, ~f10/~icd6);
				};
				if((~f10 > ~outmaxa) or: (~f10 < ~outmina), {~z34.close;~z10.close;~z34 = (CompositeView(w, Rect((~f10.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+100, ~nw, 2)).background = Color.white;);}, {~z10.close;~z34.close;~z10 = (CompositeView(w, Rect((~f10.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+100, ~nw, 2)).background = Color.white;);});
				~z25.background = Color.white; ~z1.background = Color.white;
				~z26.background = Color.white; ~z2.background = Color.white;
				~z27.background = Color.white; ~z3.background = Color.white;
				~z28.background = Color.white; ~z4.background = Color.white;
				~z29.background = Color.white; ~z5.background = Color.white;
				~z30.background = Color.white; ~z6.background = Color.white;
				~z31.background = Color.white; ~z7.background = Color.white;
				~z32.background = Color.white; ~z8.background = Color.white;
				~z33.background = Color.white; ~z9.background = Color.white;
				~z34.background = Color.green; ~z10.background = Color.green;
				~z35.background = Color.white; ~z11.background = Color.white;
				~z36.background = Color.white; ~z12.background = Color.white;
		});});
		if((~f10 <= ~freqmap.at(0)), {~freqmap.at(0)},
			{if((keycodeb.value == 9) and: ((keycode == ~leftarrow_keycode) or: (unicode == ~j_unicode)), {
				~freqmapval10 = ~f10.cpsmidi.round;
				case
				{~l1a.isRunning == true}{
					~l10a.set(\dur, ~f10 = ~freqmap.at(~freqmapval10 = ~freqmapval10.value-1));
					~l10b.set(\dur, ~f10);
					~l10c.set(\dur, ~f10/~icd3);
					~l10d.set(\dur, ~f10/~icd3);
					~l10e.set(\dur, ~f10/~icd6);
					~l10f.set(\dur, ~f10/~icd6);
				}
				{~l1a1.isRunning == true}{
					~l10a1.set(\dur, ~f10 = ~freqmap.at(~freqmapval10 = ~freqmapval10.value-1));
					~l10b1.set(\dur, ~f10);
					~l10c1.set(\dur, ~f10/~icd3);
					~l10d1.set(\dur, ~f10/~icd3);
					~l10e1.set(\dur, ~f10/~icd6);
					~l10f1.set(\dur, ~f10/~icd6);
				};
				if((~f10 > ~outmaxa) or: (~f10 < ~outmina), {~z34.close;~z10.close;~z34 = (CompositeView(w, Rect((~f10.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+100, ~nw, 2)).background = Color.white;);}, {~z10.close;~z34.close;~z10 = (CompositeView(w, Rect((~f10.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+100, ~nw, 2)).background = Color.white;);});

				~z25.background = Color.white; ~z1.background = Color.white;
				~z26.background = Color.white; ~z2.background = Color.white;
				~z27.background = Color.white; ~z3.background = Color.white;
				~z28.background = Color.white; ~z4.background = Color.white;
				~z29.background = Color.white; ~z5.background = Color.white;
				~z30.background = Color.white; ~z6.background = Color.white;
				~z31.background = Color.white; ~z7.background = Color.white;
				~z32.background = Color.white; ~z8.background = Color.white;
				~z33.background = Color.white; ~z9.background = Color.white;
				~z34.background = Color.green; ~z10.background = Color.green;
				~z35.background = Color.white; ~z11.background = Color.white;
				~z36.background = Color.white; ~z12.background = Color.white;
		});});

		if((~f11 >= ~freqmap.at(127)), {~freqmap.at(127)},
			{if((keycodeb.value == 10) and: ((keycode == ~rightarrow_keycode) or: (unicode == ~l_unicode)), {
				~freqmapval11 = ~f11.cpsmidi.round;
				case
				{~l1a.isRunning == true}{
					~l11a.set(\dur, ~f11 = ~freqmap.at(~freqmapval11 = ~freqmapval11.value+1));
					~l11b.set(\dur, ~f11);
					~l11c.set(\dur, ~f11/~icd3);
					~l11d.set(\dur, ~f11/~icd3);
					~l11e.set(\dur, ~f11/~icd6);
					~l11f.set(\dur, ~f11/~icd6);
				}
				{~l1a1.isRunning == true}{
					~l11a1.set(\dur, ~f11 = ~freqmap.at(~freqmapval11 = ~freqmapval11.value+1));
					~l11b1.set(\dur, ~f11);
					~l11c1.set(\dur, ~f11/~icd3);
					~l11d1.set(\dur, ~f11/~icd3);
					~l11e1.set(\dur, ~f11/~icd6);
					~l11f1.set(\dur, ~f11/~icd6);
				};
				if((~f11 > ~outmaxa) or: (~f11 < ~outmina), {~z35.close;~z11.close;~z35 = (CompositeView(w, Rect((~f11.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+110, ~nw, 2)).background = Color.white;);}, {~z11.close;~z35.close;~z11 = (CompositeView(w, Rect((~f11.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+110, ~nw, 2)).background = Color.white;);});
				~z25.background = Color.white; ~z1.background = Color.white;
				~z26.background = Color.white; ~z2.background = Color.white;
				~z27.background = Color.white; ~z3.background = Color.white;
				~z28.background = Color.white; ~z4.background = Color.white;
				~z29.background = Color.white; ~z5.background = Color.white;
				~z30.background = Color.white; ~z6.background = Color.white;
				~z31.background = Color.white; ~z7.background = Color.white;
				~z32.background = Color.white; ~z8.background = Color.white;
				~z33.background = Color.white; ~z9.background = Color.white;
				~z34.background = Color.white; ~z10.background = Color.white;
				~z35.background = Color.green; ~z11.background = Color.green;
				~z36.background = Color.white; ~z12.background = Color.white;
		});});
		if((~f11 <= ~freqmap.at(0)), {~freqmap.at(0)},
			{if((keycodeb.value == 10) and: ((keycode == ~leftarrow_keycode) or: (unicode == ~j_unicode)), {
				~freqmapval11 = ~f11.cpsmidi.round;
				case
				{~l1a.isRunning == true}{
					~l11a.set(\dur, ~f11 = ~freqmap.at(~freqmapval11 = ~freqmapval11.value-1));
					~l11b.set(\dur, ~f11);
					~l11c.set(\dur, ~f11/~icd3);
					~l11d.set(\dur, ~f11/~icd3);
					~l11e.set(\dur, ~f11/~icd6);
					~l11f.set(\dur, ~f11/~icd6);
				}
				{~l1a1.isRunning == true}{
					~l11a1.set(\dur, ~f11 = ~freqmap.at(~freqmapval11 = ~freqmapval11.value-1));
					~l11b1.set(\dur, ~f11);
					~l11c1.set(\dur, ~f11/~icd3);
					~l11d1.set(\dur, ~f11/~icd3);
					~l11e1.set(\dur, ~f11/~icd6);
					~l11f1.set(\dur, ~f11/~icd6);
				};
				if((~f11 > ~outmaxa) or: (~f11 < ~outmina), {~z35.close;~z11.close;~z35 = (CompositeView(w, Rect((~f11.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+110, ~nw, 2)).background = Color.white;);}, {~z11.close;~z35.close;~z11 = (CompositeView(w, Rect((~f11.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+110, ~nw, 2)).background = Color.white;);});

				~z25.background = Color.white; ~z1.background = Color.white;
				~z26.background = Color.white; ~z2.background = Color.white;
				~z27.background = Color.white; ~z3.background = Color.white;
				~z28.background = Color.white; ~z4.background = Color.white;
				~z29.background = Color.white; ~z5.background = Color.white;
				~z30.background = Color.white; ~z6.background = Color.white;
				~z31.background = Color.white; ~z7.background = Color.white;
				~z32.background = Color.white; ~z8.background = Color.white;
				~z33.background = Color.white; ~z9.background = Color.white;
				~z34.background = Color.white; ~z10.background = Color.white;
				~z35.background = Color.green; ~z11.background = Color.green;
				~z36.background = Color.white; ~z12.background = Color.white;
		});});

		if((~f12 >= ~freqmap.at(127)), {~freqmap.at(127)},
			{if((keycodeb.value == 11) and: ((keycode == ~rightarrow_keycode) or: (unicode == ~l_unicode)), {
				~freqmapval12 = ~f12.cpsmidi.round;
				case
				{~l1a.isRunning == true}{
					~l12a.set(\dur, ~f12 = ~freqmap.at(~freqmapval12 = ~freqmapval12.value+1));
					~l12b.set(\dur, ~f12);
					~l12c.set(\dur, ~f12/~icd3);
					~l12d.set(\dur, ~f12/~icd3);
					~l12e.set(\dur, ~f12/~icd6);
					~l12f.set(\dur, ~f12/~icd6);
				}
				{~l1a1.isRunning == true}{
					~l12a1.set(\dur, ~f12 = ~freqmap.at(~freqmapval12 = ~freqmapval12.value+1));
					~l12b1.set(\dur, ~f12);
					~l12c1.set(\dur, ~f12/~icd3);
					~l12d1.set(\dur, ~f12/~icd3);
					~l12e1.set(\dur, ~f12/~icd6);
					~l12f1.set(\dur, ~f12/~icd6);
				};
				if((~f12 > ~outmaxa) or: (~f12 < ~outmina), {~z36.close;~z12.close;~z36 = (CompositeView(w, Rect((~f12.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+120, ~nw, 2)).background = Color.white;);}, {~z12.close;~z36.close;~z12 = (CompositeView(w, Rect((~f12.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+120, ~nw, 2)).background = Color.white;);});
				~z25.background = Color.white; ~z1.background = Color.white;
				~z26.background = Color.white; ~z2.background = Color.white;
				~z27.background = Color.white; ~z3.background = Color.white;
				~z28.background = Color.white; ~z4.background = Color.white;
				~z29.background = Color.white; ~z5.background = Color.white;
				~z30.background = Color.white; ~z6.background = Color.white;
				~z31.background = Color.white; ~z7.background = Color.white;
				~z32.background = Color.white; ~z8.background = Color.white;
				~z33.background = Color.white; ~z9.background = Color.white;
				~z34.background = Color.white; ~z10.background = Color.white;
				~z35.background = Color.white; ~z11.background = Color.white;
				~z36.background = Color.green; ~z12.background = Color.green;
		});});
		if((~f12 <= ~freqmap.at(0)), {~freqmap.at(0)},
			{if((keycodeb.value == 11) and: ((keycode == ~leftarrow_keycode) or: (unicode == ~j_unicode)), {
				~freqmapval12 = ~f12.cpsmidi.round;
				case
				{~l1a.isRunning == true}{
					~l12a.set(\dur, ~f12 = ~freqmap.at(~freqmapval12 = ~freqmapval12.value-1));
					~l12b.set(\dur, ~f12);
					~l12c.set(\dur, ~f12/~icd3);
					~l12d.set(\dur, ~f12/~icd3);
					~l12e.set(\dur, ~f12/~icd6);
					~l12f.set(\dur, ~f12/~icd6);
				}
				{~l1a1.isRunning == true}{
					~l12a1.set(\dur, ~f12 = ~freqmap.at(~freqmapval12 = ~freqmapval12.value-1));
					~l12b1.set(\dur, ~f12);
					~l12c1.set(\dur, ~f12/~icd3);
					~l12d1.set(\dur, ~f12/~icd3);
					~l12e1.set(\dur, ~f12/~icd6);
					~l12f1.set(\dur, ~f12/~icd6);
				};
				if((~f12 > ~outmaxa) or: (~f12 < ~outmina), {~z36.close;~z12.close;~z36 = (CompositeView(w, Rect((~f12.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+120, ~nw, 2)).background = Color.white;);}, {~z12.close;~z36.close;~z12 = (CompositeView(w, Rect((~f12.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+120, ~nw, 2)).background = Color.white;);});

				~z25.background = Color.white; ~z1.background = Color.white;
				~z26.background = Color.white; ~z2.background = Color.white;
				~z27.background = Color.white; ~z3.background = Color.white;
				~z28.background = Color.white; ~z4.background = Color.white;
				~z29.background = Color.white; ~z5.background = Color.white;
				~z30.background = Color.white; ~z6.background = Color.white;
				~z31.background = Color.white; ~z7.background = Color.white;
				~z32.background = Color.white; ~z8.background = Color.white;
				~z33.background = Color.white; ~z9.background = Color.white;
				~z34.background = Color.white; ~z10.background = Color.white;
				~z35.background = Color.white; ~z11.background = Color.white;
				~z36.background = Color.green; ~z12.background = Color.green;
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
	if(~rtimeall == nil, {~rtimeall = 8;});
	if(~rtime1 == nil, {~rtime1 = 8;});
	if(~rtime2 == nil, {~rtime2 = 8;});
	if(~rtime3 == nil, {~rtime3 = 8;});
	if(~rtime4 == nil, {~rtime4 = 8;});
	if(~rtime5 == nil, {~rtime5 = 8;});
	if(~rtime6 == nil, {~rtime6 = 8;});
	if(~rtime7 == nil, {~rtime7 = 8;});
	if(~rtime8 == nil, {~rtime8 = 8;});
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
				"tsynth0/tsynth1: tsynth0 to allow timed synth set, then click on any o or f button to time a progression. click on the st button in the bottom right to stop the timer. tsynth1 to dis-allow timed synth set"++"\n"++"\n"++
				"copy: copy frequency/note info"++"\n"++"\n"++
				"kws/inst: change number of kw(King Wen) sequences per time wave instance. press set to load"++"\n"++"\n"++
				"steps/kws: change number of interval steps which occur in each kw sequence. press set to load"++"\n"++"\n"++
				"hz frequency: set the base frequency. press set to load"++"\n"++"\n"++
				"s1-s8: set/save note positions"++"\n"++"\n"++
				"uc-u8: undo changes to set note positions. press set to load"++"\n"++"\n"++
				"o1-o8: play set/saved note positions by opening a new synth set"++"\n"++"\n"++
				"f1-f8: flow transition to set/saved note positions"++"\n"++"\n"++
				"s1-s8: slide transition to set/saved note positions"++"\n"++"\n"++
				"g1-g8: groups of saved note positions"++"\n"++"\n"++
				"uc1-uc8: revert to former saved note positions"++"\n"++"\n"++
				"rc: start recording"++"\n"++"\n"++
				"prc: pause recording"++"\n"++"\n"++
				"/rc: stop recording"++"\n"++"\n"++
				"m/u: mute/unmute all"++"\n"++"\n"++
				"1-12: mute or unmute individual synth"++"\n"++"\n"++
				"rw: random western scale"++"\n"++"\n"++
				"re: random eastern scale"++"\n"++"\n"++
				"r: routine/loop function - rslot for synth set, rtime for time between transitions"++"\n"++"\n"++
				"st: stop synth timer/show timer results"++"\n"++"\n"++
				"s: set slide time/increment"++"\n"++"\n"++
				"i: help"++"\n"++"\n"++
				"m: minimize window"++"\n"++"\n"++
				"c: close window"++"\n"++"\n"++"\n"++
				"Keyboard Functions (functionality will vary with device)"++"\n"++"\n"++"\n"++
				"s: start/stop synth set"++"\n"++"\n"++
				"space bar: pause/unpause synth set"++"\n"++"\n"++
				"ctrl-period/cmd-period: stop synth/free server"++"\n"++"\n"++
				"left/right arrow(or J and L): move down/up note"++"\n"++"\n"++
				"up/down arrow(or I and K): change synth for left/right arrow note function"++"\n"++"\n"++
				"#1-= on keyboard: choose synth for left/right arrow note function"++"\n"++"\n"++
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
			12.do(x = 0; {("f"++(x=x+1)).asSymbol.envirPut(~freqmap.at(rrand(36, 91));)});
			~synthflow.value;
		});
	});


	//random notes button 2

	~randombutton2 = Button.new(w,Rect(Window.screenBounds.width-20-20-20,~bpt+69+5-(20/~gm),20,20/1.6180339887499)).states_([["re",Color.white,Color.black]]).action_({arg button;

		if((~l1a.isRunning == true) or: (~l1a1.isRunning == true), {
			12.do(x = 0; {("f"++(x=x+1)).asSymbol.envirPut((~freqmap.at(127)/8).rand;)});
			~synthflow.value;
		});
	});


	//setgroup buttons, sg1-sg8

	~setgroup1 = Button.new(w,Rect(Window.screenBounds.width-(Window.screenBounds.width/2)-(20*4),~bpt+69+5,20,20/1.6180339887499)).states_([["g1",Color.white,Color.black],["s1",Color.green,Color.black]]).action_({arg button;

		if(button.value == 1, {
			#fp1,fp2,fp3,fp4,fp5,fp6,fp7,fp8,fp9,fp10,fp11,fp12=[~sg1a1,~sg1a2,~sg1a3,~sg1a4,~sg1a5,~sg1a6,~sg1a7,~sg1a8,~sg1a9,~sg1a10,~sg1a11,~sg1a12];
			#fp1b,fp2b,fp3b,fp4b,fp5b,fp6b,fp7b,fp8b,fp9b,fp10b,fp11b,fp12b=[~sg1b1,~sg1b2,~sg1b3,~sg1b4,~sg1b5,~sg1b6,~sg1b7,~sg1b8,~sg1b9,~sg1b10,~sg1b11,~sg1b12];
			#fp1c,fp2c,fp3c,fp4c,fp5c,fp6c,fp7c,fp8c,fp9c,fp10c,fp11c,fp12c=[~sg1c1,~sg1c2,~sg1c3,~sg1c4,~sg1c5,~sg1c6,~sg1c7,~sg1c8,~sg1c9,~sg1c10,~sg1c11,~sg1c12];
			#fp1d,fp2d,fp3d,fp4d,fp5d,fp6d,fp7d,fp8d,fp9d,fp10d,fp11d,fp12d=[~sg1d1,~sg1d2,~sg1d3,~sg1d4,~sg1d5,~sg1d6,~sg1d7,~sg1d8,~sg1d9,~sg1d10,~sg1d11,~sg1d12];
			#fp1e,fp2e,fp3e,fp4e,fp5e,fp6e,fp7e,fp8e,fp9e,fp10e,fp11e,fp12e=[~sg1e1,~sg1e2,~sg1e3,~sg1e4,~sg1e5,~sg1e6,~sg1e7,~sg1e8,~sg1e9,~sg1e10,~sg1e11,~sg1e12];
			#fp1f,fp2f,fp3f,fp4f,fp5f,fp6f,fp7f,fp8f,fp9f,fp10f,fp11f,fp12f=[~sg1f1,~sg1f2,~sg1f3,~sg1f4,~sg1f5,~sg1f6,~sg1f7,~sg1f8,~sg1f9,~sg1f10,~sg1f11,~sg1f12];
			#fp1g,fp2g,fp3g,fp4g,fp5g,fp6g,fp7g,fp8g,fp9g,fp10g,fp11g,fp12g=[~sg1g1,~sg1g2,~sg1g3,~sg1g4,~sg1g5,~sg1g6,~sg1g7,~sg1g8,~sg1g9,~sg1g10,~sg1g11,~sg1g12];
			#fp1h,fp2h,fp3h,fp4h,fp5h,fp6h,fp7h,fp8h,fp9h,fp10h,fp11h,fp12h=[~sg1h1,~sg1h2,~sg1h3,~sg1h4,~sg1h5,~sg1h6,~sg1h7,~sg1h8,~sg1h9,~sg1h10,~sg1h11,~sg1h12];

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
			#fp1,fp2,fp3,fp4,fp5,fp6,fp7,fp8,fp9,fp10,fp11,fp12=[~sg2a1,~sg2a2,~sg2a3,~sg2a4,~sg2a5,~sg2a6,~sg2a7,~sg2a8,~sg2a9,~sg2a10,~sg2a11,~sg2a12];
			#fp1b,fp2b,fp3b,fp4b,fp5b,fp6b,fp7b,fp8b,fp9b,fp10b,fp11b,fp12b=[~sg2b1,~sg2b2,~sg2b3,~sg2b4,~sg2b5,~sg2b6,~sg2b7,~sg2b8,~sg2b9,~sg2b10,~sg2b11,~sg2b12];
			#fp1c,fp2c,fp3c,fp4c,fp5c,fp6c,fp7c,fp8c,fp9c,fp10c,fp11c,fp12c=[~sg2c1,~sg2c2,~sg2c3,~sg2c4,~sg2c5,~sg2c6,~sg2c7,~sg2c8,~sg2c9,~sg2c10,~sg2c11,~sg2c12];
			#fp1d,fp2d,fp3d,fp4d,fp5d,fp6d,fp7d,fp8d,fp9d,fp10d,fp11d,fp12d=[~sg2d1,~sg2d2,~sg2d3,~sg2d4,~sg2d5,~sg2d6,~sg2d7,~sg2d8,~sg2d9,~sg2d10,~sg2d11,~sg2d12];
			#fp1e,fp2e,fp3e,fp4e,fp5e,fp6e,fp7e,fp8e,fp9e,fp10e,fp11e,fp12e=[~sg2e1,~sg2e2,~sg2e3,~sg2e4,~sg2e5,~sg2e6,~sg2e7,~sg2e8,~sg2e9,~sg2e10,~sg2e11,~sg2e12];
			#fp1f,fp2f,fp3f,fp4f,fp5f,fp6f,fp7f,fp8f,fp9f,fp10f,fp11f,fp12f=[~sg2f1,~sg2f2,~sg2f3,~sg2f4,~sg2f5,~sg2f6,~sg2f7,~sg2f8,~sg2f9,~sg2f10,~sg2f11,~sg2f12];
			#fp1g,fp2g,fp3g,fp4g,fp5g,fp6g,fp7g,fp8g,fp9g,fp10g,fp11g,fp12g=[~sg2g1,~sg2g2,~sg2g3,~sg2g4,~sg2g5,~sg2g6,~sg2g7,~sg2g8,~sg2g9,~sg2g10,~sg2g11,~sg2g12];
			#fp1h,fp2h,fp3h,fp4h,fp5h,fp6h,fp7h,fp8h,fp9h,fp10h,fp11h,fp12h=[~sg2h1,~sg2h2,~sg2h3,~sg2h4,~sg2h5,~sg2h6,~sg2h7,~sg2h8,~sg2h9,~sg2h10,~sg2h11,~sg2h12];

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
			#fp1,fp2,fp3,fp4,fp5,fp6,fp7,fp8,fp9,fp10,fp11,fp12=[~sg3a1,~sg3a2,~sg3a3,~sg3a4,~sg3a5,~sg3a6,~sg3a7,~sg3a8,~sg3a9,~sg3a10,~sg3a11,~sg3a12];
			#fp1b,fp2b,fp3b,fp4b,fp5b,fp6b,fp7b,fp8b,fp9b,fp10b,fp11b,fp12b=[~sg3b1,~sg3b2,~sg3b3,~sg3b4,~sg3b5,~sg3b6,~sg3b7,~sg3b8,~sg3b9,~sg3b10,~sg3b11,~sg3b12];
			#fp1c,fp2c,fp3c,fp4c,fp5c,fp6c,fp7c,fp8c,fp9c,fp10c,fp11c,fp12c=[~sg3c1,~sg3c2,~sg3c3,~sg3c4,~sg3c5,~sg3c6,~sg3c7,~sg3c8,~sg3c9,~sg3c10,~sg3c11,~sg3c12];
			#fp1d,fp2d,fp3d,fp4d,fp5d,fp6d,fp7d,fp8d,fp9d,fp10d,fp11d,fp12d=[~sg3d1,~sg3d2,~sg3d3,~sg3d4,~sg3d5,~sg3d6,~sg3d7,~sg3d8,~sg3d9,~sg3d10,~sg3d11,~sg3d12];
			#fp1e,fp2e,fp3e,fp4e,fp5e,fp6e,fp7e,fp8e,fp9e,fp10e,fp11e,fp12e=[~sg3e1,~sg3e2,~sg3e3,~sg3e4,~sg3e5,~sg3e6,~sg3e7,~sg3e8,~sg3e9,~sg3e10,~sg3e11,~sg3e12];
			#fp1f,fp2f,fp3f,fp4f,fp5f,fp6f,fp7f,fp8f,fp9f,fp10f,fp11f,fp12f=[~sg3f1,~sg3f2,~sg3f3,~sg3f4,~sg3f5,~sg3f6,~sg3f7,~sg3f8,~sg3f9,~sg3f10,~sg3f11,~sg3f12];
			#fp1g,fp2g,fp3g,fp4g,fp5g,fp6g,fp7g,fp8g,fp9g,fp10g,fp11g,fp12g=[~sg3g1,~sg3g2,~sg3g3,~sg3g4,~sg3g5,~sg3g6,~sg3g7,~sg3g8,~sg3g9,~sg3g10,~sg3g11,~sg3g12];
			#fp1h,fp2h,fp3h,fp4h,fp5h,fp6h,fp7h,fp8h,fp9h,fp10h,fp11h,fp12h=[~sg3h1,~sg3h2,~sg3h3,~sg3h4,~sg3h5,~sg3h6,~sg3h7,~sg3h8,~sg3h9,~sg3h10,~sg3h11,~sg3h12];

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
			#fp1,fp2,fp3,fp4,fp5,fp6,fp7,fp8,fp9,fp10,fp11,fp12=[~sg4a1,~sg4a2,~sg4a3,~sg4a4,~sg4a5,~sg4a6,~sg4a7,~sg4a8,~sg4a9,~sg4a10,~sg4a11,~sg4a12];
			#fp1b,fp2b,fp3b,fp4b,fp5b,fp6b,fp7b,fp8b,fp9b,fp10b,fp11b,fp12b=[~sg4b1,~sg4b2,~sg4b3,~sg4b4,~sg4b5,~sg4b6,~sg4b7,~sg4b8,~sg4b9,~sg4b10,~sg4b11,~sg4b12];
			#fp1c,fp2c,fp3c,fp4c,fp5c,fp6c,fp7c,fp8c,fp9c,fp10c,fp11c,fp12c=[~sg4c1,~sg4c2,~sg4c3,~sg4c4,~sg4c5,~sg4c6,~sg4c7,~sg4c8,~sg4c9,~sg4c10,~sg4c11,~sg4c12];
			#fp1d,fp2d,fp3d,fp4d,fp5d,fp6d,fp7d,fp8d,fp9d,fp10d,fp11d,fp12d=[~sg4d1,~sg4d2,~sg4d3,~sg4d4,~sg4d5,~sg4d6,~sg4d7,~sg4d8,~sg4d9,~sg4d10,~sg4d11,~sg4d12];
			#fp1e,fp2e,fp3e,fp4e,fp5e,fp6e,fp7e,fp8e,fp9e,fp10e,fp11e,fp12e=[~sg4e1,~sg4e2,~sg4e3,~sg4e4,~sg4e5,~sg4e6,~sg4e7,~sg4e8,~sg4e9,~sg4e10,~sg4e11,~sg4e12];
			#fp1f,fp2f,fp3f,fp4f,fp5f,fp6f,fp7f,fp8f,fp9f,fp10f,fp11f,fp12f=[~sg4f1,~sg4f2,~sg4f3,~sg4f4,~sg4f5,~sg4f6,~sg4f7,~sg4f8,~sg4f9,~sg4f10,~sg4f11,~sg4f12];
			#fp1g,fp2g,fp3g,fp4g,fp5g,fp6g,fp7g,fp8g,fp9g,fp10g,fp11g,fp12g=[~sg4g1,~sg4g2,~sg4g3,~sg4g4,~sg4g5,~sg4g6,~sg4g7,~sg4g8,~sg4g9,~sg4g10,~sg4g11,~sg4g12];
			#fp1h,fp2h,fp3h,fp4h,fp5h,fp6h,fp7h,fp8h,fp9h,fp10h,fp11h,fp12h=[~sg4h1,~sg4h2,~sg4h3,~sg4h4,~sg4h5,~sg4h6,~sg4h7,~sg4h8,~sg4h9,~sg4h10,~sg4h11,~sg4h12];

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
			#fp1,fp2,fp3,fp4,fp5,fp6,fp7,fp8,fp9,fp10,fp11,fp12=[~sg5a1,~sg5a2,~sg5a3,~sg5a4,~sg5a5,~sg5a6,~sg5a7,~sg5a8,~sg5a9,~sg5a10,~sg5a11,~sg5a12];
			#fp1b,fp2b,fp3b,fp4b,fp5b,fp6b,fp7b,fp8b,fp9b,fp10b,fp11b,fp12b=[~sg5b1,~sg5b2,~sg5b3,~sg5b4,~sg5b5,~sg5b6,~sg5b7,~sg5b8,~sg5b9,~sg5b10,~sg5b11,~sg5b12];
			#fp1c,fp2c,fp3c,fp4c,fp5c,fp6c,fp7c,fp8c,fp9c,fp10c,fp11c,fp12c=[~sg5c1,~sg5c2,~sg5c3,~sg5c4,~sg5c5,~sg5c6,~sg5c7,~sg5c8,~sg5c9,~sg5c10,~sg5c11,~sg5c12];
			#fp1d,fp2d,fp3d,fp4d,fp5d,fp6d,fp7d,fp8d,fp9d,fp10d,fp11d,fp12d=[~sg5d1,~sg5d2,~sg5d3,~sg5d4,~sg5d5,~sg5d6,~sg5d7,~sg5d8,~sg5d9,~sg5d10,~sg5d11,~sg5d12];
			#fp1e,fp2e,fp3e,fp4e,fp5e,fp6e,fp7e,fp8e,fp9e,fp10e,fp11e,fp12e=[~sg5e1,~sg5e2,~sg5e3,~sg5e4,~sg5e5,~sg5e6,~sg5e7,~sg5e8,~sg5e9,~sg5e10,~sg5e11,~sg5e12];
			#fp1f,fp2f,fp3f,fp4f,fp5f,fp6f,fp7f,fp8f,fp9f,fp10f,fp11f,fp12f=[~sg5f1,~sg5f2,~sg5f3,~sg5f4,~sg5f5,~sg5f6,~sg5f7,~sg5f8,~sg5f9,~sg5f10,~sg5f11,~sg5f12];
			#fp1g,fp2g,fp3g,fp4g,fp5g,fp6g,fp7g,fp8g,fp9g,fp10g,fp11g,fp12g=[~sg5g1,~sg5g2,~sg5g3,~sg5g4,~sg5g5,~sg5g6,~sg5g7,~sg5g8,~sg5g9,~sg5g10,~sg5g11,~sg5g12];
			#fp1h,fp2h,fp3h,fp4h,fp5h,fp6h,fp7h,fp8h,fp9h,fp10h,fp11h,fp12h=[~sg5h1,~sg5h2,~sg5h3,~sg5h4,~sg5h5,~sg5h6,~sg5h7,~sg5h8,~sg5h9,~sg5h10,~sg5h11,~sg5h12];

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
			#fp1,fp2,fp3,fp4,fp5,fp6,fp7,fp8,fp9,fp10,fp11,fp12=[~sg6a1,~sg6a2,~sg6a3,~sg6a4,~sg6a5,~sg6a6,~sg6a7,~sg6a8,~sg6a9,~sg6a10,~sg6a11,~sg6a12];
			#fp1b,fp2b,fp3b,fp4b,fp5b,fp6b,fp7b,fp8b,fp9b,fp10b,fp11b,fp12b=[~sg6b1,~sg6b2,~sg6b3,~sg6b4,~sg6b5,~sg6b6,~sg6b7,~sg6b8,~sg6b9,~sg6b10,~sg6b11,~sg6b12];
			#fp1c,fp2c,fp3c,fp4c,fp5c,fp6c,fp7c,fp8c,fp9c,fp10c,fp11c,fp12c=[~sg6c1,~sg6c2,~sg6c3,~sg6c4,~sg6c5,~sg6c6,~sg6c7,~sg6c8,~sg6c9,~sg6c10,~sg6c11,~sg6c12];
			#fp1d,fp2d,fp3d,fp4d,fp5d,fp6d,fp7d,fp8d,fp9d,fp10d,fp11d,fp12d=[~sg6d1,~sg6d2,~sg6d3,~sg6d4,~sg6d5,~sg6d6,~sg6d7,~sg6d8,~sg6d9,~sg6d10,~sg6d11,~sg6d12];
			#fp1e,fp2e,fp3e,fp4e,fp5e,fp6e,fp7e,fp8e,fp9e,fp10e,fp11e,fp12e=[~sg6e1,~sg6e2,~sg6e3,~sg6e4,~sg6e5,~sg6e6,~sg6e7,~sg6e8,~sg6e9,~sg6e10,~sg6e11,~sg6e12];
			#fp1f,fp2f,fp3f,fp4f,fp5f,fp6f,fp7f,fp8f,fp9f,fp10f,fp11f,fp12f=[~sg6f1,~sg6f2,~sg6f3,~sg6f4,~sg6f5,~sg6f6,~sg6f7,~sg6f8,~sg6f9,~sg6f10,~sg6f11,~sg6f12];
			#fp1g,fp2g,fp3g,fp4g,fp5g,fp6g,fp7g,fp8g,fp9g,fp10g,fp11g,fp12g=[~sg6g1,~sg6g2,~sg6g3,~sg6g4,~sg6g5,~sg6g6,~sg6g7,~sg6g8,~sg6g9,~sg6g10,~sg6g11,~sg6g12];
			#fp1h,fp2h,fp3h,fp4h,fp5h,fp6h,fp7h,fp8h,fp9h,fp10h,fp11h,fp12h=[~sg6h1,~sg6h2,~sg6h3,~sg6h4,~sg6h5,~sg6h6,~sg6h7,~sg6h8,~sg6h9,~sg6h10,~sg6h11,~sg6h12];

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
			#fp1,fp2,fp3,fp4,fp5,fp6,fp7,fp8,fp9,fp10,fp11,fp12=[~sg7a1,~sg7a2,~sg7a3,~sg7a4,~sg7a5,~sg7a6,~sg7a7,~sg7a8,~sg7a9,~sg7a10,~sg7a11,~sg7a12];
			#fp1b,fp2b,fp3b,fp4b,fp5b,fp6b,fp7b,fp8b,fp9b,fp10b,fp11b,fp12b=[~sg7b1,~sg7b2,~sg7b3,~sg7b4,~sg7b5,~sg7b6,~sg7b7,~sg7b8,~sg7b9,~sg7b10,~sg7b11,~sg7b12];
			#fp1c,fp2c,fp3c,fp4c,fp5c,fp6c,fp7c,fp8c,fp9c,fp10c,fp11c,fp12c=[~sg7c1,~sg7c2,~sg7c3,~sg7c4,~sg7c5,~sg7c6,~sg7c7,~sg7c8,~sg7c9,~sg7c10,~sg7c11,~sg7c12];
			#fp1d,fp2d,fp3d,fp4d,fp5d,fp6d,fp7d,fp8d,fp9d,fp10d,fp11d,fp12d=[~sg7d1,~sg7d2,~sg7d3,~sg7d4,~sg7d5,~sg7d6,~sg7d7,~sg7d8,~sg7d9,~sg7d10,~sg7d11,~sg7d12];
			#fp1e,fp2e,fp3e,fp4e,fp5e,fp6e,fp7e,fp8e,fp9e,fp10e,fp11e,fp12e=[~sg7e1,~sg7e2,~sg7e3,~sg7e4,~sg7e5,~sg7e6,~sg7e7,~sg7e8,~sg7e9,~sg7e10,~sg7e11,~sg7e12];
			#fp1f,fp2f,fp3f,fp4f,fp5f,fp6f,fp7f,fp8f,fp9f,fp10f,fp11f,fp12f=[~sg7f1,~sg7f2,~sg7f3,~sg7f4,~sg7f5,~sg7f6,~sg7f7,~sg7f8,~sg7f9,~sg7f10,~sg7f11,~sg7f12];
			#fp1g,fp2g,fp3g,fp4g,fp5g,fp6g,fp7g,fp8g,fp9g,fp10g,fp11g,fp12g=[~sg7g1,~sg7g2,~sg7g3,~sg7g4,~sg7g5,~sg7g6,~sg7g7,~sg7g8,~sg7g9,~sg7g10,~sg7g11,~sg7g12];
			#fp1h,fp2h,fp3h,fp4h,fp5h,fp6h,fp7h,fp8h,fp9h,fp10h,fp11h,fp12h=[~sg7h1,~sg7h2,~sg7h3,~sg7h4,~sg7h5,~sg7h6,~sg7h7,~sg7h8,~sg7h9,~sg7h10,~sg7h11,~sg7h12];

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
			#fp1,fp2,fp3,fp4,fp5,fp6,fp7,fp8,fp9,fp10,fp11,fp12=[~sg8a1,~sg8a2,~sg8a3,~sg8a4,~sg8a5,~sg8a6,~sg8a7,~sg8a8,~sg8a9,~sg8a10,~sg8a11,~sg8a12];
			#fp1b,fp2b,fp3b,fp4b,fp5b,fp6b,fp7b,fp8b,fp9b,fp10b,fp11b,fp12b=[~sg8b1,~sg8b2,~sg8b3,~sg8b4,~sg8b5,~sg8b6,~sg8b7,~sg8b8,~sg8b9,~sg8b10,~sg8b11,~sg8b12];
			#fp1c,fp2c,fp3c,fp4c,fp5c,fp6c,fp7c,fp8c,fp9c,fp10c,fp11c,fp12c=[~sg8c1,~sg8c2,~sg8c3,~sg8c4,~sg8c5,~sg8c6,~sg8c7,~sg8c8,~sg8c9,~sg8c10,~sg8c11,~sg8c12];
			#fp1d,fp2d,fp3d,fp4d,fp5d,fp6d,fp7d,fp8d,fp9d,fp10d,fp11d,fp12d=[~sg8d1,~sg8d2,~sg8d3,~sg8d4,~sg8d5,~sg8d6,~sg8d7,~sg8d8,~sg8d9,~sg8d10,~sg8d11,~sg8d12];
			#fp1e,fp2e,fp3e,fp4e,fp5e,fp6e,fp7e,fp8e,fp9e,fp10e,fp11e,fp12e=[~sg8e1,~sg8e2,~sg8e3,~sg8e4,~sg8e5,~sg8e6,~sg8e7,~sg8e8,~sg8e9,~sg8e10,~sg8e11,~sg8e12];
			#fp1f,fp2f,fp3f,fp4f,fp5f,fp6f,fp7f,fp8f,fp9f,fp10f,fp11f,fp12f=[~sg8f1,~sg8f2,~sg8f3,~sg8f4,~sg8f5,~sg8f6,~sg8f7,~sg8f8,~sg8f9,~sg8f10,~sg8f11,~sg8f12];
			#fp1g,fp2g,fp3g,fp4g,fp5g,fp6g,fp7g,fp8g,fp9g,fp10g,fp11g,fp12g=[~sg8g1,~sg8g2,~sg8g3,~sg8g4,~sg8g5,~sg8g6,~sg8g7,~sg8g8,~sg8g9,~sg8g10,~sg8g11,~sg8g12];
			#fp1h,fp2h,fp3h,fp4h,fp5h,fp6h,fp7h,fp8h,fp9h,fp10h,fp11h,fp12h=[~sg8h1,~sg8h2,~sg8h3,~sg8h4,~sg8h5,~sg8h6,~sg8h7,~sg8h8,~sg8h9,~sg8h10,~sg8h11,~sg8h12];

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

	n1 = Button.new(w,Rect(Window.screenBounds.width-(Window.screenBounds.width/2)-(60*2),Window.screenBounds.height-88,60,60/1.6180339887499)).states_([["s1",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button; if(button.value == 0, {~r1=fp1;~r2=fp2;~r3=fp3;~r4=fp4;~r5=fp5;~r6=fp6;~r7=fp7;~r8=fp8;~r9=fp9;~r10=fp10;~r11=fp11;~r12=fp12; #fp1,fp2,fp3,fp4,fp5,fp6,fp7,fp8,fp9,fp10,fp11,fp12/*,fp13,fp14,fp15,fp16,fp17,fp18,fp19,fp20,fp21,fp22,fp23,fp24*/ = [ ~f1,~f2,~f3,~f4,~f5,~f6,~f7,~f8,~f9,~f10,~f11,~f12 ]; "s"++"\n"++[ ~f1,~f2,~f3,~f4,~f5,~f6,~f7,~f8,~f9,~f10,~f11,~f12 ].asString.postString; ~u1=~f1;~u2=~f2;~u3=~f3;~u4=~f4;~u5=~f5;~u6=~f6;~u7=~f7;~u8=~f8;~u9=~f9;~u10=~f10;~u11=~f11;~u12=~f12; ~si1aset.value;~si1bset.value;

		if(~setgroup1.value == 1, {12.do(x = 0; {("sg1a"++(x=x+1)).asSymbol.envirPut([fp1,fp2,fp3,fp4,fp5,fp6,fp7,fp8,fp9,fp10,fp11,fp12].at(x-1))});});
		if(~setgroup2.value == 1, {12.do(x = 0; {("sg2a"++(x=x+1)).asSymbol.envirPut([fp1,fp2,fp3,fp4,fp5,fp6,fp7,fp8,fp9,fp10,fp11,fp12].at(x-1))});});
		if(~setgroup3.value == 1, {12.do(x = 0; {("sg3a"++(x=x+1)).asSymbol.envirPut([fp1,fp2,fp3,fp4,fp5,fp6,fp7,fp8,fp9,fp10,fp11,fp12].at(x-1))});});
		if(~setgroup4.value == 1, {12.do(x = 0; {("sg4a"++(x=x+1)).asSymbol.envirPut([fp1,fp2,fp3,fp4,fp5,fp6,fp7,fp8,fp9,fp10,fp11,fp12].at(x-1))});});
		if(~setgroup5.value == 1, {12.do(x = 0; {("sg5a"++(x=x+1)).asSymbol.envirPut([fp1,fp2,fp3,fp4,fp5,fp6,fp7,fp8,fp9,fp10,fp11,fp12].at(x-1))});});
		if(~setgroup6.value == 1, {12.do(x = 0; {("sg6a"++(x=x+1)).asSymbol.envirPut([fp1,fp2,fp3,fp4,fp5,fp6,fp7,fp8,fp9,fp10,fp11,fp12].at(x-1))});});
		if(~setgroup7.value == 1, {12.do(x = 0; {("sg7a"++(x=x+1)).asSymbol.envirPut([fp1,fp2,fp3,fp4,fp5,fp6,fp7,fp8,fp9,fp10,fp11,fp12].at(x-1))});});
		if(~setgroup8.value == 1, {12.do(x = 0; {("sg8a"++(x=x+1)).asSymbol.envirPut([fp1,fp2,fp3,fp4,fp5,fp6,fp7,fp8,fp9,fp10,fp11,fp12].at(x-1))});});

		n1.states_([["s1",Color.green,Color.black]]);
		n2.states_([["s2",Color.white,Color.black]]);
		n3.states_([["s3",Color.white,Color.black]]);
		n4.states_([["s4",Color.white,Color.black]]);
		n5.states_([["s5",Color.white,Color.black]]);
		n6.states_([["s6",Color.white,Color.black]]);
		n7.states_([["s7",Color.white,Color.black]]);
		n8.states_([["s8",Color.white,Color.black]]);
	});});

	n2 = Button.new(w,Rect(Window.screenBounds.width-(Window.screenBounds.width/2)-(60*1),Window.screenBounds.height-88,60,60/1.6180339887499)).states_([["s2",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button; if(button.value == 0, {~r1b=fp1b;~r2b=fp2b;~r3b=fp3b;~r4b=fp4b;~r5b=fp5b;~r6b=fp6b;~r7b=fp7b;~r8b=fp8b;~r9b=fp9b;~r10b=fp10b;~r11b=fp11b;~r12b=fp12b; #fp1b,fp2b,fp3b,fp4b,fp5b,fp6b,fp7b,fp8b,fp9b,fp10b,fp11b,fp12b/*,fp13b,fp14b,fp15b,fp16b,fp17b,fp18b,fp19b,fp20b,fp21b,fp22b,fp23b,fp24b*/ = [ ~f1,~f2,~f3,~f4,~f5,~f6,~f7,~f8,~f9,~f10,~f11,~f12 ]; "s"++"\n"++[ ~f1,~f2,~f3,~f4,~f5,~f6,~f7,~f8,~f9,~f10,~f11,~f12 ].asString.postString; ~u1b=~f1;~u2b=~f2;~u3b=~f3;~u4b=~f4;~u5b=~f5;~u6b=~f6;~u7b=~f7;~u8b=~f8;~u9b=~f9;~u10b=~f10;~u11b=~f11;~u12b=~f12; ~si2set.value;

		if(~setgroup1.value == 1, {12.do(x = 0; {("sg1b"++(x=x+1)).asSymbol.envirPut([fp1b,fp2b,fp3b,fp4b,fp5b,fp6b,fp7b,fp8b,fp9b,fp10b,fp11b,fp12b].at(x-1))});});
		if(~setgroup2.value == 1, {12.do(x = 0; {("sg2b"++(x=x+1)).asSymbol.envirPut([fp1b,fp2b,fp3b,fp4b,fp5b,fp6b,fp7b,fp8b,fp9b,fp10b,fp11b,fp12b].at(x-1))});});
		if(~setgroup3.value == 1, {12.do(x = 0; {("sg3b"++(x=x+1)).asSymbol.envirPut([fp1b,fp2b,fp3b,fp4b,fp5b,fp6b,fp7b,fp8b,fp9b,fp10b,fp11b,fp12b].at(x-1))});});
		if(~setgroup4.value == 1, {12.do(x = 0; {("sg4b"++(x=x+1)).asSymbol.envirPut([fp1b,fp2b,fp3b,fp4b,fp5b,fp6b,fp7b,fp8b,fp9b,fp10b,fp11b,fp12b].at(x-1))});});
		if(~setgroup5.value == 1, {12.do(x = 0; {("sg5b"++(x=x+1)).asSymbol.envirPut([fp1b,fp2b,fp3b,fp4b,fp5b,fp6b,fp7b,fp8b,fp9b,fp10b,fp11b,fp12b].at(x-1))});});
		if(~setgroup6.value == 1, {12.do(x = 0; {("sg6b"++(x=x+1)).asSymbol.envirPut([fp1b,fp2b,fp3b,fp4b,fp5b,fp6b,fp7b,fp8b,fp9b,fp10b,fp11b,fp12b].at(x-1))});});
		if(~setgroup7.value == 1, {12.do(x = 0; {("sg7b"++(x=x+1)).asSymbol.envirPut([fp1b,fp2b,fp3b,fp4b,fp5b,fp6b,fp7b,fp8b,fp9b,fp10b,fp11b,fp12b].at(x-1))});});
		if(~setgroup8.value == 1, {12.do(x = 0; {("sg8b"++(x=x+1)).asSymbol.envirPut([fp1b,fp2b,fp3b,fp4b,fp5b,fp6b,fp7b,fp8b,fp9b,fp10b,fp11b,fp12b].at(x-1))});});

		n1.states_([["s1",Color.white,Color.black]]);
		n2.states_([["s2",Color.green,Color.black]]);
		n3.states_([["s3",Color.white,Color.black]]);
		n4.states_([["s4",Color.white,Color.black]]);
		n5.states_([["s5",Color.white,Color.black]]);
		n6.states_([["s6",Color.white,Color.black]]);
		n7.states_([["s7",Color.white,Color.black]]);
		n8.states_([["s8",Color.white,Color.black]]);
	});});
	n3 = Button.new(w,Rect(Window.screenBounds.width-(Window.screenBounds.width/2)+(0),   Window.screenBounds.height-88,60,60/1.6180339887499)).states_([["s3",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button; if(button.value == 0, {~r1c=fp1c;~r2c=fp2c;~r3c=fp3c;~r4c=fp4c;~r5c=fp5c;~r6c=fp6c;~r7c=fp7c;~r8c=fp8c;~r9c=fp9c;~r10c=fp10c;~r11c=fp11c;~r12c=fp12c; #fp1c,fp2c,fp3c,fp4c,fp5c,fp6c,fp7c,fp8c,fp9c,fp10c,fp11c,fp12c/*,fp13c,fp14c,fp15c,fp16c,fp17c,fp18c,fp19c,fp20c,fp21c,fp22c,fp23c,fp24c*/ = [ ~f1,~f2,~f3,~f4,~f5,~f6,~f7,~f8,~f9,~f10,~f11,~f12 ]; "s"++"\n"++[ ~f1,~f2,~f3,~f4,~f5,~f6,~f7,~f8,~f9,~f10,~f11,~f12 ].asString.postString; ~u1c=~f1;~u2c=~f2;~u3c=~f3;~u4c=~f4;~u5c=~f5;~u6c=~f6;~u7c=~f7;~u8c=~f8;~u9c=~f9;~u10c=~f10;~u11c=~f11;~u12c=~f12; ~si3set.value;

		if(~setgroup1.value == 1, {12.do(x = 0; {("sg1c"++(x=x+1)).asSymbol.envirPut([fp1c,fp2c,fp3c,fp4c,fp5c,fp6c,fp7c,fp8c,fp9c,fp10c,fp11c,fp12c].at(x-1))});});
		if(~setgroup2.value == 1, {12.do(x = 0; {("sg2c"++(x=x+1)).asSymbol.envirPut([fp1c,fp2c,fp3c,fp4c,fp5c,fp6c,fp7c,fp8c,fp9c,fp10c,fp11c,fp12c].at(x-1))});});
		if(~setgroup3.value == 1, {12.do(x = 0; {("sg3c"++(x=x+1)).asSymbol.envirPut([fp1c,fp2c,fp3c,fp4c,fp5c,fp6c,fp7c,fp8c,fp9c,fp10c,fp11c,fp12c].at(x-1))});});
		if(~setgroup4.value == 1, {12.do(x = 0; {("sg4c"++(x=x+1)).asSymbol.envirPut([fp1c,fp2c,fp3c,fp4c,fp5c,fp6c,fp7c,fp8c,fp9c,fp10c,fp11c,fp12c].at(x-1))});});
		if(~setgroup5.value == 1, {12.do(x = 0; {("sg5c"++(x=x+1)).asSymbol.envirPut([fp1c,fp2c,fp3c,fp4c,fp5c,fp6c,fp7c,fp8c,fp9c,fp10c,fp11c,fp12c].at(x-1))});});
		if(~setgroup6.value == 1, {12.do(x = 0; {("sg6c"++(x=x+1)).asSymbol.envirPut([fp1c,fp2c,fp3c,fp4c,fp5c,fp6c,fp7c,fp8c,fp9c,fp10c,fp11c,fp12c].at(x-1))});});
		if(~setgroup7.value == 1, {12.do(x = 0; {("sg7c"++(x=x+1)).asSymbol.envirPut([fp1c,fp2c,fp3c,fp4c,fp5c,fp6c,fp7c,fp8c,fp9c,fp10c,fp11c,fp12c].at(x-1))});});
		if(~setgroup8.value == 1, {12.do(x = 0; {("sg8c"++(x=x+1)).asSymbol.envirPut([fp1c,fp2c,fp3c,fp4c,fp5c,fp6c,fp7c,fp8c,fp9c,fp10c,fp11c,fp12c].at(x-1))});});

		n1.states_([["s1",Color.white,Color.black]]);
		n2.states_([["s2",Color.white,Color.black]]);
		n3.states_([["s3",Color.green,Color.black]]);
		n4.states_([["s4",Color.white,Color.black]]);
		n5.states_([["s5",Color.white,Color.black]]);
		n6.states_([["s6",Color.white,Color.black]]);
		n7.states_([["s7",Color.white,Color.black]]);
		n8.states_([["s8",Color.white,Color.black]]);
	});});
	n4 = Button.new(w,Rect(Window.screenBounds.width-(Window.screenBounds.width/2)+(60*1),Window.screenBounds.height-88,60,60/1.6180339887499)).states_([["s4",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button; if(button.value == 0, {~r1d=fp1d;~r2d=fp2d;~r3d=fp3d;~r4d=fp4d;~r5d=fp5d;~r6d=fp6d;~r7d=fp7d;~r8d=fp8d;~r9d=fp9d;~r10d=fp10d;~r11d=fp11d;~r12d=fp12d; #fp1d,fp2d,fp3d,fp4d,fp5d,fp6d,fp7d,fp8d,fp9d,fp10d,fp11d,fp12d/*,fp13d,fp14d,fp15d,fp16d,fp17d,fp18d,fp19d,fp20d,fp21d,fp22d,fp23d,fp24d*/ = [ ~f1,~f2,~f3,~f4,~f5,~f6,~f7,~f8,~f9,~f10,~f11,~f12 ]; "s"++"\n"++[ ~f1,~f2,~f3,~f4,~f5,~f6,~f7,~f8,~f9,~f10,~f11,~f12 ].asString.postString; ~u1d=~f1;~u2d=~f2;~u3d=~f3;~u4d=~f4;~u5d=~f5;~u6d=~f6;~u7d=~f7;~u8d=~f8;~u9d=~f9;~u10d=~f10;~u11d=~f11;~u12d=~f12; ~si4set.value;

		if(~setgroup1.value == 1, {12.do(x = 0; {("sg1d"++(x=x+1)).asSymbol.envirPut([fp1d,fp2d,fp3d,fp4d,fp5d,fp6d,fp7d,fp8d,fp9d,fp10d,fp11d,fp12d].at(x-1))});});
		if(~setgroup2.value == 1, {12.do(x = 0; {("sg2d"++(x=x+1)).asSymbol.envirPut([fp1d,fp2d,fp3d,fp4d,fp5d,fp6d,fp7d,fp8d,fp9d,fp10d,fp11d,fp12d].at(x-1))});});
		if(~setgroup3.value == 1, {12.do(x = 0; {("sg3d"++(x=x+1)).asSymbol.envirPut([fp1d,fp2d,fp3d,fp4d,fp5d,fp6d,fp7d,fp8d,fp9d,fp10d,fp11d,fp12d].at(x-1))});});
		if(~setgroup4.value == 1, {12.do(x = 0; {("sg4d"++(x=x+1)).asSymbol.envirPut([fp1d,fp2d,fp3d,fp4d,fp5d,fp6d,fp7d,fp8d,fp9d,fp10d,fp11d,fp12d].at(x-1))});});
		if(~setgroup5.value == 1, {12.do(x = 0; {("sg5d"++(x=x+1)).asSymbol.envirPut([fp1d,fp2d,fp3d,fp4d,fp5d,fp6d,fp7d,fp8d,fp9d,fp10d,fp11d,fp12d].at(x-1))});});
		if(~setgroup6.value == 1, {12.do(x = 0; {("sg6d"++(x=x+1)).asSymbol.envirPut([fp1d,fp2d,fp3d,fp4d,fp5d,fp6d,fp7d,fp8d,fp9d,fp10d,fp11d,fp12d].at(x-1))});});
		if(~setgroup7.value == 1, {12.do(x = 0; {("sg7d"++(x=x+1)).asSymbol.envirPut([fp1d,fp2d,fp3d,fp4d,fp5d,fp6d,fp7d,fp8d,fp9d,fp10d,fp11d,fp12d].at(x-1))});});
		if(~setgroup8.value == 1, {12.do(x = 0; {("sg8d"++(x=x+1)).asSymbol.envirPut([fp1d,fp2d,fp3d,fp4d,fp5d,fp6d,fp7d,fp8d,fp9d,fp10d,fp11d,fp12d].at(x-1))});});

		n1.states_([["s1",Color.white,Color.black]]);
		n2.states_([["s2",Color.white,Color.black]]);
		n3.states_([["s3",Color.white,Color.black]]);
		n4.states_([["s4",Color.green,Color.black]]);
		n5.states_([["s5",Color.white,Color.black]]);
		n6.states_([["s6",Color.white,Color.black]]);
		n7.states_([["s7",Color.white,Color.black]]);
		n8.states_([["s8",Color.white,Color.black]]);
	});});
	n5 = Button.new(w,Rect(Window.screenBounds.width-(Window.screenBounds.width/2)-(60*2),Window.screenBounds.height-52,60,60/1.6180339887499)).states_([["s5",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button; if(button.value == 0, {~r1e=fp1e;~r2e=fp2e;~r3e=fp3e;~r4e=fp4e;~r5e=fp5e;~r6e=fp6e;~r7e=fp7e;~r8e=fp8e;~r9e=fp9e;~r10e=fp10e;~r11e=fp11e;~r12e=fp12e; #fp1e,fp2e,fp3e,fp4e,fp5e,fp6e,fp7e,fp8e,fp9e,fp10e,fp11e,fp12e/*,fp13e,fp14e,fp15e,fp16e,fp17e,fp18e,fp19e,fp20e,fp21e,fp22e,fp23e,fp24e*/ = [ ~f1,~f2,~f3,~f4,~f5,~f6,~f7,~f8,~f9,~f10,~f11,~f12 ]; "s"++"\n"++[ ~f1,~f2,~f3,~f4,~f5,~f6,~f7,~f8,~f9,~f10,~f11,~f12 ].asString.postString; ~u1e=~f1;~u2e=~f2;~u3e=~f3;~u4e=~f4;~u5e=~f5;~u6e=~f6;~u7e=~f7;~u8e=~f8;~u9e=~f9;~u10e=~f10;~u11e=~f11;~u12e=~f12; ~si5set.value;

		if(~setgroup1.value == 1, {12.do(x = 0; {("sg1e"++(x=x+1)).asSymbol.envirPut([fp1e,fp2e,fp3e,fp4e,fp5e,fp6e,fp7e,fp8e,fp9e,fp10e,fp11e,fp12e].at(x-1))});});
		if(~setgroup2.value == 1, {12.do(x = 0; {("sg2e"++(x=x+1)).asSymbol.envirPut([fp1e,fp2e,fp3e,fp4e,fp5e,fp6e,fp7e,fp8e,fp9e,fp10e,fp11e,fp12e].at(x-1))});});
		if(~setgroup3.value == 1, {12.do(x = 0; {("sg3e"++(x=x+1)).asSymbol.envirPut([fp1e,fp2e,fp3e,fp4e,fp5e,fp6e,fp7e,fp8e,fp9e,fp10e,fp11e,fp12e].at(x-1))});});
		if(~setgroup4.value == 1, {12.do(x = 0; {("sg4e"++(x=x+1)).asSymbol.envirPut([fp1e,fp2e,fp3e,fp4e,fp5e,fp6e,fp7e,fp8e,fp9e,fp10e,fp11e,fp12e].at(x-1))});});
		if(~setgroup5.value == 1, {12.do(x = 0; {("sg5e"++(x=x+1)).asSymbol.envirPut([fp1e,fp2e,fp3e,fp4e,fp5e,fp6e,fp7e,fp8e,fp9e,fp10e,fp11e,fp12e].at(x-1))});});
		if(~setgroup6.value == 1, {12.do(x = 0; {("sg6e"++(x=x+1)).asSymbol.envirPut([fp1e,fp2e,fp3e,fp4e,fp5e,fp6e,fp7e,fp8e,fp9e,fp10e,fp11e,fp12e].at(x-1))});});
		if(~setgroup7.value == 1, {12.do(x = 0; {("sg7e"++(x=x+1)).asSymbol.envirPut([fp1e,fp2e,fp3e,fp4e,fp5e,fp6e,fp7e,fp8e,fp9e,fp10e,fp11e,fp12e].at(x-1))});});
		if(~setgroup8.value == 1, {12.do(x = 0; {("sg8e"++(x=x+1)).asSymbol.envirPut([fp1e,fp2e,fp3e,fp4e,fp5e,fp6e,fp7e,fp8e,fp9e,fp10e,fp11e,fp12e].at(x-1))});});

		n1.states_([["s1",Color.white,Color.black]]);
		n2.states_([["s2",Color.white,Color.black]]);
		n3.states_([["s3",Color.white,Color.black]]);
		n4.states_([["s4",Color.white,Color.black]]);
		n5.states_([["s5",Color.green,Color.black]]);
		n6.states_([["s6",Color.white,Color.black]]);
		n7.states_([["s7",Color.white,Color.black]]);
		n8.states_([["s8",Color.white,Color.black]]);
	});});
	n6 = Button.new(w,Rect(Window.screenBounds.width-(Window.screenBounds.width/2)-(60*1),Window.screenBounds.height-52,60,60/1.6180339887499)).states_([["s6",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button; if(button.value == 0, {~r1f=fp1f;~r2f=fp2f;~r3f=fp3f;~r4f=fp4f;~r5f=fp5f;~r6f=fp6f;~r7f=fp7f;~r8f=fp8f;~r9f=fp9f;~r10f=fp10f;~r11f=fp11f;~r12f=fp12f; #fp1f,fp2f,fp3f,fp4f,fp5f,fp6f,fp7f,fp8f,fp9f,fp10f,fp11f,fp12f/*,fp13f,fp14f,fp15f,fp16f,fp17f,fp18f,fp19f,fp20f,fp21f,fp22f,fp23f,fp24f*/ = [ ~f1,~f2,~f3,~f4,~f5,~f6,~f7,~f8,~f9,~f10,~f11,~f12 ]; "s"++"\n"++[ ~f1,~f2,~f3,~f4,~f5,~f6,~f7,~f8,~f9,~f10,~f11,~f12 ].asString.postString; ~u1f=~f1;~u2f=~f2;~u3f=~f3;~u4f=~f4;~u5f=~f5;~u6f=~f6;~u7f=~f7;~u8f=~f8;~u9f=~f9;~u10f=~f10;~u11e=~f11;~u12f=~f12; ~si6set.value;

		if(~setgroup1.value == 1, {12.do(x = 0; {("sg1f"++(x=x+1)).asSymbol.envirPut([fp1f,fp2f,fp3f,fp4f,fp5f,fp6f,fp7f,fp8f,fp9f,fp10f,fp11f,fp12f].at(x-1))});});
		if(~setgroup2.value == 1, {12.do(x = 0; {("sg2f"++(x=x+1)).asSymbol.envirPut([fp1f,fp2f,fp3f,fp4f,fp5f,fp6f,fp7f,fp8f,fp9f,fp10f,fp11f,fp12f].at(x-1))});});
		if(~setgroup3.value == 1, {12.do(x = 0; {("sg3f"++(x=x+1)).asSymbol.envirPut([fp1f,fp2f,fp3f,fp4f,fp5f,fp6f,fp7f,fp8f,fp9f,fp10f,fp11f,fp12f].at(x-1))});});
		if(~setgroup4.value == 1, {12.do(x = 0; {("sg4f"++(x=x+1)).asSymbol.envirPut([fp1f,fp2f,fp3f,fp4f,fp5f,fp6f,fp7f,fp8f,fp9f,fp10f,fp11f,fp12f].at(x-1))});});
		if(~setgroup5.value == 1, {12.do(x = 0; {("sg5f"++(x=x+1)).asSymbol.envirPut([fp1f,fp2f,fp3f,fp4f,fp5f,fp6f,fp7f,fp8f,fp9f,fp10f,fp11f,fp12f].at(x-1))});});
		if(~setgroup6.value == 1, {12.do(x = 0; {("sg6f"++(x=x+1)).asSymbol.envirPut([fp1f,fp2f,fp3f,fp4f,fp5f,fp6f,fp7f,fp8f,fp9f,fp10f,fp11f,fp12f].at(x-1))});});
		if(~setgroup7.value == 1, {12.do(x = 0; {("sg7f"++(x=x+1)).asSymbol.envirPut([fp1f,fp2f,fp3f,fp4f,fp5f,fp6f,fp7f,fp8f,fp9f,fp10f,fp11f,fp12f].at(x-1))});});
		if(~setgroup8.value == 1, {12.do(x = 0; {("sg8f"++(x=x+1)).asSymbol.envirPut([fp1f,fp2f,fp3f,fp4f,fp5f,fp6f,fp7f,fp8f,fp9f,fp10f,fp11f,fp12f].at(x-1))});});

		n1.states_([["s1",Color.white,Color.black]]);
		n2.states_([["s2",Color.white,Color.black]]);
		n3.states_([["s3",Color.white,Color.black]]);
		n4.states_([["s4",Color.white,Color.black]]);
		n5.states_([["s5",Color.white,Color.black]]);
		n6.states_([["s6",Color.green,Color.black]]);
		n7.states_([["s7",Color.white,Color.black]]);
		n8.states_([["s8",Color.white,Color.black]]);
	});});
	n7 = Button.new(w,Rect(Window.screenBounds.width-(Window.screenBounds.width/2)+(0),   Window.screenBounds.height-52,60,60/1.6180339887499)).states_([["s7",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button; if(button.value == 0, {~r1g=fp1g;~r2g=fp2g;~r3g=fp3g;~r4g=fp4g;~r5g=fp5g;~r6g=fp6g;~r7g=fp7g;~r8g=fp8g;~r9g=fp9g;~r10g=fp10g;~r11g=fp11g;~r12g=fp12g; #fp1g,fp2g,fp3g,fp4g,fp5g,fp6g,fp7g,fp8g,fp9g,fp10g,fp11g,fp12g/*,fp13g,fp14g,fp15g,fp16g,fp17g,fp18g,fp19g,fp20g,fp21g,fp22g,fp23g,fp24g*/ = [ ~f1,~f2,~f3,~f4,~f5,~f6,~f7,~f8,~f9,~f10,~f11,~f12 ]; "s"++"\n"++[ ~f1,~f2,~f3,~f4,~f5,~f6,~f7,~f8,~f9,~f10,~f11,~f12 ].asString.postString; ~u1g=~f1;~u2g=~f2;~u3g=~f3;~u4g=~f4;~u5g=~f5;~u6g=~f6;~u7g=~f7;~u8g=~f8;~u9g=~f9;~u10g=~f10;~u11f=~f11;~u12g=~f12; ~si7set.value;

		if(~setgroup1.value == 1, {12.do(x = 0; {("sg1g"++(x=x+1)).asSymbol.envirPut([fp1g,fp2g,fp3g,fp4g,fp5g,fp6g,fp7g,fp8g,fp9g,fp10g,fp11g,fp12g].at(x-1))});});
		if(~setgroup2.value == 1, {12.do(x = 0; {("sg2g"++(x=x+1)).asSymbol.envirPut([fp1g,fp2g,fp3g,fp4g,fp5g,fp6g,fp7g,fp8g,fp9g,fp10g,fp11g,fp12g].at(x-1))});});
		if(~setgroup3.value == 1, {12.do(x = 0; {("sg3g"++(x=x+1)).asSymbol.envirPut([fp1g,fp2g,fp3g,fp4g,fp5g,fp6g,fp7g,fp8g,fp9g,fp10g,fp11g,fp12g].at(x-1))});});
		if(~setgroup4.value == 1, {12.do(x = 0; {("sg4g"++(x=x+1)).asSymbol.envirPut([fp1g,fp2g,fp3g,fp4g,fp5g,fp6g,fp7g,fp8g,fp9g,fp10g,fp11g,fp12g].at(x-1))});});
		if(~setgroup5.value == 1, {12.do(x = 0; {("sg5g"++(x=x+1)).asSymbol.envirPut([fp1g,fp2g,fp3g,fp4g,fp5g,fp6g,fp7g,fp8g,fp9g,fp10g,fp11g,fp12g].at(x-1))});});
		if(~setgroup6.value == 1, {12.do(x = 0; {("sg6g"++(x=x+1)).asSymbol.envirPut([fp1g,fp2g,fp3g,fp4g,fp5g,fp6g,fp7g,fp8g,fp9g,fp10g,fp11g,fp12g].at(x-1))});});
		if(~setgroup7.value == 1, {12.do(x = 0; {("sg7g"++(x=x+1)).asSymbol.envirPut([fp1g,fp2g,fp3g,fp4g,fp5g,fp6g,fp7g,fp8g,fp9g,fp10g,fp11g,fp12g].at(x-1))});});
		if(~setgroup8.value == 1, {12.do(x = 0; {("sg8g"++(x=x+1)).asSymbol.envirPut([fp1g,fp2g,fp3g,fp4g,fp5g,fp6g,fp7g,fp8g,fp9g,fp10g,fp11g,fp12g].at(x-1))});});

		n1.states_([["s1",Color.white,Color.black]]);
		n2.states_([["s2",Color.white,Color.black]]);
		n3.states_([["s3",Color.white,Color.black]]);
		n4.states_([["s4",Color.white,Color.black]]);
		n5.states_([["s5",Color.white,Color.black]]);
		n6.states_([["s6",Color.white,Color.black]]);
		n7.states_([["s7",Color.green,Color.black]]);
		n8.states_([["s8",Color.white,Color.black]]);
	});});
	n8 = Button.new(w,Rect(Window.screenBounds.width-(Window.screenBounds.width/2)+(60*1),Window.screenBounds.height-52,60,60/1.6180339887499)).states_([["s8",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button; if(button.value == 0, {~r1h=fp1h;~r2h=fp2h;~r3h=fp3h;~r4h=fp4h;~r5h=fp5h;~r6h=fp6h;~r7h=fp7h;~r8h=fp8h;~r9h=fp9h;~r10h=fp10h;~r11h=fp11h;~r12h=fp12h; #fp1h,fp2h,fp3h,fp4h,fp5h,fp6h,fp7h,fp8h,fp9h,fp10h,fp11h,fp12h/*,fp13h,fp14h,fp15h,fp16h,fp17h,fp18h,fp19h,fp20h,fp21h,fp22h,fp23h,fp24h*/ = [ ~f1,~f2,~f3,~f4,~f5,~f6,~f7,~f8,~f9,~f10,~f11,~f12 ]; "s"++"\n"++[ ~f1,~f2,~f3,~f4,~f5,~f6,~f7,~f8,~f9,~f10,~f11,~f12 ].asString.postString; ~u1h=~f1;~u2h=~f2;~u3h=~f3;~u4h=~f4;~u5h=~f5;~u6h=~f6;~u7h=~f7;~u8h=~f8;~u9h=~f9;~u10h=~f10;~u11g=~f11;~u12h=~f12; ~si8set.value;

		if(~setgroup1.value == 1, {12.do(x = 0; {("sg1h"++(x=x+1)).asSymbol.envirPut([fp1h,fp2h,fp3h,fp4h,fp5h,fp6h,fp7h,fp8h,fp9h,fp10h,fp11h,fp12h].at(x-1))});});
		if(~setgroup2.value == 1, {12.do(x = 0; {("sg2h"++(x=x+1)).asSymbol.envirPut([fp1h,fp2h,fp3h,fp4h,fp5h,fp6h,fp7h,fp8h,fp9h,fp10h,fp11h,fp12h].at(x-1))});});
		if(~setgroup3.value == 1, {12.do(x = 0; {("sg3h"++(x=x+1)).asSymbol.envirPut([fp1h,fp2h,fp3h,fp4h,fp5h,fp6h,fp7h,fp8h,fp9h,fp10h,fp11h,fp12h].at(x-1))});});
		if(~setgroup4.value == 1, {12.do(x = 0; {("sg4h"++(x=x+1)).asSymbol.envirPut([fp1h,fp2h,fp3h,fp4h,fp5h,fp6h,fp7h,fp8h,fp9h,fp10h,fp11h,fp12h].at(x-1))});});
		if(~setgroup5.value == 1, {12.do(x = 0; {("sg5h"++(x=x+1)).asSymbol.envirPut([fp1h,fp2h,fp3h,fp4h,fp5h,fp6h,fp7h,fp8h,fp9h,fp10h,fp11h,fp12h].at(x-1))});});
		if(~setgroup6.value == 1, {12.do(x = 0; {("sg6h"++(x=x+1)).asSymbol.envirPut([fp1h,fp2h,fp3h,fp4h,fp5h,fp6h,fp7h,fp8h,fp9h,fp10h,fp11h,fp12h].at(x-1))});});
		if(~setgroup7.value == 1, {12.do(x = 0; {("sg7h"++(x=x+1)).asSymbol.envirPut([fp1h,fp2h,fp3h,fp4h,fp5h,fp6h,fp7h,fp8h,fp9h,fp10h,fp11h,fp12h].at(x-1))});});
		if(~setgroup8.value == 1, {12.do(x = 0; {("sg8h"++(x=x+1)).asSymbol.envirPut([fp1h,fp2h,fp3h,fp4h,fp5h,fp6h,fp7h,fp8h,fp9h,fp10h,fp11h,fp12h].at(x-1))});});

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
		{~undo.value == 1}{if(([fp1,fp2,fp3,fp4,fp5,fp6,fp7,fp8,fp9,fp10,fp11,fp12] == [~r1,~r2,~r3,~r4,~r5,~r6,~r7,~r8,~r9,~r10,~r11,~r12]).postln, {#fp1,fp2,fp3,fp4,fp5,fp6,fp7,fp8,fp9,fp10,fp11,fp12 = [~u1,~u2,~u3,~u4,~u5,~u6,~u7,~u8,~u9,~u10,~u11,~u12]},{#fp1,fp2,fp3,fp4,fp5,fp6,fp7,fp8,fp9,fp10,fp11,fp12 = [~r1,~r2,~r3,~r4,~r5,~r6,~r7,~r8,~r9,~r10,~r11,~r12]});~undo.value = 0;}
		{~undo.value == 2}{if([fp1b,fp2b,fp3b,fp4b,fp5b,fp6b,fp7b,fp8b,fp9b,fp10b,fp11b,fp12b] == [~r1b,~r2b,~r3b,~r4b,~r5b,~r6b,~r7b,~r8b,~r9b,~r10b,~r11b,~r12b], {#fp1b,fp2b,fp3b,fp4b,fp5b,fp6b,fp7b,fp8b,fp9b,fp10b,fp11b,fp12b = [~u1b,~u2b,~u3b,~u4b,~u5b,~u6b,~u7b,~u8b,~u9b,~u10b,~u11b,~u12b]},{#fp1b,fp2b,fp3b,fp4b,fp5b,fp6b,fp7b,fp8b,fp9b,fp10b,fp11b,fp12b = [~r1b,~r2b,~r3b,~r4b,~r5b,~r6b,~r7b,~r8b,~r9b,~r10b,~r11b,~r12b]});~undo.value = 0;}
		{~undo.value == 3}{if([fp1c,fp2c,fp3c,fp4c,fp5c,fp6c,fp7c,fp8c,fp9c,fp10c,fp11c,fp12c] == [~r1c,~r2c,~r3c,~r4c,~r5c,~r6c,~r7c,~r8c,~r9c,~r10c,~r11c,~r12c], {#fp1c,fp2c,fp3c,fp4c,fp5c,fp6c,fp7c,fp8c,fp9c,fp10c,fp11c,fp12c = [~u1c,~u2c,~u3c,~u4c,~u5c,~u6c,~u7c,~u8c,~u9c,~u10c,~u11c,~u12c]},{#fp1c,fp2c,fp3c,fp4c,fp5c,fp6c,fp7c,fp8c,fp9c,fp10c,fp11c,fp12c = [~r1c,~r2c,~r3c,~r4c,~r5c,~r6c,~r7c,~r8c,~r9c,~r10c,~r11c,~r12c]});~undo.value = 0;}
		{~undo.value == 4}{if([fp1d,fp2d,fp3d,fp4d,fp5d,fp6d,fp7d,fp8d,fp9d,fp10d,fp11d,fp12d] == [~r1d,~r2d,~r3d,~r4d,~r5d,~r6d,~r7d,~r8d,~r9d,~r10d,~r11d,~r12d], {#fp1d,fp2d,fp3d,fp4d,fp5d,fp6d,fp7d,fp8d,fp9d,fp10d,fp11d,fp12d = [~u1d,~u2d,~u3d,~u4d,~u5d,~u6d,~u7d,~u8d,~u9d,~u10d,~u11d,~u12d]},{#fp1d,fp2d,fp3d,fp4d,fp5d,fp6d,fp7d,fp8d,fp9d,fp10d,fp11d,fp12d = [~r1d,~r2d,~r3d,~r4d,~r5d,~r6d,~r7d,~r8d,~r9d,~r10d,~r11d,~r12d]});~undo.value = 0;}
		{~undo.value == 5}{if([fp1e,fp2e,fp3e,fp4e,fp5e,fp6e,fp7e,fp8e,fp9e,fp10e,fp11e,fp12e] == [~r1e,~r2e,~r3e,~r4e,~r5e,~r6e,~r7e,~r8e,~r9e,~r10e,~r11e,~r12e], {#fp1e,fp2e,fp3e,fp4e,fp5e,fp6e,fp7e,fp8e,fp9e,fp10e,fp11e,fp12e = [~u1e,~u2e,~u3e,~u4e,~u5e,~u6e,~u7e,~u8e,~u9e,~u10e,~u11e,~u12e]},{#fp1e,fp2e,fp3e,fp4e,fp5e,fp6e,fp7e,fp8e,fp9e,fp10e,fp11e,fp12e = [~r1e,~r2e,~r3e,~r4e,~r5e,~r6e,~r7e,~r8e,~r9e,~r10e,~r11e,~r12e]});~undo.value = 0;}
		{~undo.value == 6}{if([fp1f,fp2f,fp3f,fp4f,fp5f,fp6f,fp7f,fp8f,fp9f,fp10f,fp11f,fp12f] == [~r1f,~r2f,~r3f,~r4f,~r5f,~r6f,~r7f,~r8f,~r9f,~r10f,~r11f,~r12f], {#fp1f,fp2f,fp3f,fp4f,fp5f,fp6f,fp7f,fp8f,fp9f,fp10f,fp11f,fp12f = [~u1f,~u2f,~u3f,~u4f,~u5f,~u6f,~u7f,~u8f,~u9f,~u10f,~u11f,~u12f]},{#fp1f,fp2f,fp3f,fp4f,fp5f,fp6f,fp7f,fp8f,fp9f,fp10f,fp11f,fp12f = [~r1f,~r2f,~r3f,~r4f,~r5f,~r6f,~r7f,~r8f,~r9f,~r10f,~r11f,~r12f]});~undo.value = 0;}
		{~undo.value == 7}{if([fp1g,fp2g,fp3g,fp4g,fp5g,fp6g,fp7g,fp8g,fp9g,fp10g,fp11g,fp12g] == [~r1g,~r2g,~r3g,~r4g,~r5g,~r6g,~r7g,~r8g,~r9g,~r10g,~r11g,~r12g], {#fp1g,fp2g,fp3g,fp4g,fp5g,fp6g,fp7g,fp8g,fp9g,fp10g,fp11g,fp12g = [~u1g,~u2g,~u3g,~u4g,~u5g,~u6g,~u7g,~u8g,~u9g,~u10g,~u11g,~u12g]},{#fp1g,fp2g,fp3g,fp4g,fp5g,fp6g,fp7g,fp8g,fp9g,fp10g,fp11g,fp12g = [~r1g,~r2g,~r3g,~r4g,~r5g,~r6g,~r7g,~r8g,~r9g,~r10g,~r11g,~r12g]});~undo.value = 0;}
		{~undo.value == 8}{if([fp1h,fp2h,fp3h,fp4h,fp5h,fp6h,fp7h,fp8h,fp9h,fp10h,fp11h,fp12h] == [~r1h,~r2h,~r3h,~r4h,~r5h,~r6h,~r7h,~r8h,~r9h,~r10h,~r11h,~r12h], {#fp1h,fp2h,fp3h,fp4h,fp5h,fp6h,fp7h,fp8h,fp9h,fp10h,fp11h,fp12h = [~u1h,~u2h,~u3h,~u4h,~u5h,~u6h,~u7h,~u8h,~u9h,~u10h,~u11h,~u12h]},{#fp1h,fp2h,fp3h,fp4h,fp5h,fp6h,fp7h,fp8h,fp9h,fp10h,fp11h,fp12h = [~r1h,~r2h,~r3h,~r4h,~r5h,~r6h,~r7h,~r8h,~r9h,~r10h,~r11h,~r12h]});~undo.value = 0;};
	});


	//gsine pop-up menu

	if(~gsine == nil, {~gsine = ~gsine1});

	~gsinemenu = PopUpMenu(w, Rect(20+60*2+16+120,Window.screenBounds.height-88+(30/1.6180339887499*0),60,60/1.6180339887499)).items_(["gs","1","2"]).background_(Color.black).stringColor_(Color.white).action_({arg button;

		if(~gsinemenu.value == 1, {~gsine = ~gsine1});
		if(~gsinemenu.value == 2, {~gsine = ~gsine2});

	});

	case
	{~gsine == nil}{~gsinemenu.value = 0;}
	{~gsine == ~gsine1}{~gsinemenu.value = 0;}
	{~gsine == ~gsine2}{~gsinemenu.value = 1;};


	//start record button

	~startrecord = Button.new(w,Rect(Window.screenBounds.width-(Window.screenBounds.width/3)+39,Window.screenBounds.height-52+19.777087639995,28,28/1.6180339887499)).states_([["rc",Color.white,Color.black],["rc",Color.black,Color.red]]).action_({arg button; Server.default.record; ~numsynths.stop; if(button.value == 0, {button.value = 1});});


	//pause record button

	~pauserecord = Button.new(w,Rect(Window.screenBounds.width-(Window.screenBounds.width/3)+28+39,Window.screenBounds.height-52+19.777087639995,28,28/1.6180339887499)).states_([["prc",Color.white,Color.black],["/prc",Color.black,Color.blue]]).action_({arg button; if(button == 1, {Server.default.pauseRecording;}, {Server.default.record});});


	//stop record button

	~stoprecord = Button.new(w,Rect(Window.screenBounds.width-(Window.screenBounds.width/3)+28+28+39,Window.screenBounds.height-52+19.777087639995,28,28/1.6180339887499)).states_([["/rc",Color.white,Color.black]]).action_({arg button; Server.default.stopRecording; ~startrecord.value = 0; ~pauserecord.value = 0; ~numsynths.stop; ~numsynths.play;});


	//minimize GUI window button

	~min = Button.new(w,Rect(Window.screenBounds.width-20,~bpt+69+5-(20/1.6180339887499),20,20/1.6180339887499)).states_([["m",Color.white,Color.black]]).action_({arg button; w.minimize;});


	//close GUI window button

	~close = Button.new(w,Rect(Window.screenBounds.width-20,~bpt+69+5,20,20/1.6180339887499)).states_([["c",Color.white,Color.black]]).action_({arg button;

		if(~closemessage != nil, {~closemessage.close}, {nil});
		~closemessage = View(w, Rect(Window.screenBounds.width-(340+46),Window.screenBounds.height-(340+46/1.6180339887499)-110,340+46,340+46/1.6180339887499)).background_(Color.black).front;
		~closemessagestring = StaticText(~closemessage, Rect(0,0,340+46,340+46/1.6180339887499)).background_(Color.black);
		~closemessagestring.align = \center;
		~closemessagestring.string ="Close Timewave Synth?";
		~closemessagestring.stringColor = Color.white;
		~closemessagebutton1 = Button.new(~closemessage,Rect(120-46+40,340/1.6180339887499-30,46,46/1.6180339887499)).states_([["Yes",Color.white,Color.black]]).action_({AppClock.sched(0, {w.close; if(~l1a.isRunning == true or: ~l1a1.isRunning == true, {~synthfree.value; ~numsynths.stop; s.freeAll;}, {nil});});});
		~closemessagebutton2 = Button.new(~closemessage,Rect(320+46-130,340/1.6180339887499-30,46,46/1.6180339887499)).states_([["No",Color.white,Color.black]]).action_({AppClock.sched(0, {~closemessage.close;});});
		~closemessage.front;

	});


	w.front; w.fullScreen;

	//Developed by Ken Brant (ken_brant@ymail.com)

}.value);
);
);

//Interpreted King Wen Sequence

/*

(#a,b,c,d,e,f = /*[ 128.43436842029,128.43436842029,128.43436842029,128.43436842029,128.43436842029,128.43436842029  ]*/
[ ~basefreq,~basefreq,~basefreq,~basefreq,~basefreq,~basefreq  ];
~a = a; ~b = b; ~c =c; ~d = d; ~e = e;~f=f;);

~fth = 1.4142135623729;

/*1*/	#a,b,c,d,e,f=[ ~a,~b,~c,~d,~e,~f  ],
/*2*/	[ a = a/~fth, b = b/~fth, c = c/~fth, d = d/~fth, e = e/~fth, f = f/~fth ],
/*3*/	[ a = a,      b = b*~fth, c = c,      d = d,      e = e,      f = f*~fth ],
/*4*/	[ a = a*~fth, b = b/~fth, c = c,      d = d,      e = e*~fth, f = f/~fth ],
/*5*/	[ a = a/~fth, b = b*~fth, c = c,      d = d*~fth, e = e,      f = f*~fth ],
/*6*/	[ a = a*~fth, b = b,      c = c*~fth, d = d/~fth, e = e,      f = f/~fth ],
/*7*/	[ a = a/~fth, b = b/~fth, c = c/~fth, d = d,      e = e,      f = f      ],
/*8*/	[ a = a,      b = b*~fth, c = c,      d = d,      e = e/~fth, f = f      ],
/*9*/	[ a = a*~fth, b = b,      c = c,      d = d*~fth, e = e*~fth, f = f*~fth ],
/*10*/	[ a = a,      b = b,      c = c*~fth, d = d/~fth, e = e,      f = f      ],
/*11*/	[ a = a/~fth, b = b/~fth, c = c/~fth, d = d*~fth, e = e,      f = f      ],
/*12*/	[ a = a*~fth, b = b*~fth, c = c*~fth, d = d/~fth, e = e/~fth, f = f/~fth ],
/*13*/	[ a = a,      b = b,      c = c,      d = d*~fth, e = e,      f = f*~fth ],
/*14*/	[ a = a,      b = b/~fth, c = c,      d = d,      e = e*~fth, f = f      ],
/*15*/	[ a = a/~fth, b = b,      c = c/~fth, d = d,      e = e/~fth, f = f/~fth ],
/*16*/	[ a = a,      b = b,      c = c*~fth, d = d/~fth, e = e,      f = f      ],
/*17*/	[ a = a,      b = b*~fth, c = c,      d = d,      e = e,      f = f*~fth ],
/*18*/	[ a = a*~fth, b = b/~fth, c = c/~fth, d = d*~fth, e = e*~fth, f = f/~fth ],
/*19*/	[ a = a/~fth, b = b,      c = c,      d = d/~fth, e = e,      f = f*~fth ],
/*20*/	[ a = a*~fth, b = b*~fth, c = c,      d = d,      e = e/~fth, f = f/~fth ],
/*21*/	[ a = a,      b = b/~fth, c = c*~fth, d = d,      e = e,      f = f*~fth ],
/*22*/	[ a = a,      b = b,      c = c/~fth, d = d*~fth, e = e,      f = f      ],
/*23*/	[ a = a,      b = b,      c = c,      d = d/~fth, e = e,      f = f/~fth ],
/*24*/	[ a = a/~fth, b = b,      c = c,      d = d,      e = e,      f = f*~fth ],
/*25*/	[ a = a*~fth, b = b*~fth, c = c*~fth, d = d,      e = e,      f = f      ],
/*26*/	[ a = a,      b = b/~fth, c = c/~fth, d = d*~fth, e = e*~fth, f = f 	 ],
/*27*/	[ a = a,      b = b,      c = c,      d = d/~fth, e = e/~fth, f = f      ],
/*28*/	[ a = a/~fth, b = b*~fth, c = c*~fth, d = d*~fth, e = e*~fth, f = f/~fth ],
/*29*/	[ a = a,      b = b,      c = c/~fth, d = d/~fth, e = e,      f = f      ],
/*30*/	[ a = a*~fth, b = b/~fth, c = c*~fth, d = d*~fth, e = e/~fth, f = f*~fth ],
/*31*/	[ a = a/~fth, b = b*~fth, c = c,      d = d,      e = e,      f = f/~fth ],
/*32*/	[ a = a,      b = b/~fth, c = c,      d = d,      e = e*~fth, f = f      ],
/*33*/	[ a = a*~fth, b = b*~fth, c = c,      d = d,      e = e/~fth, f = f      ],
/*34*/	[ a = a/~fth, b = b/~fth, c = c,      d = d,      e = e*~fth, f = f*~fth ],
/*35*/	[ a = a*~fth, b = b,      c = c,      d = d/~fth, e = e/~fth, f = f/~fth ],
/*36*/	[ a = a/~fth, b = b,      c = c/~fth, d = d*~fth, e = e,      f = f*~fth ],
/*37*/	[ a = a*~fth, b = b*~fth, c = c,      d = d,      e = e,      f = f      ],
/*38*/	[ a = a,      b = b/~fth, c = c*~fth, d = d/~fth, e = e*~fth, f = f      ],
/*39*/	[ a = a/~fth, b = b*~fth, c = c/~fth, d = d*~fth, e = e/~fth, f = f/~fth ],
/*40*/	[ a = a,      b = b/~fth, c = c*~fth, d = d/~fth, e = e*~fth, f = f      ],
/*41*/	[ a = a*~fth, b = b,      c = c/~fth, d = d,      e = e,      f = f*~fth ],
/*42*/	[ a = a,      b = b*~fth, c = c,      d = d,      e = e/~fth, f = f      ],
/*43*/	[ a = a/~fth, b = b,      c = c*~fth, d = d*~fth, e = e*~fth, f = f      ],
/*44*/	[ a = a*~fth, b = b,      c = c,      d = d,      e = e,      f = f/~fth ],
/*45*/	[ a = a/~fth, b = b,      c = c,      d = d/~fth, e = e/~fth, f = f      ],
/*46*/	[ a = a,      b = b/~fth, c = c/~fth, d = d*~fth, e = e*~fth, f = f      ],
/*47*/	[ a = a,      b = b*~fth, c = c*~fth, d = d/~fth, e = e,      f = f      ],
/*48*/	[ a = a,      b = b,      c = c/~fth, d = d*~fth, e = e,      f = f      ],
/*49*/	[ a = a,      b = b,      c = c*~fth, d = d,      e = e/~fth, f = f*~fth ],
/*50*/	[ a = a*~fth, b = b/~fth, c = c,      d = d,      e = e*~fth, f = f/~fth ],
/*51*/	[ a = a/~fth, b = b,      c = c,      d = d/~fth, e = e/~fth, f = f*~fth ],
/*52*/	[ a = a*~fth, b = b,      c = c/~fth, d = d*~fth, e = e,      f = f/~fth ],
/*53*/	[ a = a,      b = b*~fth, c = c,      d = d,      e = e,      f = f      ],
/*54*/	[ a = a/~fth, b = b/~fth, c = c*~fth, d = d/~fth, e = e*~fth, f = f*~fth ],
/*55*/	[ a = a,      b = b,      c = c,      d = d*~fth, e = e/~fth, f = f      ],
/*56*/	[ a = a*~fth, b = b,      c = c,      d = d,      e = e,      f = f/~fth ],
/*57*/	[ a = a,      b = b*~fth, c = c/~fth, d = d,      e = e*~fth, f = f      ],
/*58*/	[ a = a/~fth, b = b,      c = c*~fth, d = d/~fth, e = e,      f = f*~fth ],
/*59*/	[ a = a*~fth, b = b,      c = c/~fth, d = d,      e = e,      f = f/~fth ],
/*60*/	[ a = a/~fth, b = b,      c = c,      d = d,      e = e,      f = f*~fth ],
/*61*/	[ a = a*~fth, b = b,      c = c,      d = d,      e = e,      f = f      ],
/*62*/	[ a = a/~fth, b = b/~fth, c = c*~fth, d = d*~fth, e = e/~fth, f = f/~fth ],
/*63*/	[ a = a,      b = b*~fth, c = c/~fth, d = d,      e = e,      f = f*~fth ],
/*64*/	[ a = a*~fth, b = b/~fth, c = c*~fth, d = d/~fth, e = e*~fth, f = f/~fth ]

/*1*/	[ a = a*n1,      b = b*n1*~fth, c = c*n1,      d = d*n1*~fth, e = e*n1,      f = f*n1*~fth ],...

OR

/*1*/	#a,b,c,d,e,f=[ ~a,~b,~c,~d,~e,~f  ],
/*2*/	[ a = a/~fth*n1, b = b/~fth*n1, c = c/~fth*n1, d = d/~fth*n1, e = e/~fth*n1, f = f/~fth*n1 ],
/*3*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f*~fth    ],
/*4*/	[ a = a*~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f/~fth    ],
/*5*/	[ a = a/~fth,    b = b*~fth,    c = c,         d = d*~fth,    e = e,         f = f*~fth    ],
/*6*/	[ a = a*~fth,    b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f/~fth    ],
/*7*/	[ a = a/~fth,    b = b/~fth,    c = c/~fth,    d = d,         e = e,         f = f         ],
/*8*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f         ],
/*9*/	[ a = a*~fth,    b = b,         c = c,         d = d*~fth,    e = e*~fth,    f = f*~fth    ],
/*10*/	[ a = a,         b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f         ],
/*11*/	[ a = a/~fth,    b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e,         f = f         ],
/*12*/	[ a = a*~fth*n2, b = b*~fth*n2, c = c*~fth*n2, d = d/~fth*n2, e = e/~fth*n2, f = f/~fth*n2 ],
/*13*/	[ a = a,         b = b,         c = c,         d = d*~fth,    e = e,         f = f*~fth    ],
/*14*/	[ a = a,         b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f         ],
/*15*/	[ a = a/~fth,    b = b,         c = c/~fth,    d = d,         e = e/~fth,    f = f/~fth    ],
/*16*/	[ a = a,         b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f         ],
/*17*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f*~fth    ],
/*18*/	[ a = a*~fth*n3, b = b/~fth*n3, c = c/~fth*n3, d = d*~fth*n3, e = e*~fth*n3, f = f/~fth*n3 ],
/*19*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e,         f = f*~fth    ],
/*20*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f/~fth    ],
/*21*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d,         e = e,         f = f*~fth    ],
/*22*/	[ a = a,         b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f         ],
/*23*/	[ a = a,         b = b,         c = c,         d = d/~fth,    e = e,         f = f/~fth    ],
/*24*/	[ a = a/~fth,    b = b,         c = c,         d = d,         e = e,         f = f*~fth    ],
/*25*/	[ a = a*~fth,    b = b*~fth,    c = c*~fth,    d = d,         e = e,         f = f         ],
/*26*/	[ a = a,         b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e*~fth,    f = f         ],
/*27*/	[ a = a,         b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f         ],
/*28*/	[ a = a/~fth*n4, b = b*~fth*n4, c = c*~fth*n4, d = d*~fth*n4, e = e*~fth*n4, f = f/~fth*n4 ],
/*29*/	[ a = a,         b = b,         c = c/~fth,    d = d/~fth,    e = e,         f = f         ],
/*30*/	[ a = a*~fth*n5, b = b/~fth*n5, c = c*~fth*n5, d = d*~fth*n5, e = e/~fth*n5, f = f*~fth*n5 ],
/*31*/	[ a = a/~fth,    b = b*~fth,    c = c,         d = d,         e = e,         f = f/~fth    ],
/*32*/	[ a = a,         b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f         ],
/*33*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f         ],
/*34*/	[ a = a/~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f*~fth    ],
/*35*/	[ a = a*~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f/~fth    ],
/*36*/	[ a = a/~fth,    b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f*~fth    ],
/*37*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e,         f = f         ],
/*38*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d/~fth,    e = e*~fth,    f = f         ],
/*39*/	[ a = a/~fth*n6, b = b*~fth*n6, c = c/~fth*n6, d = d*~fth*n6, e = e/~fth*n6, f = f/~fth*n6 ],
/*40*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d/~fth,    e = e*~fth,    f = f         ],
/*41*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d,         e = e,         f = f*~fth    ],
/*42*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f         ],
/*43*/	[ a = a/~fth,    b = b,         c = c*~fth,    d = d*~fth,    e = e*~fth,    f = f         ],
/*44*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f/~fth    ],
/*45*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f         ],
/*46*/	[ a = a,         b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e*~fth,    f = f         ],
/*47*/	[ a = a,         b = b*~fth,    c = c*~fth,    d = d/~fth,    e = e,         f = f         ],
/*48*/	[ a = a,         b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f         ],
/*49*/	[ a = a,         b = b,         c = c*~fth,    d = d,         e = e/~fth,    f = f*~fth    ],
/*50*/	[ a = a*~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f/~fth    ],
/*51*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f*~fth    ],
/*52*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f/~fth    ],
/*53*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f         ],
/*54*/	[ a = a/~fth*n7, b = b/~fth*n7, c = c*~fth*n7, d = d/~fth*n7, e = e*~fth*n7, f = f*~fth*n7 ],
/*55*/	[ a = a,         b = b,         c = c,         d = d*~fth,    e = e/~fth,    f = f         ],
/*56*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f/~fth    ],
/*57*/	[ a = a,         b = b*~fth,    c = c/~fth,    d = d,         e = e*~fth,    f = f         ],
/*58*/	[ a = a/~fth,    b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f*~fth    ],
/*59*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d,         e = e,         f = f/~fth    ],
/*60*/	[ a = a/~fth,    b = b,         c = c,         d = d,         e = e,         f = f*~fth    ],
/*61*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f         ],
/*62*/	[ a = a/~fth*n8, b = b/~fth*n8, c = c*~fth*n8, d = d*~fth*n8, e = e/~fth*n8, f = f/~fth*n8 ],
/*63*/	[ a = a,         b = b*~fth,    c = c/~fth,    d = d,         e = e,         f = f*~fth    ],
/*64*/	[ a = a*~fth*n9, b = b/~fth*n9, c = c*~fth*n9, d = d/~fth*n9, e = e*~fth*n9, f = f/~fth*n9 ],

/*1*/	[ a = a,         b = b*~fth,    c = c,         d = d*~fth,    e = e,         f = f*~fth    ],...

*/
