comp: lexCompile dropLetterCompile penultCompile doubCompile changeACompile changeICompile changeCCompile changeDCompile changeKCompile phon1 phon2 phon3 phon4 phon5 phon6 phon7 combineNnP inverse generation analyze

lexCompile: words.lexc ninfl.lexc vinfl.lexc deriv.lexc num.lexc npred.lexc
	hfst-lexc words.lexc ninfl.lexc vinfl.lexc deriv.lexc num.lexc npred.lexc -o lex.hfst

dropLetterCompile: dropLetter.twol
	hfst-twolc -R -i dropLetter.twol -o dropLetter.hfst
	
penultCompile: penult.twol
	hfst-twolc -R -i penult.twol -o penult.hfst
	
doubCompile: doub.twol
	hfst-twolc -R -i doub.twol -o doub.hfst

changeACompile: changeA.twol
	hfst-twolc -R -i changeA.twol -o changeA.hfst

changeICompile: changeI.twol
	hfst-twolc -R -i changeI.twol -o changeI.hfst
	
changeCCompile: changeC.twol
	hfst-twolc -R -i changeC.twol -o changeC.hfst
	
changeDCompile: changeD.twol
	hfst-twolc -R -i changeD.twol -o changeD.hfst
	
changeKCompile: changeK.twol
	hfst-twolc -R -i changeK.twol -o changeK.hfst

phon1: dropLetter.hfst penult.hfst
	hfst-compose-intersect -1 dropLetter.hfst -2 penult.hfst -o phon1.hfst
	
phon2: phon1.hfst doub.hfst
	hfst-compose-intersect -1 phon1.hfst -2 doub.hfst -o phon2.hfst

phon3: phon2.hfst changeA.hfst
	hfst-compose-intersect -1 phon2.hfst -2 changeA.hfst -o phon3.hfst

phon4: phon3.hfst changeI.hfst
	hfst-compose-intersect -1 phon3.hfst -2 changeI.hfst -o phon4.hfst

phon5: phon4.hfst changeC.hfst
	hfst-compose-intersect -1 phon4.hfst -2 changeC.hfst -o phon5.hfst
	
phon6: phon5.hfst changeD.hfst
	hfst-compose-intersect -1 phon5.hfst -2 changeD.hfst -o phon6.hfst
	
phon7: phon6.hfst changeK.hfst
	hfst-compose-intersect -1 phon6.hfst -2 changeK.hfst -o phon7.hfst

combineNnP: lex.hfst phon7.hfst
	hfst-compose-intersect -1 lex.hfst -2 phon7.hfst -o tr.hfst

inverse: tr.hfst
	hfst-invert -i tr.hfst -o tr.inv.hfst

generation: tr.hfst
	hfst-fst2fst -O -i tr.hfst -o generate.ol

analyze: tr.inv.hfst
	hfst-fst2fst -O -i tr.inv.hfst -o analyze.ol