all : a4_1.png a4_2.png a4_3.png a4_4.png a4_5.png a4_6.png a4_calc.png sqrt2.png sqrt2gt1.png sqrt2minus1.png sqrt2lt1pt5.png bounds.png bounds2.png 1_by_sqrt2minus1.png sm_tri_formula.png

clean :
	rm *.pdf *.aux *.log

sqrt2.png :
	wget 'http://latex.codecogs.com/png.latex?\sqrt{2}' -O $@

sqrt2minus1.png :
	wget 'http://latex.codecogs.com/png.latex?\sqrt{2}%20-%201' -O $@

1_by_sqrt2minus1.png :
	wget 'http://latex.codecogs.com/png.latex?1:\sqrt{2}%20-%201' -O $@

sm_tri_formula.png :
	wget 'http://latex.codecogs.com/png.latex?1-2(\sqrt{2}-1)=3-2\sqrt{2}' -O $@

a4_1.png : a4_1.tex
	pdflatex $(<:.tex=)
	pdflatex $(<:.tex=)
	pdftocairo -png -singlefile -scale-to 2400 $(<:.tex=.pdf)
	convert $(<:.tex=.png) -trim -resize 700x250 $(<:.tex=.png)
	rm $(<:.tex=.pdf)

a4_%.png : a4_%.tex
	pdflatex $(<:.tex=)
	pdflatex $(<:.tex=)
	pdftocairo -png -singlefile -scale-to 2400 $(<:.tex=.pdf)
	convert $(<:.tex=.png) -trim -resize 700x200 $(<:.tex=.png)
	rm $(<:.tex=.pdf)

a4_6.png : a4_6.tex
	pdflatex $(<:.tex=)
	pdflatex $(<:.tex=)
	pdftocairo -png -singlefile -scale-to 2400 $(<:.tex=.pdf)
	convert $(<:.tex=.png) -trim -resize 700x150 $(<:.tex=.png)
	rm $(<:.tex=.pdf)

a4_calc.png : a4_calc.tex
	pdflatex $(<:.tex=)
	pdflatex $(<:.tex=)
	pdftocairo -png -singlefile $(<:.tex=.pdf)
	convert $(<:.tex=.png) -trim $(<:.tex=.png)
	rm $(<:.tex=.pdf)

sqrt2gt1.png : sqrt2gt1.tex
	pdflatex $(<:.tex=)
	pdflatex $(<:.tex=)
	pdftocairo -png -singlefile $(<:.tex=.pdf)
	convert $(<:.tex=.png) -trim $(<:.tex=.png)
	rm $(<:.tex=.pdf)


sqrt2lt1pt5.png : sqrt2lt1pt5.tex
	pdflatex $(<:.tex=)
	pdflatex $(<:.tex=)
	pdftocairo -png -singlefile $(<:.tex=.pdf)
	convert $(<:.tex=.png) -trim $(<:.tex=.png)
	rm $(<:.tex=.pdf)


bounds%.png : bounds%.tex
	pdflatex $(<:.tex=)
	pdflatex $(<:.tex=)
	pdftocairo -png -singlefile $(<:.tex=.pdf)
	convert $(<:.tex=.png) -trim $(<:.tex=.png)
	rm $(<:.tex=.pdf)