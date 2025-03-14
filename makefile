# Author: Vivek Myers
# Date: 2024-08-28

LATEXMK = max_print_line=2000 latexmk -f -bibtex -pdf -outdir=build \
	-emulate-aux-dir -auxdir=build -use-make -shell-escape -file-line-error \
	-synctex=1 -interaction=nonstopmode

MAIN = sample1 sample2 sample3
OUT_sample1 = example_notes
OUT_sample2 = example_onecolumn
OUT_sample3 = example_twocolumn

slides = # add slide figure names here

define output
$(if $(OUT_$(1)),$(OUT_$(1)).pdf,$(1).pdf)
endef

all: $(foreach main,$(MAIN),$(call output,$(main)))

figures/%.pdf: build/%.pdf
	cp $< $@

define main_rule

build/$(1).pdf: $(1).tex | build
	$(LATEXMK) -recorder -deps-out=build/$(1).dep $(1).tex

$(call output,$(1)): build/$(1).pdf
	cp $$< $$@

endef

$(foreach main,$(MAIN),$(eval $(call main_rule,$(main))))

include $(wildcard build/*.dep)

build/%.bbl: build/%.aux
	bibtex $<

ifdef slides

$(foreach idx,$(shell seq 1 $(words $(slides))),\
	$(eval figures/$(word $(idx),$(slides)).pdf: build/slide$(idx).pdf))

$(foreach idx,$(shell seq 1 $(words $(slides))),build/slide$(idx).pdf) &: build/figures.key | figures
	bash scripts/keysplit.sh $< build

$(foreach fig,$(slides),figures/$(fig).pdf):
	pdfcrop $< $@

endif

figures/%-raster.pdf: figures/%.pdf
	sh scripts/raster.sh $< $@

equations = $(foreach eqn,$(wildcard equations/*.tex),$(notdir $(eqn:.tex=)))

comma = ,
build/%.pdf: equations/%.tex | equations
	mkdir -p build
	$(if $(shell grep documentclass $<),\
		$(LATEXMK) $<,\
		pdflatex -interaction=nonstopmode -output-directory=build -aux-directory=build -jobname=$* '\documentclass[tikz$(comma)border=1pt]{standalone}\
			\usepackage{palatino$(comma)amsfonts}\begin{document}\tikz\node[text height=1.5ex,text depth=0.3ex] {\input{$<}};\end{document}'\
	)

build/figures.key: resources/figures.key $(foreach eqn,$(equations),build/$(eqn).pdf)
	mkdir -p build
	cp $< build/tmp.key
	$(foreach eqn,$(equations),./scripts/keyparse replace --find "placeholder_$(eqn).pdf" --replace "build/$(eqn).pdf" build/tmp.key ;)
	cp build/tmp.key $@

build/%.pdf: figures/%.tex | figures build
	$(LATEXMK) -recorder -deps-out=build/$*.dep $<

build/figures/%.pdf: build/%.pdf | build/figures
	cp $< $@

build/%.tex: %.tex | build
	cp $< $@

build/%.sty: %.sty | build
	cp $< $@
		
build/%.cls: %.cls | build
	cp $< $@

build/%: resources/% | build
	cp $< $@

define minted_rule

build/./$(1).pytxmcr: build/$(1).pytxmcr 

build/$(1).pytxcode: $(1).tex | build
	$(LATEXMK) $(1)

build/$(1).pytxmcr: build/$(1).pytxcode | build
	pythontex $$< && $(LATEXMK) $(1) && pythontex $$<

endef

$(foreach main,$(MAIN),$(eval $(call minted_rule,$(main))))

$(patsubst %.tex,%.pdf,$(wildcard figures/*.tex)): figures/%.pdf: figures/%.tex

equations figures build resources build/figures:
	mkdir -p $@

clean:
	rm -rf build $(foreach main,$(MAIN),$(call output,$(main)))

