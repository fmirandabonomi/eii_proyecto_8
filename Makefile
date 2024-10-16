prefijo        ?= sim
dir_fuentes    ?= src
dir_resultados ?= resultados
dir_trabajo    ?= build

fuentes    := $(abspath $(dir_fuentes))
resultados := $(abspath $(dir_resultados))
trabajo    := $(abspath $(dir_trabajo))
arch_cf    := $(trabajo)/work-obj08.cf
sims 	   := $(basename $(notdir $(wildcard $(fuentes)/$(prefijo)_*.vhd)))
ops 	   := --std=08

blancos := $(patsubst $(prefijo)_%,%,$(sims))

arch_fuente = $(wildcard $(fuentes)/*.vhd)

arch_producidos = $(wildcard $(resultados)/*.*) $(wildcard $(trabajo)/*.*)

.PHONY: all clean $(blancos)

all : $(blancos)

ifeq ($(arch_producidos),)
clean :
else
clean :
	rm  $(arch_producidos)
endif

$(trabajo):
	mkdir $(trabajo)
$(resultados): | $(trabajo)
	mkdir $(resultados)
$(arch_cf): $(arch_fuente) | $(resultados)
	cd $(trabajo) && ghdl -i $(ops) $(arch_fuente)

define plantilla =
$(1): $(arch_cf)
	cd $(trabajo) && ghdl -m $(ops) $(2)
	cd $(trabajo) && ghdl -r $(ops) $(2) --wave=$(resultados)/$(1).ghw
	cd $(trabajo) && yosys -p "ghdl $(ops) $(1); prep -top $(1); write_json -compat-int $(1).json"
	cd $(trabajo) && netlistsvg.cmd $(1).json -o $(resultados)/$(1).svg
endef

$(foreach blanco,$(blancos),$(eval $(call plantilla,$(blanco),$(prefijo)_$(blanco))))
