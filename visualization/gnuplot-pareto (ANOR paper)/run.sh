#!/bin/bash

# entra na pasta com os fronts de pareto
rm -rf pdf/*;
cd exact;

# para cada front
for i in *.dat; do
  # copia eles para a pasta anterior
  cp $i ../exact.dat;
  cp ../npe/$i ../npe.dat;

  # imprime o nome do arquivo, para acompanhar o progresso
  echo $i;

  # roda o plot
  gnuplot ../pareto.plt;

  # move o PDF pra pasta correta
  mv pareto.pdf ../pdf/$i.pdf;
done

# apaga a extensão .dat
rename 's/.dat//g' ../pdf/*.pdf;
# apaga os arquivos que sobraram
rm -r pareto*
