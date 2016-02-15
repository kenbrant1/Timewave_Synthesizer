//To run the synth, simply click anywhere within the parenthesis of the main function below and press "ctrl - enter" or "cmd - return".
//A guide to using the instrument is available by clicking on the "i" button in the bottom right corner of the GUI.
//Several lines down, where it says "//VARIABLES YOU MAY WISH TO CHANGE", are variables that you can change for various things,
//including key codes for keyboard functions - which is recommended.

//It is recommended to reboot the interpreter in the "Language" toolbar, or by hightlighting "(thisProcess.platform.recompile);"
//and pressing "ctrl - enter" or "cmd - return", before each server boot. Rebooting the interpreter is not needed to
//evaluate the code below if the server is booted.


//(thisProcess.platform.recompile); //Reboot the interpreter before each
//server boot by hightlighting "(thisProcess.platform.recompile);" and pressing "ctrl - enter" or "cmd - return”

(
~server_type = 0; // "0" to boot from local server. "1" to boot from the Supernova server.

~start_timer = 0;
case
{~server_type == 0}{
	if(Server.default.serverRunning == false, {~start_timer = 0;
		({//Boot Supercollider
			var mem, blocksize;
			w = Window("", Rect(Window.screenBounds.width/2-(340/2),Window.screenBounds.height/2-(340/1.61803398875/2),340,340/1.61803398875)).front;
			a = StaticText(w, Rect(10, 10, 70, 20));
			a.string = "loading...";
			Server.quitAll;
			Server.default = Server.local;
			MIDIIn.connectAll;
			AppClock.sched(~start_timer+4,{
				~icl6 = Server.default;
				mem = 2097152/4;
				blocksize = 64;
				~icl61 = Server( "server2", NetAddr("127.0.0.1",  57111 ));
				~icl62 = Server( "server3", NetAddr("127.0.0.1",  57112 ));
				~icl63 = Server( "server4", NetAddr("127.0.0.1",  57113 ));
				~icl6.options.memSize = mem;
				~icl61.options.memSize = mem;
				~icl62.options.memSize = mem;
				~icl63.options.memSize = mem;
				~icl6.options.blockSize = blocksize;
				~icl61.options.blockSize = blocksize;
				~icl62.options.blockSize = blocksize;
				~icl63.options.blockSize = blocksize;
				~icl6.options_( s.options ).boot;
				~icl61.options_( s.options ).boot;
				~icl62.options_( s.options ).boot;
				~icl63.options_( s.options ).boot;
		});}.value);
	},{~start_timer = (-6)});
}
{~server_type == 1}{
	if(Server.default.serverRunning == false, {~start_timer = 0;
		(//Boot Supernova
			w = Window("", Rect(Window.screenBounds.width/2-(340/2),Window.screenBounds.height/2-(340/1.61803398875/2),340,340/1.61803398875)).front;
			a = StaticText(w, Rect(10, 10, 70, 20));
			a.string = "loading...";
			Server.quitAll;
			s.boot;
			AppClock.sched(7,{
				s.quit;
			});
			AppClock.sched(11,{
				MIDIIn.connectAll;
			});
			AppClock.sched(16,{
				Server.supernova;
				s.options.blockSize = 64;
				s.options.memSize = 2097152/4;
				s.boot;
			});
		);
	},{~start_timer = (-22)});
};

AppClock.sched((case
	{~server_type == 0}{~start_timer+8}
	{~server_type == 1}{~start_timer+24}
	{(~server_type != 0) or: (~server_type != 1)}{0};), {if((~server_type == 0) or: (~server_type == 1), {w.close;});

		({
		var point, w, view, view2,
		vol = 0.02,mute1,mute2,mute3,mute4,mute5,mute6,mute7,muteall,unmuteall,
		g1,g2,g6,g8,g33,g48,g64,g72,g88,gm,ngm1,ngm2,ngm6,set1,set2,menu1,menu2,
		ts,sts,str,spaceb,b1,b2,b3,b4,button,button1,info,
		bplaceo1,bplaceo2,bplaceo3,bplaceo4,bplacef1,bplacef2,bplacef3,bplacef4,bplaceo5,bplaceo6,bplaceo7,bplaceo8,bplacef5,bplacef6,bplacef7,bplacef8,n1,n2,n3,n4,n5,n6,n7,n8,keycodeb,
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


		// A tuning frequency in hz

		~tuning_frequency = 432; //default 432 hz

		~freqmap = (
			i = ~tuning_frequency
			/ (2 ** (69 / 12)); a = (-1); b = (-1);
			Array.fill(128, {i * (2 ** (((a=a+1) / 12).trunc)) * ( (2 ** (12.reciprocal)) ** ((b=b+1)  % 12));
		}));/*~freqmap = (i = 8.0271480262684/*-0.0000000000024*/; ~stepratio = 1.0594630943593; Array.fill(128, { i = i*~stepratio;}));*/


		//base frequency for synth inst

		~base_frequency = 128.43436842029; //default 128.43436842029 hz


		//starting midi number for arrow keys

			if(~f1 == nil, {~freqmapval1 = 69},{~freqmapval1 = ~f1.cpsmidi});
			if(~f2 == nil, {~freqmapval2 = 69},{~freqmapval2 = ~f2.cpsmidi});
			if(~f3 == nil, {~freqmapval3 = 69},{~freqmapval3 = ~f3.cpsmidi});
			if(~f4 == nil, {~freqmapval4 = 69},{~freqmapval4 = ~f4.cpsmidi});
			if(~f5 == nil, {~freqmapval5 = 69},{~freqmapval5 = ~f5.cpsmidi});
			if(~f6 == nil, {~freqmapval6 = 69},{~freqmapval6 = ~f6.cpsmidi});
			if(~f7 == nil, {~freqmapval7 = 69},{~freqmapval7 = ~f7.cpsmidi});


		//volume

		~vol = 0.006; //default 0.006
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


		//key codes for keyboard functions - either unicode or keycode. to find key codes, see below

		~rightarrow_keycode = 124;
		~leftarrow_keycode = 123;
		~uparrow_keycode = 126;
		~downarrow_keycode = 125;
		~enter_unicode = 13;
		~s_unicode = 115;
		~m_unicode = 109;
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

		~dc1 = 25; ~dc2 = 345; ~dca = 10;


		//increase or decrease magnitude of second and third harmonics

		~icd3 = 3; //3
		~icd6 = 6; //6


		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		#f1,f2,f3,f4,f5,f6,f7/*,f8,f9,f10,f11,f12*//*,f13,f14,f15,f16,f17,f18,f19,f20,f21,f22,f23,f24*/ =
			[432/1.61803398875/1.61803398875/1.61803398875, 432/1.61803398875, 432*1.61803398875, 432, 432*1.61803398875*1.61803398875 , 432/1.61803398875/1.61803398875,432*1.61803398875*1.61803398875*1.61803398875 ];

			if(([ ~f1,~f2,~f3,~f4,~f5,~f6,~f7,~f8,~f9,~f10,~f11,~f12 ] == [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil]), {[~f1=f1,~f2=f2,~f3=f3,~f4=f4,~f5=f5,~f6=f6,~f7=f7]});


			#fp1,fp2,fp3,fp4,fp5,fp6,fp7,fp8,fp9,fp10,fp11,fp12 = [~u1,~u2,~u3,~u4,~u5,~u6,~u7,~u8,~u9,~u10,~u11,~u12];
			#fp1b,fp2b,fp3b,fp4b,fp5b,fp6b,fp7b,fp8b,fp9b,fp10b,fp11b,fp12b = [~u1b,~u2b,~u3b,~u4b,~u5b,~u6b,~u7b,~u8b,~u9b,~u10b,~u11b,~u12b];
			#fp1c,fp2c,fp3c,fp4c,fp5c,fp6c,fp7c,fp8c,fp9c,fp10c,fp11c,fp12c = [~u1c,~u2c,~u3c,~u4c,~u5c,~u6c,~u7c,~u8c,~u9c,~u10c,~u11c,~u12c];
			#fp1d,fp2d,fp3d,fp4d,fp5d,fp6d,fp7d,fp8d,fp9d,fp10d,fp11d,fp12d = [~u1d,~u2d,~u3d,~u4d,~u5d,~u6d,~u7d,~u8d,~u9d,~u10d,~u11d,~u12d];
			#fp1e,fp2e,fp3e,fp4e,fp5e,fp6e,fp7e,fp8e,fp9e,fp10e,fp11e,fp12e = [~u1e,~u2e,~u3e,~u4e,~u5e,~u6e,~u7e,~u8e,~u9e,~u10e,~u11e,~u12e];
			#fp1f,fp2f,fp3f,fp4f,fp5f,fp6f,fp7f,fp8f,fp9f,fp10f,fp11f,fp12f = [~u1f,~u2f,~u3f,~u4f,~u5f,~u6f,~u7f,~u8f,~u9f,~u10f,~u11f,~u12f];
			#fp1g,fp2g,fp3g,fp4g,fp5g,fp6g,fp7g,fp8g,fp9g,fp10g,fp11g,fp12g = [~u1g,~u2g,~u3g,~u4g,~u5g,~u6g,~u7g,~u8g,~u9g,~u10g,~u11g,~u12g];
			#fp1h,fp2h,fp3h,fp4h,fp5h,fp6h,fp7h,fp8h,fp9h,fp10h,fp11h,fp12h = [~u1h,~u2h,~u3h,~u4h,~u5h,~u6h,~u7h,~u8h,~u9h,~u10h,~u11h,~u12h];

		/*	#fp1,fp2,fp3,fp4,fp5,fp6,fp7,fp8,fp9,fp10,fp11,fp12 = [];
			#fp1b,fp2b,fp3b,fp4b,fp5b,fp6b,fp7b,fp8b,fp9b,fp10b,fp11b,fp12b = [];
			#fp1c,fp2c,fp3c,fp4c,fp5c,fp6c,fp7c,fp8c,fp9c,fp10c,fp11c,fp12c = [];
			#fp1d,fp2d,fp3d,fp4d,fp5d,fp6d,fp7d,fp8d,fp9d,fp10d,fp11d,fp12d = [];
			#fp1e,fp2e,fp3e,fp4e,fp5e,fp6e,fp7e,fp8e,fp9e,fp10e,fp11e,fp12e = [];
			#fp1f,fp2f,fp3f,fp4f,fp5f,fp6f,fp7f,fp8f,fp9f,fp10f,fp11f,fp12f = [];
			#fp1g,fp2g,fp3g,fp4g,fp5g,fp6g,fp7g,fp8g,fp9g,fp10g,fp11g,fp12g = [];
			#fp1h,fp2h,fp3h,fp4h,fp5h,fp6h,fp7h,fp8h,fp9h,fp10h,fp11h,fp12h = [];*/

			~gsine = {
						SynthDef(\gsineicfld, {arg graindur = 0.04, dur = 2000, atk = 0.007, rel = 0.01, gate = 1, amp = 1, i = 1, vol = ~vol, rate = 20, tune = 0,dseqval,
							a, b, c, d, e, f, pan=0, fc = 1;
							var s1, out, env1, s2, dseq,n1,n2,n3,n4,n5,n6,n7,n8,n9;
							#n1,n2,n3,n4,n5,n6,n7,n8,n9=[~nval,~nval,~nval,~nval,~nval,~nval,~nval,~nval,~nval];
							dseq = Dseq([/*1*/	#a,b,c,d,e,f=[ ~a,~b,~c,~d,~e,~f  ],/*2*/	[ a = a/~fth*n1, b = b/~fth*n1, c = c/~fth*n1, d = d/~fth*n1, e = e/~fth*n1, f = f/~fth*n1 ],/*3*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f*~fth  ],/*4*/	[ a = a*~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f/~fth  ],/*5*/	[ a = a/~fth,    b = b*~fth,    c = c,         d = d*~fth,    e = e,         f = f*~fth ],/*6*/	[ a = a*~fth,    b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f/~fth  ],/*7*/	[ a = a/~fth,    b = b/~fth,    c = c/~fth,    d = d,         e = e,         f = f ],/*8*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*9*/	[ a = a*~fth,    b = b,         c = c,         d = d*~fth,    e = e*~fth,    f = f*~fth ],/*10*/	[ a = a,         b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*11*/	[ a = a/~fth,    b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*12*/	[ a = a*~fth*n2, b = b*~fth*n2, c = c*~fth*n2, d = d/~fth*n2, e = e/~fth*n2, f = f/~fth*n2 ],/*13*/	[ a = a,         b = b,         c = c,         d = d*~fth,    e = e,         f = f*~fth ],/*14*/	[ a = a,         b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f],/*15*/	[ a = a/~fth,    b = b,         c = c/~fth,    d = d,         e = e/~fth,    f = f/~fth ],/*16*/	[ a = a,         b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*17*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f*~fth],/*18*/	[ a = a*~fth*n3, b = b/~fth*n3, c = c/~fth*n3, d = d*~fth*n3, e = e*~fth*n3, f = f/~fth*n3 ],/*19*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e,         f = f*~fth ],/*20*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f/~fth ],/*21*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d,         e = e,         f = f*~fth ],/*22*/	[ a = a,         b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*23*/	[ a = a,         b = b,         c = c,         d = d/~fth,    e = e,         f = f/~fth ],/*24*/	[ a = a/~fth,    b = b,         c = c,         d = d,         e = e,         f = f*~fth ],/*25*/	[ a = a*~fth,    b = b*~fth,    c = c*~fth,    d = d,         e = e,         f = f ],/*26*/	[ a = a,         b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*27*/	[ a = a,         b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f ],/*28*/	[ a = a/~fth*n4, b = b*~fth*n4, c = c*~fth*n4, d = d*~fth*n4, e = e*~fth*n4, f = f/~fth*n4 ],/*29*/	[ a = a,         b = b,         c = c/~fth,    d = d/~fth,    e = e,         f = f ],/*30*/	[ a = a*~fth*n5, b = b/~fth*n5, c = c*~fth*n5, d = d*~fth*n5, e = e/~fth*n5, f = f*~fth*n5 ],/*31*/	[ a = a/~fth,    b = b*~fth,    c = c,         d = d,         e = e,         f = f/~fth ],/*32*/	[ a = a,         b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f ],/*33*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*34*/	[ a = a/~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f*~fth ],/*35*/	[ a = a*~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f/~fth ],/*36*/	[ a = a/~fth,    b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f*~fth ],/*37*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e,         f = f ],/*38*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d/~fth,    e = e*~fth,    f = f ],/*39*/	[ a = a/~fth*n6, b = b*~fth*n6, c = c/~fth*n6, d = d*~fth*n6, e = e/~fth*n6, f = f/~fth*n6 ],/*40*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d/~fth,    e = e*~fth,    f = f ],/*41*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d,         e = e,         f = f*~fth ],/*42*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*43*/	[ a = a/~fth,    b = b,         c = c*~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*44*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f/~fth ],/*45*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f ],/*46*/	[ a = a,         b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*47*/	[ a = a,         b = b*~fth,    c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*48*/	[ a = a,         b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*49*/	[ a = a,         b = b,         c = c*~fth,    d = d,         e = e/~fth,    f = f*~fth ],/*50*/	[ a = a*~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f/~fth ],/*51*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f*~fth ],/*52*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f/~fth ],/*53*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f ],/*54*/	[ a = a/~fth*n7, b = b/~fth*n7, c = c*~fth*n7, d = d/~fth*n7, e = e*~fth*n7, f = f*~fth*n7 ],/*55*/	[ a = a,         b = b,         c = c,         d = d*~fth,    e = e/~fth,    f = f ],/*56*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f/~fth ],/*57*/	[ a = a,         b = b*~fth,    c = c/~fth,    d = d,         e = e*~fth,    f = f ],/*58*/	[ a = a/~fth,    b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f*~fth ],/*59*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d,         e = e,         f = f/~fth ],/*60*/	[ a = a/~fth,    b = b,         c = c,         d = d,         e = e,         f = f*~fth ],/*61*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f ],/*62*/	[ a = a/~fth*n8, b = b/~fth*n8, c = c*~fth*n8, d = d*~fth*n8, e = e/~fth*n8, f = f/~fth*n8 ],/*63*/	[ a = a,         b = b*~fth,    c = c/~fth,    d = d,         e = e,         f = f*~fth ],/*64*/	[ a = a*~fth*n9, b = b/~fth*n9, c = c*~fth*n9, d = d/~fth*n9, e = e*~fth*n9, f = f/~fth*n9 ]]
								++Array.fill((~gsinenum -1), {[/*1*/	[ a = a,         b = b*~fth,    c = c,         d = d*~fth,    e = e,         f = f*~fth ],/*2*/	[ a = a/~fth*n1, b = b/~fth*n1, c = c/~fth*n1, d = d/~fth*n1, e = e/~fth*n1, f = f/~fth*n1 ],/*3*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f*~fth  ],/*4*/	[ a = a*~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f/~fth  ],/*5*/	[ a = a/~fth,    b = b*~fth,    c = c,         d = d*~fth,    e = e,         f = f*~fth ],/*6*/	[ a = a*~fth,    b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f/~fth  ],/*7*/	[ a = a/~fth,    b = b/~fth,    c = c/~fth,    d = d,         e = e,         f = f ],/*8*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*9*/	[ a = a*~fth,    b = b,         c = c,         d = d*~fth,    e = e*~fth,    f = f*~fth ],/*10*/	[ a = a,         b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*11*/	[ a = a/~fth,    b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*12*/	[ a = a*~fth*n2, b = b*~fth*n2, c = c*~fth*n2, d = d/~fth*n2, e = e/~fth*n2, f = f/~fth*n2 ],/*13*/	[ a = a,         b = b,         c = c,         d = d*~fth,    e = e,         f = f*~fth ],/*14*/	[ a = a,         b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f],/*15*/	[ a = a/~fth,    b = b,         c = c/~fth,    d = d,         e = e/~fth,    f = f/~fth ],/*16*/	[ a = a,         b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*17*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f*~fth],/*18*/	[ a = a*~fth*n3, b = b/~fth*n3, c = c/~fth*n3, d = d*~fth*n3, e = e*~fth*n3, f = f/~fth*n3 ],/*19*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e,         f = f*~fth ],/*20*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f/~fth ],/*21*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d,         e = e,         f = f*~fth ],/*22*/	[ a = a,         b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*23*/	[ a = a,         b = b,         c = c,         d = d/~fth,    e = e,         f = f/~fth ],/*24*/	[ a = a/~fth,    b = b,         c = c,         d = d,         e = e,         f = f*~fth ],/*25*/	[ a = a*~fth,    b = b*~fth,    c = c*~fth,    d = d,         e = e,         f = f ],/*26*/	[ a = a,         b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*27*/	[ a = a,         b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f ],/*28*/	[ a = a/~fth*n4, b = b*~fth*n4, c = c*~fth*n4, d = d*~fth*n4, e = e*~fth*n4, f = f/~fth*n4 ],/*29*/	[ a = a,         b = b,         c = c/~fth,    d = d/~fth,    e = e,         f = f ],/*30*/	[ a = a*~fth*n5, b = b/~fth*n5, c = c*~fth*n5, d = d*~fth*n5, e = e/~fth*n5, f = f*~fth*n5 ],/*31*/	[ a = a/~fth,    b = b*~fth,    c = c,         d = d,         e = e,         f = f/~fth ],/*32*/	[ a = a,         b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f ],/*33*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*34*/	[ a = a/~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f*~fth ],/*35*/	[ a = a*~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f/~fth ],/*36*/	[ a = a/~fth,    b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f*~fth ],/*37*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e,         f = f ],/*38*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d/~fth,    e = e*~fth,    f = f ],/*39*/	[ a = a/~fth*n6, b = b*~fth*n6, c = c/~fth*n6, d = d*~fth*n6, e = e/~fth*n6, f = f/~fth*n6 ],/*40*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d/~fth,    e = e*~fth,    f = f ],/*41*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d,         e = e,         f = f*~fth ],/*42*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*43*/	[ a = a/~fth,    b = b,         c = c*~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*44*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f/~fth ],/*45*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f ],/*46*/	[ a = a,         b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*47*/	[ a = a,         b = b*~fth,    c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*48*/	[ a = a,         b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*49*/	[ a = a,         b = b,         c = c*~fth,    d = d,         e = e/~fth,    f = f*~fth ],/*50*/	[ a = a*~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f/~fth ],/*51*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f*~fth ],/*52*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f/~fth ],/*53*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f ],/*54*/	[ a = a/~fth*n7, b = b/~fth*n7, c = c*~fth*n7, d = d/~fth*n7, e = e*~fth*n7, f = f*~fth*n7 ],/*55*/	[ a = a,         b = b,         c = c,         d = d*~fth,    e = e/~fth,    f = f ],/*56*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f/~fth ],/*57*/	[ a = a,         b = b*~fth,    c = c/~fth,    d = d,         e = e*~fth,    f = f ],/*58*/	[ a = a/~fth,    b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f*~fth ],/*59*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d,         e = e,         f = f/~fth ],/*60*/	[ a = a/~fth,    b = b,         c = c,         d = d,         e = e,         f = f*~fth ],/*61*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f ],/*62*/	[ a = a/~fth*n8, b = b/~fth*n8, c = c*~fth*n8, d = d*~fth*n8, e = e/~fth*n8, f = f/~fth*n8 ],/*63*/	[ a = a,         b = b*~fth,    c = c/~fth,    d = d,         e = e,         f = f*~fth ],/*64*/	[ a = a*~fth*n9, b = b/~fth*n9, c = c*~fth*n9, d = d/~fth*n9, e = e*~fth*n9, f = f/~fth*n9 ]]
							}).flatten, inf);
							//env1 = EnvGen.kr(Env([0, 1, 1, 0], [0, dur, 0]), levelScale: amp, doneAction: 2);
							s1 = GrainSin.ar(1, Impulse.ar(dur+tune), 1/(dur+tune),Demand.ar(Impulse.ar(dur+tune), 0, dseq)*fc);
							OffsetOut.ar(0, s1.dup*vol);
						}, [\ir]).add;

						SynthDef(\gsineicrld, {arg graindur = 0.04, dur = 2000, atk = 0.007, rel = 0.01, gate = 1, amp = 1, i = 1, vol = ~vol, rate = 20, tune = 0,dseqval,
							a, b, c, d, e, f, pan=0, fc = 1, id = -1;
							var s1, out, env1, s2, dseq,n1,n2,n3,n4,n5,n6,n7,n8,n9,af;
							#n1,n2,n3,n4,n5,n6,n7,n8,n9=[~nval,~nval,~nval,~nval,~nval,~nval,~nval,~nval,~nval];
							dseq = Dseq([[/*1*/	#a,b,c,d,e,f=[ ~a,~b,~c,~d,~e,~f  ],/*2*/	[ a = a/~fth*n1, b = b/~fth*n1, c = c/~fth*n1, d = d/~fth*n1, e = e/~fth*n1, f = f/~fth*n1 ],/*3*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f*~fth  ],/*4*/	[ a = a*~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f/~fth  ],/*5*/	[ a = a/~fth,    b = b*~fth,    c = c,         d = d*~fth,    e = e,         f = f*~fth ],/*6*/	[ a = a*~fth,    b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f/~fth  ],/*7*/	[ a = a/~fth,    b = b/~fth,    c = c/~fth,    d = d,         e = e,         f = f ],/*8*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*9*/	[ a = a*~fth,    b = b,         c = c,         d = d*~fth,    e = e*~fth,    f = f*~fth ],/*10*/	[ a = a,         b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*11*/	[ a = a/~fth,    b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*12*/	[ a = a*~fth*n2, b = b*~fth*n2, c = c*~fth*n2, d = d/~fth*n2, e = e/~fth*n2, f = f/~fth*n2 ],/*13*/	[ a = a,         b = b,         c = c,         d = d*~fth,    e = e,         f = f*~fth ],/*14*/	[ a = a,         b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f],/*15*/	[ a = a/~fth,    b = b,         c = c/~fth,    d = d,         e = e/~fth,    f = f/~fth ],/*16*/	[ a = a,         b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*17*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f*~fth],/*18*/	[ a = a*~fth*n3, b = b/~fth*n3, c = c/~fth*n3, d = d*~fth*n3, e = e*~fth*n3, f = f/~fth*n3 ],/*19*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e,         f = f*~fth ],/*20*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f/~fth ],/*21*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d,         e = e,         f = f*~fth ],/*22*/	[ a = a,         b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*23*/	[ a = a,         b = b,         c = c,         d = d/~fth,    e = e,         f = f/~fth ],/*24*/	[ a = a/~fth,    b = b,         c = c,         d = d,         e = e,         f = f*~fth ],/*25*/	[ a = a*~fth,    b = b*~fth,    c = c*~fth,    d = d,         e = e,         f = f ],/*26*/	[ a = a,         b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*27*/	[ a = a,         b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f ],/*28*/	[ a = a/~fth*n4, b = b*~fth*n4, c = c*~fth*n4, d = d*~fth*n4, e = e*~fth*n4, f = f/~fth*n4 ],/*29*/	[ a = a,         b = b,         c = c/~fth,    d = d/~fth,    e = e,         f = f ],/*30*/	[ a = a*~fth*n5, b = b/~fth*n5, c = c*~fth*n5, d = d*~fth*n5, e = e/~fth*n5, f = f*~fth*n5 ],/*31*/	[ a = a/~fth,    b = b*~fth,    c = c,         d = d,         e = e,         f = f/~fth ],/*32*/	[ a = a,         b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f ],/*33*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*34*/	[ a = a/~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f*~fth ],/*35*/	[ a = a*~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f/~fth ],/*36*/	[ a = a/~fth,    b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f*~fth ],/*37*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e,         f = f ],/*38*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d/~fth,    e = e*~fth,    f = f ],/*39*/	[ a = a/~fth*n6, b = b*~fth*n6, c = c/~fth*n6, d = d*~fth*n6, e = e/~fth*n6, f = f/~fth*n6 ],/*40*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d/~fth,    e = e*~fth,    f = f ],/*41*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d,         e = e,         f = f*~fth ],/*42*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*43*/	[ a = a/~fth,    b = b,         c = c*~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*44*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f/~fth ],/*45*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f ],/*46*/	[ a = a,         b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*47*/	[ a = a,         b = b*~fth,    c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*48*/	[ a = a,         b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*49*/	[ a = a,         b = b,         c = c*~fth,    d = d,         e = e/~fth,    f = f*~fth ],/*50*/	[ a = a*~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f/~fth ],/*51*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f*~fth ],/*52*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f/~fth ],/*53*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f ],/*54*/	[ a = a/~fth*n7, b = b/~fth*n7, c = c*~fth*n7, d = d/~fth*n7, e = e*~fth*n7, f = f*~fth*n7 ],/*55*/	[ a = a,         b = b,         c = c,         d = d*~fth,    e = e/~fth,    f = f ],/*56*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f/~fth ],/*57*/	[ a = a,         b = b*~fth,    c = c/~fth,    d = d,         e = e*~fth,    f = f ],/*58*/	[ a = a/~fth,    b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f*~fth ],/*59*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d,         e = e,         f = f/~fth ],/*60*/	[ a = a/~fth,    b = b,         c = c,         d = d,         e = e,         f = f*~fth ],/*61*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f ],/*62*/	[ a = a/~fth*n8, b = b/~fth*n8, c = c*~fth*n8, d = d*~fth*n8, e = e/~fth*n8, f = f/~fth*n8 ],/*63*/	[ a = a,         b = b*~fth,    c = c/~fth,    d = d,         e = e,         f = f*~fth ],/*64*/	[ a = a*~fth*n9, b = b/~fth*n9, c = c*~fth*n9, d = d/~fth*n9, e = e*~fth*n9, f = f/~fth*n9 ]]
								++Array.fill((~gsinenum -1), {[/*1*/	[ a = a,         b = b*~fth,    c = c,         d = d*~fth,    e = e,         f = f*~fth ],/*2*/	[ a = a/~fth*n1, b = b/~fth*n1, c = c/~fth*n1, d = d/~fth*n1, e = e/~fth*n1, f = f/~fth*n1 ],/*3*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f*~fth  ],/*4*/	[ a = a*~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f/~fth  ],/*5*/	[ a = a/~fth,    b = b*~fth,    c = c,         d = d*~fth,    e = e,         f = f*~fth ],/*6*/	[ a = a*~fth,    b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f/~fth  ],/*7*/	[ a = a/~fth,    b = b/~fth,    c = c/~fth,    d = d,         e = e,         f = f ],/*8*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*9*/	[ a = a*~fth,    b = b,         c = c,         d = d*~fth,    e = e*~fth,    f = f*~fth ],/*10*/	[ a = a,         b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*11*/	[ a = a/~fth,    b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*12*/	[ a = a*~fth*n2, b = b*~fth*n2, c = c*~fth*n2, d = d/~fth*n2, e = e/~fth*n2, f = f/~fth*n2 ],/*13*/	[ a = a,         b = b,         c = c,         d = d*~fth,    e = e,         f = f*~fth ],/*14*/	[ a = a,         b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f],/*15*/	[ a = a/~fth,    b = b,         c = c/~fth,    d = d,         e = e/~fth,    f = f/~fth ],/*16*/	[ a = a,         b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*17*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f*~fth],/*18*/	[ a = a*~fth*n3, b = b/~fth*n3, c = c/~fth*n3, d = d*~fth*n3, e = e*~fth*n3, f = f/~fth*n3 ],/*19*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e,         f = f*~fth ],/*20*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f/~fth ],/*21*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d,         e = e,         f = f*~fth ],/*22*/	[ a = a,         b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*23*/	[ a = a,         b = b,         c = c,         d = d/~fth,    e = e,         f = f/~fth ],/*24*/	[ a = a/~fth,    b = b,         c = c,         d = d,         e = e,         f = f*~fth ],/*25*/	[ a = a*~fth,    b = b*~fth,    c = c*~fth,    d = d,         e = e,         f = f ],/*26*/	[ a = a,         b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*27*/	[ a = a,         b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f ],/*28*/	[ a = a/~fth*n4, b = b*~fth*n4, c = c*~fth*n4, d = d*~fth*n4, e = e*~fth*n4, f = f/~fth*n4 ],/*29*/	[ a = a,         b = b,         c = c/~fth,    d = d/~fth,    e = e,         f = f ],/*30*/	[ a = a*~fth*n5, b = b/~fth*n5, c = c*~fth*n5, d = d*~fth*n5, e = e/~fth*n5, f = f*~fth*n5 ],/*31*/	[ a = a/~fth,    b = b*~fth,    c = c,         d = d,         e = e,         f = f/~fth ],/*32*/	[ a = a,         b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f ],/*33*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*34*/	[ a = a/~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f*~fth ],/*35*/	[ a = a*~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f/~fth ],/*36*/	[ a = a/~fth,    b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f*~fth ],/*37*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e,         f = f ],/*38*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d/~fth,    e = e*~fth,    f = f ],/*39*/	[ a = a/~fth*n6, b = b*~fth*n6, c = c/~fth*n6, d = d*~fth*n6, e = e/~fth*n6, f = f/~fth*n6 ],/*40*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d/~fth,    e = e*~fth,    f = f ],/*41*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d,         e = e,         f = f*~fth ],/*42*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*43*/	[ a = a/~fth,    b = b,         c = c*~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*44*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f/~fth ],/*45*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f ],/*46*/	[ a = a,         b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*47*/	[ a = a,         b = b*~fth,    c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*48*/	[ a = a,         b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*49*/	[ a = a,         b = b,         c = c*~fth,    d = d,         e = e/~fth,    f = f*~fth ],/*50*/	[ a = a*~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f/~fth ],/*51*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f*~fth ],/*52*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f/~fth ],/*53*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f ],/*54*/	[ a = a/~fth*n7, b = b/~fth*n7, c = c*~fth*n7, d = d/~fth*n7, e = e*~fth*n7, f = f*~fth*n7 ],/*55*/	[ a = a,         b = b,         c = c,         d = d*~fth,    e = e/~fth,    f = f ],/*56*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f/~fth ],/*57*/	[ a = a,         b = b*~fth,    c = c/~fth,    d = d,         e = e*~fth,    f = f ],/*58*/	[ a = a/~fth,    b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f*~fth ],/*59*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d,         e = e,         f = f/~fth ],/*60*/	[ a = a/~fth,    b = b,         c = c,         d = d,         e = e,         f = f*~fth ],/*61*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f ],/*62*/	[ a = a/~fth*n8, b = b/~fth*n8, c = c*~fth*n8, d = d*~fth*n8, e = e/~fth*n8, f = f/~fth*n8 ],/*63*/	[ a = a,         b = b*~fth,    c = c/~fth,    d = d,         e = e,         f = f*~fth ],/*64*/	[ a = a*~fth*n9, b = b/~fth*n9, c = c*~fth*n9, d = d/~fth*n9, e = e*~fth*n9, f = f/~fth*n9 ]]
							}).flatten].flatten.reverse, inf);
							//env1 = EnvGen.kr(Env([0, 1, 1, 0], [0, dur, 0]), levelScale: amp, doneAction: 2);
							s1 = GrainSin.ar(1, Impulse.ar(dur+tune), 1/(dur+tune), Demand.ar(Impulse.ar(dur+tune), 0, dseq));
							OffsetOut.ar(0, s1.dup*vol);
						}, [\ir]).add;
					};


			if((~gsinenum == nil) and: (~synthdef != 1), {
		(
			if(~basefreq == nil, {~basefreq = ~base_frequency});
			~fmult = 16;
			(#a,b,c,d,e,f = /*[ 432/1.61803398875, 432*1.61803398875, 432, 432*1.61803398875*1.61803398875 , 528, 432/1.61803398875/1.61803398875  ]*/
				[ ~basefreq,~basefreq,~basefreq,~basefreq,~basefreq,~basefreq  ];
				~a = a; ~b = b; ~c =c; ~d = d; ~e = e;~f=f;);

			~fth = 1.4142135623729;
			~gm = 1.61803398875;
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

					~synthdef = 1; ~gsinenum = 33;
			(
						SynthDef(\gsineicfld, {arg graindur = 0.04, dur = 2000, atk = 0.007, rel = 0.01, gate = 1, amp = 1, i = 1, vol = ~vol, rate = 20, tune = 0,dseqval,
							a, b, c, d, e, f, pan=0, fc = 1;
							var s1, out, env1, s2, dseq,n1,n2,n3,n4,n5,n6,n7,n8,n9;
							#n1,n2,n3,n4,n5,n6,n7,n8,n9=[~nval,~nval,~nval,~nval,~nval,~nval,~nval,~nval,~nval];
							dseq = Dseq([/*1*/	#a,b,c,d,e,f=[ ~a,~b,~c,~d,~e,~f  ],/*2*/	[ a = a/~fth*n1, b = b/~fth*n1, c = c/~fth*n1, d = d/~fth*n1, e = e/~fth*n1, f = f/~fth*n1 ],/*3*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f*~fth  ],/*4*/	[ a = a*~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f/~fth  ],/*5*/	[ a = a/~fth,    b = b*~fth,    c = c,         d = d*~fth,    e = e,         f = f*~fth ],/*6*/	[ a = a*~fth,    b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f/~fth  ],/*7*/	[ a = a/~fth,    b = b/~fth,    c = c/~fth,    d = d,         e = e,         f = f ],/*8*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*9*/	[ a = a*~fth,    b = b,         c = c,         d = d*~fth,    e = e*~fth,    f = f*~fth ],/*10*/	[ a = a,         b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*11*/	[ a = a/~fth,    b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*12*/	[ a = a*~fth*n2, b = b*~fth*n2, c = c*~fth*n2, d = d/~fth*n2, e = e/~fth*n2, f = f/~fth*n2 ],/*13*/	[ a = a,         b = b,         c = c,         d = d*~fth,    e = e,         f = f*~fth ],/*14*/	[ a = a,         b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f],/*15*/	[ a = a/~fth,    b = b,         c = c/~fth,    d = d,         e = e/~fth,    f = f/~fth ],/*16*/	[ a = a,         b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*17*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f*~fth],/*18*/	[ a = a*~fth*n3, b = b/~fth*n3, c = c/~fth*n3, d = d*~fth*n3, e = e*~fth*n3, f = f/~fth*n3 ],/*19*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e,         f = f*~fth ],/*20*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f/~fth ],/*21*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d,         e = e,         f = f*~fth ],/*22*/	[ a = a,         b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*23*/	[ a = a,         b = b,         c = c,         d = d/~fth,    e = e,         f = f/~fth ],/*24*/	[ a = a/~fth,    b = b,         c = c,         d = d,         e = e,         f = f*~fth ],/*25*/	[ a = a*~fth,    b = b*~fth,    c = c*~fth,    d = d,         e = e,         f = f ],/*26*/	[ a = a,         b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*27*/	[ a = a,         b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f ],/*28*/	[ a = a/~fth*n4, b = b*~fth*n4, c = c*~fth*n4, d = d*~fth*n4, e = e*~fth*n4, f = f/~fth*n4 ],/*29*/	[ a = a,         b = b,         c = c/~fth,    d = d/~fth,    e = e,         f = f ],/*30*/	[ a = a*~fth*n5, b = b/~fth*n5, c = c*~fth*n5, d = d*~fth*n5, e = e/~fth*n5, f = f*~fth*n5 ],/*31*/	[ a = a/~fth,    b = b*~fth,    c = c,         d = d,         e = e,         f = f/~fth ],/*32*/	[ a = a,         b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f ],/*33*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*34*/	[ a = a/~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f*~fth ],/*35*/	[ a = a*~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f/~fth ],/*36*/	[ a = a/~fth,    b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f*~fth ],/*37*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e,         f = f ],/*38*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d/~fth,    e = e*~fth,    f = f ],/*39*/	[ a = a/~fth*n6, b = b*~fth*n6, c = c/~fth*n6, d = d*~fth*n6, e = e/~fth*n6, f = f/~fth*n6 ],/*40*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d/~fth,    e = e*~fth,    f = f ],/*41*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d,         e = e,         f = f*~fth ],/*42*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*43*/	[ a = a/~fth,    b = b,         c = c*~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*44*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f/~fth ],/*45*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f ],/*46*/	[ a = a,         b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*47*/	[ a = a,         b = b*~fth,    c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*48*/	[ a = a,         b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*49*/	[ a = a,         b = b,         c = c*~fth,    d = d,         e = e/~fth,    f = f*~fth ],/*50*/	[ a = a*~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f/~fth ],/*51*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f*~fth ],/*52*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f/~fth ],/*53*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f ],/*54*/	[ a = a/~fth*n7, b = b/~fth*n7, c = c*~fth*n7, d = d/~fth*n7, e = e*~fth*n7, f = f*~fth*n7 ],/*55*/	[ a = a,         b = b,         c = c,         d = d*~fth,    e = e/~fth,    f = f ],/*56*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f/~fth ],/*57*/	[ a = a,         b = b*~fth,    c = c/~fth,    d = d,         e = e*~fth,    f = f ],/*58*/	[ a = a/~fth,    b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f*~fth ],/*59*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d,         e = e,         f = f/~fth ],/*60*/	[ a = a/~fth,    b = b,         c = c,         d = d,         e = e,         f = f*~fth ],/*61*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f ],/*62*/	[ a = a/~fth*n8, b = b/~fth*n8, c = c*~fth*n8, d = d*~fth*n8, e = e/~fth*n8, f = f/~fth*n8 ],/*63*/	[ a = a,         b = b*~fth,    c = c/~fth,    d = d,         e = e,         f = f*~fth ],/*64*/	[ a = a*~fth*n9, b = b/~fth*n9, c = c*~fth*n9, d = d/~fth*n9, e = e*~fth*n9, f = f/~fth*n9 ]]
								++Array.fill((~gsinenum -1), {[/*1*/	[ a = a,         b = b*~fth,    c = c,         d = d*~fth,    e = e,         f = f*~fth ],/*2*/	[ a = a/~fth*n1, b = b/~fth*n1, c = c/~fth*n1, d = d/~fth*n1, e = e/~fth*n1, f = f/~fth*n1 ],/*3*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f*~fth  ],/*4*/	[ a = a*~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f/~fth  ],/*5*/	[ a = a/~fth,    b = b*~fth,    c = c,         d = d*~fth,    e = e,         f = f*~fth ],/*6*/	[ a = a*~fth,    b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f/~fth  ],/*7*/	[ a = a/~fth,    b = b/~fth,    c = c/~fth,    d = d,         e = e,         f = f ],/*8*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*9*/	[ a = a*~fth,    b = b,         c = c,         d = d*~fth,    e = e*~fth,    f = f*~fth ],/*10*/	[ a = a,         b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*11*/	[ a = a/~fth,    b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*12*/	[ a = a*~fth*n2, b = b*~fth*n2, c = c*~fth*n2, d = d/~fth*n2, e = e/~fth*n2, f = f/~fth*n2 ],/*13*/	[ a = a,         b = b,         c = c,         d = d*~fth,    e = e,         f = f*~fth ],/*14*/	[ a = a,         b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f],/*15*/	[ a = a/~fth,    b = b,         c = c/~fth,    d = d,         e = e/~fth,    f = f/~fth ],/*16*/	[ a = a,         b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*17*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f*~fth],/*18*/	[ a = a*~fth*n3, b = b/~fth*n3, c = c/~fth*n3, d = d*~fth*n3, e = e*~fth*n3, f = f/~fth*n3 ],/*19*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e,         f = f*~fth ],/*20*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f/~fth ],/*21*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d,         e = e,         f = f*~fth ],/*22*/	[ a = a,         b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*23*/	[ a = a,         b = b,         c = c,         d = d/~fth,    e = e,         f = f/~fth ],/*24*/	[ a = a/~fth,    b = b,         c = c,         d = d,         e = e,         f = f*~fth ],/*25*/	[ a = a*~fth,    b = b*~fth,    c = c*~fth,    d = d,         e = e,         f = f ],/*26*/	[ a = a,         b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*27*/	[ a = a,         b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f ],/*28*/	[ a = a/~fth*n4, b = b*~fth*n4, c = c*~fth*n4, d = d*~fth*n4, e = e*~fth*n4, f = f/~fth*n4 ],/*29*/	[ a = a,         b = b,         c = c/~fth,    d = d/~fth,    e = e,         f = f ],/*30*/	[ a = a*~fth*n5, b = b/~fth*n5, c = c*~fth*n5, d = d*~fth*n5, e = e/~fth*n5, f = f*~fth*n5 ],/*31*/	[ a = a/~fth,    b = b*~fth,    c = c,         d = d,         e = e,         f = f/~fth ],/*32*/	[ a = a,         b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f ],/*33*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*34*/	[ a = a/~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f*~fth ],/*35*/	[ a = a*~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f/~fth ],/*36*/	[ a = a/~fth,    b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f*~fth ],/*37*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e,         f = f ],/*38*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d/~fth,    e = e*~fth,    f = f ],/*39*/	[ a = a/~fth*n6, b = b*~fth*n6, c = c/~fth*n6, d = d*~fth*n6, e = e/~fth*n6, f = f/~fth*n6 ],/*40*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d/~fth,    e = e*~fth,    f = f ],/*41*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d,         e = e,         f = f*~fth ],/*42*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*43*/	[ a = a/~fth,    b = b,         c = c*~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*44*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f/~fth ],/*45*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f ],/*46*/	[ a = a,         b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*47*/	[ a = a,         b = b*~fth,    c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*48*/	[ a = a,         b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*49*/	[ a = a,         b = b,         c = c*~fth,    d = d,         e = e/~fth,    f = f*~fth ],/*50*/	[ a = a*~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f/~fth ],/*51*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f*~fth ],/*52*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f/~fth ],/*53*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f ],/*54*/	[ a = a/~fth*n7, b = b/~fth*n7, c = c*~fth*n7, d = d/~fth*n7, e = e*~fth*n7, f = f*~fth*n7 ],/*55*/	[ a = a,         b = b,         c = c,         d = d*~fth,    e = e/~fth,    f = f ],/*56*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f/~fth ],/*57*/	[ a = a,         b = b*~fth,    c = c/~fth,    d = d,         e = e*~fth,    f = f ],/*58*/	[ a = a/~fth,    b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f*~fth ],/*59*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d,         e = e,         f = f/~fth ],/*60*/	[ a = a/~fth,    b = b,         c = c,         d = d,         e = e,         f = f*~fth ],/*61*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f ],/*62*/	[ a = a/~fth*n8, b = b/~fth*n8, c = c*~fth*n8, d = d*~fth*n8, e = e/~fth*n8, f = f/~fth*n8 ],/*63*/	[ a = a,         b = b*~fth,    c = c/~fth,    d = d,         e = e,         f = f*~fth ],/*64*/	[ a = a*~fth*n9, b = b/~fth*n9, c = c*~fth*n9, d = d/~fth*n9, e = e*~fth*n9, f = f/~fth*n9 ]]
							}).flatten, inf);
							//env1 = EnvGen.kr(Env([0, 1, 1, 0], [0, dur, 0]), levelScale: amp, doneAction: 2);
							s1 = GrainSin.ar(1, Impulse.ar(dur+tune), 1/(dur+tune),Demand.ar(Impulse.ar(dur+tune), 0, dseq)*fc);
							OffsetOut.ar(0, s1.dup*vol);
						}, [\ir]).add;

						SynthDef(\gsineicrld, {arg graindur = 0.04, dur = 2000, atk = 0.007, rel = 0.01, gate = 1, amp = 1, i = 1, vol = ~vol, rate = 20, tune = 0,dseqval,
							a, b, c, d, e, f, pan=0, fc = 1, id = -1;
							var s1, out, env1, s2, dseq,n1,n2,n3,n4,n5,n6,n7,n8,n9,af;
							#n1,n2,n3,n4,n5,n6,n7,n8,n9=[~nval,~nval,~nval,~nval,~nval,~nval,~nval,~nval,~nval];
							dseq = Dseq([[/*1*/	#a,b,c,d,e,f=[ ~a,~b,~c,~d,~e,~f  ],/*2*/	[ a = a/~fth*n1, b = b/~fth*n1, c = c/~fth*n1, d = d/~fth*n1, e = e/~fth*n1, f = f/~fth*n1 ],/*3*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f*~fth  ],/*4*/	[ a = a*~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f/~fth  ],/*5*/	[ a = a/~fth,    b = b*~fth,    c = c,         d = d*~fth,    e = e,         f = f*~fth ],/*6*/	[ a = a*~fth,    b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f/~fth  ],/*7*/	[ a = a/~fth,    b = b/~fth,    c = c/~fth,    d = d,         e = e,         f = f ],/*8*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*9*/	[ a = a*~fth,    b = b,         c = c,         d = d*~fth,    e = e*~fth,    f = f*~fth ],/*10*/	[ a = a,         b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*11*/	[ a = a/~fth,    b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*12*/	[ a = a*~fth*n2, b = b*~fth*n2, c = c*~fth*n2, d = d/~fth*n2, e = e/~fth*n2, f = f/~fth*n2 ],/*13*/	[ a = a,         b = b,         c = c,         d = d*~fth,    e = e,         f = f*~fth ],/*14*/	[ a = a,         b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f],/*15*/	[ a = a/~fth,    b = b,         c = c/~fth,    d = d,         e = e/~fth,    f = f/~fth ],/*16*/	[ a = a,         b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*17*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f*~fth],/*18*/	[ a = a*~fth*n3, b = b/~fth*n3, c = c/~fth*n3, d = d*~fth*n3, e = e*~fth*n3, f = f/~fth*n3 ],/*19*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e,         f = f*~fth ],/*20*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f/~fth ],/*21*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d,         e = e,         f = f*~fth ],/*22*/	[ a = a,         b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*23*/	[ a = a,         b = b,         c = c,         d = d/~fth,    e = e,         f = f/~fth ],/*24*/	[ a = a/~fth,    b = b,         c = c,         d = d,         e = e,         f = f*~fth ],/*25*/	[ a = a*~fth,    b = b*~fth,    c = c*~fth,    d = d,         e = e,         f = f ],/*26*/	[ a = a,         b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*27*/	[ a = a,         b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f ],/*28*/	[ a = a/~fth*n4, b = b*~fth*n4, c = c*~fth*n4, d = d*~fth*n4, e = e*~fth*n4, f = f/~fth*n4 ],/*29*/	[ a = a,         b = b,         c = c/~fth,    d = d/~fth,    e = e,         f = f ],/*30*/	[ a = a*~fth*n5, b = b/~fth*n5, c = c*~fth*n5, d = d*~fth*n5, e = e/~fth*n5, f = f*~fth*n5 ],/*31*/	[ a = a/~fth,    b = b*~fth,    c = c,         d = d,         e = e,         f = f/~fth ],/*32*/	[ a = a,         b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f ],/*33*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*34*/	[ a = a/~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f*~fth ],/*35*/	[ a = a*~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f/~fth ],/*36*/	[ a = a/~fth,    b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f*~fth ],/*37*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e,         f = f ],/*38*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d/~fth,    e = e*~fth,    f = f ],/*39*/	[ a = a/~fth*n6, b = b*~fth*n6, c = c/~fth*n6, d = d*~fth*n6, e = e/~fth*n6, f = f/~fth*n6 ],/*40*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d/~fth,    e = e*~fth,    f = f ],/*41*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d,         e = e,         f = f*~fth ],/*42*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*43*/	[ a = a/~fth,    b = b,         c = c*~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*44*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f/~fth ],/*45*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f ],/*46*/	[ a = a,         b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*47*/	[ a = a,         b = b*~fth,    c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*48*/	[ a = a,         b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*49*/	[ a = a,         b = b,         c = c*~fth,    d = d,         e = e/~fth,    f = f*~fth ],/*50*/	[ a = a*~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f/~fth ],/*51*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f*~fth ],/*52*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f/~fth ],/*53*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f ],/*54*/	[ a = a/~fth*n7, b = b/~fth*n7, c = c*~fth*n7, d = d/~fth*n7, e = e*~fth*n7, f = f*~fth*n7 ],/*55*/	[ a = a,         b = b,         c = c,         d = d*~fth,    e = e/~fth,    f = f ],/*56*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f/~fth ],/*57*/	[ a = a,         b = b*~fth,    c = c/~fth,    d = d,         e = e*~fth,    f = f ],/*58*/	[ a = a/~fth,    b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f*~fth ],/*59*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d,         e = e,         f = f/~fth ],/*60*/	[ a = a/~fth,    b = b,         c = c,         d = d,         e = e,         f = f*~fth ],/*61*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f ],/*62*/	[ a = a/~fth*n8, b = b/~fth*n8, c = c*~fth*n8, d = d*~fth*n8, e = e/~fth*n8, f = f/~fth*n8 ],/*63*/	[ a = a,         b = b*~fth,    c = c/~fth,    d = d,         e = e,         f = f*~fth ],/*64*/	[ a = a*~fth*n9, b = b/~fth*n9, c = c*~fth*n9, d = d/~fth*n9, e = e*~fth*n9, f = f/~fth*n9 ]]
								++Array.fill((~gsinenum -1), {[/*1*/	[ a = a,         b = b*~fth,    c = c,         d = d*~fth,    e = e,         f = f*~fth ],/*2*/	[ a = a/~fth*n1, b = b/~fth*n1, c = c/~fth*n1, d = d/~fth*n1, e = e/~fth*n1, f = f/~fth*n1 ],/*3*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f*~fth  ],/*4*/	[ a = a*~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f/~fth  ],/*5*/	[ a = a/~fth,    b = b*~fth,    c = c,         d = d*~fth,    e = e,         f = f*~fth ],/*6*/	[ a = a*~fth,    b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f/~fth  ],/*7*/	[ a = a/~fth,    b = b/~fth,    c = c/~fth,    d = d,         e = e,         f = f ],/*8*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*9*/	[ a = a*~fth,    b = b,         c = c,         d = d*~fth,    e = e*~fth,    f = f*~fth ],/*10*/	[ a = a,         b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*11*/	[ a = a/~fth,    b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*12*/	[ a = a*~fth*n2, b = b*~fth*n2, c = c*~fth*n2, d = d/~fth*n2, e = e/~fth*n2, f = f/~fth*n2 ],/*13*/	[ a = a,         b = b,         c = c,         d = d*~fth,    e = e,         f = f*~fth ],/*14*/	[ a = a,         b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f],/*15*/	[ a = a/~fth,    b = b,         c = c/~fth,    d = d,         e = e/~fth,    f = f/~fth ],/*16*/	[ a = a,         b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*17*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f*~fth],/*18*/	[ a = a*~fth*n3, b = b/~fth*n3, c = c/~fth*n3, d = d*~fth*n3, e = e*~fth*n3, f = f/~fth*n3 ],/*19*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e,         f = f*~fth ],/*20*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f/~fth ],/*21*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d,         e = e,         f = f*~fth ],/*22*/	[ a = a,         b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*23*/	[ a = a,         b = b,         c = c,         d = d/~fth,    e = e,         f = f/~fth ],/*24*/	[ a = a/~fth,    b = b,         c = c,         d = d,         e = e,         f = f*~fth ],/*25*/	[ a = a*~fth,    b = b*~fth,    c = c*~fth,    d = d,         e = e,         f = f ],/*26*/	[ a = a,         b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*27*/	[ a = a,         b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f ],/*28*/	[ a = a/~fth*n4, b = b*~fth*n4, c = c*~fth*n4, d = d*~fth*n4, e = e*~fth*n4, f = f/~fth*n4 ],/*29*/	[ a = a,         b = b,         c = c/~fth,    d = d/~fth,    e = e,         f = f ],/*30*/	[ a = a*~fth*n5, b = b/~fth*n5, c = c*~fth*n5, d = d*~fth*n5, e = e/~fth*n5, f = f*~fth*n5 ],/*31*/	[ a = a/~fth,    b = b*~fth,    c = c,         d = d,         e = e,         f = f/~fth ],/*32*/	[ a = a,         b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f ],/*33*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*34*/	[ a = a/~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f*~fth ],/*35*/	[ a = a*~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f/~fth ],/*36*/	[ a = a/~fth,    b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f*~fth ],/*37*/	[ a = a*~fth,    b = b*~fth,    c = c,         d = d,         e = e,         f = f ],/*38*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d/~fth,    e = e*~fth,    f = f ],/*39*/	[ a = a/~fth*n6, b = b*~fth*n6, c = c/~fth*n6, d = d*~fth*n6, e = e/~fth*n6, f = f/~fth*n6 ],/*40*/	[ a = a,         b = b/~fth,    c = c*~fth,    d = d/~fth,    e = e*~fth,    f = f ],/*41*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d,         e = e,         f = f*~fth ],/*42*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e/~fth,    f = f ],/*43*/	[ a = a/~fth,    b = b,         c = c*~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*44*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f/~fth ],/*45*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f ],/*46*/	[ a = a,         b = b/~fth,    c = c/~fth,    d = d*~fth,    e = e*~fth,    f = f ],/*47*/	[ a = a,         b = b*~fth,    c = c*~fth,    d = d/~fth,    e = e,         f = f ],/*48*/	[ a = a,         b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f ],/*49*/	[ a = a,         b = b,         c = c*~fth,    d = d,         e = e/~fth,    f = f*~fth ],/*50*/	[ a = a*~fth,    b = b/~fth,    c = c,         d = d,         e = e*~fth,    f = f/~fth ],/*51*/	[ a = a/~fth,    b = b,         c = c,         d = d/~fth,    e = e/~fth,    f = f*~fth ],/*52*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d*~fth,    e = e,         f = f/~fth ],/*53*/	[ a = a,         b = b*~fth,    c = c,         d = d,         e = e,         f = f ],/*54*/	[ a = a/~fth*n7, b = b/~fth*n7, c = c*~fth*n7, d = d/~fth*n7, e = e*~fth*n7, f = f*~fth*n7 ],/*55*/	[ a = a,         b = b,         c = c,         d = d*~fth,    e = e/~fth,    f = f ],/*56*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f/~fth ],/*57*/	[ a = a,         b = b*~fth,    c = c/~fth,    d = d,         e = e*~fth,    f = f ],/*58*/	[ a = a/~fth,    b = b,         c = c*~fth,    d = d/~fth,    e = e,         f = f*~fth ],/*59*/	[ a = a*~fth,    b = b,         c = c/~fth,    d = d,         e = e,         f = f/~fth ],/*60*/	[ a = a/~fth,    b = b,         c = c,         d = d,         e = e,         f = f*~fth ],/*61*/	[ a = a*~fth,    b = b,         c = c,         d = d,         e = e,         f = f ],/*62*/	[ a = a/~fth*n8, b = b/~fth*n8, c = c*~fth*n8, d = d*~fth*n8, e = e/~fth*n8, f = f/~fth*n8 ],/*63*/	[ a = a,         b = b*~fth,    c = c/~fth,    d = d,         e = e,         f = f*~fth ],/*64*/	[ a = a*~fth*n9, b = b/~fth*n9, c = c*~fth*n9, d = d/~fth*n9, e = e*~fth*n9, f = f/~fth*n9 ]]
							}).flatten].flatten.reverse, inf);
							//env1 = EnvGen.kr(Env([0, 1, 1, 0], [0, dur, 0]), levelScale: amp, doneAction: 2);
							s1 = GrainSin.ar(1, Impulse.ar(dur+tune), 1/(dur+tune), Demand.ar(Impulse.ar(dur+tune), 0, dseq));
							OffsetOut.ar(0, s1.dup*vol);
						}, [\ir]).add;
			);
			);
			});



		//gui
		w = Window("ic gui", Rect(0,0,Window.screenBounds.width,Window.screenBounds.height), border:true);



		view = UserView(w, Window.screenBounds);
		view.clearOnRefresh = false;
		view.background = Color.black;
		/*
		~b1 = Window.screenBounds.width/3/*(12*4)*/  /*25.462962962963*/; ~btu = 31; ~btd = 340; ~bw = 0.5; ~bh = 70; ~bcolor = Color.grey;
		CompositeView(w, Rect(~b1, ~btu, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b1, ~btd, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b2=~b1+~b1, ~btu, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b2=~b1+~b1, ~btd, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b3=~b2+~b1, ~btu, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b3=~b2+~b1, ~btd, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b4=~b3+~b1, ~btu, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b4=~b3+~b1, ~btd, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b5=~b4+~b1, ~btu, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b5=~b4+~b1, ~btd, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b6=~b5+~b1, ~btu, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b6=~b5+~b1, ~btd, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b7=~b6+~b1, ~btu, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b7=~b6+~b1, ~btd, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b8=~b7+~b1, ~btu, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b8=~b7+~b1, ~btd, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b9=~b8+~b1, ~btu, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b9=~b8+~b1, ~btd, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b10=~b9+~b1, ~btu, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b10=~b9+~b1, ~btd, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b11=~b10+~b1, ~btu, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b11=~b10+~b1, ~btd, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b12=~b11+~b1, ~btu, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b12=~b11+~b1, ~btd, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b13=~b12+~b1, ~btu, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b13=~b12+~b1, ~btd, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b14=~b13+~b1, ~btu, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b14=~b13+~b1, ~btd, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b15=~b14+~b1, ~btu, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b15=~b14+~b1, ~btd, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b16=~b15+~b1, ~btu, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b16=~b15+~b1, ~btd, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b17=~b16+~b1, ~btu, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b17=~b16+~b1, ~btd, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b18=~b17+~b1, ~btu, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b18=~b17+~b1, ~btd, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b19=~b18+~b1, ~btu, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b19=~b18+~b1, ~btd, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b20=~b19+~b1, ~btu, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b20=~b19+~b1, ~btd, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b21=~b20+~b1, ~btu, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b21=~b20+~b1, ~btd, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b22=~b21+~b1, ~btu, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b22=~b21+~b1, ~btd, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b23=~b22+~b1, ~btu, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b23=~b22+~b1, ~btd, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b24=~b23+~b1, ~btu, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b24=~b23+~b1, ~btd, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b25=~b24+~b1, ~btu, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b25=~b24+~b1, ~btd, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b26=~b25+~b1, ~btu, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b26=~b25+~b1, ~btd, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b27=~b26+~b1, ~btu, ~bw, ~bh)).background =~bcolor;
		CompositeView(w, Rect(~b27=~b26+~b1, ~btd, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b28=~b27+~b1, ~btu, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b28=~b27+~b1, ~btd, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b29=~b28+~b1, ~btu, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b29=~b28+~b1, ~btd, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b30=~b29+~b1, ~btu, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b30=~b29+~b1, ~btd, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b31=~b30+~b1, ~btu, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b31=~b30+~b1, ~btd, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b32=~b31+~b1, ~btu, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b32=~b31+~b1, ~btd, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b33=~b32+~b1, ~btu, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b33=~b32+~b1, ~btd, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b34=~b33+~b1, ~btu, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b34=~b33+~b1, ~btd, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b35=~b34+~b1, ~btu, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b35=~b34+~b1, ~btd, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b36=~b35+~b1, ~btu, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b36=~b35+~b1, ~btd, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b37=~b36+~b1, ~btu, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b37=~b36+~b1, ~btd, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b38=~b37+~b1, ~btu, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b38=~b37+~b1, ~btd, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b39=~b38+~b1, ~btu, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b39=~b38+~b1, ~btd, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b40=~b39+~b1, ~btu, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b40=~b39+~b1, ~btd, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b41=~b40+~b1, ~btu, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b41=~b40+~b1, ~btd, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b42=~b41+~b1, ~btu, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b42=~b41+~b1, ~btd, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b43=~b42+~b1, ~btu, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b43=~b42+~b1, ~btd, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b44=~b43+~b1, ~btu, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b44=~b43+~b1, ~btd, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b45=~b44+~b1, ~btu, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b45=~b44+~b1, ~btd, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b46=~b45+~b1, ~btu, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b46=~b45+~b1, ~btd, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b47=~b46+~b1, ~btu, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b47=~b46+~b1, ~btd, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b48=~b47+~b1, ~btu, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b48=~b47+~b1, ~btd, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b49=~b48+~b1, ~btu, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b49=~b48+~b1, ~btd, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b50=~b49+~b1, ~btu, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b50=~b49+~b1, ~btd, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b51=~b50+~b1, ~btu, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b51=~b50+~b1, ~btd, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b52=~b51+~b1, ~btu, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b52=~b51+~b1, ~btd, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b53=~b52+~b1, ~btu, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b53=~b52+~b1, ~btd, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b54=~b53+~b1, ~btu, ~bw, ~bh)).background = ~bcolor;
		CompositeView(w, Rect(~b54=~b53+~b1, ~btd, ~bw, ~bh)).background = ~bcolor;
		*/


		CompositeView(w, Rect(1, 30, Window.screenBounds.width, 0.5)).background = Color.new255(51, 51, 51);
		CompositeView(w, Rect(1, 40, Window.screenBounds.width, 0.5)).background = Color.new255(51, 51, 51);
		CompositeView(w, Rect(1, 50, Window.screenBounds.width, 0.5)).background = Color.new255(51, 51, 51);
		CompositeView(w, Rect(1, 60, Window.screenBounds.width, 0.5)).background = Color.new255(51, 51, 51);
		/*CompositeView(w, Rect(1, 70, Window.screenBounds.width, 0.5)).background = Color.new255(51, 51, 51);
		CompositeView(w, Rect(1, 80, Window.screenBounds.width, 0.5)).background = Color.new255(51, 51, 51);
		CompositeView(w, Rect(1, 90, Window.screenBounds.width, 0.5)).background = Color.new255(51, 51, 51);
		CompositeView(w, Rect(1, 100, Window.screenBounds.width, 0.5)).background = Color.new255(51, 51, 51);*/
		/*CompositeView(w, Rect(1, 110, Window.screenBounds.width, 0.5)).background = Color.new255(51, 51, 51);
		CompositeView(w, Rect(1, 120, Window.screenBounds.width, 0.5)).background = Color.new255(51, 51, 51);
		CompositeView(w, Rect(1, 130, Window.screenBounds.width, 0.5)).background = Color.new255(51, 51, 51);
		CompositeView(w, Rect(1, 140, Window.screenBounds.width, 0.5)).background = Color.new255(51, 51, 51);
		CompositeView(w, Rect(1, 150, Window.screenBounds.width, 0.5)).background = Color.new255(51, 51, 51);*/
		/*	CompositeView(w, Rect(1, 160, Window.screenBounds.width, 0.5)).background = Color.new255(51, 51, 51);
		CompositeView(w, Rect(1, 170, Window.screenBounds.width, 0.5)).background = Color.new255(51, 51, 51);
		CompositeView(w, Rect(1, 180, Window.screenBounds.width, 0.5)).background = Color.new255(51, 51, 51);
		CompositeView(w, Rect(1, 190, Window.screenBounds.width, 0.5)).background = Color.new255(51, 51, 51);
		CompositeView(w, Rect(1, 200, Window.screenBounds.width, 0.5)).background = Color.new255(51, 51, 51);
		CompositeView(w, Rect(1, 210, Window.screenBounds.width, 0.5)).background = Color.new255(140, 140, 140);
		CompositeView(w, Rect(1, 220, Window.screenBounds.width, 0.5)).background = Color.new255(51, 51, 51);
		CompositeView(w, Rect(1, 230, Window.screenBounds.width, 0.5)).background = Color.new255(51, 51, 51);
		CompositeView(w, Rect(1, 240, Window.screenBounds.width, 0.5)).background = Color.new255(51, 51, 51);
		CompositeView(w, Rect(1, 250, Window.screenBounds.width, 0.5)).background = Color.new255(51, 51, 51);
		CompositeView(w, Rect(1, 260, Window.screenBounds.width, 0.5)).background = Color.new255(51, 51, 51);
		CompositeView(w, Rect(1, 270, Window.screenBounds.width, 0.5)).background = Color.new255(140, 140, 140);*/
		CompositeView(w, Rect(1, 340, Window.screenBounds.width, 0.5)).background = Color.new255(51, 51, 51);
		CompositeView(w, Rect(1, 350, Window.screenBounds.width, 0.5)).background = Color.new255(51, 51, 51);
		CompositeView(w, Rect(1, 360, Window.screenBounds.width, 0.5)).background = Color.new255(51, 51, 51);
		CompositeView(w, Rect(1, 370, Window.screenBounds.width, 0.5)).background = Color.new255(51, 51, 51);
		/*CompositeView(w, Rect(1, 380, Window.screenBounds.width, 0.5)).background = Color.new255(51, 51, 51);
		CompositeView(w, Rect(1, 390, Window.screenBounds.width, 0.5)).background = Color.new255(51, 51, 51);
		CompositeView(w, Rect(1, 400, Window.screenBounds.width, 0.5)).background = Color.new255(51, 51, 51);
		CompositeView(w, Rect(1, 410, Window.screenBounds.width, 0.5)).background = Color.new255(51, 51, 51);*/
		/*CompositeView(w, Rect(1, 420, Window.screenBounds.width, 0.5)).background = Color.new255(51, 51, 51);
		CompositeView(w, Rect(1, 430, Window.screenBounds.width, 0.5)).background = Color.new255(51, 51, 51);
		CompositeView(w, Rect(1, 440, Window.screenBounds.width, 0.5)).background = Color.new255(51, 51, 51);
		CompositeView(w, Rect(1, 450, Window.screenBounds.width, 0.5)).background = Color.new255(51, 51, 51);
		CompositeView(w, Rect(1, 460, Window.screenBounds.width, 0.5)).background = Color.new255(51, 51, 51);*/
		/*CompositeView(w, Rect(1, 470, Window.screenBounds.width, 0.5)).background = Color.new255(51, 51, 51);
		CompositeView(w, Rect(1, 480, Window.screenBounds.width, 0.5)).background = Color.new255(51, 51, 51);
		CompositeView(w, Rect(1, 490, Window.screenBounds.width, 0.5)).background = Color.new255(51, 51, 51);
		CompositeView(w, Rect(1, 500, Window.screenBounds.width, 0.5)).background = Color.new255(51, 51, 51);
		CompositeView(w, Rect(1, 510, Window.screenBounds.width, 0.5)).background = Color.new255(51, 51, 51);
		CompositeView(w, Rect(1, 520, Window.screenBounds.width, 0.5)).background = Color.new255(140, 140, 140);
		CompositeView(w, Rect(1, 530, Window.screenBounds.width, 0.5)).background = Color.new255(51, 51, 51);
		CompositeView(w, Rect(1, 540, Window.screenBounds.width, 0.5)).background = Color.new255(51, 51, 51);
		CompositeView(w, Rect(1, 550, Window.screenBounds.width, 0.5)).background = Color.new255(51, 51, 51);
		CompositeView(w, Rect(1, 560, Window.screenBounds.width, 0.5)).background = Color.new255(51, 51, 51);
		CompositeView(w, Rect(1, 570, Window.screenBounds.width, 0.5)).background = Color.new255(51, 51, 51);
		CompositeView(w, Rect(1, 580, Window.screenBounds.width, 0.5)).background = Color.new255(140, 140, 140);*/

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
				/*~l4a1.set(\dur, f4, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol4, \tune, tune);           ~l4b1.set(\dur, f4, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol4, \tune, tune);
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
			*/	/*~l8a1.set(\dur, f8, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol8, \tune, tune);           ~l8b1.set(\dur, f8, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol8, \tune, tune);
				~l8c1.set(\dur, f8/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol8, \tune, tune);  ~l8d1.set(\dur, f8/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol8, \tune, tune);
				~l8e1.set(\dur, f8/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol8, \tune, tune);  ~l8f1.set(\dur, f8/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol8, \tune, tune);
				~l9a1.set(\dur, f9, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol9,  \tune, tune);          ~l9b1.set(\dur, f9, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol9, \tune, tune);
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
					#s1,s2 = [\gsineicfld, \gsineicrld];
					~l1a = Synth(s1, [\dur, ~f1, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol1, \tune, tune],~icl6).register;    ~l1b = Synth(s2, [\dur, ~f1, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol1, \tune, tune],~icl6);
					~l1c = Synth(s1, [\dur, ~f1/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol1, \tune, tune], ~icl6);   ~l1d = Synth(s2, [\dur, ~f1/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol1, \tune, tune],~icl6);
					~l1e = Synth(s1, [\dur, ~f1/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol1, \tune, tune], ~icl6);   ~l1f = Synth(s2, [\dur, ~f1/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol1, \tune, tune],~icl6);
					~l2a = Synth(s1, [\dur, ~f2, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol2, \tune, tune],~icl6);    ~l2b = Synth(s2, [\dur, ~f2, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol2, \tune, tune],~icl6);
					~l2c = Synth(s1, [\dur, ~f2/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol2, \tune, tune], ~icl6);   ~l2d = Synth(s2, [\dur, ~f2/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol2, \tune, tune],~icl6);
					~l2e = Synth(s1, [\dur, ~f2/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol2, \tune, tune], ~icl6);   ~l2f = Synth(s2, [\dur, ~f2/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol2, \tune, tune],~icl6);
					~l3a = Synth(s1, [\dur, ~f3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol3, \tune, tune],~icl6);    ~l3b = Synth(s2, [\dur, ~f3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,  \vol, vol3, \tune, tune],~icl6);
					~l3c = Synth(s1, [\dur, ~f3/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol3, \tune, tune], ~icl6);   ~l3d = Synth(s2, [\dur, ~f3/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,\vol, vol3, \tune, tune],~icl6);
					~l3e = Synth(s1, [\dur, ~f3/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol3, \tune, tune], ~icl6);   ~l3f = Synth(s2, [\dur, ~f3/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,\vol, vol3, \tune, tune],~icl6);
					/*~l4a = Synth(s1, [\dur, ~f4, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol4, \tune, tune],~icl61);   ~l4b = Synth(s2, [\dur, ~f4, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,  \vol, vol4, \tune, tune],~icl61);
					~l4c = Synth(s1, [\dur, ~f4/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol4, \tune, tune], ~icl61);  ~l4d = Synth(s2, [\dur, ~f4/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,\vol, vol4, \tune, tune],~icl61);
					~l4e = Synth(s1, [\dur, ~f4/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol4, \tune, tune],~icl61);   ~l4f = Synth(s2, [\dur, ~f4/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,\vol, vol4, \tune, tune],~icl61);
					~l5a = Synth(s1, [\dur, ~f5, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol5, \tune, tune],~icl61);   ~l5b = Synth(s2, [\dur, ~f5, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,  \vol, vol5, \tune, tune],~icl61);
					~l5c = Synth(s1, [\dur, ~f5/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol5, \tune, tune],~icl61);   ~l5d = Synth(s2, [\dur, ~f5/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,\vol, vol5, \tune, tune],~icl61);
					~l5e = Synth(s1, [\dur, ~f5/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol5, \tune, tune],~icl61);   ~l5f = Synth(s2, [\dur, ~f5/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,\vol, vol5, \tune, tune],~icl61);
					~l6a = Synth(s1, [\dur, ~f6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol6, \tune, tune],~icl61);   ~l6b = Synth(s2, [\dur, ~f6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,  \vol, vol6, \tune, tune],~icl61);
					~l6c = Synth(s1, [\dur, ~f6/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol6, \tune, tune],~icl61);   ~l6d = Synth(s2, [\dur, ~f6/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,\vol, vol6, \tune, tune],~icl61);
					~l6e = Synth(s1, [\dur, ~f6/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol6, \tune, tune],~icl61);   ~l6f = Synth(s2, [\dur, ~f6/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,\vol, vol6, \tune, tune],~icl61);
					~l7a = Synth(s1, [\dur, ~f7, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol7, \tune, tune],~icl62);   ~l7b = Synth(s2, [\dur, ~f7, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,  \vol, vol7, \tune, tune],~icl62);
					~l7c = Synth(s1, [\dur, ~f7/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol7, \tune, tune],~icl62);   ~l7d = Synth(s2, [\dur, ~f7/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,\vol, vol7, \tune, tune],~icl62);
					~l7e = Synth(s1, [\dur, ~f7/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol7, \tune, tune],~icl62);   ~l7f = Synth(s2, [\dur, ~f7/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,\vol, vol7, \tune, tune],~icl62);
			*/		/*~l8a = Synth(s1, [\dur, ~f8=f8, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol8, \tune, tune],~icl62);  ~l8b = Synth(s2, [\dur, ~f8, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,  \vol, vol8, \tune, tune],~icl62);
					~l8c = Synth(s1, [\dur, ~f8/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol8, \tune, tune],~icl62);   ~l8d = Synth(s2, [\dur, ~f8/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,\vol, vol8, \tune, tune],~icl62);
					~l8e = Synth(s1, [\dur, ~f8/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol8, \tune, tune],~icl62);   ~l8f = Synth(s2, [\dur, ~f8/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,\vol, vol8, \tune, tune],~icl62);
					~l9a = Synth(s1, [\dur, ~f9=f9, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol9, \tune, tune],~icl62);  ~l9b = Synth(s2, [\dur, ~f9, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,  \vol, vol9, \tune, tune],~icl62);
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
						([~l1a1,~l1b1,~l1c1,~l1d1,~l1e1,~l1f1,~l2a1,~l2b1,~l2c1,~l2d1,~l2e1,~l2f1,~l3a1,~l3b1,~l3c1,~l3d1,~l3e1,~l3f1/*,~l4a1,~l4b1,~l4c1,~l4d1,~l4e1,~l4f1,~l5a1,~l5b1,~l5c1,~l5d1,~l5e1,~l5f1,~l6a1,~l6b1,~l6c1,~l6d1,~l6e1,~l6f1,~l7a1,~l7b1,~l7c1,~l7d1,~l7e1,~l7f1*//*1,~l8a1,~l8b1,~l8c1,~l8d1,~l8e1,~l8f1,~l9a1,~l9b1,~l9c1,~l9d1,~l9e1,~l9f1,~l10a1,~l10b1,~l10c1,~l10d1,~l10e1,~l10f1,~l11a1,~l11b1,~l11c1,~l11d1,~l11e1,~l11f1,~l12a1,~l12b1,~l12c1,~l12d1,~l12e1,~l12f*/ ].do(_.free)); ~slideroutine.stop;
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
				/*~l4a.set(\dur, f4, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol4, \tune, tune);           ~l4b.set(\dur, f4, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol4, \tune, tune);
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
			*/	/*~l8a.set(\dur, f8, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol8, \tune, tune);           ~l8b.set(\dur, f8, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol8, \tune, tune);
				~l8c.set(\dur, f8/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol8, \tune, tune);  ~l8d.set(\dur, f8/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol8, \tune, tune);
				~l8e.set(\dur, f8/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol8, \tune, tune);  ~l8f.set(\dur, f8/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol8, \tune, tune);
				~l9a.set(\dur, f9, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol9,  \tune, tune);          ~l9b.set(\dur, f9, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol9, \tune, tune);
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
					#s1,s2 = [\gsineicfld, \gsineicrld];
					~l1a1 = Synth(s1, [\dur, ~f1, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol1, \tune, tune],~icl6).register;    ~l1b1 = Synth(s2, [\dur, ~f1, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol1, \tune, tune],~icl6);
					~l1c1 = Synth(s1, [\dur, ~f1/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol1, \tune, tune], ~icl6);   ~l1d1 = Synth(s2, [\dur, ~f1/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol1, \tune, tune],~icl6);
					~l1e1 = Synth(s1, [\dur, ~f1/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol1, \tune, tune], ~icl6);   ~l1f1 = Synth(s2, [\dur, ~f1/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol1, \tune, tune],~icl6);
					~l2a1 = Synth(s1, [\dur, ~f2, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol2, \tune, tune],~icl6);    ~l2b1 = Synth(s2, [\dur, ~f2, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol2, \tune, tune],~icl6);
					~l2c1 = Synth(s1, [\dur, ~f2/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol2, \tune, tune], ~icl6);   ~l2d1 = Synth(s2, [\dur, ~f2/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol2, \tune, tune],~icl6);
					~l2e1 = Synth(s1, [\dur, ~f2/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol2, \tune, tune], ~icl6);   ~l2f1 = Synth(s2, [\dur, ~f2/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol2, \tune, tune],~icl6);
					~l3a1 = Synth(s1, [\dur, ~f3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol3, \tune, tune],~icl6);    ~l3b1 = Synth(s2, [\dur, ~f3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,  \vol, vol3, \tune, tune],~icl6);
					~l3c1 = Synth(s1, [\dur, ~f3/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol3, \tune, tune], ~icl6);   ~l3d1 = Synth(s2, [\dur, ~f3/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,\vol, vol3, \tune, tune],~icl6);
					~l3e1 = Synth(s1, [\dur, ~f3/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol3, \tune, tune], ~icl6);   ~l3f1 = Synth(s2, [\dur, ~f3/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,\vol, vol3, \tune, tune],~icl6);
					/*~l4a1 = Synth(s1, [\dur, ~f4, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol4, \tune, tune],~icl61);   ~l4b1 = Synth(s2, [\dur, ~f4, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,  \vol, vol4, \tune, tune],~icl61);
					~l4c1 = Synth(s1, [\dur, ~f4/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol4, \tune, tune], ~icl61);  ~l4d1 = Synth(s2, [\dur, ~f4/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,\vol, vol4, \tune, tune],~icl61);
					~l4e1 = Synth(s1, [\dur, ~f4/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol4, \tune, tune],~icl61);   ~l4f1 = Synth(s2, [\dur, ~f4/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,\vol, vol4, \tune, tune],~icl61);
					~l5a1 = Synth(s1, [\dur, ~f5, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol5, \tune, tune],~icl61);   ~l5b1 = Synth(s2, [\dur, ~f5, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,  \vol, vol5, \tune, tune],~icl61);
					~l5c1 = Synth(s1, [\dur, ~f5/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol5, \tune, tune],~icl61);   ~l5d1 = Synth(s2, [\dur, ~f5/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,\vol, vol5, \tune, tune],~icl61);
					~l5e1 = Synth(s1, [\dur, ~f5/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol5, \tune, tune],~icl61);   ~l5f1 = Synth(s2, [\dur, ~f5/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,\vol, vol5, \tune, tune],~icl61);
					~l6a1 = Synth(s1, [\dur, ~f6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol6, \tune, tune],~icl61);   ~l6b1 = Synth(s2, [\dur, ~f6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,  \vol, vol6, \tune, tune],~icl61);
					~l6c1 = Synth(s1, [\dur, ~f6/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol6, \tune, tune],~icl61);   ~l6d1 = Synth(s2, [\dur, ~f6/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,\vol, vol6, \tune, tune],~icl61);
					~l6e1 = Synth(s1, [\dur, ~f6/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol6, \tune, tune],~icl61);   ~l6f1 = Synth(s2, [\dur, ~f6/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,\vol, vol6, \tune, tune],~icl61);
					~l7a1 = Synth(s1, [\dur, ~f7, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol7, \tune, tune],~icl62);   ~l7b1 = Synth(s2, [\dur, ~f7, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,  \vol, vol7, \tune, tune],~icl62);
					~l7c1 = Synth(s1, [\dur, ~f7/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol7, \tune, tune],~icl62);   ~l7d1 = Synth(s2, [\dur, ~f7/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,\vol, vol7, \tune, tune],~icl62);
					~l7e1 = Synth(s1, [\dur, ~f7/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol7, \tune, tune],~icl62);   ~l7f1 = Synth(s2, [\dur, ~f7/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,\vol, vol7, \tune, tune],~icl62);
				*/	/*~l8a1 = Synth(s1, [\dur, ~f8=f8, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol8, \tune, tune],~icl62);  ~l8b1 = Synth(s2, [\dur, ~f8, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,  \vol, vol8, \tune, tune],~icl62);
					~l8c1 = Synth(s1, [\dur, ~f8/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol8, \tune, tune],~icl62);   ~l8d1 = Synth(s2, [\dur, ~f8/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,\vol, vol8, \tune, tune],~icl62);
					~l8e1 = Synth(s1, [\dur, ~f8/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol8, \tune, tune],~icl62);   ~l8f1 = Synth(s2, [\dur, ~f8/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,\vol, vol8, \tune, tune],~icl62);
					~l9a1 = Synth(s1, [\dur, ~f9=f9, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol9, \tune, tune],~icl62);  ~l9b1 = Synth(s2, [\dur, ~f9, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,  \vol, vol9, \tune, tune],~icl62);
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
					([~l1a,~l1b,~l1c,~l1d,~l1e,~l1f,~l2a,~l2b,~l2c,~l2d,~l2e,~l2f,~l3a,~l3b,~l3c,~l3d,~l3e,~l3f/*,~l4a,~l4b,~l4c,~l4d,~l4e,~l4f,~l5a,~l5b,~l5c,~l5d,~l5e,~l5f,~l6a,~l6b,~l6c,~l6d,~l6e,~l6f,~l7a,~l7b,~l7c,~l7d,~l7e,~l7f*//*,~l8a,~l8b,~l8c,~l8d,~l8e,~l8f,~l9a,~l9b,~l9c,~l9d,~l9e,~l9f,~l10a,~l10b,~l10c,~l10d,~l10e,~l10f,~l11a,~l11b,~l11c,~l11d,~l11e,~l11f,~l12a,~l12b,~l12c,~l12d,~l12e,~l12f*/].do(_.free)); ~slideroutine.stop;
					});
						};

					if((~f1 > ~outmaxa) or: (~f1 < ~outmina), {~z25.close;~z1.close;~z25 = (CompositeView(w, Rect((~f1.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+10, ~nw, 2)).background = Color.white;);}, {~z1.close;~z25.close;~z1 = (CompositeView(w, Rect((~f1.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2, ~nw, 2)).background = Color.white;);});
					if((~f2 > ~outmaxa) or: (~f2 < ~outmina), {~z26.close;~z2.close;~z26 = (CompositeView(w, Rect((~f2.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+20, ~nw, 2)).background = Color.white;);}, {~z2.close;~z26.close;~z2 = (CompositeView(w, Rect((~f2.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+10, ~nw, 2)).background = Color.white;);});
					if((~f3 > ~outmaxa) or: (~f3 < ~outmina), {~z27.close;~z3.close;~z27 = (CompositeView(w, Rect((~f3.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+30, ~nw, 2)).background = Color.white;);}, {~z3.close;~z27.close;~z3 = (CompositeView(w, Rect((~f3.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+20, ~nw, 2)).background = Color.white;);});
					/*if((~f4 > ~outmaxa) or: (~f4 < ~outmina), {~z28.close;~z4.close;~z28 = (CompositeView(w, Rect((~f4.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+40, ~nw, 2)).background = Color.white;);}, {~z4.close;~z28.close;~z4 = (CompositeView(w, Rect((~f4.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+30, ~nw, 2)).background = Color.white;);});
					if((~f5 > ~outmaxa) or: (~f5 < ~outmina), {~z29.close;~z5.close;~z29 = (CompositeView(w, Rect((~f5.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+50, ~nw, 2)).background = Color.white;);}, {~z5.close;~z29.close;~z5 = (CompositeView(w, Rect((~f5.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+40, ~nw, 2)).background = Color.white;);});
					if((~f6 > ~outmaxa) or: (~f6 < ~outmina), {~z30.close;~z6.close;~z30 = (CompositeView(w, Rect((~f6.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+60, ~nw, 2)).background = Color.white;);}, {~z6.close;~z30.close;~z6 = (CompositeView(w, Rect((~f6.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+50, ~nw, 2)).background = Color.white;);});
					if((~f7 > ~outmaxa) or: (~f7 < ~outmina), {~z31.close;~z7.close;~z31 = (CompositeView(w, Rect((~f7.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+70, ~nw, 2)).background = Color.white;);}, {~z7.close;~z31.close;~z7 = (CompositeView(w, Rect((~f7.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+60, ~nw, 2)).background = Color.white;);});
				*/	/*if((f8 > ~outmaxa) or: (f8 < ~outmina), {~z32.close;~z8.close;~z32 = (CompositeView(w, Rect((f8.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+80, ~nw, 2)).background = Color.white;);}, {~z8.close;~z32.close;~z8 = (CompositeView(w, Rect((f8.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+70, ~nw, 2)).background = Color.white;);});
					if((f9 > ~outmaxa) or: (f9 < ~outmina), {~z33.close;~z9.close;~z33 = (CompositeView(w, Rect((f9.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+90, ~nw, 2)).background = Color.white;);}, {~z9.close;~z33.close;~z9 = (CompositeView(w, Rect((f9.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+80, ~nw, 2)).background = Color.white;);});
					if((f10 > ~outmaxa) or: (f10 < ~outmina), {~z34.close;~z10.close;~z34 = (CompositeView(w, Rect((f10.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+100, ~nw, 2)).background = Color.white;);}, {~z10.close;~z34.close;~z10 = (CompositeView(w, Rect((f10.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+90, ~nw, 2)).background = Color.white;);});
					if((f11 > ~outmaxa) or: (f11 < ~outmina), {~z35.close;~z11.close;~z35 = (CompositeView(w, Rect((f11.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+110, ~nw, 2)).background = Color.white;);}, {~z11.close;~z35.close;~z11 = (CompositeView(w, Rect((f11.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+100, ~nw, 2)).background = Color.white;);});
					if((f12 > ~outmaxa) or: (f12 < ~outmina), {~z36.close;~z12.close;~z36 = (CompositeView(w, Rect((f12.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+120, ~nw, 2)).background = Color.white;);}, {~z12.close;~z36.close;~z12 = (CompositeView(w, Rect((f12.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+110, ~nw, 2)).background = Color.white;);});
					*//*if((f13 > ~outmaxa) or: (f13 < ~outmina), {~z37.close;~z13.close;~z37 = (CompositeView(w, Rect((f13.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+130, ~nw, 2)).background = Color.white;);}, {~z13.close;~z37.close;~z13 = (CompositeView(w, Rect((f13.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+120, ~nw, 2)).background = Color.white;);});
					if((f14 > ~outmaxa) or: (f14 < ~outmina), {~z38.close;~z14.close;~z38 = (CompositeView(w, Rect((f14.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+140, ~nw, 2)).background = Color.white;);}, {~z14.close;~z38.close;~z14 = (CompositeView(w, Rect((f14.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+130, ~nw, 2)).background = Color.white;);});
					if((f15 > ~outmaxa) or: (f15 < ~outmina), {~z39.close;~z15.close;~z39 = (CompositeView(w, Rect((f15.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+150, ~nw, 2)).background = Color.white;);}, {~z15.close;~z39.close;~z15 = (CompositeView(w, Rect((f15.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+140, ~nw, 2)).background = Color.white;);});
					if((f16 > ~outmaxa) or: (f16 < ~outmina), {~z40.close;~z16.close;~z40 = (CompositeView(w, Rect((f16.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+160, ~nw, 2)).background = Color.white;);}, {~z16.close;~z40.close;~z16 = (CompositeView(w, Rect((f16.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+150, ~nw, 2)).background = Color.white;);});
					if((f17 > ~outmaxa) or: (f17 < ~outmina), {~z41.close;~z17.close;~z41 = (CompositeView(w, Rect((f17.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+170, ~nw, 2)).background = Color.white;);}, {~z17.close;~z41.close;~z17 = (CompositeView(w, Rect((f17.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+160, ~nw, 2)).background = Color.white;);});
					if((f18 > ~outmaxa) or: (f18 < ~outmina), {~z42.close;~z18.close;~z42 = (CompositeView(w, Rect((f18.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+180, ~nw, 2)).background = Color.white;);}, {~z18.close;~z42.close;~z18 = (CompositeView(w, Rect((f18.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+170, ~nw, 2)).background = Color.white;);});
					if((f19 > ~outmaxa) or: (f19 < ~outmina), {~z43.close;~z19.close;~z43 = (CompositeView(w, Rect((f19.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+190, ~nw, 2)).background = Color.white;);}, {~z19.close;~z43.close;~z19 = (CompositeView(w, Rect((f19.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+180, ~nw, 2)).background = Color.white;);});
				*/	/*if((f20 > ~outmaxa) or: (f20 < ~outmina), {~z44.close;~z20.close;~z44 = (CompositeView(w, Rect((f20.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+200, ~nw, 2)).background = Color.white;);}, {~z20.close;~z44.close;~z20 = (CompositeView(w, Rect((f20.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+190, ~nw, 2)).background = Color.white;);});
					if((f21 > ~outmaxa) or: (f21 < ~outmina), {~z45.close;~z21.close;~z45 = (CompositeView(w, Rect((f21.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+210, ~nw, 2)).background = Color.white;);}, {~z21.close;~z45.close;~z21 = (CompositeView(w, Rect((f21.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+200, ~nw, 2)).background = Color.white;);});
					if((f22 > ~outmaxa) or: (f22 < ~outmina), {~z46.close;~z22.close;~z46 = (CompositeView(w, Rect((f22.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+220, ~nw, 2)).background = Color.white;);}, {~z22.close;~z46.close;~z22 = (CompositeView(w, Rect((f22.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+210, ~nw, 2)).background = Color.white;);});
					if((f23 > ~outmaxa) or: (f23 < ~outmina), {~z47.close;~z23.close;~z47 = (CompositeView(w, Rect((f23.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+230, ~nw, 2)).background = Color.white;);}, {~z23.close;~z47.close;~z23 = (CompositeView(w, Rect((f23.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+220, ~nw, 2)).background = Color.white;);});
					if((f24 > ~outmaxa) or: (f24 < ~outmina), {~z48.close;~z24.close;~z48 = (CompositeView(w, Rect((f24.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+240, ~nw, 2)).background = Color.white;);}, {~z24.close;~z48.close;~z24 = (CompositeView(w, Rect((f24.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+230, ~nw, 2)).background = Color.white;);});
					*/
					b3.value = 1;
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
				/*~l4a1.set(\dur, ~f4, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol4, \tune, tune);           ~l4b1.set(\dur, ~f4, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol4, \tune, tune);
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
		*/		/*~l8a1.set(\dur, ~f8, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol8, \tune, tune);           ~l8b1.set(\dur, ~f8, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol8, \tune, tune);
				~l8c1.set(\dur, ~f8/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol8, \tune, tune);  ~l8d1.set(\dur, ~f8/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol8, \tune, tune);
				~l8e1.set(\dur, ~f8/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol8, \tune, tune);  ~l8f1.set(\dur, ~f8/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol8, \tune, tune);
				~l9a1.set(\dur, ~f9, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol9,  \tune, tune);          ~l9b1.set(\dur, ~f9, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol9, \tune, tune);
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
				/*~l4a.set(\dur, ~f4, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol4, \tune, tune);           ~l4b.set(\dur, ~f4, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol4, \tune, tune);
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
		*/		/*~l8a.set(\dur, ~f8, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol8, \tune, tune);           ~l8b.set(\dur, ~f8, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol8, \tune, tune);
				~l8c.set(\dur, ~f8/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol8, \tune, tune);  ~l8d.set(\dur, ~f8/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol8, \tune, tune);
				~l8e.set(\dur, ~f8/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol8, \tune, tune);  ~l8f.set(\dur, ~f8/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol8, \tune, tune);
				~l9a.set(\dur, ~f9, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol9,  \tune, tune);          ~l9b.set(\dur, ~f9, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol9, \tune, tune);
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

					if((~f1 > ~outmaxa) or: (~f1 < ~outmina), {~z25.close;~z1.close;~z25 = (CompositeView(w, Rect((~f1.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+10, ~nw, 2)).background = Color.white;);}, {~z1.close;~z25.close;~z1 = (CompositeView(w, Rect((~f1.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2, ~nw, 2)).background = Color.white;);});
					if((~f2 > ~outmaxa) or: (~f2 < ~outmina), {~z26.close;~z2.close;~z26 = (CompositeView(w, Rect((~f2.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+20, ~nw, 2)).background = Color.white;);}, {~z2.close;~z26.close;~z2 = (CompositeView(w, Rect((~f2.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+10, ~nw, 2)).background = Color.white;);});
					if((~f3 > ~outmaxa) or: (~f3 < ~outmina), {~z27.close;~z3.close;~z27 = (CompositeView(w, Rect((~f3.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+30, ~nw, 2)).background = Color.white;);}, {~z3.close;~z27.close;~z3 = (CompositeView(w, Rect((~f3.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+20, ~nw, 2)).background = Color.white;);});
					/*if((~f4 > ~outmaxa) or: (~f4 < ~outmina), {~z28.close;~z4.close;~z28 = (CompositeView(w, Rect((~f4.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+40, ~nw, 2)).background = Color.white;);}, {~z4.close;~z28.close;~z4 = (CompositeView(w, Rect((~f4.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+30, ~nw, 2)).background = Color.white;);});
					if((~f5 > ~outmaxa) or: (~f5 < ~outmina), {~z29.close;~z5.close;~z29 = (CompositeView(w, Rect((~f5.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+50, ~nw, 2)).background = Color.white;);}, {~z5.close;~z29.close;~z5 = (CompositeView(w, Rect((~f5.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+40, ~nw, 2)).background = Color.white;);});
					if((~f6 > ~outmaxa) or: (~f6 < ~outmina), {~z30.close;~z6.close;~z30 = (CompositeView(w, Rect((~f6.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+60, ~nw, 2)).background = Color.white;);}, {~z6.close;~z30.close;~z6 = (CompositeView(w, Rect((~f6.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+50, ~nw, 2)).background = Color.white;);});
					if((~f7 > ~outmaxa) or: (~f7 < ~outmina), {~z31.close;~z7.close;~z31 = (CompositeView(w, Rect((~f7.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+70, ~nw, 2)).background = Color.white;);}, {~z7.close;~z31.close;~z7 = (CompositeView(w, Rect((~f7.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+60, ~nw, 2)).background = Color.white;);});
				*/	/*if((f8 > ~outmaxa) or: (f8 < ~outmina), {~z32.close;~z8.close;~z32 = (CompositeView(w, Rect((f8.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+80, ~nw, 2)).background = Color.white;);}, {~z8.close;~z32.close;~z8 = (CompositeView(w, Rect((f8.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+70, ~nw, 2)).background = Color.white;);});
					if((f9 > ~outmaxa) or: (f9 < ~outmina), {~z33.close;~z9.close;~z33 = (CompositeView(w, Rect((f9.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+90, ~nw, 2)).background = Color.white;);}, {~z9.close;~z33.close;~z9 = (CompositeView(w, Rect((f9.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+80, ~nw, 2)).background = Color.white;);});
					if((f10 > ~outmaxa) or: (f10 < ~outmina), {~z34.close;~z10.close;~z34 = (CompositeView(w, Rect((f10.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+100, ~nw, 2)).background = Color.white;);}, {~z10.close;~z34.close;~z10 = (CompositeView(w, Rect((f10.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+90, ~nw, 2)).background = Color.white;);});
					if((f11 > ~outmaxa) or: (f11 < ~outmina), {~z35.close;~z11.close;~z35 = (CompositeView(w, Rect((f11.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+110, ~nw, 2)).background = Color.white;);}, {~z11.close;~z35.close;~z11 = (CompositeView(w, Rect((f11.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+100, ~nw, 2)).background = Color.white;);});
					if((f12 > ~outmaxa) or: (f12 < ~outmina), {~z36.close;~z12.close;~z36 = (CompositeView(w, Rect((f12.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+120, ~nw, 2)).background = Color.white;);}, {~z12.close;~z36.close;~z12 = (CompositeView(w, Rect((f12.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+110, ~nw, 2)).background = Color.white;);});
					*//*if((f13 > ~outmaxa) or: (f13 < ~outmina), {~z37.close;~z13.close;~z37 = (CompositeView(w, Rect((f13.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+130, ~nw, 2)).background = Color.white;);}, {~z13.close;~z37.close;~z13 = (CompositeView(w, Rect((f13.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+120, ~nw, 2)).background = Color.white;);});
					if((f14 > ~outmaxa) or: (f14 < ~outmina), {~z38.close;~z14.close;~z38 = (CompositeView(w, Rect((f14.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+140, ~nw, 2)).background = Color.white;);}, {~z14.close;~z38.close;~z14 = (CompositeView(w, Rect((f14.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+130, ~nw, 2)).background = Color.white;);});
					if((f15 > ~outmaxa) or: (f15 < ~outmina), {~z39.close;~z15.close;~z39 = (CompositeView(w, Rect((f15.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+150, ~nw, 2)).background = Color.white;);}, {~z15.close;~z39.close;~z15 = (CompositeView(w, Rect((f15.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+140, ~nw, 2)).background = Color.white;);});
					if((f16 > ~outmaxa) or: (f16 < ~outmina), {~z40.close;~z16.close;~z40 = (CompositeView(w, Rect((f16.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+160, ~nw, 2)).background = Color.white;);}, {~z16.close;~z40.close;~z16 = (CompositeView(w, Rect((f16.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+150, ~nw, 2)).background = Color.white;);});
					if((f17 > ~outmaxa) or: (f17 < ~outmina), {~z41.close;~z17.close;~z41 = (CompositeView(w, Rect((f17.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+170, ~nw, 2)).background = Color.white;);}, {~z17.close;~z41.close;~z17 = (CompositeView(w, Rect((f17.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+160, ~nw, 2)).background = Color.white;);});
					if((f18 > ~outmaxa) or: (f18 < ~outmina), {~z42.close;~z18.close;~z42 = (CompositeView(w, Rect((f18.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+180, ~nw, 2)).background = Color.white;);}, {~z18.close;~z42.close;~z18 = (CompositeView(w, Rect((f18.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+170, ~nw, 2)).background = Color.white;);});
					if((f19 > ~outmaxa) or: (f19 < ~outmina), {~z43.close;~z19.close;~z43 = (CompositeView(w, Rect((f19.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+190, ~nw, 2)).background = Color.white;);}, {~z19.close;~z43.close;~z19 = (CompositeView(w, Rect((f19.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+180, ~nw, 2)).background = Color.white;);});
				*/	/*if((f20 > ~outmaxa) or: (f20 < ~outmina), {~z44.close;~z20.close;~z44 = (CompositeView(w, Rect((f20.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+200, ~nw, 2)).background = Color.white;);}, {~z20.close;~z44.close;~z20 = (CompositeView(w, Rect((f20.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+190, ~nw, 2)).background = Color.white;);});
					if((f21 > ~outmaxa) or: (f21 < ~outmina), {~z45.close;~z21.close;~z45 = (CompositeView(w, Rect((f21.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+210, ~nw, 2)).background = Color.white;);}, {~z21.close;~z45.close;~z21 = (CompositeView(w, Rect((f21.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+200, ~nw, 2)).background = Color.white;);});
					if((f22 > ~outmaxa) or: (f22 < ~outmina), {~z46.close;~z22.close;~z46 = (CompositeView(w, Rect((f22.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+220, ~nw, 2)).background = Color.white;);}, {~z22.close;~z46.close;~z22 = (CompositeView(w, Rect((f22.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+210, ~nw, 2)).background = Color.white;);});
					if((f23 > ~outmaxa) or: (f23 < ~outmina), {~z47.close;~z23.close;~z47 = (CompositeView(w, Rect((f23.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+230, ~nw, 2)).background = Color.white;);}, {~z23.close;~z47.close;~z23 = (CompositeView(w, Rect((f23.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+220, ~nw, 2)).background = Color.white;);});
					if((f24 > ~outmaxa) or: (f24 < ~outmina), {~z48.close;~z24.close;~z48 = (CompositeView(w, Rect((f24.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+240, ~nw, 2)).background = Color.white;);}, {~z24.close;~z48.close;~z24 = (CompositeView(w, Rect((f24.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+230, ~nw, 2)).background = Color.white;);});
					*/
			};

~synthslide = {
	case
	{~l1a1.isRunning == true}{(//fprog
		~slideroutine = Routine({1.do({var a,b,c,d,e,f,fs,rs,vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8,vol9,vol10,vol11,vol12,s1,s2,s3,s4,s5,s6,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,f19,f20,f21,f22,f23,f24,fs1,fs2,fs3,fs4,fs5,fs6,fd1,fd2,fd3,fd4,fd5,fd6,tune=0;
			#vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8,vol9,vol10,vol11,vol12 = [~vol1,~vol2,~vol3,~vol4,~vol5,~vol6,~vol7,~vol8,~vol9,~vol10,~vol11,~vol12];
			~slidedo.do({~slidecount=~slidecount-1;
				(
											[ ~f1=~f1+g,~f2=~f2+h,~f3=~f3+i,~f4=~f4+j,~f5=~f5+k,~f6=~f6+l,~f7=~f7+m ];
				~l1a1.set(\dur, ~f1, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,    \vol, vol1, \tune, tune);  ~l1b1.set(\dur, ~f1, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol1, \tune, tune);
				~l1c1.set(\dur, ~f1/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol1, \tune, tune);  ~l1d1.set(\dur, ~f1/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol1, \tune, tune);
				~l1e1.set(\dur, ~f1/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol1, \tune, tune);  ~l1f1.set(\dur, ~f1/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol1, \tune, tune);
				~l2a1.set(\dur, ~f2, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,    \vol, vol2, \tune, tune);          ~l2b1.set(\dur, ~f2, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol2, \tune, tune);
				~l2c1.set(\dur, ~f2/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol2, \tune, tune);  ~l2d1.set(\dur, ~f2/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol2, \tune, tune);
				~l2e1.set(\dur, ~f2/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol2, \tune, tune);  ~l2f1.set(\dur, ~f2/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol2, \tune, tune);
				~l3a1.set(\dur, ~f3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,    \vol, vol3, \tune, tune);          ~l3b1.set(\dur, ~f3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol3, \tune, tune);
				~l3c1.set(\dur, ~f3/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol3, \tune, tune);  ~l3d1.set(\dur, ~f3/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol3, \tune, tune);
				~l3e1.set(\dur, ~f3/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol3, \tune, tune);  ~l3f1.set(\dur, ~f3/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol3, \tune, tune);
				/*~l4a1.set(\dur, ~f4, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol4, \tune, tune);           ~l4b1.set(\dur, ~f4, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol4, \tune, tune);
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
			*/	/*~l8a1.set(\dur, ~f8, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol8, \tune, tune);           ~l8b1.set(\dur, ~f8, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol8, \tune, tune);
				~l8c1.set(\dur, ~f8/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol8, \tune, tune);  ~l8d1.set(\dur, ~f8/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol8, \tune, tune);
				~l8e1.set(\dur, ~f8/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol8, \tune, tune);  ~l8f1.set(\dur, ~f8/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol8, \tune, tune);
				~l9a1.set(\dur, ~f9, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol9,  \tune, tune);          ~l9b1.set(\dur, ~f9, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol9, \tune, tune);
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
			*/
						);

						{if(~slidecount==0,{if((~f1 > ~outmaxa) or: (~f1 < ~outmina), {~z25.close;~z1.close;~z25 = (CompositeView(w, Rect((~f1.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+10, ~nw, 2)).background = Color.white;);}, {~z1.close;~z25.close;~z1 = (CompositeView(w, Rect((~f1.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2, ~nw, 2)).background = Color.white;);});
					if((~f2 > ~outmaxa) or: (~f2 < ~outmina), {~z26.close;~z2.close;~z26 = (CompositeView(w, Rect((~f2.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+20, ~nw, 2)).background = Color.white;);}, {~z2.close;~z26.close;~z2 = (CompositeView(w, Rect((~f2.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+10, ~nw, 2)).background = Color.white;);});
					if((~f3 > ~outmaxa) or: (~f3 < ~outmina), {~z27.close;~z3.close;~z27 = (CompositeView(w, Rect((~f3.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+30, ~nw, 2)).background = Color.white;);}, {~z3.close;~z27.close;~z3 = (CompositeView(w, Rect((~f3.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+20, ~nw, 2)).background = Color.white;);});
					/*if((~f4 > ~outmaxa) or: (~f4 < ~outmina), {~z28.close;~z4.close;~z28 = (CompositeView(w, Rect((~f4.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+40, ~nw, 2)).background = Color.white;);}, {~z4.close;~z28.close;~z4 = (CompositeView(w, Rect((~f4.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+30, ~nw, 2)).background = Color.white;);});
					if((~f5 > ~outmaxa) or: (~f5 < ~outmina), {~z29.close;~z5.close;~z29 = (CompositeView(w, Rect((~f5.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+50, ~nw, 2)).background = Color.white;);}, {~z5.close;~z29.close;~z5 = (CompositeView(w, Rect((~f5.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+40, ~nw, 2)).background = Color.white;);});
					if((~f6 > ~outmaxa) or: (~f6 < ~outmina), {~z30.close;~z6.close;~z30 = (CompositeView(w, Rect((~f6.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+60, ~nw, 2)).background = Color.white;);}, {~z6.close;~z30.close;~z6 = (CompositeView(w, Rect((~f6.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+50, ~nw, 2)).background = Color.white;);});
					if((~f7 > ~outmaxa) or: (~f7 < ~outmina), {~z31.close;~z7.close;~z31 = (CompositeView(w, Rect((~f7.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+70, ~nw, 2)).background = Color.white;);}, {~z7.close;~z31.close;~z7 = (CompositeView(w, Rect((~f7.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+60, ~nw, 2)).background = Color.white;);});
				*/	/*if((f8 > ~outmaxa) or: (f8 < ~outmina), {~z32.close;~z8.close;~z32 = (CompositeView(w, Rect((f8.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+80, ~nw, 2)).background = Color.white;);}, {~z8.close;~z32.close;~z8 = (CompositeView(w, Rect((f8.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+70, ~nw, 2)).background = Color.white;);});
					if((f9 > ~outmaxa) or: (f9 < ~outmina), {~z33.close;~z9.close;~z33 = (CompositeView(w, Rect((f9.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+90, ~nw, 2)).background = Color.white;);}, {~z9.close;~z33.close;~z9 = (CompositeView(w, Rect((f9.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+80, ~nw, 2)).background = Color.white;);});
					if((f10 > ~outmaxa) or: (f10 < ~outmina), {~z34.close;~z10.close;~z34 = (CompositeView(w, Rect((f10.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+100, ~nw, 2)).background = Color.white;);}, {~z10.close;~z34.close;~z10 = (CompositeView(w, Rect((f10.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+90, ~nw, 2)).background = Color.white;);});
					if((f11 > ~outmaxa) or: (f11 < ~outmina), {~z35.close;~z11.close;~z35 = (CompositeView(w, Rect((f11.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+110, ~nw, 2)).background = Color.white;);}, {~z11.close;~z35.close;~z11 = (CompositeView(w, Rect((f11.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+100, ~nw, 2)).background = Color.white;);});
					if((f12 > ~outmaxa) or: (f12 < ~outmina), {~z36.close;~z12.close;~z36 = (CompositeView(w, Rect((f12.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+120, ~nw, 2)).background = Color.white;);}, {~z12.close;~z36.close;~z12 = (CompositeView(w, Rect((f12.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+110, ~nw, 2)).background = Color.white;);});
					*//*if((f13 > ~outmaxa) or: (f13 < ~outmina), {~z37.close;~z13.close;~z37 = (CompositeView(w, Rect((f13.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+130, ~nw, 2)).background = Color.white;);}, {~z13.close;~z37.close;~z13 = (CompositeView(w, Rect((f13.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+120, ~nw, 2)).background = Color.white;);});
					if((f14 > ~outmaxa) or: (f14 < ~outmina), {~z38.close;~z14.close;~z38 = (CompositeView(w, Rect((f14.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+140, ~nw, 2)).background = Color.white;);}, {~z14.close;~z38.close;~z14 = (CompositeView(w, Rect((f14.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+130, ~nw, 2)).background = Color.white;);});
					if((f15 > ~outmaxa) or: (f15 < ~outmina), {~z39.close;~z15.close;~z39 = (CompositeView(w, Rect((f15.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+150, ~nw, 2)).background = Color.white;);}, {~z15.close;~z39.close;~z15 = (CompositeView(w, Rect((f15.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+140, ~nw, 2)).background = Color.white;);});
					if((f16 > ~outmaxa) or: (f16 < ~outmina), {~z40.close;~z16.close;~z40 = (CompositeView(w, Rect((f16.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+160, ~nw, 2)).background = Color.white;);}, {~z16.close;~z40.close;~z16 = (CompositeView(w, Rect((f16.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+150, ~nw, 2)).background = Color.white;);});
					if((f17 > ~outmaxa) or: (f17 < ~outmina), {~z41.close;~z17.close;~z41 = (CompositeView(w, Rect((f17.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+170, ~nw, 2)).background = Color.white;);}, {~z17.close;~z41.close;~z17 = (CompositeView(w, Rect((f17.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+160, ~nw, 2)).background = Color.white;);});
					if((f18 > ~outmaxa) or: (f18 < ~outmina), {~z42.close;~z18.close;~z42 = (CompositeView(w, Rect((f18.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+180, ~nw, 2)).background = Color.white;);}, {~z18.close;~z42.close;~z18 = (CompositeView(w, Rect((f18.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+170, ~nw, 2)).background = Color.white;);});
					if((f19 > ~outmaxa) or: (f19 < ~outmina), {~z43.close;~z19.close;~z43 = (CompositeView(w, Rect((f19.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+190, ~nw, 2)).background = Color.white;);}, {~z19.close;~z43.close;~z19 = (CompositeView(w, Rect((f19.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+180, ~nw, 2)).background = Color.white;);});
				*/	/*if((f20 > ~outmaxa) or: (f20 < ~outmina), {~z44.close;~z20.close;~z44 = (CompositeView(w, Rect((f20.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+200, ~nw, 2)).background = Color.white;);}, {~z20.close;~z44.close;~z20 = (CompositeView(w, Rect((f20.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+190, ~nw, 2)).background = Color.white;);});
					if((f21 > ~outmaxa) or: (f21 < ~outmina), {~z45.close;~z21.close;~z45 = (CompositeView(w, Rect((f21.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+210, ~nw, 2)).background = Color.white;);}, {~z21.close;~z45.close;~z21 = (CompositeView(w, Rect((f21.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+200, ~nw, 2)).background = Color.white;);});
					if((f22 > ~outmaxa) or: (f22 < ~outmina), {~z46.close;~z22.close;~z46 = (CompositeView(w, Rect((f22.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+220, ~nw, 2)).background = Color.white;);}, {~z22.close;~z46.close;~z22 = (CompositeView(w, Rect((f22.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+210, ~nw, 2)).background = Color.white;);});
					if((f23 > ~outmaxa) or: (f23 < ~outmina), {~z47.close;~z23.close;~z47 = (CompositeView(w, Rect((f23.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+230, ~nw, 2)).background = Color.white;);}, {~z23.close;~z47.close;~z23 = (CompositeView(w, Rect((f23.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+220, ~nw, 2)).background = Color.white;);});
					if((f24 > ~outmaxa) or: (f24 < ~outmina), {~z48.close;~z24.close;~z48 = (CompositeView(w, Rect((f24.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+240, ~nw, 2)).background = Color.white;);}, {~z24.close;~z48.close;~z24 = (CompositeView(w, Rect((f24.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+230, ~nw, 2)).background = Color.white;);});
											*/});}.defer;

				(~slidetime/~slidedo).wait;});});}).play;);}
	{~l1a.isRunning == true} {(//fprog
		~slideroutine = Routine({1.do({var a,b,c,d,e,f,fs,rs,vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8,vol9,vol10,vol11,vol12,s1,s2,s3,s4,s5,s6,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,f19,f20,f21,f22,f23,f24,fs1,fs2,fs3,fs4,fs5,fs6,fd1,fd2,fd3,fd4,fd5,fd6,tune=0;
			#vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8,vol9,vol10,vol11,vol12 = [~vol1,~vol2,~vol3,~vol4,~vol5,~vol6,~vol7,~vol8,~vol9,~vol10,~vol11,~vol12];
						~slidedo.do({~slidecount=~slidecount-1;
				(
											[ ~f1=~f1+g,~f2=~f2+h,~f3=~f3+i,~f4=~f4+j,~f5=~f5+k,~f6=~f6+l,~f7=~f7+m ];
				~l1a.set(\dur, ~f1, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,    \vol, vol1, \tune, tune);  ~l1b.set(\dur, ~f1, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol1, \tune, tune);
				~l1c.set(\dur, ~f1/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol1, \tune, tune);  ~l1d.set(\dur, ~f1/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol1, \tune, tune);
				~l1e.set(\dur, ~f1/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol1, \tune, tune);  ~l1f.set(\dur, ~f1/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol1, \tune, tune);
				~l2a.set(\dur, ~f2, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,    \vol, vol2, \tune, tune);          ~l2b.set(\dur, ~f2, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol2, \tune, tune);
				~l2c.set(\dur, ~f2/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol2, \tune, tune);  ~l2d.set(\dur, ~f2/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol2, \tune, tune);
				~l2e.set(\dur, ~f2/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol2, \tune, tune);  ~l2f.set(\dur, ~f2/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol2, \tune, tune);
				~l3a.set(\dur, ~f3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,    \vol, vol3, \tune, tune);          ~l3b.set(\dur, ~f3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol3, \tune, tune);
				~l3c.set(\dur, ~f3/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol3, \tune, tune);  ~l3d.set(\dur, ~f3/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol3, \tune, tune);
				~l3e.set(\dur, ~f3/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol3, \tune, tune);  ~l3f.set(\dur, ~f3/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol3, \tune, tune);
				/*~l4a.set(\dur, ~f4, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol4, \tune, tune);           ~l4b.set(\dur, ~f4, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol4, \tune, tune);
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
			*/	/*~l8a.set(\dur, ~f8, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol8, \tune, tune);           ~l8b.set(\dur, ~f8, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol8, \tune, tune);
				~l8c.set(\dur, ~f8/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol8, \tune, tune);  ~l8d.set(\dur, ~f8/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol8, \tune, tune);
				~l8e.set(\dur, ~f8/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol8, \tune, tune);  ~l8f.set(\dur, ~f8/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol8, \tune, tune);
				~l9a.set(\dur, ~f9, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol9,  \tune, tune);          ~l9b.set(\dur, ~f9, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol9, \tune, tune);
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

						);

							{if(~slidecount==0,{if((~f1 > ~outmaxa) or: (~f1 < ~outmina), {~z25.close;~z1.close;~z25 = (CompositeView(w, Rect((~f1.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+10, ~nw, 2)).background = Color.white;);}, {~z1.close;~z25.close;~z1 = (CompositeView(w, Rect((~f1.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2, ~nw, 2)).background = Color.white;);});
					if((~f2 > ~outmaxa) or: (~f2 < ~outmina), {~z26.close;~z2.close;~z26 = (CompositeView(w, Rect((~f2.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+20, ~nw, 2)).background = Color.white;);}, {~z2.close;~z26.close;~z2 = (CompositeView(w, Rect((~f2.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+10, ~nw, 2)).background = Color.white;);});
					if((~f3 > ~outmaxa) or: (~f3 < ~outmina), {~z27.close;~z3.close;~z27 = (CompositeView(w, Rect((~f3.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+30, ~nw, 2)).background = Color.white;);}, {~z3.close;~z27.close;~z3 = (CompositeView(w, Rect((~f3.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+20, ~nw, 2)).background = Color.white;);});
					/*if((~f4 > ~outmaxa) or: (~f4 < ~outmina), {~z28.close;~z4.close;~z28 = (CompositeView(w, Rect((~f4.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+40, ~nw, 2)).background = Color.white;);}, {~z4.close;~z28.close;~z4 = (CompositeView(w, Rect((~f4.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+30, ~nw, 2)).background = Color.white;);});
					if((~f5 > ~outmaxa) or: (~f5 < ~outmina), {~z29.close;~z5.close;~z29 = (CompositeView(w, Rect((~f5.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+50, ~nw, 2)).background = Color.white;);}, {~z5.close;~z29.close;~z5 = (CompositeView(w, Rect((~f5.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+40, ~nw, 2)).background = Color.white;);});
					if((~f6 > ~outmaxa) or: (~f6 < ~outmina), {~z30.close;~z6.close;~z30 = (CompositeView(w, Rect((~f6.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+60, ~nw, 2)).background = Color.white;);}, {~z6.close;~z30.close;~z6 = (CompositeView(w, Rect((~f6.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+50, ~nw, 2)).background = Color.white;);});
					if((~f7 > ~outmaxa) or: (~f7 < ~outmina), {~z31.close;~z7.close;~z31 = (CompositeView(w, Rect((~f7.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+70, ~nw, 2)).background = Color.white;);}, {~z7.close;~z31.close;~z7 = (CompositeView(w, Rect((~f7.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+60, ~nw, 2)).background = Color.white;);});
				*/	/*if((f8 > ~outmaxa) or: (f8 < ~outmina), {~z32.close;~z8.close;~z32 = (CompositeView(w, Rect((f8.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+80, ~nw, 2)).background = Color.white;);}, {~z8.close;~z32.close;~z8 = (CompositeView(w, Rect((f8.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+70, ~nw, 2)).background = Color.white;);});
					if((f9 > ~outmaxa) or: (f9 < ~outmina), {~z33.close;~z9.close;~z33 = (CompositeView(w, Rect((f9.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+90, ~nw, 2)).background = Color.white;);}, {~z9.close;~z33.close;~z9 = (CompositeView(w, Rect((f9.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+80, ~nw, 2)).background = Color.white;);});
					if((f10 > ~outmaxa) or: (f10 < ~outmina), {~z34.close;~z10.close;~z34 = (CompositeView(w, Rect((f10.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+100, ~nw, 2)).background = Color.white;);}, {~z10.close;~z34.close;~z10 = (CompositeView(w, Rect((f10.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+90, ~nw, 2)).background = Color.white;);});
					if((f11 > ~outmaxa) or: (f11 < ~outmina), {~z35.close;~z11.close;~z35 = (CompositeView(w, Rect((f11.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+110, ~nw, 2)).background = Color.white;);}, {~z11.close;~z35.close;~z11 = (CompositeView(w, Rect((f11.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+100, ~nw, 2)).background = Color.white;);});
					if((f12 > ~outmaxa) or: (f12 < ~outmina), {~z36.close;~z12.close;~z36 = (CompositeView(w, Rect((f12.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+120, ~nw, 2)).background = Color.white;);}, {~z12.close;~z36.close;~z12 = (CompositeView(w, Rect((f12.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+110, ~nw, 2)).background = Color.white;);});
					*//*if((f13 > ~outmaxa) or: (f13 < ~outmina), {~z37.close;~z13.close;~z37 = (CompositeView(w, Rect((f13.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+130, ~nw, 2)).background = Color.white;);}, {~z13.close;~z37.close;~z13 = (CompositeView(w, Rect((f13.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+120, ~nw, 2)).background = Color.white;);});
					if((f14 > ~outmaxa) or: (f14 < ~outmina), {~z38.close;~z14.close;~z38 = (CompositeView(w, Rect((f14.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+140, ~nw, 2)).background = Color.white;);}, {~z14.close;~z38.close;~z14 = (CompositeView(w, Rect((f14.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+130, ~nw, 2)).background = Color.white;);});
					if((f15 > ~outmaxa) or: (f15 < ~outmina), {~z39.close;~z15.close;~z39 = (CompositeView(w, Rect((f15.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+150, ~nw, 2)).background = Color.white;);}, {~z15.close;~z39.close;~z15 = (CompositeView(w, Rect((f15.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+140, ~nw, 2)).background = Color.white;);});
					if((f16 > ~outmaxa) or: (f16 < ~outmina), {~z40.close;~z16.close;~z40 = (CompositeView(w, Rect((f16.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+160, ~nw, 2)).background = Color.white;);}, {~z16.close;~z40.close;~z16 = (CompositeView(w, Rect((f16.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+150, ~nw, 2)).background = Color.white;);});
					if((f17 > ~outmaxa) or: (f17 < ~outmina), {~z41.close;~z17.close;~z41 = (CompositeView(w, Rect((f17.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+170, ~nw, 2)).background = Color.white;);}, {~z17.close;~z41.close;~z17 = (CompositeView(w, Rect((f17.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+160, ~nw, 2)).background = Color.white;);});
					if((f18 > ~outmaxa) or: (f18 < ~outmina), {~z42.close;~z18.close;~z42 = (CompositeView(w, Rect((f18.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+180, ~nw, 2)).background = Color.white;);}, {~z18.close;~z42.close;~z18 = (CompositeView(w, Rect((f18.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+170, ~nw, 2)).background = Color.white;);});
					if((f19 > ~outmaxa) or: (f19 < ~outmina), {~z43.close;~z19.close;~z43 = (CompositeView(w, Rect((f19.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+190, ~nw, 2)).background = Color.white;);}, {~z19.close;~z43.close;~z19 = (CompositeView(w, Rect((f19.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+180, ~nw, 2)).background = Color.white;);});
				*/	/*if((f20 > ~outmaxa) or: (f20 < ~outmina), {~z44.close;~z20.close;~z44 = (CompositeView(w, Rect((f20.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+200, ~nw, 2)).background = Color.white;);}, {~z20.close;~z44.close;~z20 = (CompositeView(w, Rect((f20.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+190, ~nw, 2)).background = Color.white;);});
					if((f21 > ~outmaxa) or: (f21 < ~outmina), {~z45.close;~z21.close;~z45 = (CompositeView(w, Rect((f21.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+210, ~nw, 2)).background = Color.white;);}, {~z21.close;~z45.close;~z21 = (CompositeView(w, Rect((f21.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+200, ~nw, 2)).background = Color.white;);});
					if((f22 > ~outmaxa) or: (f22 < ~outmina), {~z46.close;~z22.close;~z46 = (CompositeView(w, Rect((f22.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+220, ~nw, 2)).background = Color.white;);}, {~z22.close;~z46.close;~z22 = (CompositeView(w, Rect((f22.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+210, ~nw, 2)).background = Color.white;);});
					if((f23 > ~outmaxa) or: (f23 < ~outmina), {~z47.close;~z23.close;~z47 = (CompositeView(w, Rect((f23.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+230, ~nw, 2)).background = Color.white;);}, {~z23.close;~z47.close;~z23 = (CompositeView(w, Rect((f23.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+220, ~nw, 2)).background = Color.white;);});
					if((f24 > ~outmaxa) or: (f24 < ~outmina), {~z48.close;~z24.close;~z48 = (CompositeView(w, Rect((f24.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+240, ~nw, 2)).background = Color.white;);}, {~z24.close;~z48.close;~z24 = (CompositeView(w, Rect((f24.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+230, ~nw, 2)).background = Color.white;);});
											*/});}.defer;

				(~slidetime/~slidedo).wait;});});}).play;);};
};

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
				/*~l4a1.set(\dur, f4, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol4, \tune, tune);           ~l4b1.set(\dur, f4, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol4, \tune, tune);
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
			*/	/*~l8a1.set(\dur, f8, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol8, \tune, tune);           ~l8b1.set(\dur, f8, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol8, \tune, tune);
				~l8c1.set(\dur, f8/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol8, \tune, tune);  ~l8d1.set(\dur, f8/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol8, \tune, tune);
				~l8e1.set(\dur, f8/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol8, \tune, tune);  ~l8f1.set(\dur, f8/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol8, \tune, tune);
				~l9a1.set(\dur, f9, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol9,  \tune, tune);          ~l9b1.set(\dur, f9, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol9, \tune, tune);
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
				/*~l4a.set(\dur, f4, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol4, \tune, tune);           ~l4b.set(\dur, f4, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol4, \tune, tune);
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
			*/	/*~l8a.set(\dur, f8, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol8, \tune, tune);           ~l8b.set(\dur, f8, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol8, \tune, tune);
				~l8c.set(\dur, f8/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol8, \tune, tune);  ~l8d.set(\dur, f8/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol8, \tune, tune);
				~l8e.set(\dur, f8/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol8, \tune, tune);  ~l8f.set(\dur, f8/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol8, \tune, tune);
				~l9a.set(\dur, f9, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol9,  \tune, tune);          ~l9b.set(\dur, f9, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol9, \tune, tune);
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
				/*~l4a1.set(\dur, f4, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol4, \tune, tune);           ~l4b1.set(\dur, f4, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol4, \tune, tune);
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
		*/		/*~l8a1.set(\dur, f8, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol8, \tune, tune);           ~l8b1.set(\dur, f8, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol8, \tune, tune);
				~l8c1.set(\dur, f8/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol8, \tune, tune);  ~l8d1.set(\dur, f8/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol8, \tune, tune);
				~l8e1.set(\dur, f8/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol8, \tune, tune);  ~l8f1.set(\dur, f8/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol8, \tune, tune);
				~l9a1.set(\dur, f9, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol9,  \tune, tune);          ~l9b1.set(\dur, f9, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol9, \tune, tune);
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
						([~l1a1,~l1b1,~l1c1,~l1d1,~l1e1,~l1f1,~l2a1,~l2b1,~l2c1,~l2d1,~l2e1,~l2f1,~l3a1,~l3b1,~l3c1,~l3d1,~l3e1,~l3f1/*,~l4a1,~l4b1,~l4c1,~l4d1,~l4e1,~l4f1,~l5a1,~l5b1,~l5c1,~l5d1,~l5e1,~l5f1,~l6a1,~l6b1,~l6c1,~l6d1,~l6e1,~l6f1,~l7a1,~l7b1,~l7c1,~l7d1,~l7e1,~l7f1*//*1,~l8a1,~l8b1,~l8c1,~l8d1,~l8e1,~l8f1,~l9a1,~l9b1,~l9c1,~l9d1,~l9e1,~l9f1,~l10a1,~l10b1,~l10c1,~l10d1,~l10e1,~l10f1,~l11a1,~l11b1,~l11c1,~l11d1,~l11e1,~l11f1,~l12a1,~l12b1,~l12c1,~l12d1,~l12e1,~l12f*/ ].do(_.free)); ~slideroutine.stop;
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
				/*~l4a.set(\dur, f4, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol4, \tune, tune);           ~l4b.set(\dur, f4, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol4, \tune, tune);
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
			*/	/*~l8a.set(\dur, f8, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol8, \tune, tune);           ~l8b.set(\dur, f8, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol8, \tune, tune);
				~l8c.set(\dur, f8/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol8, \tune, tune);  ~l8d.set(\dur, f8/~icd3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol8, \tune, tune);
				~l8e.set(\dur, f8/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol8, \tune, tune);  ~l8f.set(\dur, f8/~icd6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol8, \tune, tune);
				~l9a.set(\dur, f9, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol9,  \tune, tune);          ~l9b.set(\dur, f9, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol9, \tune, tune);
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
					([~l1a,~l1b,~l1c,~l1d,~l1e,~l1f,~l2a,~l2b,~l2c,~l2d,~l2e,~l2f,~l3a,~l3b,~l3c,~l3d,~l3e,~l3f/*,~l4a,~l4b,~l4c,~l4d,~l4e,~l4f,~l5a,~l5b,~l5c,~l5d,~l5e,~l5f,~l6a,~l6b,~l6c,~l6d,~l6e,~l6f,~l7a,~l7b,~l7c,~l7d,~l7e,~l7f*//*,~l8a,~l8b,~l8c,~l8d,~l8e,~l8f,~l9a,~l9b,~l9c,~l9d,~l9e,~l9f,~l10a,~l10b,~l10c,~l10d,~l10e,~l10f,~l11a,~l11b,~l11c,~l11d,~l11e,~l11f,~l12a,~l12b,~l12c,~l12d,~l12e,~l12f*/].do(_.free)); ~slideroutine.stop;
					});
						};
				);
			};

~timevals = {(~tst = TextView(w, Rect(~tspl,~tspt, ~tspw, ~tsph)).background_(Color.black);
				(~tst.string =
					"o1:_"++~time1o.value.asString++"_f1:_"++~time1f.value.asString++"_s1:_"++~time1s.value.asString++"\n" ++
					"o2:_"++~time2o.value.asString++"_f2:_"++~time2f.value.asString++"_s2:_"++~time2s.value.asString++"\n" ++
					"o3:_"++~time3o.value.asString++"_f3:_"++~time3f.value.asString++"_s3:_"++~time3s.value.asString++"\n" ++
					"o4:_"++~time4o.value.asString++"_f4:_"++~time4f.value.asString++"_s4:_"++~time4s.value.asString++"\n" ++
					"o5:_"++~time5o.value.asString++"_f5:_"++~time5f.value.asString++"_s5:_"++~time5s.value.asString++"\n" ++
					"o6:_"++~time6o.value.asString++"_f6:_"++~time6f.value.asString++"_s6:_"++~time6s.value.asString++"\n" ++
					"o7:_"++~time7o.value.asString++"_f7:_"++~time7f.value.asString++"_s7:_"++~time7s.value.asString++"\n" ++
					"o8:_"++~time8o.value.asString++"_f8:_"++~time8f.value.asString++"_s8:_"++~time8s.value.asString;
				);
				~tst.stringColor = Color.white;
			)};

~numsynthsfunc = {
				if((~numsynths != nil) or: (~numsynths.isPlaying == true), {~numsynths.stop;});
				~numsynths = Routine({inf.do({if((s.numSynths > 18) and: (3.wait; s.numSynths > 18), {

						AppClock.sched(0, {
						if(~numsynthmessage != nil, {~numsynthmessage.close;});
							~numsynthmessage = View(w, Rect(Window.screenBounds.width-(340+46),Window.screenBounds.height-(340+46/1.61803398875)-110,340+46,340+46/1.61803398875)).background_(Color.black).front;
						~numsynthmessagestring = StaticText(~numsynthmessage, Rect(0,0,340+46,340+46/1.61803398875)).background_(Color.black);
						~numsynthmessagestring.align = \topLeft;
						~numsynthmessagestring.string ="Warning:"++"\n"++"\n"++"More than the normal amount of synths are currently running. It is recommended to free the server by pressing "+"ctrl/cmd - period".quote+" and then pressing the "+"ok".quote+" button. Otherwise, you can press the "+"cancel".quote+" button to allow the synths to keep running. If you press the "+"cancel".quote+" button this message will not show again unless you reinitiate the program.";
						~numsynthmessagestring.stringColor = Color.white;
						~numsynthmessagebutton1 = Button.new(~numsynthmessage,Rect(320+46-100,340/1.61803398875-30,46,46/1.61803398875)).states_([["ok",Color.white,Color.black]]).action_({AppClock.sched(0, {~numsynthmessage.close; ~numsynths.play;});});
						~numsynthmessagebutton2 = Button.new(~numsynthmessage,Rect(120-46,340/1.61803398875-30,46,46/1.61803398875)).states_([["cancel",Color.white,Color.black]]).action_({AppClock.sched(0, {~numsynths.stop; ~numsynthmessage.close;});});
						~numsynthmessage.front;
						});
				}); 1.wait;});}).play;
			};

			~numsynthsfunc.value;

		view.mouseDownAction = {
			|v, x, y, mod, butNum|
			point = [x,y];
			if(butNum == 0, { v.refresh;

			case
				{y<30} {nil}
				{y>=30 and: y<=40}  {~z1.close;~z1 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
				{y>=40 and: y<=50}  {~z2.close;~z2 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
				{y>=50 and: y<=60}  {~z3.close;~z3 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
				/*{y>=60 and: y<=70}  {~z4.close;~z4 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
				{y>=70 and: y<=80}  {~z5.close;~z5 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
				{y>=80 and: y<=90}  {~z6.close;~z6 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
				{y>=90 and: y<=100} {~z7.close;~z7 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
			*/	/*{y>=100 and: y<=110} {~z8.close;~z8 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
				{y>=110 and: y<=120} {~z9.close;~z9 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
				{y>=120 and: y<=130} {~z10.close;~z10 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
				{y>=130 and: y<=140} {~z11.close;~z11 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
				{y>=140 and: y<=150} {~z12.close;~z12 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}*/
				/*{y>=150 and: y<=160} {~z13.close;~z13 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
				{y>=160 and: y<=170} {~z14.close;~z14 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
				{y>=170 and: y<=180} {~z15.close;~z15 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
				{y>=180 and: y<=190} {~z16.close;~z16 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
				{y>=190 and: y<=200} {~z17.close;~z17 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
				{y>=200 and: y<=210} {~z18.close;~z18 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
				{y>=210 and: y<=220} {~z19.close;~z19 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
				{y>=220 and: y<=230} {~z20.close;~z20 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
				{y>=230 and: y<=240} {~z21.close;~z21 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
				{y>=240 and: y<=250} {~z22.close;~z22 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
				{y>=250 and: y<=260} {~z23.close;~z23 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
				{y>=260 and: y<=270} {~z24.close;~z24 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}*/
				{y>90 and: y<340} {nil}
				{y>=340 and: y<=350} {~z1.close;~z1 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
				{y>=350 and: y<=360} {~z2.close;~z2 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
				{y>=360 and: y<=370} {~z3.close;~z3 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
				/*{y>=370 and: y<=380} {~z4.close;~z4 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
				{y>=380 and: y<=390} {~z5.close;~z5 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
				{y>=390 and: y<=400} {~z6.close;~z6 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
				{y>=400 and: y<=410} {~z7.close;~z7 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
		*/		/*{y>=410 and: y<=420} {~z8.close;~z8 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
				{y>=420 and: y<=430} {~z9.close;~z9 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
				{y>=430 and: y<=440} {~z10.close;~z10 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
				{y>=440 and: y<=450} {~z11.close;~z11 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
				{y>=450 and: y<=460} {~z12.close;~z12 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}*/;
				/*{y>=460 and: y<=470} {~z13.close;~z13 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
				{y>=470 and: y<=480} {~z14.close;~z14 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
				{y>=480 and: y<=490} {~z15.close;~z15 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
				{y>=490 and: y<=500} {~z16.close;~z16 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
				{y>=500 and: y<=510} {~z17.close;~z17 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
				{y>=510 and: y<=520} {~z18.close;~z18 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
				{y>=520 and: y<=530} {~z19.close;~z19 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
				{y>=530 and: y<=540} {~z20.close;~z20 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
				{y>=540 and: y<=550} {~z21.close;~z21 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
				{y>=550 and: y<=560} {~z22.close;~z22 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
				{y>=560 and: y<=570} {~z23.close;~z23 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
				{y>=570 and: y<=580} {~z24.close;~z24 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)};*/
			}, {});

			case
		{~l1a.isRunning == true}{
				case
				{y<30} {nil}
				{y>=30 and: y<=40} {
					~l1a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
					~l1b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value);~f1=q.value;
					~l1c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
					~l1d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
					~l1e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
					~l1f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}
				{y>=40 and: y<=50} {
					~l2a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
					~l2b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value);~f2=q.value;
					~l2c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
					~l2d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
					~l2e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
					~l2f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}
				{y>=50 and: y<=60} {
					~l3a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
					~l3b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value);~f3=q.value;
					~l3c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
					~l3d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
					~l3e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
					~l3f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}
				/*{y>=60 and: y<=70} {
					~l4a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
					~l4b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value);~f4=q.value;
					~l4c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
					~l4d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
					~l4e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
					~l4f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}
				{y>=70 and: y<=80} {
					~l5a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
					~l5b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value);~f5=q.value;
					~l5c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
					~l5d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
					~l5e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
					~l5f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}
				{y>=80 and: y<=90} {
					~l6a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
					~l6b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value);~f6=q.value;
					~l6c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
					~l6d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
					~l6e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
					~l6f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}
				{y>=90 and: y<=100} {
					~l7a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
					~l7b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value);~f7=q.value;
					~l7c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
					~l7d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
					~l7e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
					~l7f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}*/
				/*{y>=100 and: y<=110} {
				~l8a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
				~l8b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value);~f8=q.value;
				~l8c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
				~l8d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
				~l8e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
				~l8f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}
				{y>=110 and: y<=120} {
				~l9a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
				~l9b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value);~f9=q.value;
				~l9c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
				~l9d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
				~l9e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
				~l9f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}
				{y>=120 and: y<=130} {
				~l10a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
				~l10b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value);~f10=q.value;
				~l10c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
				~l10d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
				~l10e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
				~l10f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}
				{y>=130 and: y<=140} {
				~l11a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
				~l11b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value);~f11=q.value;
				~l11c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
				~l11d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
				~l11e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
				~l11f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}
				{y>=140 and: y<=150} {
				~l12a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
				~l12b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value);~f12=q.value;
				~l12c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
				~l12d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
				~l12e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
				~l12f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}*/
				/*{y>=110 and: y<=120} {
				{y>=120 and: y<=130} {
				{y>=130 and: y<=140} {
				{y>=140 and: y<=150} {
				{y>=150 and: y<=160} {
				{y>=160 and: y<=170} {
				{y>=170 and: y<=180} {
				{y>=180 and: y<=190} {
				{y>=190 and: y<=200} {
				{y>=200 and: y<=210} {
				{y>=210 and: y<=220} {
				{y>=220 and: y<=230} {
				{y>=230 and: y<=240} {
				{y>=240 and: y<=250} {
				{y>=250 and: y<=260} {*/
				/*{y>=260 and: y<=270} {
				~l8e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
				~l8f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value);~f24=q.value;}*/
				{y>100 and: y<340} {nil}
				{y>=340 and: y<=350} {
					~l1a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
					~l1b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f1=q.value;
					~l1c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
					~l1d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
					~l1e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
					~l1f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);}
				{y>=350 and: y<=360} {
					~l2a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
					~l2b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f2=q.value;
					~l2c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
					~l2d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
					~l2e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
					~l2f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);}
				{y>=360 and: y<=370} {
					~l3a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
					~l3b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f3=q.value;
					~l3c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
					~l3d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
					~l3e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
					~l3f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);}
				/*{y>=370 and: y<=380} {
					~l4a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
					~l4b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f4=q.value;
					~l4c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
					~l4d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
					~l4e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
					~l4f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);}
				{y>=380 and: y<=390} {
					~l5a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
					~l5b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f5=q.value;
					~l5c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
					~l5d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
					~l5e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
					~l5f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);}
				{y>=390 and: y<=400} {
					~l6a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
					~l6b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f6=q.value;
					~l6c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
					~l6d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
					~l6e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
					~l6f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);}
				{y>=400 and: y<=410} {
					~l7a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
					~l7b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f7=q.value;
					~l7c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
					~l7d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
					~l7e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
					~l7f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);}*/;
				/*{y>=410 and: y<=420} {
				~l8a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l8b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f8=q.value;
				~l8c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
				~l8d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
				~l8e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
				~l8f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);}
				{y>=420 and: y<=430} {
				~l9a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l9b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f9=q.value;
				~l9c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
				~l9d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
				~l9e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
				~l9f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);}
				{y>=430 and: y<=440} {
				~l10a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l10b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f10=q.value;
				~l10c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
				~l10d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
				~l10e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
				~l10f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);}
				{y>=440 and: y<=450} {
				~l11a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l11b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f11=q.value;
				~l11c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
				~l11d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
				~l11e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
				~l11f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);}
				{y>=450 and: y<=460} {
				~l12a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l12b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f12=q.value;
				~l12c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
				~l12d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
				~l12e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
				~l12f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);};*/
				/*{y>=460 and: y<=470} {
				~l5a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l5b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f5=q.value;}
				{y>=470 and: y<=480} {
				~l5c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l5d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f14=q.value;}
				{y>=480 and: y<=490} {
				~l5e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l5f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f15=q.value;}
				{y>=490 and: y<=500} {
				~l6a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l6b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f6=q.value;}
				{y>=500 and: y<=510} {
				~l6c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l6d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f17=q.value;}
				{y>=510 and: y<=520} {
				~l6e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l6f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f18=q.value;}
				{y>=520 and: y<=530} {
				~l7a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l7b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f7=q.value;}
				{y>=530 and: y<=540} {
				~l7c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l7d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f20=q.value;}
				{y>=540 and: y<=550} {
				~l7e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l7f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f21=q.value;}
				{y>=550 and: y<=560} {
				~l8a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l8b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f8=q.value;}
				{y>=460 and: y<=570} {
				~l8c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l8d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f23=q.value;}
				{y>=570 and: y<=580} {
				~l8e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l8f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f24=q.value;};*/
					}
					{~l1a1.isRunning == true}{
				case
				{y<30} {nil}
				{y>=30 and: y<=40} {
					~l1a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
					~l1b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value);~f1=q.value;
					~l1c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
					~l1d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
					~l1e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
					~l1f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}
				{y>=40 and: y<=50} {
					~l2a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
					~l2b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value);~f2=q.value;
					~l2c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
					~l2d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
					~l2e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
					~l2f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}
				{y>=50 and: y<=60} {
					~l3a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
					~l3b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value);~f3=q.value;
					~l3c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
					~l3d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
					~l3e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
					~l3f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}
				/*{y>=60 and: y<=70} {
					~l4a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
					~l4b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value);~f4=q.value;
					~l4c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
					~l4d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
					~l4e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
					~l4f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}
				{y>=70 and: y<=80} {
					~l5a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
					~l5b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value);~f5=q.value;
					~l5c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
					~l5d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
					~l5e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
					~l5f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}
				{y>=80 and: y<=90} {
					~l6a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
					~l6b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value);~f6=q.value;
					~l6c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
					~l6d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
					~l6e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
					~l6f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}
				{y>=90 and: y<=100} {
					~l7a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
					~l7b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value);~f7=q.value;
					~l7c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
					~l7d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
					~l7e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
					~l7f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}*/
				/*{y>=100 and: y<=110} {
				~l8a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
				~l8b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value);~f8=q.value;
				~l8c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
				~l8d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
				~l8e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
				~l8f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}
				{y>=110 and: y<=120} {
				~l9a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
				~l9b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value);~f9=q.value;
				~l9c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
				~l9d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
				~l9e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
				~l9f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}
				{y>=120 and: y<=130} {
				~l10a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
				~l10b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value);~f10=q.value;
				~l10c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
				~l10d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
				~l10e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
				~l10f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}
				{y>=130 and: y<=140} {
				~l11a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
				~l11b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value);~f11=q.value;
				~l11c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
				~l11d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
				~l11e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
				~l11f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}
				{y>=140 and: y<=150} {
				~l12a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
				~l12b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value);~f12=q.value;
				~l12c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
				~l12d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
				~l12e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
				~l12f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}*/
				/*{y>=110 and: y<=120} {
				{y>=120 and: y<=130} {
				{y>=130 and: y<=140} {
				{y>=140 and: y<=150} {
				{y>=150 and: y<=160} {
				{y>=160 and: y<=170} {
				{y>=170 and: y<=180} {
				{y>=180 and: y<=190} {
				{y>=190 and: y<=200} {
				{y>=200 and: y<=210} {
				{y>=210 and: y<=220} {
				{y>=220 and: y<=230} {
				{y>=230 and: y<=240} {
				{y>=240 and: y<=250} {
				{y>=250 and: y<=260} {*/
				/*{y>=260 and: y<=270} {
				~l8e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
				~l8f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value);~f24=q.value;}*/
				{y>100 and: y<340} {nil}
				{y>=340 and: y<=350} {
					~l1a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
					~l1b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f1=q.value;
					~l1c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
					~l1d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
					~l1e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
					~l1f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);}
				{y>=350 and: y<=360} {
					~l2a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
					~l2b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f2=q.value;
					~l2c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
					~l2d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
					~l2e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
					~l2f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);}
				{y>=360 and: y<=370} {
					~l3a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
					~l3b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f3=q.value;
					~l3c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
					~l3d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
					~l3e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
					~l3f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);}
				/*{y>=370 and: y<=380} {
					~l4a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
					~l4b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f4=q.value;
					~l4c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
					~l4d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
					~l4e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
					~l4f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);}
				{y>=380 and: y<=390} {
					~l5a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
					~l5b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f5=q.value;
					~l5c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
					~l5d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
					~l5e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
					~l5f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);}
				{y>=390 and: y<=400} {
					~l6a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
					~l6b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f6=q.value;
					~l6c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
					~l6d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
					~l6e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
					~l6f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);}
				{y>=400 and: y<=410} {
					~l7a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
					~l7b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f7=q.value;
					~l7c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
					~l7d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
					~l7e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
					~l7f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);}*/;
				/*{y>=410 and: y<=420} {
				~l8a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l8b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f8=q.value;
				~l8c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
				~l8d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
				~l8e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
				~l8f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);}
				{y>=420 and: y<=430} {
				~l9a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l9b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f9=q.value;
				~l9c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
				~l9d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
				~l9e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
				~l9f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);}
				{y>=430 and: y<=440} {
				~l10a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l10b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f10=q.value;
				~l10c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
				~l10d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
				~l10e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
				~l10f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);}
				{y>=440 and: y<=450} {
				~l11a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l11b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f11=q.value;
				~l11c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
				~l11d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
				~l11e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
				~l11f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);}
				{y>=450 and: y<=460} {
				~l12a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l12b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f12=q.value;
				~l12c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
				~l12d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
				~l12e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
				~l12f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);};*/
				/*{y>=460 and: y<=470} {
				~l5a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l5b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f5=q.value;}
				{y>=470 and: y<=480} {
				~l5c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l5d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f14=q.value;}
				{y>=480 and: y<=490} {
				~l5e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l5f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f15=q.value;}
				{y>=490 and: y<=500} {
				~l6a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l6b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f6=q.value;}
				{y>=500 and: y<=510} {
				~l6c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l6d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f17=q.value;}
				{y>=510 and: y<=520} {
				~l6e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l6f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f18=q.value;}
				{y>=520 and: y<=530} {
				~l7a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l7b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f7=q.value;}
				{y>=530 and: y<=540} {
				~l7c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l7d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f20=q.value;}
				{y>=540 and: y<=550} {
				~l7e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l7f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f21=q.value;}
				{y>=550 and: y<=560} {
				~l8a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l8b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f8=q.value;}
				{y>=460 and: y<=570} {
				~l8c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l8d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f23=q.value;}
				{y>=570 and: y<=580} {
				~l8e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l8f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f24=q.value;};*/
			};
		};


		~z1 = (CompositeView(w, Rect(x, y, 5, 5)).background = Color.yellow;);
		~z2 = (CompositeView(w, Rect(x, y, 5, 5)).background = Color.yellow;);
		~z3 = (CompositeView(w, Rect(x, y, 5, 5)).background = Color.yellow;);
		/*~z4 = (CompositeView(w, Rect(x, y, 5, 5)).background = Color.yellow;);
		~z5 = (CompositeView(w, Rect(x, y, 5, 5)).background = Color.yellow;);
		~z6 = (CompositeView(w, Rect(x, y, 5, 5)).background = Color.yellow;);
		~z7 = (CompositeView(w, Rect(x, y, 5, 5)).background = Color.yellow;);*/
		/*~z8 = (CompositeView(w, Rect(x, y, 5, 5)).background = Color.yellow;);
		~z9 = (CompositeView(w, Rect(x, y, 5, 5)).background = Color.yellow;);
		~z10 = (CompositeView(w, Rect(x, y, 5, 5)).background = Color.yellow;);
		~z11 = (CompositeView(w, Rect(x, y, 5, 5)).background = Color.yellow;);
		~z12 = (CompositeView(w, Rect(x, y, 5, 5)).background = Color.yellow;);*/
		/*~z13 = (CompositeView(w, Rect(x, y, 5, 5)).background = Color.yellow;);
		~z14 = (CompositeView(w, Rect(x, y, 5, 5)).background = Color.yellow;);
		~z15 = (CompositeView(w, Rect(x, y, 5, 5)).background = Color.yellow;);
		~z16 = (CompositeView(w, Rect(x, y, 5, 5)).background = Color.yellow;);
		~z17 = (CompositeView(w, Rect(x, y, 5, 5)).background = Color.yellow;);
		~z18 = (CompositeView(w, Rect(x, y, 5, 5)).background = Color.yellow;);
		~z19 = (CompositeView(w, Rect(x, y, 5, 5)).background = Color.yellow;);
		~z20 = (CompositeView(w, Rect(x, y, 5, 5)).background = Color.yellow;);
		~z21 = (CompositeView(w, Rect(x, y, 5, 5)).background = Color.yellow;);
		~z22 = (CompositeView(w, Rect(x, y, 5, 5)).background = Color.yellow;);
		~z23 = (CompositeView(w, Rect(x, y, 5, 5)).background = Color.yellow;);
		~z24 = (CompositeView(w, Rect(x, y, 5, 5)).background = Color.yellow;);*/
		~z25 = (CompositeView(w, Rect(x, y, 5, 5)).background = Color.yellow;);
		~z26 = (CompositeView(w, Rect(x, y, 5, 5)).background = Color.yellow;);
		~z27 = (CompositeView(w, Rect(x, y, 5, 5)).background = Color.yellow;);
		/*~z28 = (CompositeView(w, Rect(x, y, 5, 5)).background = Color.yellow;);
		~z29 = (CompositeView(w, Rect(x, y, 5, 5)).background = Color.yellow;);
		~z30 = (CompositeView(w, Rect(x, y, 5, 5)).background = Color.yellow;);
		~z31 = (CompositeView(w, Rect(x, y, 5, 5)).background = Color.yellow;);*/
		/*~z32 = (CompositeView(w, Rect(x, y, 5, 5)).background = Color.yellow;);
		~z33 = (CompositeView(w, Rect(x, y, 5, 5)).background = Color.yellow;);
		~z34 = (CompositeView(w, Rect(x, y, 5, 5)).background = Color.yellow;);
		~z35 = (CompositeView(w, Rect(x, y, 5, 5)).background = Color.yellow;);
		~z36 = (CompositeView(w, Rect(x, y, 5, 5)).background = Color.yellow;);*/
		/*~z37 = (CompositeView(w, Rect(x, y, 5, 5)).background = Color.yellow;);
		~z38 = (CompositeView(w, Rect(x, y, 5, 5)).background = Color.yellow;);
		~z39 = (CompositeView(w, Rect(x, y, 5, 5)).background = Color.yellow;);
		~z40 = (CompositeView(w, Rect(x, y, 5, 5)).background = Color.yellow;);
		~z41 = (CompositeView(w, Rect(x, y, 5, 5)).background = Color.yellow;);
		~z42 = (CompositeView(w, Rect(x, y, 5, 5)).background = Color.yellow;);
		~z43 = (CompositeView(w, Rect(x, y, 5, 5)).background = Color.yellow;);
		~z44 = (CompositeView(w, Rect(x, y, 5, 5)).background = Color.yellow;);
		~z45 = (CompositeView(w, Rect(x, y, 5, 5)).background = Color.yellow;);
		~z46 = (CompositeView(w, Rect(x, y, 5, 5)).background = Color.yellow;);
		~z47 = (CompositeView(w, Rect(x, y, 5, 5)).background = Color.yellow;);
		~z48 = (CompositeView(w, Rect(x, y, 5, 5)).background = Color.yellow;);*/
		~ztop = (CompositeView(w, Rect(x, y, 5, 5)).background = Color.yellow;);
		~zmid = (CompositeView(w, Rect(x, y, 5, 5)).background = Color.yellow;);

		~z1.close;~z1 = (CompositeView(w, Rect((if(~f1 == nil, {f1.value},{~f1.value}).explin(~outmin1,~outmax1,0,Window.screenBounds.width)), 40, ~nw, 2)).background = Color.white;);
		~z2.close;~z2 = (CompositeView(w, Rect((if(~f2 == nil, {f2.value},{~f2.value}).explin(~outmin1,~outmax1,0,Window.screenBounds.width)), 50, ~nw, 2)).background = Color.white;);
		~z3.close;~z3 = (CompositeView(w, Rect((if(~f3 == nil, {f3.value},{~f3.value}).explin(~outmin1,~outmax1,0,Window.screenBounds.width)), 60, ~nw, 2)).background = Color.white;);
		/*~z4.close;~z4 = (CompositeView(w, Rect((if(~f4 == nil, {f4.value},{~f4.value}).explin(~outmin1,~outmax1,0,Window.screenBounds.width)), 70, ~nw, 2)).background = Color.white;);
		~z5.close;~z5 = (CompositeView(w, Rect((if(~f5 == nil, {f5.value},{~f5.value}).explin(~outmin1,~outmax1,0,Window.screenBounds.width)), 80, ~nw, 2)).background = Color.white;);
		~z6.close;~z6 = (CompositeView(w, Rect((if(~f6 == nil, {f6.value},{~f6.value}).explin(~outmin1,~outmax1,0,Window.screenBounds.width)), 90, ~nw, 2)).background = Color.white;);
		~z7.close;~z7 = (CompositeView(w, Rect((if(~f7 == nil, {f7.value},{~f7.value}).explin(~outmin1,~outmax1,0,Window.screenBounds.width)), 100, ~nw, 2)).background = Color.white;);
		*//*~z8.close;~z8 = (CompositeView(w, Rect((if(~f8 == nil, {f8.value},{~f8.value}).explin(~outmin1,~outmax1,0,Window.screenBounds.width)), 110, ~nw, 2)).background = Color.white;);
		~z9.close;~z9 = (CompositeView(w, Rect((if(~f9 == nil, {f9.value},{~f9.value}).explin(~outmin1,~outmax1,0,Window.screenBounds.width)), 120, ~nw, 2)).background = Color.white;);
		~z10.close;~z10 = (CompositeView(w, Rect((if(~f10 == nil, {f10.value},{~f10.value}).explin(~outmin1,~outmax1,0,Window.screenBounds.width)), 130, ~nw, 2)).background = Color.white;);
		~z11.close;~z11 = (CompositeView(w, Rect((if(~f11 == nil, {f11.value},{~f11.value}).explin(~outmin1,~outmax1,0,Window.screenBounds.width)), 140, ~nw, 2)).background = Color.white;);
		~z12.close;~z12 = (CompositeView(w, Rect((if(~f12 == nil, {f12.value},{~f12.value}).explin(~outmin1,~outmax1,0,Window.screenBounds.width)), 150, ~nw, 2)).background = Color.white;);
		~z13.close;~z13 = (CompositeView(w, Rect((if(~f37 == nil, {f13.value},{~f37.value}).explin(~outmin1,~outmax1,0,Window.screenBounds.width)), 160, ~nw, 2)).background = Color.white;);
	*/	/*~z14.close;~z14 = (CompositeView(w, Rect((if(~f1 == nil, {f1.value},{~f1.value}).explin(~outmin1,~outmax1,0,Window.screenBounds.width)), 170, ~nw, 2)).background = Color.white;);
		~z15.close;~z15 = (CompositeView(w, Rect((if(~f1 == nil, {f1.value},{~f1.value}).explin(~outmin1,~outmax1,0,Window.screenBounds.width)), 180, ~nw, 2)).background = Color.white;);
		~z16.close;~z16 = (CompositeView(w, Rect((if(~f1 == nil, {f1.value},{~f1.value}).explin(~outmin1,~outmax1,0,Window.screenBounds.width)), 190, ~nw, 2)).background = Color.white;);
		~z17.close;~z17 = (CompositeView(w, Rect((if(~f1 == nil, {f1.value},{~f1.value}).explin(~outmin1,~outmax1,0,Window.screenBounds.width)), 200, ~nw, 2)).background = Color.white;);
		~z18.close;~z18 = (CompositeView(w, Rect((if(~f1 == nil, {f1.value},{~f1.value}).explin(~outmin1,~outmax1,0,Window.screenBounds.width)), 210, ~nw, 2)).background = Color.white;);
		~z19.close;~z19 = (CompositeView(w, Rect((if(~f1 == nil, {f1.value},{~f1.value}).explin(~outmin1,~outmax1,0,Window.screenBounds.width)), 220, ~nw, 2)).background = Color.white;);
		~z20.close;~z20 = (CompositeView(w, Rect((if(~f1 == nil, {f1.value},{~f1.value}).explin(~outmin1,~outmax1,0,Window.screenBounds.width)), 230, ~nw, 2)).background = Color.white;);
		~z21.close;~z21 = (CompositeView(w, Rect((if(~f1 == nil, {f1.value},{~f1.value}).explin(~outmin1,~outmax1,0,Window.screenBounds.width)), 240, ~nw, 2)).background = Color.white;);
		~z22.close;~z22 = (CompositeView(w, Rect((if(~f1 == nil, {f1.value},{~f1.value}).explin(~outmin1,~outmax1,0,Window.screenBounds.width)), 250, ~nw, 2)).background = Color.white;);
		~z23.close;~z23 = (CompositeView(w, Rect((if(~f1 == nil, {f1.value},{~f1.value}).explin(~outmin1,~outmax1,0,Window.screenBounds.width)), 260, ~nw, 2)).background = Color.white;);
		~z24.close;~z24 = (CompositeView(w, Rect((if(~f1 == nil, {f1.value},{~f1.value}).explin(~outmin1,~outmax1,0,Window.screenBounds.width)), 270, ~nw, 2)).background = Color.white;);
		*/		~zmid.close;~zmid = (CompositeView(w, Rect(x, 280, ~nw, 2)).background = Color.clear;);
		~z25.close;~z25 = (CompositeView(w, Rect((if(~f1 == nil, {f1.value},{~f1.value}).explin(~outmin2,~outmax2,0,Window.screenBounds.width)), 350, ~nw, 2)).background = Color.white;);
		~z26.close;~z26 = (CompositeView(w, Rect((if(~f2 == nil, {f2.value},{~f2.value}).explin(~outmin2,~outmax2,0,Window.screenBounds.width)), 360, ~nw, 2)).background = Color.white;);
		~z27.close;~z27 = (CompositeView(w, Rect((if(~f3 == nil, {f3.value},{~f3.value}).explin(~outmin2,~outmax2,0,Window.screenBounds.width)), 370, ~nw, 2)).background = Color.white;);
		/*~z28.close;~z28 = (CompositeView(w, Rect((if(~f4 == nil, {f4.value},{~f4.value}).explin(~outmin2,~outmax2,0,Window.screenBounds.width)), 380, ~nw, 2)).background = Color.white;);
		~z29.close;~z29 = (CompositeView(w, Rect((if(~f5 == nil, {f5.value},{~f5.value}).explin(~outmin2,~outmax2,0,Window.screenBounds.width)), 390, ~nw, 2)).background = Color.white;);
		~z30.close;~z30 = (CompositeView(w, Rect((if(~f6 == nil, {f6.value},{~f6.value}).explin(~outmin2,~outmax2,0,Window.screenBounds.width)), 400, ~nw, 2)).background = Color.white;);
		~z31.close;~z31 = (CompositeView(w, Rect((if(~f7 == nil, {f7.value},{~f7.value}).explin(~outmin2,~outmax2,0,Window.screenBounds.width)), 410, ~nw, 2)).background = Color.white;);
	*/	/*~z32.close;~z32 = (CompositeView(w, Rect((if(~f8 == nil, {f8.value},{~f8.value}).explin(~outmin2,~outmax2,0,Window.screenBounds.width)), 420, ~nw, 2)).background = Color.white;);
		~z33.close;~z33 = (CompositeView(w, Rect((if(~f9 == nil, {f9.value},{~f9.value}).explin(~outmin2,~outmax2,0,Window.screenBounds.width)), 430, ~nw, 2)).background = Color.white;);
		~z34.close;~z34 = (CompositeView(w, Rect((if(~f10 == nil, {f10.value},{~f10.value}).explin(~outmin2,~outmax2,0,Window.screenBounds.width)), 440, ~nw, 2)).background = Color.white;);
		~z35.close;~z35 = (CompositeView(w, Rect((if(~f11 == nil, {f11.value},{~f11.value}).explin(~outmin2,~outmax2,0,Window.screenBounds.width)), 450, ~nw, 2)).background = Color.white;);
		~z36.close;~z36 = (CompositeView(w, Rect((if(~f12 == nil, {f12.value},{~f12.value}).explin(~outmin2,~outmax2,0,Window.screenBounds.width)), 460, ~nw, 2)).background = Color.white;);
		~z37.close;~z37 = (CompositeView(w, Rect((if(~f37 == nil, {f13.value},{~f37.value}).explin(~outmin2,~outmax2,0,Window.screenBounds.width)), 470, ~nw, 2)).background = Color.white;);
	*/	/*~z38.close;~z38 = (CompositeView(w, Rect((if(~f1 == nil, {f1.value},{~f1.value}).explin(~outmin2,~outmax2,0,Window.screenBounds.width)), 480, ~nw, 2)).background = Color.white;);
		~z39.close;~z39 = (CompositeView(w, Rect((if(~f1 == nil, {f1.value},{~f1.value}).explin(~outmin2,~outmax2,0,Window.screenBounds.width)), 490, ~nw, 2)).background = Color.white;);
		~z40.close;~z40 = (CompositeView(w, Rect((if(~f1 == nil, {f1.value},{~f1.value}).explin(~outmin2,~outmax2,0,Window.screenBounds.width)), 500, ~nw, 2)).background = Color.white;);
		~z41.close;~z41 = (CompositeView(w, Rect((if(~f1 == nil, {f1.value},{~f1.value}).explin(~outmin2,~outmax2,0,Window.screenBounds.width)), 510, ~nw, 2)).background = Color.white;);
		~z42.close;~z42 = (CompositeView(w, Rect((if(~f1 == nil, {f1.value},{~f1.value}).explin(~outmin2,~outmax2,0,Window.screenBounds.width)), 520, ~nw, 2)).background = Color.white;);
		~z43.close;~z43 = (CompositeView(w, Rect((if(~f1 == nil, {f1.value},{~f1.value}).explin(~outmin2,~outmax2,0,Window.screenBounds.width)), 530, ~nw, 2)).background = Color.white;);
		~z44.close;~z44 = (CompositeView(w, Rect((if(~f1 == nil, {f1.value},{~f1.value}).explin(~outmin2,~outmax2,0,Window.screenBounds.width)), 540, ~nw, 2)).background = Color.white;);
		~z45.close;~z45 = (CompositeView(w, Rect((if(~f1 == nil, {f1.value},{~f1.value}).explin(~outmin2,~outmax2,0,Window.screenBounds.width)), 550, ~nw, 2)).background = Color.white;);
		~z46.close;~z46 = (CompositeView(w, Rect((if(~f1 == nil, {f1.value},{~f1.value}).explin(~outmin2,~outmax2,0,Window.screenBounds.width)), 560, ~nw, 2)).background = Color.white;);
		~z47.close;~z47 = (CompositeView(w, Rect((if(~f1 == nil, {f1.value},{~f1.value}).explin(~outmin2,~outmax2,0,Window.screenBounds.width)), 570, ~nw, 2)).background = Color.white;);
		~z48.close;~z48 = (CompositeView(w, Rect((if(~f1 == nil, {f1.value},{~f1.value}).explin(~outmin2,~outmax2,0,Window.screenBounds.width)), 580, ~nw, 2)).background = Color.white;);
		*/

			/*if(~f1 == nil, {

		~z1.close;~z1 = (CompositeView(w, Rect((f1.explin(~outmin1,~outmax1,0,Window.screenBounds.width)), 40, ~nw, 2)).background = Color.white;);
		~z2.close;~z2 = (CompositeView(w, Rect((f2.explin(~outmin1,~outmax1,0,Window.screenBounds.width)), 50, ~nw, 2)).background = Color.white;);
		~z3.close;~z3 = (CompositeView(w, Rect((f3.explin(~outmin1,~outmax1,0,Window.screenBounds.width)), 60, ~nw, 2)).background = Color.white;);
		~z4.close;~z4 = (CompositeView(w, Rect((f4.explin(~outmin1,~outmax1,0,Window.screenBounds.width)), 70, ~nw, 2)).background = Color.white;);
		~z5.close;~z5 = (CompositeView(w, Rect((f5.explin(~outmin1,~outmax1,0,Window.screenBounds.width)), 80, ~nw, 2)).background = Color.white;);
		~z6.close;~z6 = (CompositeView(w, Rect((f6.explin(~outmin1,~outmax1,0,Window.screenBounds.width)), 90, ~nw, 2)).background = Color.white;);
		~z7.close;~z7 = (CompositeView(w, Rect((f7.explin(~outmin1,~outmax1,0,Window.screenBounds.width)), 100, ~nw, 2)).background = Color.white;);
		/*~z8.close;~z8 = (CompositeView(w, Rect((f8.explin(~outmin1,~outmax1,0,Window.screenBounds.width)), 110, ~nw, 2)).background = Color.white;);
		~z9.close;~z9 = (CompositeView(w, Rect((f9.explin(~outmin1,~outmax1,0,Window.screenBounds.width)), 120, ~nw, 2)).background = Color.white;);
		~z10.close;~z10 = (CompositeView(w, Rect((f10.explin(~outmin1,~outmax1,0,Window.screenBounds.width)), 130, ~nw, 2)).background = Color.white;);
		~z11.close;~z11 = (CompositeView(w, Rect((f11.explin(~outmin1,~outmax1,0,Window.screenBounds.width)), 140, ~nw, 2)).background = Color.white;);
		~z12.close;~z12 = (CompositeView(w, Rect((f12.explin(~outmin1,~outmax1,0,Window.screenBounds.width)), 150, ~nw, 2)).background = Color.white;);
		*/		/*~z13.close;~z13 = (CompositeView(w, Rect((f13.explin(~outmin1,~outmax1,0,Window.screenBounds.width)), 160, ~nw, 2)).background = Color.white;);
		~z14.close;~z14 = (CompositeView(w, Rect((f14.explin(~outmin1,~outmax1,0,Window.screenBounds.width)), 170, ~nw, 2)).background = Color.white;);
		~z15.close;~z15 = (CompositeView(w, Rect((f15.explin(~outmin1,~outmax1,0,Window.screenBounds.width)), 180, ~nw, 2)).background = Color.white;);
		~z16.close;~z16 = (CompositeView(w, Rect((f16.explin(~outmin1,~outmax1,0,Window.screenBounds.width)), 190, ~nw, 2)).background = Color.white;);
		~z17.close;~z17 = (CompositeView(w, Rect((f17.explin(~outmin1,~outmax1,0,Window.screenBounds.width)), 200, ~nw, 2)).background = Color.white;);
		~z18.close;~z18 = (CompositeView(w, Rect((f18.explin(~outmin1,~outmax1,0,Window.screenBounds.width)), 210, ~nw, 2)).background = Color.white;);
		~z19.close;~z19 = (CompositeView(w, Rect((f19.explin(~outmin1,~outmax1,0,Window.screenBounds.width)), 220, ~nw, 2)).background = Color.white;);
		~z20.close;~z20 = (CompositeView(w, Rect((f20.explin(~outmin1,~outmax1,0,Window.screenBounds.width)), 230, ~nw, 2)).background = Color.white;);
		~z21.close;~z21 = (CompositeView(w, Rect((f21.explin(~outmin1,~outmax1,0,Window.screenBounds.width)), 240, ~nw, 2)).background = Color.white;);
		~z22.close;~z22 = (CompositeView(w, Rect((f22.explin(~outmin1,~outmax1,0,Window.screenBounds.width)), 250, ~nw, 2)).background = Color.white;);
		~z23.close;~z23 = (CompositeView(w, Rect((f23.explin(~outmin1,~outmax1,0,Window.screenBounds.width)), 260, ~nw, 2)).background = Color.white;);
		~z24.close;~z24 = (CompositeView(w, Rect((f24.explin(~outmin1,~outmax1,0,Window.screenBounds.width)), 270, ~nw, 2)).background = Color.white;);
		*/		~zmid.close;~zmid = (CompositeView(w, Rect(x, 280, ~nw, 2)).background = Color.clear;);
		~z25.close;~z25 = (CompositeView(w, Rect((f1.explin(~outmin2,~outmax2,0,Window.screenBounds.width)), 350, ~nw, 2)).background = Color.white;);
		~z26.close;~z26 = (CompositeView(w, Rect((f2.explin(~outmin2,~outmax2,0,Window.screenBounds.width)), 360, ~nw, 2)).background = Color.white;);
		~z27.close;~z27 = (CompositeView(w, Rect((f3.explin(~outmin2,~outmax2,0,Window.screenBounds.width)), 370, ~nw, 2)).background = Color.white;);
		~z28.close;~z28 = (CompositeView(w, Rect((f4.explin(~outmin2,~outmax2,0,Window.screenBounds.width)), 380, ~nw, 2)).background = Color.white;);
		~z29.close;~z29 = (CompositeView(w, Rect((f5.explin(~outmin2,~outmax2,0,Window.screenBounds.width)), 390, ~nw, 2)).background = Color.white;);
		~z30.close;~z30 = (CompositeView(w, Rect((f6.explin(~outmin2,~outmax2,0,Window.screenBounds.width)), 400, ~nw, 2)).background = Color.white;);
		~z31.close;~z31 = (CompositeView(w, Rect((f7.explin(~outmin2,~outmax2,0,Window.screenBounds.width)), 410, ~nw, 2)).background = Color.white;);
		/*~z32.close;~z32 = (CompositeView(w, Rect((f8.explin(~outmin2,~outmax2,0,Window.screenBounds.width)), 420, ~nw, 2)).background = Color.white;);
		~z33.close;~z33 = (CompositeView(w, Rect((f9.explin(~outmin2,~outmax2,0,Window.screenBounds.width)), 430, ~nw, 2)).background = Color.white;);
		~z34.close;~z34 = (CompositeView(w, Rect((f10.explin(~outmin2,~outmax2,0,Window.screenBounds.width)), 440, ~nw, 2)).background = Color.white;);
		~z35.close;~z35 = (CompositeView(w, Rect((f11.explin(~outmin2,~outmax2,0,Window.screenBounds.width)), 450, ~nw, 2)).background = Color.white;);
		~z36.close;~z36 = (CompositeView(w, Rect((f12.explin(~outmin2,~outmax2,0,Window.screenBounds.width)), 460, ~nw, 2)).background = Color.white;);
		*/		/*~z37.close;~z37 = (CompositeView(w, Rect((f13.explin(~outmin2,~outmax2,0,Window.screenBounds.width)), 470, ~nw, 2)).background = Color.white;);
		~z38.close;~z38 = (CompositeView(w, Rect((f14.explin(~outmin2,~outmax2,0,Window.screenBounds.width)), 480, ~nw, 2)).background = Color.white;);
		~z39.close;~z39 = (CompositeView(w, Rect((f15.explin(~outmin2,~outmax2,0,Window.screenBounds.width)), 490, ~nw, 2)).background = Color.white;);
		~z40.close;~z40 = (CompositeView(w, Rect((f16.explin(~outmin2,~outmax2,0,Window.screenBounds.width)), 500, ~nw, 2)).background = Color.white;);
		~z41.close;~z41 = (CompositeView(w, Rect((f17.explin(~outmin2,~outmax2,0,Window.screenBounds.width)), 510, ~nw, 2)).background = Color.white;);
		~z42.close;~z42 = (CompositeView(w, Rect((f18.explin(~outmin2,~outmax2,0,Window.screenBounds.width)), 520, ~nw, 2)).background = Color.white;);
		~z43.close;~z43 = (CompositeView(w, Rect((f19.explin(~outmin2,~outmax2,0,Window.screenBounds.width)), 530, ~nw, 2)).background = Color.white;);
		~z44.close;~z44 = (CompositeView(w, Rect((f20.explin(~outmin2,~outmax2,0,Window.screenBounds.width)), 540, ~nw, 2)).background = Color.white;);
		~z45.close;~z45 = (CompositeView(w, Rect((f21.explin(~outmin2,~outmax2,0,Window.screenBounds.width)), 550, ~nw, 2)).background = Color.white;);
		~z46.close;~z46 = (CompositeView(w, Rect((f22.explin(~outmin2,~outmax2,0,Window.screenBounds.width)), 560, ~nw, 2)).background = Color.white;);
		~z47.close;~z47 = (CompositeView(w, Rect((f23.explin(~outmin2,~outmax2,0,Window.screenBounds.width)), 570, ~nw, 2)).background = Color.white;);
		~z48.close;~z48 = (CompositeView(w, Rect((f24.explin(~outmin2,~outmax2,0,Window.screenBounds.width)), 580, ~nw, 2)).background = Color.white;);
		*/
		},
		{
		~z1.close;~z1 = (CompositeView(w, Rect((~f1.explin(~outmin1,~outmax1,0,Window.screenBounds.width)), 40, ~nw, 2)).background = Color.white;);
		~z2.close;~z2 = (CompositeView(w, Rect((~f2.explin(~outmin1,~outmax1,0,Window.screenBounds.width)), 50, ~nw, 2)).background = Color.white;);
		~z3.close;~z3 = (CompositeView(w, Rect((~f3.explin(~outmin1,~outmax1,0,Window.screenBounds.width)), 60, ~nw, 2)).background = Color.white;);
		~z4.close;~z4 = (CompositeView(w, Rect((~f4.explin(~outmin1,~outmax1,0,Window.screenBounds.width)), 70, ~nw, 2)).background = Color.white;);
		~z5.close;~z5 = (CompositeView(w, Rect((~f5.explin(~outmin1,~outmax1,0,Window.screenBounds.width)), 80, ~nw, 2)).background = Color.white;);
		~z6.close;~z6 = (CompositeView(w, Rect((~f6.explin(~outmin1,~outmax1,0,Window.screenBounds.width)), 90, ~nw, 2)).background = Color.white;);
		~z7.close;~z7 = (CompositeView(w, Rect((~f7.explin(~outmin1,~outmax1,0,Window.screenBounds.width)), 100, ~nw, 2)).background = Color.white;);
		/*~z8.close;~z8 = (CompositeView(w, Rect((~f8.explin(~outmin1,~outmax1,0,Window.screenBounds.width)), 110, ~nw, 2)).background = Color.white;);
		~z9.close;~z9 = (CompositeView(w, Rect((~f9.explin(~outmin1,~outmax1,0,Window.screenBounds.width)), 120, ~nw, 2)).background = Color.white;);
		~z10.close;~z10 = (CompositeView(w, Rect((~f4.explin(~outmin1,~outmax1,0,Window.screenBounds.width)), 130, ~nw, 2)).background = Color.white;);
		~z11.close;~z11 = (CompositeView(w, Rect((~f11.explin(~outmin1,~outmax1,0,Window.screenBounds.width)), 140, ~nw, 2)).background = Color.white;);
		~z12.close;~z12 = (CompositeView(w, Rect((~f12.explin(~outmin1,~outmax1,0,Window.screenBounds.width)), 150, ~nw, 2)).background = Color.white;);
		*/		/*~z13.close;~z13 = (CompositeView(w, Rect((~f5.explin(~outmin1,~outmax1,0,Window.screenBounds.width)), 160, ~nw, 2)).background = Color.white;);
		~z14.close;~z14 = (CompositeView(w, Rect((~f14.explin(~outmin1,~outmax1,0,Window.screenBounds.width)), 170, ~nw, 2)).background = Color.white;);
		~z15.close;~z15 = (CompositeView(w, Rect((~f15.explin(~outmin1,~outmax1,0,Window.screenBounds.width)), 180, ~nw, 2)).background = Color.white;);
		~z16.close;~z16 = (CompositeView(w, Rect((~f6.explin(~outmin1,~outmax1,0,Window.screenBounds.width)), 190, ~nw, 2)).background = Color.white;);
		~z17.close;~z17 = (CompositeView(w, Rect((~f17.explin(~outmin1,~outmax1,0,Window.screenBounds.width)), 200, ~nw, 2)).background = Color.white;);
		~z18.close;~z18 = (CompositeView(w, Rect((~f18.explin(~outmin1,~outmax1,0,Window.screenBounds.width)), 210, ~nw, 2)).background = Color.white;);
		~z19.close;~z19 = (CompositeView(w, Rect((~f7.explin(~outmin1,~outmax1,0,Window.screenBounds.width)), 220, ~nw, 2)).background = Color.white;);
		~z20.close;~z20 = (CompositeView(w, Rect((~f20.explin(~outmin1,~outmax1,0,Window.screenBounds.width)), 230, ~nw, 2)).background = Color.white;);
		~z21.close;~z21 = (CompositeView(w, Rect((~f21.explin(~outmin1,~outmax1,0,Window.screenBounds.width)), 240, ~nw, 2)).background = Color.white;);
		~z22.close;~z22 = (CompositeView(w, Rect((~f8.explin(~outmin1,~outmax1,0,Window.screenBounds.width)), 250, ~nw, 2)).background = Color.white;);
		~z23.close;~z23 = (CompositeView(w, Rect((~f23.explin(~outmin1,~outmax1,0,Window.screenBounds.width)), 260, ~nw, 2)).background = Color.white;);
		~z24.close;~z24 = (CompositeView(w, Rect((~f24.explin(~outmin1,~outmax1,0,Window.screenBounds.width)), 270, ~nw, 2)).background = Color.white;);
		*/		~zmid.close;~zmid = (CompositeView(w, Rect(x, 280, ~nw, 2)).background = Color.clear;);
		~z25.close;~z25 = (CompositeView(w, Rect((~f1.explin(~outmin2,~outmax2,0,Window.screenBounds.width)), 350, ~nw, 2)).background = Color.white;);
		~z26.close;~z26 = (CompositeView(w, Rect((~f2.explin(~outmin2,~outmax2,0,Window.screenBounds.width)), 360, ~nw, 2)).background = Color.white;);
		~z27.close;~z27 = (CompositeView(w, Rect((~f3.explin(~outmin2,~outmax2,0,Window.screenBounds.width)), 370, ~nw, 2)).background = Color.white;);
		~z28.close;~z28 = (CompositeView(w, Rect((~f4.explin(~outmin2,~outmax2,0,Window.screenBounds.width)), 380, ~nw, 2)).background = Color.white;);
		~z29.close;~z29 = (CompositeView(w, Rect((~f5.explin(~outmin2,~outmax2,0,Window.screenBounds.width)), 390, ~nw, 2)).background = Color.white;);
		~z30.close;~z30 = (CompositeView(w, Rect((~f6.explin(~outmin2,~outmax2,0,Window.screenBounds.width)), 400, ~nw, 2)).background = Color.white;);
		~z31.close;~z31 = (CompositeView(w, Rect((~f7.explin(~outmin2,~outmax2,0,Window.screenBounds.width)), 410, ~nw, 2)).background = Color.white;);
		/*~z32.close;~z32 = (CompositeView(w, Rect((f8.explin(~outmin2,~outmax2,0,Window.screenBounds.width)), 420, ~nw, 2)).background = Color.white;);
		~z33.close;~z33 = (CompositeView(w, Rect((f9.explin(~outmin2,~outmax2,0,Window.screenBounds.width)), 430, ~nw, 2)).background = Color.white;);
		~z34.close;~z34 = (CompositeView(w, Rect((f10.explin(~outmin2,~outmax2,0,Window.screenBounds.width)), 440, ~nw, 2)).background = Color.white;);
		~z35.close;~z35 = (CompositeView(w, Rect((f11.explin(~outmin2,~outmax2,0,Window.screenBounds.width)), 450, ~nw, 2)).background = Color.white;);
		~z36.close;~z36 = (CompositeView(w, Rect((f12.explin(~outmin2,~outmax2,0,Window.screenBounds.width)), 460, ~nw, 2)).background = Color.white;);
		*/		/*~z37.close;~z37 = (CompositeView(w, Rect((f13.explin(~outmin2,~outmax2,0,Window.screenBounds.width)), 470, ~nw, 2)).background = Color.white;);
		~z38.close;~z38 = (CompositeView(w, Rect((f14.explin(~outmin2,~outmax2,0,Window.screenBounds.width)), 480, ~nw, 2)).background = Color.white;);
		~z39.close;~z39 = (CompositeView(w, Rect((f15.explin(~outmin2,~outmax2,0,Window.screenBounds.width)), 490, ~nw, 2)).background = Color.white;);
		~z40.close;~z40 = (CompositeView(w, Rect((f16.explin(~outmin2,~outmax2,0,Window.screenBounds.width)), 500, ~nw, 2)).background = Color.white;);
		~z41.close;~z41 = (CompositeView(w, Rect((f17.explin(~outmin2,~outmax2,0,Window.screenBounds.width)), 510, ~nw, 2)).background = Color.white;);
		~z42.close;~z42 = (CompositeView(w, Rect((f18.explin(~outmin2,~outmax2,0,Window.screenBounds.width)), 520, ~nw, 2)).background = Color.white;);
		~z43.close;~z43 = (CompositeView(w, Rect((f19.explin(~outmin2,~outmax2,0,Window.screenBounds.width)), 530, ~nw, 2)).background = Color.white;);
		~z44.close;~z44 = (CompositeView(w, Rect((f20.explin(~outmin2,~outmax2,0,Window.screenBounds.width)), 540, ~nw, 2)).background = Color.white;);
		~z45.close;~z45 = (CompositeView(w, Rect((f21.explin(~outmin2,~outmax2,0,Window.screenBounds.width)), 550, ~nw, 2)).background = Color.white;);
		~z46.close;~z46 = (CompositeView(w, Rect((f22.explin(~outmin2,~outmax2,0,Window.screenBounds.width)), 560, ~nw, 2)).background = Color.white;);
		~z47.close;~z47 = (CompositeView(w, Rect((f23.explin(~outmin2,~outmax2,0,Window.screenBounds.width)), 570, ~nw, 2)).background = Color.white;);
		~z48.close;~z48 = (CompositeView(w, Rect((f24.explin(~outmin2,~outmax2,0,Window.screenBounds.width)), 580, ~nw, 2)).background = Color.white;);
		*/
	});*/





		//draw lines with Pen and create Synths according to mouse movement
		view.mouseMoveAction = {
			|v, x, y|

			~nh = 2;
			~nw = ~nh*1.61803398875;
			case
			{y<30} {nil}
			{y>=30 and: y<=40}  {~z1.close;~z25.close;~z1 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
			{y>=40 and: y<=50}  {~z2.close;~z26.close;~z2 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
			{y>=50 and: y<=60}  {~z3.close;~z27.close;~z3 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
			/*{y>=60 and: y<=70}  {~z4.close;~z28.close;~z4 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
			{y>=70 and: y<=80}  {~z5.close;~z29.close;~z5 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
			{y>=80 and: y<=90}  {~z6.close;~z30.close;~z6 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
			{y>=90 and: y<=100} {~z7.close;~z31.close;~z7 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}*/
			/*{y>=100 and: y<=110} {~z8.close;~z32.close;~z8 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
			{y>=110 and: y<=120} {~z9.close;~z33.close;~z9 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
			{y>=120 and: y<=130} {~z10.close;~z34.close;~z10 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
			{y>=130 and: y<=140} {~z11.close;~z35.close;~z11 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
			{y>=140 and: y<=150} {~z12.close;~z36.close;~z12 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}*/
			/*{y>=150 and: y<=160} {~z13.close;~z37.close;~z13 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
			{y>=160 and: y<=170} {~z14.close;~z38.close;~z14 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
			{y>=170 and: y<=180} {~z15.close;~z39.close;~z15 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
			{y>=180 and: y<=190} {~z16.close;~z40.close;~z16 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
			{y>=190 and: y<=200} {~z17.close;~z41.close;~z17 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
			{y>=200 and: y<=210} {~z18.close;~z42.close;~z18 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
			{y>=210 and: y<=220} {~z19.close;~z43.close;~z19 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
			{y>=220 and: y<=230} {~z20.close;~z44.close;~z20 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
			{y>=230 and: y<=240} {~z21.close;~z45.close;~z21 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
			{y>=240 and: y<=250} {~z22.close;~z46.close;~z22 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
			{y>=250 and: y<=260} {~z23.close;~z47.close;~z23 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
			{y>=260 and: y<=270} {~z24.close;~z48.close;~z24 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}*/
			{y>90 and: y<340} {nil}
			{y>=340 and: y<=350} {~z1.close;~z25.close;~z1 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
			{y>=350 and: y<=360} {~z2.close;~z26.close;~z2 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
			{y>=360 and: y<=370} {~z3.close;~z27.close;~z3 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
			/*{y>=370 and: y<=380} {~z4.close;~z28.close;~z4 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
			{y>=380 and: y<=390} {~z5.close;~z29.close;~z5 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
			{y>=390 and: y<=400} {~z6.close;~z30.close;~z6 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
			{y>=400 and: y<=410} {~z7.close;~z31.close;~z7 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}*/
			/*{y>=410 and: y<=420} {~z8.close;~z32.close;~z8 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
			{y>=420 and: y<=430} {~z9.close;~z33.close;~z9 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
			{y>=430 and: y<=440} {~z10.close;~z34.close;~z10 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
			{y>=440 and: y<=450} {~z11.close;~z35.close;~z11 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
			{y>=450 and: y<=460} {~z12.close;~z36.close;~z12 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}*/;
			/*{y>=460 and: y<=470} {~z13.close;~z37.close;~z13 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
			{y>=470 and: y<=480} {~z14.close;~z38.close;~z14 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
			{y>=480 and: y<=490} {~z15.close;~z39.close;~z15 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
			{y>=490 and: y<=500} {~z16.close;~z40.close;~z16 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
			{y>=500 and: y<=510} {~z17.close;~z41.close;~z17 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
			{y>=510 and: y<=520} {~z18.close;~z42.close;~z18 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
			{y>=520 and: y<=530} {~z19.close;~z43.close;~z19 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
			{y>=530 and: y<=540} {~z20.close;~z44.close;~z20 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
			{y>=540 and: y<=550} {~z21.close;~z45.close;~z21 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
			{y>=550 and: y<=560} {~z22.close;~z46.close;~z22 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
			{y>=560 and: y<=570} {~z23.close;~z47.close;~z23 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)}
			{y>=570 and: y<=580} {~z24.close;~z48.close;~z24 = (CompositeView(w, Rect(x, y, ~nw, 2)).background = Color.white;)};
			*/
			w.refresh;

			case
		{~l1a.isRunning == true}{
				case
				{y<30} {nil}
				{y>=30 and: y<=40} {
					~l1a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
					~l1b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value);~f1=q.value;
					~l1c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
					~l1d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
					~l1e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
					~l1f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}
				{y>=40 and: y<=50} {
					~l2a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
					~l2b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value);~f2=q.value;
					~l2c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
					~l2d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
					~l2e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
					~l2f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}
				{y>=50 and: y<=60} {
					~l3a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
					~l3b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value);~f3=q.value;
					~l3c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
					~l3d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
					~l3e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
					~l3f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}
				/*{y>=60 and: y<=70} {
					~l4a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
					~l4b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value);~f4=q.value;
					~l4c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
					~l4d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
					~l4e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
					~l4f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}
				{y>=70 and: y<=80} {
					~l5a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
					~l5b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value);~f5=q.value;
					~l5c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
					~l5d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
					~l5e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
					~l5f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}
				{y>=80 and: y<=90} {
					~l6a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
					~l6b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value);~f6=q.value;
					~l6c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
					~l6d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
					~l6e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
					~l6f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}
				{y>=90 and: y<=100} {
					~l7a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
					~l7b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value);~f7=q.value;
					~l7c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
					~l7d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
					~l7e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
					~l7f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}*/
				/*{y>=100 and: y<=110} {
				~l8a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
				~l8b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value);~f8=q.value;
				~l8c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
				~l8d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
				~l8e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
				~l8f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}
				{y>=110 and: y<=120} {
				~l9a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
				~l9b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value);~f9=q.value;
				~l9c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
				~l9d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
				~l9e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
				~l9f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}
				{y>=120 and: y<=130} {
				~l10a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
				~l10b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value);~f10=q.value;
				~l10c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
				~l10d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
				~l10e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
				~l10f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}
				{y>=130 and: y<=140} {
				~l11a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
				~l11b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value);~f11=q.value;
				~l11c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
				~l11d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
				~l11e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
				~l11f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}
				{y>=140 and: y<=150} {
				~l12a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
				~l12b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value);~f12=q.value;
				~l12c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
				~l12d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
				~l12e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
				~l12f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}*/
				/*{y>=110 and: y<=120} {
				{y>=120 and: y<=130} {
				{y>=130 and: y<=140} {
				{y>=140 and: y<=150} {
				{y>=150 and: y<=160} {
				{y>=160 and: y<=170} {
				{y>=170 and: y<=180} {
				{y>=180 and: y<=190} {
				{y>=190 and: y<=200} {
				{y>=200 and: y<=210} {
				{y>=210 and: y<=220} {
				{y>=220 and: y<=230} {
				{y>=230 and: y<=240} {
				{y>=240 and: y<=250} {
				{y>=250 and: y<=260} {*/
				/*{y>=260 and: y<=270} {
				~l8e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
				~l8f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value);~f24=q.value;}*/
				{y>100 and: y<340} {nil}
				{y>=340 and: y<=350} {
					~l1a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
					~l1b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f1=q.value;
					~l1c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
					~l1d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
					~l1e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
					~l1f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);}
				{y>=350 and: y<=360} {
					~l2a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
					~l2b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f2=q.value;
					~l2c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
					~l2d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
					~l2e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
					~l2f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);}
				{y>=360 and: y<=370} {
					~l3a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
					~l3b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f3=q.value;
					~l3c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
					~l3d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
					~l3e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
					~l3f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);}
				/*{y>=370 and: y<=380} {
					~l4a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
					~l4b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f4=q.value;
					~l4c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
					~l4d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
					~l4e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
					~l4f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);}
				{y>=380 and: y<=390} {
					~l5a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
					~l5b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f5=q.value;
					~l5c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
					~l5d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
					~l5e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
					~l5f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);}
				{y>=390 and: y<=400} {
					~l6a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
					~l6b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f6=q.value;
					~l6c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
					~l6d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
					~l6e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
					~l6f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);}
				{y>=400 and: y<=410} {
					~l7a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
					~l7b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f7=q.value;
					~l7c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
					~l7d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
					~l7e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
					~l7f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);}*/;
				/*{y>=410 and: y<=420} {
				~l8a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l8b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f8=q.value;
				~l8c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
				~l8d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
				~l8e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
				~l8f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);}
				{y>=420 and: y<=430} {
				~l9a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l9b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f9=q.value;
				~l9c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
				~l9d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
				~l9e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
				~l9f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);}
				{y>=430 and: y<=440} {
				~l10a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l10b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f10=q.value;
				~l10c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
				~l10d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
				~l10e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
				~l10f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);}
				{y>=440 and: y<=450} {
				~l11a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l11b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f11=q.value;
				~l11c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
				~l11d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
				~l11e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
				~l11f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);}
				{y>=450 and: y<=460} {
				~l12a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l12b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f12=q.value;
				~l12c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
				~l12d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
				~l12e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
				~l12f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);};*/
				/*{y>=460 and: y<=470} {
				~l5a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l5b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f5=q.value;}
				{y>=470 and: y<=480} {
				~l5c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l5d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f14=q.value;}
				{y>=480 and: y<=490} {
				~l5e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l5f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f15=q.value;}
				{y>=490 and: y<=500} {
				~l6a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l6b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f6=q.value;}
				{y>=500 and: y<=510} {
				~l6c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l6d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f17=q.value;}
				{y>=510 and: y<=520} {
				~l6e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l6f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f18=q.value;}
				{y>=520 and: y<=530} {
				~l7a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l7b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f7=q.value;}
				{y>=530 and: y<=540} {
				~l7c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l7d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f20=q.value;}
				{y>=540 and: y<=550} {
				~l7e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l7f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f21=q.value;}
				{y>=550 and: y<=560} {
				~l8a.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l8b.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f8=q.value;}
				{y>=460 and: y<=570} {
				~l8c.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l8d.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f23=q.value;}
				{y>=570 and: y<=580} {
				~l8e.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l8f.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f24=q.value;};*/
					}
					{~l1a1.isRunning == true}{
				case
				{y<30} {nil}
				{y>=30 and: y<=40} {
					~l1a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
					~l1b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value);~f1=q.value;
					~l1c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
					~l1d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
					~l1e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
					~l1f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}
				{y>=40 and: y<=50} {
					~l2a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
					~l2b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value);~f2=q.value;
					~l2c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
					~l2d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
					~l2e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
					~l2f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}
				{y>=50 and: y<=60} {
					~l3a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
					~l3b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value);~f3=q.value;
					~l3c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
					~l3d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
					~l3e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
					~l3f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}
				/*{y>=60 and: y<=70} {
					~l4a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
					~l4b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value);~f4=q.value;
					~l4c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
					~l4d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
					~l4e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
					~l4f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}
				{y>=70 and: y<=80} {
					~l5a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
					~l5b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value);~f5=q.value;
					~l5c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
					~l5d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
					~l5e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
					~l5f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}
				{y>=80 and: y<=90} {
					~l6a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
					~l6b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value);~f6=q.value;
					~l6c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
					~l6d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
					~l6e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
					~l6f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}
				{y>=90 and: y<=100} {
					~l7a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
					~l7b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value);~f7=q.value;
					~l7c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
					~l7d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
					~l7e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
					~l7f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}*/
				/*{y>=100 and: y<=110} {
				~l8a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
				~l8b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value);~f8=q.value;
				~l8c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
				~l8d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
				~l8e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
				~l8f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}
				{y>=110 and: y<=120} {
				~l9a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
				~l9b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value);~f9=q.value;
				~l9c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
				~l9d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
				~l9e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
				~l9f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}
				{y>=120 and: y<=130} {
				~l10a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
				~l10b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value);~f10=q.value;
				~l10c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
				~l10d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
				~l10e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
				~l10f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}
				{y>=130 and: y<=140} {
				~l11a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
				~l11b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value);~f11=q.value;
				~l11c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
				~l11d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
				~l11e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
				~l11f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}
				{y>=140 and: y<=150} {
				~l12a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
				~l12b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value);~f12=q.value;
				~l12c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd3);
				~l12d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd3);
				~l12e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1))/~icd6);
				~l12f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value/~icd6);}*/
				/*{y>=110 and: y<=120} {
				{y>=120 and: y<=130} {
				{y>=130 and: y<=140} {
				{y>=140 and: y<=150} {
				{y>=150 and: y<=160} {
				{y>=160 and: y<=170} {
				{y>=170 and: y<=180} {
				{y>=180 and: y<=190} {
				{y>=190 and: y<=200} {
				{y>=200 and: y<=210} {
				{y>=210 and: y<=220} {
				{y>=220 and: y<=230} {
				{y>=230 and: y<=240} {
				{y>=240 and: y<=250} {
				{y>=250 and: y<=260} {*/
				/*{y>=260 and: y<=270} {
				~l8e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)));
				~l8f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin1,~outmax1)).value);~f24=q.value;}*/
				{y>100 and: y<340} {nil}
				{y>=340 and: y<=350} {
					~l1a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
					~l1b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f1=q.value;
					~l1c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
					~l1d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
					~l1e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
					~l1f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);}
				{y>=350 and: y<=360} {
					~l2a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
					~l2b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f2=q.value;
					~l2c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
					~l2d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
					~l2e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
					~l2f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);}
				{y>=360 and: y<=370} {
					~l3a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
					~l3b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f3=q.value;
					~l3c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
					~l3d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
					~l3e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
					~l3f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);}
				/*{y>=370 and: y<=380} {
					~l4a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
					~l4b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f4=q.value;
					~l4c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
					~l4d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
					~l4e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
					~l4f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);}
				{y>=380 and: y<=390} {
					~l5a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
					~l5b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f5=q.value;
					~l5c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
					~l5d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
					~l5e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
					~l5f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);}
				{y>=390 and: y<=400} {
					~l6a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
					~l6b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f6=q.value;
					~l6c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
					~l6d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
					~l6e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
					~l6f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);}
				{y>=400 and: y<=410} {
					~l7a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
					~l7b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f7=q.value;
					~l7c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
					~l7d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
					~l7e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
					~l7f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);}*/;
				/*{y>=410 and: y<=420} {
				~l8a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l8b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f8=q.value;
				~l8c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
				~l8d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
				~l8e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
				~l8f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);}
				{y>=420 and: y<=430} {
				~l9a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l9b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f9=q.value;
				~l9c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
				~l9d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
				~l9e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
				~l9f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);}
				{y>=430 and: y<=440} {
				~l10a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l10b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f10=q.value;
				~l10c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
				~l10d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
				~l10e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
				~l10f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);}
				{y>=440 and: y<=450} {
				~l11a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l11b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f11=q.value;
				~l11c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
				~l11d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
				~l11e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
				~l11f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);}
				{y>=450 and: y<=460} {
				~l12a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l12b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f12=q.value;
				~l12c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd3);
				~l12d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd3);
				~l12e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2))/~icd6);
				~l12f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value/~icd6);};*/
				/*{y>=460 and: y<=470} {
				~l5a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l5b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f5=q.value;}
				{y>=470 and: y<=480} {
				~l5c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l5d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f14=q.value;}
				{y>=480 and: y<=490} {
				~l5e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l5f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f15=q.value;}
				{y>=490 and: y<=500} {
				~l6a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l6b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f6=q.value;}
				{y>=500 and: y<=510} {
				~l6c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l6d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f17=q.value;}
				{y>=510 and: y<=520} {
				~l6e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l6f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f18=q.value;}
				{y>=520 and: y<=530} {
				~l7a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l7b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f7=q.value;}
				{y>=530 and: y<=540} {
				~l7c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l7d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f20=q.value;}
				{y>=540 and: y<=550} {
				~l7e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l7f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f21=q.value;}
				{y>=550 and: y<=560} {
				~l8a1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l8b1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f8=q.value;}
				{y>=460 and: y<=570} {
				~l8c1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l8d1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f23=q.value;}
				{y>=570 and: y<=580} {
				~l8e1.set(\dur, ((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)));
				~l8f1.set(\dur, q=((x/(Window.screenBounds.width)).linexp(0,1,~outmin2,~outmax2)).value);~f24=q.value;};*/
			};
		};

		~bpl = Window.screenBounds.width-340;
		~bpt = Window.screenBounds.height-88;
		~bph = 40;
		~bpw = 40/1.61803398875;

			b = Button.new(w,Rect(Window.screenBounds.width*0+80,Window.screenBounds.height-52,60,60/1.61803398875)).states_([["copy",Color.white,Color.black],["copy",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button;
			if(button.value == 1, {

				~tsc = TextView(w, Rect(0,0, 1600*2, 354)).background_(Color.black);
				(~tsc.string =
					"saved: "++"\n"++
					"1: "++"\n"++"[~f1="++fp1.asString++",~f2="++fp2.asString++",~f3="++fp3.asString++"]"++"\n"++
					"2: "++"\n"++"[~f1="++fp1b.asString++",~f2="++fp2b.asString++",~f3="++fp3b.asString++"]"++"\n"++
					"3: "++"\n"++"[~f1="++fp1c.asString++",~f2="++fp2c.asString++",~f3="++fp3c.asString++"]"++"\n"++
					"4: "++"\n"++"[~f1="++fp1d.asString++",~f2="++fp2d.asString++",~f3="++fp3d.asString++"]"++"\n"++
					"5: "++"\n"++"[~f1="++fp1e.asString++",~f2="++fp2e.asString++",~f3="++fp3e.asString++"]"++"\n"++
					"6: "++"\n"++"[~f1="++fp1f.asString++",~f2="++fp2f.asString++",~f3="++fp3f.asString++"]"++"\n"++
					"7: "++"\n"++"[~f1="++fp1g.asString++",~f2="++fp2g.asString++",~f3="++fp3g.asString++"]"++"\n"++
					"8: "++"\n"++"[~f1="++fp1h.asString++",~f2="++fp2h.asString++",~f3="++fp3h.asString++"]"++"\n"++"\n"++

						"current: "++"\n"++
					"[~f1="++~f1.asString++",~f2="++~f2.asString++",~f3="++~f3.asString++"]"

					/*"(([~l1a,~l1b,~l1c,~l1d,~l1e,~l1f,~l2a,~l2b,~l2c,~l2d,~l2e,~l2f,~l3a,~l3b,~l3c,~l3d,~l3e,~l3f/*,~l4a,~l4b,~l4c,~l4d,~l4e,~l4f,~l5a,~l5b,~l5c,~l5d,~l5e,~l5f,~l6a,~l6b,~l6c,~l6d,~l6e,~l6f,~l7a,~l7b,~l7c,~l7d,~l7e,~l7f*//*,~l8a,~l8b,~l8c,~l8d,~l8e,~l8f,~l9a,~l9b,~l9c,~l9d,~l9e,~l9f,~l10a,~l10b,~l10c,~l10d,~l10e,~l10f,~l11a,~l11b,~l11c,~l11d,~l11e,~l11f,~l12a,~l12b,~l12c,~l12d,~l12e,~l12f*/].do(_.free)); ~slideroutine.stop;~icl6=ParGroup.new;~icl61=ParGroup.new;~icl62=ParGroup.new;~icl63=ParGroup.new;1.do({var a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,fs,rs,vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8,vol9,vol10,vol11,vol12,s1,s2,s3,s4,s5,s6,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,f19,f20,f21,f22,f23,f24,fs1,fs2,fs3,fs4,fs5,fs6,fd1,fd2,fd3,fd4,fd5,fd6,tune=0;#s1,s2 = [\gsineicfld, \gsineicrld];#vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8,vol9,vol10,vol11,vol12 = [~vol1,~vol2,~vol3,~vol4,~vol5,~vol6,~vol7,~vol8,~vol9,~vol10,~vol11,~vol12];"++"\n" ++
					"#f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12 = "++str++";~l1a = Synth(s1, [\dur, f1, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol1, \tune, tune],~icl6);~l1b = Synth(s2, [\dur, f1, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol1, \tune, tune],~icl6);~l1c = Synth(s1, [\dur, f1/3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol1, \tune, tune],    ~icl6);~l1d = Synth(s2, [\dur, f1/3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol1, \tune, tune],~icl6);~l1e = Synth(s1, [\dur, f1/6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol1, \tune, tune],    ~icl6);~l1f = Synth(s2, [\dur, f1/6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol1, \tune, tune],~icl6);~l2a = Synth(s1, [\dur, f2, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol2, \tune, tune],~icl6);~l2b = Synth(s2, [\dur, f2, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol2, \tune, tune],~icl6);~l2c = Synth(s1, [\dur, f2/3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol2, \tune, tune],    ~icl6);~l2d = Synth(s2, [\dur, f2/3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol2, \tune, tune],~icl6);~l2e = Synth(s1, [\dur, f2/6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol2, \tune, tune],    ~icl6);~l2f = Synth(s2, [\dur, f2/6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol2, \tune, tune],~icl6);~l3a = Synth(s1, [\dur, f3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol3, \tune, tune],~icl6);~l3b = Synth(s2, [\dur, f3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,  \vol, vol3, \tune, tune],~icl6);~l3c = Synth(s1, [\dur, f3/3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol3, \tune, tune],    ~icl6);~l3d = Synth(s2, [\dur, f3/3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,\vol, vol3, \tune, tune],~icl6);~l3e = Synth(s1, [\dur, f3/6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol3, \tune, tune],    ~icl6);~l3f = Synth(s2, [\dur, f3/6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,\vol, vol3, \tune, tune],~icl6);~l4a = Synth(s1, [\dur, f4, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol4, \tune, tune],~icl61);~l4b = Synth(s2, [\dur, f4, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,  \vol, vol4, \tune, tune],~icl61);~l4c = Synth(s1, [\dur, f4/3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol4, \tune, tune],    ~icl61);~l4d = Synth(s2, [\dur, f4/3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,\vol, vol4, \tune, tune],~icl61);~l4e = Synth(s1, [\dur, f4/6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol4, \tune, tune],~icl61);~l4f = Synth(s2, [\dur, f4/6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,\vol, vol4, \tune, tune],~icl61);~l5a = Synth(s1, [\dur, f5, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol5, \tune, tune],~icl61);~l5b = Synth(s2, [\dur, f5, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,  \vol, vol5, \tune, tune],~icl61);~l5c = Synth(s1, [\dur, f5/3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol5, \tune, tune],~icl61);~l5d = Synth(s2, [\dur, f5/3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,\vol, vol5, \tune, tune],~icl61);~l5e = Synth(s1, [\dur, f5/6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol5, \tune, tune],~icl61);~l5f = Synth(s2, [\dur, f5/6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,\vol, vol5, \tune, tune],~icl61);~l6a = Synth(s1, [\dur, f6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol6, \tune, tune],~icl61);~l6b = Synth(s2, [\dur, f6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,  \vol, vol6, \tune, tune],~icl61);~l6c = Synth(s1, [\dur, f6/3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol6, \tune, tune],~icl61);~l6d = Synth(s2, [\dur, f6/3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,\vol, vol6, \tune, tune],~icl61);~l6e = Synth(s1, [\dur, f6/6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol6, \tune, tune],~icl61);~l6f = Synth(s2, [\dur, f6/6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,\vol, vol6, \tune, tune],~icl61);~l7a = Synth(s1, [\dur, f7, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol7, \tune, tune],~icl62);~l7b = Synth(s2, [\dur, f7, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,  \vol, vol7, \tune, tune],~icl62);~l7c = Synth(s1, [\dur, f7/3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol7, \tune, tune],~icl62);~l7d = Synth(s2, [\dur, f7/3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,\vol, vol7, \tune, tune],~icl62);~l7e = Synth(s1, [\dur, f7/6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol7, \tune, tune],~icl62);~l7f = Synth(s2, [\dur, f7/6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,\vol, vol7, \tune, tune],~icl62);~l8a = Synth(s1, [\dur, f8, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol8, \tune, tune],~icl62);~l8b = Synth(s2, [\dur, f8, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,  \vol, vol8, \tune, tune],~icl62);~l8c = Synth(s1, [\dur, f8/3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol8, \tune, tune],~icl62);~l8d = Synth(s2, [\dur, f8/3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,\vol, vol8, \tune, tune],~icl62);~l8e = Synth(s1, [\dur, f8/6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol8, \tune, tune],~icl62);~l8f = Synth(s2, [\dur, f8/6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,\vol, vol8, \tune, tune],~icl62);~l9a = Synth(s1, [\dur, f9, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol9, \tune, tune],~icl62);~l9b = Synth(s2, [\dur, f9, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,  \vol, vol9, \tune, tune],~icl62);~l9c = Synth(s1, [\dur, f9/3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol9, \tune, tune],~icl62);~l9d = Synth(s2, [\dur, f9/3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,\vol, vol9, \tune, tune],~icl62);~l9e = Synth(s1, [\dur, f9/6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol9, \tune, tune],~icl62);~l9f = Synth(s2, [\dur, f9/6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,\vol, vol9, \tune, tune],~icl62);~l10a = Synth(s1, [\dur, f10, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol10, \tune, tune],~icl63);~l10b = Synth(s2, [\dur, f10, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,\vol, vol10, \tune, tune],~icl63);~l10c = Synth(s1, [\dur, f10/3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol10, \tune, tune],~icl63);~l10d = Synth(s2, [\dur, f10/3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol10, \tune, tune],~icl63);~l10e = Synth(s1, [\dur, f10/6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol10, \tune, tune],~icl63);~l10f = Synth(s2, [\dur, f10/6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol10, \tune, tune],~icl63);~l11a = Synth(s1, [\dur, f11, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol11, \tune, tune],~icl63);~l11b = Synth(s2, [\dur, f11, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol11, \tune, tune],~icl63);~l11c = Synth(s1, [\dur, f11/3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol11, \tune, tune],~icl63);~l11d = Synth(s2, [\dur, f11/3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol11, \tune, tune],~icl63);~l11e = Synth(s1, [\dur, f11/6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol11, \tune, tune],~icl63);~l11f = Synth(s2, [\dur, f11/6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol11, \tune, tune],~icl63);~l12a = Synth(s1, [\dur, f12, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol12, \tune, tune],~icl63);~l12b = Synth(s2, [\dur, f12, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol12, \tune, tune],~icl63);~l12c = Synth(s1, [\dur, f12/3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol12, \tune, tune],~icl63);~l12d = Synth(s2, [\dur, f12/3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol12, \tune, tune],~icl63);~l12e = Synth(s1, [\dur, f12/6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol12, \tune, tune],~icl63);~l12f = Synth(s2, [\dur, f12/6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol12, \tune, tune],~icl63);"++"\n" ++
					"}));"++"\n" ++
					"\n" ++
					"2.wait; ~st = ~st + 1; ~st.postln;"++"\n" ++
					"\n" ++
					"\n" ++
					"(1.do({var a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,fs,rs,vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8,vol9,vol10,vol11,vol12,s1,s2,s3,s4,s5,s6,f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,f19,f20,f21,f22,f23,f24,fs1,fs2,fs3,fs4,fs5,fs6,fd1,fd2,fd3,fd4,fd5,fd6,tune=0;#vol1,vol2,vol3,vol4,vol5,vol6,vol7,vol8,vol9,vol10,vol11,vol12 = [~vol1,~vol2,~vol3,~vol4,~vol5,~vol6,~vol7,~vol8,~vol9,~vol10,~vol11,~vol12];"++"\n" ++
					"#f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12 ="++str++"; ~l1a.set(\dur, f1, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,    \vol, vol1, \tune, tune);  ~l1b.set(\dur, f1, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol1, \tune, tune);~l1c.set(\dur, f1/3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol1, \tune, tune);~l1d.set(\dur, f1/3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol1, \tune, tune);~l1e.set(\dur, f1/6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol1, \tune, tune);~l1f.set(\dur, f1/6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol1, \tune, tune);~l2a.set(\dur, f2, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,    \vol, vol2, \tune, tune);  ~l2b.set(\dur, f2, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol2, \tune, tune);~l2c.set(\dur, f2/3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol2, \tune, tune);~l2d.set(\dur, f2/3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol2, \tune, tune);~l2e.set(\dur, f2/6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol2, \tune, tune);~l2f.set(\dur, f2/6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol2, \tune, tune);~l3a.set(\dur, f3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,    \vol, vol3, \tune, tune);  ~l3b.set(\dur, f3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol3, \tune, tune);~l3c.set(\dur, f3/3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol3, \tune, tune);~l3d.set(\dur, f3/3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol3, \tune, tune);~l3e.set(\dur, f3/6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol3, \tune, tune);~l3f.set(\dur, f3/6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol3, \tune, tune);~l4a.set(\dur, f4, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol4, \tune, tune);  ~l4b.set(\dur, f4, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol4, \tune, tune);~l4c.set(\dur, f4/3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol4, \tune, tune);~l4d.set(\dur, f4/3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol4, \tune, tune);~l4e.set(\dur, f4/6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol4, \tune, tune);~l4f.set(\dur, f4/6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol4, \tune, tune);~l5a.set(\dur, f5, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol5, \tune, tune);  ~l5b.set(\dur, f5, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol5, \tune, tune);~l5c.set(\dur, f5/3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol5, \tune, tune);~l5d.set(\dur, f5/3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol5, \tune, tune);~l5e.set(\dur, f5/6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol5, \tune, tune);~l5f.set(\dur, f5/6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol5, \tune, tune);~l6a.set(\dur, f6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol6, \tune, tune);  ~l6b.set(\dur, f6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol6, \tune, tune);~l6c.set(\dur, f6/3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol6, \tune, tune);~l6d.set(\dur, f6/3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol6, \tune, tune);~l6e.set(\dur, f6/6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol6, \tune, tune);~l6f.set(\dur, f6/6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol6, \tune, tune);~l7a.set(\dur, f7, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol7, \tune, tune);  ~l7b.set(\dur, f7, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol7, \tune, tune);~l7c.set(\dur, f7/3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol7, \tune, tune);~l7d.set(\dur, f7/3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol7, \tune, tune);~l7e.set(\dur, f7/6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol7, \tune, tune);~l7f.set(\dur, f7/6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol7, \tune, tune);~l8a.set(\dur, f8, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol8, \tune, tune);  ~l8b.set(\dur, f8, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol8, \tune, tune);~l8c.set(\dur, f8/3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol8, \tune, tune);~l8d.set(\dur, f8/3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol8, \tune, tune);~l8e.set(\dur, f8/6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol8, \tune, tune);~l8f.set(\dur, f8/6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol8, \tune, tune);~l9a.set(\dur, f9, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,   \vol, vol9,  \tune, tune);  ~l9b.set(\dur, f9, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol9, \tune, tune);~l9c.set(\dur, f9/3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol9,  \tune, tune);~l9d.set(\dur, f9/3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol9, \tune, tune);~l9e.set(\dur, f9/6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,      \vol, vol9,  \tune, tune);~l9f.set(\dur, f9/6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol9, \tune, tune);~l10a.set(\dur, f10, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol10,  \tune, tune);~l10b.set(\dur, f10, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol10, \tune, tune);~l10c.set(\dur, f10/3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,    \vol, vol10,  \tune, tune);~l10d.set(\dur, f10/3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol10, \tune, tune);~l10e.set(\dur, f10/6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,    \vol, vol10,  \tune, tune);~l10f.set(\dur, f10/6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol10, \tune, tune);~l11a.set(\dur, f11, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol11,  \tune, tune);  ~l11b.set(\dur, f11, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol11, \tune, tune);~l11c.set(\dur, f11/3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,    \vol, vol11,  \tune, tune);~l11d.set(\dur, f11/3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol11, \tune, tune);~l11e.set(\dur, f11/6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,    \vol, vol11,  \tune, tune);~l11f.set(\dur, f11/6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol11, \tune, tune);~l12a.set(\dur, f12, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol12,  \tune, tune);  ~l12b.set(\dur, f12, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol12, \tune, tune);~l12c.set(\dur, f12/3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,    \vol, vol12,  \tune, tune);~l12d.set(\dur, f12/3, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol12, \tune, tune);~l12e.set(\dur, f12/6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f,    \vol, vol12,  \tune, tune);~l12f.set(\dur, f12/6, \a, a, \b, b, \c, c, \d, d, \e, e, \f, f, \vol, vol12, \tune, tune);"++"\n" ++
					"}));"++"\n" ++
					"\n" ++
					"2.wait; ~st = ~st + 1; ~st.postln;"*/
				);
				~tsc.stringColor = Color.white;
				(str= [ ~f1,~f2,~f3/*,~f4,~f5,~f6,~f7*//*,~f8,~f9,~f10,~f11,~f12*/ ];("echo"+str+"| xclip -selection clipboard").unixCmd;);
				[ ~f1,~f2,~f3/*,~f4,~f5,~f6,~f7*//*,~f8,~f9,~f10,~f11,~f12*/ ].postln;},
				{~tsc.close;});
		});
		sts = Button.new(w,Rect(Window.screenBounds.width-20-20-20-20,~bpt+69,20,20/1.61803398875)).states_([["ts",Color.white,Color.black],["ts",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button;
			if(~tst.value == nil, {nil},{~tst.close;
				~timevals.value;
				~timer.stop; ~systemclock.stop; ~systemclock.clear;});
		});
		~ts = Button.new(w,Rect(Window.screenBounds.width*0+20,Window.screenBounds.height-52,60,60/1.61803398875)).states_([["tsynth0",Color.white,Color.black],["tsynth1",Color.white,Color.black]]).action_({arg synthbutton; synthbutton.value.postln}).action_({arg synthbutton; if(synthbutton.value == 1, {
			~tst.close;
			~timevals.value;
			~timer.stop; ~systemclock.stop; ~systemclock.clear;},{if(~tst.value == nil, {nil},{~tst.close;})})});
		b3 = Button.new(w,Rect(Window.screenBounds.width*0+20,Window.screenBounds.height-88,60,60/1.61803398875)).states_([["synth0",Color.white,Color.black],["synth1",Color.white,Color.black]]).action_({arg synthbutton; synthbutton.value.postln}).action_({
				arg synthbutton; if(synthbutton.value == 1, {
					~l1a = Synth(\gsineicfld, [\dur, 432],~icl6).register;~l1a1 = Synth(\gsineicfld, [\dur, 432],~icl6).register;[~l1a, ~l1a1].do(_.free);~l1a = Synth(\gsineicfld, [\dur, 432],~icl6).register;~l1a1 = Synth(\gsineicfld, [\dur, 432],~icl6).register;[~l1a, ~l1a1].do(_.free);
					~synthopen.value;
					},
			{~synthfree.value;})
			});
		b4 = Button.new(w,Rect(Window.screenBounds.width*0+80,Window.screenBounds.height-88,60,60/1.61803398875)).states_([["pause0",Color.white,Color.black],["pause1",Color.white,Color.black]]).action_({arg synthbutton; synthbutton.value.postln}).action_({
				arg synthbutton; if(synthbutton.value == 1, {~synthpause.value; ~timer.stop;},
			{~synthflow.value; if(~time == 0, {~timer.stop;}, {~timer = Routine({inf.do({~time = ~time+0.01; ~time.postln; 0.01.wait;});}); SystemClock.play(~timer);})})
			});

		~bph = 26;
		~bpw = 26/1.61803398875;
		~bpl = Window.screenBounds.width-(~bph*8)-20;
		~bpt = Window.screenBounds.height-88;

		~bp01l = ~bpl;
		~bp02l = ~bpl+~bph;
		~bp03l = ~bpl+~bph+~bph;
		~bp04l = ~bpl+~bph+~bph+~bph;
		~bp05l = ~bpl+~bph+~bph+~bph+~bph;
		~bp06l = ~bpl+~bph+~bph+~bph+~bph+~bph;
		~bp07l = ~bpl+~bph+~bph+~bph+~bph+~bph+~bph;
		~bp08l = ~bpl+~bph+~bph+~bph+~bph+~bph+~bph+~bph;
		~bpf1l = ~bpl;
		~bpf2l = ~bpl+~bph;
		~bpf3l = ~bpl+~bph+~bph;
		~bpf4l = ~bpl+~bph+~bph+~bph;
		~bpf5l = ~bpl+~bph+~bph+~bph+~bph;
		~bpf6l = ~bpl+~bph+~bph+~bph+~bph+~bph;
		~bpf7l = ~bpl+~bph+~bph+~bph+~bph+~bph+~bph;
		~bpf8l = ~bpl+~bph+~bph+~bph+~bph+~bph+~bph+~bph;
		/*~bp01l = ~bpl;
		~bp02l = ~bpl;
		~bp03l = ~bpl+~bph;
		~bp04l = ~bpl+~bph;
		~bp05l = ~bpl+~bph+~bph;
		~bp06l = ~bpl+~bph+~bph;
		~bp07l = ~bpl+~bph+~bph+~bph;
		~bp08l = ~bpl+~bph+~bph+~bph;
		~bpf1l = ~bpl+~bph+~bph+~bph+~bph;
		~bpf2l = ~bpl+~bph+~bph+~bph+~bph;
		~bpf3l = ~bpl+~bph+~bph+~bph+~bph+~bph;
		~bpf4l = ~bpl+~bph+~bph+~bph+~bph+~bph;
		~bpf5l = ~bpl+~bph+~bph+~bph+~bph+~bph+~bph;
		~bpf6l = ~bpl+~bph+~bph+~bph+~bph+~bph+~bph;
		~bpf7l = ~bpl+~bph+~bph+~bph+~bph+~bph+~bph+~bph;
		~bpf8l = ~bpl+~bph+~bph+~bph+~bph+~bph+~bph+~bph;*/

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
		/*~bp01t = ~bpt;
		~bp02t = ~bpt+~bpw;
		~bp03t = ~bpt;
		~bp04t = ~bpt+~bpw;
		~bp05t = ~bpt;
		~bp06t = ~bpt+~bpw;
		~bp07t = ~bpt;
		~bp08t = ~bpt+~bpw;
		~bpf1t = ~bpt;
		~bpf2t = ~bpt+~bpw;
		~bpf3t = ~bpt;
		~bpf4t = ~bpt+~bpw;
		~bpf5t = ~bpt;
		~bpf6t = ~bpt+~bpw;
		~bpf7t = ~bpt;
		~bpf8t = ~bpt+~bpw;*/

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

		~tspw=280+190;
		~tsph=280+190/~gm;
		~tspl=Window.screenBounds.width-~tspw;
		~tspt=~bpt-310;

		bplaceo1 = Button.new(w,Rect(~bp01l,~bp01t,~bp01h,~bp01w)).states_([["o1",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button;

			if(~ts.value == 1,
				{if(~tst == nil, {nil}, {~tst.close;});
					~timevals.value;
					~timer.stop; ~systemclock.stop; ~systemclock.clear; ~time1o = 0;
					~timer = Routine({inf.do({
							~time1o =
							~time1o+0.01;
							~time1o.postString; 0.01.wait;});}); ~systemclock = SystemClock.play(~timer);},
				{nil});

				[~f1=fp1,~f2=fp2,~f3=fp3,~f4=fp4,~f5=fp5,~f6=fp6,~f7=fp7];

				~synthopen.value;
		});

		bplaceo2 = Button.new(w,Rect(~bp02l,~bp02t,~bp02h,~bp02w)).states_([["o2",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button;

			if(~ts.value == 1,
				{if(~tst == nil, {nil}, {~tst.close;});
					~timevals.value;
					~timer.stop; ~systemclock.stop; ~systemclock.clear; ~time2o = 0;
					~timer = Routine({inf.do({
						~time2o =
						~time2o+0.01;
						~time2o.postString; 0.01.wait;});}); ~systemclock = SystemClock.play(~timer);},
				{nil});

			[~f1=fp1b,~f2=fp2b,~f3=fp3b,~f4=fp4b,~f5=fp5b,~f6=fp6b,~f7=fp7b];

				~synthopen.value;
		});
		bplaceo3 = Button.new(w,Rect(~bp03l,~bp03t,~bp03h,~bp03w)).states_([["o3",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button;

			if(~ts.value == 1,
				{if(~tst == nil, {nil}, {~tst.close;});
					~timevals.value;
					~timer.stop; ~systemclock.stop; ~systemclock.clear; ~time3o = 0;
					~timer = Routine({inf.do({
						~time3o =
						~time3o+0.01;
						~time3o.postString; 0.01.wait;});}); ~systemclock = SystemClock.play(~timer);},
				{nil});

			[~f1=fp1c,~f2=fp2c,~f3=fp3c,~f4=fp4c,~f5=fp5c,~f6=fp6c,~f7=fp7c];

				~synthopen.value;
		});
		bplaceo4 = Button.new(w,Rect(~bp04l,~bp04t,~bp04h,~bp04w)).states_([["o4",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button;

			if(~ts.value == 1,
				{if(~tst == nil, {nil}, {~tst.close;});
					~timevals.value;
					~timer.stop; ~systemclock.stop; ~systemclock.clear; ~time4o = 0;
					~timer = Routine({inf.do({
						~time4o =
						~time4o+0.01;
						~time4o.postString; 0.01.wait;});}); ~systemclock = SystemClock.play(~timer);},
				{nil});

			[~f1=fp1d,~f2=fp2d,~f3=fp3d,~f4=fp4d,~f5=fp5d,~f6=fp6d,~f7=fp7d];

				~synthopen.value;
		});

		bplaceo5 = Button.new(w,Rect(~bp05l,~bp05t,~bp05h,~bp05w)).states_([["o5",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button;

			if(~ts.value == 1,
				{if(~tst == nil, {nil}, {~tst.close;});
					~timevals.value;
					~timer.stop; ~systemclock.stop; ~systemclock.clear; ~time5o = 0;
					~timer = Routine({inf.do({
						~time5o =
						~time5o+0.01;
						~time5o.postString; 0.01.wait;});}); ~systemclock = SystemClock.play(~timer);},
				{nil});

			[~f1=fp1e,~f2=fp2e,~f3=fp3e,~f4=fp4e,~f5=fp5e,~f6=fp6e,~f7=fp7e];

				~synthopen.value;
		});
		bplaceo6 = Button.new(w,Rect(~bp06l,~bp06t,~bp06h,~bp06w)).states_([["o6",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button;

			if(~ts.value == 1,
				{if(~tst == nil, {nil}, {~tst.close;});
					~timevals.value;
					~timer.stop; ~systemclock.stop; ~systemclock.clear; ~time6o = 0;
					~timer = Routine({inf.do({
						~time6o =
						~time6o+0.01;
						~time6o.postString; 0.01.wait;});}); ~systemclock = SystemClock.play(~timer);},
				{nil});

			[~f1=fp1f,~f2=fp2f,~f3=fp3f,~f4=fp4f,~f5=fp5f,~f6=fp6f,~f7=fp7f];

				~synthopen.value;
		});
		bplaceo7 = Button.new(w,Rect(~bp07l,~bp07t,~bp07h,~bp07w)).states_([["o7",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button;

			if(~ts.value == 1,
				{if(~tst == nil, {nil}, {~tst.close;});
					~timevals.value;
					~timer.stop; ~systemclock.stop; ~systemclock.clear; ~time7o = 0;
					~timer = Routine({inf.do({
						~time7o =
						~time7o+0.01;
						~time7o.postString; 0.01.wait;});}); ~systemclock = SystemClock.play(~timer);},
				{nil});

			[~f1=fp1g,~f2=fp2g,~f3=fp3g,~f4=fp4g,~f5=fp5g,~f6=fp6g,~f7=fp7g];

				~synthopen.value;
		});
		bplaceo8 = Button.new(w,Rect(~bp08l,~bp08t,~bp08h,~bp08w)).states_([["o8",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button;

			if(~ts.value == 1,
				{if(~tst == nil, {nil}, {~tst.close;});
					~timevals.value;
					~timer.stop; ~systemclock.stop; ~systemclock.clear; ~time8o = 0;
					~timer = Routine({inf.do({
						~time8o =
						~time8o+0.01;
						~time8o.postString; 0.01.wait;});}); ~systemclock = SystemClock.play(~timer);},
				{nil});

			[~f1=fp1h,~f2=fp2h,~f3=fp3h,~f4=fp4h,~f5=fp5h,~f6=fp6h,~f7=fp7h];

				~synthopen.value;
		});
		bplacef1 = Button.new(w,Rect(~bpf1l,~bpf1t,~bpf1h,~bpf1w)).states_([["f1",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button;

			if(~ts.value == 1,
				{if(~tst == nil, {nil}, {~tst.close;});
					~timevals.value;
					~timer.stop; ~systemclock.stop; ~systemclock.clear; ~time1f = 0;
					~timer = Routine({inf.do({
						~time1f =
						~time1f+0.01;
						~time1f.postString; 0.01.wait;});}); ~systemclock = SystemClock.play(~timer);},
				{nil});

				[~f1=fp1,~f2=fp2,~f3=fp3,~f4=fp4,~f5=fp5,~f6=fp6,~f7=fp7];

				~synthflow.value;
		});
		bplacef2 = Button.new(w,Rect(~bpf2l,~bpf2t,~bpf2h,~bpf2w)).states_([["f2",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button;

			if(~ts.value == 1,
				{if(~tst == nil, {nil}, {~tst.close;});
					~timevals.value;
					~timer.stop; ~systemclock.stop; ~systemclock.clear; ~time2f = 0;
					~timer = Routine({inf.do({
						~time2f =
						~time2f+0.01;
						~time2f.postString; 0.01.wait;});}); ~systemclock = SystemClock.play(~timer);},
				{nil});

			[~f1=fp1b,~f2=fp2b,~f3=fp3b,~f4=fp4b,~f5=fp5b,~f6=fp6b,~f7=fp7b];

				~synthflow.value;
		});

		bplacef3 = Button.new(w,Rect(~bpf3l,~bpf3t,~bpf3h,~bpf3w)).states_([["f3",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button;

			if(~ts.value == 1,
				{if(~tst == nil, {nil}, {~tst.close;});
					~timevals.value;
					~timer.stop; ~systemclock.stop; ~systemclock.clear; ~time3f = 0;
					~timer = Routine({inf.do({
						~time3f =
						~time3f+0.01;
						~time3f.postString; 0.01.wait;});}); ~systemclock = SystemClock.play(~timer);},
				{nil});

			[~f1=fp1c,~f2=fp2c,~f3=fp3c,~f4=fp4c,~f5=fp5c,~f6=fp6c,~f7=fp7c];

				~synthflow.value;
		});
		bplacef4 = Button.new(w,Rect(~bpf4l,~bpf4t,~bpf4h,~bpf4w)).states_([["f4",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button;

			if(~ts.value == 1,
				{if(~tst == nil, {nil}, {~tst.close;});
					~timevals.value;
					~timer.stop; ~systemclock.stop; ~systemclock.clear; ~time4f = 0;
					~timer = Routine({inf.do({
						~time4f =
						~time4f+0.01;
						~time4f.postString; 0.01.wait;});}); ~systemclock = SystemClock.play(~timer);},
				{nil});

			[~f1=fp1d,~f2=fp2d,~f3=fp3d,~f4=fp4d,~f5=fp5d,~f6=fp6d,~f7=fp7d];

				~synthflow.value;
		});

		bplacef5 = Button.new(w,Rect(~bpf5l,~bpf5t,~bpf5h,~bpf5w)).states_([["f5",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button;

			if(~ts.value == 1,
				{if(~tst == nil, {nil}, {~tst.close;});
					~timevals.value;
					~timer.stop; ~systemclock.stop; ~systemclock.clear; ~time5f = 0;
					~timer = Routine({inf.do({
						~time5f =
						~time5f+0.01;
						~time5f.postString; 0.01.wait;});}); ~systemclock = SystemClock.play(~timer);},
				{nil});

			[~f1=fp1e,~f2=fp2e,~f3=fp3e,~f4=fp4e,~f5=fp5e,~f6=fp6e,~f7=fp7e];

				~synthflow.value;
		});

		bplacef6 = Button.new(w,Rect(~bpf6l,~bpf6t,~bpf6h,~bpf6w)).states_([["f6",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button;

			if(~ts.value == 1,
				{if(~tst == nil, {nil}, {~tst.close;});
					~timevals.value;
					~timer.stop; ~systemclock.stop; ~systemclock.clear; ~time6f = 0;
					~timer = Routine({inf.do({
						~time6f =
						~time6f+0.01;
						~time6f.postString; 0.01.wait;});}); ~systemclock = SystemClock.play(~timer);},
				{nil});

			[~f1=fp1f,~f2=fp2f,~f3=fp3f,~f4=fp4f,~f5=fp5f,~f6=fp6f,~f7=fp7f];

				~synthflow.value;
		});


		bplacef7 = Button.new(w,Rect(~bpf7l,~bpf7t,~bpf7h,~bpf7w)).states_([["f7",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button;

			if(~ts.value == 1,
				{if(~tst == nil, {nil}, {~tst.close;});
					~timevals.value;
					~timer.stop; ~systemclock.stop; ~systemclock.clear; ~time7f = 0;
					~timer = Routine({inf.do({
						~time7f =
						~time7f+0.01;
						~time7f.postString; 0.01.wait;});}); ~systemclock = SystemClock.play(~timer);},
				{nil});

			[~f1=fp1g,~f2=fp2g,~f3=fp3g,~f4=fp4g,~f5=fp5g,~f6=fp6g,~f7=fp7g];

				~synthflow.value;
		});
		bplacef8 = Button.new(w,Rect(~bpf8l,~bpf8t,~bpf8h,~bpf8w)).states_([["f8",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button;

			if(~ts.value == 1,
				{if(~tst == nil, {nil}, {~tst.close;});
					~timevals.value;
					~timer.stop; ~systemclock.stop; ~systemclock.clear; ~time8f = 0;
					~timer = Routine({inf.do({
						~time8f =
						~time8f+0.01;
						~time8f.postString; 0.01.wait;});}); ~systemclock = SystemClock.play(~timer);},
				{nil});

			[~f1=fp1h,~f2=fp2h,~f3=fp3h,~f4=fp4h,~f5=fp5h,~f6=fp6h,~f7=fp7h];

				~synthflow.value;
		});
			~bplaces1 = Button.new(w,Rect(~bpf1l,~bpf1t+~bpf1w,~bpf1h,~bpf1w)).states_([["s1",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button;

			if(~ts.value == 1,
				{if(~tst == nil, {nil}, {~tst.close;});
					~timevals.value;
					~timer.stop; ~systemclock.stop; ~systemclock.clear; ~time1s = 0;
					~timer = Routine({inf.do({
						~time1s =
						~time1s+0.01;
						~time1s.postString; 0.01.wait;});}); ~systemclock = SystemClock.play(~timer);},
				{nil});

			if(~slidetime1 == nil, {~slidetime1 = 4}); if(~slidedo1 == nil, {~slidedo1 = 2000;}); ~slidecount = ~slidedo1;
					#g,h,i,j,k,l,m,n,o,p,q,r = (([ ~f1,~f2,~f3,~f4,~f5,~f6,~f7 ]-
						[ fp1,fp2,fp3,fp4,fp5,fp6,fp7 ])*(-1)/~slidedo1);

				~slidetime =~slidetime1; ~slidedo = ~slidedo1;

				~slideroutine.stop;

				~synthslide.value;

		});
			~bplaces2 = Button.new(w,Rect(~bpf2l,~bpf2t+~bpf2w,~bpf2h,~bpf2w)).states_([["s2",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button;

			if(~ts.value == 1,
				{if(~tst == nil, {nil}, {~tst.close;});
					~timevals.value;
					~timer.stop; ~systemclock.stop; ~systemclock.clear; ~time2s = 0;
					~timer = Routine({inf.do({
						~time2s =
						~time2s+0.01;
						~time2s.postString; 0.01.wait;});}); ~systemclock = SystemClock.play(~timer);},
				{nil});


					if(~slidetime2 == nil, {~slidetime2 = 4}); if(~slidedo2 == nil, {~slidedo2 = 2000;}); ~slidecount = ~slidedo2;
					#g,h,i,j,k,l,m,n,o,p,q,r = (([ ~f1,~f2,~f3,~f4,~f5,~f6,~f7 ]-
						[ fp1b,fp2b,fp3b,fp4b,fp5b,fp6b,fp7b ])*(-1)/~slidedo2);

									~slidetime = ~slidetime2; ~slidedo = ~slidedo2;

				~slideroutine.stop;

					~synthslide.value;

		});
			~bplaces3 = Button.new(w,Rect(~bpf3l,~bpf3t+~bpf3w,~bpf3h,~bpf3w)).states_([["s3",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button;

			if(~ts.value == 1,
				{if(~tst == nil, {nil}, {~tst.close;});
					~timevals.value;
					~timer.stop; ~systemclock.stop; ~systemclock.clear; ~time3s = 0;
					~timer = Routine({inf.do({
						~time3s =
						~time3s+0.01;
						~time3s.postString; 0.01.wait;});}); ~systemclock = SystemClock.play(~timer);},
				{nil});


					if(~slidetime3 == nil, {~slidetime3 = 4}); if(~slidedo3 == nil, {~slidedo3 = 2000;}); ~slidecount = ~slidedo3;
					#g,h,i,j,k,l,m,n,o,p,q,r = (([ ~f1,~f2,~f3,~f4,~f5,~f6,~f7 ]-
						[ fp1c,fp2c,fp3c,fp4c,fp5c,fp6c,fp7c ])*(-1)/~slidedo3);

									~slidetime = ~slidetime3; ~slidedo = ~slidedo3;

				~slideroutine.stop;

					~synthslide.value;

		});
			~bplaces4 = Button.new(w,Rect(~bpf4l,~bpf4t+~bpf4w,~bpf4h,~bpf4w)).states_([["s4",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button;

			if(~ts.value == 1,
				{if(~tst == nil, {nil}, {~tst.close;});
					~timevals.value;
					~timer.stop; ~systemclock.stop; ~systemclock.clear; ~time4s = 0;
					~timer = Routine({inf.do({
						~time4s =
						~time4s+0.01;
						~time4s.postString; 0.01.wait;});}); ~systemclock = SystemClock.play(~timer);},
				{nil});


					if(~slidetime4 == nil, {~slidetime4 = 4}); if(~slidedo4 == nil, {~slidedo4 = 2000;}); ~slidecount = ~slidedo4;
					#g,h,i,j,k,l,m,n,o,p,q,r = (([ ~f1,~f2,~f3,~f4,~f5,~f6,~f7 ]-
						[ fp1d,fp2d,fp3d,fp4d,fp5d,fp6d,fp7d ])*(-1)/~slidedo4);

									~slidetime = ~slidetime4; ~slidedo = ~slidedo4;

				~slideroutine.stop;

					~synthslide.value;

		});
			~bplaces5 = Button.new(w,Rect(~bpf5l,~bpf5t+~bpf5w,~bpf5h,~bpf5w)).states_([["s5",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button;

			if(~ts.value == 1,
				{if(~tst == nil, {nil}, {~tst.close;});
					~timevals.value;
					~timer.stop; ~systemclock.stop; ~systemclock.clear; ~time5s = 0;
					~timer = Routine({inf.do({
						~time5s =
						~time5s+0.01;
						~time5s.postString; 0.01.wait;});}); ~systemclock = SystemClock.play(~timer);},
				{nil});


					if(~slidetime5 == nil, {~slidetime5 = 4}); if(~slidedo5 == nil, {~slidedo5 = 2000;}); ~slidecount = ~slidedo5;
					#g,h,i,j,k,l,m,n,o,p,q,r = (([ ~f1,~f2,~f3,~f4,~f5,~f6,~f7 ]-
						[ fp1e,fp2e,fp3e,fp4e,fp5e,fp6e,fp7e ])*(-1)/~slidedo5);

									~slidetime = ~slidetime5; ~slidedo = ~slidedo5;

				~slideroutine.stop;

					~synthslide.value;

		});
			~bplaces6 = Button.new(w,Rect(~bpf6l,~bpf6t+~bpf6w,~bpf6h,~bpf6w)).states_([["s6",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button;

			if(~ts.value == 1,
				{if(~tst == nil, {nil}, {~tst.close;});
					~timevals.value;
					~timer.stop; ~systemclock.stop; ~systemclock.clear; ~time6s = 0;
					~timer = Routine({inf.do({
						~time6s =
						~time6s+0.01;
						~time6s.postString; 0.01.wait;});}); ~systemclock = SystemClock.play(~timer);},
				{nil});


					if(~slidetime6 == nil, {~slidetime6 = 4}); if(~slidedo6 == nil, {~slidedo6 = 2000;}); ~slidecount = ~slidedo6;
					#g,h,i,j,k,l,m,n,o,p,q,r = (([ ~f1,~f2,~f3,~f4,~f5,~f6,~f7 ]-
						[ fp1f,fp2f,fp3f,fp4f,fp5f,fp6f,fp7f ])*(-1)/~slidedo6);

									~slidetime = ~slidetime6; ~slidedo = ~slidedo6;
				~slideroutine.stop;

					~synthslide.value;

		});
			~bplaces7 = Button.new(w,Rect(~bpf7l,~bpf7t+~bpf7w,~bpf7h,~bpf7w)).states_([["s7",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button;

			if(~ts.value == 1,
				{if(~tst == nil, {nil}, {~tst.close;});
					~timevals.value;
					~timer.stop; ~systemclock.stop; ~systemclock.clear; ~time7s = 0;
					~timer = Routine({inf.do({
						~time7s =
						~time7s+0.01;
						~time7s.postString; 0.01.wait;});}); ~systemclock = SystemClock.play(~timer);},
				{nil});


					if(~slidetime7 == nil, {~slidetime7 = 4}); if(~slidedo7 == nil, {~slidedo7 = 2000;}); ~slidecount = ~slidedo7;
					#g,h,i,j,k,l,m,n,o,p,q,r = (([ ~f1,~f2,~f3,~f4,~f5,~f6,~f7 ]-
						[ fp1g,fp2g,fp3g,fp4g,fp5g,fp6g,fp7g ])*(-1)/~slidedo7);

									~slidetime = ~slidetime7; ~slidedo = ~slidedo7;
				~slideroutine.stop;

					~synthslide.value;

		});
			~bplaces8 = Button.new(w,Rect(~bpf8l,~bpf8t+~bpf8w,~bpf8h,~bpf8w)).states_([["s8",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button;

			if(~ts.value == 1,
				{if(~tst == nil, {nil}, {~tst.close;});
					~timevals.value;
					~timer.stop; ~systemclock.stop; ~systemclock.clear; ~time8s = 0;
					~timer = Routine({inf.do({
						~time8s =
						~time8s+0.01;
						~time8s.postString; 0.01.wait;});}); ~systemclock = SystemClock.play(~timer);},
				{nil});


					if(~slidetime8 == nil, {~slidetime8 = 4}); if(~slidedo8 == nil, {~slidedo8 = 2000;}); ~slidecount = ~slidedo8;
					#g,h,i,j,k,l,m,n,o,p,q,r = (([ ~f1,~f2,~f3,~f4,~f5,~f6,~f7 ]-
						[ fp1h,fp2h,fp3h,fp4h,fp5h,fp6h,fp7h])*(-1)/~slidedo8);

									~slidetime = ~slidetime8; ~slidedo = ~slidedo8;

				~slideroutine.stop;

					~synthslide.value;

		});

			if(~slidetime1 == nil, {~slidetime1 = 4});
			if(~slidetime2 == nil, {~slidetime2 = 4});
			if(~slidetime3 == nil, {~slidetime3 = 4});
			if(~slidetime4 == nil, {~slidetime4 = 4});
			if(~slidetime5 == nil, {~slidetime5 = 4});
			if(~slidetime6 == nil, {~slidetime6 = 4});
			if(~slidetime7 == nil, {~slidetime7 = 4});
			if(~slidetime8 == nil, {~slidetime8 = 4});

			if(~slidedo1 == nil, {~slidedo1 = 432});
			if(~slidedo2 == nil, {~slidedo2 = 432});
			if(~slidedo3 == nil, {~slidedo3 = 432});
			if(~slidedo4 == nil, {~slidedo4 = 432});
			if(~slidedo5 == nil, {~slidedo5 = 432});
			if(~slidedo6 == nil, {~slidedo6 = 432});
			if(~slidedo7 == nil, {~slidedo7 = 432});
			if(~slidedo8 == nil, {~slidedo8 = 432});


		~slidevals = Button.new(w,Rect(Window.screenBounds.width-20-20-20,~bpt+69,20,20/1.61803398875)).states_([["s",Color.white,Color.black],["s",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button;

			if(button.value == 1, {
					({
				arg lefttime = 0 , lefttimebox = 52, leftdo = lefttimebox+widthbox, leftdobox = leftdo+52, top = 0,width=52, height = 16,  widthbox=52, heightbox = 16, inc=0, lw = 0,  uw = 0, numw = 40;
						var tall, stall, iall, siall, st1, st2, st3, st4, st5, st6, st7, st8, si1, si2, si3, si4, si5, si6, si7, si8, t1,t2,t3,t4,t5,t6,t7,t8,i1,i2,i3,i4,i5,i6,i7,i8;
					~slideview = View(w, Rect(Window.screenBounds.width/2-(340/2),Window.screenBounds.height/2-(340/1.61803398875/2),340,340/1.61803398875)).front;
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

						stall=NumberBox(~slideview, Rect(lefttimebox , top=top, widthbox, heightbox));
						st1=NumberBox(~slideview, Rect(lefttimebox , top=top+heightbox, widthbox, heightbox)).value_(~slidetime1);
						st2=NumberBox(~slideview, Rect(lefttimebox , top=top+heightbox, widthbox, heightbox)).value_(~slidetime2);
						st3=NumberBox(~slideview, Rect(lefttimebox , top=top+heightbox, widthbox, heightbox)).value_(~slidetime3);
						st4=NumberBox(~slideview, Rect(lefttimebox , top=top+heightbox, widthbox, heightbox)).value_(~slidetime4);
						st5=NumberBox(~slideview, Rect(lefttimebox , top=top+heightbox, widthbox, heightbox)).value_(~slidetime5);
						st6=NumberBox(~slideview, Rect(lefttimebox , top=top+heightbox, widthbox, heightbox)).value_(~slidetime6);
						st7=NumberBox(~slideview, Rect(lefttimebox , top=top+heightbox, widthbox, heightbox)).value_(~slidetime7);
						st8=NumberBox(~slideview, Rect(lefttimebox , top=top+heightbox, widthbox, heightbox)).value_(~slidetime8);

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

						siall=NumberBox(~slideview, Rect(leftdobox , top=top, widthbox, heightbox));
						si1=NumberBox(~slideview, Rect(leftdobox , top=top+heightbox, widthbox, heightbox)).value_(~slidedo1);
						si2=NumberBox(~slideview, Rect(leftdobox , top=top+heightbox, widthbox, heightbox)).value_(~slidedo2);
						si3=NumberBox(~slideview, Rect(leftdobox , top=top+heightbox, widthbox, heightbox)).value_(~slidedo3);
						si4=NumberBox(~slideview, Rect(leftdobox , top=top+heightbox, widthbox, heightbox)).value_(~slidedo4);
						si5=NumberBox(~slideview, Rect(leftdobox , top=top+heightbox, widthbox, heightbox)).value_(~slidedo5);
						si6=NumberBox(~slideview, Rect(leftdobox , top=top+heightbox, widthbox, heightbox)).value_(~slidedo6);
						si7=NumberBox(~slideview, Rect(leftdobox , top=top+heightbox, widthbox, heightbox)).value_(~slidedo7);
						si8=NumberBox(~slideview, Rect(leftdobox , top=top+heightbox, widthbox, heightbox)).value_(~slidedo8);

						stall.action_({arg val;
							~slidetime1 = val.value;
							~slidetime2 = val.value;
							~slidetime3 = val.value;
							~slidetime4 = val.value;
							~slidetime5 = val.value;
							~slidetime6 = val.value;
							~slidetime7 = val.value;
							~slidetime8 = val.value;
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
							~slidedo1 = val.value;
							~slidedo2 = val.value;
							~slidedo3 = val.value;
							~slidedo4 = val.value;
							~slidedo5 = val.value;
							~slidedo6 = val.value;
							~slidedo7 = val.value;
							~slidedo8 = val.value;
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

					}.value);

		~slideview.front;
				}, {~slideview.close});
			});

		mute1 = Button.new(w,Rect(~bpl+(16*1),~bpt+69,16,16/1.61803398875)).states_([["1",Color.white,Color.black],["",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button;
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

		mute2 = Button.new(w,Rect(~bpl+(16*2),~bpt+69,16,16/1.61803398875)).states_([["2",Color.white,Color.black],["",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button;
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
		mute3 = Button.new(w,Rect(~bpl+(16*3),~bpt+69,16,16/1.61803398875)).states_([["3",Color.white,Color.black],["",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button;
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
		/*mute4 = Button.new(w,Rect(~bpl+(16*4),~bpt+69,16,16/1.61803398875)).states_([["4",Color.white,Color.black],["",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button;
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
		mute5 = Button.new(w,Rect(~bpl+(16*5),~bpt+69,16,16/1.61803398875)).states_([["5",Color.white,Color.black],["",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button;
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
		mute6 = Button.new(w,Rect(~bpl+(16*6),~bpt+69,16,16/1.61803398875)).states_([["6",Color.white,Color.black],["",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button;
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
		mute7 = Button.new(w,Rect(~bpl+(16*7),~bpt+69,16,16/1.61803398875)).states_([["7",Color.white,Color.black],["",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button;
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
		});*/

		muteall = Button.new(w,Rect(~bpl+(0),~bpt+69,16,16/1.61803398875)).states_([["m",Color.white,Color.black],["u",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button;

				if(button.value == 0, {
					mute1.value = 0;
					mute2.value = 0;
					mute3.value = 0;
					/*mute4.value = 0;
					mute5.value = 0;
					mute6.value = 0;
					mute7.value = 0;*/
					/*mute8.value = 0;
					mute9.value = 0;
					mute10.value = 0;
					mute11.value = 0;
					mute12.value = 0;*/

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
						/*mute4.value = 1;
						mute5.value = 1;
						mute6.value = 1;
						mute7.value = 1;*/
						/*mute8.value = 1;
						mute9.value = 1;
						mute10.value = 1;
						mute11.value = 1;
						mute12.value = 1;*/

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

			~menu1values = ["0.167 steps/kws","0.5 steps/kws","1 step/kws","9 steps/kws"];
			case
			{~menu1nval == nil}{~menu1start = ~menu1values.at(0)}
			{~menu1nval == ~ngm6;}{~menu1start = ~menu1values.at(0)}
			{~menu1nval == ~ngm2;}{~menu1start = ~menu1values.at(1)}
			{~menu1nval == ~ngm1;}{~menu1start = ~menu1values.at(2)}
			{~menu1nval == ~gm;}{~menu1start = ~menu1values.at(3)};
			if(~menu1nvalstart.value == nil, {~menu1nvalstart = ~ngm6}, {~menu1nvalstart = ~menu1nval});
			menu1=PopUpMenu(w,Rect(20+60*2+16+(60*2),Window.screenBounds.height-88+(30/1.61803398875*0),60*2,60/1.61803398875)).items_(~mvalue = (-1); [~menu1start.asString]++Array.fill(4, {~menu1values.at(~mvalue = ~mvalue+1);});).background_(Color.black).stringColor_(Color.white);

			~menu2values = [ "1 kws/inst" , "2 kws/inst" , "6 kws/inst" , "8 kws/inst", "12 kws/inst", "24 kws/inst", "33 kws/inst", "36 kws/inst", "48 kws/inst", "64 kws/inst", "72 kws/inst", "88 kws/inst"];
			case
			{~gsinenum == nil}{~menu2start = ~menu2values.at(6)}
			{~gsinenum == 1}{~menu2start = ~menu2values.at(0)}
			{~gsinenum == 2}{~menu2start = ~menu2values.at(1)}
			{~gsinenum == 6}{~menu2start = ~menu2values.at(2)}
			{~gsinenum == 8}{~menu2start = ~menu2values.at(3)}
			{~gsinenum == 12}{~menu2start = ~menu2values.at(4)}
			{~gsinenum == 24}{~menu2start = ~menu2values.at(5)}
			{~gsinenum == 33}{~menu2start = ~menu2values.at(6)}
			{~gsinenum == 36}{~menu2start = ~menu2values.at(7)}
			{~gsinenum == 48}{~menu2start = ~menu2values.at(8)}
			{~gsinenum == 64}{~menu2start = ~menu2values.at(9)}
			{~gsinenum == 72}{~menu2start = ~menu2values.at(10)}
			{~gsinenum == 88}{~menu2start = ~menu2values.at(11)};
			if(~menu2synthdefstart.value == nil, {~menu2synthdefstart = 33}, {~menu2synthdefstart = ~gsinenum});
			menu2=PopUpMenu(w,Rect(20+60*2+16,Window.screenBounds.height-88+(30/1.61803398875*0),60*2,60/1.61803398875)).items_(~mvalue = (-1); [~menu2start.asString]++Array.fill(12, {~menu2values.at(~mvalue = ~mvalue+1);});).background_(Color.black).stringColor_(Color.white);

			set1=Button(w,Rect(20+60*2+16+180,Window.screenBounds.height-52+(16/1.61803398875*0),60,60/1.61803398875)).states_([["set",Color.white,Color.black]]).mouseDownAction_({

			~st = StaticText(w, Rect(20+60*2+16+250,Window.screenBounds.height-40, 62, 20)).background_(Color.black);
			~st.stringColor = Color.white;
			~st.string = "loading...";
			AppClock.sched(0.2,{
				~st.close;
			});

			AppClock.sched(0,{

					if(~bfreq.value > 0, {~basefreq = ~freqmap.at(~bfreq.value - 1)}, {~basefreq = ~bfreqstart});

					(#a,b,c,d,e,f =	[ ~basefreq,~basefreq,~basefreq,~basefreq,~basefreq,~basefreq  ]; ~a = a; ~b = b; ~c =c; ~d = d; ~e = e;~f=f;);

					case
					{menu1.value == 0}{~nval = ~menu1nvalstart; ~menu1nval = ~menu1nvalstart}
					{menu1.value == 1}{~nval = ~ngm6; ~menu1nval = ~ngm6;}
					{menu1.value == 2}{~nval = ~ngm2; ~menu1nval = ~ngm2;}
					{menu1.value == 3}{~nval = ~ngm1; ~menu1nval = ~ngm1;}
					{menu1.value == 4}{~nval = ~gm; ~menu1nval = ~gm;};

				case
				{menu2.value == 0}{~gsinenum = ~menu2synthdefstart; ~gsine.value;}
				{menu2.value == 1}{~gsinenum = 1; ~gsine.value;}
				{menu2.value == 2}{~gsinenum = 2; ~gsine.value;}
				{menu2.value == 3}{~gsinenum = 6; ~gsine.value;}
				{menu2.value == 4}{~gsinenum = 8; ~gsine.value;}
				{menu2.value == 5}{~gsinenum = 12; ~gsine.value;}
				{menu2.value == 6}{~gsinenum = 24; ~gsine.value;}
				{menu2.value == 7}{~gsinenum = 33; ~gsine.value;}
				{menu2.value == 8}{~gsinenum = 36; ~gsine.value;}
				{menu2.value == 9}{~gsinenum = 48; ~gsine.value;}
				{menu2.value == 10}{~gsinenum = 64; ~gsine.value;}
				{menu2.value == 11}{~gsinenum = 72; ~gsine.value;}
				{menu2.value == 12}{~gsinenum = 88; ~gsine.value;};
			});

		})
		.action_({
		});
		~snb = 0;
		/*~etemp = EqualTemperament(12, calibratefreq: 432, calibratenote: 69);*/
		MIDIFunc.cc({if(~snb == 0, {~snb = 1},{~snb = 0});}, ccNum: 60);
		MIDIdef.cc('l1', { |val|
			~l1a.set(\dur, ~f1 = \dur.asSpec.map(val / 127));
			~l1b.set(\dur,      \dur.asSpec.map(val / 127));
			~l1c.set(\dur,      \dur.asSpec.map(val / 127)/~icd3);
			~l1d.set(\dur,      \dur.asSpec.map(val / 127)/~icd3);
			~l1e.set(\dur,      \dur.asSpec.map(val / 127)/~icd6);
			~l1f.set(\dur,      \dur.asSpec.map(val / 127)/~icd6);
			{if((~f1 > ~outmaxa) or: (~f1 < ~outmina), {~z25.close;~z1.close;~z25 = (CompositeView(w, Rect((~f1.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+10, ~nw, 2)).background = Color.white;);}, {~z1.close;~z25.close;~z1 = (CompositeView(w, Rect((~f1.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2, ~nw, 2)).background = Color.white;);});
			}.defer;
			/*if(~snb == 1,
			{{~nb = NumberBox.new(w,Rect(20,0,60,60/~gm)).value_(~f1.value;).background_(Color.black).normalColor_(Color.white;);}.defer;},
			{if(~nb == nil, {nil},{~nb.close;~nb==nil;})});*/
		}, ccNum: [0]);
		MIDIdef.cc('l2', { |val|
			~l2a.set(\dur, ~f2 = \dur.asSpec.map(val / 127));
			~l2b.set(\dur,      \dur.asSpec.map(val / 127));
			~l2c.set(\dur,      \dur.asSpec.map(val / 127)/~icd3);
			~l2d.set(\dur,      \dur.asSpec.map(val / 127)/~icd3);
			~l2e.set(\dur,      \dur.asSpec.map(val / 127)/~icd6);
			~l2f.set(\dur,      \dur.asSpec.map(val / 127)/~icd6);
			{if((~f2 > ~outmaxa) or: (~f2 < ~outmina), {~z26.close;~z2.close;~z26 = (CompositeView(w, Rect((~f2.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+20, ~nw, 2)).background = Color.white;);}, {~z2.close;~z26.close;~z2 = (CompositeView(w, Rect((~f2.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+10, ~nw, 2)).background = Color.white;);});
			}.defer;
		}, ccNum: [1]);
		MIDIdef.cc('l3', { |val|
			~l3a.set(\dur, ~f3 = \dur.asSpec.map(val / 127));
			~l3b.set(\dur,      \dur.asSpec.map(val / 127));
			~l3c.set(\dur,      \dur.asSpec.map(val / 127)/~icd3);
			~l3d.set(\dur,      \dur.asSpec.map(val / 127)/~icd3);
			~l3e.set(\dur,      \dur.asSpec.map(val / 127)/~icd6);
			~l3f.set(\dur,      \dur.asSpec.map(val / 127)/~icd6);
			{if((~f3 > ~outmaxa) or: (~f3 < ~outmina), {~z27.close;~z3.close;~z27 = (CompositeView(w, Rect((~f3.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+30, ~nw, 2)).background = Color.white;);}, {~z3.close;~z27.close;~z3 = (CompositeView(w, Rect((~f3.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+20, ~nw, 2)).background = Color.white;);});
			}.defer;
		}, ccNum: 2);
		/*MIDIdef.cc('l4', { |val|
			~l4a.set(\dur, ~f4 = \dur.asSpec.map(val / 127));
			~l4b.set(\dur,      \dur.asSpec.map(val / 127));
			~l4c.set(\dur,      \dur.asSpec.map(val / 127)/~icd3);
			~l4d.set(\dur,      \dur.asSpec.map(val / 127)/~icd3);
			~l4e.set(\dur,      \dur.asSpec.map(val / 127)/~icd6);
			~l4f.set(\dur,      \dur.asSpec.map(val / 127)/~icd6);
			{if((~f4 > ~outmaxa) or: (~f4 < ~outmina), {~z28.close;~z4.close;~z28 = (CompositeView(w, Rect((~f4.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+40, ~nw, 2)).background = Color.white;);}, {~z4.close;~z28.close;~z4 = (CompositeView(w, Rect((~f4.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+30, ~nw, 2)).background = Color.white;);});
			}.defer;
		}, ccNum: 3);
		MIDIdef.cc('l5', { |val|
			~l5a.set(\dur, ~f5 = \dur.asSpec.map(val / 127));
			~l5b.set(\dur,      \dur.asSpec.map(val / 127));
			~l5c.set(\dur,      \dur.asSpec.map(val / 127)/~icd3);
			~l5d.set(\dur,      \dur.asSpec.map(val / 127)/~icd3);
			~l5e.set(\dur,      \dur.asSpec.map(val / 127)/~icd6);
			~l5f.set(\dur,      \dur.asSpec.map(val / 127)/~icd6);
			{if((~f5 > ~outmaxa) or: (~f5 < ~outmina), {~z29.close;~z5.close;~z29 = (CompositeView(w, Rect((~f5.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+50, ~nw, 2)).background = Color.white;);}, {~z5.close;~z29.close;~z5 = (CompositeView(w, Rect((~f5.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+40, ~nw, 2)).background = Color.white;);});
			}.defer;
		}, ccNum: 4);
		MIDIdef.cc('l6', { |val|
			~l6a.set(\dur, ~f6 = \dur.asSpec.map(val / 127));
			~l6b.set(\dur,      \dur.asSpec.map(val / 127));
			~l6c.set(\dur,      \dur.asSpec.map(val / 127)/~icd3);
			~l6d.set(\dur,      \dur.asSpec.map(val / 127)/~icd3);
			~l6e.set(\dur,      \dur.asSpec.map(val / 127)/~icd6);
			~l6f.set(\dur,      \dur.asSpec.map(val / 127)/~icd6);
			{if((~f6 > ~outmaxa) or: (~f6 < ~outmina), {~z30.close;~z6.close;~z30 = (CompositeView(w, Rect((~f6.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+60, ~nw, 2)).background = Color.white;);}, {~z6.close;~z30.close;~z6 = (CompositeView(w, Rect((~f6.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+50, ~nw, 2)).background = Color.white;);});
			}.defer;
		}, ccNum: 5);
		MIDIdef.cc('l7', { |val|
			~l7a.set(\dur, ~f7 = \dur.asSpec.map(val / 127));
			~l7b.set(\dur,      \dur.asSpec.map(val / 127));
			~l7c.set(\dur,      \dur.asSpec.map(val / 127)/~icd3);
			~l7d.set(\dur,      \dur.asSpec.map(val / 127)/~icd3);
			~l7e.set(\dur,      \dur.asSpec.map(val / 127)/~icd6);
			~l7f.set(\dur,      \dur.asSpec.map(val / 127)/~icd6);
			{if((~f7 > ~outmaxa) or: (~f7 < ~outmina), {~z31.close;~z7.close;~z31 = (CompositeView(w, Rect((~f7.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+70, ~nw, 2)).background = Color.white;);}, {~z7.close;~z31.close;~z7 = (CompositeView(w, Rect((~f7.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+60, ~nw, 2)).background = Color.white;);});
			}.defer;
		}, ccNum: 6);
*/
		MIDIFunc.cc({|val|
			~l1a.set(\tune, ~f1t=\tune.asSpec.map(val / 127));
			~l1b.set(\tune, \tune.asSpec.map(val / 127));
			~l1c.set(\tune, \tune.asSpec.map(val / 127)/~icd3);
			~l1d.set(\tune, \tune.asSpec.map(val / 127)/~icd3);
			~l1e.set(\tune, \tune.asSpec.map(val / 127)/~icd6);
			~l1f.set(\tune, \tune.asSpec.map(val / 127)/~icd6);
			{if((~f1+~f1t > ~outmaxa) or: (~f1+~f1t < ~outmina), {~z25.close;~z1.close;~z25 = (CompositeView(w, Rect(((~f1+~f1t).explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+10, ~nw, 2)).background = Color.white;);}, {~z1.close;~z25.close;~z1 = (CompositeView(w, Rect(((~f1+~f1t).explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2, ~nw, 2)).background = Color.white;);});
			}.defer;
		}, ccNum: 16);
		MIDIFunc.cc({|val|
			~l2a.set(\tune, ~f2t=\tune.asSpec.map(val / 127));
			~l2b.set(\tune, \tune.asSpec.map(val / 127));
			~l2c.set(\tune, \tune.asSpec.map(val / 127)/~icd3);
			~l2d.set(\tune, \tune.asSpec.map(val / 127)/~icd3);
			~l2e.set(\tune, \tune.asSpec.map(val / 127)/~icd6);
			~l2f.set(\tune, \tune.asSpec.map(val / 127)/~icd6);
			{if(((~f2+~f2t) > ~outmaxa) or: ((~f2+~f2t) < ~outmina), {~z26.close;~z2.close;~z26 = (CompositeView(w, Rect(((~f2+~f2t).explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+20, ~nw, 2)).background = Color.white;);}, {~z2.close;~z26.close;~z2 = (CompositeView(w, Rect(((~f2+~f2t).explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+10, ~nw, 2)).background = Color.white;);});
			}.defer;
		}, ccNum: 17);
		MIDIFunc.cc({|val|
			~l3a.set(\tune, ~f3t=\tune.asSpec.map(val / 127));
			~l3b.set(\tune, \tune.asSpec.map(val / 127));
			~l3c.set(\tune, \tune.asSpec.map(val / 127)/~icd3);
			~l3d.set(\tune, \tune.asSpec.map(val / 127)/~icd3);
			~l3e.set(\tune, \tune.asSpec.map(val / 127)/~icd6);
			~l3f.set(\tune, \tune.asSpec.map(val / 127)/~icd6);
			{if(((~f3+~f3t) > ~outmaxa) or: ((~f3+~f3t) < ~outmina), {~z27.close;~z3.close;~z27 = (CompositeView(w, Rect(((~f3+~f3t).explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+30, ~nw, 2)).background = Color.white;);}, {~z3.close;~z27.close;~z3 = (CompositeView(w, Rect(((~f3+~f3t).explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+20, ~nw, 2)).background = Color.white;);});
			}.defer;
		}, ccNum: 18);
		/*MIDIFunc.cc({|val|
			~l4a.set(\tune, ~f4t=\tune.asSpec.map(val / 127));
			~l4b.set(\tune, \tune.asSpec.map(val / 127));
			~l4c.set(\tune, \tune.asSpec.map(val / 127)/~icd3);
			~l4d.set(\tune, \tune.asSpec.map(val / 127)/~icd3);
			~l4e.set(\tune, \tune.asSpec.map(val / 127)/~icd6);
			~l4f.set(\tune, \tune.asSpec.map(val / 127)/~icd6);
			{if(((~f4+~f4t) > ~outmaxa) or: ((~f4+~f4t) < ~outmina), {~z28.close;~z4.close;~z28 = (CompositeView(w, Rect(((~f4+~f4t).explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+40, ~nw, 2)).background = Color.white;);}, {~z4.close;~z28.close;~z4 = (CompositeView(w, Rect(((~f4+~f4t).explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+30, ~nw, 2)).background = Color.white;);});
			}.defer;
		}, ccNum: 19);
		MIDIFunc.cc({|val|
			~l5a.set(\tune, ~f5t=\tune.asSpec.map(val / 127));
			~l5b.set(\tune, \tune.asSpec.map(val / 127));
			~l5c.set(\tune, \tune.asSpec.map(val / 127)/~icd3);
			~l5d.set(\tune, \tune.asSpec.map(val / 127)/~icd3);
			~l5e.set(\tune, \tune.asSpec.map(val / 127)/~icd6);
			~l5f.set(\tune, \tune.asSpec.map(val / 127)/~icd6);
			{if(((~f5+~f5t) > ~outmaxa) or: ((~f5+~f5t) < ~outmina), {~z29.close;~z5.close;~z29 = (CompositeView(w, Rect(((~f5+~f5t).explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+50, ~nw, 2)).background = Color.white;);}, {~z5.close;~z29.close;~z5 = (CompositeView(w, Rect(((~f5+~f5t).explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+40, ~nw, 2)).background = Color.white;);});
			}.defer;
		}, ccNum: 20);
		MIDIFunc.cc({|val|
			~l6a.set(\tune, ~f6t=\tune.asSpec.map(val / 127));
			~l6b.set(\tune, \tune.asSpec.map(val / 127));
			~l6c.set(\tune, \tune.asSpec.map(val / 127)/~icd3);
			~l6d.set(\tune, \tune.asSpec.map(val / 127)/~icd3);
			~l6e.set(\tune, \tune.asSpec.map(val / 127)/~icd6);
			~l6f.set(\tune, \tune.asSpec.map(val / 127)/~icd6);
			{if(((~f6+~f6t) > ~outmaxa) or: ((~f6+~f6t) < ~outmina), {~z30.close;~z6.close;~z30 = (CompositeView(w, Rect(((~f6+~f6t).explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+60, ~nw, 2)).background = Color.white;);}, {~z6.close;~z30.close;~z6 = (CompositeView(w, Rect(((~f6+~f6t).explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+50, ~nw, 2)).background = Color.white;);});
			}.defer;
		}, ccNum: 21);
		MIDIFunc.cc({|val|
			~l7a.set(\tune, ~f7t=\tune.asSpec.map(val / 127));
			~l7b.set(\tune, \tune.asSpec.map(val / 127));
			~l7c.set(\tune, \tune.asSpec.map(val / 127)/~icd3);
			~l7d.set(\tune, \tune.asSpec.map(val / 127)/~icd3);
			~l7e.set(\tune, \tune.asSpec.map(val / 127)/~icd6);
			~l7f.set(\tune, \tune.asSpec.map(val / 127)/~icd6);
			{if(((~f7+~f7t) > ~outmaxa) or: ((~f7+~f7t) < ~outmina), {~z31.close;~z7.close;~z31 = (CompositeView(w, Rect(((~f7+~f7t).explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+70, ~nw, 2)).background = Color.white;);}, {~z7.close;~z31.close;~z7 = (CompositeView(w, Rect(((~f7+~f7t).explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+60, ~nw, 2)).background = Color.white;);});
			}.defer;
		}, ccNum: 22);*/

		MIDIFunc.cc({|val| {b3.state == 1;}.defer;}, ccNum: 49);
		MIDIFunc.cc({|val| {b3.state == 0;}.defer;}, ccNum: 48);
		/*MIDIFunc.cc({ |val| ([~a2,~b2,~c2,~d2,~e2,~f2]).postln;}, ccNum: [0]);*/
		/*MIDIFunc.cc({ |val|~l1.set(\tune, 0);}, ccNum: [32]);*/
		/*MIDIFunc.cc({ |val| ([(~w),(~x),(~y),(~z),(~u),(~v),~r,~s]).postln;}, ccNum: [64]);*/
		/*~basefreq= 432.cpsmidi-69;*/
		/*Spec.add(\dur, ~etemp.cps([0, 127, \exp]));*/
		Spec.add(\dur, ([~freqmap.at(0), ~freqmap.at(127), \exp]));
		Spec.add(\tune, ([0, 128, \lin]));

		keycodeb = Button.new(w,Rect(Window.screenBounds.width-20-16,~bpt+160,16,16/1.61803398875)).states_([
			["1",Color.white,Color.black],
			["2",Color.white,Color.black],
			["3",Color.white,Color.black],
			["4",Color.white,Color.black],
			["5",Color.white,Color.black],
			["6",Color.white,Color.black],
			["7",Color.white,Color.black]]).action_({arg button;

			case
			{button.value == 0}{
				~z25.background = Color.green; ~z1.background = Color.green;
				~z26.background = Color.white; ~z2.background = Color.white;
				~z27.background = Color.white; ~z3.background = Color.white;
				~z28.background = Color.white; ~z4.background = Color.white;
				~z29.background = Color.white; ~z5.background = Color.white;
				~z30.background = Color.white; ~z6.background = Color.white;
				~z31.background = Color.white; ~z7.background = Color.white;
			}
			{button.value == 1}{
				~z25.background = Color.white; ~z1.background = Color.white;
				~z26.background = Color.green; ~z2.background = Color.green;
				~z27.background = Color.white; ~z3.background = Color.white;
				~z28.background = Color.white; ~z4.background = Color.white;
				~z29.background = Color.white; ~z5.background = Color.white;
				~z30.background = Color.white; ~z6.background = Color.white;
				~z31.background = Color.white; ~z7.background = Color.white;
			}
			{button.value == 2}{
				~z25.background = Color.white; ~z1.background = Color.white;
				~z26.background = Color.white; ~z2.background = Color.white;
				~z27.background = Color.green; ~z3.background = Color.green;
				~z28.background = Color.white; ~z4.background = Color.white;
				~z29.background = Color.white; ~z5.background = Color.white;
				~z30.background = Color.white; ~z6.background = Color.white;
				~z31.background = Color.white; ~z7.background = Color.white;
			}
			{button.value == 3}{
				~z25.background = Color.white; ~z1.background = Color.white;
				~z26.background = Color.white; ~z2.background = Color.white;
				~z27.background = Color.white; ~z3.background = Color.white;
				~z28.background = Color.green; ~z4.background = Color.green;
				~z29.background = Color.white; ~z5.background = Color.white;
				~z30.background = Color.white; ~z6.background = Color.white;
				~z31.background = Color.white; ~z7.background = Color.white;
			}
			/*{button.value == 4}{
				~z25.background = Color.white; ~z1.background = Color.white;
				~z26.background = Color.white; ~z2.background = Color.white;
				~z27.background = Color.white; ~z3.background = Color.white;
				~z28.background = Color.white; ~z4.background = Color.white;
				~z29.background = Color.green; ~z5.background = Color.green;
				~z30.background = Color.white; ~z6.background = Color.white;
				~z31.background = Color.white; ~z7.background = Color.white;
			}
			{button.value == 5}{
				~z25.background = Color.white; ~z1.background = Color.white;
				~z26.background = Color.white; ~z2.background = Color.white;
				~z27.background = Color.white; ~z3.background = Color.white;
				~z28.background = Color.white; ~z4.background = Color.white;
				~z29.background = Color.white; ~z5.background = Color.white;
				~z30.background = Color.green; ~z6.background = Color.green;
				~z31.background = Color.white; ~z7.background = Color.white;
			}
			{button.value == 6}{
				~z25.background = Color.white; ~z1.background = Color.white;
				~z26.background = Color.white; ~z2.background = Color.white;
				~z27.background = Color.white; ~z3.background = Color.white;
				~z28.background = Color.white; ~z4.background = Color.white;
				~z29.background = Color.white; ~z5.background = Color.white;
				~z30.background = Color.white; ~z6.background = Color.white;
				~z31.background = Color.green; ~z7.background = Color.green;
			}*/

		});

		w.view.keyDownAction = { arg view, char, modifiers, unicode, keycode;
			[char, modifiers, unicode, keycode];

			if(unicode == ~c_unicode, {
					case
					{b.value == 0}{b.valueAction = 1}
					{b.value == 1}{b.valueAction = 0};
				});
				if(unicode == ~s_unicode, {
					case
					{b3.value == 0}{b3.valueAction = 1}
					{b3.value == 1}{b3.valueAction = 0};
				});
				if(unicode == ~spacebar_unicode, {
					case
					{b4.value == 0}{b4.valueAction = 1}
					{b4.value == 1}{b4.valueAction = 0};
				});
				if(unicode == ~t_unicode, {
					case
					{~ts.value == 0}{~ts.valueAction = 1}
					{~ts.value == 1}{~ts.valueAction = 0};
				});
				if(unicode == ~u_unicode, {
					case
					{unmuteall.value == 0}{unmuteall.valueAction = 1}
					{unmuteall.value == 1}{unmuteall.valueAction = 0};
				});
				if(unicode == ~m_unicode, {
					case
					{muteall.value == 0}{muteall.valueAction = 1}
					{muteall.value == 1}{muteall.valueAction = 0};
				});

				if(unicode == ~escape_unicode, {w.minimize;});

				/*~bfreqv = ~freqmap.at(34);
				if((~bfreq.value == 1) and: ((keycode == ~leftarrow_keycode) or: (unicode == ~j_unicode)), {~bfreqtext.string = ~freqmap.at(~bfreqv = ~bfreqv-1).asString;}, {nil});
				if((~bfreq.value == 1) and: ((keycode == ~rightarrow_keycode) or: (unicode == ~l_unicode)), {~bfreqtext.string = ~freqmap.at(~bfreqv = ~bfreqv+1).asString;}, {nil});
*/
			case
			{unicode == ~one_unicode}{keycodeb.valueAction_(0)}
			{unicode == ~two_unicode}{keycodeb.valueAction_(1)}
			{unicode == ~three_unicode}{keycodeb.valueAction_(2)}
			{unicode == ~four_unicode}{keycodeb.valueAction_(3)}
			{unicode == ~five_unicode}{keycodeb.valueAction_(4)}
			{unicode == ~six_unicode}{keycodeb.valueAction_(5)}
			{unicode == ~seven_unicode}{keycodeb.valueAction_(6)}
			{(keycode == ~uparrow_keycode) or: (unicode == ~i_unicode)}{keycodeb.valueAction_(keycodeb.value-1)}
			{(keycode == ~downarrow_keycode) or: (unicode == ~k_unicode)}{keycodeb.valueAction_(keycodeb.value+1)};

			if((~f1 >= ~freqmap.at(127)), {~freqmap.at(127)},
				{if((keycodeb.value == 0) and: ((keycode == ~rightarrow_keycode) or: (unicode == ~l_unicode)), {|val|
					~l1a.set(\dur, ~f1 = ~freqmap.at(~freqmapval1 = ~freqmapval1.value+1));
					~l1b.set(\dur, ~f1);
					~l1c.set(\dur, ~f1/~icd3);
					~l1d.set(\dur, ~f1/~icd3);
					~l1e.set(\dur, ~f1/~icd6);
					~l1f.set(\dur, ~f1/~icd6);
					if((~f1 > ~outmaxa) or: (~f1 < ~outmina), {~z25.close;~z1.close;~z25 = (CompositeView(w, Rect((~f1.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+10, ~nw, 2)).background = Color.white;);}, {~z1.close;~z25.close;~z1 = (CompositeView(w, Rect((~f1.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2, ~nw, 2)).background = Color.white;);});
					~z25.background = Color.green; ~z1.background = Color.green;
					~z26.background = Color.white; ~z2.background = Color.white;
					~z27.background = Color.white; ~z3.background = Color.white;
					~z28.background = Color.white; ~z4.background = Color.white;
					~z29.background = Color.white; ~z5.background = Color.white;
					~z30.background = Color.white; ~z6.background = Color.white;
					~z31.background = Color.white; ~z7.background = Color.white;
			});});
			if((~f1 <= ~freqmap.at(0)), {~freqmap.at(0)},
				{if((keycodeb.value == 0) and: ((keycode == ~leftarrow_keycode) or: (unicode == ~j_unicode)), {|val|
					~l1a.set(\dur, ~f1 = ~freqmap.at(~freqmapval1 = ~freqmapval1.value-1));
					~l1b.set(\dur, ~f1);
					~l1c.set(\dur, ~f1/~icd3);
					~l1d.set(\dur, ~f1/~icd3);
					~l1e.set(\dur, ~f1/~icd6);
					~l1f.set(\dur, ~f1/~icd6);
					if((~f1 > ~outmaxa) or: (~f1 < ~outmina), {~z25.close;~z1.close;~z25 = (CompositeView(w, Rect((~f1.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+10, ~nw, 2)).background = Color.white;);}, {~z1.close;~z25.close;~z1 = (CompositeView(w, Rect((~f1.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2, ~nw, 2)).background = Color.white;);});
					/*if(~f1 <= ~outmin1 and: ~f1 <= ~outmin2 and: ~f1 >= ~outmax1 and: ~f1 >= ~outmax2, {~f1 = 0;*/
					~z25.background = Color.green; ~z1.background = Color.green;
					~z26.background = Color.white; ~z2.background = Color.white;
					~z27.background = Color.white; ~z3.background = Color.white;
					~z28.background = Color.white; ~z4.background = Color.white;
					~z29.background = Color.white; ~z5.background = Color.white;
					~z30.background = Color.white; ~z6.background = Color.white;
					~z31.background = Color.white; ~z7.background = Color.white;
			});});

			if((~f2 >= ~freqmap.at(127)), {~freqmap.at(127)},
				{if((keycodeb.value == 1) and: ((keycode == ~rightarrow_keycode) or: (unicode == ~l_unicode)), {|val|
					~l2a.set(\dur, ~f2 = ~freqmap.at(~freqmapval2 = ~freqmapval2.value+1));
					~l2b.set(\dur, ~f2);
					~l2c.set(\dur, ~f2/~icd3);
					~l2d.set(\dur, ~f2/~icd3);
					~l2e.set(\dur, ~f2/~icd6);
					~l2f.set(\dur, ~f2/~icd6);
					if((~f2 > ~outmaxa) or: (~f2 < ~outmina), {~z26.close;~z2.close;~z26 = (CompositeView(w, Rect((~f2.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+20, ~nw, 2)).background = Color.white;);}, {~z2.close;~z26.close;~z2 = (CompositeView(w, Rect((~f2.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+10, ~nw, 2)).background = Color.white;);});
					~z25.background = Color.white; ~z1.background = Color.white;
					~z26.background = Color.green; ~z2.background = Color.green;
					~z27.background = Color.white; ~z3.background = Color.white;
					~z28.background = Color.white; ~z4.background = Color.white;
					~z29.background = Color.white; ~z5.background = Color.white;
					~z30.background = Color.white; ~z6.background = Color.white;
					~z31.background = Color.white; ~z7.background = Color.white;
			});});
			if((~f2 <= ~freqmap.at(0)), {~freqmap.at(0)},
				{if((keycodeb.value == 1) and: ((keycode == ~leftarrow_keycode) or: (unicode == ~j_unicode)), {|val|
					~l2a.set(\dur, ~f2 = ~freqmap.at(~freqmapval2 = ~freqmapval2.value-1));
					~l2b.set(\dur, ~f2);
					~l2c.set(\dur, ~f2/~icd3);
					~l2d.set(\dur, ~f2/~icd3);
					~l2e.set(\dur, ~f2/~icd6);
					~l2f.set(\dur, ~f2/~icd6);
					if((~f2 > ~outmaxa) or: (~f2 < ~outmina), {~z26.close;~z2.close;~z26 = (CompositeView(w, Rect((~f2.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+20, ~nw, 2)).background = Color.white;);}, {~z2.close;~z26.close;~z2 = (CompositeView(w, Rect((~f2.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+10, ~nw, 2)).background = Color.white;);});
					/*if(~f1 <= ~outmin1 and: ~f1 <= ~outmin2 and: ~f1 >= ~outmax1 and: ~f1 >= ~outmax2, {~f1 = 0;*/
					~z25.background = Color.white; ~z1.background = Color.white;
					~z26.background = Color.green; ~z2.background = Color.green;
					~z27.background = Color.white; ~z3.background = Color.white;
					~z28.background = Color.white; ~z4.background = Color.white;
					~z29.background = Color.white; ~z5.background = Color.white;
					~z30.background = Color.white; ~z6.background = Color.white;
					~z31.background = Color.white; ~z7.background = Color.white;
			});});

			if((~f3 >= ~freqmap.at(127)), {~freqmap.at(127)},
				{if((keycodeb.value == 2) and: ((keycode == ~rightarrow_keycode) or: (unicode == ~l_unicode)), {|val|
					~l3a.set(\dur, ~f3 = ~freqmap.at(~freqmapval3 = ~freqmapval3.value+1));
					~l3b.set(\dur, ~f3);
					~l3c.set(\dur, ~f3/~icd3);
					~l3d.set(\dur, ~f3/~icd3);
					~l3e.set(\dur, ~f3/~icd6);
					~l3f.set(\dur, ~f3/~icd6);
					if((~f3 > ~outmaxa) or: (~f3 < ~outmina), {~z27.close;~z3.close;~z27 = (CompositeView(w, Rect((~f3.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+30, ~nw, 2)).background = Color.white;);}, {~z3.close;~z27.close;~z3 = (CompositeView(w, Rect((~f3.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+20, ~nw, 2)).background = Color.white;);});
					~z25.background = Color.white; ~z1.background = Color.white;
					~z26.background = Color.white; ~z2.background = Color.white;
					~z27.background = Color.green; ~z3.background = Color.green;
					~z28.background = Color.white; ~z4.background = Color.white;
					~z29.background = Color.white; ~z5.background = Color.white;
					~z30.background = Color.white; ~z6.background = Color.white;
					~z31.background = Color.white; ~z7.background = Color.white;
			});});
			if((~f3 <= ~freqmap.at(0)), {~freqmap.at(0)},
				{if((keycodeb.value == 2) and: ((keycode == ~leftarrow_keycode) or: (unicode == ~j_unicode)), {|val|
					~l3a.set(\dur, ~f3 = ~freqmap.at(~freqmapval3 = ~freqmapval3.value-1));
					~l3b.set(\dur, ~f3);
					~l3c.set(\dur, ~f3/~icd3);
					~l3d.set(\dur, ~f3/~icd3);
					~l3e.set(\dur, ~f3/~icd6);
					~l3f.set(\dur, ~f3/~icd6);
					if((~f3 > ~outmaxa) or: (~f3 < ~outmina), {~z27.close;~z3.close;~z27 = (CompositeView(w, Rect((~f3.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+30, ~nw, 2)).background = Color.white;);}, {~z3.close;~z27.close;~z3 = (CompositeView(w, Rect((~f3.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+20, ~nw, 2)).background = Color.white;);});
					/*if(~f1 <= ~outmin1 and: ~f1 <= ~outmin2 and: ~f1 >= ~outmax1 and: ~f1 >= ~outmax2, {~f1 = 0;*/
					~z25.background = Color.white; ~z1.background = Color.white;
					~z26.background = Color.white; ~z2.background = Color.white;
					~z27.background = Color.green; ~z3.background = Color.green;
					~z28.background = Color.white; ~z4.background = Color.white;
					~z29.background = Color.white; ~z5.background = Color.white;
					~z30.background = Color.white; ~z6.background = Color.white;
					~z31.background = Color.white; ~z7.background = Color.white;
			});});

			if((~f4 >= ~freqmap.at(127)), {~freqmap.at(127)},
				{if((keycodeb.value == 3) and: ((keycode == ~rightarrow_keycode) or: (unicode == ~l_unicode)), {|val|
					~l4a.set(\dur, ~f4 = ~freqmap.at(~freqmapval4 = ~freqmapval4.value+1));
					~l4b.set(\dur, ~f4);
					~l4c.set(\dur, ~f4/~icd3);
					~l4d.set(\dur, ~f4/~icd3);
					~l4e.set(\dur, ~f4/~icd6);
					~l4f.set(\dur, ~f4/~icd6);
					if((~f4 > ~outmaxa) or: (~f4 < ~outmina), {~z28.close;~z4.close;~z28 = (CompositeView(w, Rect((~f4.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+40, ~nw, 2)).background = Color.white;);}, {~z4.close;~z28.close;~z4 = (CompositeView(w, Rect((~f4.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+30, ~nw, 2)).background = Color.white;);});
					~z25.background = Color.white; ~z1.background = Color.white;
					~z26.background = Color.white; ~z2.background = Color.white;
					~z27.background = Color.white; ~z3.background = Color.white;
					~z28.background = Color.green; ~z4.background = Color.green;
					~z29.background = Color.white; ~z5.background = Color.white;
					~z30.background = Color.white; ~z6.background = Color.white;
					~z31.background = Color.white; ~z7.background = Color.white;
			});});
			if((~f4 <= ~freqmap.at(0)), {~freqmap.at(0)},
				{if((keycodeb.value == 3) and: ((keycode == ~leftarrow_keycode) or: (unicode == ~j_unicode)), {|val|
					~l4a.set(\dur, ~f4 = ~freqmap.at(~freqmapval4 = ~freqmapval4.value-1));
					~l4b.set(\dur, ~f4);
					~l4c.set(\dur, ~f4/~icd3);
					~l4d.set(\dur, ~f4/~icd3);
					~l4e.set(\dur, ~f4/~icd6);
					~l4f.set(\dur, ~f4/~icd6);
					if((~f4 > ~outmaxa) or: (~f4 < ~outmina), {~z28.close;~z4.close;~z28 = (CompositeView(w, Rect((~f4.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+40, ~nw, 2)).background = Color.white;);}, {~z4.close;~z28.close;~z4 = (CompositeView(w, Rect((~f4.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+30, ~nw, 2)).background = Color.white;);});
					/*if(~f1 <= ~outmin1 and: ~f1 <= ~outmin2 and: ~f1 >= ~outmax1 and: ~f1 >= ~outmax2, {~f1 = 0;*/
					~z25.background = Color.white; ~z1.background = Color.white;
					~z26.background = Color.white; ~z2.background = Color.white;
					~z27.background = Color.white; ~z3.background = Color.white;
					~z28.background = Color.green; ~z4.background = Color.green;
					~z29.background = Color.white; ~z5.background = Color.white;
					~z30.background = Color.white; ~z6.background = Color.white;
					~z31.background = Color.white; ~z7.background = Color.white;
			});});

			if((~f5 >= ~freqmap.at(127)), {~freqmap.at(127)},
				{if((keycodeb.value == 4) and: ((keycode == ~rightarrow_keycode) or: (unicode == ~l_unicode)), {|val|
					~l5a.set(\dur, ~f5 = ~freqmap.at(~freqmapval5 = ~freqmapval5.value+1));
					~l5b.set(\dur, ~f5);
					~l5c.set(\dur, ~f5/~icd3);
					~l5d.set(\dur, ~f5/~icd3);
					~l5e.set(\dur, ~f5/~icd6);
					~l5f.set(\dur, ~f5/~icd6);
					if((~f5 > ~outmaxa) or: (~f5 < ~outmina), {~z29.close;~z5.close;~z29 = (CompositeView(w, Rect((~f5.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+50, ~nw, 2)).background = Color.white;);}, {~z5.close;~z29.close;~z5 = (CompositeView(w, Rect((~f5.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+40, ~nw, 2)).background = Color.white;);});
					~z25.background = Color.white; ~z1.background = Color.white;
					~z26.background = Color.white; ~z2.background = Color.white;
					~z27.background = Color.white; ~z3.background = Color.white;
					~z28.background = Color.white; ~z4.background = Color.white;
					~z29.background = Color.green; ~z5.background = Color.green;
					~z30.background = Color.white; ~z6.background = Color.white;
					~z31.background = Color.white; ~z7.background = Color.white;
			});});
			if((~f5 <= ~freqmap.at(0)), {~freqmap.at(0)},
				{if((keycodeb.value == 4) and: ((keycode == ~leftarrow_keycode) or: (unicode == ~j_unicode)), {|val|
					~l5a.set(\dur, ~f5 = ~freqmap.at(~freqmapval5 = ~freqmapval5.value-1));
					~l5b.set(\dur, ~f5);
					~l5c.set(\dur, ~f5/~icd3);
					~l5d.set(\dur, ~f5/~icd3);
					~l5e.set(\dur, ~f5/~icd6);
					~l5f.set(\dur, ~f5/~icd6);
					if((~f5 > ~outmaxa) or: (~f5 < ~outmina), {~z29.close;~z5.close;~z29 = (CompositeView(w, Rect((~f5.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+50, ~nw, 2)).background = Color.white;);}, {~z5.close;~z29.close;~z5 = (CompositeView(w, Rect((~f5.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+40, ~nw, 2)).background = Color.white;);});
					/*if(~f1 <= ~outmin1 and: ~f1 <= ~outmin2 and: ~f1 >= ~outmax1 and: ~f1 >= ~outmax2, {~f1 = 0;*/
					~z25.background = Color.white; ~z1.background = Color.white;
					~z26.background = Color.white; ~z2.background = Color.white;
					~z27.background = Color.white; ~z3.background = Color.white;
					~z28.background = Color.white; ~z4.background = Color.white;
					~z29.background = Color.green; ~z5.background = Color.green;
					~z30.background = Color.white; ~z6.background = Color.white;
					~z31.background = Color.white; ~z7.background = Color.white;
			});});

			if((~f6 >= ~freqmap.at(127)), {~freqmap.at(127)},
				{if((keycodeb.value == 5) and: ((keycode == ~rightarrow_keycode) or: (unicode == ~l_unicode)), {|val|
					~l6a.set(\dur, ~f6 = ~freqmap.at(~freqmapval6 = ~freqmapval6.value+1));
					~l6b.set(\dur, ~f6);
					~l6c.set(\dur, ~f6/~icd3);
					~l6d.set(\dur, ~f6/~icd3);
					~l6e.set(\dur, ~f6/~icd6);
					~l6f.set(\dur, ~f6/~icd6);
					if((~f6 > ~outmaxa) or: (~f6 < ~outmina), {~z30.close;~z6.close;~z30 = (CompositeView(w, Rect((~f6.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+60, ~nw, 2)).background = Color.white;);}, {~z6.close;~z30.close;~z6 = (CompositeView(w, Rect((~f6.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+50, ~nw, 2)).background = Color.white;);});
					~z25.background = Color.white; ~z1.background = Color.white;
					~z26.background = Color.white; ~z2.background = Color.white;
					~z27.background = Color.white; ~z3.background = Color.white;
					~z28.background = Color.white; ~z4.background = Color.white;
					~z29.background = Color.white; ~z5.background = Color.white;
					~z30.background = Color.green; ~z6.background = Color.green;
					~z31.background = Color.white; ~z7.background = Color.white;
			});});
			if((~f6 <= ~freqmap.at(0)), {~freqmap.at(0)},
				{if((keycodeb.value == 5) and: ((keycode == ~leftarrow_keycode) or: (unicode == ~j_unicode)), {|val|
					~l6a.set(\dur, ~f6 = ~freqmap.at(~freqmapval6 = ~freqmapval6.value-1));
					~l6b.set(\dur, ~f6);
					~l6c.set(\dur, ~f6/~icd3);
					~l6d.set(\dur, ~f6/~icd3);
					~l6e.set(\dur, ~f6/~icd6);
					~l6f.set(\dur, ~f6/~icd6);
					if((~f6 > ~outmaxa) or: (~f6 < ~outmina), {~z30.close;~z6.close;~z30 = (CompositeView(w, Rect((~f6.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+60, ~nw, 2)).background = Color.white;);}, {~z6.close;~z30.close;~z6 = (CompositeView(w, Rect((~f6.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+50, ~nw, 2)).background = Color.white;);});
					/*if(~f1 <= ~outmin1 and: ~f1 <= ~outmin2 and: ~f1 >= ~outmax1 and: ~f1 >= ~outmax2, {~f1 = 0;*/
					~z25.background = Color.white; ~z1.background = Color.white;
					~z26.background = Color.white; ~z2.background = Color.white;
					~z27.background = Color.white; ~z3.background = Color.white;
					~z28.background = Color.white; ~z4.background = Color.white;
					~z29.background = Color.white; ~z5.background = Color.white;
					~z30.background = Color.green; ~z6.background = Color.green;
					~z31.background = Color.white; ~z7.background = Color.white;
			});});

			if((~f7 >= ~freqmap.at(127)), {~freqmap.at(127)},
					{if((keycodeb.value == 6) and: ((keycode == ~rightarrow_keycode) or: (unicode == ~l_unicode)), {|val|
					~l7a.set(\dur, ~f7 = ~freqmap.at(~freqmapval7 = ~freqmapval7.value+1));
					~l7b.set(\dur, ~f7);
					~l7c.set(\dur, ~f7/~icd3);
					~l7d.set(\dur, ~f7/~icd3);
					~l7e.set(\dur, ~f7/~icd6);
					~l7f.set(\dur, ~f7/~icd6);
					if((~f7 > ~outmaxa) or: (~f7 < ~outmina), {~z31.close;~z7.close;~z31 = (CompositeView(w, Rect((~f7.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+70, ~nw, 2)).background = Color.white;);}, {~z7.close;~z31.close;~z7 = (CompositeView(w, Rect((~f7.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+60, ~nw, 2)).background = Color.white;);});
					~z25.background = Color.white; ~z1.background = Color.white;
					~z26.background = Color.white; ~z2.background = Color.white;
					~z27.background = Color.white; ~z3.background = Color.white;
					~z28.background = Color.white; ~z4.background = Color.white;
					~z29.background = Color.white; ~z5.background = Color.white;
					~z30.background = Color.white; ~z6.background = Color.white;
					~z31.background = Color.green; ~z7.background = Color.green;
			});});
			if((~f7 <= ~freqmap.at(0)), {~freqmap.at(0)},
				{if((keycodeb.value == 6) and: ((keycode == ~leftarrow_keycode) or: (unicode == ~j_unicode)), {|val|
					~l7a.set(\dur, ~f7 = ~freqmap.at(~freqmapval7 = ~freqmapval7.value-1));
					~l7b.set(\dur, ~f7);
					~l7c.set(\dur, ~f7/~icd3);
					~l7d.set(\dur, ~f7/~icd3);
					~l7e.set(\dur, ~f7/~icd6);
					~l7f.set(\dur, ~f7/~icd6);
					if((~f7 > ~outmaxa) or: (~f7 < ~outmina), {~z31.close;~z7.close;~z31 = (CompositeView(w, Rect((~f7.explin(~outminb,~outmaxb,0,Window.screenBounds.width)), ~dc1+70, ~nw, 2)).background = Color.white;);}, {~z7.close;~z31.close;~z7 = (CompositeView(w, Rect((~f7.explin(~outmina,~outmaxa,0,Window.screenBounds.width)), ~dc2+60, ~nw, 2)).background = Color.white;);});
					/*if(~f1 <= ~outmin1 and: ~f1 <= ~outmin2 and: ~f1 >= ~outmax1 and: ~f1 >= ~outmax2, {~f1 = 0;*/
					~z25.background = Color.white; ~z1.background = Color.white;
					~z26.background = Color.white; ~z2.background = Color.white;
					~z27.background = Color.white; ~z3.background = Color.white;
					~z28.background = Color.white; ~z4.background = Color.white;
					~z29.background = Color.white; ~z5.background = Color.white;
					~z30.background = Color.white; ~z6.background = Color.white;
					~z31.background = Color.green; ~z7.background = Color.green;
			});});

			};

		info = Button.new(w,Rect(Window.screenBounds.width-20-20,~bpt+69,20,20/1.61803398875)).states_([["i",Color.white,Color.black],["i",Color.white,Color.black]]).action_({arg button;

			if(button.value == 1, {
				~hb = TextView(w, Rect(0,0, Window.screenBounds.width, Window.screenBounds.height-200)).background_(Color.black);
				(~hb.string =
						"(scroll down to see more)"++"\n"++"\n"++"\n"++
						"GUI Buttons"++"\n"++"\n"++"\n"++
						"synth0/synth1: start/stop synth set"++"\n"++"\n"++
						"pause0/pause1: pause/unpause synth set"++"\n"++"\n"++
						"copy: copy frequency/note info"++"\n"++"\n"++
						"kws/inst: change number of kw(King Wen) sequences per time wave instance. press set to load"++"\n"++"\n"++
						"steps/kws: change number of interval steps which occur in each kw sequence. press set to load"++"\n"++"\n"++
						"hz frequency: set the base frequency. press set to load"++"\n"++"\n"++
						"s1-s8: set/save note positions"++"\n"++"\n"++
						"u1-u8: undo changes to set note positions. press set to load"++"\n"++"\n"++
						"o1-o8: play set/saved note positions by opening a new synth set"++"\n"++"\n"++
						"f1-f8: flow transition to set/saved note positions"++"\n"++"\n"++
						"s1-s8: slide transition to set/saved note positions"++"\n"++"\n"++
						"tsynth0/tsynth1: tsynth0 to allow timed synth set, then click on any o or f button to time a progression. click on the ts button in the bottom right to stop the timer. tsynth1 to dis-allow timed synth set"++"\n"++"\n"++
						"ts: stop synth timer/show timer results"++"\n"++"\n"++
						"rc: start recording"++"\n"++"\n"++
						"prc: pause recording"++"\n"++"\n"++
						"/rc: stop recording"++"\n"++"\n"++
						"m/u: mute/unmute all"++"\n"++"\n"++
						"1-3: mute or unmute individual synth"++"\n"++"\n"++
						"s: slide settings - s(1-7) time is the duration of slide in seconds, s(1-7) incr is the number of steps in the slide"++"\n"++"\n"++
						"i: help"++"\n"++"\n"++
						"m: minimize window"++"\n"++"\n"++
						"e: close window"++"\n"++"\n"++"\n"++
						"Keyboard Functions (functionality will vary with device)"++"\n"++"\n"++"\n"++
						"s: start/stop synth set"++"\n"++"\n"++
						"space bar: pause/unpause synth set"++"\n"++"\n"++
						"ctrl-period/cmd-period: free server"++"\n"++"\n"++
						"left/right arrow(or J and L): move down/up note"++"\n"++"\n"++
						"up/down arrow(or I and K): change synth for left/right arrow note function"++"\n"++"\n"++
						"#1-3 on keyboard: choose synth for left/right arrow note function"++"\n"++"\n"++
						"m: mute all"++"\n"++"\n"++
						"u: unmute all"++"\n"++"\n"++
						"c: copy function"++"\n"++"\n"++
						"t: timed synth function"++"\n"++"\n"++
						"esc: close window"
					;
				);
				~hb.stringColor = Color.white;
				},
				{~hb.close;});
		});

			n1 = Button.new(w,Rect(Window.screenBounds.width-(Window.screenBounds.width/2)-(60*2),Window.screenBounds.height-88,60,60/1.61803398875)).states_([["s1",Color.white,Color.black],["1set",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button; if(button.value == 1, {~r1=fp1;~r2=fp2;~r3=fp3;~r4=fp4;~r5=fp5;~r6=fp6;~r7=fp7;~r8=fp8;~r9=fp9;~r10=fp10;~r11=fp11;~r12=fp12; #fp1,fp2,fp3,fp4,fp5,fp6,fp7,fp8,fp9,fp10,fp11,fp12/*,fp13,fp14,fp15,fp16,fp17,fp18,fp19,fp20,fp21,fp22,fp23,fp24*/ = [ ~f1,~f2,~f3,~f4,~f5,~f6,~f7,~f8,~f9,~f10,~f11,~f12 ]; "s"++"\n"++[ ~f1,~f2,~f3,~f4,~f5,~f6,~f7,~f8,~f9,~f10,~f11,~f12 ].asString.postString; ~u1=~f1;~u2=~f2;~u3=~f3;~u4=~f4;~u5=~f5;~u6=~f6;~u7=~f7;~u8=~f8;~u9=~f9;~u10=~f10;~u11=~f11;~u12=~f12;}, {nil});});
			n2 = Button.new(w,Rect(Window.screenBounds.width-(Window.screenBounds.width/2)-(60*1),Window.screenBounds.height-88,60,60/1.61803398875)).states_([["s2",Color.white,Color.black],["2set",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button; if(button.value == 1, {~r1=fp1b;~r2=fp2b;~r3=fp3b;~r4b=fp4b;~r5b=fp5b;~r6b=fp6b;~r7b=fp7b;~r8b=fp8b;~r9b=fp9b;~r10b=fp10b;~r11b=fp11b;~r12b=fp12b; #fp1b,fp2b,fp3b,fp4b,fp5b,fp6b,fp7b,fp8b,fp9b,fp10b,fp11b,fp12b/*,fp13b,fp14b,fp15b,fp16b,fp17b,fp18b,fp19b,fp20b,fp21b,fp22b,fp23b,fp24b*/ = [ ~f1,~f2,~f3,~f4,~f5,~f6,~f7,~f8,~f9,~f10,~f11,~f12 ]; "s"++"\n"++[ ~f1,~f2,~f3,~f4,~f5,~f6,~f7,~f8,~f9,~f10,~f11,~f12 ].asString.postString; ~u1b=~f1;~u2b=~f2;~u3b=~f3;~u4b=~f4;~u5b=~f5;~u6b=~f6;~u7b=~f7;~u8b=~f8;~u9b=~f9;~u10b=~f10;~u11b=~f11;~u12b=~f12;}, {nil});});
			n3 = Button.new(w,Rect(Window.screenBounds.width-(Window.screenBounds.width/2)+(0),   Window.screenBounds.height-88,60,60/1.61803398875)).states_([["s3",Color.white,Color.black],["3set",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button; if(button.value == 1, {~r1=fp1c;~r2=fp2c;~r3=fp3c;~r4c=fp4c;~r5c=fp5c;~r6c=fp6c;~r7c=fp7c;~r8c=fp8c;~r9c=fp9c;~r10c=fp10c;~r11c=fp11c;~r12c=fp12c; #fp1c,fp2c,fp3c,fp4c,fp5c,fp6c,fp7c,fp8c,fp9c,fp10c,fp11c,fp12c/*,fp13c,fp14c,fp15c,fp16c,fp17c,fp18c,fp19c,fp20c,fp21c,fp22c,fp23c,fp24c*/ = [ ~f1,~f2,~f3,~f4,~f5,~f6,~f7,~f8,~f9,~f10,~f11,~f12 ]; "s"++"\n"++[ ~f1,~f2,~f3,~f4,~f5,~f6,~f7,~f8,~f9,~f10,~f11,~f12 ].asString.postString; ~u1c=~f1;~u2c=~f2;~u3c=~f3;~u4c=~f4;~u5c=~f5;~u6c=~f6;~u7c=~f7;~u8c=~f8;~u9c=~f9;~u10c=~f10;~u11c=~f11;~u12c=~f12;}, {nil});});
			n4 = Button.new(w,Rect(Window.screenBounds.width-(Window.screenBounds.width/2)+(60*1),Window.screenBounds.height-88,60,60/1.61803398875)).states_([["s4",Color.white,Color.black],["4set",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button; if(button.value == 1, {~r1=fp1d;~r2=fp2d;~r3=fp3d;~r4d=fp4d;~r5d=fp5d;~r6d=fp6d;~r7d=fp7d;~r8d=fp8d;~r9d=fp9d;~r10d=fp10d;~r11d=fp11d;~r12d=fp12d; #fp1d,fp2d,fp3d,fp4d,fp5d,fp6d,fp7d,fp8d,fp9d,fp10d,fp11d,fp12d/*,fp13d,fp14d,fp15d,fp16d,fp17d,fp18d,fp19d,fp20d,fp21d,fp22d,fp23d,fp24d*/ = [ ~f1,~f2,~f3,~f4,~f5,~f6,~f7,~f8,~f9,~f10,~f11,~f12 ]; "s"++"\n"++[ ~f1,~f2,~f3,~f4,~f5,~f6,~f7,~f8,~f9,~f10,~f11,~f12 ].asString.postString; ~u1d=~f1;~u2d=~f2;~u3d=~f3;~u4d=~f4;~u5d=~f5;~u6d=~f6;~u7d=~f7;~u8d=~f8;~u9d=~f9;~u10d=~f10;~u11d=~f11;~u12d=~f12;}, {nil});});
			n5 = Button.new(w,Rect(Window.screenBounds.width-(Window.screenBounds.width/2)-(60*2),Window.screenBounds.height-52,60,60/1.61803398875)).states_([["s5",Color.white,Color.black],["5set",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button; if(button.value == 1, {~r1=fp1e;~r2=fp2e;~r3=fp3e;~r4e=fp4e;~r5e=fp5e;~r6e=fp6e;~r7e=fp7e;~r8e=fp8e;~r9e=fp9e;~r10e=fp10e;~r11e=fp11e;~r12e=fp12e; #fp1e,fp2e,fp3e,fp4e,fp5e,fp6e,fp7e,fp8e,fp9e,fp10e,fp11e,fp12e/*,fp13e,fp14e,fp15e,fp16e,fp17e,fp18e,fp19e,fp20e,fp21e,fp22e,fp23e,fp24e*/ = [ ~f1,~f2,~f3,~f4,~f5,~f6,~f7,~f8,~f9,~f10,~f11,~f12 ]; "s"++"\n"++[ ~f1,~f2,~f3,~f4,~f5,~f6,~f7,~f8,~f9,~f10,~f11,~f12 ].asString.postString; ~u1e=~f1;~u2e=~f2;~u3e=~f3;~u4e=~f4;~u5e=~f5;~u6e=~f6;~u7e=~f7;~u8e=~f8;~u9e=~f9;~u10e=~f10;~u11e=~f11;~u12e=~f12;}, {nil});});
			n6 = Button.new(w,Rect(Window.screenBounds.width-(Window.screenBounds.width/2)-(60*1),Window.screenBounds.height-52,60,60/1.61803398875)).states_([["s6",Color.white,Color.black],["6set",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button; if(button.value == 1, {~r1=fp1f;~r2=fp2f;~r3=fp3f;~r4f=fp4f;~r5f=fp5f;~r6f=fp6f;~r7f=fp7f;~r8f=fp8f;~r9f=fp9f;~r10f=fp10f;~r11f=fp11f;~r12f=fp12f; #fp1f,fp2f,fp3f,fp4f,fp5f,fp6f,fp7f,fp8f,fp9f,fp10f,fp11f,fp12f/*,fp13f,fp14f,fp15f,fp16f,fp17f,fp18f,fp19f,fp20f,fp21f,fp22f,fp23f,fp24f*/ = [ ~f1,~f2,~f3,~f4,~f5,~f6,~f7,~f8,~f9,~f10,~f11,~f12 ]; "s"++"\n"++[ ~f1,~f2,~f3,~f4,~f5,~f6,~f7,~f8,~f9,~f10,~f11,~f12 ].asString.postString; ~u1f=~f1;~u2f=~f2;~u3f=~f3;~u4f=~f4;~u5f=~f5;~u6f=~f6;~u7f=~f7;~u8f=~f8;~u9f=~f9;~u10f=~f10;~u11e=~f11;~u12f=~f12;}, {nil});});
			n7 = Button.new(w,Rect(Window.screenBounds.width-(Window.screenBounds.width/2)+(0),   Window.screenBounds.height-52,60,60/1.61803398875)).states_([["s7",Color.white,Color.black],["7set",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button; if(button.value == 1, {~r1=fp1g;~r2=fp2g;~r3=fp3g;~r4g=fp4g;~r5g=fp5g;~r6g=fp6g;~r7g=fp7g;~r8g=fp8g;~r9g=fp9g;~r10g=fp10g;~r11g=fp11g;~r12g=fp12g; #fp1g,fp2g,fp3g,fp4g,fp5g,fp6g,fp7g,fp8g,fp9g,fp10g,fp11g,fp12g/*,fp13g,fp14g,fp15g,fp16g,fp17g,fp18g,fp19g,fp20g,fp21g,fp22g,fp23g,fp24g*/ = [ ~f1,~f2,~f3,~f4,~f5,~f6,~f7,~f8,~f9,~f10,~f11,~f12 ]; "s"++"\n"++[ ~f1,~f2,~f3,~f4,~f5,~f6,~f7,~f8,~f9,~f10,~f11,~f12 ].asString.postString; ~u1g=~f1;~u2g=~f2;~u3g=~f3;~u4g=~f4;~u5g=~f5;~u6g=~f6;~u7g=~f7;~u8g=~f8;~u9g=~f9;~u10g=~f10;~u11f=~f11;~u12g=~f12;}, {nil});});
			n8 = Button.new(w,Rect(Window.screenBounds.width-(Window.screenBounds.width/2)+(60*1),Window.screenBounds.height-52,60,60/1.61803398875)).states_([["s8",Color.white,Color.black],["8set",Color.white,Color.black]]).action_({arg button; button.value.postln}).action_({arg button; if(button.value == 1, {~r1=fp1h;~r2=fp2h;~r3=fp3h;~r4h=fp4h;~r5h=fp5h;~r6h=fp6h;~r7h=fp7h;~r8h=fp8h;~r9h=fp9h;~r10h=fp10h;~r11h=fp11h;~r12h=fp12h; #fp1h,fp2h,fp3h,fp4h,fp5h,fp6h,fp7h,fp8h,fp9h,fp10h,fp11h,fp12h/*,fp13h,fp14h,fp15h,fp16h,fp17h,fp18h,fp19h,fp20h,fp21h,fp22h,fp23h,fp24h*/ = [ ~f1,~f2,~f3,~f4,~f5,~f6,~f7,~f8,~f9,~f10,~f11,~f12 ]; "s"++"\n"++[ ~f1,~f2,~f3,~f4,~f5,~f6,~f7,~f8,~f9,~f10,~f11,~f12 ].asString.postString; ~u1h=~f1;~u2h=~f2;~u3h=~f3;~u4h=~f4;~u5h=~f5;~u6h=~f6;~u7h=~f7;~u8h=~f8;~u9h=~f9;~u10h=~f10;~u11g=~f11;~u12h=~f12;}, {nil});});


			~undo = PopUpMenu(w, Rect(Window.screenBounds.width-(Window.screenBounds.width/3),Window.screenBounds.height-52+19.777087639995-34,40,40/1.61803398875)).items_(["u","u1","u2","u3","u4","u5","u6","u7","u8"]).background_(Color.black).stringColor_(Color.white).action_({arg button;});

			set2 = Button.new(w,Rect(Window.screenBounds.width-(Window.screenBounds.width/3)+40,Window.screenBounds.height-52+19.777087639995-34,40,40/1.61803398875)).states_([["set",Color.white,Color.black]]).action_({arg button;
				case
				{~undo.value == 1}{if(([fp1,fp2,fp3,fp4,fp5,fp6,fp7,fp8,fp9,fp10,fp11,fp12] == [~r1,~r2,~r3,~r4,~r5,~r6,~r7,~r8,~r9,~r10,~r11,~r12]).postln, {#fp1,fp2,fp3,fp4,fp5,fp6,fp7,fp8,fp9,fp10,fp11,fp12 = [~u1,~u2,~u3,~u4,~u5,~u6,~u7,~u8,~u9,~u10,~u11,~u12]},{#fp1,fp2,fp3,fp4,fp5,fp6,fp7,fp8,fp9,fp10,fp11,fp12 = [~r1,~r2,~r3,~r4,~r5,~r6,~r7,~r8,~r9,~r10,~r11,~r12]});~undo.value = 0;}
				{~undo.value == 2}{if([fp1b,fp2b,fp3b,fp4b,fp5b,fp6b,fp7b,fp8b,fp9b,fp10b,fp11b,fp12b] == [~r1b,~r2b,~r3b,~r4b,~r5b,~r6b,~r7b,~r8b,~r9b,~r10b,~r11b,~r12b], {#fp1b,fp2b,fp3b,fp4b,fp5b,fp6b,fp7b,fp8b,fp9b,fp10b,fp11b,fp12b = [~u1b,~u2b,~u3b,~u4b,~u5b,~u6b,~u7b,~u8b,~u9b,~u10b,~u11b,~u12b]},{#fp1b,fp2b,fp3b,fp4b,fp5b,fp6b,fp7b,fp8b,fp9b,fp10b,fp11b,fp12b = [~r1b,~r2b,~r3b,~r4b,~r5b,~r6b,~r7b,~r8b,~r9b,~r10b,~r11b,~r12b]});~undo.value = 0;}
				{~undo.value == 3}{if([fp1c,fp2c,fp3c,fp4c,fp5c,fp6c,fp7c,fp8c,fp9c,fp10c,fp11c,fp12c] == [~r1c,~r2c,~r3c,~r4c,~r5c,~r6c,~r7c,~r8c,~r9c,~r10c,~r11c,~r12c], {#fp1c,fp2c,fp3c,fp4c,fp5c,fp6c,fp7c,fp8c,fp9c,fp10c,fp11c,fp12c = [~u1c,~u2c,~u3c,~u4c,~u5c,~u6c,~u7c,~u8c,~u9c,~u10c,~u11c,~u12c]},{#fp1c,fp2c,fp3c,fp4c,fp5c,fp6c,fp7c,fp8c,fp9c,fp10c,fp11c,fp12c = [~r1c,~r2c,~r3c,~r4c,~r5c,~r6c,~r7c,~r8c,~r9c,~r10c,~r11c,~r12c]});~undo.value = 0;}
				{~undo.value == 4}{if([fp1d,fp2d,fp3d,fp4d,fp5d,fp6d,fp7d,fp8d,fp9d,fp10d,fp11d,fp12d] == [~r1d,~r2d,~r3d,~r4d,~r5d,~r6d,~r7d,~r8d,~r9d,~r10d,~r11d,~r12d], {#fp1d,fp2d,fp3d,fp4d,fp5d,fp6d,fp7d,fp8d,fp9d,fp10d,fp11d,fp12d = [~u1d,~u2d,~u3d,~u4d,~u5d,~u6d,~u7d,~u8d,~u9d,~u10d,~u11d,~u12d]},{#fp1d,fp2d,fp3d,fp4d,fp5d,fp6d,fp7d,fp8d,fp9d,fp10d,fp11d,fp12d = [~r1d,~r2d,~r3d,~r4d,~r5d,~r6d,~r7d,~r8d,~r9d,~r10d,~r11d,~r12d]});~undo.value = 0;}
				{~undo.value == 5}{if([fp1e,fp2e,fp3e,fp4e,fp5e,fp6e,fp7e,fp8e,fp9e,fp10e,fp11e,fp12e] == [~r1e,~r2e,~r3e,~r4e,~r5e,~r6e,~r7e,~r8e,~r9e,~r10e,~r11e,~r12e], {#fp1e,fp2e,fp3e,fp4e,fp5e,fp6e,fp7e,fp8e,fp9e,fp10e,fp11e,fp12e = [~u1e,~u2e,~u3e,~u4e,~u5e,~u6e,~u7e,~u8e,~u9e,~u10e,~u11e,~u12e]},{#fp1e,fp2e,fp3e,fp4e,fp5e,fp6e,fp7e,fp8e,fp9e,fp10e,fp11e,fp12e = [~r1e,~r2e,~r3e,~r4e,~r5e,~r6e,~r7e,~r8e,~r9e,~r10e,~r11e,~r12e]});~undo.value = 0;}
				{~undo.value == 6}{if([fp1f,fp2f,fp3f,fp4f,fp5f,fp6f,fp7f,fp8f,fp9f,fp10f,fp11f,fp12f] == [~r1f,~r2f,~r3f,~r4f,~r5f,~r6f,~r7f,~r8f,~r9f,~r10f,~r11f,~r12f], {#fp1f,fp2f,fp3f,fp4f,fp5f,fp6f,fp7f,fp8f,fp9f,fp10f,fp11f,fp12f = [~u1f,~u2f,~u3f,~u4f,~u5f,~u6f,~u7f,~u8f,~u9f,~u10f,~u11f,~u12f]},{#fp1f,fp2f,fp3f,fp4f,fp5f,fp6f,fp7f,fp8f,fp9f,fp10f,fp11f,fp12f = [~r1f,~r2f,~r3f,~r4f,~r5f,~r6f,~r7f,~r8f,~r9f,~r10f,~r11f,~r12f]});~undo.value = 0;}
				{~undo.value == 7}{if([fp1g,fp2g,fp3g,fp4g,fp5g,fp6g,fp7g,fp8g,fp9g,fp10g,fp11g,fp12g] == [~r1g,~r2g,~r3g,~r4g,~r5g,~r6g,~r7g,~r8g,~r9g,~r10g,~r11g,~r12g], {#fp1g,fp2g,fp3g,fp4g,fp5g,fp6g,fp7g,fp8g,fp9g,fp10g,fp11g,fp12g = [~u1g,~u2g,~u3g,~u4g,~u5g,~u6g,~u7g,~u8g,~u9g,~u10g,~u11g,~u12g]},{#fp1g,fp2g,fp3g,fp4g,fp5g,fp6g,fp7g,fp8g,fp9g,fp10g,fp11g,fp12g = [~r1g,~r2g,~r3g,~r4g,~r5g,~r6g,~r7g,~r8g,~r9g,~r10g,~r11g,~r12g]});~undo.value = 0;}
				{~undo.value == 8}{if([fp1h,fp2h,fp3h,fp4h,fp5h,fp6h,fp7h,fp8h,fp9h,fp10h,fp11h,fp12h] == [~r1h,~r2h,~r3h,~r4h,~r5h,~r6h,~r7h,~r8h,~r9h,~r10h,~r11h,~r12h], {#fp1h,fp2h,fp3h,fp4h,fp5h,fp6h,fp7h,fp8h,fp9h,fp10h,fp11h,fp12h = [~u1h,~u2h,~u3h,~u4h,~u5h,~u6h,~u7h,~u8h,~u9h,~u10h,~u11h,~u12h]},{#fp1h,fp2h,fp3h,fp4h,fp5h,fp6h,fp7h,fp8h,fp9h,fp10h,fp11h,fp12h = [~r1h,~r2h,~r3h,~r4h,~r5h,~r6h,~r7h,~r8h,~r9h,~r10h,~r11h,~r12h]});~undo.value = 0;};
			});

			/*{[~r1,~r2,~r3,~r4,~r5,~r6,~r7,~r9,~r10,~r11,~r12] = [fp1,fp2,fp3,fp4,fp5,fp6,fp7,fp8,fp9,fp10,fp11,fp12]}
			{[~r1b,~r2b,~r3b,~r4b,~r5b,~r6b,~r7b,~r9b,~r10b,~r11b,~r12b] = [fp1b,fp2b,fp3b,fp4b,fp5b,fp6b,fp7b,fp8b,fp9b,fp10b,fp11b,fp12b]}
			{[~r1c,~r2c,~r3c,~r4c,~r5c,~r6c,~r7c,~r9c,~r10c,~r11c,~r12c] = [fp1c,fp2c,fp3c,fp4c,fp5c,fp6c,fp7c,fp8c,fp9c,fp10c,fp11c,fp12c]}
			{[~r1d,~r2d,~r3d,~r4d,~r5d,~r6d,~r7d,~r9d,~r10d,~r11d,~r12d] = [fp1d,fp2d,fp3d,fp4d,fp5d,fp6d,fp7d,fp8d,fp9d,fp10d,fp11d,fp12d]}
			{[~r1e,~r2e,~r3e,~r4e,~r5e,~r6e,~r7e,~r9e,~r10e,~r11e,~r12e] = [fp1e,fp2e,fp3e,fp4e,fp5e,fp6e,fp7e,fp8e,fp9e,fp10e,fp11e,fp12e]}
			{[~r1f,~r2f,~r3f,~r4f,~r5f,~r6f,~r7f,~r9f,~r10f,~r11f,~r12f] = [fp1f,fp2f,fp3f,fp4f,fp5f,fp6f,fp7f,fp8f,fp9f,fp10f,fp11f,fp12f]}
			{[~r1g,~r2g,~r3g,~r4g,~r5g,~r6g,~r7g,~r9g,~r10g,~r11g,~r12g] = [fp1g,fp2g,fp3g,fp4g,fp5g,fp6g,fp7g,fp8g,fp9g,fp10g,fp11g,fp12g]}
			{[~r1h,~r2h,~r3h,~r4h,~r5h,~r6h,~r7h,~r9h,~r10h,~r11h,~r12h] = [fp1h,fp2h,fp3h,fp4h,fp5h,fp6h,fp7h,fp8h,fp9h,fp10h,fp11h,fp12h]}*/
			/*set = PopUpMenu(w, Rect(Window.screenBounds.width-20,~bpt+69-(20/1.61803398875),20,20/1.61803398875)).items_(["undo"]).background_(Color.black).stringColor_(Color.white).action({
					case
					{~r1,~r2,~r3,~r4,~r5,~r6,~r7,~r1,~r1,~r1,~r1,~r1,}{}
				});

			set2 = Button(w,Rect(20+60*2+16+140,Window.screenBounds.height-88+(16/1.61803398875*0),60,60/1.61803398875)).states_([["set",Color.white,Color.black]]).mouseDownAction_({
*/

			~bfreqstart = ~basefreq;
			~bfreq = PopUpMenu(w, Rect(20+60*2+16,Window.screenBounds.height-52+(16/1.61803398875*0),180,60/1.61803398875)).items_(~bfreqv = (-1); [~basefreq.asString++" hz"]++Array.fill(128, {~freqmap.at(~bfreqv=~bfreqv+1).asString++" hz"})).background_(Color.black).stringColor_(Color.white).action_({arg button;});

			~startrecord = Button.new(w,Rect(Window.screenBounds.width-(Window.screenBounds.width/3),Window.screenBounds.height-52+19.777087639995,28,28/1.61803398875)).states_([["rc",Color.white,Color.black],["rc",Color.black,Color.red]]).action_({arg button; Server.default.record; if(button.value == 0, {button.value = 1});});

			~pauserecord = Button.new(w,Rect(Window.screenBounds.width-(Window.screenBounds.width/3)+28,Window.screenBounds.height-52+19.777087639995,28,28/1.61803398875)).states_([["prc",Color.white,Color.black],["/prc",Color.black,Color.blue]]).action_({arg button; if(button == 1, {Server.default.pauseRecording;}, {Server.default.record});});

			~stoprecord = Button.new(w,Rect(Window.screenBounds.width-(Window.screenBounds.width/3)+28+28,Window.screenBounds.height-52+19.777087639995,28,28/1.61803398875)).states_([["/rc",Color.white,Color.black]]).action_({arg button; Server.default.stopRecording; ~startrecord.value = 0; ~pauserecord.value = 0;});

			/*~free = Button.new(w,Rect(Window.screenBounds.width-20-20-20,~bpt+69,20,20/1.61803398875)).states_([["fs",Color.white,Color.black]]).action_({arg button;
			~synthfree.value;
			});*/
			/*~freeserver = Button.new(w,Rect(Window.screenBounds.width-20-20-20,~bpt+75,20,20/1.61803398875)).states_([["fs",Color.white,Color.black]]).action_({arg button;
			~synthfree.value; Server.freeAll;
			});*/
				~min = Button.new(w,Rect(Window.screenBounds.width-20,~bpt+69-(20/1.61803398875),20,20/1.61803398875)).states_([["m",Color.white,Color.black]]).action_({arg button; w.minimize;});

				~close = Button.new(w,Rect(Window.screenBounds.width-20,~bpt+69,20,20/1.61803398875)).states_([["c",Color.white,Color.black]]).action_({arg button; w.close; ~numsynths.stop;});


				w.front; w.fullScreen;

		//Developed by Ken Brant

	}.value);
});
);

//Interpreted King Wen Sequence

/*

(#a,b,c,d,e,f = /*[ 128.43436842029,128.43436842029,128.43436842029,128.43436842029,128.43436842029,128.43436842029  ]*/
[ ~basefreq,~basefreq,~basefreq,~basefreq,~basefreq,~basefreq  ];
~a = a; ~b = b; ~c =c; ~d = d; ~e = e;~f=f;);

~fth = 1.4142135623729;

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
