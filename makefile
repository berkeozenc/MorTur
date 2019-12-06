comp: lexCompile IyorCompile dropNCompile dropLetterCompile penultCompile doubCompile changeRConsCompile changeACompile changeICompile changeCCompile changeDCompile changeKCompile phon1 phon2 phon3 phon4 phon5 phon6 phon7 phon8 phon9 phon10 combine inverse createAnalyzer

lexCompile: words.lexc morphotactics.lexc
	hfst-lexc words.lexc morphotactics.lexc -o morphotactics.hfst

IyorCompile: Iyor.twol
	hfst-twolc -R -i Iyor.twol -o Iyor.hfst

dropNCompile: dropN.twol
	hfst-twolc -R -i dropN.twol -o dropN.hfst

dropLetterCompile: dropLetter.twol
	hfst-twolc -R -i dropLetter.twol -o dropLetter.hfst

penultCompile: penult.twol
	hfst-twolc -R -i penult.twol -o penult.hfst

doubCompile: doub.twol
	hfst-twolc -R -i doub.twol -o doub.hfst

changeRConsCompile: changeRCons.twol
	hfst-twolc -R -i changeRCons.twol -o changeRCons.hfst

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

phon1: Iyor.hfst dropN.hfst
	hfst-compose-intersect -1 Iyor.hfst -2 dropN.hfst -o phon1.hfst

phon2: phon1.hfst dropLetter.hfst
	hfst-compose-intersect -1 phon1.hfst -2 dropLetter.hfst -o phon2.hfst

phon3: phon2.hfst penult.hfst
	hfst-compose-intersect -1 phon2.hfst -2 penult.hfst -o phon3.hfst

phon4: phon3.hfst doub.hfst
	hfst-compose-intersect -1 phon3.hfst -2 doub.hfst -o phon4.hfst

phon5: phon4.hfst changeRCons.hfst
	hfst-compose-intersect -1 phon4.hfst -2 changeRCons.hfst -o phon5.hfst

phon6: phon5.hfst changeA.hfst
	hfst-compose-intersect -1 phon5.hfst -2 changeA.hfst -o phon6.hfst

phon7: phon6.hfst changeI.hfst
	hfst-compose-intersect -1 phon6.hfst -2 changeI.hfst -o phon7.hfst

phon8: phon7.hfst changeC.hfst
	hfst-compose-intersect -1 phon7.hfst -2 changeC.hfst -o phon8.hfst

phon9: phon8.hfst changeD.hfst
	hfst-compose-intersect -1 phon8.hfst -2 changeD.hfst -o phon9.hfst

phon10: phon9.hfst changeK.hfst
	hfst-compose-intersect -1 phon9.hfst -2 changeK.hfst -o phon10.hfst

combine: morphotactics.hfst phon10.hfst
	hfst-compose-intersect -1 morphotactics.hfst -2 phon10.hfst -o combined.hfst

inverse: combined.hfst
	hfst-invert -i combined.hfst -o inverseCombined.hfst

createAnalyzer: inverseCombined.hfst
	hfst-fst2fst -O -i inverseCombined.hfst -o analyze.ol

